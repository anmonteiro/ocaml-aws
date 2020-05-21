(** "<p>Describes one or more of your network interfaces.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeNetworkInterfacesRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    network_interface_ids: NetworkInterfaceIdList.t ;
    next_token: String.t option ;
    max_results: Integer.t option }[@@ocaml.doc
                                     "<p>Contains the parameters for DescribeNetworkInterfaces.</p>"]
  val make :
    ?filters:FilterList.t ->
      ?dry_run:Boolean.t ->
        ?network_interface_ids:NetworkInterfaceIdList.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeNetworkInterfacesResult = DescribeNetworkInterfacesResult
type input = DescribeNetworkInterfacesRequest.t
type output = DescribeNetworkInterfacesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error