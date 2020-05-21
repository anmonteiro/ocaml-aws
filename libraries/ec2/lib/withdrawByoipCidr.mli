(** "<p>Stops advertising an IPv4 address range that is provisioned as an address pool.</p> <p>You can perform this operation at most once every 10 seconds, even if you specify different address ranges each time.</p> <p>It can take a few minutes before traffic to the specified addresses stops routing to AWS because of BGP propagation delays.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module WithdrawByoipCidrRequest :
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
module WithdrawByoipCidrResult = WithdrawByoipCidrResult
type input = WithdrawByoipCidrRequest.t
type output = WithdrawByoipCidrResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error