(** "<p>Creates a new maintenance window.</p> <note> <p>The value you specify for <code>Duration</code> determines the specific end time for the maintenance window based on the time it begins. No maintenance window tasks are permitted to start after the resulting endtime minus the number of hours you specify for <code>Cutoff</code>. For example, if the maintenance window starts at 3 PM, the duration is three hours, and the value you specify for <code>Cutoff</code> is one hour, no maintenance window tasks can start after 5 PM.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateMaintenanceWindowRequest :
sig
  type t =
    {
    name: String.t ;
    description: String.t option ;
    start_date: String.t option ;
    end_date: String.t option ;
    schedule: String.t ;
    schedule_timezone: String.t option ;
    duration: Integer.t ;
    cutoff: Integer.t ;
    allow_unassociated_targets: Boolean.t ;
    client_token: String.t option ;
    tags: TagList.t }
  val make :
    name:String.t ->
      ?description:String.t ->
        ?start_date:String.t ->
          ?end_date:String.t ->
            schedule:String.t ->
              ?schedule_timezone:String.t ->
                duration:Integer.t ->
                  cutoff:Integer.t ->
                    allow_unassociated_targets:Boolean.t ->
                      ?client_token:String.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module CreateMaintenanceWindowResult = CreateMaintenanceWindowResult
type input = CreateMaintenanceWindowRequest.t
type output = CreateMaintenanceWindowResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error