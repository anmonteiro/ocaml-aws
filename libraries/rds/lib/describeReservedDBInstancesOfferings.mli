(** "<p>Lists available reserved DB instance offerings.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReservedDBInstancesOfferingsMessage :
sig
  type t =
    {
    reserved_d_b_instances_offering_id: String.t option ;
    d_b_instance_class: String.t option ;
    duration: String.t option ;
    product_description: String.t option ;
    offering_type: String.t option ;
    multi_a_z: Boolean.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?reserved_d_b_instances_offering_id:String.t ->
      ?d_b_instance_class:String.t ->
        ?duration:String.t ->
          ?product_description:String.t ->
            ?offering_type:String.t ->
              ?multi_a_z:Boolean.t ->
                ?filters:FilterList.t ->
                  ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReservedDBInstancesOfferingMessage =
ReservedDBInstancesOfferingMessage
type input = DescribeReservedDBInstancesOfferingsMessage.t
type output = ReservedDBInstancesOfferingMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error