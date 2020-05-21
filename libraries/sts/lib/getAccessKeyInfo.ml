open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetAccessKeyInfoRequest =
  struct
    type t =
      {
      access_key_id: String.t
        [@ocaml.doc
          "<p>The identifier of an access key.</p> <p>This parameter allows (through its regex pattern) a string of characters that can consist of any upper- or lowercase letter or digit.</p>"]}
    let make ~access_key_id  () = { access_key_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("access_key_id", (String.to_json v.access_key_id))])
    let parse xml =
      Some
        {
          access_key_id =
            (Xml.required "AccessKeyId"
               (Util.option_bind (Xml.member "AccessKeyId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "AccessKeyId"
                 ([], (String.to_xml v.access_key_id)))])
  end
module GetAccessKeyInfoResponse = GetAccessKeyInfoResponse
type input = GetAccessKeyInfoRequest.t
type output = GetAccessKeyInfoResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-06-15"]); ("Action", ["GetAccessKeyInfo"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetAccessKeyInfoRequest.to_query req))))) in
  (`POST, uri, (Headers.render (GetAccessKeyInfoRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetAccessKeyInfoResponse" (snd xml))
        (Xml.member "GetAccessKeyInfoResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetAccessKeyInfoResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetAccessKeyInfoResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetAccessKeyInfoResponse - missing field in body or children: "
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