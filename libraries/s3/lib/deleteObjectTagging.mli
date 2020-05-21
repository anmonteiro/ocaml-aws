(** "<p>Removes the entire tag set from the specified object. For more information about managing object tags, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html\"> Object Tagging</a>.</p> <p>To use this operation, you must have permission to perform the <code>s3:DeleteObjectTagging</code> action.</p> <p>To delete tags of a specific object version, add the <code>versionId</code> query parameter in the request. You will need permission for the <code>s3:DeleteObjectVersionTagging</code> action.</p> <p>The following operations are related to <code>DeleteBucketMetricsConfiguration</code>:</p> <ul> <li> <p> <a>PutObjectTagging</a> </p> </li> <li> <p> <a>GetObjectTagging</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteObjectTaggingRequest :
sig
  type t = {
    bucket: String.t ;
    key: String.t ;
    version_id: String.t option }
  val make :
    bucket:String.t -> key:String.t -> ?version_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DeleteObjectTaggingOutput = DeleteObjectTaggingOutput
type input = DeleteObjectTaggingRequest.t
type output = DeleteObjectTaggingOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error