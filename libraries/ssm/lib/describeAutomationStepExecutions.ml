open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAutomationStepExecutionsRequest =
  struct
    type t =
      {
      automation_execution_id: String.t
        [@ocaml.doc
          "<p>The Automation execution ID for which you want step execution descriptions.</p>"];
      filters: StepExecutionFilterList.t
        [@ocaml.doc
          "<p>One or more filters to limit the number of step executions returned by the request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      reverse_order: Boolean.t option
        [@ocaml.doc
          "<p>A boolean that indicates whether to list step executions in reverse order by start time. The default value is false.</p>"]}
    let make ~automation_execution_id  ?(filters= [])  ?next_token 
      ?max_results  ?reverse_order  () =
      {
        automation_execution_id;
        filters;
        next_token;
        max_results;
        reverse_order
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reverse_order
              (fun f -> ("reverse_order", (Boolean.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (StepExecutionFilterList.to_json v.filters));
           Some
             ("automation_execution_id",
               (String.to_json v.automation_execution_id))])
    let of_json j =
      {
        automation_execution_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "automation_execution_id")));
        filters =
          (StepExecutionFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        reverse_order =
          (Util.option_map (Json.lookup j "reverse_order") Boolean.of_json)
      }
  end
module DescribeAutomationStepExecutionsResult =
  DescribeAutomationStepExecutionsResult
type input = DescribeAutomationStepExecutionsRequest.t
type output = DescribeAutomationStepExecutionsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (DescribeAutomationStepExecutionsRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DescribeAutomationStepExecutionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeAutomationStepExecutionsResult.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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