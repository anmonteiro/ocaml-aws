(** "<p>Describes the policies for the specified Auto Scaling group.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribePoliciesType :
sig
  type t =
    {
    auto_scaling_group_name: String.t option ;
    policy_names: PolicyNames.t ;
    policy_types: PolicyTypes.t ;
    next_token: String.t option ;
    max_records: Integer.t option }
  val make :
    ?auto_scaling_group_name:String.t ->
      ?policy_names:PolicyNames.t ->
        ?policy_types:PolicyTypes.t ->
          ?next_token:String.t -> ?max_records:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module PoliciesType = PoliciesType
type input = DescribePoliciesType.t
type output = PoliciesType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error