(** "<p>Changes the default customer master key (CMK) for EBS encryption by default for your account in this Region.</p> <p>AWS creates a unique AWS managed CMK in each Region for use with encryption by default. If you change the default CMK to a symmetric customer managed CMK, it is used instead of the AWS managed CMK. To reset the default CMK to the AWS managed CMK for EBS, use <a>ResetEbsDefaultKmsKeyId</a>. Amazon EBS does not support asymmetric CMKs.</p> <p>If you delete or disable the customer managed CMK that you specified for use with encryption by default, your instances will fail to launch.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyEbsDefaultKmsKeyIdRequest :
sig
  type t = {
    kms_key_id: String.t ;
    dry_run: Boolean.t option }
  val make : kms_key_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyEbsDefaultKmsKeyIdResult = ModifyEbsDefaultKmsKeyIdResult
type input = ModifyEbsDefaultKmsKeyIdRequest.t
type output = ModifyEbsDefaultKmsKeyIdResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error