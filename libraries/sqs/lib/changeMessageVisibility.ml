open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ChangeMessageVisibilityRequest =
  struct
    type t =
      {
      queue_url: String.t
        [@ocaml.doc
          "<p>The URL of the Amazon SQS queue whose message's visibility is changed.</p> <p>Queue URLs and names are case-sensitive.</p>"];
      receipt_handle: String.t
        [@ocaml.doc
          "<p>The receipt handle associated with the message whose visibility timeout is changed. This parameter is returned by the <code> <a>ReceiveMessage</a> </code> action.</p>"];
      visibility_timeout: Integer.t
        [@ocaml.doc
          "<p>The new value for the message's visibility timeout (in seconds). Values values: <code>0</code> to <code>43200</code>. Maximum: 12 hours.</p>"]}
    let make ~queue_url  ~receipt_handle  ~visibility_timeout  () =
      { queue_url; receipt_handle; visibility_timeout }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("visibility_timeout", (Integer.to_json v.visibility_timeout));
           Some ("receipt_handle", (String.to_json v.receipt_handle));
           Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse));
          receipt_handle =
            (Xml.required "ReceiptHandle"
               (Util.option_bind (Xml.member "ReceiptHandle" xml)
                  String.parse));
          visibility_timeout =
            (Xml.required "VisibilityTimeout"
               (Util.option_bind (Xml.member "VisibilityTimeout" xml)
                  Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "QueueUrl" ([], (String.to_xml v.queue_url)))])
            @
            [Some
               (Ezxmlm.make_tag "ReceiptHandle"
                  ([], (String.to_xml v.receipt_handle)))])
           @
           [Some
              (Ezxmlm.make_tag "VisibilityTimeout"
                 ([], (Integer.to_xml v.visibility_timeout)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ChangeMessageVisibilityRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2012-11-05"]);
         ("Action", ["ChangeMessageVisibility"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ChangeMessageVisibilityRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ChangeMessageVisibilityRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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