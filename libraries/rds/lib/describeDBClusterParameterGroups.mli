(** "<p> Returns a list of <code>DBClusterParameterGroup</code> descriptions. If a <code>DBClusterParameterGroupName</code> parameter is specified, the list will contain only the description of the specified DB cluster parameter group. </p> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDBClusterParameterGroupsMessage :
sig
  type t =
    {
    d_b_cluster_parameter_group_name: String.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?d_b_cluster_parameter_group_name:String.t ->
      ?filters:FilterList.t ->
        ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBClusterParameterGroupsMessage = DBClusterParameterGroupsMessage
type input = DescribeDBClusterParameterGroupsMessage.t
type output = DBClusterParameterGroupsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error