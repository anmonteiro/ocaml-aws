open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetParametersRequest =
  struct
    type t =
      {
      names: ParameterNameList.t
        [@ocaml.doc
          "<p>Names of the parameters for which you want to query information.</p>"];
      with_decryption: Boolean.t option
        [@ocaml.doc
          "<p>Return decrypted secure string value. Return decrypted values for secure string parameters. This flag is ignored for String and StringList parameter types.</p>"]}
    let make ~names  ?with_decryption  () = { names; with_decryption }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.with_decryption
              (fun f -> ("with_decryption", (Boolean.to_json f)));
           Some ("names", (ParameterNameList.to_json v.names))])
    let of_json j =
      {
        names =
          (ParameterNameList.of_json
             (Util.of_option_exn (Json.lookup j "names")));
        with_decryption =
          (Util.option_map (Json.lookup j "with_decryption") Boolean.of_json)
      }
  end
module GetParametersResult = GetParametersResult
type input = GetParametersRequest.t
type output = GetParametersResult.t
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
            (Query.render (GetParametersRequest.to_query req)))) in
  (`POST, uri, (Headers.render (GetParametersRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (GetParametersResult.of_json json)
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