open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateMaintenanceWindowRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc "<p>The name of the maintenance window.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>An optional description for the maintenance window. We recommend specifying a description to help you organize your maintenance windows. </p>"];
      start_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when you want the maintenance window to become active. StartDate allows you to delay activation of the maintenance window until the specified future date.</p>"];
      end_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when you want the maintenance window to become inactive. EndDate allows you to set a date and time in the future when the maintenance window will no longer run.</p>"];
      schedule: String.t
        [@ocaml.doc
          "<p>The schedule of the maintenance window in the form of a cron or rate expression.</p>"];
      schedule_timezone: String.t option
        [@ocaml.doc
          "<p>The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. For example: \"America/Los_Angeles\", \"etc/UTC\", or \"Asia/Seoul\". For more information, see the <a href=\"https://www.iana.org/time-zones\">Time Zone Database</a> on the IANA website.</p>"];
      duration: Integer.t
        [@ocaml.doc
          "<p>The duration of the maintenance window in hours.</p>"];
      cutoff: Integer.t
        [@ocaml.doc
          "<p>The number of hours before the end of the maintenance window that Systems Manager stops scheduling new tasks for execution.</p>"];
      allow_unassociated_targets: Boolean.t
        [@ocaml.doc
          "<p>Enables a maintenance window task to run on managed instances, even if you have not registered those instances as targets. If enabled, then you must specify the unregistered instances (by instance ID) when you register a task with the maintenance window.</p> <p>If you don't enable this option, then you must specify previously-registered targets when you register a task with the maintenance window.</p>"];
      client_token: String.t option
        [@ocaml.doc "<p>User-provided idempotency token.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>Optional metadata that you assign to a resource. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag a maintenance window to identify the type of tasks it will run, the types of targets, and the environment it will run in. In this case, you could specify the following key name/value pairs:</p> <ul> <li> <p> <code>Key=TaskType,Value=AgentUpdate</code> </p> </li> <li> <p> <code>Key=OS,Value=Windows</code> </p> </li> <li> <p> <code>Key=Environment,Value=Production</code> </p> </li> </ul> <note> <p>To add tags to an existing maintenance window, use the <a>AddTagsToResource</a> action.</p> </note>"]}
    let make ~name  ?description  ?start_date  ?end_date  ~schedule 
      ?schedule_timezone  ~duration  ~cutoff  ~allow_unassociated_targets 
      ?client_token  ?(tags= [])  () =
      {
        name;
        description;
        start_date;
        end_date;
        schedule;
        schedule_timezone;
        duration;
        cutoff;
        allow_unassociated_targets;
        client_token;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Some
             ("allow_unassociated_targets",
               (Boolean.to_json v.allow_unassociated_targets));
           Some ("cutoff", (Integer.to_json v.cutoff));
           Some ("duration", (Integer.to_json v.duration));
           Util.option_map v.schedule_timezone
             (fun f -> ("schedule_timezone", (String.to_json f)));
           Some ("schedule", (String.to_json v.schedule));
           Util.option_map v.end_date
             (fun f -> ("end_date", (String.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        start_date =
          (Util.option_map (Json.lookup j "start_date") String.of_json);
        end_date =
          (Util.option_map (Json.lookup j "end_date") String.of_json);
        schedule =
          (String.of_json (Util.of_option_exn (Json.lookup j "schedule")));
        schedule_timezone =
          (Util.option_map (Json.lookup j "schedule_timezone") String.of_json);
        duration =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "duration")));
        cutoff =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "cutoff")));
        allow_unassociated_targets =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "allow_unassociated_targets")));
        client_token =
          (Util.option_map (Json.lookup j "client_token") String.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module CreateMaintenanceWindowResult = CreateMaintenanceWindowResult
type input = CreateMaintenanceWindowRequest.t
type output = CreateMaintenanceWindowResult.t
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
            (Query.render (CreateMaintenanceWindowRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CreateMaintenanceWindowRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (CreateMaintenanceWindowResult.of_json json)
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