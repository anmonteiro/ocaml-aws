(** "<p>Deletes the specified route from the specified route table.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteRouteRequest :
sig
  type t =
    {
    destination_cidr_block: String.t option ;
    destination_ipv6_cidr_block: String.t option ;
    dry_run: Boolean.t option ;
    route_table_id: String.t }
  val make :
    ?destination_cidr_block:String.t ->
      ?destination_ipv6_cidr_block:String.t ->
        ?dry_run:Boolean.t -> route_table_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteRouteRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error