(** "<p>Deletes a permission for a network interface. By default, you cannot delete the permission if the account for which you're removing the permission has attached the network interface to an instance. However, you can force delete the permission, regardless of any attachment.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteNetworkInterfacePermissionRequest :
sig
  type t =
    {
    network_interface_permission_id: String.t ;
    force: Boolean.t option ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for DeleteNetworkInterfacePermission.</p>"]
  val make :
    network_interface_permission_id:String.t ->
      ?force:Boolean.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteNetworkInterfacePermissionResult =
DeleteNetworkInterfacePermissionResult
type input = DeleteNetworkInterfacePermissionRequest.t
type output = DeleteNetworkInterfacePermissionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error