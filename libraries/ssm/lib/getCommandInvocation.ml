open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetCommandInvocationRequest =
  struct
    type t =
      {
      command_id: String.t
        [@ocaml.doc
          "<p>(Required) The parent command ID of the invocation plugin.</p>"];
      instance_id: String.t
        [@ocaml.doc
          "<p>(Required) The ID of the managed instance targeted by the command. A managed instance can be an Amazon EC2 instance or an instance in your hybrid environment that is configured for Systems Manager.</p>"];
      plugin_name: String.t option
        [@ocaml.doc
          "<p>(Optional) The name of the plugin for which you want detailed results. If the document contains only one plugin, the name can be omitted and the details will be returned.</p>"]}
    let make ~command_id  ~instance_id  ?plugin_name  () =
      { command_id; instance_id; plugin_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.plugin_name
              (fun f -> ("plugin_name", (String.to_json f)));
           Some ("instance_id", (String.to_json v.instance_id));
           Some ("command_id", (String.to_json v.command_id))])
    let of_json j =
      {
        command_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "command_id")));
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        plugin_name =
          (Util.option_map (Json.lookup j "plugin_name") String.of_json)
      }
  end
module GetCommandInvocationResult = GetCommandInvocationResult
type input = GetCommandInvocationRequest.t
type output = GetCommandInvocationResult.t
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
            (Query.render (GetCommandInvocationRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetCommandInvocationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetCommandInvocationResult.of_json json)
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