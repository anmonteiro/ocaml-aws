open Types
open Aws
type input = PutPublicAccessBlockRequest.t
type output = unit
type error = Errors_internal.t
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutPublicAccessBlockRequest.bucket) ^
               "?publicAccessBlock")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutPublicAccessBlockRequest.to_query req)))) in
  (`PUT, uri, (Headers.render (PutPublicAccessBlockRequest.to_headers req)),
    (Ezxmlm.to_string
       [Ezxmlm.make_tag "PublicAccessBlockConfiguration"
          ([],
            (PublicAccessBlockConfiguration.to_xml
               req.PutPublicAccessBlockRequest.public_access_block_configuration))]))
let of_http body = `Ok ()
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