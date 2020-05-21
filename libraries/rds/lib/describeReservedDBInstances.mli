(** "<p>Returns information about reserved DB instances for this account, or about a specified reserved DB instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReservedDBInstancesMessage :
sig
  type t =
    {
    reserved_d_b_instance_id: String.t option ;
    reserved_d_b_instances_offering_id: String.t option ;
    d_b_instance_class: String.t option ;
    duration: String.t option ;
    product_description: String.t option ;
    offering_type: String.t option ;
    multi_a_z: Boolean.t option ;
    lease_id: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?reserved_d_b_instance_id:String.t ->
      ?reserved_d_b_instances_offering_id:String.t ->
        ?d_b_instance_class:String.t ->
          ?duration:String.t ->
            ?product_description:String.t ->
              ?offering_type:String.t ->
                ?multi_a_z:Boolean.t ->
                  ?lease_id:String.t ->
                    ?filters:FilterList.t ->
                      ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReservedDBInstanceMessage = ReservedDBInstanceMessage
type input = DescribeReservedDBInstancesMessage.t
type output = ReservedDBInstanceMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error