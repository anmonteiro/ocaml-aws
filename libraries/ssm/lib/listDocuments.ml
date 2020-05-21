open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListDocumentsRequest =
  struct
    type t =
      {
      document_filter_list: DocumentFilterList.t
        [@ocaml.doc
          "<p>One or more filters. Use a filter to return a more specific list of results.</p>"];
      filters: DocumentKeyValuesFilterList.t
        [@ocaml.doc
          "<p>One or more filters. Use a filter to return a more specific list of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ?(document_filter_list= [])  ?(filters= [])  ?max_results 
      ?next_token  () =
      { document_filter_list; filters; max_results; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filters", (DocumentKeyValuesFilterList.to_json v.filters));
           Some
             ("document_filter_list",
               (DocumentFilterList.to_json v.document_filter_list))])
    let of_json j =
      {
        document_filter_list =
          (DocumentFilterList.of_json
             (Util.of_option_exn (Json.lookup j "document_filter_list")));
        filters =
          (DocumentKeyValuesFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ListDocumentsResult = ListDocumentsResult
type input = ListDocumentsRequest.t
type output = ListDocumentsResult.t
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
            (Query.render (ListDocumentsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (ListDocumentsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (ListDocumentsResult.of_json json)
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