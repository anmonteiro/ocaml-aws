(** "<p> Modifies the parameters of a DB cluster parameter group to the default value. To reset specific parameters submit a list of the following: <code>ParameterName</code> and <code>ApplyMethod</code>. To reset the entire DB cluster parameter group, specify the <code>DBClusterParameterGroupName</code> and <code>ResetAllParameters</code> parameters. </p> <p> When resetting the entire group, dynamic parameters are updated immediately and static parameters are set to <code>pending-reboot</code> to take effect on the next DB instance restart or <code>RebootDBInstance</code> request. You must call <code>RebootDBInstance</code> for every DB instance in your DB cluster that you want the updated static parameter to apply to.</p> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ResetDBClusterParameterGroupMessage :
sig
  type t =
    {
    d_b_cluster_parameter_group_name: String.t ;
    reset_all_parameters: Boolean.t option ;
    parameters: ParametersList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_parameter_group_name:String.t ->
      ?reset_all_parameters:Boolean.t ->
        ?parameters:ParametersList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBClusterParameterGroupNameMessage =
DBClusterParameterGroupNameMessage
type input = ResetDBClusterParameterGroupMessage.t
type output = DBClusterParameterGroupNameMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error