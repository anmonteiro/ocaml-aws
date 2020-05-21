open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateServiceSettingRequest =
  struct
    type t =
      {
      setting_id: String.t
        [@ocaml.doc "<p>The ID of the service setting to update.</p>"];
      setting_value: String.t
        [@ocaml.doc
          "<p>The new value to specify for the service setting.</p>"]}
    [@@ocaml.doc
      "<p>The request body of the UpdateServiceSetting API action.</p>"]
    let make ~setting_id  ~setting_value  () = { setting_id; setting_value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("setting_value", (String.to_json v.setting_value));
           Some ("setting_id", (String.to_json v.setting_id))])
    let of_json j =
      {
        setting_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "setting_id")));
        setting_value =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "setting_value")))
      }
  end[@@ocaml.doc
       "<p>The request body of the UpdateServiceSetting API action.</p>"]
module Output = Aws.BaseTypes.Unit
type input = UpdateServiceSettingRequest.t
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
            (Query.render (UpdateServiceSettingRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdateServiceSettingRequest.to_headers req)),
    "")
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