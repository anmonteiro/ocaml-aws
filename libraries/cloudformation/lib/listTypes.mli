(** "<p>Returns summary information about types that have been registered with CloudFormation.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTypesInput :
sig
  type t =
    {
    visibility: Visibility.t option ;
    provisioning_type: ProvisioningType.t option ;
    deprecated_status: DeprecatedStatus.t option ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?visibility:Visibility.t ->
      ?provisioning_type:ProvisioningType.t ->
        ?deprecated_status:DeprecatedStatus.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTypesOutput = ListTypesOutput
type input = ListTypesInput.t
type output = ListTypesOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error