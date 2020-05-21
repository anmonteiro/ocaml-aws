(** "<p>Advertises an IPv4 address range that is provisioned for use with your AWS resources through bring your own IP addresses (BYOIP).</p> <p>You can perform this operation at most once every 10 seconds, even if you specify different address ranges each time.</p> <p>We recommend that you stop advertising the BYOIP CIDR from other locations when you advertise it from AWS. To minimize down time, you can configure your AWS resources to use an address from a BYOIP CIDR before it is advertised, and then simultaneously stop advertising it from the current location and start advertising it through AWS.</p> <p>It can take a few minutes before traffic to the specified addresses starts routing to AWS because of BGP propagation delays.</p> <p>To stop advertising the BYOIP CIDR, use <a>WithdrawByoipCidr</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AdvertiseByoipCidrRequest :
sig
  type t = {
    cidr: String.t ;
    dry_run: Boolean.t option }
  val make : cidr:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AdvertiseByoipCidrResult = AdvertiseByoipCidrResult
type input = AdvertiseByoipCidrRequest.t
type output = AdvertiseByoipCidrResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error