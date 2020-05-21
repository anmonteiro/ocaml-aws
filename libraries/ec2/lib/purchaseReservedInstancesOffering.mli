(** "<p>Purchases a Reserved Instance for use with your account. With Reserved Instances, you pay a lower hourly rate compared to On-Demand instance pricing.</p> <p>Use <a>DescribeReservedInstancesOfferings</a> to get a list of Reserved Instance offerings that match your specifications. After you've purchased a Reserved Instance, you can check for your new Reserved Instance with <a>DescribeReservedInstances</a>.</p> <p>To queue a purchase for a future date and time, specify a purchase time. If you do not specify a purchase time, the default is the current time.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts-on-demand-reserved-instances.html\">Reserved Instances</a> and <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html\">Reserved Instance Marketplace</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PurchaseReservedInstancesOfferingRequest :
sig
  type t =
    {
    instance_count: Integer.t ;
    reserved_instances_offering_id: String.t ;
    dry_run: Boolean.t option ;
    limit_price: ReservedInstanceLimitPrice.t option ;
    purchase_time: DateTime.t option }[@@ocaml.doc
                                        "<p>Contains the parameters for PurchaseReservedInstancesOffering.</p>"]
  val make :
    instance_count:Integer.t ->
      reserved_instances_offering_id:String.t ->
        ?dry_run:Boolean.t ->
          ?limit_price:ReservedInstanceLimitPrice.t ->
            ?purchase_time:DateTime.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PurchaseReservedInstancesOfferingResult =
PurchaseReservedInstancesOfferingResult
type input = PurchaseReservedInstancesOfferingRequest.t
type output = PurchaseReservedInstancesOfferingResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error