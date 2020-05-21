(** "<p>Returns all public keys whose private keys were used to sign the digest files within the specified time range. The public key is needed to validate digest files that were signed with its corresponding private key.</p> <note> <p>CloudTrail uses different private/public key pairs per region. Each digest file is signed with a private key unique to its region. Therefore, when you validate a digest file from a particular region, you must look in the same region for its corresponding public key.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListPublicKeysRequest :
sig
  type t =
    {
    start_time: DateTime.t option ;
    end_time: DateTime.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>Requests the public keys for a specified time range.</p>"]
  val make :
    ?start_time:DateTime.t ->
      ?end_time:DateTime.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListPublicKeysResponse = ListPublicKeysResponse
type input = ListPublicKeysRequest.t
type output = ListPublicKeysResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error