(** "<p>Sets the request payment configuration for a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html\">Requester Pays Buckets</a>.</p> <p>The following operations are related to <code>PutBucketRequestPayment</code>:</p> <ul> <li> <p> <a>CreateBucket</a> </p> </li> <li> <p> <a>GetBucketRequestPayment</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketRequestPaymentRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    request_payment_configuration: RequestPaymentConfiguration.t }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t ->
        request_payment_configuration:RequestPaymentConfiguration.t ->
          unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketRequestPaymentRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error