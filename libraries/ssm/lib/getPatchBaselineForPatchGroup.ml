open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetPatchBaselineForPatchGroupRequest =
  struct
    type t =
      {
      patch_group: String.t
        [@ocaml.doc
          "<p>The name of the patch group whose patch baseline should be retrieved.</p>"];
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>Returns he operating system rule specified for patch groups using the patch baseline.</p>"]}
    let make ~patch_group  ?operating_system  () =
      { patch_group; operating_system }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operating_system
              (fun f -> ("operating_system", (OperatingSystem.to_json f)));
           Some ("patch_group", (String.to_json v.patch_group))])
    let of_json j =
      {
        patch_group =
          (String.of_json (Util.of_option_exn (Json.lookup j "patch_group")));
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json)
      }
  end
module GetPatchBaselineForPatchGroupResult =
  GetPatchBaselineForPatchGroupResult
type input = GetPatchBaselineForPatchGroupRequest.t
type output = GetPatchBaselineForPatchGroupResult.t
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
            (Query.render (GetPatchBaselineForPatchGroupRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (GetPatchBaselineForPatchGroupRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetPatchBaselineForPatchGroupResult.of_json json)
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