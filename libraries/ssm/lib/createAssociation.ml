open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateAssociationRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the SSM document that contains the configuration information for the instance. You can specify Command or Automation documents.</p> <p>You can specify AWS-predefined documents, documents you created, or a document that is shared with you from another account.</p> <p>For SSM documents that are shared with you from other AWS accounts, you must specify the complete SSM document ARN, in the following format:</p> <p> <code>arn:<i>partition</i>:ssm:<i>region</i>:<i>account-id</i>:document/<i>document-name</i> </code> </p> <p>For example:</p> <p> <code>arn:aws:ssm:us-east-2:12345678912:document/My-Shared-Document</code> </p> <p>For AWS-predefined documents and SSM documents you created in your account, you only need to specify the document name. For example, <code>AWS-ApplyPatchBaseline</code> or <code>My-Document</code>.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The document version you want to associate with the target(s). Can be a specific version or the default version.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The instance ID.</p> <note> <p> <code>InstanceId</code> has been deprecated. To specify an instance ID for an association, use the <code>Targets</code> parameter. Requests that include the parameter <code>InstanceID</code> with SSM documents that use schema version 2.0 or later will fail. In addition, if you use the parameter <code>InstanceId</code>, you cannot use the parameters <code>AssociationName</code>, <code>DocumentVersion</code>, <code>MaxErrors</code>, <code>MaxConcurrency</code>, <code>OutputLocation</code>, or <code>ScheduleExpression</code>. To use these parameters, you must use the <code>Targets</code> parameter.</p> </note>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>The parameters for the runtime configuration of the document.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets (either instances or tags) for the association. You must specify a value for <code>Targets</code> if you don't specify a value for <code>InstanceId</code>.</p>"];
      schedule_expression: String.t option
        [@ocaml.doc
          "<p>A cron expression when the association will be applied to the target(s).</p>"];
      output_location: InstanceAssociationOutputLocation.t option
        [@ocaml.doc
          "<p>An Amazon S3 bucket where you want to store the output details of the request.</p>"];
      association_name: String.t option
        [@ocaml.doc "<p>Specify a descriptive name for the association.</p>"];
      automation_target_parameter_name: String.t option
        [@ocaml.doc
          "<p>Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify either an absolute number of errors, for example 10, or a percentage of the target set, for example 10%. If you specify 3, for example, the system stops sending requests when the fourth error is received. If you specify 0, then the system stops sending requests after the first error is returned. If you run an association on 50 instances and set MaxError to 10%, then the system stops sending the request when the sixth error is received.</p> <p>Executions that are already running an association when MaxErrors is reached are allowed to complete, but some of these executions may fail as well. If you need to ensure that there won't be more than max-errors failed executions, set MaxConcurrency to 1 so that executions proceed one at a time.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%. The default value is 100%, which means all targets run the association at the same time.</p> <p>If a new instance starts and attempts to run an association while Systems Manager is running MaxConcurrency associations, the association is allowed to run. During the next association interval, the new instance will process its association within the limit specified for MaxConcurrency.</p>"];
      compliance_severity: AssociationComplianceSeverity.t option
        [@ocaml.doc
          "<p>The severity level to assign to the association.</p>"]}
    let make ~name  ?document_version  ?instance_id  ?parameters  ?(targets=
      [])  ?schedule_expression  ?output_location  ?association_name 
      ?automation_target_parameter_name  ?max_errors  ?max_concurrency 
      ?compliance_severity  () =
      {
        name;
        document_version;
        instance_id;
        parameters;
        targets;
        schedule_expression;
        output_location;
        association_name;
        automation_target_parameter_name;
        max_errors;
        max_concurrency;
        compliance_severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.compliance_severity
              (fun f ->
                 ("compliance_severity",
                   (AssociationComplianceSeverity.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.automation_target_parameter_name
             (fun f ->
                ("automation_target_parameter_name", (String.to_json f)));
           Util.option_map v.association_name
             (fun f -> ("association_name", (String.to_json f)));
           Util.option_map v.output_location
             (fun f ->
                ("output_location",
                  (InstanceAssociationOutputLocation.to_json f)));
           Util.option_map v.schedule_expression
             (fun f -> ("schedule_expression", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        schedule_expression =
          (Util.option_map (Json.lookup j "schedule_expression")
             String.of_json);
        output_location =
          (Util.option_map (Json.lookup j "output_location")
             InstanceAssociationOutputLocation.of_json);
        association_name =
          (Util.option_map (Json.lookup j "association_name") String.of_json);
        automation_target_parameter_name =
          (Util.option_map (Json.lookup j "automation_target_parameter_name")
             String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        compliance_severity =
          (Util.option_map (Json.lookup j "compliance_severity")
             AssociationComplianceSeverity.of_json)
      }
  end
module CreateAssociationResult = CreateAssociationResult
type input = CreateAssociationRequest.t
type output = CreateAssociationResult.t
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
            (Query.render (CreateAssociationRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreateAssociationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (CreateAssociationResult.of_json json)
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