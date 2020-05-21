(** "<p>Lists the configurations for DNS query logging that are associated with the current AWS account or the configuration that is associated with a specified hosted zone.</p> <p>For more information about DNS query logs, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateQueryLoggingConfig.html\">CreateQueryLoggingConfig</a>. Additional information, including the format of DNS query logs, appears in <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html\">Logging DNS Queries</a> in the <i>Amazon Route 53 Developer Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListQueryLoggingConfigsRequest :
sig
  type t =
    {
    hosted_zone_id: String.t option ;
    next_token: String.t option ;
    max_results: String.t option }
  val make :
    ?hosted_zone_id:String.t ->
      ?next_token:String.t -> ?max_results:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListQueryLoggingConfigsResponse = ListQueryLoggingConfigsResponse
type input = ListQueryLoggingConfigsRequest.t
type output = ListQueryLoggingConfigsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error