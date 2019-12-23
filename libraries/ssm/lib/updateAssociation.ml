open Types
open Aws
type input = UpdateAssociationRequest.t
type output = UpdateAssociationResult.t
type error = Errors_internal.t
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UpdateAssociationRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdateAssociationRequest.to_headers req)),
    "")
let of_http body =
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateAssociationResult.of_json json)
  with
  | Yojson.Json_error msg ->
      `Error
        (let open Error in
           BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some var ->
      if
        (List.mem var errors) &&
          ((match Errors_internal.to_http_code var with
            | Some var -> var = code
            | None -> true))
      then Some var
      else None
  | None -> None