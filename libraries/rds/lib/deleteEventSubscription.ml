open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteEventSubscriptionMessage =
  struct
    type t =
      {
      subscription_name: String.t
        [@ocaml.doc
          "<p>The name of the RDS event notification subscription you want to delete.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~subscription_name  () = { subscription_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subscription_name", (String.to_json v.subscription_name))])
    let parse xml =
      Some
        {
          subscription_name =
            (Xml.required "SubscriptionName"
               (Util.option_bind (Xml.member "SubscriptionName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "SubscriptionName"
                 ([], (String.to_xml v.subscription_name)))])
  end[@@ocaml.doc "<p/>"]
module DeleteEventSubscriptionResult = DeleteEventSubscriptionResult
type input = DeleteEventSubscriptionMessage.t
type output = DeleteEventSubscriptionResult.t
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
         ("Action", ["DeleteEventSubscription"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteEventSubscriptionMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteEventSubscriptionMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DeleteEventSubscriptionResponse" (snd xml))
        (Xml.member "DeleteEventSubscriptionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteEventSubscriptionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteEventSubscriptionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteEventSubscriptionResult - missing field in body or children: "
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