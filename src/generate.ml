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
open Util
open Ppxlib

let loc = !Ast_helper.default_loc

let is_list ~shapes ~shp =
  try
    match (StringTable.find shp shapes).Shape.content with
    | Shape.List _ -> true
    | _            -> false
  with Not_found -> false

let is_flat_list ~shapes ~shp =
  try
    match (StringTable.find shp shapes).Shape.content with
    | Shape.List (_,_,true) -> true
    | _ -> false
  with Not_found -> false

let is_map ~shapes ~shp =
  try
    match (StringTable.find shp shapes).Shape.content with
    | Shape.Map _ -> true
    | _            -> false
  with Not_found -> false

let has_required_fields ~shapes shape =
  match (StringTable.find shape shapes).Shape.content with
  | Shape.Structure members ->
    List.exists (fun { Structure.payload; required; _ } ->
      not payload && required) members
  | _            -> false

let has_payload ~shapes shape =
  try
    match (StringTable.find shape shapes).Shape.content with
    | Shape.Structure members ->
      List.exists (fun { Structure.payload; shape; _ } -> payload && Util.is_prim shape) members &&
      List.for_all (function
        | {Structure.location = Some
            ( "headers"
            | "header"
            | "uri"
            | "querystring") ; _} -> true
        | _ -> false)
      (List.filter (fun { Structure.payload; _ } -> not payload) members)
    | _            -> false
  with Not_found -> false

let is_prim_payload m =
  m.Structure.payload && Util.is_prim m.shape

let get_payload_shape ~shapes shape =
  match (StringTable.find shape shapes).Shape.content with
  | Shape.Structure members ->
    let member =
      List.hd (List.filter (fun { Structure.payload; _ } -> payload) members)
    in
    member.shape
  | _            -> raise Not_found

let toposort (shapes : Shape.t StringTable.t) =
  let open Graph in
  let module G = Imperative.Digraph.ConcreteBidirectional(struct
      type t = Shape.t
      let compare a b = compare a.Shape.name b.Shape.name
      let hash a = Hashtbl.hash a.Shape.name
      let equal a b = a.Shape.name = b.Shape.name
    end) in
  let graph = G.create () in
  let add_edge from to_ =
    try
      G.add_edge graph from (StringTable.find to_ shapes)
    with Not_found -> ()
  in
  StringTable.iter (fun _key data ->
    G.add_vertex graph data;
    match data.Shape.content with
    | Shape.Structure members ->
      List.iter (fun mem -> add_edge data mem.Structure.shape) members
    | Shape.List (s,_,_) ->
      add_edge data s;
      (try
        let shp = StringTable.find s shapes in
        (* Only handle mutual recursion for now *)
        if G.mem_edge graph shp data then begin
          data.depends_on <- Some shp, false;
          shp.depends_on <- Some data, false;
        end
      with _ -> ())
    | Shape.Map ((ks,_), (vs,_)) -> add_edge data ks; add_edge data vs
    | Shape.Enum _ -> ())
  shapes;
  let module T = Topological.Make(G) in
  let out = ref [] in
  T.iter (fun shape -> out := shape :: !out) graph;
  !out

