open Types
open Aws
type input = DeleteObjectsRequest.t
type output = DeleteObjectsOutput.t
type error = Errors_internal.t
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.DeleteObjectsRequest.bucket) ^ "?delete")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DeleteObjectsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DeleteObjectsRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "Delete"
          ([], (Delete.to_xml req.DeleteObjectsRequest.delete))]))
let of_http body =
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise (Failure "Could not find well formed DeleteObjectsOutput.") in
    try
      Util.or_error (Util.option_bind resp DeleteObjectsOutput.parse)
        (let open Error in
           BadResponse
             {
               body;
               message = "Could not find well formed DeleteObjectsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteObjectsOutput - missing field in body or children: "
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