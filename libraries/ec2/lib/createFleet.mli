(** "<p>Launches an EC2 Fleet.</p> <p>You can create a single EC2 Fleet that includes multiple launch specifications that vary by instance type, AMI, Availability Zone, or subnet.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet.html\">Launching an EC2 Fleet</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateFleetRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    client_token: String.t option ;
    spot_options: SpotOptionsRequest.t option ;
    on_demand_options: OnDemandOptionsRequest.t option ;
    excess_capacity_termination_policy:
      FleetExcessCapacityTerminationPolicy.t option ;
    launch_template_configs: FleetLaunchTemplateConfigListRequest.t ;
    target_capacity_specification: TargetCapacitySpecificationRequest.t ;
    terminate_instances_with_expiration: Boolean.t option ;
    type_: FleetType.t option ;
    valid_from: DateTime.t option ;
    valid_until: DateTime.t option ;
    replace_unhealthy_instances: Boolean.t option ;
    tag_specifications: TagSpecificationList.t }
  val make :
    ?dry_run:Boolean.t ->
      ?client_token:String.t ->
        ?spot_options:SpotOptionsRequest.t ->
          ?on_demand_options:OnDemandOptionsRequest.t ->
            ?excess_capacity_termination_policy:FleetExcessCapacityTerminationPolicy.t
              ->
              launch_template_configs:FleetLaunchTemplateConfigListRequest.t
                ->
                target_capacity_specification:TargetCapacitySpecificationRequest.t
                  ->
                  ?terminate_instances_with_expiration:Boolean.t ->
                    ?type_:FleetType.t ->
                      ?valid_from:DateTime.t ->
                        ?valid_until:DateTime.t ->
                          ?replace_unhealthy_instances:Boolean.t ->
                            ?tag_specifications:TagSpecificationList.t ->
                              unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateFleetResult = CreateFleetResult
type input = CreateFleetRequest.t
type output = CreateFleetResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error