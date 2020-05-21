(** "<p>Describes the IP address ranges that were specified in calls to <a>ProvisionByoipCidr</a>.</p> <p>To describe the address pools that were created when you provisioned the address ranges, use <a>DescribePublicIpv4Pools</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeByoipCidrsRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    max_results: Integer.t ;
    next_token: String.t option }
  val make :
    ?dry_run:Boolean.t ->
      max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeByoipCidrsResult = DescribeByoipCidrsResult
type input = DescribeByoipCidrsRequest.t
type output = DescribeByoipCidrsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error