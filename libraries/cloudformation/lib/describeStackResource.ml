open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStackResourceInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name or the unique stack ID that is associated with the stack, which are not always interchangeable:</p> <ul> <li> <p>Running stacks: You can specify either the stack's name or its unique stack ID.</p> </li> <li> <p>Deleted stacks: You must specify the unique stack ID.</p> </li> </ul> <p>Default: There is no default value.</p>"];
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical name of the resource as specified in the template.</p> <p>Default: There is no default value.</p>"]}
    [@@ocaml.doc "<p>The input for <a>DescribeStackResource</a> action.</p>"]
    let make ~stack_name  ~logical_resource_id  () =
      { stack_name; logical_resource_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("logical_resource_id", (String.to_json v.logical_resource_id));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackName"
                  ([], (String.to_xml v.stack_name)))])
           @
           [Some
              (Ezxmlm.make_tag "LogicalResourceId"
                 ([], (String.to_xml v.logical_resource_id)))])
  end[@@ocaml.doc
       "<p>The input for <a>DescribeStackResource</a> action.</p>"]
module DescribeStackResourceOutput = DescribeStackResourceOutput
type input = DescribeStackResourceInput.t
type output = DescribeStackResourceOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DescribeStackResource"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeStackResourceInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeStackResourceInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeStackResourceResponse" (snd xml))
        (Xml.member "DescribeStackResourceResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeStackResourceOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeStackResourceOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStackResourceOutput - missing field in body or children: "
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