(** "<p>Gets the specified limit for the current account, for example, the maximum number of health checks that you can create using the account.</p> <p>For the default limit, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html\">Limits</a> in the <i>Amazon Route 53 Developer Guide</i>. To request a higher limit, <a href=\"https://console.aws.amazon.com/support/home#/case/create?issueType=service-limit-increase&amp;limitType=service-code-route53\">open a case</a>.</p> <note> <p>You can also view account limits in AWS Trusted Advisor. Sign in to the AWS Management Console and open the Trusted Advisor console at <a href=\"https://console.aws.amazon.com/trustedadvisor\">https://console.aws.amazon.com/trustedadvisor/</a>. Then choose <b>Service limits</b> in the navigation pane.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetAccountLimitRequest :
sig
  type t = {
    type_: AccountLimitType.t }[@@ocaml.doc
                                 "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
  val make : type_:AccountLimitType.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetAccountLimitResponse = GetAccountLimitResponse
type input = GetAccountLimitRequest.t
type output = GetAccountLimitResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error