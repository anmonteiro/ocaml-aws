open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpcEndpointConnectionNotificationRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      service_id: String.t option
        [@ocaml.doc "<p>The ID of the endpoint service.</p>"];
      vpc_endpoint_id: String.t option
        [@ocaml.doc "<p>The ID of the endpoint. </p>"];
      connection_notification_arn: String.t
        [@ocaml.doc "<p>The ARN of the SNS topic for the notifications.</p>"];
      connection_events: ValueStringList.t
        [@ocaml.doc
          "<p>One or more endpoint events for which to receive notifications. Valid values are <code>Accept</code>, <code>Connect</code>, <code>Delete</code>, and <code>Reject</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"]}
    let make ?dry_run  ?service_id  ?vpc_endpoint_id 
      ~connection_notification_arn  ~connection_events  ?client_token  () =
      {
        dry_run;
        service_id;
        vpc_endpoint_id;
        connection_notification_arn;
        connection_events;
        client_token
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Some
             (Query.Pair
                ("ConnectionEvents",
                  (ValueStringList.to_query v.connection_events)));
           Some
             (Query.Pair
                ("ConnectionNotificationArn",
                  (String.to_query v.connection_notification_arn)));
           Util.option_map v.vpc_endpoint_id
             (fun f -> Query.Pair ("VpcEndpointId", (String.to_query f)));
           Util.option_map v.service_id
             (fun f -> Query.Pair ("ServiceId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Some
             ("connection_events",
               (ValueStringList.to_json v.connection_events));
           Some
             ("connection_notification_arn",
               (String.to_json v.connection_notification_arn));
           Util.option_map v.vpc_endpoint_id
             (fun f -> ("vpc_endpoint_id", (String.to_json f)));
           Util.option_map v.service_id
             (fun f -> ("service_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          service_id =
            (Util.option_bind (Xml.member "ServiceId" xml) String.parse);
          vpc_endpoint_id =
            (Util.option_bind (Xml.member "VpcEndpointId" xml) String.parse);
          connection_notification_arn =
            (Xml.required "ConnectionNotificationArn"
               (Util.option_bind (Xml.member "ConnectionNotificationArn" xml)
                  String.parse));
          connection_events =
            (Xml.required "ConnectionEvents"
               (Util.option_bind (Xml.member "ConnectionEvents" xml)
                  ValueStringList.parse));
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.dry_run
                   (fun f ->
                      Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.service_id
                  (fun f ->
                     Ezxmlm.make_tag "ServiceId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.vpc_endpoint_id
                 (fun f ->
                    Ezxmlm.make_tag "VpcEndpointId" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "ConnectionNotificationArn"
                   ([], (String.to_xml v.connection_notification_arn)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ConnectionEvents"
                       ([], (ValueStringList.to_xml [x]))))
               v.connection_events))
           @
           [Util.option_map v.client_token
              (fun f -> Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
  end
module CreateVpcEndpointConnectionNotificationResult =
  CreateVpcEndpointConnectionNotificationResult
type input = CreateVpcEndpointConnectionNotificationRequest.t
type output = CreateVpcEndpointConnectionNotificationResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["CreateVpcEndpointConnectionNotification"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateVpcEndpointConnectionNotificationRequest.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (CreateVpcEndpointConnectionNotificationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "CreateVpcEndpointConnectionNotificationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             CreateVpcEndpointConnectionNotificationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateVpcEndpointConnectionNotificationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateVpcEndpointConnectionNotificationResult - missing field in body or children: "
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