open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListStackInstancesInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name or unique ID of the stack set that you want to list stack instances for.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the previous request didn't return all of the remaining results, the response's <code>NextToken</code> parameter value is set to a token. To retrieve the next set of results, call <code>ListStackInstances</code> again and assign that token to the request object's <code>NextToken</code> parameter. If there are no remaining results, the previous response object's <code>NextToken</code> parameter is set to <code>null</code>.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to be returned with a single call. If the number of available results exceeds this maximum, the response includes a <code>NextToken</code> value that you can assign to the <code>NextToken</code> request parameter to get the next set of results.</p>"];
      stack_instance_account: String.t option
        [@ocaml.doc
          "<p>The name of the AWS account that you want to list stack instances for.</p>"];
      stack_instance_region: String.t option
        [@ocaml.doc
          "<p>The name of the region where you want to list stack instances. </p>"]}
    let make ~stack_set_name  ?next_token  ?max_results 
      ?stack_instance_account  ?stack_instance_region  () =
      {
        stack_set_name;
        next_token;
        max_results;
        stack_instance_account;
        stack_instance_region
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_instance_region
              (fun f -> ("stack_instance_region", (String.to_json f)));
           Util.option_map v.stack_instance_account
             (fun f -> ("stack_instance_account", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("stack_set_name", (String.to_json v.stack_set_name))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Xml.required "StackSetName"
               (Util.option_bind (Xml.member "StackSetName" xml) String.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          stack_instance_account =
            (Util.option_bind (Xml.member "StackInstanceAccount" xml)
               String.parse);
          stack_instance_region =
            (Util.option_bind (Xml.member "StackInstanceRegion" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "StackSetName"
                     ([], (String.to_xml v.stack_set_name)))])
              @
              [Util.option_map v.next_token
                 (fun f ->
                    Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.stack_instance_account
               (fun f ->
                  Ezxmlm.make_tag "StackInstanceAccount"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.stack_instance_region
              (fun f ->
                 Ezxmlm.make_tag "StackInstanceRegion"
                   ([], (String.to_xml f)))])
  end
module ListStackInstancesOutput = ListStackInstancesOutput
type input = ListStackInstancesInput.t
type output = ListStackInstancesOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["ListStackInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListStackInstancesInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListStackInstancesInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListStackInstancesResponse" (snd xml))
        (Xml.member "ListStackInstancesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListStackInstancesOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListStackInstancesOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListStackInstancesOutput - missing field in body or children: "
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