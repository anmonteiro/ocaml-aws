(** "<p>Returns the request payment configuration of a bucket. To use this version of the operation, you must be the bucket owner. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html\">Requester Pays Buckets</a>.</p> <p>The following operations are related to <code>GetBucketRequestPayment</code>:</p> <ul> <li> <p> <a>ListObjects</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketRequestPaymentRequest :
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
module GetBucketRequestPaymentOutput = GetBucketRequestPaymentOutput
type input = GetBucketRequestPaymentRequest.t
type output = GetBucketRequestPaymentOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error