open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateQueryLoggingConfigRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you want to log queries for. You can log queries only for public hosted zones.</p>"];
      cloud_watch_logs_log_group_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the log group that you want to Amazon Route 53 to send query logs to. This is the format of the ARN:</p> <p>arn:aws:logs:<i>region</i>:<i>account-id</i>:log-group:<i>log_group_name</i> </p> <p>To get the ARN for a log group, you can use the CloudWatch console, the <a href=\"https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_DescribeLogGroups.html\">DescribeLogGroups</a> API action, the <a href=\"https://docs.aws.amazon.com/cli/latest/reference/logs/describe-log-groups.html\">describe-log-groups</a> command, or the applicable command in one of the AWS SDKs.</p>"]}
    let make ~hosted_zone_id  ~cloud_watch_logs_log_group_arn  () =
      { hosted_zone_id; cloud_watch_logs_log_group_arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cloud_watch_logs_log_group_arn",
                (String.to_json v.cloud_watch_logs_log_group_arn));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "HostedZoneId"
               (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse));
          cloud_watch_logs_log_group_arn =
            (Xml.required "CloudWatchLogsLogGroupArn"
               (Util.option_bind (Xml.member "CloudWatchLogsLogGroupArn" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "HostedZoneId"
                  ([], (String.to_xml v.hosted_zone_id)))])
           @
           [Some
              (Ezxmlm.make_tag "CloudWatchLogsLogGroupArn"
                 ([], (String.to_xml v.cloud_watch_logs_log_group_arn)))])
  end
module CreateQueryLoggingConfigResponse = CreateQueryLoggingConfigResponse
type input = CreateQueryLoggingConfigRequest.t
type output = CreateQueryLoggingConfigResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/queryloggingconfig"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateQueryLoggingConfigRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CreateQueryLoggingConfigRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed CreateQueryLoggingConfigResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateQueryLoggingConfigResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateQueryLoggingConfigResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateQueryLoggingConfigResponse - missing field in body or children: "
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