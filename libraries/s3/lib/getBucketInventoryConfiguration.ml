open Types
open Aws
type input = GetBucketInventoryConfigurationRequest.t
type output = GetBucketInventoryConfigurationOutput.t
type error = Errors_internal.t
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.GetBucketInventoryConfigurationRequest.bucket) ^
               "?inventory")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (GetBucketInventoryConfigurationRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (GetBucketInventoryConfigurationRequest.to_headers req)),
    "")
let of_http body =
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed GetBucketInventoryConfigurationOutput.") in
    try
      Util.or_error
        (Util.option_bind resp GetBucketInventoryConfigurationOutput.parse)
        (let open Error in
           BadResponse
             {
               body;
               message =
                 "Could not find well formed GetBucketInventoryConfigurationOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetBucketInventoryConfigurationOutput - missing field in body or children: "
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