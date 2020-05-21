(** "<p>Modifies the specified attribute of the specified instance. You can specify only one attribute at a time.</p> <p> <b>Note: </b>Using this action to change the security groups associated with an elastic network interface (ENI) attached to an instance in a VPC can result in an error if the instance has more than one ENI. To change the security groups associated with an ENI attached to an instance that has multiple ENIs, we recommend that you use the <a>ModifyNetworkInterfaceAttribute</a> action.</p> <p>To modify some attributes, the instance must be stopped. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_ChangingAttributesWhileInstanceStopped.html\">Modifying Attributes of a Stopped Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyInstanceAttributeRequest :
sig
  type t =
    {
    source_dest_check: AttributeBooleanValue.t option ;
    attribute: InstanceAttributeName.t option ;
    block_device_mappings: InstanceBlockDeviceMappingSpecificationList.t ;
    disable_api_termination: AttributeBooleanValue.t option ;
    dry_run: Boolean.t option ;
    ebs_optimized: AttributeBooleanValue.t option ;
    ena_support: AttributeBooleanValue.t option ;
    groups: GroupIdStringList.t ;
    instance_id: String.t ;
    instance_initiated_shutdown_behavior: AttributeValue.t option ;
    instance_type: AttributeValue.t option ;
    kernel: AttributeValue.t option ;
    ramdisk: AttributeValue.t option ;
    sriov_net_support: AttributeValue.t option ;
    user_data: BlobAttributeValue.t option ;
    value: String.t option }
  val make :
    ?source_dest_check:AttributeBooleanValue.t ->
      ?attribute:InstanceAttributeName.t ->
        ?block_device_mappings:InstanceBlockDeviceMappingSpecificationList.t
          ->
          ?disable_api_termination:AttributeBooleanValue.t ->
            ?dry_run:Boolean.t ->
              ?ebs_optimized:AttributeBooleanValue.t ->
                ?ena_support:AttributeBooleanValue.t ->
                  ?groups:GroupIdStringList.t ->
                    instance_id:String.t ->
                      ?instance_initiated_shutdown_behavior:AttributeValue.t
                        ->
                        ?instance_type:AttributeValue.t ->
                          ?kernel:AttributeValue.t ->
                            ?ramdisk:AttributeValue.t ->
                              ?sriov_net_support:AttributeValue.t ->
                                ?user_data:BlobAttributeValue.t ->
                                  ?value:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ModifyInstanceAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error