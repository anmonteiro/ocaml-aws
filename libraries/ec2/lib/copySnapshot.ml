open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopySnapshotRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc "<p>A description for the EBS snapshot.</p>"];
      destination_region: String.t option
        [@ocaml.doc
          "<p>The destination Region to use in the <code>PresignedUrl</code> parameter of a snapshot copy operation. This parameter is only valid for specifying the destination Region in a <code>PresignedUrl</code> parameter, where it is required.</p> <p>The snapshot copy is sent to the regional endpoint that you sent the HTTP request to (for example, <code>ec2.us-east-1.amazonaws.com</code>). With the AWS CLI, this is specified using the <code>--region</code> parameter or the default Region in your AWS configuration file.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>To encrypt a copy of an unencrypted snapshot if encryption by default is not enabled, enable encryption using this parameter. Otherwise, omit this parameter. Encrypted snapshots are encrypted, even if you omit this parameter and encryption by default is not enabled. You cannot set this parameter to false. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html\">Amazon EBS Encryption</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The identifier of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use for Amazon EBS encryption. If this parameter is not specified, your AWS managed CMK for EBS is used. If <code>KmsKeyId</code> is specified, the encrypted state must be <code>true</code>.</p> <p>You can specify the CMK using any of the following:</p> <ul> <li> <p>Key ID. For example, key/1234abcd-12ab-34cd-56ef-1234567890ab.</p> </li> <li> <p>Key alias. For example, alias/ExampleAlias.</p> </li> <li> <p>Key ARN. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:key/<i>abcd1234-a123-456a-a12b-a123b4cd56ef</i>.</p> </li> <li> <p>Alias ARN. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:alias/<i>ExampleAlias</i>.</p> </li> </ul> <p>AWS authenticates the CMK asynchronously. Therefore, if you specify an ID, alias, or ARN that is not valid, the action can appear to complete, but eventually fails.</p>"];
      presigned_url: String.t option
        [@ocaml.doc
          "<p>When you copy an encrypted source snapshot using the Amazon EC2 Query API, you must supply a pre-signed URL. This parameter is optional for unencrypted snapshots. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html\">Query Requests</a>.</p> <p>The <code>PresignedUrl</code> should use the snapshot source endpoint, the <code>CopySnapshot</code> action, and include the <code>SourceRegion</code>, <code>SourceSnapshotId</code>, and <code>DestinationRegion</code> parameters. The <code>PresignedUrl</code> must be signed using AWS Signature Version 4. Because EBS snapshots are stored in Amazon S3, the signing algorithm for this parameter uses the same logic that is described in <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html\">Authenticating Requests by Using Query Parameters (AWS Signature Version 4)</a> in the <i>Amazon Simple Storage Service API Reference</i>. An invalid or improperly signed <code>PresignedUrl</code> will cause the copy operation to fail asynchronously, and the snapshot will move to an <code>error</code> state.</p>"];
      source_region: String.t
        [@ocaml.doc
          "<p>The ID of the Region that contains the snapshot to be copied.</p>"];
      source_snapshot_id: String.t
        [@ocaml.doc "<p>The ID of the EBS snapshot to copy.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc "<p>The tags to apply to the new snapshot.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?description  ?destination_region  ?encrypted  ?kms_key_id 
      ?presigned_url  ~source_region  ~source_snapshot_id 
      ?(tag_specifications= [])  ?dry_run  () =
      {
        description;
        destination_region;
        encrypted;
        kms_key_id;
        presigned_url;
        source_region;
        source_snapshot_id;
        tag_specifications;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Some
             (Query.Pair
                ("SourceSnapshotId", (String.to_query v.source_snapshot_id)));
           Some
             (Query.Pair ("SourceRegion", (String.to_query v.source_region)));
           Util.option_map v.presigned_url
             (fun f -> Query.Pair ("PresignedUrl", (String.to_query f)));
           Util.option_map v.kms_key_id
             (fun f -> Query.Pair ("KmsKeyId", (String.to_query f)));
           Util.option_map v.encrypted
             (fun f -> Query.Pair ("Encrypted", (Boolean.to_query f)));
           Util.option_map v.destination_region
             (fun f -> Query.Pair ("DestinationRegion", (String.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Some ("source_snapshot_id", (String.to_json v.source_snapshot_id));
           Some ("source_region", (String.to_json v.source_region));
           Util.option_map v.presigned_url
             (fun f -> ("presigned_url", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.destination_region
             (fun f -> ("destination_region", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          destination_region =
            (Util.option_bind (Xml.member "destinationRegion" xml)
               String.parse);
          encrypted =
            (Util.option_bind (Xml.member "encrypted" xml) Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "kmsKeyId" xml) String.parse);
          presigned_url =
            (Util.option_bind (Xml.member "presignedUrl" xml) String.parse);
          source_region =
            (Xml.required "SourceRegion"
               (Util.option_bind (Xml.member "SourceRegion" xml) String.parse));
          source_snapshot_id =
            (Xml.required "SourceSnapshotId"
               (Util.option_bind (Xml.member "SourceSnapshotId" xml)
                  String.parse));
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.description
                      (fun f ->
                         Ezxmlm.make_tag "Description"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.destination_region
                     (fun f ->
                        Ezxmlm.make_tag "destinationRegion"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.encrypted
                    (fun f ->
                       Ezxmlm.make_tag "encrypted" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.kms_key_id
                   (fun f ->
                      Ezxmlm.make_tag "kmsKeyId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.presigned_url
                  (fun f ->
                     Ezxmlm.make_tag "presignedUrl" ([], (String.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "SourceRegion"
                    ([], (String.to_xml v.source_region)))])
             @
             [Some
                (Ezxmlm.make_tag "SourceSnapshotId"
                   ([], (String.to_xml v.source_snapshot_id)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TagSpecification"
                       ([], (TagSpecificationList.to_xml [x]))))
               v.tag_specifications))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module CopySnapshotResult = CopySnapshotResult
type input = CopySnapshotRequest.t
type output = CopySnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CopySnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopySnapshotRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CopySnapshotRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CopySnapshotResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CopySnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CopySnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopySnapshotResult - missing field in body or children: "
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