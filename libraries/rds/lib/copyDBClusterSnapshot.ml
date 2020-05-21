open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopyDBClusterSnapshotMessage =
  struct
    type t =
      {
      source_d_b_cluster_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the DB cluster snapshot to copy. This parameter isn't case-sensitive.</p> <p>You can't copy an encrypted, shared DB cluster snapshot from one AWS Region to another.</p> <p>Constraints:</p> <ul> <li> <p>Must specify a valid system snapshot in the \"available\" state.</p> </li> <li> <p>If the source snapshot is in the same AWS Region as the copy, specify a valid DB snapshot identifier.</p> </li> <li> <p>If the source snapshot is in a different AWS Region than the copy, specify a valid DB cluster snapshot ARN. For more information, go to <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_CopySnapshot.html#USER_CopySnapshot.AcrossRegions\"> Copying Snapshots Across AWS Regions</a> in the <i>Amazon Aurora User Guide.</i> </p> </li> </ul> <p>Example: <code>my-cluster-snapshot1</code> </p>"];
      target_d_b_cluster_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the new DB cluster snapshot to create from the source DB cluster snapshot. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>my-cluster-snapshot2</code> </p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS AWS KMS key ID for an encrypted DB cluster snapshot. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key. </p> <p>If you copy an encrypted DB cluster snapshot from your AWS account, you can specify a value for <code>KmsKeyId</code> to encrypt the copy with a new KMS encryption key. If you don't specify a value for <code>KmsKeyId</code>, then the copy of the DB cluster snapshot is encrypted with the same KMS key as the source DB cluster snapshot. </p> <p>If you copy an encrypted DB cluster snapshot that is shared from another AWS account, then you must specify a value for <code>KmsKeyId</code>. </p> <p>To copy an encrypted DB cluster snapshot to another AWS Region, you must set <code>KmsKeyId</code> to the KMS key ID you want to use to encrypt the copy of the DB cluster snapshot in the destination AWS Region. KMS encryption keys are specific to the AWS Region that they are created in, and you can't use encryption keys from one AWS Region in another AWS Region.</p> <p>If you copy an unencrypted DB cluster snapshot and specify a value for the <code>KmsKeyId</code> parameter, an error is returned.</p>"];
      pre_signed_url: String.t option
        [@ocaml.doc
          "<p>The URL that contains a Signature Version 4 signed request for the <code>CopyDBClusterSnapshot</code> API action in the AWS Region that contains the source DB cluster snapshot to copy. The <code>PreSignedUrl</code> parameter must be used when copying an encrypted DB cluster snapshot from another AWS Region. Don't specify <code>PreSignedUrl</code> when you are copying an encrypted DB cluster snapshot in the same AWS Region.</p> <p>The pre-signed URL must be a valid request for the <code>CopyDBSClusterSnapshot</code> API action that can be executed in the source AWS Region that contains the encrypted DB cluster snapshot to be copied. The pre-signed URL request must contain the following parameter values:</p> <ul> <li> <p> <code>KmsKeyId</code> - The AWS KMS key identifier for the key to use to encrypt the copy of the DB cluster snapshot in the destination AWS Region. This is the same identifier for both the <code>CopyDBClusterSnapshot</code> action that is called in the destination AWS Region, and the action contained in the pre-signed URL.</p> </li> <li> <p> <code>DestinationRegion</code> - The name of the AWS Region that the DB cluster snapshot will be created in.</p> </li> <li> <p> <code>SourceDBClusterSnapshotIdentifier</code> - The DB cluster snapshot identifier for the encrypted DB cluster snapshot to be copied. This identifier must be in the Amazon Resource Name (ARN) format for the source AWS Region. For example, if you are copying an encrypted DB cluster snapshot from the us-west-2 AWS Region, then your <code>SourceDBClusterSnapshotIdentifier</code> looks like the following example: <code>arn:aws:rds:us-west-2:123456789012:cluster-snapshot:aurora-cluster1-snapshot-20161115</code>.</p> </li> </ul> <p>To learn how to generate a Signature Version 4 signed request, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html\"> Authenticating Requests: Using Query Parameters (AWS Signature Version 4)</a> and <a href=\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\"> Signature Version 4 Signing Process</a>.</p> <note> <p>If you are using an AWS SDK tool or the AWS CLI, you can specify <code>SourceRegion</code> (or <code>--source-region</code> for the AWS CLI) instead of specifying <code>PreSignedUrl</code> manually. Specifying <code>SourceRegion</code> autogenerates a pre-signed URL that is a valid request for the operation that can be executed in the source AWS Region.</p> </note>"];
      copy_tags: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the source DB cluster snapshot to the target DB cluster snapshot. By default, tags are not copied.</p>"];
      tags: TagList.t }[@@ocaml.doc "<p/>"]
    let make ~source_d_b_cluster_snapshot_identifier 
      ~target_d_b_cluster_snapshot_identifier  ?kms_key_id  ?pre_signed_url 
      ?copy_tags  ?(tags= [])  () =
      {
        source_d_b_cluster_snapshot_identifier;
        target_d_b_cluster_snapshot_identifier;
        kms_key_id;
        pre_signed_url;
        copy_tags;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.copy_tags
             (fun f -> ("copy_tags", (Boolean.to_json f)));
           Util.option_map v.pre_signed_url
             (fun f -> ("pre_signed_url", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Some
             ("target_d_b_cluster_snapshot_identifier",
               (String.to_json v.target_d_b_cluster_snapshot_identifier));
           Some
             ("source_d_b_cluster_snapshot_identifier",
               (String.to_json v.source_d_b_cluster_snapshot_identifier))])
    let parse xml =
      Some
        {
          source_d_b_cluster_snapshot_identifier =
            (Xml.required "SourceDBClusterSnapshotIdentifier"
               (Util.option_bind
                  (Xml.member "SourceDBClusterSnapshotIdentifier" xml)
                  String.parse));
          target_d_b_cluster_snapshot_identifier =
            (Xml.required "TargetDBClusterSnapshotIdentifier"
               (Util.option_bind
                  (Xml.member "TargetDBClusterSnapshotIdentifier" xml)
                  String.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          pre_signed_url =
            (Util.option_bind (Xml.member "PreSignedUrl" xml) String.parse);
          copy_tags =
            (Util.option_bind (Xml.member "CopyTags" xml) Boolean.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "SourceDBClusterSnapshotIdentifier"
                      ([],
                        (String.to_xml
                           v.source_d_b_cluster_snapshot_identifier)))])
               @
               [Some
                  (Ezxmlm.make_tag "TargetDBClusterSnapshotIdentifier"
                     ([],
                       (String.to_xml
                          v.target_d_b_cluster_snapshot_identifier)))])
              @
              [Util.option_map v.kms_key_id
                 (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.pre_signed_url
                (fun f ->
                   Ezxmlm.make_tag "PreSignedUrl" ([], (String.to_xml f)))])
            @
            [Util.option_map v.copy_tags
               (fun f -> Ezxmlm.make_tag "CopyTags" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CopyDBClusterSnapshotResult = CopyDBClusterSnapshotResult
type input = CopyDBClusterSnapshotMessage.t
type output = CopyDBClusterSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CopyDBClusterSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopyDBClusterSnapshotMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CopyDBClusterSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CopyDBClusterSnapshotResponse" (snd xml))
        (Xml.member "CopyDBClusterSnapshotResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CopyDBClusterSnapshotResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CopyDBClusterSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopyDBClusterSnapshotResult - missing field in body or children: "
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