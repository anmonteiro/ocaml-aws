(** "<p>Describes the specified attribute of the specified Amazon FPGA Image (AFI).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeFpgaImageAttributeRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    fpga_image_id: String.t ;
    attribute: FpgaImageAttributeName.t }
  val make :
    ?dry_run:Boolean.t ->
      fpga_image_id:String.t ->
        attribute:FpgaImageAttributeName.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeFpgaImageAttributeResult = DescribeFpgaImageAttributeResult
type input = DescribeFpgaImageAttributeRequest.t
type output = DescribeFpgaImageAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error