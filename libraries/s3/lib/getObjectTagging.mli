(** "<p>Returns the tag-set of an object. You send the GET request against the tagging subresource associated with the object.</p> <p>To use this operation, you must have permission to perform the <code>s3:GetObjectTagging</code> action. By default, the GET operation returns information about current version of an object. For a versioned bucket, you can have multiple versions of an object in your bucket. To retrieve tags of any other version, use the versionId query parameter. You also need permission for the <code>s3:GetObjectVersionTagging</code> action.</p> <p> By default, the bucket owner has this permission and can grant this permission to others.</p> <p> For information about the Amazon S3 object tagging feature, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-tagging.html\">Object Tagging</a>.</p> <p>The following operation is related to <code>GetObjectTagging</code>:</p> <ul> <li> <p> <a>PutObjectTagging</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetObjectTaggingRequest :
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
module GetObjectTaggingOutput = GetObjectTaggingOutput
type input = GetObjectTaggingRequest.t
type output = GetObjectTaggingOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error