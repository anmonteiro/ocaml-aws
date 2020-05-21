open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetInventorySchemaRequest =
  struct
    type t =
      {
      type_name: String.t option
        [@ocaml.doc "<p>The type of inventory item to return.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      aggregator: Boolean.t option
        [@ocaml.doc
          "<p>Returns inventory schemas that support aggregation. For example, this call returns the <code>AWS:InstanceInformation</code> type, because it supports aggregation based on the <code>PlatformName</code>, <code>PlatformType</code>, and <code>PlatformVersion</code> attributes.</p>"];
      sub_type: Boolean.t option
        [@ocaml.doc
          "<p>Returns the sub-type schema for a specified inventory type.</p>"]}
    let make ?type_name  ?next_token  ?max_results  ?aggregator  ?sub_type 
      () = { type_name; next_token; max_results; aggregator; sub_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sub_type
              (fun f -> ("sub_type", (Boolean.to_json f)));
           Util.option_map v.aggregator
             (fun f -> ("aggregator", (Boolean.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)))])
    let of_json j =
      {
        type_name =
          (Util.option_map (Json.lookup j "type_name") String.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        aggregator =
          (Util.option_map (Json.lookup j "aggregator") Boolean.of_json);
        sub_type =
          (Util.option_map (Json.lookup j "sub_type") Boolean.of_json)
      }
  end
module GetInventorySchemaResult = GetInventorySchemaResult
type input = GetInventorySchemaRequest.t
type output = GetInventorySchemaResult.t
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
            (Query.render (GetInventorySchemaRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetInventorySchemaRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetInventorySchemaResult.of_json json)
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