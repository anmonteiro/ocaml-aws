(** "<p>Creates a connection notification for a specified VPC endpoint or VPC endpoint service. A connection notification notifies you of specific endpoint events. You must create an SNS topic to receive notifications. For more information, see <a href=\"https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html\">Create a Topic</a> in the <i>Amazon Simple Notification Service Developer Guide</i>.</p> <p>You can create a connection notification for interface endpoints only.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateVpcEndpointConnectionNotificationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    service_id: String.t option ;
    vpc_endpoint_id: String.t option ;
    connection_notification_arn: String.t ;
    connection_events: ValueStringList.t ;
    client_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?service_id:String.t ->
        ?vpc_endpoint_id:String.t ->
          connection_notification_arn:String.t ->
            connection_events:ValueStringList.t ->
              ?client_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateVpcEndpointConnectionNotificationResult =
CreateVpcEndpointConnectionNotificationResult
type input = CreateVpcEndpointConnectionNotificationRequest.t
type output = CreateVpcEndpointConnectionNotificationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error