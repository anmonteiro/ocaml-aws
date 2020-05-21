(** "<p>Registers an AMI. When you're creating an AMI, this is the final step you must complete before you can launch an instance from the AMI. For more information about creating AMIs, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami.html\">Creating Your Own AMIs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <note> <p>For Amazon EBS-backed instances, <a>CreateImage</a> creates and registers the AMI in a single request, so you don't have to register the AMI yourself.</p> </note> <p>You can also use <code>RegisterImage</code> to create an Amazon EBS-backed Linux AMI from a snapshot of a root device volume. You specify the snapshot using the block device mapping. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-launch-snapshot.html\">Launching a Linux Instance from a Backup</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>You can't register an image where a secondary (non-root) snapshot has AWS Marketplace product codes.</p> <p>Windows and some Linux distributions, such as Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES), use the EC2 billing product code associated with an AMI to verify the subscription status for package updates. To create a new AMI for operating systems that require a billing product code, do the following:</p> <ol> <li> <p>Launch an instance from an existing AMI with that billing product code.</p> </li> <li> <p>Customize the instance.</p> </li> <li> <p>Create a new AMI from the instance using <a>CreateImage</a> to preserve the billing product code association.</p> </li> </ol> <p>If you purchase a Reserved Instance to apply to an On-Demand Instance that was launched from an AMI with a billing product code, make sure that the Reserved Instance has the matching billing product code. If you purchase a Reserved Instance without the matching billing product code, the Reserved Instance will not be applied to the On-Demand Instance. </p> <p>If needed, you can deregister an AMI at any time. Any modifications you make to an AMI backed by an instance store volume invalidates its registration. If you make changes to an image, deregister the previous image and register the new image.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RegisterImageRequest :
sig
  type t =
    {
    image_location: String.t option ;
    architecture: ArchitectureValues.t option ;
    block_device_mappings: BlockDeviceMappingRequestList.t ;
    description: String.t option ;
    dry_run: Boolean.t option ;
    ena_support: Boolean.t option ;
    kernel_id: String.t option ;
    name: String.t ;
    billing_products: BillingProductList.t ;
    ramdisk_id: String.t option ;
    root_device_name: String.t option ;
    sriov_net_support: String.t option ;
    virtualization_type: String.t option }[@@ocaml.doc
                                            "<p>Contains the parameters for RegisterImage.</p>"]
  val make :
    ?image_location:String.t ->
      ?architecture:ArchitectureValues.t ->
        ?block_device_mappings:BlockDeviceMappingRequestList.t ->
          ?description:String.t ->
            ?dry_run:Boolean.t ->
              ?ena_support:Boolean.t ->
                ?kernel_id:String.t ->
                  name:String.t ->
                    ?billing_products:BillingProductList.t ->
                      ?ramdisk_id:String.t ->
                        ?root_device_name:String.t ->
                          ?sriov_net_support:String.t ->
                            ?virtualization_type:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RegisterImageResult = RegisterImageResult
type input = RegisterImageRequest.t
type output = RegisterImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error