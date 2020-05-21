(** "<p>Places an Object Retention configuration on an object.</p> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\">Locking Objects</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutObjectRetentionRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    retention: ObjectLockRetention.t option ;
    request_payer: RequestPayer.t option ;
    version_id: String.t option ;
    bypass_governance_retention: Boolean.t option ;
    content_m_d5: String.t option }
  val make :
    bucket:String.t ->
      key:String.t ->
        ?retention:ObjectLockRetention.t ->
          ?request_payer:RequestPayer.t ->
            ?version_id:String.t ->
              ?bypass_governance_retention:Boolean.t ->
                ?content_m_d5:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PutObjectRetentionOutput = PutObjectRetentionOutput
type input = PutObjectRetentionRequest.t
type output = PutObjectRetentionOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error