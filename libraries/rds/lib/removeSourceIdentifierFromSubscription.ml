open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveSourceIdentifierFromSubscriptionMessage =
  struct
    type t =
      {
      subscription_name: String.t
        [@ocaml.doc
          "<p>The name of the RDS event notification subscription you want to remove a source identifier from.</p>"];
      source_identifier: String.t
        [@ocaml.doc
          "<p> The source identifier to be removed from the subscription, such as the <b>DB instance identifier</b> for a DB instance or the name of a security group. </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~subscription_name  ~source_identifier  () =
      { subscription_name; source_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("source_identifier", (String.to_json v.source_identifier));
           Some ("subscription_name", (String.to_json v.subscription_name))])
    let parse xml =
      Some
        {
          subscription_name =
            (Xml.required "SubscriptionName"
               (Util.option_bind (Xml.member "SubscriptionName" xml)
                  String.parse));
          source_identifier =
            (Xml.required "SourceIdentifier"
               (Util.option_bind (Xml.member "SourceIdentifier" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "SubscriptionName"
                  ([], (String.to_xml v.subscription_name)))])
           @
           [Some
              (Ezxmlm.make_tag "SourceIdentifier"
                 ([], (String.to_xml v.source_identifier)))])
  end[@@ocaml.doc "<p/>"]
module RemoveSourceIdentifierFromSubscriptionResult =
  RemoveSourceIdentifierFromSubscriptionResult
type input = RemoveSourceIdentifierFromSubscriptionMessage.t
type output = RemoveSourceIdentifierFromSubscriptionResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["RemoveSourceIdentifierFromSubscription"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (RemoveSourceIdentifierFromSubscriptionMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (RemoveSourceIdentifierFromSubscriptionMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RemoveSourceIdentifierFromSubscriptionResponse"
           (snd xml))
        (Xml.member "RemoveSourceIdentifierFromSubscriptionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             RemoveSourceIdentifierFromSubscriptionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RemoveSourceIdentifierFromSubscriptionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RemoveSourceIdentifierFromSubscriptionResult - missing field in body or children: "
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