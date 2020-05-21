(** "<p>Updates the status of the Systems Manager document associated with the specified instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateAssociationStatusRequest :
sig
  type t =
    {
    name: String.t ;
    instance_id: String.t ;
    association_status: AssociationStatus.t }
  val make :
    name:String.t ->
      instance_id:String.t ->
        association_status:AssociationStatus.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateAssociationStatusResult = UpdateAssociationStatusResult
type input = UpdateAssociationStatusRequest.t
type output = UpdateAssociationStatusResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error