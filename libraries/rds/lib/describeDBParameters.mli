(** "<p>Returns the detailed parameter list for a particular DB parameter group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBParametersMessage :
sig
  type t =
    {
    d_b_parameter_group_name: String.t ;
    source: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }
  val make :
    d_b_parameter_group_name:String.t ->
      ?source:String.t ->
        ?filters:FilterList.t ->
          ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBParameterGroupDetails = DBParameterGroupDetails
type input = DescribeDBParametersMessage.t
type output = DBParameterGroupDetails.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error