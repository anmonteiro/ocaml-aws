open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListStacksInput =
  struct
    type t =
      {
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that identifies the next page of stacks that you want to retrieve.</p>"];
      stack_status_filter: StackStatusFilter.t
        [@ocaml.doc
          "<p>Stack status to use as a filter. Specify one or more stack status codes to list only stacks with the specified status codes. For a complete list of stack status codes, see the <code>StackStatus</code> parameter of the <a>Stack</a> data type.</p>"]}
    [@@ocaml.doc "<p>The input for <a>ListStacks</a> action.</p>"]
    let make ?next_token  ?(stack_status_filter= [])  () =
      { next_token; stack_status_filter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("stack_status_filter",
                (StackStatusFilter.to_json v.stack_status_filter));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          stack_status_filter =
            (Util.of_option []
               (Util.option_bind (Xml.member "StackStatusFilter" xml)
                  StackStatusFilter.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "StackStatusFilter"
                      ([], (StackStatusFilter.to_xml [x]))))
              v.stack_status_filter))
  end[@@ocaml.doc "<p>The input for <a>ListStacks</a> action.</p>"]
module ListStacksOutput = ListStacksOutput
type input = ListStacksInput.t
type output = ListStacksOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-05-15"]); ("Action", ["ListStacks"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListStacksInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListStacksInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListStacksResponse" (snd xml))
        (Xml.member "ListStacksResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListStacksOutput.parse)
          (BadResponse
             { body; message = "Could not find well formed ListStacksOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListStacksOutput - missing field in body or children: "
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