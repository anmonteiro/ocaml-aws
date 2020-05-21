(** "<p>Returns some or all (up to 1,000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket. A 200 OK response can contain valid or invalid XML. Be sure to design your application to parse the contents of the response and handle it appropriately.</p> <important> <p>This API has been revised. We recommend that you use the newer version, <a>ListObjectsV2</a>, when developing applications. For backward compatibility, Amazon S3 continues to support <code>ListObjects</code>.</p> </important> <p>The following operations are related to <code>ListObjects</code>:</p> <ul> <li> <p> <a>ListObjectsV2</a> </p> </li> <li> <p> <a>GetObject</a> </p> </li> <li> <p> <a>PutObject</a> </p> </li> <li> <p> <a>CreateBucket</a> </p> </li> <li> <p> <a>ListBuckets</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListObjectsRequest :
sig
  type t =
    {
    bucket: String.t ;
    delimiter: String.t option ;
    encoding_type: EncodingType.t option ;
    marker: String.t option ;
    max_keys: Integer.t option ;
    prefix: String.t option ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      ?delimiter:String.t ->
        ?encoding_type:EncodingType.t ->
          ?marker:String.t ->
            ?max_keys:Integer.t ->
              ?prefix:String.t -> ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListObjectsOutput = ListObjectsOutput
type input = ListObjectsRequest.t
type output = ListObjectsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error