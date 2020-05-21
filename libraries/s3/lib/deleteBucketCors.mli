(** "<p>Deletes the <code>cors</code> configuration information set for the bucket.</p> <p>To use this operation, you must have permission to perform the <code>s3:PutBucketCORS</code> action. The bucket owner has this permission by default and can grant this permission to others. </p> <p>For information about <code>cors</code>, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\">Enabling Cross-Origin Resource Sharing</a> in the <i>Amazon Simple Storage Service Developer Guide</i>.</p> <p class=\"title\"> <b>Related Resources:</b> </p> <ul> <li> <p> </p> </li> <li> <p> <a>RESTOPTIONSobject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteBucketCorsRequest :
sig
  type t = {
    bucket: String.t }
  val make : bucket:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteBucketCorsRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error