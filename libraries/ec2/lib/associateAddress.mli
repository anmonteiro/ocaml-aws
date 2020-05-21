(** "<p>Associates an Elastic IP address with an instance or a network interface. Before you can use an Elastic IP address, you must allocate it to your account.</p> <p>An Elastic IP address is for use in either the EC2-Classic platform or in a VPC. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html\">Elastic IP Addresses</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>[EC2-Classic, VPC in an EC2-VPC-only account] If the Elastic IP address is already associated with a different instance, it is disassociated from that instance and associated with the specified instance. If you associate an Elastic IP address with an instance that has an existing Elastic IP address, the existing address is disassociated from the instance, but remains allocated to your account.</p> <p>[VPC in an EC2-Classic account] If you don't specify a private IP address, the Elastic IP address is associated with the primary IP address. If the Elastic IP address is already associated with a different instance or a network interface, you get an error unless you allow reassociation. You cannot associate an Elastic IP address with an instance or network interface that has an existing Elastic IP address.</p> <p>You cannot associate an Elastic IP address with an interface in a different network border group.</p> <important> <p>This is an idempotent operation. If you perform the operation more than once, Amazon EC2 doesn't return an error, and you may be charged for each time the Elastic IP address is remapped to the same instance. For more information, see the <i>Elastic IP Addresses</i> section of <a href=\"http://aws.amazon.com/ec2/pricing/\">Amazon EC2 Pricing</a>.</p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateAddressRequest :
sig
  type t =
    {
    allocation_id: String.t option ;
    instance_id: String.t option ;
    public_ip: String.t option ;
    allow_reassociation: Boolean.t option ;
    dry_run: Boolean.t option ;
    network_interface_id: String.t option ;
    private_ip_address: String.t option }
  val make :
    ?allocation_id:String.t ->
      ?instance_id:String.t ->
        ?public_ip:String.t ->
          ?allow_reassociation:Boolean.t ->
            ?dry_run:Boolean.t ->
              ?network_interface_id:String.t ->
                ?private_ip_address:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssociateAddressResult = AssociateAddressResult
type input = AssociateAddressRequest.t
type output = AssociateAddressResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error