open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribePatchGroupStateRequest =
  struct
    type t =
      {
      patch_group: String.t
        [@ocaml.doc
          "<p>The name of the patch group whose patch snapshot should be retrieved.</p>"]}
    let make ~patch_group  () = { patch_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("patch_group", (String.to_json v.patch_group))])
    let of_json j =
      {
        patch_group =
          (String.of_json (Util.of_option_exn (Json.lookup j "patch_group")))
      }
  end
module DescribePatchGroupStateResult = DescribePatchGroupStateResult
type input = DescribePatchGroupStateRequest.t
type output = DescribePatchGroupStateResult.t
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
            (Query.render (DescribePatchGroupStateRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DescribePatchGroupStateRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribePatchGroupStateResult.of_json json)
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