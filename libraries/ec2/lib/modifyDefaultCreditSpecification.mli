(** "<p>Modifies the default credit option for CPU usage of burstable performance instances. The default credit option is set at the account level per AWS Region, and is specified per instance family. All new burstable performance instances in the account launch using the default credit option.</p> <p> <code>ModifyDefaultCreditSpecification</code> is an asynchronous operation, which works at an AWS Region level and modifies the credit option for each Availability Zone. All zones in a Region are updated within five minutes. But if instances are launched during this operation, they might not get the new credit option until the zone is updated. To verify whether the update has occurred, you can call <code>GetDefaultCreditSpecification</code> and check <code>DefaultCreditSpecification</code> for updates.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html\">Burstable Performance Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDefaultCreditSpecificationRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    instance_family: UnlimitedSupportedInstanceFamily.t ;
    cpu_credits: String.t }
  val make :
    ?dry_run:Boolean.t ->
      instance_family:UnlimitedSupportedInstanceFamily.t ->
        cpu_credits:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDefaultCreditSpecificationResult =
ModifyDefaultCreditSpecificationResult
type input = ModifyDefaultCreditSpecificationRequest.t
type output = ModifyDefaultCreditSpecificationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error