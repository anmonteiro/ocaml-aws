(** "<p>Describes the Amazon FPGA Images (AFIs) available to you. These include public AFIs, private AFIs that you own, and AFIs owned by other AWS accounts for which you have load permissions.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeFpgaImagesRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    fpga_image_ids: FpgaImageIdList.t ;
    owners: OwnerStringList.t ;
    filters: FilterList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?fpga_image_ids:FpgaImageIdList.t ->
        ?owners:OwnerStringList.t ->
          ?filters:FilterList.t ->
            ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeFpgaImagesResult = DescribeFpgaImagesResult
type input = DescribeFpgaImagesRequest.t
type output = DescribeFpgaImagesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error