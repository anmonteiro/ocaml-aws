open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SendCommandRequest =
  struct
    type t =
      {
      instance_ids: InstanceIdList.t
        [@ocaml.doc
          "<p>The instance IDs where the command should run. You can specify a maximum of 50 IDs. If you prefer not to list individual instance IDs, you can instead send commands to a fleet of instances using the Targets parameter, which accepts EC2 tags. For more information about how to use targets, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html\">Sending Commands to a Fleet</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>(Optional) An array of search criteria that targets instances using a Key,Value combination that you specify. Targets is required if you don't provide one or more instance IDs in the call. For more information about how to use targets, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html\">Sending Commands to a Fleet</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      document_name: String.t
        [@ocaml.doc
          "<p>Required. The name of the Systems Manager document to run. This can be a public document or a custom document.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The SSM document version to use in the request. You can specify $DEFAULT, $LATEST, or a specific version number. If you run commands by using the AWS CLI, then you must escape the first two options by using a backslash. If you specify a version number, then you don't need to use the backslash. For example:</p> <p>--document-version \"\\$DEFAULT\"</p> <p>--document-version \"\\$LATEST\"</p> <p>--document-version \"3\"</p>"];
      document_hash: String.t option
        [@ocaml.doc
          "<p>The Sha256 or Sha1 hash created by the system when the document was created. </p> <note> <p>Sha1 hashes have been deprecated.</p> </note>"];
      document_hash_type: DocumentHashType.t option
        [@ocaml.doc
          "<p>Sha256 or Sha1.</p> <note> <p>Sha1 hashes have been deprecated.</p> </note>"];
      timeout_seconds: Integer.t option
        [@ocaml.doc
          "<p>If this time is reached and the command has not already started running, it will not run.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>User-specified information about the command, such as a brief description of what the command should do.</p>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>The required and optional parameters specified in the document being run.</p>"];
      output_s3_region: String.t option
        [@ocaml.doc
          "<p>(Deprecated) You can no longer specify this parameter. The system ignores it. Instead, Systems Manager automatically determines the Amazon S3 bucket region.</p>"];
      output_s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>The name of the S3 bucket where command execution responses should be stored.</p>"];
      output_s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>The directory structure within the S3 bucket where the responses should be stored.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of instances that are allowed to run the command at the same time. You can specify a number such as 10 or a percentage such as 10%. The default value is 50. For more information about how to use MaxConcurrency, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-velocity\">Using Concurrency Controls</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The maximum number of errors allowed without the command failing. When the command fails one more time beyond the value of MaxErrors, the systems stops sending the command to additional targets. You can specify a number like 10 or a percentage like 10%. The default value is 0. For more information about how to use MaxErrors, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-maxerrors\">Using Error Controls</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for Run Command commands.</p>"];
      notification_config: NotificationConfig.t option
        [@ocaml.doc "<p>Configurations for sending notifications.</p>"];
      cloud_watch_output_config: CloudWatchOutputConfig.t option
        [@ocaml.doc
          "<p>Enables Systems Manager to send Run Command output to Amazon CloudWatch Logs. </p>"]}
    let make ?(instance_ids= [])  ?(targets= [])  ~document_name 
      ?document_version  ?document_hash  ?document_hash_type 
      ?timeout_seconds  ?comment  ?parameters  ?output_s3_region 
      ?output_s3_bucket_name  ?output_s3_key_prefix  ?max_concurrency 
      ?max_errors  ?service_role_arn  ?notification_config 
      ?cloud_watch_output_config  () =
      {
        instance_ids;
        targets;
        document_name;
        document_version;
        document_hash;
        document_hash_type;
        timeout_seconds;
        comment;
        parameters;
        output_s3_region;
        output_s3_bucket_name;
        output_s3_key_prefix;
        max_concurrency;
        max_errors;
        service_role_arn;
        notification_config;
        cloud_watch_output_config
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_output_config
              (fun f ->
                 ("cloud_watch_output_config",
                   (CloudWatchOutputConfig.to_json f)));
           Util.option_map v.notification_config
             (fun f ->
                ("notification_config", (NotificationConfig.to_json f)));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.output_s3_key_prefix
             (fun f -> ("output_s3_key_prefix", (String.to_json f)));
           Util.option_map v.output_s3_bucket_name
             (fun f -> ("output_s3_bucket_name", (String.to_json f)));
           Util.option_map v.output_s3_region
             (fun f -> ("output_s3_region", (String.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)));
           Util.option_map v.timeout_seconds
             (fun f -> ("timeout_seconds", (Integer.to_json f)));
           Util.option_map v.document_hash_type
             (fun f -> ("document_hash_type", (DocumentHashType.to_json f)));
           Util.option_map v.document_hash
             (fun f -> ("document_hash", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Some ("document_name", (String.to_json v.document_name));
           Some ("targets", (Targets.to_json v.targets));
           Some ("instance_ids", (InstanceIdList.to_json v.instance_ids))])
    let of_json j =
      {
        instance_ids =
          (InstanceIdList.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        document_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "document_name")));
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        document_hash =
          (Util.option_map (Json.lookup j "document_hash") String.of_json);
        document_hash_type =
          (Util.option_map (Json.lookup j "document_hash_type")
             DocumentHashType.of_json);
        timeout_seconds =
          (Util.option_map (Json.lookup j "timeout_seconds") Integer.of_json);
        comment = (Util.option_map (Json.lookup j "comment") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        output_s3_region =
          (Util.option_map (Json.lookup j "output_s3_region") String.of_json);
        output_s3_bucket_name =
          (Util.option_map (Json.lookup j "output_s3_bucket_name")
             String.of_json);
        output_s3_key_prefix =
          (Util.option_map (Json.lookup j "output_s3_key_prefix")
             String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        notification_config =
          (Util.option_map (Json.lookup j "notification_config")
             NotificationConfig.of_json);
        cloud_watch_output_config =
          (Util.option_map (Json.lookup j "cloud_watch_output_config")
             CloudWatchOutputConfig.of_json)
      }
  end
module SendCommandResult = SendCommandResult
type input = SendCommandRequest.t
type output = SendCommandResult.t
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
            (Query.render (SendCommandRequest.to_query req)))) in
  (`POST, uri, (Headers.render (SendCommandRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (SendCommandResult.of_json json)
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