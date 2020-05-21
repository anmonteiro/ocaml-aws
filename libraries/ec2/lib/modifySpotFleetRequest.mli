(** "<p>Modifies the specified Spot Fleet request.</p> <p>You can only modify a Spot Fleet request of type <code>maintain</code>.</p> <p>While the Spot Fleet request is being modified, it is in the <code>modifying</code> state.</p> <p>To scale up your Spot Fleet, increase its target capacity. The Spot Fleet launches the additional Spot Instances according to the allocation strategy for the Spot Fleet request. If the allocation strategy is <code>lowestPrice</code>, the Spot Fleet launches instances using the Spot Instance pool with the lowest price. If the allocation strategy is <code>diversified</code>, the Spot Fleet distributes the instances across the Spot Instance pools. If the allocation strategy is <code>capacityOptimized</code>, Spot Fleet launches instances from Spot Instance pools with optimal capacity for the number of instances that are launching.</p> <p>To scale down your Spot Fleet, decrease its target capacity. First, the Spot Fleet cancels any open requests that exceed the new target capacity. You can request that the Spot Fleet terminate Spot Instances until the size of the fleet no longer exceeds the new target capacity. If the allocation strategy is <code>lowestPrice</code>, the Spot Fleet terminates the instances with the highest price per unit. If the allocation strategy is <code>capacityOptimized</code>, the Spot Fleet terminates the instances in the Spot Instance pools that have the least available Spot Instance capacity. If the allocation strategy is <code>diversified</code>, the Spot Fleet terminates instances across the Spot Instance pools. Alternatively, you can request that the Spot Fleet keep the fleet at its current size, but not replace any Spot Instances that are interrupted or that you terminate manually.</p> <p>If you are finished with your Spot Fleet for now, but will use it again later, you can set the target capacity to 0.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifySpotFleetRequestRequest :
sig
  type t =
    {
    excess_capacity_termination_policy:
      ExcessCapacityTerminationPolicy.t option ;
    spot_fleet_request_id: String.t ;
    target_capacity: Integer.t option ;
    on_demand_target_capacity: Integer.t option }[@@ocaml.doc
                                                   "<p>Contains the parameters for ModifySpotFleetRequest.</p>"]
  val make :
    ?excess_capacity_termination_policy:ExcessCapacityTerminationPolicy.t ->
      spot_fleet_request_id:String.t ->
        ?target_capacity:Integer.t ->
          ?on_demand_target_capacity:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifySpotFleetRequestResponse = ModifySpotFleetRequestResponse
type input = ModifySpotFleetRequestRequest.t
type output = ModifySpotFleetRequestResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error