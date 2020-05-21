(** "<p>Creates a new option group. You can create up to 20 option groups.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateOptionGroupMessage :
sig
  type t =
    {
    option_group_name: String.t ;
    engine_name: String.t ;
    major_engine_version: String.t ;
    option_group_description: String.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    option_group_name:String.t ->
      engine_name:String.t ->
        major_engine_version:String.t ->
          option_group_description:String.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateOptionGroupResult = CreateOptionGroupResult
type input = CreateOptionGroupMessage.t
type output = CreateOptionGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error