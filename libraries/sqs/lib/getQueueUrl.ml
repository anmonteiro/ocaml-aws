open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetQueueUrlRequest =
  struct
    type t =
      {
      queue_name: String.t
        [@ocaml.doc
          "<p>The name of the queue whose URL must be fetched. Maximum 80 characters. Valid values: alphanumeric characters, hyphens (<code>-</code>), and underscores (<code>_</code>).</p> <p>Queue URLs and names are case-sensitive.</p>"];
      queue_owner_a_w_s_account_id: String.t option
        [@ocaml.doc
          "<p>The AWS account ID of the account that created the queue.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~queue_name  ?queue_owner_a_w_s_account_id  () =
      { queue_name; queue_owner_a_w_s_account_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.queue_owner_a_w_s_account_id
              (fun f -> ("queue_owner_a_w_s_account_id", (String.to_json f)));
           Some ("queue_name", (String.to_json v.queue_name))])
    let parse xml =
      Some
        {
          queue_name =
            (Xml.required "QueueName"
               (Util.option_bind (Xml.member "QueueName" xml) String.parse));
          queue_owner_a_w_s_account_id =
            (Util.option_bind (Xml.member "QueueOwnerAWSAccountId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "QueueName"
                  ([], (String.to_xml v.queue_name)))])
           @
           [Util.option_map v.queue_owner_a_w_s_account_id
              (fun f ->
                 Ezxmlm.make_tag "QueueOwnerAWSAccountId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module GetQueueUrlResult = GetQueueUrlResult
type input = GetQueueUrlRequest.t
type output = GetQueueUrlResult.t
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2012-11-05"]); ("Action", ["GetQueueUrl"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetQueueUrlRequest.to_query req))))) in
  (`POST, uri, (Headers.render (GetQueueUrlRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetQueueUrlResponse" (snd xml))
        (Xml.member "GetQueueUrlResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetQueueUrlResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetQueueUrlResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetQueueUrlResult - missing field in body or children: "
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