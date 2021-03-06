(** "<p>Modifies the specified EC2 Fleet.</p> <p>You can only modify an EC2 Fleet request of type <code>maintain</code>.</p> <p>While the EC2 Fleet is being modified, it is in the <code>modifying</code> state.</p> <p>To scale up your EC2 Fleet, increase its target capacity. The EC2 Fleet launches the additional Spot Instances according to the allocation strategy for the EC2 Fleet request. If the allocation strategy is <code>lowest-price</code>, the EC2 Fleet launches instances using the Spot Instance pool with the lowest price. If the allocation strategy is <code>diversified</code>, the EC2 Fleet distributes the instances across the Spot Instance pools. If the allocation strategy is <code>capacity-optimized</code>, EC2 Fleet launches instances from Spot Instance pools with optimal capacity for the number of instances that are launching.</p> <p>To scale down your EC2 Fleet, decrease its target capacity. First, the EC2 Fleet cancels any open requests that exceed the new target capacity. You can request that the EC2 Fleet terminate Spot Instances until the size of the fleet no longer exceeds the new target capacity. If the allocation strategy is <code>lowest-price</code>, the EC2 Fleet terminates the instances with the highest price per unit. If the allocation strategy is <code>capacity-optimized</code>, the EC2 Fleet terminates the instances in the Spot Instance pools that have the least available Spot Instance capacity. If the allocation strategy is <code>diversified</code>, the EC2 Fleet terminates instances across the Spot Instance pools. Alternatively, you can request that the EC2 Fleet keep the fleet at its current size, but not replace any Spot Instances that are interrupted or that you terminate manually.</p> <p>If you are finished with your EC2 Fleet for now, but will use it again later, you can set the target capacity to 0.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyFleetRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    excess_capacity_termination_policy:
      FleetExcessCapacityTerminationPolicy.t option ;
    fleet_id: String.t ;
    target_capacity_specification: TargetCapacitySpecificationRequest.t }
  val make :
    ?dry_run:Boolean.t ->
      ?excess_capacity_termination_policy:FleetExcessCapacityTerminationPolicy.t
        ->
        fleet_id:String.t ->
          target_capacity_specification:TargetCapacitySpecificationRequest.t
            -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyFleetResult = ModifyFleetResult
type input = ModifyFleetRequest.t
type output = ModifyFleetResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error