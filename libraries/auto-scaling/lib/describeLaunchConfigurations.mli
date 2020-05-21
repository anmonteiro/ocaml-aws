(** "<p>Describes one or more launch configurations.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module LaunchConfigurationNamesType :
sig
  type t =
    {
    launch_configuration_names: LaunchConfigurationNames.t ;
    next_token: String.t option ;
    max_records: Integer.t option }
  val make :
    ?launch_configuration_names:LaunchConfigurationNames.t ->
      ?next_token:String.t -> ?max_records:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module LaunchConfigurationsType = LaunchConfigurationsType
type input = LaunchConfigurationNamesType.t
type output = LaunchConfigurationsType.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error