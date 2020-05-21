(** "<p>Modifies a connection notification for VPC endpoint or VPC endpoint service. You can change the SNS topic for the notification, or the events for which to be notified. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcEndpointConnectionNotificationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    connection_notification_id: String.t ;
    connection_notification_arn: String.t option ;
    connection_events: ValueStringList.t }
  val make :
    ?dry_run:Boolean.t ->
      connection_notification_id:String.t ->
        ?connection_notification_arn:String.t ->
          ?connection_events:ValueStringList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpcEndpointConnectionNotificationResult =
ModifyVpcEndpointConnectionNotificationResult
type input = ModifyVpcEndpointConnectionNotificationRequest.t
type output = ModifyVpcEndpointConnectionNotificationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error