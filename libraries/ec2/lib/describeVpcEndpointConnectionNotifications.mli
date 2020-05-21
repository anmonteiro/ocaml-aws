(** "<p>Describes the connection notifications for VPC endpoints and VPC endpoint services.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeVpcEndpointConnectionNotificationsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    connection_notification_id: String.t option ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?connection_notification_id:String.t ->
        ?filters:FilterList.t ->
          ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeVpcEndpointConnectionNotificationsResult =
DescribeVpcEndpointConnectionNotificationsResult
type input = DescribeVpcEndpointConnectionNotificationsRequest.t
type output = DescribeVpcEndpointConnectionNotificationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error