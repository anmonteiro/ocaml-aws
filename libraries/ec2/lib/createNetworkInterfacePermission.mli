(** "<p>Grants an AWS-authorized account permission to attach the specified network interface to an instance in their account.</p> <p>You can grant permission to a single AWS account only, and only one account at a time.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateNetworkInterfacePermissionRequest :
sig
  type t =
    {
    network_interface_id: String.t ;
    aws_account_id: String.t option ;
    aws_service: String.t option ;
    permission: InterfacePermissionType.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for CreateNetworkInterfacePermission.</p>"]
  val make :
    network_interface_id:String.t ->
      ?aws_account_id:String.t ->
        ?aws_service:String.t ->
          permission:InterfacePermissionType.t ->
            ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateNetworkInterfacePermissionResult =
CreateNetworkInterfacePermissionResult
type input = CreateNetworkInterfacePermissionRequest.t
type output = CreateNetworkInterfacePermissionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error