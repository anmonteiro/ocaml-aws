open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyImageRequest =
  struct
    type t =
      {
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier you provide to ensure idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description for the new AMI in the destination Region.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the destination snapshots of the copied image should be encrypted. You can encrypt a copy of an unencrypted snapshot, but you cannot create an unencrypted copy of an encrypted snapshot. The default CMK for EBS is used unless you specify a non-default AWS Key Management Service (AWS KMS) CMK using <code>KmsKeyId</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>An identifier for the symmetric AWS Key Management Service (AWS KMS) customer master key (CMK) to use when creating the encrypted volume. This parameter is only required if you want to use a non-default CMK; if this parameter is not specified, the default CMK for EBS is used. If a <code>KmsKeyId</code> is specified, the <code>Encrypted</code> flag must also be set. </p> <p>To specify a CMK, use its key ID, Amazon Resource Name (ARN), alias name, or alias ARN. When using an alias name, prefix it with \"alias/\". For example:</p> <ul> <li> <p>Key ID: <code>1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Key ARN: <code>arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab</code> </p> </li> <li> <p>Alias name: <code>alias/ExampleAlias</code> </p> </li> <li> <p>Alias ARN: <code>arn:aws:kms:us-east-2:111122223333:alias/ExampleAlias</code> </p> </li> </ul> <p>AWS parses <code>KmsKeyId</code> asynchronously, meaning that the action you call may appear to complete even though you provided an invalid identifier. This action will eventually report failure. </p> <p>The specified CMK must exist in the Region that the snapshot is being copied to. </p> <p>Amazon EBS does not support asymmetric CMKs.</p>"];
      name: String.t
        [@ocaml.doc
          "<p>The name of the new AMI in the destination Region.</p>"];
      source_image_id: String.t
        [@ocaml.doc "<p>The ID of the AMI to copy.</p>"];
      source_region: String.t
        [@ocaml.doc
          "<p>The name of the Region that contains the AMI to copy.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for CopyImage.</p>"]
    let make ?client_token  ?description  ?encrypted  ?kms_key_id  ~name 
      ~source_image_id  ~source_region  ?dry_run  () =
      {
        client_token;
        description;
        encrypted;
        kms_key_id;
        name;
        source_image_id;
        source_region;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair ("SourceRegion", (String.to_query v.source_region)));
           Some
             (Query.Pair
                ("SourceImageId", (String.to_query v.source_image_id)));
           Some (Query.Pair ("Name", (String.to_query v.name)));
           Util.option_map v.kms_key_id
             (fun f -> Query.Pair ("KmsKeyId", (String.to_query f)));
           Util.option_map v.encrypted
             (fun f -> Query.Pair ("Encrypted", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("source_region", (String.to_json v.source_region));
           Some ("source_image_id", (String.to_json v.source_image_id));
           Some ("name", (String.to_json v.name));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          encrypted =
            (Util.option_bind (Xml.member "encrypted" xml) Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "kmsKeyId" xml) String.parse);
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          source_image_id =
            (Xml.required "SourceImageId"
               (Util.option_bind (Xml.member "SourceImageId" xml)
                  String.parse));
          source_region =
            (Xml.required "SourceRegion"
               (Util.option_bind (Xml.member "SourceRegion" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.client_token
                     (fun f ->
                        Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.description
                    (fun f ->
                       Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
                @
                [Util.option_map v.encrypted
                   (fun f ->
                      Ezxmlm.make_tag "encrypted" ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.kms_key_id
                  (fun f ->
                     Ezxmlm.make_tag "kmsKeyId" ([], (String.to_xml f)))])
              @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
             @
             [Some
                (Ezxmlm.make_tag "SourceImageId"
                   ([], (String.to_xml v.source_image_id)))])
            @
            [Some
               (Ezxmlm.make_tag "SourceRegion"
                  ([], (String.to_xml v.source_region)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for CopyImage.</p>"]
module CopyImageResult = CopyImageResult
type input = CopyImageRequest.t
type output = CopyImageResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["CopyImage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopyImageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CopyImageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CopyImageResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CopyImageResult.parse)
          (BadResponse
             { body; message = "Could not find well formed CopyImageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopyImageResult - missing field in body or children: "
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