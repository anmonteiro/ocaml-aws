open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyDBSnapshotMessage =
  struct
    type t =
      {
      source_d_b_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the source DB snapshot.</p> <p>If the source snapshot is in the same AWS Region as the copy, specify a valid DB snapshot identifier. For example, you might specify <code>rds:mysql-instance1-snapshot-20130805</code>. </p> <p>If the source snapshot is in a different AWS Region than the copy, specify a valid DB snapshot ARN. For example, you might specify <code>arn:aws:rds:us-west-2:123456789012:snapshot:mysql-instance1-snapshot-20130805</code>. </p> <p>If you are copying from a shared manual DB snapshot, this parameter must be the Amazon Resource Name (ARN) of the shared DB snapshot. </p> <p>If you are copying an encrypted snapshot this parameter must be in the ARN format for the source AWS Region, and must match the <code>SourceDBSnapshotIdentifier</code> in the <code>PreSignedUrl</code> parameter. </p> <p>Constraints:</p> <ul> <li> <p>Must specify a valid system snapshot in the \"available\" state.</p> </li> </ul> <p>Example: <code>rds:mydb-2012-04-02-00-01</code> </p> <p>Example: <code>arn:aws:rds:us-west-2:123456789012:snapshot:mysql-instance1-snapshot-20130805</code> </p>"];
      target_d_b_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the copy of the snapshot. </p> <p>Constraints:</p> <ul> <li> <p>Can't be null, empty, or blank</p> </li> <li> <p>Must contain from 1 to 255 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-db-snapshot</code> </p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key ID for an encrypted DB snapshot. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key. </p> <p>If you copy an encrypted DB snapshot from your AWS account, you can specify a value for this parameter to encrypt the copy with a new KMS encryption key. If you don't specify a value for this parameter, then the copy of the DB snapshot is encrypted with the same KMS key as the source DB snapshot. </p> <p>If you copy an encrypted DB snapshot that is shared from another AWS account, then you must specify a value for this parameter. </p> <p>If you specify this parameter when you copy an unencrypted snapshot, the copy is encrypted. </p> <p>If you copy an encrypted snapshot to a different AWS Region, then you must specify a KMS key for the destination AWS Region. KMS encryption keys are specific to the AWS Region that they are created in, and you can't use encryption keys from one AWS Region in another AWS Region. </p>"];
      tags: TagList.t ;
      copy_tags: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the source DB snapshot to the target DB snapshot. By default, tags are not copied.</p>"];
      pre_signed_url: String.t option
        [@ocaml.doc
          "<p>The URL that contains a Signature Version 4 signed request for the <code>CopyDBSnapshot</code> API action in the source AWS Region that contains the source DB snapshot to copy. </p> <p>You must specify this parameter when you copy an encrypted DB snapshot from another AWS Region by using the Amazon RDS API. Don't specify <code>PreSignedUrl</code> when you are copying an encrypted DB snapshot in the same AWS Region.</p> <p>The presigned URL must be a valid request for the <code>CopyDBSnapshot</code> API action that can be executed in the source AWS Region that contains the encrypted DB snapshot to be copied. The presigned URL request must contain the following parameter values: </p> <ul> <li> <p> <code>DestinationRegion</code> - The AWS Region that the encrypted DB snapshot is copied to. This AWS Region is the same one where the <code>CopyDBSnapshot</code> action is called that contains this presigned URL. </p> <p>For example, if you copy an encrypted DB snapshot from the us-west-2 AWS Region to the us-east-1 AWS Region, then you call the <code>CopyDBSnapshot</code> action in the us-east-1 AWS Region and provide a presigned URL that contains a call to the <code>CopyDBSnapshot</code> action in the us-west-2 AWS Region. For this example, the <code>DestinationRegion</code> in the presigned URL must be set to the us-east-1 AWS Region. </p> </li> <li> <p> <code>KmsKeyId</code> - The AWS KMS key identifier for the key to use to encrypt the copy of the DB snapshot in the destination AWS Region. This is the same identifier for both the <code>CopyDBSnapshot</code> action that is called in the destination AWS Region, and the action contained in the presigned URL. </p> </li> <li> <p> <code>SourceDBSnapshotIdentifier</code> - The DB snapshot identifier for the encrypted snapshot to be copied. This identifier must be in the Amazon Resource Name (ARN) format for the source AWS Region. For example, if you are copying an encrypted DB snapshot from the us-west-2 AWS Region, then your <code>SourceDBSnapshotIdentifier</code> looks like the following example: <code>arn:aws:rds:us-west-2:123456789012:snapshot:mysql-instance1-snapshot-20161115</code>. </p> </li> </ul> <p>To learn how to generate a Signature Version 4 signed request, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html\">Authenticating Requests: Using Query Parameters (AWS Signature Version 4)</a> and <a href=\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\">Signature Version 4 Signing Process</a>. </p> <note> <p>If you are using an AWS SDK tool or the AWS CLI, you can specify <code>SourceRegion</code> (or <code>--source-region</code> for the AWS CLI) instead of specifying <code>PreSignedUrl</code> manually. Specifying <code>SourceRegion</code> autogenerates a pre-signed URL that is a valid request for the operation that can be executed in the source AWS Region.</p> </note>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The name of an option group to associate with the copy of the snapshot.</p> <p>Specify this option if you are copying a snapshot from one AWS Region to another, and your DB instance uses a nondefault option group. If your source DB instance uses Transparent Data Encryption for Oracle or Microsoft SQL Server, you must specify this option when copying across AWS Regions. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_CopySnapshot.html#USER_CopySnapshot.Options\">Option Group Considerations</a> in the <i>Amazon RDS User Guide.</i> </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~source_d_b_snapshot_identifier  ~target_d_b_snapshot_identifier
       ?kms_key_id  ?(tags= [])  ?copy_tags  ?pre_signed_url 
      ?option_group_name  () =
      {
        source_d_b_snapshot_identifier;
        target_d_b_snapshot_identifier;
        kms_key_id;
        tags;
        copy_tags;
        pre_signed_url;
        option_group_name
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.option_group_name
              (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.pre_signed_url
             (fun f -> ("pre_signed_url", (String.to_json f)));
           Util.option_map v.copy_tags
             (fun f -> ("copy_tags", (Boolean.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Some
             ("target_d_b_snapshot_identifier",
               (String.to_json v.target_d_b_snapshot_identifier));
           Some
             ("source_d_b_snapshot_identifier",
               (String.to_json v.source_d_b_snapshot_identifier))])
    let parse xml =
      Some
        {
          source_d_b_snapshot_identifier =
            (Xml.required "SourceDBSnapshotIdentifier"
               (Util.option_bind
                  (Xml.member "SourceDBSnapshotIdentifier" xml) String.parse));
          target_d_b_snapshot_identifier =
            (Xml.required "TargetDBSnapshotIdentifier"
               (Util.option_bind
                  (Xml.member "TargetDBSnapshotIdentifier" xml) String.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          copy_tags =
            (Util.option_bind (Xml.member "CopyTags" xml) Boolean.parse);
          pre_signed_url =
            (Util.option_bind (Xml.member "PreSignedUrl" xml) String.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "SourceDBSnapshotIdentifier"
                       ([], (String.to_xml v.source_d_b_snapshot_identifier)))])
                @
                [Some
                   (Ezxmlm.make_tag "TargetDBSnapshotIdentifier"
                      ([], (String.to_xml v.target_d_b_snapshot_identifier)))])
               @
               [Util.option_map v.kms_key_id
                  (fun f ->
                     Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
                 v.tags))
             @
             [Util.option_map v.copy_tags
                (fun f -> Ezxmlm.make_tag "CopyTags" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.pre_signed_url
               (fun f ->
                  Ezxmlm.make_tag "PreSignedUrl" ([], (String.to_xml f)))])
           @
           [Util.option_map v.option_group_name
              (fun f ->
                 Ezxmlm.make_tag "OptionGroupName" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module CopyDBSnapshotResult = CopyDBSnapshotResult
type input = CopyDBSnapshotMessage.t
type output = CopyDBSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CopyDBSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopyDBSnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CopyDBSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CopyDBSnapshotResponse" (snd xml))
        (Xml.member "CopyDBSnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CopyDBSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CopyDBSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopyDBSnapshotResult - missing field in body or children: "
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