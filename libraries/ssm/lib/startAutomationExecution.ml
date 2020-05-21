open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartAutomationExecutionRequest =
  struct
    type t =
      {
      document_name: String.t
        [@ocaml.doc
          "<p>The name of the Automation document to use for this execution.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The version of the Automation document to use for this execution.</p>"];
      parameters: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>A key-value map of execution parameters, which match the declared parameters in the Automation document.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>User-provided idempotency token. The token must be unique, is case insensitive, enforces the UUID format, and can't be reused.</p>"];
      mode: ExecutionMode.t option
        [@ocaml.doc
          "<p>The execution mode of the automation. Valid modes include the following: Auto and Interactive. The default mode is Auto.</p>"];
      target_parameter_name: String.t option
        [@ocaml.doc
          "<p>The name of the parameter used as the target resource for the rate-controlled execution. Required if you specify targets.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>A key-value mapping to target resources. Required if you specify TargetParameterName.</p>"];
      target_maps: TargetMaps.t
        [@ocaml.doc
          "<p>A key-value mapping of document parameters to target resources. Both Targets and TargetMaps cannot be specified together.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets allowed to run this task in parallel. You can specify a number, such as 10, or a percentage, such as 10%. The default value is 10.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The number of errors that are allowed before the system stops running the automation on additional targets. You can specify either an absolute number of errors, for example 10, or a percentage of the target set, for example 10%. If you specify 3, for example, the system stops running the automation when the fourth error is received. If you specify 0, then the system stops running the automation on additional targets after the first error result is returned. If you run an automation on 50 resources and set max-errors to 10%, then the system stops running the automation on additional targets when the sixth error is received.</p> <p>Executions that are already running an automation when max-errors is reached are allowed to complete, but some of these executions may fail as well. If you need to ensure that there won't be more than max-errors failed executions, set max-concurrency to 1 so the executions proceed one at a time.</p>"];
      target_locations: TargetLocations.t
        [@ocaml.doc
          "<p>A location is a combination of AWS Regions and/or AWS accounts where you want to run the Automation. Use this action to start an Automation in multiple Regions and multiple accounts. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation-multiple-accounts-and-regions.html\">Executing Automations in Multiple AWS Regions and Accounts</a> in the <i>AWS Systems Manager User Guide</i>. </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>Optional metadata that you assign to a resource. You can specify a maximum of five tags for an automation. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag an automation to identify an environment or operating system. In this case, you could specify the following key name/value pairs:</p> <ul> <li> <p> <code>Key=environment,Value=test</code> </p> </li> <li> <p> <code>Key=OS,Value=Windows</code> </p> </li> </ul> <note> <p>To add tags to an existing patch baseline, use the <a>AddTagsToResource</a> action.</p> </note>"]}
    let make ~document_name  ?document_version  ?parameters  ?client_token 
      ?mode  ?target_parameter_name  ?(targets= [])  ?(target_maps= []) 
      ?max_concurrency  ?max_errors  ?(target_locations= [])  ?(tags= [])  ()
      =
      {
        document_name;
        document_version;
        parameters;
        client_token;
        mode;
        target_parameter_name;
        targets;
        target_maps;
        max_concurrency;
        max_errors;
        target_locations;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("target_locations",
               (TargetLocations.to_json v.target_locations));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Some ("target_maps", (TargetMaps.to_json v.target_maps));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.target_parameter_name
             (fun f -> ("target_parameter_name", (String.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ExecutionMode.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (AutomationParameterMap.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Some ("document_name", (String.to_json v.document_name))])
    let of_json j =
      {
        document_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "document_name")));
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters")
             AutomationParameterMap.of_json);
        client_token =
          (Util.option_map (Json.lookup j "client_token") String.of_json);
        mode = (Util.option_map (Json.lookup j "mode") ExecutionMode.of_json);
        target_parameter_name =
          (Util.option_map (Json.lookup j "target_parameter_name")
             String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        target_maps =
          (TargetMaps.of_json
             (Util.of_option_exn (Json.lookup j "target_maps")));
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        target_locations =
          (TargetLocations.of_json
             (Util.of_option_exn (Json.lookup j "target_locations")));
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module StartAutomationExecutionResult = StartAutomationExecutionResult
type input = StartAutomationExecutionRequest.t
type output = StartAutomationExecutionResult.t
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
            (Query.render (StartAutomationExecutionRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (StartAutomationExecutionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (StartAutomationExecutionResult.of_json json)
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