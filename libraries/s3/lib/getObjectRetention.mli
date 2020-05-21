(** "<p>Retrieves an object's retention settings. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\">Locking Objects</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetObjectRetentionRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    version_id: String.t option ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      key:String.t ->
        ?version_id:String.t -> ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetObjectRetentionOutput = GetObjectRetentionOutput
type input = GetObjectRetentionRequest.t
type output = GetObjectRetentionOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error