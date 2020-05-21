open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStacksInput =
  struct
    type t =
      {
      stack_name: String.t option
        [@ocaml.doc
          "<p>The name or the unique stack ID that is associated with the stack, which are not always interchangeable:</p> <ul> <li> <p>Running stacks: You can specify either the stack's name or its unique stack ID.</p> </li> <li> <p>Deleted stacks: You must specify the unique stack ID.</p> </li> </ul> <p>Default: There is no default value.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that identifies the next page of stacks that you want to retrieve.</p>"]}
    [@@ocaml.doc "<p>The input for <a>DescribeStacks</a> action.</p>"]
    let make ?stack_name  ?next_token  () = { stack_name; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.stack_name
               (fun f -> Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The input for <a>DescribeStacks</a> action.</p>"]
module DescribeStacksOutput = DescribeStacksOutput
type input = DescribeStacksInput.t
type output = DescribeStacksOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DescribeStacks"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeStacksInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeStacksInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeStacksResponse" (snd xml))
        (Xml.member "DescribeStacksResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeStacksOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeStacksOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStacksOutput - missing field in body or children: "
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