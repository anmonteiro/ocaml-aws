(** "<p>Submits feedback about the status of an instance. The instance must be in the <code>running</code> state. If your experience with the instance differs from the instance status returned by <a>DescribeInstanceStatus</a>, use <a>ReportInstanceStatus</a> to report your experience with the instance. Amazon EC2 collects this information to improve the accuracy of status checks.</p> <p>Use of this action does not change the value returned by <a>DescribeInstanceStatus</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ReportInstanceStatusRequest :
sig
  type t =
    {
    description: String.t option ;
    dry_run: Boolean.t option ;
    end_time: DateTime.t option ;
    instances: InstanceIdStringList.t ;
    reason_codes: ReasonCodesList.t ;
    start_time: DateTime.t option ;
    status: ReportStatusType.t }
  val make :
    ?description:String.t ->
      ?dry_run:Boolean.t ->
        ?end_time:DateTime.t ->
          instances:InstanceIdStringList.t ->
            reason_codes:ReasonCodesList.t ->
              ?start_time:DateTime.t ->
                status:ReportStatusType.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ReportInstanceStatusRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error