open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateMaintenanceWindowRequest =
  struct
    type t =
      {
      window_id: String.t
        [@ocaml.doc "<p>The ID of the maintenance window to update.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the maintenance window.</p>"];
      description: String.t option
        [@ocaml.doc "<p>An optional description for the update request.</p>"];
      start_date: String.t option
        [@ocaml.doc
          "<p>The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. For example: \"America/Los_Angeles\", \"etc/UTC\", or \"Asia/Seoul\". For more information, see the <a href=\"https://www.iana.org/time-zones\">Time Zone Database</a> on the IANA website.</p>"];
      end_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when you want the maintenance window to become inactive. EndDate allows you to set a date and time in the future when the maintenance window will no longer run.</p>"];
      schedule: String.t option
        [@ocaml.doc
          "<p>The schedule of the maintenance window in the form of a cron or rate expression.</p>"];
      schedule_timezone: String.t option
        [@ocaml.doc
          "<p>The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. For example: \"America/Los_Angeles\", \"etc/UTC\", or \"Asia/Seoul\". For more information, see the <a href=\"https://www.iana.org/time-zones\">Time Zone Database</a> on the IANA website.</p>"];
      duration: Integer.t option
        [@ocaml.doc
          "<p>The duration of the maintenance window in hours.</p>"];
      cutoff: Integer.t option
        [@ocaml.doc
          "<p>The number of hours before the end of the maintenance window that Systems Manager stops scheduling new tasks for execution.</p>"];
      allow_unassociated_targets: Boolean.t option
        [@ocaml.doc
          "<p>Whether targets must be registered with the maintenance window before tasks can be defined for those targets.</p>"];
      enabled: Boolean.t option
        [@ocaml.doc "<p>Whether the maintenance window is enabled.</p>"];
      replace: Boolean.t option
        [@ocaml.doc
          "<p>If True, then all fields that are required by the CreateMaintenanceWindow action are also required for this API request. Optional fields that are not specified are set to null. </p>"]}
    let make ~window_id  ?name  ?description  ?start_date  ?end_date 
      ?schedule  ?schedule_timezone  ?duration  ?cutoff 
      ?allow_unassociated_targets  ?enabled  ?replace  () =
      {
        window_id;
        name;
        description;
        start_date;
        end_date;
        schedule;
        schedule_timezone;
        duration;
        cutoff;
        allow_unassociated_targets;
        enabled;
        replace
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replace
              (fun f -> ("replace", (Boolean.to_json f)));
           Util.option_map v.enabled
             (fun f -> ("enabled", (Boolean.to_json f)));
           Util.option_map v.allow_unassociated_targets
             (fun f -> ("allow_unassociated_targets", (Boolean.to_json f)));
           Util.option_map v.cutoff
             (fun f -> ("cutoff", (Integer.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.schedule_timezone
             (fun f -> ("schedule_timezone", (String.to_json f)));
           Util.option_map v.schedule
             (fun f -> ("schedule", (String.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (String.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Some ("window_id", (String.to_json v.window_id))])
    let of_json j =
      {
        window_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "window_id")));
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        start_date =
          (Util.option_map (Json.lookup j "start_date") String.of_json);
        end_date =
          (Util.option_map (Json.lookup j "end_date") String.of_json);
        schedule =
          (Util.option_map (Json.lookup j "schedule") String.of_json);
        schedule_timezone =
          (Util.option_map (Json.lookup j "schedule_timezone") String.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        cutoff = (Util.option_map (Json.lookup j "cutoff") Integer.of_json);
        allow_unassociated_targets =
          (Util.option_map (Json.lookup j "allow_unassociated_targets")
             Boolean.of_json);
        enabled = (Util.option_map (Json.lookup j "enabled") Boolean.of_json);
        replace = (Util.option_map (Json.lookup j "replace") Boolean.of_json)
      }
  end
module UpdateMaintenanceWindowResult = UpdateMaintenanceWindowResult
type input = UpdateMaintenanceWindowRequest.t
type output = UpdateMaintenanceWindowResult.t
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
            (Query.render (UpdateMaintenanceWindowRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateMaintenanceWindowRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateMaintenanceWindowResult.of_json json)
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