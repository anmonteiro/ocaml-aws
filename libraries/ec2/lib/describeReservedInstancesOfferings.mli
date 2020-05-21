(** "<p>Describes Reserved Instance offerings that are available for purchase. With Reserved Instances, you purchase the right to launch instances for a period of time. During that time period, you do not receive insufficient capacity errors, and you pay a lower usage rate than the rate charged for On-Demand instances for the actual time used.</p> <p>If you have listed your own Reserved Instances for sale in the Reserved Instance Marketplace, they will be excluded from these results. This is to ensure that you do not purchase your own Reserved Instances.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html\">Reserved Instance Marketplace</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReservedInstancesOfferingsRequest :
sig
  type t =
    {
    availability_zone: String.t option ;
    filters: FilterList.t ;
    include_marketplace: Boolean.t option ;
    instance_type: InstanceType.t option ;
    max_duration: Long.t option ;
    max_instance_count: Integer.t option ;
    min_duration: Long.t option ;
    offering_class: OfferingClassType.t option ;
    product_description: RIProductDescription.t option ;
    reserved_instances_offering_ids: ReservedInstancesOfferingIdStringList.t ;
    dry_run: Boolean.t option ;
    instance_tenancy: Tenancy.t option ;
    max_results: Integer.t option ;
    next_token: String.t option ;
    offering_type: OfferingTypeValues.t option }[@@ocaml.doc
                                                  "<p>Contains the parameters for DescribeReservedInstancesOfferings.</p>"]
  val make :
    ?availability_zone:String.t ->
      ?filters:FilterList.t ->
        ?include_marketplace:Boolean.t ->
          ?instance_type:InstanceType.t ->
            ?max_duration:Long.t ->
              ?max_instance_count:Integer.t ->
                ?min_duration:Long.t ->
                  ?offering_class:OfferingClassType.t ->
                    ?product_description:RIProductDescription.t ->
                      ?reserved_instances_offering_ids:ReservedInstancesOfferingIdStringList.t
                        ->
                        ?dry_run:Boolean.t ->
                          ?instance_tenancy:Tenancy.t ->
                            ?max_results:Integer.t ->
                              ?next_token:String.t ->
                                ?offering_type:OfferingTypeValues.t ->
                                  unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeReservedInstancesOfferingsResult =
DescribeReservedInstancesOfferingsResult
type input = DescribeReservedInstancesOfferingsRequest.t
type output = DescribeReservedInstancesOfferingsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error