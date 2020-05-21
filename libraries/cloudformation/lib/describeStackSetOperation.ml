open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStackSetOperationInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name or the unique stack ID of the stack set for the stack operation.</p>"];
      operation_id: String.t
        [@ocaml.doc "<p>The unique ID of the stack set operation. </p>"]}
    let make ~stack_set_name  ~operation_id  () =
      { stack_set_name; operation_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("operation_id", (String.to_json v.operation_id));
           Some ("stack_set_name", (String.to_json v.stack_set_name))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Xml.required "StackSetName"
               (Util.option_bind (Xml.member "StackSetName" xml) String.parse));
          operation_id =
            (Xml.required "OperationId"
               (Util.option_bind (Xml.member "OperationId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackSetName"
                  ([], (String.to_xml v.stack_set_name)))])
           @
           [Some
              (Ezxmlm.make_tag "OperationId"
                 ([], (String.to_xml v.operation_id)))])
  end
module DescribeStackSetOperationOutput = DescribeStackSetOperationOutput
type input = DescribeStackSetOperationInput.t
type output = DescribeStackSetOperationOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]);
         ("Action", ["DescribeStackSetOperation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeStackSetOperationInput.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeStackSetOperationInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeStackSetOperationResponse" (snd xml))
        (Xml.member "DescribeStackSetOperationResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeStackSetOperationOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeStackSetOperationOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStackSetOperationOutput - missing field in body or children: "
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