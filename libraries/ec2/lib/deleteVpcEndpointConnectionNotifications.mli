(** "<p>Deletes one or more VPC endpoint connection notifications.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteVpcEndpointConnectionNotificationsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    connection_notification_ids: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      connection_notification_ids:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteVpcEndpointConnectionNotificationsResult =
DeleteVpcEndpointConnectionNotificationsResult
type input = DeleteVpcEndpointConnectionNotificationsRequest.t
type output = DeleteVpcEndpointConnectionNotificationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error