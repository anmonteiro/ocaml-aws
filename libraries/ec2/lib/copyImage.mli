(** "<p>Initiates the copy of an AMI from the specified source Region to the current Region. You specify the destination Region by using its endpoint when making the request.</p> <p>Copies of encrypted backing snapshots for the AMI are encrypted. Copies of unencrypted backing snapshots remain unencrypted, unless you set <code>Encrypted</code> during the copy operation. You cannot create an unencrypted copy of an encrypted backing snapshot.</p> <p>For more information about the prerequisites and limits when copying an AMI, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/CopyingAMIs.html\">Copying an AMI</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CopyImageRequest :
sig
  type t =
    {
    client_token: String.t option ;
    description: String.t option ;
    encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    name: String.t ;
    source_image_id: String.t ;
    source_region: String.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for CopyImage.</p>"]
  val make :
    ?client_token:String.t ->
      ?description:String.t ->
        ?encrypted:Boolean.t ->
          ?kms_key_id:String.t ->
            name:String.t ->
              source_image_id:String.t ->
                source_region:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CopyImageResult = CopyImageResult
type input = CopyImageRequest.t
type output = CopyImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error