open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteMessageBatchRequest =
  struct
    type t =
      {
      queue_url: String.t
        [@ocaml.doc
          "<p>The URL of the Amazon SQS queue from which messages are deleted.</p> <p>Queue URLs and names are case-sensitive.</p>"];
      entries: DeleteMessageBatchRequestEntryList.t
        [@ocaml.doc
          "<p>A list of receipt handles for the messages to be deleted.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~queue_url  ~entries  () = { queue_url; entries }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("entries",
                (DeleteMessageBatchRequestEntryList.to_json v.entries));
           Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse));
          entries =
            (Xml.required "Entries"
               (DeleteMessageBatchRequestEntryList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "QueueUrl" ([], (String.to_xml v.queue_url)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Entries"
                      ([], (DeleteMessageBatchRequestEntryList.to_xml [x]))))
              v.entries))
  end[@@ocaml.doc "<p/>"]
module DeleteMessageBatchResult = DeleteMessageBatchResult
type input = DeleteMessageBatchRequest.t
type output = DeleteMessageBatchResult.t
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2012-11-05"]); ("Action", ["DeleteMessageBatch"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteMessageBatchRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteMessageBatchRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteMessageBatchResponse" (snd xml))
        (Xml.member "DeleteMessageBatchResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteMessageBatchResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteMessageBatchResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteMessageBatchResult - missing field in body or children: "
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