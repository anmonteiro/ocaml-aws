open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListQueueTagsRequest =
  struct
    type t =
      {
      queue_url: String.t [@ocaml.doc "<p>The URL of the queue.</p>"]}
    let make ~queue_url  () = { queue_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "QueueUrl" ([], (String.to_xml v.queue_url)))])
  end
module ListQueueTagsResult = ListQueueTagsResult
type input = ListQueueTagsRequest.t
type output = ListQueueTagsResult.t
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2012-11-05"]); ("Action", ["ListQueueTags"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListQueueTagsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ListQueueTagsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListQueueTagsResponse" (snd xml))
        (Xml.member "ListQueueTagsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListQueueTagsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListQueueTagsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListQueueTagsResult - missing field in body or children: "
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