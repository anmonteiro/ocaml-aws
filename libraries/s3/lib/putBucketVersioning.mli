(** "<p>Sets the versioning state of an existing bucket. To set the versioning state, you must be the bucket owner.</p> <p>You can set the versioning state with one of the following values:</p> <p> <b>Enabled</b>\226\128\148Enables versioning for the objects in the bucket. All objects added to the bucket receive a unique version ID.</p> <p> <b>Suspended</b>\226\128\148Disables versioning for the objects in the bucket. All objects added to the bucket receive the version ID null.</p> <p>If the versioning state has never been set on a bucket, it has no versioning state; a <a>GetBucketVersioning</a> request does not return a versioning state value.</p> <p>If the bucket owner enables MFA Delete in the bucket versioning configuration, the bucket owner must include the <code>x-amz-mfa request</code> header and the <code>Status</code> and the <code>MfaDelete</code> request elements in a request to set the versioning state of the bucket.</p> <important> <p>If you have an object expiration lifecycle policy in your non-versioned bucket and you want to maintain the same permanent delete behavior when you enable versioning, you must add a noncurrent expiration policy. The noncurrent expiration lifecycle policy will manage the deletes of the noncurrent object versions in the version-enabled bucket. (A version-enabled bucket maintains one current and zero or more noncurrent object versions.) For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html#lifecycle-and-other-bucket-config\">Lifecycle and Versioning</a>.</p> </important> <p class=\"title\"> <b>Related Resources</b> </p> <ul> <li> <p> <a>CreateBucket</a> </p> </li> <li> <p> <a>DeleteBucket</a> </p> </li> <li> <p> <a>GetBucketVersioning</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketVersioningRequest :
sig
  type t =
    {
    bucket: String.t ;
    content_m_d5: String.t option ;
    m_f_a: String.t option ;
    versioning_configuration: VersioningConfiguration.t }
  val make :
    bucket:String.t ->
      ?content_m_d5:String.t ->
        ?m_f_a:String.t ->
          versioning_configuration:VersioningConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketVersioningRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error