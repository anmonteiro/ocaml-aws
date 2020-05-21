(** "<p>Gets the value that Amazon Route 53 returns in response to a DNS request for a specified record name and type. You can optionally specify the IP address of a DNS resolver, an EDNS0 client subnet IP address, and a subnet mask. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module TestDNSAnswerRequest :
sig
  type t =
    {
    hosted_zone_id: String.t ;
    record_name: String.t ;
    record_type: RRType.t ;
    resolver_i_p: String.t option ;
    e_d_n_s0_client_subnet_i_p: String.t option ;
    e_d_n_s0_client_subnet_mask: String.t option }[@@ocaml.doc
                                                    "<p>Gets the value that Amazon Route 53 returns in response to a DNS request for a specified record name and type. You can optionally specify the IP address of a DNS resolver, an EDNS0 client subnet IP address, and a subnet mask. </p>"]
  val make :
    hosted_zone_id:String.t ->
      record_name:String.t ->
        record_type:RRType.t ->
          ?resolver_i_p:String.t ->
            ?e_d_n_s0_client_subnet_i_p:String.t ->
              ?e_d_n_s0_client_subnet_mask:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module TestDNSAnswerResponse = TestDNSAnswerResponse
type input = TestDNSAnswerRequest.t
type output = TestDNSAnswerResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error