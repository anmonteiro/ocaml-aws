(** "<p>Describes one or more scaling activities for the specified Auto Scaling group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeScalingActivitiesType :
sig
  type t =
    {
    activity_ids: ActivityIds.t ;
    auto_scaling_group_name: String.t option ;
    max_records: Integer.t option ;
    next_token: String.t option }
  val make :
    ?activity_ids:ActivityIds.t ->
      ?auto_scaling_group_name:String.t ->
        ?max_records:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ActivitiesType = ActivitiesType
type input = DescribeScalingActivitiesType.t
type output = ActivitiesType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error