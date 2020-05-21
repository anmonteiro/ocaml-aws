(** "<p>Stops a database activity stream that was started using the AWS console, the <code>start-activity-stream</code> AWS CLI command, or the <code>StartActivityStream</code> action.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.html\">Database Activity Streams</a> in the <i>Amazon Aurora User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StopActivityStreamRequest :
sig
  type t = {
    resource_arn: String.t ;
    apply_immediately: Boolean.t option }
  val make :
    resource_arn:String.t -> ?apply_immediately:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module StopActivityStreamResponse = StopActivityStreamResponse
type input = StopActivityStreamRequest.t
type output = StopActivityStreamResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error