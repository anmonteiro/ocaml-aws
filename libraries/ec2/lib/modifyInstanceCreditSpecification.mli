(** "<p>Modifies the credit option for CPU usage on a running or stopped burstable performance instance. The credit options are <code>standard</code> and <code>unlimited</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html\">Burstable Performance Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyInstanceCreditSpecificationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    client_token: String.t option ;
    instance_credit_specifications: InstanceCreditSpecificationListRequest.t }
  val make :
    ?dry_run:Boolean.t ->
      ?client_token:String.t ->
        instance_credit_specifications:InstanceCreditSpecificationListRequest.t
          -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyInstanceCreditSpecificationResult =
ModifyInstanceCreditSpecificationResult
type input = ModifyInstanceCreditSpecificationRequest.t
type output = ModifyInstanceCreditSpecificationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error