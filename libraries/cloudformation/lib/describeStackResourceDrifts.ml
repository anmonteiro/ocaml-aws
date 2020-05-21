open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeStackResourceDriftsInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name of the stack for which you want drift information.</p>"];
      stack_resource_drift_status_filters: StackResourceDriftStatusFilters.t
        [@ocaml.doc
          "<p>The resource drift status values to use as filters for the resource drift results returned.</p> <ul> <li> <p> <code>DELETED</code>: The resource differs from its expected template configuration in that the resource has been deleted.</p> </li> <li> <p> <code>MODIFIED</code>: One or more resource properties differ from their expected template values.</p> </li> <li> <p> <code>IN_SYNC</code>: The resources's actual configuration matches its expected template configuration.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation does not currently return this value.</p> </li> </ul>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that identifies the next page of stack resource drift results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to be returned with a single call. If the number of available results exceeds this maximum, the response includes a <code>NextToken</code> value that you can assign to the <code>NextToken</code> request parameter to get the next set of results.</p>"]}
    let make ~stack_name  ?(stack_resource_drift_status_filters= []) 
      ?next_token  ?max_results  () =
      {
        stack_name;
        stack_resource_drift_status_filters;
        next_token;
        max_results
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("stack_resource_drift_status_filters",
               (StackResourceDriftStatusFilters.to_json
                  v.stack_resource_drift_status_filters));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          stack_resource_drift_status_filters =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "StackResourceDriftStatusFilters" xml)
                  StackResourceDriftStatusFilters.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "StackName"
                    ([], (String.to_xml v.stack_name)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "StackResourceDriftStatusFilters"
                        ([], (StackResourceDriftStatusFilters.to_xml [x]))))
                v.stack_resource_drift_status_filters))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end
module DescribeStackResourceDriftsOutput = DescribeStackResourceDriftsOutput
type input = DescribeStackResourceDriftsInput.t
type output = DescribeStackResourceDriftsOutput.t
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
         ("Action", ["DescribeStackResourceDrifts"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeStackResourceDriftsInput.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeStackResourceDriftsInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeStackResourceDriftsResponse" (snd xml))
        (Xml.member "DescribeStackResourceDriftsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeStackResourceDriftsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeStackResourceDriftsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeStackResourceDriftsOutput - missing field in body or children: "
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