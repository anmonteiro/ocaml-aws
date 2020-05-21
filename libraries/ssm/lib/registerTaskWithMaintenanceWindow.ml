open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RegisterTaskWithMaintenanceWindowRequest =
  struct
    type t =
      {
      window_id: String.t
        [@ocaml.doc
          "<p>The ID of the maintenance window the task should be added to.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets (either instances or maintenance window targets).</p> <p>Specify instances using the following format: </p> <p> <code>Key=InstanceIds,Values=&lt;instance-id-1&gt;,&lt;instance-id-2&gt;</code> </p> <p>Specify maintenance window targets using the following format:</p> <p> <code>Key=WindowTargetIds;,Values=&lt;window-target-id-1&gt;,&lt;window-target-id-2&gt;</code> </p>"];
      task_arn: String.t [@ocaml.doc "<p>The ARN of the task to run.</p>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role for Systems Manager to assume when running a maintenance window task. If you do not specify a service role ARN, Systems Manager uses your account's service-linked role. If no service-linked role for Systems Manager exists in your account, it is created when you run <code>RegisterTaskWithMaintenanceWindow</code>.</p> <p>For more information, see the following topics in the in the <i>AWS Systems Manager User Guide</i>:</p> <ul> <li> <p> <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html#slr-permissions\">Service-Linked Role Permissions for Systems Manager</a> </p> </li> <li> <p> <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-maintenance-permissions.html#maintenance-window-tasks-service-role\">Should I Use a Service-Linked Role or a Custom Service Role to Run Maintenance Window Tasks? </a> </p> </li> </ul>"];
      task_type: MaintenanceWindowTaskType.t
        [@ocaml.doc "<p>The type of task being registered.</p>"];
      task_parameters: MaintenanceWindowTaskParameters.t option
        [@ocaml.doc
          "<p>The parameters that should be passed to the task when it is run.</p> <note> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      task_invocation_parameters:
        MaintenanceWindowTaskInvocationParameters.t option
        [@ocaml.doc
          "<p>The parameters that the task should use during execution. Populate only the fields that match the task type. All other fields should be empty. </p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The priority of the task in the maintenance window, the lower the number the higher the priority. Tasks in a maintenance window are scheduled in priority order with tasks that have the same priority scheduled in parallel.</p>"];
      max_concurrency: String.t
        [@ocaml.doc
          "<p>The maximum number of targets this task can be run for in parallel.</p>"];
      max_errors: String.t
        [@ocaml.doc
          "<p>The maximum number of errors allowed before this task stops being scheduled.</p>"];
      logging_info: LoggingInfo.t option
        [@ocaml.doc
          "<p>A structure containing information about an Amazon S3 bucket to write instance-level logs to. </p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      name: String.t option
        [@ocaml.doc "<p>An optional name for the task.</p>"];
      description: String.t option
        [@ocaml.doc "<p>An optional description for the task.</p>"];
      client_token: String.t option
        [@ocaml.doc "<p>User-provided idempotency token.</p>"]}
    let make ~window_id  ~targets  ~task_arn  ?service_role_arn  ~task_type 
      ?task_parameters  ?task_invocation_parameters  ?priority 
      ~max_concurrency  ~max_errors  ?logging_info  ?name  ?description 
      ?client_token  () =
      {
        window_id;
        targets;
        task_arn;
        service_role_arn;
        task_type;
        task_parameters;
        task_invocation_parameters;
        priority;
        max_concurrency;
        max_errors;
        logging_info;
        name;
        description;
        client_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.logging_info
             (fun f -> ("logging_info", (LoggingInfo.to_json f)));
           Some ("max_errors", (String.to_json v.max_errors));
           Some ("max_concurrency", (String.to_json v.max_concurrency));
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
           Some
             ("task_type", (MaintenanceWindowTaskType.to_json v.task_type));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Some ("task_arn", (String.to_json v.task_arn));
           Some ("targets", (Targets.to_json v.targets));
           Some ("window_id", (String.to_json v.window_id))])
    let of_json j =
      {
        window_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "window_id")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        task_arn =
          (String.of_json (Util.of_option_exn (Json.lookup j "task_arn")));
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        task_type =
          (MaintenanceWindowTaskType.of_json
             (Util.of_option_exn (Json.lookup j "task_type")));
        task_parameters =
          (Util.option_map (Json.lookup j "task_parameters")
             MaintenanceWindowTaskParameters.of_json);
        task_invocation_parameters =
          (Util.option_map (Json.lookup j "task_invocation_parameters")
             MaintenanceWindowTaskInvocationParameters.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        max_concurrency =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "max_concurrency")));
        max_errors =
          (String.of_json (Util.of_option_exn (Json.lookup j "max_errors")));
        logging_info =
          (Util.option_map (Json.lookup j "logging_info") LoggingInfo.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        client_token =
          (Util.option_map (Json.lookup j "client_token") String.of_json)
      }
  end
module RegisterTaskWithMaintenanceWindowResult =
  RegisterTaskWithMaintenanceWindowResult
type input = RegisterTaskWithMaintenanceWindowRequest.t
type output = RegisterTaskWithMaintenanceWindowResult.t
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
            (Query.render
               (RegisterTaskWithMaintenanceWindowRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (RegisterTaskWithMaintenanceWindowRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (RegisterTaskWithMaintenanceWindowResult.of_json json)
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