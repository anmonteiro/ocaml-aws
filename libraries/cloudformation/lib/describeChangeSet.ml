open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeChangeSetInput =
  struct
    type t =
      {
      change_set_name: String.t
        [@ocaml.doc
          "<p>The name or Amazon Resource Name (ARN) of the change set that you want to describe.</p>"];
      stack_name: String.t option
        [@ocaml.doc
          "<p>If you specified the name of a change set, specify the stack name or ID (ARN) of the change set you want to describe.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string (provided by the <a>DescribeChangeSet</a> response output) that identifies the next page of information that you want to retrieve.</p>"]}
    [@@ocaml.doc "<p>The input for the <a>DescribeChangeSet</a> action.</p>"]
    let make ~change_set_name  ?stack_name  ?next_token  () =
      { change_set_name; stack_name; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)));
           Some ("change_set_name", (String.to_json v.change_set_name))])
    let parse xml =
      Some
        {
          change_set_name =
            (Xml.required "ChangeSetName"
               (Util.option_bind (Xml.member "ChangeSetName" xml)
                  String.parse));
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ChangeSetName"
                   ([], (String.to_xml v.change_set_name)))])
            @
            [Util.option_map v.stack_name
               (fun f -> Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The input for the <a>DescribeChangeSet</a> action.</p>"]
module DescribeChangeSetOutput = DescribeChangeSetOutput
type input = DescribeChangeSetInput.t
type output = DescribeChangeSetOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DescribeChangeSet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeChangeSetInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeChangeSetInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeChangeSetResponse" (snd xml))
        (Xml.member "DescribeChangeSetResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeChangeSetOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeChangeSetOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeChangeSetOutput - missing field in body or children: "
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