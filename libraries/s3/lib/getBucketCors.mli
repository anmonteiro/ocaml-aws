(** "<p>Returns the cors configuration information set for the bucket.</p> <p> To use this operation, you must have permission to perform the s3:GetBucketCORS action. By default, the bucket owner has this permission and can grant it to others.</p> <p> For more information about cors, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/cors.html\"> Enabling Cross-Origin Resource Sharing</a>.</p> <p>The following operations are related to <code>GetBucketCors</code>:</p> <ul> <li> <p> <a>PutBucketCors</a> </p> </li> <li> <p> <a>DeleteBucketCors</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketCorsRequest :
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
module GetBucketCorsOutput = GetBucketCorsOutput
type input = GetBucketCorsRequest.t
type output = GetBucketCorsOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error