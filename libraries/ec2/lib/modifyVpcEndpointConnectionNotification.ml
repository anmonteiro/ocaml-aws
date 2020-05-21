open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpcEndpointConnectionNotificationRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      connection_notification_id: String.t
        [@ocaml.doc "<p>The ID of the notification.</p>"];
      connection_notification_arn: String.t option
        [@ocaml.doc "<p>The ARN for the SNS topic for the notification.</p>"];
      connection_events: ValueStringList.t
        [@ocaml.doc
          "<p>One or more events for the endpoint. Valid values are <code>Accept</code>, <code>Connect</code>, <code>Delete</code>, and <code>Reject</code>.</p>"]}
    let make ?dry_run  ~connection_notification_id 
      ?connection_notification_arn  ?(connection_events= [])  () =
      {
        dry_run;
        connection_notification_id;
        connection_notification_arn;
        connection_events
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("ConnectionEvents",
                   (ValueStringList.to_query v.connection_events)));
           Util.option_map v.connection_notification_arn
             (fun f ->
                Query.Pair ("ConnectionNotificationArn", (String.to_query f)));
           Some
             (Query.Pair
                ("ConnectionNotificationId",
                  (String.to_query v.connection_notification_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("connection_events",
                (ValueStringList.to_json v.connection_events));
           Util.option_map v.connection_notification_arn
             (fun f -> ("connection_notification_arn", (String.to_json f)));
           Some
             ("connection_notification_id",
               (String.to_json v.connection_notification_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          connection_notification_id =
            (Xml.required "ConnectionNotificationId"
               (Util.option_bind (Xml.member "ConnectionNotificationId" xml)
                  String.parse));
          connection_notification_arn =
            (Util.option_bind (Xml.member "ConnectionNotificationArn" xml)
               String.parse);
          connection_events =
            (Util.of_option []
               (Util.option_bind (Xml.member "ConnectionEvents" xml)
                  ValueStringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "ConnectionNotificationId"
                   ([], (String.to_xml v.connection_notification_id)))])
            @
            [Util.option_map v.connection_notification_arn
               (fun f ->
                  Ezxmlm.make_tag "ConnectionNotificationArn"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ConnectionEvents"
                      ([], (ValueStringList.to_xml [x]))))
              v.connection_events))
  end
module ModifyVpcEndpointConnectionNotificationResult =
  ModifyVpcEndpointConnectionNotificationResult
type input = ModifyVpcEndpointConnectionNotificationRequest.t
type output = ModifyVpcEndpointConnectionNotificationResult.t
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
         ("Action", ["ModifyVpcEndpointConnectionNotification"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyVpcEndpointConnectionNotificationRequest.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (ModifyVpcEndpointConnectionNotificationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ModifyVpcEndpointConnectionNotificationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyVpcEndpointConnectionNotificationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyVpcEndpointConnectionNotificationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVpcEndpointConnectionNotificationResult - missing field in body or children: "
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