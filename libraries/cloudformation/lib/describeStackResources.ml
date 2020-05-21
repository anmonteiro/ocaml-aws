open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStackResourcesInput =
  struct
    type t =
      {
      stack_name: String.t option
        [@ocaml.doc
          "<p>The name or the unique stack ID that is associated with the stack, which are not always interchangeable:</p> <ul> <li> <p>Running stacks: You can specify either the stack's name or its unique stack ID.</p> </li> <li> <p>Deleted stacks: You must specify the unique stack ID.</p> </li> </ul> <p>Default: There is no default value.</p> <p>Required: Conditional. If you do not specify <code>StackName</code>, you must specify <code>PhysicalResourceId</code>.</p>"];
      logical_resource_id: String.t option
        [@ocaml.doc
          "<p>The logical name of the resource as specified in the template.</p> <p>Default: There is no default value.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The name or unique identifier that corresponds to a physical instance ID of a resource supported by AWS CloudFormation.</p> <p>For example, for an Amazon Elastic Compute Cloud (EC2) instance, <code>PhysicalResourceId</code> corresponds to the <code>InstanceId</code>. You can pass the EC2 <code>InstanceId</code> to <code>DescribeStackResources</code> to find which stack the instance belongs to and what other resources are part of the stack.</p> <p>Required: Conditional. If you do not specify <code>PhysicalResourceId</code>, you must specify <code>StackName</code>.</p> <p>Default: There is no default value.</p>"]}
    [@@ocaml.doc
      "<p>The input for <a>DescribeStackResources</a> action.</p>"]
    let make ?stack_name  ?logical_resource_id  ?physical_resource_id  () =
      { stack_name; logical_resource_id; physical_resource_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.physical_resource_id
              (fun f -> ("physical_resource_id", (String.to_json f)));
           Util.option_map v.logical_resource_id
             (fun f -> ("logical_resource_id", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          logical_resource_id =
            (Util.option_bind (Xml.member "LogicalResourceId" xml)
               String.parse);
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.stack_name
                (fun f -> Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.logical_resource_id
               (fun f ->
                  Ezxmlm.make_tag "LogicalResourceId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.physical_resource_id
              (fun f ->
                 Ezxmlm.make_tag "PhysicalResourceId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The input for <a>DescribeStackResources</a> action.</p>"]
module DescribeStackResourcesOutput = DescribeStackResourcesOutput
type input = DescribeStackResourcesInput.t
type output = DescribeStackResourcesOutput.t
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
         ("Action", ["DescribeStackResources"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeStackResourcesInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeStackResourcesInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeStackResourcesResponse" (snd xml))
        (Xml.member "DescribeStackResourcesResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeStackResourcesOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeStackResourcesOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStackResourcesOutput - missing field in body or children: "
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