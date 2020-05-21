open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListComplianceSummariesRequest =
  struct
    type t =
      {
      filters: ComplianceStringFilterList.t
        [@ocaml.doc
          "<p>One or more compliance or inventory filters. Use a filter to return a more specific list of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A token to start the list. Use this token to get the next set of results. </p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. Currently, you can specify null or 50. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"]}
    let make ?(filters= [])  ?next_token  ?max_results  () =
      { filters; next_token; max_results }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (ComplianceStringFilterList.to_json v.filters))])
    let of_json j =
      {
        filters =
          (ComplianceStringFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json)
      }
  end
module ListComplianceSummariesResult = ListComplianceSummariesResult
type input = ListComplianceSummariesRequest.t
type output = ListComplianceSummariesResult.t
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
            (Query.render (ListComplianceSummariesRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (ListComplianceSummariesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (ListComplianceSummariesResult.of_json json)
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