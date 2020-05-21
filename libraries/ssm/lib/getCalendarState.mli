(** "<p>Gets the state of the AWS Systems Manager Change Calendar at an optional, specified time. If you specify a time, <code>GetCalendarState</code> returns the state of the calendar at a specific time, and returns the next time that the Change Calendar state will transition. If you do not specify a time, <code>GetCalendarState</code> assumes the current time. Change Calendar entries have two possible states: <code>OPEN</code> or <code>CLOSED</code>. For more information about Systems Manager Change Calendar, see <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar.html\">AWS Systems Manager Change Calendar</a> in the <i>AWS Systems Manager User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetCalendarStateRequest :
sig
  type t =
    {
    calendar_names: CalendarNameOrARNList.t ;
    at_time: String.t option }
  val make :
    calendar_names:CalendarNameOrARNList.t -> ?at_time:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetCalendarStateResponse = GetCalendarStateResponse
type input = GetCalendarStateRequest.t
type output = GetCalendarStateResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error