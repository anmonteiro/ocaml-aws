open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartActivityStreamRequest =
  struct
    type t =
      {
      resource_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the DB cluster, for example <code>arn:aws:rds:us-east-1:12345667890:cluster:das-cluster</code>.</p>"];
      mode: ActivityStreamMode.t
        [@ocaml.doc
          "<p>Specifies the mode of the database activity stream. Database events such as a change or access generate an activity stream event. The database session can handle these events either synchronously or asynchronously. </p>"];
      kms_key_id: String.t
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encrypting messages in the database activity stream. The key identifier can be either a key ID, a key ARN, or a key alias.</p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether or not the database activity stream is to start as soon as possible, regardless of the maintenance window for the database.</p>"]}
    let make ~resource_arn  ~mode  ~kms_key_id  ?apply_immediately  () =
      { resource_arn; mode; kms_key_id; apply_immediately }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.apply_immediately
              (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Some ("kms_key_id", (String.to_json v.kms_key_id));
           Some ("mode", (ActivityStreamMode.to_json v.mode));
           Some ("resource_arn", (String.to_json v.resource_arn))])
    let parse xml =
      Some
        {
          resource_arn =
            (Xml.required "ResourceArn"
               (Util.option_bind (Xml.member "ResourceArn" xml) String.parse));
          mode =
            (Xml.required "Mode"
               (Util.option_bind (Xml.member "Mode" xml)
                  ActivityStreamMode.parse));
          kms_key_id =
            (Xml.required "KmsKeyId"
               (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse));
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "ResourceArn"
                    ([], (String.to_xml v.resource_arn)))])
             @
             [Some
                (Ezxmlm.make_tag "Mode"
                   ([], (ActivityStreamMode.to_xml v.mode)))])
            @
            [Some
               (Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml v.kms_key_id)))])
           @
           [Util.option_map v.apply_immediately
              (fun f ->
                 Ezxmlm.make_tag "ApplyImmediately" ([], (Boolean.to_xml f)))])
  end
module StartActivityStreamResponse = StartActivityStreamResponse
type input = StartActivityStreamRequest.t
type output = StartActivityStreamResponse.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["StartActivityStream"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StartActivityStreamRequest.to_query req))))) in
  (`POST, uri, (Headers.render (StartActivityStreamRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "StartActivityStreamResponse" (snd xml))
        (Xml.member "StartActivityStreamResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp StartActivityStreamResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed StartActivityStreamResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StartActivityStreamResponse - missing field in body or children: "
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