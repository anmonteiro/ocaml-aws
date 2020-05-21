(** "<p>Purchases a reserved DB instance offering.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PurchaseReservedDBInstancesOfferingMessage :
sig
  type t =
    {
    reserved_d_b_instances_offering_id: String.t ;
    reserved_d_b_instance_id: String.t option ;
    d_b_instance_count: Integer.t option ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    reserved_d_b_instances_offering_id:String.t ->
      ?reserved_d_b_instance_id:String.t ->
        ?d_b_instance_count:Integer.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PurchaseReservedDBInstancesOfferingResult =
PurchaseReservedDBInstancesOfferingResult
type input = PurchaseReservedDBInstancesOfferingMessage.t
type output = PurchaseReservedDBInstancesOfferingResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error