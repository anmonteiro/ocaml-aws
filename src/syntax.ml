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

open Ppxlib.Selected_ast.Ast

open Parsetree
open Ast_helper
open Asttypes


let strloc txt = { txt; loc = !default_loc }

let lid txt = strloc (Longident.parse txt)

(* nm (as a type) *)
let ty0 nm = Typ.constr (lid nm) []

(* nm2 nm1 (as a type) *)
let ty1 nm1 nm2 = Typ.constr (lid nm1) [ty0 nm2]

(* nm2 nm1 (as a type) *)
let ty2 nm1 nm2 nm3 = Typ.constr (lid nm1) [ty0 nm2; ty0 nm3]

let doc_attrs = function
 | Some doc -> [Docstrings.(docs_attr (docstring doc !default_loc)) ]
 | None -> []

(* type nm = { fs.. } *)
let tyreclet nm fs =
  Str.type_
    Recursive
    [Type.mk
      ~kind:(Ptype_record (List.map (fun (nm, ty, doc) ->
        Type.field ~attrs:(doc_attrs doc) (strloc nm) ty) fs)) (strloc nm)]

(* type nm = { fs.. }  (in .mli) *)
let styreclet nm fs =
  Sig.type_ Recursive [Type.mk ~kind:(Ptype_record (List.map (fun (nm, ty) -> Type.field (strloc nm) ty) fs)) (strloc nm)]

(* type nm = | nm0 of ty0 | ... *)
let tyvariantlet nm variants =
  Str.type_ Recursive
    [Type.mk
       ~kind:(Ptype_variant (List.map (fun (cnm, args, doc) ->
         Type.constructor
           ~attrs:(doc_attrs doc)
           ~args:(Pcstr_tuple args)
           (strloc cnm))
         variants))
       (strloc nm)]

(* type nm = | nm0 of ty0 | ... (in .mli) *)
let styvariantlet nm variants =
  Sig.type_ Recursive
    [Type.mk ~kind:(Ptype_variant
                      (List.map (fun (cnm,args) -> Type.constructor ~args:(Pcstr_tuple args) (strloc cnm)) variants))
       (strloc nm)]

(* fun ~arg -> body *)
let funlab arg body =
  Exp.fun_ (Labelled arg) None (Pat.var (strloc arg)) body

(* fun ?arg -> body *)
let funopt arg body =
  Exp.fun_ (Optional arg) None (Pat.var (strloc arg)) body

(* fun ?(arg=exp) -> body *)
let funopt_def exp arg body =
  Exp.fun_ (Optional arg) (Some exp) (Pat.var (strloc arg)) body

let arrowlab arg typ1 typ2 =
  Typ.arrow (Labelled arg) typ1 typ2

let arrowopt arg typ1 typ2 =
  Typ.arrow (Optional arg) typ1 typ2

let arrow typ1 typ2 =
  Typ.arrow Nolabel typ1 typ2

let tname nm = Typ.constr (lid nm)  [ ]

(* fun () -> body *)
let fununit body =
  Exp.fun_ Nolabel None (Pat.construct (lid "()") None) body

let sfununit t =
  arrow (tname "unit") (tname t)

(* { fs .. } (as value) *)
let record fs =
  Exp.record (List.map (fun (nm, exp) -> (lid nm, exp)) fs) None

(* i (the identifier) *)
let ident i = Exp.ident (lid i)

(* f a *)
let app1 f a = Exp.apply (ident f) [(Nolabel, a)]

(* f a0 a1 *)
let app2 f a0 a1 = Exp.apply (ident f) [(Nolabel, a0);(Nolabel, a1)]

(* s (the string literal) *)
let str s = Exp.constant (Pconst_string (s, None))

(* n (the int literal) *)
let int n = Exp.constant (Pconst_integer (string_of_int n, None))

(* (a, b) *)
let pair a b = Exp.tuple [a; b]

(* [x; ..] (the list of expressions) *)
let list xs = List.fold_left (fun rest x -> Exp.construct (lid "::") (Some (pair x rest))) (Exp.construct (lid "[]") None) xs

(* `v *)
let variant v = Exp.variant v None
(* `v a *)
let variant1 v a = Exp.variant v (Some a)

(* module nm = vs *)
let module_ ?doc nm vs =
  Str.module_ (Mb.mk ~attrs:(doc_attrs doc) (strloc nm) (Mod.structure vs))

let rec_module nmvs =
  Str.rec_module
    (List.map (fun (nm, vs, sigs, doc) ->
      Mb.mk ~attrs:(doc_attrs doc) (strloc nm) (Mod.constraint_ (Mod.structure vs) (Mty.signature sigs)))
    nmvs)

(* match exp with | Constructor -> body | Constructor -> body ... *)
let matchvar exp branches = Exp.match_ exp (List.map (fun (nm, body) ->
    Exp.case (Pat.construct (lid nm) None) body) branches)

(* match exp with | "String" -> body ... | _ -> els ... *)
let matchstrs exp branches els =
  Exp.match_ exp ((List.map (fun (nm, body) ->
      Exp.case (Pat.constant (Pconst_string (nm, None))) body) branches)
                  @ [Exp.case (Pat.any ()) els])

