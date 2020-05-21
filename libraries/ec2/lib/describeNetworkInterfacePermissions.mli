(** "<p>Describes the permissions for your network interfaces. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeNetworkInterfacePermissionsRequest :
sig
  type t =
    {
    network_interface_permission_ids: NetworkInterfacePermissionIdList.t ;
    filters: FilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }[@@ocaml.doc
                                     "<p>Contains the parameters for DescribeNetworkInterfacePermissions.</p>"]
  val make :
    ?network_interface_permission_ids:NetworkInterfacePermissionIdList.t ->
      ?filters:FilterList.t ->
        ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeNetworkInterfacePermissionsResult =
DescribeNetworkInterfacePermissionsResult
type input = DescribeNetworkInterfacePermissionsRequest.t
type output = DescribeNetworkInterfacePermissionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error