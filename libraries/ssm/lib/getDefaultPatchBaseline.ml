open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetDefaultPatchBaselineRequest =
  struct
    type t =
      {
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>Returns the default patch baseline for the specified operating system.</p>"]}
    let make ?operating_system  () = { operating_system }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operating_system
              (fun f -> ("operating_system", (OperatingSystem.to_json f)))])
    let of_json j =
      {
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json)
      }
  end
module GetDefaultPatchBaselineResult = GetDefaultPatchBaselineResult
type input = GetDefaultPatchBaselineRequest.t
type output = GetDefaultPatchBaselineResult.t
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
            (Query.render (GetDefaultPatchBaselineRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (GetDefaultPatchBaselineRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetDefaultPatchBaselineResult.of_json json)
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