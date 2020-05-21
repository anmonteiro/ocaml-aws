open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribePatchGroupsRequest =
  struct
    type t =
      {
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of patch groups to return (per page).</p>"];
      filters: PatchOrchestratorFilterList.t
        [@ocaml.doc
          "<p>One or more filters. Use a filter to return a more specific list of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ?max_results  ?(filters= [])  ?next_token  () =
      { max_results; filters; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (PatchOrchestratorFilterList.to_json v.filters));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)))])
    let of_json j =
      {
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        filters =
          (PatchOrchestratorFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribePatchGroupsResult = DescribePatchGroupsResult
type input = DescribePatchGroupsRequest.t
type output = DescribePatchGroupsResult.t
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
            (Query.render (DescribePatchGroupsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DescribePatchGroupsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribePatchGroupsResult.of_json json)
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