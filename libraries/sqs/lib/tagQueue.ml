open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module TagQueueRequest =
  struct
    type t =
      {
      queue_url: String.t [@ocaml.doc "<p>The URL of the queue.</p>"];
      tags: TagMap.t
        [@ocaml.doc
          "<p>The list of tags to be added to the specified queue.</p>"]}
    let make ~queue_url  ~tags  () = { queue_url; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagMap.to_json v.tags));
           Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse));
          tags =
            (Xml.required "Tags"
               (Util.option_bind (Xml.member "Tags" xml) TagMap.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "QueueUrl" ([], (String.to_xml v.queue_url)))])
           @ [Some (Ezxmlm.make_tag "Tags" ([], (TagMap.to_xml v.tags)))])
  end
module Output = Aws.BaseTypes.Unit
type input = TagQueueRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2012-11-05"]); ("Action", ["TagQueue"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (TagQueueRequest.to_query req))))) in
  (`POST, uri, (Headers.render (TagQueueRequest.to_headers req)), "")
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