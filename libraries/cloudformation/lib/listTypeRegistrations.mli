(** "<p>Returns a list of registration tokens for the specified type.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTypeRegistrationsInput :
sig
  type t =
    {
    type_: RegistryType.t option ;
    type_name: String.t option ;
    type_arn: String.t option ;
    registration_status_filter: RegistrationStatus.t option ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?type_:RegistryType.t ->
      ?type_name:String.t ->
        ?type_arn:String.t ->
          ?registration_status_filter:RegistrationStatus.t ->
            ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTypeRegistrationsOutput = ListTypeRegistrationsOutput
type input = ListTypeRegistrationsInput.t
type output = ListTypeRegistrationsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error