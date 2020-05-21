(** "<p>Gets the specified limit for a specified hosted zone, for example, the maximum number of records that you can create in the hosted zone. </p> <p>For the default limit, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html\">Limits</a> in the <i>Amazon Route 53 Developer Guide</i>. To request a higher limit, <a href=\"https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&amp;limitType=service-code-route53\">open a case</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetHostedZoneLimitRequest :
sig
  type t = {
    type_: HostedZoneLimitType.t ;
    hosted_zone_id: String.t }[@@ocaml.doc
                                "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
  val make :
    type_:HostedZoneLimitType.t -> hosted_zone_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetHostedZoneLimitResponse = GetHostedZoneLimitResponse
type input = GetHostedZoneLimitRequest.t
type output = GetHostedZoneLimitResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error