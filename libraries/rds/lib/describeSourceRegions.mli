(** "<p>Returns a list of the source AWS Regions where the current AWS Region can create a Read Replica or copy a DB snapshot from. This API action supports pagination.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeSourceRegionsMessage :
sig
  type t =
    {
    region_name: String.t option ;
    max_records: Integer.t option ;
    marker: String.t option ;
    filters: FilterList.t }[@@ocaml.doc "<p/>"]
  val make :
    ?region_name:String.t ->
      ?max_records:Integer.t ->
        ?marker:String.t -> ?filters:FilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module SourceRegionMessage = SourceRegionMessage
type input = DescribeSourceRegionsMessage.t
type output = SourceRegionMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error