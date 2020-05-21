(** "<p>Modifies the parameters of a DB parameter group to the engine/system default value. To reset specific parameters, provide a list of the following: <code>ParameterName</code> and <code>ApplyMethod</code>. To reset the entire DB parameter group, specify the <code>DBParameterGroup</code> name and <code>ResetAllParameters</code> parameters. When resetting the entire group, dynamic parameters are updated immediately and static parameters are set to <code>pending-reboot</code> to take effect on the next DB instance restart or <code>RebootDBInstance</code> request. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ResetDBParameterGroupMessage :
sig
  type t =
    {
    d_b_parameter_group_name: String.t ;
    reset_all_parameters: Boolean.t option ;
    parameters: ParametersList.t }[@@ocaml.doc "<p/>"]
  val make :
    d_b_parameter_group_name:String.t ->
      ?reset_all_parameters:Boolean.t ->
        ?parameters:ParametersList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DBParameterGroupNameMessage = DBParameterGroupNameMessage
type input = ResetDBParameterGroupMessage.t
type output = DBParameterGroupNameMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error