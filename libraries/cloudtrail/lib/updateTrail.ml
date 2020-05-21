open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateTrailRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>Specifies the name of the trail or trail ARN. If <code>Name</code> is a trail name, the string must meet the following requirements:</p> <ul> <li> <p>Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.), underscores (_), or dashes (-)</p> </li> <li> <p>Start with a letter or number, and end with a letter or number</p> </li> <li> <p>Be between 3 and 128 characters</p> </li> <li> <p>Have no adjacent periods, underscores or dashes. Names like <code>my-_namespace</code> and <code>my--namespace</code> are invalid.</p> </li> <li> <p>Not be in IP address format (for example, 192.168.5.4)</p> </li> </ul> <p>If <code>Name</code> is a trail ARN, it must be in the format:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the Amazon S3 bucket designated for publishing log files. See <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create_trail_naming_policy.html\">Amazon S3 Bucket Naming Requirements</a>.</p>"];
      s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-find-log-files.html\">Finding Your CloudTrail Log Files</a>. The maximum length is 200 characters.</p>"];
      sns_topic_name: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the Amazon SNS topic defined for notification of log file delivery. The maximum length is 256 characters.</p>"];
      include_global_service_events: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is publishing events from global services such as IAM to the log files.</p>"];
      is_multi_region_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail applies only to the current region or to all regions. The default is false. If the trail exists only in the current region and this value is set to true, shadow trails (replications of the trail) will be created in the other regions. If the trail exists in all regions and this value is set to false, the trail will remain in the region where it was created, and its shadow trails in other regions will be deleted. As a best practice, consider using trails that log events in all regions.</p>"];
      enable_log_file_validation: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether log file validation is enabled. The default is false.</p> <note> <p>When you disable log file integrity validation, the chain of digest files is broken after one hour. CloudTrail will not create digest files for log files that were delivered during a period in which log file integrity validation was disabled. For example, if you enable log file integrity validation at noon on January 1, disable it at noon on January 2, and re-enable it at noon on January 10, digest files will not be created for the log files delivered from noon on January 2 to noon on January 10. The same applies whenever you stop CloudTrail logging or delete a trail.</p> </note>"];
      cloud_watch_logs_log_group_arn: String.t option
        [@ocaml.doc
          "<p>Specifies a log group name using an Amazon Resource Name (ARN), a unique identifier that represents the log group to which CloudTrail logs will be delivered. Not required unless you specify CloudWatchLogsRoleArn.</p>"];
      cloud_watch_logs_role_arn: String.t option
        [@ocaml.doc
          "<p>Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>Specifies the KMS key ID to use to encrypt the logs delivered by CloudTrail. The value can be an alias name prefixed by \"alias/\", a fully specified ARN to an alias, a fully specified ARN to a key, or a globally unique identifier.</p> <p>Examples:</p> <ul> <li> <p>alias/MyAliasName</p> </li> <li> <p>arn:aws:kms:us-east-2:123456789012:alias/MyAliasName</p> </li> <li> <p>arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012</p> </li> <li> <p>12345678-1234-1234-1234-123456789012</p> </li> </ul>"];
      is_organization_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is applied to all accounts in an organization in AWS Organizations, or only for the current AWS account. The default is false, and cannot be true unless the call is made on behalf of an AWS account that is the master account for an organization in AWS Organizations. If the trail is not an organization trail and this is set to true, the trail will be created in all AWS accounts that belong to the organization. If the trail is an organization trail and this is set to false, the trail will remain in the current AWS account but be deleted from all member accounts in the organization.</p>"]}
    [@@ocaml.doc "<p>Specifies settings to update for the trail.</p>"]
    let make ~name  ?s3_bucket_name  ?s3_key_prefix  ?sns_topic_name 
      ?include_global_service_events  ?is_multi_region_trail 
      ?enable_log_file_validation  ?cloud_watch_logs_log_group_arn 
      ?cloud_watch_logs_role_arn  ?kms_key_id  ?is_organization_trail  () =
      {
        name;
        s3_bucket_name;
        s3_key_prefix;
        sns_topic_name;
        include_global_service_events;
        is_multi_region_trail;
        enable_log_file_validation;
        cloud_watch_logs_log_group_arn;
        cloud_watch_logs_role_arn;
        kms_key_id;
        is_organization_trail
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_organization_trail
              (fun f -> ("is_organization_trail", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_role_arn
             (fun f -> ("cloud_watch_logs_role_arn", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_log_group_arn
             (fun f -> ("cloud_watch_logs_log_group_arn", (String.to_json f)));
           Util.option_map v.enable_log_file_validation
             (fun f -> ("enable_log_file_validation", (Boolean.to_json f)));
           Util.option_map v.is_multi_region_trail
             (fun f -> ("is_multi_region_trail", (Boolean.to_json f)));
           Util.option_map v.include_global_service_events
             (fun f -> ("include_global_service_events", (Boolean.to_json f)));
           Util.option_map v.sns_topic_name
             (fun f -> ("sns_topic_name", (String.to_json f)));
           Util.option_map v.s3_key_prefix
             (fun f -> ("s3_key_prefix", (String.to_json f)));
           Util.option_map v.s3_bucket_name
             (fun f -> ("s3_bucket_name", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        s3_bucket_name =
          (Util.option_map (Json.lookup j "s3_bucket_name") String.of_json);
        s3_key_prefix =
          (Util.option_map (Json.lookup j "s3_key_prefix") String.of_json);
        sns_topic_name =
          (Util.option_map (Json.lookup j "sns_topic_name") String.of_json);
        include_global_service_events =
          (Util.option_map (Json.lookup j "include_global_service_events")
             Boolean.of_json);
        is_multi_region_trail =
          (Util.option_map (Json.lookup j "is_multi_region_trail")
             Boolean.of_json);
        enable_log_file_validation =
          (Util.option_map (Json.lookup j "enable_log_file_validation")
             Boolean.of_json);
        cloud_watch_logs_log_group_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_log_group_arn")
             String.of_json);
        cloud_watch_logs_role_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_role_arn")
             String.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json);
        is_organization_trail =
          (Util.option_map (Json.lookup j "is_organization_trail")
             Boolean.of_json)
      }
  end[@@ocaml.doc "<p>Specifies settings to update for the trail.</p>"]
module UpdateTrailResponse = UpdateTrailResponse
type input = UpdateTrailRequest.t
type output = UpdateTrailResponse.t
type error = Errors_internal.t
let streaming = false
let service = "cloudtrail"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UpdateTrailRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdateTrailRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateTrailResponse.of_json json)
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