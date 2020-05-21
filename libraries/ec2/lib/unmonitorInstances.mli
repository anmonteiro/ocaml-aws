(** "<p>Disables detailed monitoring for a running instance. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch.html\">Monitoring Your Instances and Volumes</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UnmonitorInstancesRequest :
sig
  type t = {
    instance_ids: InstanceIdStringList.t ;
    dry_run: Boolean.t option }
  val make :
    instance_ids:InstanceIdStringList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module UnmonitorInstancesResult = UnmonitorInstancesResult
type input = UnmonitorInstancesRequest.t
type output = UnmonitorInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error