open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStackInstanceInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name or the unique stack ID of the stack set that you want to get stack instance information for.</p>"];
      stack_instance_account: String.t
        [@ocaml.doc
          "<p>The ID of an AWS account that's associated with this stack instance.</p>"];
      stack_instance_region: String.t
        [@ocaml.doc
          "<p>The name of a region that's associated with this stack instance.</p>"]}
    let make ~stack_set_name  ~stack_instance_account  ~stack_instance_region
       () = { stack_set_name; stack_instance_account; stack_instance_region }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("stack_instance_region",
                (String.to_json v.stack_instance_region));
           Some
             ("stack_instance_account",
               (String.to_json v.stack_instance_account));
           Some ("stack_set_name", (String.to_json v.stack_set_name))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Xml.required "StackSetName"
               (Util.option_bind (Xml.member "StackSetName" xml) String.parse));
          stack_instance_account =
            (Xml.required "StackInstanceAccount"
               (Util.option_bind (Xml.member "StackInstanceAccount" xml)
                  String.parse));
          stack_instance_region =
            (Xml.required "StackInstanceRegion"
               (Util.option_bind (Xml.member "StackInstanceRegion" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "StackSetName"
                   ([], (String.to_xml v.stack_set_name)))])
            @
            [Some
               (Ezxmlm.make_tag "StackInstanceAccount"
                  ([], (String.to_xml v.stack_instance_account)))])
           @
           [Some
              (Ezxmlm.make_tag "StackInstanceRegion"
                 ([], (String.to_xml v.stack_instance_region)))])
  end
module DescribeStackInstanceOutput = DescribeStackInstanceOutput
type input = DescribeStackInstanceInput.t
type output = DescribeStackInstanceOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["DescribeStackInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeStackInstanceInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeStackInstanceInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeStackInstanceResponse" (snd xml))
        (Xml.member "DescribeStackInstanceResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeStackInstanceOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeStackInstanceOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStackInstanceOutput - missing field in body or children: "
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