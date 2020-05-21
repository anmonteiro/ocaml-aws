(** "<p>Returns metadata about all of the versions of objects in a bucket. You can also use request parameters as selection criteria to return metadata about a subset of all the object versions. </p> <note> <p> A 200 OK response can contain valid or invalid XML. Make sure to design your application to parse the contents of the response and handle it appropriately.</p> </note> <p>To use this operation, you must have READ access to the bucket.</p> <p>The following operations are related to <code>ListObjectVersions</code>:</p> <ul> <li> <p> <a>ListObjectsV2</a> </p> </li> <li> <p> <a>GetObject</a> </p> </li> <li> <p> <a>PutObject</a> </p> </li> <li> <p> <a>DeleteObject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListObjectVersionsRequest :
sig
  type t =
    {
    bucket: String.t ;
    delimiter: String.t option ;
    encoding_type: EncodingType.t option ;
    key_marker: String.t option ;
    max_keys: Integer.t option ;
    prefix: String.t option ;
    version_id_marker: String.t option }
  val make :
    bucket:String.t ->
      ?delimiter:String.t ->
        ?encoding_type:EncodingType.t ->
          ?key_marker:String.t ->
            ?max_keys:Integer.t ->
              ?prefix:String.t -> ?version_id_marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListObjectVersionsOutput = ListObjectVersionsOutput
type input = ListObjectVersionsRequest.t
type output = ListObjectVersionsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error