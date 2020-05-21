open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CancelCommandRequest =
  struct
    type t =
      {
      command_id: String.t
        [@ocaml.doc "<p>The ID of the command you want to cancel.</p>"];
      instance_ids: InstanceIdList.t
        [@ocaml.doc
          "<p>(Optional) A list of instance IDs on which you want to cancel the command. If not provided, the command is canceled on every instance on which it was requested.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~command_id  ?(instance_ids= [])  () =
      { command_id; instance_ids }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("instance_ids", (InstanceIdList.to_json v.instance_ids));
           Some ("command_id", (String.to_json v.command_id))])
    let of_json j =
      {
        command_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "command_id")));
        instance_ids =
          (InstanceIdList.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")))
      }
  end[@@ocaml.doc "<p/>"]
module Output = Aws.BaseTypes.Unit
type input = CancelCommandRequest.t
type output = unit
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
            (Query.render (CancelCommandRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CancelCommandRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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