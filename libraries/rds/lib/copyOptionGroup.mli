(** "<p>Copies the specified option group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopyOptionGroupMessage :
sig
  type t =
    {
    source_option_group_identifier: String.t ;
    target_option_group_identifier: String.t ;
    target_option_group_description: String.t ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    source_option_group_identifier:String.t ->
      target_option_group_identifier:String.t ->
        target_option_group_description:String.t ->
          ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopyOptionGroupResult = CopyOptionGroupResult
type input = CopyOptionGroupMessage.t
type output = CopyOptionGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error