(** "<p>Starts a database activity stream to monitor activity on the database. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/DBActivityStreams.html\">Database Activity Streams</a> in the <i>Amazon Aurora User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StartActivityStreamRequest :
sig
  type t =
    {
    resource_arn: String.t ;
    mode: ActivityStreamMode.t ;
    kms_key_id: String.t ;
    apply_immediately: Boolean.t option }
  val make :
    resource_arn:String.t ->
      mode:ActivityStreamMode.t ->
        kms_key_id:String.t -> ?apply_immediately:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module StartActivityStreamResponse = StartActivityStreamResponse
type input = StartActivityStreamRequest.t
type output = StartActivityStreamResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error