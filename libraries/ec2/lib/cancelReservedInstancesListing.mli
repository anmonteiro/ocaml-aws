(** "<p>Cancels the specified Reserved Instance listing in the Reserved Instance Marketplace.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html\">Reserved Instance Marketplace</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CancelReservedInstancesListingRequest :
sig
  type t = {
    reserved_instances_listing_id: String.t }[@@ocaml.doc
                                               "<p>Contains the parameters for CancelReservedInstancesListing.</p>"]
  val make : reserved_instances_listing_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CancelReservedInstancesListingResult =
CancelReservedInstancesListingResult
type input = CancelReservedInstancesListingRequest.t
type output = CancelReservedInstancesListingResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error