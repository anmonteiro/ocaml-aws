(** "<p>Resets the specified attribute of the specified Amazon FPGA Image (AFI) to its default value. You can only reset the load permission attribute.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ResetFpgaImageAttributeRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    fpga_image_id: String.t ;
    attribute: ResetFpgaImageAttributeName.t option }
  val make :
    ?dry_run:Boolean.t ->
      fpga_image_id:String.t ->
        ?attribute:ResetFpgaImageAttributeName.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ResetFpgaImageAttributeResult = ResetFpgaImageAttributeResult
type input = ResetFpgaImageAttributeRequest.t
type output = ResetFpgaImageAttributeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error