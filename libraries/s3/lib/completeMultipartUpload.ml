open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CompleteMultipartUploadRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>Name of the bucket to which the multipart upload was initiated.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>Object key for which the multipart upload was initiated.</p>"];
      multipart_upload: CompletedMultipartUpload.t option
        [@ocaml.doc
          "<p>The container for the multipart upload request information.</p>"];
      upload_id: String.t
        [@ocaml.doc "<p>ID for the initiated multipart upload.</p>"];
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?multipart_upload  ~upload_id  ?request_payer  ()
      = { bucket; key; multipart_upload; upload_id; request_payer }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Util.option_map v.multipart_upload
             (fun f ->
                ("multipart_upload", (CompletedMultipartUpload.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          multipart_upload =
            (Util.option_bind (Xml.member "CompleteMultipartUpload" xml)
               CompletedMultipartUpload.parse);
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
             @
             [Util.option_map v.multipart_upload
                (fun f ->
                   Ezxmlm.make_tag "CompleteMultipartUpload"
                     ([], (CompletedMultipartUpload.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "uploadId" ([], (String.to_xml v.upload_id)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
  end
module CompleteMultipartUploadOutput = CompleteMultipartUploadOutput
type input = CompleteMultipartUploadRequest.t
type output = CompleteMultipartUploadOutput.t
type error = Errors_internal.t
let streaming = false
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/" ^ req.CompleteMultipartUploadRequest.bucket) ^ "/") ^
               req.CompleteMultipartUploadRequest.key)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CompleteMultipartUploadRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CompleteMultipartUploadRequest.to_headers req)),
    (match req.CompleteMultipartUploadRequest.multipart_upload with
     | Some v ->
         Ezxmlm.to_string
           [Ezxmlm.make_tag "CompleteMultipartUpload"
              ([], (CompletedMultipartUpload.to_xml v))]
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
               "Could not find well formed CompleteMultipartUploadOutput.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CompleteMultipartUploadOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CompleteMultipartUploadOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CompleteMultipartUploadOutput - missing field in body or children: "
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