open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DecodeAuthorizationMessageRequest =
  struct
    type t =
      {
      encoded_message: String.t
        [@ocaml.doc
          "<p>The encoded message that was returned with the response.</p>"]}
    let make ~encoded_message  () = { encoded_message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("encoded_message", (String.to_json v.encoded_message))])
    let parse xml =
      Some
        {
          encoded_message =
            (Xml.required "EncodedMessage"
               (Util.option_bind (Xml.member "EncodedMessage" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "EncodedMessage"
                 ([], (String.to_xml v.encoded_message)))])
  end
module DecodeAuthorizationMessageResponse =
  DecodeAuthorizationMessageResponse
type input = DecodeAuthorizationMessageRequest.t
type output = DecodeAuthorizationMessageResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-06-15"]);
         ("Action", ["DecodeAuthorizationMessage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DecodeAuthorizationMessageRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DecodeAuthorizationMessageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DecodeAuthorizationMessageResponse" (snd xml))
        (Xml.member "DecodeAuthorizationMessageResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DecodeAuthorizationMessageResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DecodeAuthorizationMessageResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DecodeAuthorizationMessageResponse - missing field in body or children: "
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