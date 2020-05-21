open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetCalendarStateRequest =
  struct
    type t =
      {
      calendar_names: CalendarNameOrARNList.t
        [@ocaml.doc
          "<p>The names or Amazon Resource Names (ARNs) of the Systems Manager documents that represent the calendar entries for which you want to get the state.</p>"];
      at_time: String.t option
        [@ocaml.doc
          "<p>(Optional) The specific time for which you want to get calendar state information, in <a href=\"https://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a> format. If you do not add <code>AtTime</code>, the current time is assumed.</p>"]}
    let make ~calendar_names  ?at_time  () = { calendar_names; at_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.at_time
              (fun f -> ("at_time", (String.to_json f)));
           Some
             ("calendar_names",
               (CalendarNameOrARNList.to_json v.calendar_names))])
    let of_json j =
      {
        calendar_names =
          (CalendarNameOrARNList.of_json
             (Util.of_option_exn (Json.lookup j "calendar_names")));
        at_time = (Util.option_map (Json.lookup j "at_time") String.of_json)
      }
  end
module GetCalendarStateResponse = GetCalendarStateResponse
type input = GetCalendarStateRequest.t
type output = GetCalendarStateResponse.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetCalendarStateRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetCalendarStateRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetCalendarStateResponse.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None