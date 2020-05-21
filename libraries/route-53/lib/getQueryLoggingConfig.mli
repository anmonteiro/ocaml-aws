(** "<p>Gets information about a specified configuration for DNS query logging.</p> <p>For more information about DNS query logs, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateQueryLoggingConfig.html\">CreateQueryLoggingConfig</a> and <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html\">Logging DNS Queries</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetQueryLoggingConfigRequest :
sig
  type t = {
    id: String.t }
  val make : id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetQueryLoggingConfigResponse = GetQueryLoggingConfigResponse
type input = GetQueryLoggingConfigRequest.t
type output = GetQueryLoggingConfigResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error