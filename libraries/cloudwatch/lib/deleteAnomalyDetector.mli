(** "<p>Deletes the specified anomaly detection model from your account.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteAnomalyDetectorInput :
sig
  type t =
    {
    namespace: String.t ;
    metric_name: String.t ;
    dimensions: Dimensions.t ;
    stat: String.t }
  val make :
    namespace:String.t ->
      metric_name:String.t ->
        ?dimensions:Dimensions.t -> stat:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteAnomalyDetectorInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error