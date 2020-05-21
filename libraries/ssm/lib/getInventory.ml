open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetInventoryRequest =
  struct
    type t =
      {
      filters: InventoryFilterList.t
        [@ocaml.doc
          "<p>One or more filters. Use a filter to return a more specific list of results.</p>"];
      aggregators: InventoryAggregatorList.t
        [@ocaml.doc
          "<p>Returns counts of inventory types based on one or more expressions. For example, if you aggregate by using an expression that uses the <code>AWS:InstanceInformation.PlatformType</code> type, you can see a count of how many Windows and Linux instances exist in your inventoried fleet.</p>"];
      result_attributes: ResultAttributeList.t
        [@ocaml.doc "<p>The list of inventory item types to return.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"]}
    let make ?(filters= [])  ?(aggregators= [])  ?(result_attributes= []) 
      ?next_token  ?max_results  () =
      { filters; aggregators; result_attributes; next_token; max_results }
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
               (ResultAttributeList.to_json v.result_attributes));
           Some
             ("aggregators", (InventoryAggregatorList.to_json v.aggregators));
           Some ("filters", (InventoryFilterList.to_json v.filters))])
    let of_json j =
      {
        filters =
          (InventoryFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        aggregators =
          (InventoryAggregatorList.of_json
             (Util.of_option_exn (Json.lookup j "aggregators")));
        result_attributes =
          (ResultAttributeList.of_json
             (Util.of_option_exn (Json.lookup j "result_attributes")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json)
      }
  end
module GetInventoryResult = GetInventoryResult
type input = GetInventoryRequest.t
type output = GetInventoryResult.t
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
            (Query.render (GetInventoryRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetInventoryRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetInventoryResult.of_json json)
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