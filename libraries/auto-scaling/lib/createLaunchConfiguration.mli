(** "<p>Creates a launch configuration.</p> <p>If you exceed your maximum limit of launch configurations, the call fails. For information about viewing this limit, see <a>DescribeAccountLimits</a>. For information about updating this limit, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-account-limits.html\">Amazon EC2 Auto Scaling Limits</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchConfiguration.html\">Launch Configurations</a> in the <i>Amazon EC2 Auto Scaling User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateLaunchConfigurationType :
sig
  type t =
    {
    launch_configuration_name: String.t ;
    image_id: String.t option ;
    key_name: String.t option ;
    security_groups: SecurityGroups.t ;
    classic_link_v_p_c_id: String.t option ;
    classic_link_v_p_c_security_groups: ClassicLinkVPCSecurityGroups.t ;
    user_data: String.t option ;
    instance_id: String.t option ;
    instance_type: String.t option ;
    kernel_id: String.t option ;
    ramdisk_id: String.t option ;
    block_device_mappings: BlockDeviceMappings.t ;
    instance_monitoring: InstanceMonitoring.t option ;
    spot_price: String.t option ;
    iam_instance_profile: String.t option ;
    ebs_optimized: Boolean.t option ;
    associate_public_ip_address: Boolean.t option ;
    placement_tenancy: String.t option }
  val make :
    launch_configuration_name:String.t ->
      ?image_id:String.t ->
        ?key_name:String.t ->
          ?security_groups:SecurityGroups.t ->
            ?classic_link_v_p_c_id:String.t ->
              ?classic_link_v_p_c_security_groups:ClassicLinkVPCSecurityGroups.t
                ->
                ?user_data:String.t ->
                  ?instance_id:String.t ->
                    ?instance_type:String.t ->
                      ?kernel_id:String.t ->
                        ?ramdisk_id:String.t ->
                          ?block_device_mappings:BlockDeviceMappings.t ->
                            ?instance_monitoring:InstanceMonitoring.t ->
                              ?spot_price:String.t ->
                                ?iam_instance_profile:String.t ->
                                  ?ebs_optimized:Boolean.t ->
                                    ?associate_public_ip_address:Boolean.t ->
                                      ?placement_tenancy:String.t ->
                                        unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = CreateLaunchConfigurationType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error