open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutObjectLockConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The bucket whose Object Lock configuration you want to create or replace.</p>"];
      object_lock_configuration: ObjectLockConfiguration.t option
        [@ocaml.doc
          "<p>The Object Lock configuration that you want to apply to the specified bucket.</p>"];
      request_payer: RequestPayer.t option ;
      token: String.t option
        [@ocaml.doc
          "<p>A token to allow Object Lock to be enabled for an existing bucket.</p>"];
      content_m_d5: String.t option
        [@ocaml.doc "<p>The MD5 hash for the request body.</p>"]}
    let make ~bucket  ?object_lock_configuration  ?request_payer  ?token 
      ?content_m_d5  () =
      { bucket; object_lock_configuration; request_payer; token; content_m_d5
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.token
             (fun f ->
                Headers.Pair
                  ("x-amz-bucket-object-lock-token", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.token (fun f -> ("token", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.object_lock_configuration
             (fun f ->
                ("object_lock_configuration",
                  (ObjectLockConfiguration.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          object_lock_configuration =
            (Util.option_bind (Xml.member "ObjectLockConfiguration" xml)
               ObjectLockConfiguration.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          token =
            (Util.option_bind
               (Xml.member "x-amz-bucket-object-lock-token" xml) String.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @
              [Util.option_map v.object_lock_configuration
                 (fun f ->
                    Ezxmlm.make_tag "ObjectLockConfiguration"
                      ([], (ObjectLockConfiguration.to_xml f)))])
             @
             [Util.option_map v.request_payer
                (fun f ->
                   Ezxmlm.make_tag "x-amz-request-payer"
                     ([], (RequestPayer.to_xml f)))])
            @
            [Util.option_map v.token
               (fun f ->
                  Ezxmlm.make_tag "x-amz-bucket-object-lock-token"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
  end
module PutObjectLockConfigurationOutput = PutObjectLockConfigurationOutput
type input = PutObjectLockConfigurationRequest.t
type output = PutObjectLockConfigurationOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/" ^ req.PutObjectLockConfigurationRequest.bucket) ^
               "?object-lock")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutObjectLockConfigurationRequest.to_query req)))) in
  (`PUT, uri,
    (Headers.render (PutObjectLockConfigurationRequest.to_headers req)),
    (match req.PutObjectLockConfigurationRequest.object_lock_configuration
     with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "ObjectLockConfiguration"
              ([], (ObjectLockConfiguration.to_xml v))]
     | None -> ""))
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure
               "Could not find well formed PutObjectLockConfigurationOutput.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp PutObjectLockConfigurationOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PutObjectLockConfigurationOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PutObjectLockConfigurationOutput - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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