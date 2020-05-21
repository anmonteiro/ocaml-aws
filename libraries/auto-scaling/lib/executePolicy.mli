(** "<p>Executes the specified policy.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ExecutePolicyType :
sig
  type t =
    {
    auto_scaling_group_name: String.t option ;
    policy_name: String.t ;
    honor_cooldown: Boolean.t option ;
    metric_value: Double.t option ;
    breach_threshold: Double.t option }
  val make :
    ?auto_scaling_group_name:String.t ->
      policy_name:String.t ->
        ?honor_cooldown:Boolean.t ->
          ?metric_value:Double.t -> ?breach_threshold:Double.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ExecutePolicyType.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error