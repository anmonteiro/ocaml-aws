(** "<p>Returns summary information about the versions of a type.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTypeVersionsInput :
sig
  type t =
    {
    type_: RegistryType.t option ;
    type_name: String.t option ;
    arn: String.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    deprecated_status: DeprecatedStatus.t option }
  val make :
    ?type_:RegistryType.t ->
      ?type_name:String.t ->
        ?arn:String.t ->
          ?max_results:Integer.t ->
            ?next_token:String.t ->
              ?deprecated_status:DeprecatedStatus.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTypeVersionsOutput = ListTypeVersionsOutput
type input = ListTypeVersionsInput.t
type output = ListTypeVersionsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error