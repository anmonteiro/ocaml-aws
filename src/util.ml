(*----------------------------------------------------------------------------
    Copyright (c) 2016 Inhabited Type LLC.

    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    3. Neither the name of the author nor the names of his contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE CONTRIBUTORS ``AS IS'' AND ANY EXPRESS
    OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR
    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
    STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
  ----------------------------------------------------------------------------*)

open Structures

module Printing = struct
  let with_output file f =
    let out = open_out file in
    try f out; flush out; close_out out with _ -> close_out out

  let write_all ~filename ?doc contents =
    with_output filename (fun out ->
      begin match doc with
      | Some doc ->
        (* Small hack to write a documentation comment at the top of the file.
         * Needs to be in quotes (%S) otherwise OCaml thinks there are
         * unterminated string literals in some cases. *)
        output_string out (Format.asprintf "(** %S *)@\n" doc)
      | None -> () end;
      output_string out contents)

  module Migration = Ppxlib.Selected_ast.To_ocaml

  let write_structure filename es =
    write_all ~filename (Pprintast.string_of_structure (Migration.copy_structure es))

  let string_of_signature x =
    ignore (Format.flush_str_formatter ());
    let f = Format.str_formatter in
    Pprintast.signature f (Migration.copy_signature x);
    Format.flush_str_formatter ()

  let write_signature ?doc filename es =
    write_all ?doc ~filename (string_of_signature es)
end

module StringTable = Map.Make(String)

module Char = struct
  include Char

  let _is_uppercase i =
    (i >= 65 && i <= 90)

  let _is_alpha i =
    _is_uppercase i || (i >= 97 && i <= 122)

  let is_uppercase c =
    _is_uppercase (code c)

  let is_alpha c =
    _is_alpha (code c)

  let is_alphanum c =
    let i = code c in
    _is_alpha i || (i >= 48 && i <= 57)
end

let to_lib_name s =
  String.map (fun c -> if Char.is_alphanum c then (Char.lowercase_ascii c) else '-') s

let to_variant_name s =
  String.map (fun c -> if Char.is_alphanum c then c else '_')
    (if Char.is_alpha (String.get s 0)
     then String.capitalize_ascii s
     else "N" ^ s)

let to_field_name s =
  let add_underscore = ref false in
  let acc = ref [] in
  String.iter (fun c ->
    let c' = Printf.sprintf "%c" Char.(lowercase_ascii c) in
    let s  = if Char.is_uppercase c && !add_underscore
      then "_" ^ c'
      else begin add_underscore := true; c' end
    in
    acc := s :: !acc)
  s;
  (String.concat "" (List.rev !acc))

let prim_type_map =
  (* NOTE(dbp 2015-01-26): Not all of these have been seen in the
     wild (ex: double, float, datetime) *)
  [("boolean", "Boolean")
  ;("string","String")
  ;("integer","Integer")
  ;("long","Long")
  ;("double","Double")
  ;("float","Float")
  ;("datetime","DateTime")
  (* NOTE(dbp 2015-01-26): timestamp is a type used in the
     CreatedTime shape for elasticloadbalancing, and as far as I can
     tell from the examples, it is the same as DateTime. *)
  ;("timestamp","DateTime")
  ;("blob","Blob")]

 let is_prim shp =
  List.mem_assoc (String.lowercase_ascii shp) prim_type_map

(* NOTE(dbp 2015-01-26): Shapes that just have primitive types
   (boolean, integer, etc) types aren't actually useful (they
   communicate no information, since all of the typing is
   structural). Some string types are `enums`, which we support by translating
   them into actual types, but non-enum string shapes are similarly not
   useful. So, we will both remove references to them in fields (by
   just replacing them with Integer, Boolean, etc), and removing the
   shapes themselves.

   NOTE(dbp 2015-02-04): Another optimization: get rid of structs with no fields.
   Many of these are actually error descriptions, but once we support those, they
   would get parsed before this pass (similarly to how enums don't get inlined
   away as strings).
*)
let inline_shapes (ops : Operation.t list) (shapes : Shape.parsed StringTable.t) =
  let shape_type name =
   if List.exists (fun { Operation.input_shape; _ } ->
    Option.is_some input_shape && Option.get input_shape = name) ops
   then Input
   else if List.exists (fun { Operation.output_shape; _ } ->
    Option.is_some output_shape && Option.get output_shape = name) ops
   then Output
   else Type
  in
  let replace_shape default =
    try
      let _, shptyp, _, _ = StringTable.find default shapes in
      List.assoc shptyp prim_type_map
    with Not_found -> default
  in
  let new_shapes =
    StringTable.fold (fun key (nm, ty, contents, doc) acc ->
      if is_prim ty then
        acc
      else
        let content =
          match contents with
          | None -> assert false
          | Some (Shape.Structure ms) ->
            Shape.Structure (List.map (fun member ->
              { member with Structure.shape = replace_shape member.Structure.shape })
            ms)
          | Some (Shape.List (shp, ln, flatten)) ->
            Shape.List (replace_shape shp, ln, flatten)
          | Some (Shape.Map ((kshp, kln), (vshp, vln))) ->
            Shape.Map ((replace_shape kshp, kln), (replace_shape vshp, vln))
          | Some (Shape.Enum opts) -> Shape.Enum opts
        in
        StringTable.add
         key
         { Shape.name = nm
         ; content
         ; depends_on = None, false
         ; doc
         ; type_ = shape_type nm
         }
         acc)
    shapes StringTable.empty
  in
  let is_empty_struct shp =
    try
      match StringTable.find shp shapes with
      | (_, _, Some (Shape.Structure []), _) -> true
      | _                                 -> false
    with Not_found -> false
  in
  let new_ops =
    List.map (fun op ->
        let input_shape =
          match op.Operation.input_shape with
          | Some shp when is_empty_struct shp -> None
          | shp -> shp
        and output_shape =
          match op.Operation.output_shape with
          | Some shp when is_empty_struct shp -> None
          | shp -> shp
        in
        { op with Operation.input_shape ; output_shape }
      )
      ops
  in
  new_shapes, new_ops

let rec filter_map l ~f =
  match l with
  | []    -> []
  | x::xs ->
    begin match f x with
    | Some x' -> x' :: filter_map xs ~f
    | None    -> filter_map xs ~f
    end

let option_map l ~f =
  match l with
  | None -> None
  | Some x -> Some (f ^ x)

let rec split_with f xs =
  match xs with
  | [] ->
    [], []
  | y :: ys ->
    if f y then
      let zs, ts = split_with f ys in
      y :: zs, ts
    else
      [], xs

let split_with_i f xs =
  let rec inner i f xs =
    match xs with
    | [] ->
      [], []
    | y :: ys ->
      if f i y then
        let zs, ts = inner (i + 1) f ys in
        y :: zs, ts
      else
        [], xs
  in
  inner 0 f xs
