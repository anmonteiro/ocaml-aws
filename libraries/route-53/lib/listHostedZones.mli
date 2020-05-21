(** "<p>Retrieves a list of the public and private hosted zones that are associated with the current AWS account. The response includes a <code>HostedZones</code> child element for each hosted zone.</p> <p>Amazon Route 53 returns a maximum of 100 items in each response. If you have a lot of hosted zones, you can use the <code>maxitems</code> parameter to list them in groups of up to 100.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListHostedZonesRequest :
sig
  type t =
    {
    marker: String.t option ;
    max_items: String.t option ;
    delegation_set_id: String.t option }[@@ocaml.doc
                                          "<p>A request to retrieve a list of the public and private hosted zones that are associated with the current AWS account.</p>"]
  val make :
    ?marker:String.t ->
      ?max_items:String.t -> ?delegation_set_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListHostedZonesResponse = ListHostedZonesResponse
type input = ListHostedZonesRequest.t
type output = ListHostedZonesResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error