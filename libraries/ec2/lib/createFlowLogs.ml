open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateFlowLogsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"];
      deliver_logs_permission_arn: String.t option
        [@ocaml.doc
          "<p>The ARN for the IAM role that permits Amazon EC2 to publish flow logs to a CloudWatch Logs log group in your account.</p> <p>If you specify <code>LogDestinationType</code> as <code>s3</code>, do not specify <code>DeliverLogsPermissionArn</code> or <code>LogGroupName</code>.</p>"];
      log_group_name: String.t option
        [@ocaml.doc
          "<p>The name of a new or existing CloudWatch Logs log group where Amazon EC2 publishes your flow logs.</p> <p>If you specify <code>LogDestinationType</code> as <code>s3</code>, do not specify <code>DeliverLogsPermissionArn</code> or <code>LogGroupName</code>.</p>"];
      resource_ids: ValueStringList.t
        [@ocaml.doc
          "<p>The ID of the subnet, network interface, or VPC for which you want to create a flow log.</p> <p>Constraints: Maximum of 1000 resources</p>"];
      resource_type: FlowLogsResourceType.t
        [@ocaml.doc
          "<p>The type of resource for which to create the flow log. For example, if you specified a VPC ID for the <code>ResourceId</code> property, specify <code>VPC</code> for this property.</p>"];
      traffic_type: TrafficType.t
        [@ocaml.doc
          "<p>The type of traffic to log. You can log traffic that the resource accepts or rejects, or all traffic.</p>"];
      log_destination_type: LogDestinationType.t option
        [@ocaml.doc
          "<p>Specifies the type of destination to which the flow log data is to be published. Flow log data can be published to CloudWatch Logs or Amazon S3. To publish flow log data to CloudWatch Logs, specify <code>cloud-watch-logs</code>. To publish flow log data to Amazon S3, specify <code>s3</code>.</p> <p>If you specify <code>LogDestinationType</code> as <code>s3</code>, do not specify <code>DeliverLogsPermissionArn</code> or <code>LogGroupName</code>.</p> <p>Default: <code>cloud-watch-logs</code> </p>"];
      log_destination: String.t option
        [@ocaml.doc
          "<p>Specifies the destination to which the flow log data is to be published. Flow log data can be published to a CloudWatch Logs log group or an Amazon S3 bucket. The value specified for this parameter depends on the value specified for <code>LogDestinationType</code>.</p> <p>If <code>LogDestinationType</code> is not specified or <code>cloud-watch-logs</code>, specify the Amazon Resource Name (ARN) of the CloudWatch Logs log group. For example, to publish to a log group called <code>my-logs</code>, specify <code>arn:aws:logs:us-east-1:123456789012:log-group:my-logs</code>. Alternatively, use <code>LogGroupName</code> instead.</p> <p>If LogDestinationType is <code>s3</code>, specify the ARN of the Amazon S3 bucket. You can also specify a subfolder in the bucket. To specify a subfolder in the bucket, use the following ARN format: <code>bucket_ARN/subfolder_name/</code>. For example, to specify a subfolder named <code>my-logs</code> in a bucket named <code>my-bucket</code>, use the following ARN: <code>arn:aws:s3:::my-bucket/my-logs/</code>. You cannot use <code>AWSLogs</code> as a subfolder name. This is a reserved term.</p>"];
      log_format: String.t option
        [@ocaml.doc
          "<p>The fields to include in the flow log record, in the order in which they should appear. For a list of available fields, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html#flow-log-records\">Flow Log Records</a>. If you omit this parameter, the flow log is created using the default format. If you specify this parameter, you must specify at least one field.</p> <p>Specify the fields using the <code>${field-id}</code> format, separated by spaces. For the AWS CLI, use single quotation marks (' ') to surround the parameter value.</p> <p>Only applicable to flow logs that are published to an Amazon S3 bucket.</p>"]}
    let make ?dry_run  ?client_token  ?deliver_logs_permission_arn 
      ?log_group_name  ~resource_ids  ~resource_type  ~traffic_type 
      ?log_destination_type  ?log_destination  ?log_format  () =
      {
        dry_run;
        client_token;
        deliver_logs_permission_arn;
        log_group_name;
        resource_ids;
        resource_type;
        traffic_type;
        log_destination_type;
        log_destination;
        log_format
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.log_format
              (fun f -> Query.Pair ("LogFormat", (String.to_query f)));
           Util.option_map v.log_destination
             (fun f -> Query.Pair ("LogDestination", (String.to_query f)));
           Util.option_map v.log_destination_type
             (fun f ->
                Query.Pair
                  ("LogDestinationType", (LogDestinationType.to_query f)));
           Some
             (Query.Pair
                ("TrafficType", (TrafficType.to_query v.traffic_type)));
           Some
             (Query.Pair
                ("ResourceType",
                  (FlowLogsResourceType.to_query v.resource_type)));
           Some
             (Query.Pair
                ("ResourceId", (ValueStringList.to_query v.resource_ids)));
           Util.option_map v.log_group_name
             (fun f -> Query.Pair ("LogGroupName", (String.to_query f)));
           Util.option_map v.deliver_logs_permission_arn
             (fun f ->
                Query.Pair ("DeliverLogsPermissionArn", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.log_format
              (fun f -> ("log_format", (String.to_json f)));
           Util.option_map v.log_destination
             (fun f -> ("log_destination", (String.to_json f)));
           Util.option_map v.log_destination_type
             (fun f ->
                ("log_destination_type", (LogDestinationType.to_json f)));
           Some ("traffic_type", (TrafficType.to_json v.traffic_type));
           Some
             ("resource_type",
               (FlowLogsResourceType.to_json v.resource_type));
           Some ("resource_ids", (ValueStringList.to_json v.resource_ids));
           Util.option_map v.log_group_name
             (fun f -> ("log_group_name", (String.to_json f)));
           Util.option_map v.deliver_logs_permission_arn
             (fun f -> ("deliver_logs_permission_arn", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          deliver_logs_permission_arn =
            (Util.option_bind (Xml.member "DeliverLogsPermissionArn" xml)
               String.parse);
          log_group_name =
            (Util.option_bind (Xml.member "LogGroupName" xml) String.parse);
          resource_ids =
            (Xml.required "ResourceId"
               (Util.option_bind (Xml.member "ResourceId" xml)
                  ValueStringList.parse));
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml)
                  FlowLogsResourceType.parse));
          traffic_type =
            (Xml.required "TrafficType"
               (Util.option_bind (Xml.member "TrafficType" xml)
                  TrafficType.parse));
          log_destination_type =
            (Util.option_bind (Xml.member "LogDestinationType" xml)
               LogDestinationType.parse);
          log_destination =
            (Util.option_bind (Xml.member "LogDestination" xml) String.parse);
          log_format =
            (Util.option_bind (Xml.member "LogFormat" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.dry_run
                       (fun f ->
                          Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                   @
                   [Util.option_map v.client_token
                      (fun f ->
                         Ezxmlm.make_tag "ClientToken"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.deliver_logs_permission_arn
                     (fun f ->
                        Ezxmlm.make_tag "DeliverLogsPermissionArn"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.log_group_name
                    (fun f ->
                       Ezxmlm.make_tag "LogGroupName" ([], (String.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "ResourceId"
                           ([], (ValueStringList.to_xml [x]))))
                   v.resource_ids))
               @
               [Some
                  (Ezxmlm.make_tag "ResourceType"
                     ([], (FlowLogsResourceType.to_xml v.resource_type)))])
              @
              [Some
                 (Ezxmlm.make_tag "TrafficType"
                    ([], (TrafficType.to_xml v.traffic_type)))])
             @
             [Util.option_map v.log_destination_type
                (fun f ->
                   Ezxmlm.make_tag "LogDestinationType"
                     ([], (LogDestinationType.to_xml f)))])
            @
            [Util.option_map v.log_destination
               (fun f ->
                  Ezxmlm.make_tag "LogDestination" ([], (String.to_xml f)))])
           @
           [Util.option_map v.log_format
              (fun f -> Ezxmlm.make_tag "LogFormat" ([], (String.to_xml f)))])
  end
module CreateFlowLogsResult = CreateFlowLogsResult
type input = CreateFlowLogsRequest.t
type output = CreateFlowLogsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateFlowLogs"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateFlowLogsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateFlowLogsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateFlowLogsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateFlowLogsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateFlowLogsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateFlowLogsResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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