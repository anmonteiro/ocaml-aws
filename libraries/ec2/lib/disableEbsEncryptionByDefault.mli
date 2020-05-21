(** "<p>Disables EBS encryption by default for your account in the current Region.</p> <p>After you disable encryption by default, you can still create encrypted volumes by enabling encryption when you create each volume.</p> <p>Disabling encryption by default does not change the encryption status of your existing volumes.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DisableEbsEncryptionByDefaultRequest :
sig
  type t = {
    dry_run: Boolean.t option }
  val make : ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DisableEbsEncryptionByDefaultResult =
DisableEbsEncryptionByDefaultResult
type input = DisableEbsEncryptionByDefaultRequest.t
type output = DisableEbsEncryptionByDefaultResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error