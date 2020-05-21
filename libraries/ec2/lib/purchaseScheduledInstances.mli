(** "<p>Purchases the Scheduled Instances with the specified schedule.</p> <p>Scheduled Instances enable you to purchase Amazon EC2 compute capacity by the hour for a one-year term. Before you can purchase a Scheduled Instance, you must call <a>DescribeScheduledInstanceAvailability</a> to check for available schedules and obtain a purchase token. After you purchase a Scheduled Instance, you must call <a>RunScheduledInstances</a> during each scheduled time period.</p> <p>After you purchase a Scheduled Instance, you can't cancel, modify, or resell your purchase.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PurchaseScheduledInstancesRequest :
sig
  type t =
    {
    client_token: String.t option ;
    dry_run: Boolean.t option ;
    purchase_requests: PurchaseRequestSet.t }[@@ocaml.doc
                                               "<p>Contains the parameters for PurchaseScheduledInstances.</p>"]
  val make :
    ?client_token:String.t ->
      ?dry_run:Boolean.t ->
        purchase_requests:PurchaseRequestSet.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PurchaseScheduledInstancesResult = PurchaseScheduledInstancesResult
type input = PurchaseScheduledInstancesRequest.t
type output = PurchaseScheduledInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error