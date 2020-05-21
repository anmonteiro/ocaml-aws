(** "<p>Places an Object Lock configuration on the specified bucket. The rule specified in the Object Lock configuration will be applied by default to every new object placed in the specified bucket.</p> <note> <p> <code>DefaultRetention</code> requires either Days or Years. You can't specify both at the same time.</p> </note> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lock.html\">Locking Objects</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutObjectLockConfigurationRequest :
sig
  type t =
    {
    bucket: String.t ;
    object_lock_configuration: ObjectLockConfiguration.t option ;
    request_payer: RequestPayer.t option ;
    token: String.t option ;
    content_m_d5: String.t option }
  val make :
    bucket:String.t ->
      ?object_lock_configuration:ObjectLockConfiguration.t ->
        ?request_payer:RequestPayer.t ->
          ?token:String.t -> ?content_m_d5:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PutObjectLockConfigurationOutput = PutObjectLockConfigurationOutput
type input = PutObjectLockConfigurationRequest.t
type output = PutObjectLockConfigurationOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error