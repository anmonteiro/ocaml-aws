(** "<p>Returns details of the service updates</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeServiceUpdatesMessage :
sig
  type t =
    {
    service_update_name: String.t option ;
    service_update_status: ServiceUpdateStatusList.t ;
    max_records: Integer.t option ;
    marker: String.t option }
  val make :
    ?service_update_name:String.t ->
      ?service_update_status:ServiceUpdateStatusList.t ->
        ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ServiceUpdatesMessage = ServiceUpdatesMessage
type input = DescribeServiceUpdatesMessage.t
type output = ServiceUpdatesMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error