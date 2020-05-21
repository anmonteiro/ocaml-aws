open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListCommandsRequest =
  struct
    type t =
      {
      command_id: String.t option
        [@ocaml.doc
          "<p>(Optional) If provided, lists only the specified command.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>(Optional) Lists commands issued against this instance ID.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>(Optional) The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      filters: CommandFilterList.t
        [@ocaml.doc
          "<p>(Optional) One or more filters. Use a filter to return a more specific list of results. </p>"]}
    let make ?command_id  ?instance_id  ?max_results  ?next_token  ?(filters=
      [])  () = { command_id; instance_id; max_results; next_token; filters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filters", (CommandFilterList.to_json v.filters));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.command_id
             (fun f -> ("command_id", (String.to_json f)))])
    let of_json j =
      {
        command_id =
          (Util.option_map (Json.lookup j "command_id") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        filters =
          (CommandFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")))
      }
  end
module ListCommandsResult = ListCommandsResult
type input = ListCommandsRequest.t
type output = ListCommandsResult.t
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
            (Query.render (ListCommandsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (ListCommandsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (ListCommandsResult.of_json json)
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