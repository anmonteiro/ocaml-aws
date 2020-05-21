open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateMaintenanceWindowTaskRequest =
  struct
    type t =
      {
      window_id: String.t
        [@ocaml.doc
          "<p>The maintenance window ID that contains the task to modify.</p>"];
      window_task_id: String.t [@ocaml.doc "<p>The task ID to modify.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets (either instances or tags) to modify. Instances are specified using Key=instanceids,Values=instanceID_1,instanceID_2. Tags are specified using Key=tag_name,Values=tag_value. </p>"];
      task_arn: String.t option [@ocaml.doc "<p>The task ARN to modify.</p>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role for Systems Manager to assume when running a maintenance window task. If you do not specify a service role ARN, Systems Manager uses your account's service-linked role. If no service-linked role for Systems Manager exists in your account, it is created when you run <code>RegisterTaskWithMaintenanceWindow</code>.</p> <p>For more information, see the following topics in the in the <i>AWS Systems Manager User Guide</i>:</p> <ul> <li> <p> <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html#slr-permissions\">Service-Linked Role Permissions for Systems Manager</a> </p> </li> <li> <p> <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html#maintenance-window-tasks-service-role\">Should I Use a Service-Linked Role or a Custom Service Role to Run Maintenance Window Tasks? </a> </p> </li> </ul>"];
      task_parameters: MaintenanceWindowTaskParameters.t option
        [@ocaml.doc
          "<p>The parameters to modify.</p> <note> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note> <p>The map has the following format:</p> <p>Key: string, between 1 and 255 characters</p> <p>Value: an array of strings, each string is between 1 and 255 characters</p>"];
      task_invocation_parameters:
        MaintenanceWindowTaskInvocationParameters.t option
        [@ocaml.doc
          "<p>The parameters that the task should use during execution. Populate only the fields that match the task type. All other fields should be empty.</p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The new task priority to specify. The lower the number, the higher the priority. Tasks that have the same priority are scheduled in parallel.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The new <code>MaxConcurrency</code> value you want to specify. <code>MaxConcurrency</code> is the number of targets that are allowed to run this task in parallel.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The new <code>MaxErrors</code> value to specify. <code>MaxErrors</code> is the maximum number of errors that are allowed before the task stops being scheduled.</p>"];
      logging_info: LoggingInfo.t option
        [@ocaml.doc
          "<p>The new logging location in Amazon S3 to specify.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      name: String.t option
        [@ocaml.doc "<p>The new task name to specify.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The new task description to specify.</p>"];
      replace: Boolean.t option
        [@ocaml.doc
          "<p>If True, then all fields that are required by the RegisterTaskWithMaintenanceWndow action are also required for this API request. Optional fields that are not specified are set to null.</p>"]}
    let make ~window_id  ~window_task_id  ?(targets= [])  ?task_arn 
      ?service_role_arn  ?task_parameters  ?task_invocation_parameters 
      ?priority  ?max_concurrency  ?max_errors  ?logging_info  ?name 
      ?description  ?replace  () =
      {
        window_id;
        window_task_id;
        targets;
        task_arn;
        service_role_arn;
        task_parameters;
        task_invocation_parameters;
        priority;
        max_concurrency;
        max_errors;
        logging_info;
        name;
        description;
        replace
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replace
              (fun f -> ("replace", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.logging_info
             (fun f -> ("logging_info", (LoggingInfo.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Util.option_map v.task_invocation_parameters
             (fun f ->
                ("task_invocation_parameters",
                  (MaintenanceWindowTaskInvocationParameters.to_json f)));
           Util.option_map v.task_parameters
             (fun f ->
                ("task_parameters",
                  (MaintenanceWindowTaskParameters.to_json f)));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Util.option_map v.task_arn
             (fun f -> ("task_arn", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Some ("window_task_id", (String.to_json v.window_task_id));
           Some ("window_id", (String.to_json v.window_id))])
    let of_json j =
      {
        window_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "window_id")));
        window_task_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "window_task_id")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        task_arn =
          (Util.option_map (Json.lookup j "task_arn") String.of_json);
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        task_parameters =
          (Util.option_map (Json.lookup j "task_parameters")
             MaintenanceWindowTaskParameters.of_json);
        task_invocation_parameters =
          (Util.option_map (Json.lookup j "task_invocation_parameters")
             MaintenanceWindowTaskInvocationParameters.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        logging_info =
          (Util.option_map (Json.lookup j "logging_info") LoggingInfo.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        replace = (Util.option_map (Json.lookup j "replace") Boolean.of_json)
      }
  end
module UpdateMaintenanceWindowTaskResult = UpdateMaintenanceWindowTaskResult
type input = UpdateMaintenanceWindowTaskRequest.t
type output = UpdateMaintenanceWindowTaskResult.t
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
            (Query.render (UpdateMaintenanceWindowTaskRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateMaintenanceWindowTaskRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateMaintenanceWindowTaskResult.of_json json)
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