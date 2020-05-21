open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListCommandInvocationsRequest =
  struct
    type t =
      {
      command_id: String.t option
        [@ocaml.doc
          "<p>(Optional) The invocations for a specific command ID.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>(Optional) The command execution details for a specific instance ID.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>(Optional) The token for the next set of items to return. (You received this token from a previous call.)</p>"];
      filters: CommandFilterList.t
        [@ocaml.doc
          "<p>(Optional) One or more filters. Use a filter to return a more specific list of results. Note that the <code>DocumentName</code> filter is not supported for ListCommandInvocations.</p>"];
      details: Boolean.t option
        [@ocaml.doc
          "<p>(Optional) If set this returns the response of the command executions and any command output. By default this is set to False. </p>"]}
    let make ?command_id  ?instance_id  ?max_results  ?next_token  ?(filters=
      [])  ?details  () =
      { command_id; instance_id; max_results; next_token; filters; details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (Boolean.to_json f)));
           Some ("filters", (CommandFilterList.to_json v.filters));
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
             (Util.of_option_exn (Json.lookup j "filters")));
        details = (Util.option_map (Json.lookup j "details") Boolean.of_json)
      }
  end
module ListCommandInvocationsResult = ListCommandInvocationsResult
type input = ListCommandInvocationsRequest.t
type output = ListCommandInvocationsResult.t
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
            (Query.render (ListCommandInvocationsRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (ListCommandInvocationsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (ListCommandInvocationsResult.of_json json)
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