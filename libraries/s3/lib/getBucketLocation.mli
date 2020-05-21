(** "<p>Returns the Region the bucket resides in. You set the bucket's Region using the <code>LocationConstraint</code> request parameter in a <code>CreateBucket</code> request. For more information, see <a>CreateBucket</a>.</p> <p> To use this implementation of the operation, you must be the bucket owner.</p> <p>The following operations are related to <code>GetBucketLocation</code>:</p> <ul> <li> <p> <a>GetObject</a> </p> </li> <li> <p> <a>CreateBucket</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketLocationRequest :
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
module GetBucketLocationOutput = GetBucketLocationOutput
type input = GetBucketLocationRequest.t
type output = GetBucketLocationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error