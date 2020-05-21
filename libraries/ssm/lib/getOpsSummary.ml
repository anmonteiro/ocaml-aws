open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetOpsSummaryRequest =
  struct
    type t =
      {
      sync_name: String.t option
        [@ocaml.doc
          "<p>Specify the name of a resource data sync to get.</p>"];
      filters: OpsFilterList.t
        [@ocaml.doc
          "<p>Optional filters used to scope down the returned OpsItems. </p>"];
      aggregators: OpsAggregatorList.t
        [@ocaml.doc
          "<p>Optional aggregators that return counts of OpsItems based on one or more expressions.</p>"];
      result_attributes: OpsResultAttributeList.t
        [@ocaml.doc "<p>The OpsItem data type to return.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A token to start the list. Use this token to get the next set of results. </p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"]}
    let make ?sync_name  ?(filters= [])  ?(aggregators= []) 
      ?(result_attributes= [])  ?next_token  ?max_results  () =
      {
        sync_name;
        filters;
        aggregators;
        result_attributes;
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
             ("result_attributes",
               (OpsResultAttributeList.to_json v.result_attributes));
           Some ("aggregators", (OpsAggregatorList.to_json v.aggregators));
           Some ("filters", (OpsFilterList.to_json v.filters));
           Util.option_map v.sync_name
             (fun f -> ("sync_name", (String.to_json f)))])
    let of_json j =
      {
        sync_name =
          (Util.option_map (Json.lookup j "sync_name") String.of_json);
        filters =
          (OpsFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        aggregators =
          (OpsAggregatorList.of_json
             (Util.of_option_exn (Json.lookup j "aggregators")));
        result_attributes =
          (OpsResultAttributeList.of_json
             (Util.of_option_exn (Json.lookup j "result_attributes")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json)
      }
  end
module GetOpsSummaryResult = GetOpsSummaryResult
type input = GetOpsSummaryRequest.t
type output = GetOpsSummaryResult.t
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
            (Query.render (GetOpsSummaryRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetOpsSummaryRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetOpsSummaryResult.of_json json)
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