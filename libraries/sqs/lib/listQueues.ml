open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListQueuesRequest =
  struct
    type t =
      {
      queue_name_prefix: String.t option
        [@ocaml.doc
          "<p>A string to use for filtering the list results. Only those queues whose name begins with the specified string are returned.</p> <p>Queue URLs and names are case-sensitive.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?queue_name_prefix  () = { queue_name_prefix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.queue_name_prefix
              (fun f -> ("queue_name_prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          queue_name_prefix =
            (Util.option_bind (Xml.member "QueueNamePrefix" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.queue_name_prefix
              (fun f ->
                 Ezxmlm.make_tag "QueueNamePrefix" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module ListQueuesResult = ListQueuesResult
type input = ListQueuesRequest.t
type output = ListQueuesResult.t
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2012-11-05"]); ("Action", ["ListQueues"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListQueuesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ListQueuesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListQueuesResponse" (snd xml))
        (Xml.member "ListQueuesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListQueuesResult.parse)
          (BadResponse
             { body; message = "Could not find well formed ListQueuesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListQueuesResult - missing field in body or children: "
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