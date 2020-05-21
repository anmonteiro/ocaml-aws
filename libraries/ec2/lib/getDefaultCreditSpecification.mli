(** "<p>Describes the default credit option for CPU usage of a burstable performance instance family.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html\">Burstable Performance Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetDefaultCreditSpecificationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    instance_family: UnlimitedSupportedInstanceFamily.t }
  val make :
    ?dry_run:Boolean.t ->
      instance_family:UnlimitedSupportedInstanceFamily.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetDefaultCreditSpecificationResult =
GetDefaultCreditSpecificationResult
type input = GetDefaultCreditSpecificationRequest.t
type output = GetDefaultCreditSpecificationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error