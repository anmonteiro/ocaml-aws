(** "<p>Modifies the placement attributes for a specified instance. You can do the following:</p> <ul> <li> <p>Modify the affinity between an instance and a <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-overview.html\">Dedicated Host</a>. When affinity is set to <code>host</code> and the instance is not associated with a specific Dedicated Host, the next time the instance is launched, it is automatically associated with the host on which it lands. If the instance is restarted or rebooted, this relationship persists.</p> </li> <li> <p>Change the Dedicated Host with which an instance is associated.</p> </li> <li> <p>Change the instance tenancy of an instance from <code>host</code> to <code>dedicated</code>, or from <code>dedicated</code> to <code>host</code>.</p> </li> <li> <p>Move an instance to or from a <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html\">placement group</a>.</p> </li> </ul> <p>At least one attribute for affinity, host ID, tenancy, or placement group name must be specified in the request. Affinity and tenancy can be modified in the same request.</p> <p>To modify the host ID, tenancy, placement group, or partition for an instance, the instance must be in the <code>stopped</code> state.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyInstancePlacementRequest :
sig
  type t =
    {
    affinity: Affinity.t option ;
    group_name: String.t option ;
    host_id: String.t option ;
    instance_id: String.t ;
    tenancy: HostTenancy.t option ;
    partition_number: Integer.t option ;
    host_resource_group_arn: String.t option }
  val make :
    ?affinity:Affinity.t ->
      ?group_name:String.t ->
        ?host_id:String.t ->
          instance_id:String.t ->
            ?tenancy:HostTenancy.t ->
              ?partition_number:Integer.t ->
                ?host_resource_group_arn:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyInstancePlacementResult = ModifyInstancePlacementResult
type input = ModifyInstancePlacementRequest.t
type output = ModifyInstancePlacementResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error