let build_module_signature protocol ~shapes v =
  let open Syntax in
  let mkrecsty fs =
    styreclet "t" (List.map (fun (nm,shp,req) ->
        (nm, option_type shp req)) fs)
  in
  let ty_with_doc x =
   match x.psig_desc with
   | Psig_type (r, [ decl ]) ->
     { x with
       psig_desc = Psig_type (r, [ { decl with ptype_attributes = Syntax.doc_attrs v.Shape.doc } ])
     }
   | _ -> x
  in
  let ty =
   ty_with_doc @@
    match v.content with
    | Shape.Structure [ ] ->
      (* Hack for a unit type since empty records aren't yet valid *)
      [%sigi: type t = unit]
    | Shape.Structure members ->
      let members = List.filter_map (fun m ->
       if is_prim_payload m then begin
        None
       end else
        Some
         ( m.Structure.field_name
         , (String.capitalize_ascii m.Structure.shape) ^ ".t"
         , m.Structure.required || is_list ~shapes ~shp:m.Structure.shape))
       members
      in
      if members == [] then
       mkrecsty members
      else
       mkrecsty members
    | Shape.List (shp, _, _flatten) ->
      [%sigi: type t = [%t (Syntax.ty1 "list" (shp ^ ".t"))]]
    | Shape.Map ((kshp, _loc), (vshp, _)) ->
      [%sigi: type t = [%t (Syntax.ty2 "Hashtbl.t" (kshp ^ ".t") (vshp ^ ".t"))]]
    | Shape.Enum opts ->
      Syntax.styvariantlet "t" (List.map (fun t -> (Util.to_variant_name t, [])) opts)
  in
  let make = match v.Shape.content with
    | Shape.Structure [ ] -> [%sigi: val make: unit -> t]
    | Shape.Structure members ->
      let members = List.filter (fun m -> not (is_prim_payload m)) members
      in
      let rec mkarrow (args : Structure.member list) ret = match args with
        | [ ] -> ret
        | (x::xs) ->
          let fn = if x.Structure.required
            then Syntax.arrowlab
            else Syntax.arrowopt
           in
           fn x.Structure.field_name (Syntax.tname ((String.capitalize_ascii x.Structure.shape) ^ ".t")) (mkarrow xs ret) in
      if members == [] then
       [%sigi: val make: unit -> t]
      else
       [%sigi: val make: [%t (mkarrow members (Syntax.sfununit "t"))]]
    | Shape.List _
    | Shape.Enum _
    | Shape.Map _ -> [%sigi: val make: t -> unit -> t]
  in
  let extra = match v.Shape.content with
    | Shape.Enum _ ->
      [[%sigi: val str_to_t: (string * t) list];
       [%sigi: val t_to_str: (t * string) list];
       [%sigi: val to_string: t -> string];
       [%sigi: val of_string: string -> t]]
    | _ -> []
  in
  let parse = [%sigi: val parse: Ezxmlm.nodes -> t option] in
  let to_query = [%sigi: val to_query: t -> Aws.Query.t] in
  let to_json = [%sigi: val to_json: t -> Aws.Json.t] in
  let of_json = [%sigi: val of_json: Aws.Json.t -> t] in
  let to_headers = [%sigi: val to_headers: t -> Aws.Headers.t] in
  let to_xml = [%sigi: val to_xml: t -> Ezxmlm.nodes] in
  let parse_payload =
    if has_payload ~shapes v.name then
      [ [%sigi: val of_headers :  Aws.Headers.Assoc.t -> t]]
    else
      [ ]
  in
  let base = [ty] @ extra @ [ make; to_query; to_headers; to_json ] in
  let protocol_specific = match protocol with
    | "json" | "rest-json" -> [ of_json ]
    | "ec2" | "query" | "rest-xml" -> [ parse; to_xml ]
    | _ -> raise Not_found
  in
  base @ protocol_specific @ parse_payload

let build_module_structure protocol ~shapes v =
  let is_ec2 = protocol = "ec2" in
  let open Syntax in
  let mkrecty fs =
    tyreclet "t" (List.map (fun (nm,shp,req, doc) ->
        (nm, option_type shp req, doc)) fs)
  in
  let ty_with_doc x =
   match x.pstr_desc with
   | Pstr_type (r, [ decl ]) ->
     { x with
       pstr_desc = Pstr_type (r, [ { decl with ptype_attributes = Syntax.doc_attrs v.Shape.doc } ])
     }
   | _ -> x
  in
  let ty =
    ty_with_doc @@
    match v.Shape.content with
    | Shape.Structure [ ] ->
      (* Hack for a unit type since empty records aren't yet valid *)
      [%stri type t = unit]
    | Shape.Structure members ->
      let members = List.filter_map (fun m ->
       if is_prim_payload m then
        None
       else
         Some
          (m.Structure.field_name
          , (String.capitalize_ascii m.Structure.shape) ^ ".t"
          , m.Structure.required || is_list ~shapes ~shp:m.Structure.shape, m.doc))
        members
      in
      if members == [] then
       [%stri type t = unit]
      else
        mkrecty members
    | Shape.List (shp, _, _flatten) ->
      [%stri type t = [%t tname (shp ^ ".t") ] list]
    | Shape.Map ((kshp, _loc), (vshp, _)) ->
      [%stri type t = [%t ty2 "Hashtbl.t" (kshp ^ ".t") (vshp ^ ".t")]]
    | Shape.Enum opts ->
      tyvariantlet "t" (List.map (fun t -> (Util.to_variant_name t, [], None)) opts)
  in
  let make = match v.Shape.content with
    | Shape.Structure [ ] ->
      [%stri let make () = ()]
    | Shape.Structure members ->
      let members = List.filter (fun m -> not (is_prim_payload m)) members in
      let rec mkfun (args : Structure.member list) body = match args with
        | [ ] -> body
        | (x::xs) ->
          let fn = if x.Structure.required then funlab else if is_list ~shapes ~shp:x.Structure.shape then funopt_def (list []) else funopt in
          fn x.Structure.field_name (mkfun xs body) in
      let body =
        fununit
          (record
             (List.map (fun a -> (a.Structure.field_name, ident a.Structure.field_name)) members))
      in
      if members == [] then
       [%stri let make () = ()]
      else
       [%stri let make = [%e (mkfun members body)]]
    | Shape.List _ -> [%stri let make elems () = elems]
    | Shape.Enum _ -> [%stri let make v () = v]
    | Shape.Map _ ->
      (* TODO: maybe accept a list of tuples and create a Hashtbl *)
      [%stri let make elems () = elems]
  in
  let extra = match v.Shape.content with
    | Shape.Enum opts ->
      [[%stri let str_to_t = [%e list (List.map (fun o -> pair (str o) (ident (Util.to_variant_name o))) opts)]];
       [%stri let t_to_str = [%e list (List.map (fun o -> pair (ident (Util.to_variant_name o)) (str o)) opts)]];
       [%stri let to_string e = Util.of_option_exn (Util.list_find t_to_str e)];
       [%stri let of_string s = Util.of_option_exn (Util.list_find str_to_t s)]]
    | _ -> []
  in
  let parse = match v.Shape.content with
    | Shape.Structure [ ] ->
      [%stri let parse xml = Some ()]
    | Shape.Structure s ->
      let s = List.filter (fun m -> not (is_prim_payload m)) s in
      if s == [] then
        [%stri let parse xml = Some ()]
      else
       let fields = List.map (fun (mem : Structure.member) ->
           let loc_name =
             match mem.Structure.loc_name with
             | Some name -> name
             | None      -> mem.Structure.name
           in
           let b = if is_flat_list ~shapes ~shp:mem.Structure.shape then
             [%expr [%e ident (mem.Structure.shape ^ ".parse")] xml]
           else
             [%expr Util.option_bind (Xml.member [%e str loc_name] xml) [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".parse")]]
           in
           let op =
             if mem.Structure.required then
               [%expr Xml.required [%e str loc_name] [%e b]]
             else if is_list ~shapes ~shp:mem.Structure.shape then
               [%expr Util.of_option [] [%e b]]
             else
               b
           in
           (mem.Structure.field_name, op))
           s
       in
       [%stri let parse xml = Some [%e record fields]]
    | Shape.Map ((_shp, _loc_name), _) ->
      [%stri let parse xml = None]
    | Shape.List (shp, loc_name, flattened) ->
      let item_name = match loc_name with
        | None -> "member"
        | Some nm -> nm
      in
      let arg = if flattened
        then [%expr [ xml ]]
        else [%expr Xml.members [%e str item_name] xml]
      in
      [%stri let parse xml = Util.option_all (List.map [%e ident (shp ^ ".parse")] [%e arg]) ]
    | Shape.Enum _opts ->
      [%stri let parse xml = Util.option_bind (String.parse xml) (fun s -> Util.list_find str_to_t s)]
  in
  let to_query =
    let exp = match v.Shape.content with
      | Shape.Structure s ->
        let queryparams = if is_ec2
          (* EC2 API is only query params  *)
          then s
          else List.filter (fun x ->
            match x.Structure.location with
            | None -> false
            | Some l -> l = "querystring") s
        in
        let lst =
          list (List.map (fun mem ->
            let location =
              match mem.Structure.loc_name with
              | Some name -> name
              | None      ->
                mem.Structure.name ^
                if not is_ec2 && is_list ~shapes ~shp:mem.Structure.shape
                then ".member" else ""
            in
            let location =
              if is_ec2 then String.capitalize_ascii location else location
            in
            let q arg =
              [%expr Query.Pair
                ( [%e (str location) ]
                , [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".to_query")] [%e arg ])]
            in
            (if mem.Structure.required || is_list ~shapes ~shp:mem.Structure.shape
            then [%expr Some [%e (q (ident ("v." ^ mem.Structure.field_name)))]]
             else
               [%expr Util.option_map
                 [%e (ident ("v." ^ mem.Structure.field_name))]
                 (fun f -> [%e (q (ident "f"))])]))
            queryparams)
        in
        [%expr Query.List (Util.list_filter_opt [%e lst])]
      | Shape.List (shp,_,_flatten) ->
        [%expr Query.to_query_list [%e ident (shp ^ ".to_query")] v]
      | Shape.Map ((key_shp,_),(val_shp,_)) ->
        [%expr Query.to_query_hashtbl [%e ident (key_shp ^ ".to_string")] [%e ident (val_shp ^ ".to_query")] v]
      | Shape.Enum _ ->
        [%expr Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))]
    in
    [%stri let to_query v = [%e exp]]
  in
  let to_json =
    let exp = match v.Shape.content with
      | Shape.Structure s ->
        let s = List.filter (fun m -> not (is_prim_payload m)) s in
        let lst = list
          (List.map (fun mem ->
            (* TODO: confirm this *)
            let _location =
              match mem.Structure.loc_name with
              | Some name -> name
              | None      ->
                mem.Structure.name ^
                if not is_ec2 && is_list ~shapes ~shp:mem.Structure.shape
                then ".member" else ""
            in
            let q arg =
              [%expr
                ([%e (str mem.Structure.field_name)]
                ,[%e [%expr [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".to_json")] [%e arg]]])]
            in
            if mem.Structure.required || is_list ~shapes ~shp:mem.Structure.shape
            then [%expr Some [%e q (ident ("v." ^ mem.Structure.field_name))]]
            else [%expr Util.option_map [%e ident ("v." ^ mem.Structure.field_name)] (fun f -> [%e q (ident "f")])])
            s)
        in
        [%expr `Assoc (Util.list_filter_opt [%e lst])]
      | Shape.List (shp,_,_flatten) ->
        [%expr `List (List.map [%e ident (shp ^ ".to_json")] v)]
      | Shape.Map ((key_shp,_),(val_shp,_)) ->
        [%expr
          `Assoc (Hashtbl.fold (fun k v acc ->
                   [%e (pair (app1 (key_shp ^ ".to_string") (ident "k")) (app1 (val_shp ^ ".to_json") (ident "v")))] :: acc)
                 v [])]
      | Shape.Enum _ ->
        [%expr String.to_json (Util.of_option_exn (Util.list_find t_to_str v))]
    in
    [%stri let to_json v = [%e exp]]
  in
  let of_json =
    let exp = match v.Shape.content with
      | Shape.Structure [ ] ->
          (* Hack for a unit type since empty records aren't yet valid *)
        [%expr ()]
      | Shape.Structure s ->
        record (List.map (fun mem ->
          let f = if mem.Structure.required || is_list ~shapes ~shp:mem.Structure.shape
            then fun v ->
              [%expr [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".of_json")] (Util.of_option_exn [%e v ])]
            else fun v ->
              [%expr Util.option_map [%e v] [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".of_json")]]
          in
          (mem.Structure.field_name, f [%expr Json.lookup j [%e (str mem.field_name)]]))
        s)
      | Shape.List (shp,_,_flatten) ->
        [%expr Json.to_list [%e ident (shp ^ ".of_json")] j]
      | Shape.Map ((key_shp,_),(val_shp,_)) ->
        [%expr Json.to_hashtbl [%e (ident (key_shp ^ ".of_string"))] [%e (ident (val_shp ^ ".of_json"))] j]
      | Shape.Enum _ ->
        [%expr Util.of_option_exn (Util.list_find str_to_t (String.of_json j))]
    in
    [%stri let of_json j = [%e exp]]
  in
  let to_headers =
    let exp = match v.Shape.content with
      | Shape.Structure s ->
        let headers_ms = List.filter
          (fun x -> match x.Structure.location with
             | None -> false
             | Some l -> l = "header" || l = "headers") s
        in
        let lst = list (List.map (fun mem ->
          let location =
            match mem.Structure.loc_name with
                   | Some name -> name
                   | None -> raise Not_found
          in
          let h arg =
            [%expr Headers.Pair ([%e (str location)], [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".to_headers")] [%e arg])]
          in
          if mem.Structure.required || is_list ~shapes ~shp:mem.Structure.shape then
            [%expr Some [%e h (ident ("v." ^ mem.Structure.field_name))]]
          else
            [%expr Util.option_map [%e (ident ("v." ^ mem.Structure.field_name))] (fun f -> [%e (h (ident "f")) ])])
          headers_ms) in
        [%expr Headers.List (Util.list_filter_opt [%e lst ])]
      | Shape.List (shp,_,_) ->
        [%expr Headers.to_headers_list [%e ident (shp ^ ".to_headers")] v]
      | Shape.Map ((shp,_),_) ->
        [%expr Headers.to_headers_hashtbl [%e ident (shp ^ ".to_headers")] v]
      | Shape.Enum _opts ->
        [%expr Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))]
    in
    [%stri let to_headers v = [%e exp]]
  in
  let to_xml =
    let exp = match v.Shape.content with
      | Shape.Structure s ->
        let s = List.filter (fun m -> not (is_prim_payload m)) s in
        let arg = List.fold_left (fun acc mem ->
          let location = match mem.Structure.loc_name with
            | Some name -> name
            | None -> mem.Structure.name
            in
            let xml arg =
              [%expr Ezxmlm.make_tag
                [%e (str location)]
                ( []
                , [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ ".to_xml")] [%e arg]
                )]
            in
            let exp = if is_list ~shapes ~shp:mem.Structure.shape then
              [%expr List.map (fun x ->
                Some [%e xml (list [(ident "x")])])
                [%e ident ("v." ^ mem.Structure.field_name)]]
            else if mem.Structure.required then
              [%expr [(Some [%e xml (ident ("v." ^ mem.Structure.field_name))])]]
            else
              [%expr [Util.option_map [%e ident ("v." ^ mem.Structure.field_name)] (fun f -> [%e (xml (ident "f"))])]]
            in
            [%expr [%e acc ] @ [%e exp]]) (list []) s
        in
        [%expr Util.list_filter_opt [%e arg]]
       | Shape.List (shp,_,flattened) ->
         if flattened then
           [%expr List.concat (List.map [%e ident (shp ^ ".to_xml")] v)]
         else
           [%expr List.map (fun x ->
             Ezxmlm.make_tag "member" ([], [%e ident (shp ^ ".to_xml")] x)) v]
       | Shape.Map ((_shp,_),_) -> [%expr []]
       | Shape.Enum _opts ->
         [%expr String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))]
      in
    [%stri let to_xml v = [%e exp]]
  in
  let of_headers () =
    let exp = match v.Shape.content with
      | Shape.Structure [ ] ->
        [%expr ()]
      | Shape.Structure s ->
        let fields = List.filter_map (fun (mem : Structure.member) ->
          if is_prim_payload mem then
           None
          else match mem.location with
          | Some ("header" | "headers" | "uri" | "querystring") ->
            let loc_name =
              match mem.Structure.loc_name with
              | Some name -> name
              | None      -> mem.Structure.name
            in
            let of_string_fn = match mem.Structure.shape with
             | "DateTime" ->
               (* If we're reading from HTTP headers, the date string is
                * specified in the RFC7231§7.1.1.1 format. *)
               ".of_http_string"
             | _ -> ".of_string"
            in
            let b =
              [%expr Util.option_map
                (Headers.Assoc.find [%e (str loc_name)] headers)
                [%e ident ((String.capitalize_ascii mem.Structure.shape) ^ of_string_fn)]]
            in
            let op =
              if mem.Structure.required then
                [%expr Util.of_option_exn [%e b]]
              else if is_list ~shapes ~shp:mem.Structure.shape then
                [%expr Util.of_option [] [%e b]]
              else if is_map ~shapes ~shp:mem.Structure.shape then
                [%expr Some (Hashtbl.create 0)]
              else
                b
            in
            Some (mem.Structure.field_name, op)
          | _ ->
            (* TODO: payload *)
            failwith
              (Format.asprintf "of_headers (op: %s, field: %s)@."
                mem.Structure.field_name
                v.name))
            s
        in
        if fields == [] then
         [%expr ()]
        else
         record fields
      | Shape.List (shp, _, _) ->
        [%expr List.map (fun x -> [%e ident (shp ^ ".of_headers")] x) v]
      | Shape.Map ((_shp,_),_) -> [%expr []]
      | Shape.Enum _opts -> [%expr assert false]
    in
    if has_payload ~shapes v.name && Util.is_prim (get_payload_shape ~shapes v.name) then
     [%stri let of_headers headers = [%e exp]]
    else
     [%stri let of_headers headers body = [%e exp]]
  in
  (* Don't emit to_headers / to_query if the op doesn't need them. *)
  let base = [ty] @ extra @ [ make; to_query; to_headers; to_json ] in
  let protocol_specific = match protocol with
    | "json" | "rest-json" -> [ of_json ]
    | "ec2" | "query" | "rest-xml" -> [ parse; to_xml ]
    | _ -> raise Not_found
  in
  (* Force capitalize the module name, because some shapes may have uncapitalized names *)
  ( String.capitalize_ascii v.Shape.name
  , base @ protocol_specific @ (if has_payload ~shapes v.name then [ of_headers () ] else [])
  , v.doc
  )

let build_module protocol ~shapes v =
  let name, itms, doc = build_module_structure protocol ~shapes v in
  match v.Shape.depends_on with
  | Some dshp, false ->
    let oname, oitms, odoc = build_module_structure protocol ~shapes dshp in
    let sigs = build_module_signature protocol ~shapes v in
    let osigs = build_module_signature protocol ~shapes dshp in
    dshp.depends_on <- fst dshp.depends_on, true;
    Some (Syntax.rec_module [ name, itms, sigs, doc; oname, oitms, osigs, odoc ])
  | _, true -> None
  | None, _ -> Some (Syntax.module_ ?doc name itms)

let types protocol (input_op_name_map, _output_op_name_map) shapes =
  (* Only generate types for the output shapes, input shapes are written inline
   * in the op specific module. See comment at the end of the `op` function
    * below. *)
  let op_names = StringTable.bindings input_op_name_map |> List.map fst in
  let modules = List.filter_map (fun v ->
    if List.mem v.Shape.name op_names then
     (* Operation-specific input / output Shapes are inlined in the operation
      * modules *)
     None
    else
     build_module protocol ~shapes v)
   (toposort shapes)
  in
  let imports =
    [ [%stri open Aws]
    ; [%stri open Aws.BaseTypes]
    ] in
  imports, modules


let op_to_uri ~req_name shapes op =
  let replace_shape loc_name =
    (* Some S3 APIs specify `Key+` but the shape name is `Key` *)
    let loc_name = if String.get loc_name ((String.length loc_name) - 1) = '+' then
        String.sub loc_name 0 ((String.length loc_name) - 1)
      else loc_name
    in
    match op.Operation.input_shape with
    | Some input_shape ->
      let shp = StringTable.find input_shape shapes in
      begin match shp.Shape.content with
      | Shape.Structure members ->
        List.find
          (fun member ->
             match member.Structure.loc_name with
             | None -> false
             | Some x -> x = loc_name) members
      | _ -> raise Not_found
      end
    | None -> assert false
  in
  let uri = op.Operation.http_uri in
  if ((String.contains uri '{') && (String.contains uri '}')) then
    let is_shape = ref false in
    let tokens = Str.full_split (Str.regexp "[{}]") uri
      |> List.fold_left (fun acc i ->
           let open Str in
           match i with
           | Text s ->
             begin match op.Operation.input_shape with
             | Some input_shape when !is_shape ->
               let { Structure.field_name; shape; _ } = replace_shape s in
               let segment =
                 Ast_helper.Exp.field
                   req_name
                   (Syntax.lid (input_shape ^ "." ^ field_name))
               in
               let segment = match shape with
               | "String" | "Blob" ->
                 (* Don't convert a string to a string *)
                 segment
               | _ ->
                 let prefix =
                   if Util.is_prim shape then
                     "Aws.BaseTypes." ^ shape
                   else shape
                 in
                 (Syntax.app1 (prefix ^ ".to_string") segment)
               in
               segment :: acc
             | _ ->
               (Syntax.str s) :: acc
             end
           | Delim d -> is_shape := d = "{"; acc)
        []
      |> List.rev
    in
    List.fold_left
      (Syntax.app2 "^")
      (Syntax.app2 "^" (List.hd tokens) (List.nth tokens 1))
      (List.tl (List.tl tokens))
  else (Syntax.str uri)

let mk_of_body op shapes protocol =
  let open Syntax in
  let read_xml shape =
    let resp = if protocol = "rest-xml" then
      [%expr
        match List.hd (snd xml) with
        | `El (_, xs) -> Some xs
        | _ -> raise (Failure [%e str ("Could not find well formed " ^ shape ^ ".")])
      ]
    else
      let r =
        (* this may be a bug. shouldn't we just use output-shape? *)
        [%expr Xml.member [%e str (op.Operation.name ^ "Response")] (snd xml)]
      in
      match op.Operation.output_wrapper with
      | None -> r
      | Some w ->
        [%expr Util.option_bind [%e r] (Xml.member [%e str w])]
    in
    let read_xml_body read_expr =
      let expr =
        if has_required_fields ~shapes shape then
          read_expr
        else
         (* `of_http` should only be called on successful responses. If the
          * response body is empty, surely all fields for the output object are
          * optional. Just call `make ()` in that case. *)
          [%expr
           if body = "" then begin
             `Ok ([%e ident (shape ^ ".make")] ())
           end else [%e read_expr]
          ]
      in
      [%expr
       let[@ocaml.warning "-8"] (`String body: [ `String of string | `Streaming of Piaf.Body.t  ]) =
         body
       in
       [%e expr]
      ]
    in
    read_xml_body
      [%expr
       try
         let xml = Ezxmlm.from_string body in
         let resp = [%e resp] in
         try
           let open Error in
           Util.or_error
            (Util.option_bind resp [%e ident (shape ^ ".parse")])
            (BadResponse { body; message = [%e str ("Could not find well formed " ^ shape ^ ".")]})
         with | Xml.RequiredFieldMissing msg ->
           let open Error in
           `Error
             (BadResponse
               { body
               ; message =
                 [%e (str ("Error parsing " ^ shape ^ " - missing field in body or children: "))] ^ msg
               })
       with
       | Failure msg ->
         let open Error in
         `Error (BadResponse {body; message = "Error parsing xml: " ^ msg})]
  in
  match op.Operation.output_shape with
  | None -> [%expr `Ok ()]
  | Some shp ->
    match protocol with
    | "json" | "rest-json" ->
      [%expr
        let[@ocaml.warning "-8"] ((`String body): [ `String of string | `Streaming of Piaf.Body.t  ]) = body in
        try
          let json = Yojson.Basic.from_string body in
          `Ok ([%e ident (shp ^ ".of_json")] json )
        with Yojson.Json_error msg ->
          let open Error in
          `Error (BadResponse { body; message = "Error parsing JSON: " ^ msg })
      ]
    | "query" | "ec2" ->
      read_xml shp
    | "rest-xml" ->
      if (has_payload ~shapes shp) then begin
        (* If the output shape has a payload, the rest of the structure is in
         * headers. *)
        let payload_shp = get_payload_shape ~shapes shp in
        if Util.is_prim payload_shp then begin
          [%expr
let[@ocaml.warning "-8"] ((`Streaming body) : [ `String of string | `Streaming of Piaf.Body.t ]) = body in
            `Ok ([%e ident (shp ^ ".of_headers")] headers, body)]
        end else begin
          (* parse the payload shape from the body *)
          [%expr
            match [%e (read_xml payload_shp)] with
            | `Ok payload ->
              `Ok [%e (app2 (shp ^ ".of_headers") (ident "headers") (ident "payload")) ]
            | `Error err -> `Error err
          ]
        end
      end else
        read_xml shp
    | _other -> raise Not_found

let op service version protocol shapes (input_op_name_map, _output_op_name_map) op =
  let open Syntax in
  let mkty = function
    | None -> ty0 "unit"
    | Some shp -> ty0 (shp ^ ".t")
  in
  let defaults =
    [%expr
      [ ("Version", [[%e str version]])
      ; ("Action", [[%e str op.Operation.name]])
      ]
    ]
  in
  let to_body =
    match protocol with
    | "json" | "rest-json" | "rest-xml" ->
      let is_streaming_input =
        Option.is_some op.Operation.input_shape &&
        has_payload ~shapes Option.(get op.input_shape) &&
        Util.is_prim (get_payload_shape ~shapes Option.(get op.input_shape))
      in
      let payload =
       match op.Operation.input_shape with
       | None | Some "Aws.BaseTypes.Unit" ->
         [%expr Piaf.Body.empty]
       | Some input_shape ->
          let shp = StringTable.find input_shape shapes in
          match shp.Shape.content with
          | Shape.Structure members ->
            begin match List.find_opt (fun member -> member.Structure.payload) members with
            | None -> [%expr Piaf.Body.empty]
            | Some found ->
              let field_access =
                (ident ("req." ^ input_shape ^ "." ^ found.Structure.field_name))
              in
              begin match found.Structure.shape with
              | "Blob" | "String" ->
                [%expr (snd req)]
              | _ ->
                begin match protocol with
                | "json" | "rest-json" ->
                  if found.Structure.required then
                    [%expr
                      Piaf.Body.of_string
                        (Yojson.Basic.to_string
                          ([%e ident (found.Structure.shape ^ ".to_json")] [%e field_access]))]
                  else
                    [%expr
                      match [%e field_access] with
                      | Some v ->
                        Piaf.Body.of_string
                          (Yojson.Basic.to_string
                            ([%e ident (found.Structure.shape ^ ".to_json")] v))
                      | None -> Piaf.Body.empty ]
                | "rest-xml" ->
                  let location = match found.Structure.loc_name with
                    | None -> found.Structure.name
                    | Some name -> name
                  in
                  if found.Structure.required then
                    [%expr
                      Piaf.Body.of_string
                        (Ezxmlm.to_string
                          [Ezxmlm.make_tag
                            [%e str location]
                            ([], [%e ident (found.Structure.shape ^ ".to_xml")] [%e field_access])
                            ])
                    ]
                  else
                    [%expr
                      match [%e field_access] with
                      | Some v ->
                        Piaf.Body.of_string
                          (Ezxmlm.to_string
                            [Ezxmlm.make_tag
                              [%e str location]
                              ([], [%e ident (found.Structure.shape ^ ".to_xml")] v)
                            ])
                      | None -> Piaf.Body.empty
                    ]
                | _ -> raise Not_found
                end
              end
            end
          | _ -> [%expr Piaf.Body.empty]
      in
      let req_name = if is_streaming_input then
        [%expr (fst req)]
      else
        [%expr req]
      in
      let query_params = match op.Operation.input_shape with
        | None ->
          (* TODO: I seriously doubt this is correct for these protocols. Should be empty. *)
          defaults
        | Some input_shape ->
          [%expr
            Util.drop_empty
              (Uri.query_of_encoded
                (Query.render ([%e ident (input_shape ^ ".to_query")] [%e req_name])))]
      in
      let headers = match op.Operation.input_shape with
        | None -> [%expr Headers.List []]
        | Some input_shape ->
          [%expr [%e ident (input_shape ^ ".to_headers")] [%e req_name]]
      in
      [%expr
        let uri =
          Uri.add_query_params
            (Uri.of_string
              ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
               [%e op_to_uri ~req_name shapes op]))
            [%e query_params]
        in
        ( [%e variant op.Operation.http_meth ]
        , uri
        , Headers.render [%e headers]
        , [%e payload]
        )
      ]
    | "query" | "ec2" ->
      let query_params = match op.Operation.input_shape with
        | None -> defaults
        | Some input_shape ->
          [%expr
            List.append
              [%e defaults]
              (Util.drop_empty
                (Uri.query_of_encoded
                  (Query.render
                    ([%e ident (input_shape ^ ".to_query")] req))))]
      in
      let headers = match op.Operation.input_shape with
        | None -> [%expr Headers.List []]
        | Some input_shape ->
          [%expr [%e ident (input_shape ^ ".to_headers")] req]
      in
      [%expr
        let uri =
          Uri.add_query_params
            (Uri.of_string
              ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
               [%e op_to_uri ~req_name:(Syntax.ident "req") shapes op]))
            [%e query_params]
        in
        ( [%e variant op.Operation.http_meth]
        , uri
        , Headers.render [%e headers]
        , Piaf.Body.empty)]
    | _ -> raise Not_found
  in
  let of_body = mk_of_body op shapes protocol in
  let op_error_parse =
    [%stri let parse_error code err =
      let errors =
        [%e (list (List.map (fun name -> ident ("Errors_internal." ^ (Util.to_variant_name name))) op.Operation.errors))]
        @ Errors_internal.common
      in
      match Errors_internal.of_string err with
      | Some v ->
        if List.mem v errors &&
           match Errors_internal.to_http_code v with | Some x -> x = code | None -> true then
          Some v
        else
          None
      | None -> None
    ]
  in
  let extra_opens =
   let shapes_to_check shp =
    match (StringTable.find shp shapes).Shape.content with
    | Structure members ->
      List.map (fun { Structure.shape; _ } -> shape) members
    | List (shape, _, _) -> [shape]
    | Map ((kshp, _), (vshp, _)) ->
      [kshp; vshp]
    | _ -> []
    | exception Not_found -> []
   in
   let to_check = match op.input_shape, op.output_shape with
   | None, None -> []
   | Some i, None -> shapes_to_check i
   | None, Some o -> shapes_to_check o
   | Some i, Some o -> shapes_to_check i @ shapes_to_check o
   in
   (* If one of the types that make either this op's Input or Output objects
    * is an input / output type of another op, we need to open those other ops
    *)
   List.fold_left (fun acc shape ->
    match StringTable.find shape input_op_name_map with
    | op -> op :: acc
    | exception Not_found -> acc)
   [] to_check
  in
  if extra_opens != [] then
   Format.eprintf "OPNS: %s@." (String.concat "; " extra_opens);
  let sopens, opens = List.split (List.map (fun opn ->
    (sopen opn, open_ opn))
  extra_opens)
  in
  let mk_smodalias nm = function
   | None | Some "Aws.BaseTypes.Unit" -> smodalias nm "Aws.BaseTypes.Unit"
   | Some shp -> smodalias shp shp
  in
  let mk_modalias nm = function
   | None | Some "Aws.BaseTypes.Unit" -> modalias nm "Aws.BaseTypes.Unit"
   | Some shp -> modalias shp shp
  in
  let mk_modsig nm = function
   | None | Some "Aws.BaseTypes.Unit" -> smodalias nm "Aws.BaseTypes.Unit"
   | Some shp ->
     let shape = StringTable.find shp shapes in
     modsig shp (build_module_signature protocol ~shapes shape)
  in
  let mk_modstr nm = function
   | None | Some "Aws.BaseTypes.Unit" ->
     [ modalias nm "Aws.BaseTypes.Unit" ]
   | Some shp ->
     let shape = StringTable.find shp shapes in
     match build_module protocol ~shapes shape with
     | None -> []
     | Some x -> [ x ]
  in
  let is_streaming_input =
    Option.is_some op.Operation.input_shape &&
    has_payload ~shapes Option.(get op.input_shape) &&
    Util.is_prim (get_payload_shape ~shapes Option.(get op.input_shape))
  in
  let input = if is_streaming_input then
   Syntax.tytup [ mkty op.Operation.input_shape; Syntax.ty0 "Piaf.Body.t" ]
  else
   mkty op.Operation.input_shape
  in
  let is_streaming_output =
    Option.is_some op.Operation.output_shape &&
    has_payload ~shapes Option.(get op.output_shape) &&
    Util.is_prim (get_payload_shape ~shapes Option.(get op.output_shape))
  in
  let output = if is_streaming_output then
   Syntax.tytup [ mkty op.Operation.output_shape; Syntax.ty0 "Piaf.Body.t" ]
  else
   mkty op.Operation.output_shape
  in
  (** Tuple corresponding to (doc, mli, ml) *)
  (op.Operation.doc,
   [ [%sigi: open Types[@@ocaml.warning "-33"]]
   ; [%sigi: open Aws.BaseTypes [@@ocaml.warning "-33"]]
   ]
   @ sopens @
   (* XXX(anmonteiro): For Input modules, each Request is tied to its
    * Operation, so we generate them inline with the op module for better
    * developer experience.
    *
    * This is not the case for Output types: several different ops may have
    * the same Output type, and this is the case in e.g. EC2. So we just place
    * an alias to the types module. *)
   [ mk_modsig "Input" op.Operation.input_shape
   ; mk_smodalias "Output" op.Operation.output_shape
   ; [%sigi: type input = [%t input]]
   ; [%sigi: type output = [%t output]]
   ; [%sigi: type error = Errors_internal.t]
   ; [%sigi: include Aws.Call
                with type input := input
                 and type output := output
                 and type error :=  error
   ]],
   [ [%stri open Types[@@ocaml.warning "-33"]]
   ; [%stri open Aws.BaseTypes[@@ocaml.warning "-33"]]
   ; [%stri open Aws]]
   @ opens @
   List.concat
    [ mk_modstr "Input" op.Operation.input_shape
    ; [ mk_modalias "Output" op.Operation.output_shape ]
    ]
   @
   [ [%stri type input = [%t input ]]
   ; [%stri type output = [%t output]]
   ; [%stri type error = Errors_internal.t]
   ; [%stri let streaming = [%e (if is_streaming_output then [%expr true ] else [%expr false ]) ]]
   ; [%stri let service = [%e (str service)]]
   ; [%stri let to_http service region req = [%e to_body]]
   ; [%stri let of_http headers (body : [ `String of string | `Streaming of Piaf.Body.t ]) = [%e of_body]]
   ; op_error_parse
   ])


let errors errs common_errors =
  let errs =
    errs @ [Error.({ shape_name = "UninhabitedError"
                   ; variant_name = "Uninhabited"
                   ; string_name = "Uninhabited"
                   ; http_code = None
                   ; doc = None})]
  in
  let open Syntax in
  [ tyvariantlet "t"
      (List.map (fun e -> (e.Error.variant_name, [], e.doc)) errs)
  ; [%stri let common = [%e (list (List.map (fun e -> ident e.Error.variant_name) common_errors))]]
  ; [%stri let to_http_code e =
    [%e matchvar (ident "e")
    (List.map (fun e ->
      (e.Error.variant_name,
                  match e.Error.http_code with
                  | Some n -> app1 "Some" (int n)
                  | None -> ident "None"))
    errs)] ]
  ; [%stri let to_string e =
      [%e matchvar
            (ident "e")
            (List.map (fun e -> (e.Error.variant_name, str e.Error.string_name)) errs)] ]
  ; [%stri let of_string e =
      [%e matchstrs
            (ident "e")
            (List.map (fun e -> (e.Error.string_name, app1 "Some" (ident e.Error.variant_name))) errs)
            (ident "None")] ]
  ]
