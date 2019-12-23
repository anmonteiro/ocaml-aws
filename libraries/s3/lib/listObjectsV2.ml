open Types
open Aws
type input = ListObjectsV2Request.t
type output = ListObjectsV2Output.t
type error = Errors_internal.t
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.ListObjectsV2Request.bucket) ^ "?list-type=2")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListObjectsV2Request.to_query req)))) in
  (`GET, uri, (Headers.render (ListObjectsV2Request.to_headers req)), "")
let of_http body =
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise (Failure "Could not find well formed ListObjectsV2Output.") in
    try
      Util.or_error (Util.option_bind resp ListObjectsV2Output.parse)
        (let open Error in
           BadResponse
             {
               body;
               message = "Could not find well formed ListObjectsV2Output."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListObjectsV2Output - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      `Error
        (let open Error in
           BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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