(** "<p>Modifies an existing option group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyOptionGroupMessage :
sig
  type t =
    {
    option_group_name: String.t ;
    options_to_include: OptionConfigurationList.t ;
    options_to_remove: OptionNamesList.t ;
    apply_immediately: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    option_group_name:String.t ->
      ?options_to_include:OptionConfigurationList.t ->
        ?options_to_remove:OptionNamesList.t ->
          ?apply_immediately:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyOptionGroupResult = ModifyOptionGroupResult
type input = ModifyOptionGroupMessage.t
type output = ModifyOptionGroupResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error