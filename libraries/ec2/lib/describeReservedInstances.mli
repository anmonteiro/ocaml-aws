(** "<p>Describes one or more of the Reserved Instances that you purchased.</p> <p>For more information about Reserved Instances, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts-on-demand-reserved-instances.html\">Reserved Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReservedInstancesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    offering_class: OfferingClassType.t option ;
    reserved_instances_ids: ReservedInstancesIdStringList.t ;
    dry_run: Boolean.t option ;
    offering_type: OfferingTypeValues.t option }[@@ocaml.doc
                                                  "<p>Contains the parameters for DescribeReservedInstances.</p>"]
  val make :
    ?filters:FilterList.t ->
      ?offering_class:OfferingClassType.t ->
        ?reserved_instances_ids:ReservedInstancesIdStringList.t ->
          ?dry_run:Boolean.t ->
            ?offering_type:OfferingTypeValues.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeReservedInstancesResult = DescribeReservedInstancesResult
type input = DescribeReservedInstancesRequest.t
type output = DescribeReservedInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error