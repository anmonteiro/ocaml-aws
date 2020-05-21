open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListComplianceItemsRequest =
  struct
    type t =
      {
      filters: ComplianceStringFilterList.t
        [@ocaml.doc
          "<p>One or more compliance filters. Use a filter to return a more specific list of results.</p>"];
      resource_ids: ComplianceResourceIdList.t
        [@ocaml.doc
          "<p>The ID for the resources from which to get compliance information. Currently, you can only specify one resource ID.</p>"];
      resource_types: ComplianceResourceTypeList.t
        [@ocaml.doc
          "<p>The type of resource from which to get compliance information. Currently, the only supported resource type is <code>ManagedInstance</code>.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A token to start the list. Use this token to get the next set of results. </p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"]}
    let make ?(filters= [])  ?(resource_ids= [])  ?(resource_types= []) 
      ?next_token  ?max_results  () =
      { filters; resource_ids; resource_types; next_token; max_results }
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
             ("resource_types",
               (ComplianceResourceTypeList.to_json v.resource_types));
           Some
             ("resource_ids",
               (ComplianceResourceIdList.to_json v.resource_ids));
           Some ("filters", (ComplianceStringFilterList.to_json v.filters))])
    let of_json j =
      {
        filters =
          (ComplianceStringFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        resource_ids =
          (ComplianceResourceIdList.of_json
             (Util.of_option_exn (Json.lookup j "resource_ids")));
        resource_types =
          (ComplianceResourceTypeList.of_json
             (Util.of_option_exn (Json.lookup j "resource_types")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json)
      }
  end
module ListComplianceItemsResult = ListComplianceItemsResult
type input = ListComplianceItemsRequest.t
type output = ListComplianceItemsResult.t
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
            (Query.render (ListComplianceItemsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (ListComplianceItemsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (ListComplianceItemsResult.of_json json)
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