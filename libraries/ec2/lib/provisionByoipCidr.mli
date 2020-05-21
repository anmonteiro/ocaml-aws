(** "<p>Provisions an address range for use with your AWS resources through bring your own IP addresses (BYOIP) and creates a corresponding address pool. After the address range is provisioned, it is ready to be advertised using <a>AdvertiseByoipCidr</a>.</p> <p>AWS verifies that you own the address range and are authorized to advertise it. You must ensure that the address range is registered to you and that you created an RPKI ROA to authorize Amazon ASNs 16509 and 14618 to advertise the address range. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html\">Bring Your Own IP Addresses (BYOIP)</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>Provisioning an address range is an asynchronous operation, so the call returns immediately, but the address range is not ready to use until its status changes from <code>pending-provision</code> to <code>provisioned</code>. To monitor the status of an address range, use <a>DescribeByoipCidrs</a>. To allocate an Elastic IP address from your address pool, use <a>AllocateAddress</a> with either the specific address from the address pool or the ID of the address pool.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ProvisionByoipCidrRequest :
sig
  type t =
    {
    cidr: String.t ;
    cidr_authorization_context: CidrAuthorizationContext.t option ;
    description: String.t option ;
    dry_run: Boolean.t option }
  val make :
    cidr:String.t ->
      ?cidr_authorization_context:CidrAuthorizationContext.t ->
        ?description:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ProvisionByoipCidrResult = ProvisionByoipCidrResult
type input = ProvisionByoipCidrRequest.t
type output = ProvisionByoipCidrResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error