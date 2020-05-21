(** "<p>Launches the specified number of instances using an AMI for which you have permissions. </p> <p>You can specify a number of options, or leave the default options. The following rules apply:</p> <ul> <li> <p>[EC2-VPC] If you don't specify a subnet ID, we choose a default subnet from your default VPC for you. If you don't have a default VPC, you must specify a subnet ID in the request.</p> </li> <li> <p>[EC2-Classic] If don't specify an Availability Zone, we choose one for you.</p> </li> <li> <p>Some instance types must be launched into a VPC. If you do not have a default VPC, or if you do not specify a subnet ID, the request fails. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-vpc.html#vpc-only-instance-types\">Instance Types Available Only in a VPC</a>.</p> </li> <li> <p>[EC2-VPC] All instances have a network interface with a primary private IPv4 address. If you don't specify this address, we choose one from the IPv4 range of your subnet.</p> </li> <li> <p>Not all instance types support IPv6 addresses. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a>.</p> </li> <li> <p>If you don't specify a security group ID, we use the default security group. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html\">Security Groups</a>.</p> </li> <li> <p>If any of the AMIs have a product code attached for which the user has not subscribed, the request fails.</p> </li> </ul> <p>You can create a <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html\">launch template</a>, which is a resource that contains the parameters to launch an instance. When you launch an instance using <a>RunInstances</a>, you can specify the launch template instead of specifying the launch parameters.</p> <p>To ensure faster instance launches, break up large requests into smaller batches. For example, create five separate launch requests for 100 instances each instead of one launch request for 500 instances.</p> <p>An instance is ready for you to use when it's in the <code>running</code> state. You can check the state of your instance using <a>DescribeInstances</a>. You can tag instances and EBS volumes during launch, after launch, or both. For more information, see <a>CreateTags</a> and <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html\">Tagging Your Amazon EC2 Resources</a>.</p> <p>Linux instances have access to the public key of the key pair at boot. You can use this key to provide secure access to the instance. Amazon EC2 public images use this feature to provide secure access without passwords. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html\">Key Pairs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>For troubleshooting, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_InstanceStraightToTerminated.html\">What To Do If An Instance Immediately Terminates</a>, and <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html\">Troubleshooting Connecting to Your Instance</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RunInstancesRequest :
sig
  type t =
    {
    block_device_mappings: BlockDeviceMappingRequestList.t ;
    image_id: String.t option ;
    instance_type: InstanceType.t option ;
    ipv6_address_count: Integer.t option ;
    ipv6_addresses: InstanceIpv6AddressList.t ;
    kernel_id: String.t option ;
    key_name: String.t option ;
    max_count: Integer.t ;
    min_count: Integer.t ;
    monitoring: RunInstancesMonitoringEnabled.t option ;
    placement: Placement.t option ;
    ramdisk_id: String.t option ;
    security_group_ids: SecurityGroupIdStringList.t ;
    security_groups: SecurityGroupStringList.t ;
    subnet_id: String.t option ;
    user_data: String.t option ;
    additional_info: String.t option ;
    client_token: String.t option ;
    disable_api_termination: Boolean.t option ;
    dry_run: Boolean.t option ;
    ebs_optimized: Boolean.t option ;
    iam_instance_profile: IamInstanceProfileSpecification.t option ;
    instance_initiated_shutdown_behavior: ShutdownBehavior.t option ;
    network_interfaces: InstanceNetworkInterfaceSpecificationList.t ;
    private_ip_address: String.t option ;
    elastic_gpu_specification: ElasticGpuSpecifications.t ;
    elastic_inference_accelerators: ElasticInferenceAccelerators.t ;
    tag_specifications: TagSpecificationList.t ;
    launch_template: LaunchTemplateSpecification.t option ;
    instance_market_options: InstanceMarketOptionsRequest.t option ;
    credit_specification: CreditSpecificationRequest.t option ;
    cpu_options: CpuOptionsRequest.t option ;
    capacity_reservation_specification:
      CapacityReservationSpecification.t option ;
    hibernation_options: HibernationOptionsRequest.t option ;
    license_specifications: LicenseSpecificationListRequest.t ;
    metadata_options: InstanceMetadataOptionsRequest.t option }
  val make :
    ?block_device_mappings:BlockDeviceMappingRequestList.t ->
      ?image_id:String.t ->
        ?instance_type:InstanceType.t ->
          ?ipv6_address_count:Integer.t ->
            ?ipv6_addresses:InstanceIpv6AddressList.t ->
              ?kernel_id:String.t ->
                ?key_name:String.t ->
                  max_count:Integer.t ->
                    min_count:Integer.t ->
                      ?monitoring:RunInstancesMonitoringEnabled.t ->
                        ?placement:Placement.t ->
                          ?ramdisk_id:String.t ->
                            ?security_group_ids:SecurityGroupIdStringList.t
                              ->
                              ?security_groups:SecurityGroupStringList.t ->
                                ?subnet_id:String.t ->
                                  ?user_data:String.t ->
                                    ?additional_info:String.t ->
                                      ?client_token:String.t ->
                                        ?disable_api_termination:Boolean.t ->
                                          ?dry_run:Boolean.t ->
                                            ?ebs_optimized:Boolean.t ->
                                              ?iam_instance_profile:IamInstanceProfileSpecification.t
                                                ->
                                                ?instance_initiated_shutdown_behavior:ShutdownBehavior.t
                                                  ->
                                                  ?network_interfaces:InstanceNetworkInterfaceSpecificationList.t
                                                    ->
                                                    ?private_ip_address:String.t
                                                      ->
                                                      ?elastic_gpu_specification:ElasticGpuSpecifications.t
                                                        ->
                                                        ?elastic_inference_accelerators:ElasticInferenceAccelerators.t
                                                          ->
                                                          ?tag_specifications:TagSpecificationList.t
                                                            ->
                                                            ?launch_template:LaunchTemplateSpecification.t
                                                              ->
                                                              ?instance_market_options:InstanceMarketOptionsRequest.t
                                                                ->
                                                                ?credit_specification:CreditSpecificationRequest.t
                                                                  ->
                                                                  ?cpu_options:CpuOptionsRequest.t
                                                                    ->
                                                                    ?capacity_reservation_specification:CapacityReservationSpecification.t
                                                                    ->
                                                                    ?hibernation_options:HibernationOptionsRequest.t
                                                                    ->
                                                                    ?license_specifications:LicenseSpecificationListRequest.t
                                                                    ->
                                                                    ?metadata_options:InstanceMetadataOptionsRequest.t
                                                                    ->
                                                                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Reservation = Reservation
type input = RunInstancesRequest.t
type output = Reservation.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error