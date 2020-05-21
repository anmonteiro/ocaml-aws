(** "<p>Creates an Amazon FPGA Image (AFI) from the specified design checkpoint (DCP).</p> <p>The create operation is asynchronous. To verify that the AFI is ready for use, check the output logs.</p> <p>An AFI contains the FPGA bitstream that is ready to download to an FPGA. You can securely deploy an AFI on multiple FPGA-accelerated instances. For more information, see the <a href=\"https://github.com/aws/aws-fpga/\">AWS FPGA Hardware Development Kit</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateFpgaImageRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    input_storage_location: StorageLocation.t ;
    logs_storage_location: StorageLocation.t option ;
    description: String.t option ;
    name: String.t option ;
    client_token: String.t option ;
    tag_specifications: TagSpecificationList.t }
  val make :
    ?dry_run:Boolean.t ->
      input_storage_location:StorageLocation.t ->
        ?logs_storage_location:StorageLocation.t ->
          ?description:String.t ->
            ?name:String.t ->
              ?client_token:String.t ->
                ?tag_specifications:TagSpecificationList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateFpgaImageResult = CreateFpgaImageResult
type input = CreateFpgaImageRequest.t
type output = CreateFpgaImageResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error