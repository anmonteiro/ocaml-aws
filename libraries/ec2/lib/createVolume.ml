open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVolumeRequest =
  struct
    type t =
      {
      availability_zone: String.t
        [@ocaml.doc
          "<p>The Availability Zone in which to create the volume.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the volume should be encrypted. The effect of setting the encryption state to <code>true</code> depends on the volume origin (new or from a snapshot), starting encryption state, ownership, and whether encryption by default is enabled. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#encryption-by-default\">Encryption by Default</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>Encrypted Amazon EBS volumes must be attached to instances that support Amazon EBS encryption. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSEncryption.html#EBSEncryption_supported_instances\">Supported Instance Types</a>.</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The number of I/O operations per second (IOPS) to provision for the volume, with a maximum ratio of 50 IOPS/GiB. Range is 100 to 64,000 IOPS for volumes in most Regions. Maximum IOPS of 64,000 is guaranteed only on <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html#ec2-nitro-instances\">Nitro-based instances</a>. Other instance families guarantee performance up to 32,000 IOPS. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSVolumeTypes.html\">Amazon EBS Volume Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p> <p>This parameter is valid only for Provisioned IOPS SSD (io1) volumes.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The identifier of the AWS Key Management Service (AWS KMS) customer master key (CMK) to use for Amazon EBS encryption. If this parameter is not specified, your AWS managed CMK for EBS is used. If <code>KmsKeyId</code> is specified, the encrypted state must be <code>true</code>.</p> <p>You can specify the CMK using any of the following:</p> <ul> <li> <p>Key ID. For example, key/1234abcd-12ab-34cd-56ef-1234567890ab.</p> </li> <li> <p>Key alias. For example, alias/ExampleAlias.</p> </li> <li> <p>Key ARN. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:key/<i>abcd1234-a123-456a-a12b-a123b4cd56ef</i>.</p> </li> <li> <p>Alias ARN. For example, arn:aws:kms:<i>us-east-1</i>:<i>012345678910</i>:alias/<i>ExampleAlias</i>.</p> </li> </ul> <p>AWS authenticates the CMK asynchronously. Therefore, if you specify an ID, alias, or ARN that is not valid, the action can appear to complete, but eventually fails.</p>"];
      outpost_arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the Outpost.</p>"];
      size: Integer.t option
        [@ocaml.doc
          "<p>The size of the volume, in GiBs.</p> <p>Constraints: 1-16,384 for <code>gp2</code>, 4-16,384 for <code>io1</code>, 500-16,384 for <code>st1</code>, 500-16,384 for <code>sc1</code>, and 1-1,024 for <code>standard</code>. If you specify a snapshot, the volume size must be equal to or larger than the snapshot size.</p> <p>Default: If you're creating the volume from a snapshot and don't specify a volume size, the default is the snapshot size.</p> <note> <p>At least one of Size or SnapshotId is required.</p> </note>"];
      snapshot_id: String.t option
        [@ocaml.doc
          "<p>The snapshot from which to create the volume.</p> <note> <p>At least one of Size or SnapshotId are required.</p> </note>"];
      volume_type: VolumeType.t option
        [@ocaml.doc
          "<p>The volume type. This can be <code>gp2</code> for General Purpose SSD, <code>io1</code> for Provisioned IOPS SSD, <code>st1</code> for Throughput Optimized HDD, <code>sc1</code> for Cold HDD, or <code>standard</code> for Magnetic volumes.</p> <p>Default: <code>gp2</code> </p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the volume during creation.</p>"]}
    let make ~availability_zone  ?encrypted  ?iops  ?kms_key_id  ?outpost_arn
       ?size  ?snapshot_id  ?volume_type  ?dry_run  ?(tag_specifications= [])
       () =
      {
        availability_zone;
        encrypted;
        iops;
        kms_key_id;
        outpost_arn;
        size;
        snapshot_id;
        volume_type;
        dry_run;
        tag_specifications
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TagSpecification",
                   (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.volume_type
             (fun f -> Query.Pair ("VolumeType", (VolumeType.to_query f)));
           Util.option_map v.snapshot_id
             (fun f -> Query.Pair ("SnapshotId", (String.to_query f)));
           Util.option_map v.size
             (fun f -> Query.Pair ("Size", (Integer.to_query f)));
           Util.option_map v.outpost_arn
             (fun f -> Query.Pair ("OutpostArn", (String.to_query f)));
           Util.option_map v.kms_key_id
             (fun f -> Query.Pair ("KmsKeyId", (String.to_query f)));
           Util.option_map v.iops
             (fun f -> Query.Pair ("Iops", (Integer.to_query f)));
           Util.option_map v.encrypted
             (fun f -> Query.Pair ("Encrypted", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("AvailabilityZone", (String.to_query v.availability_zone)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("tag_specifications",
                (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.volume_type
             (fun f -> ("volume_type", (VolumeType.to_json f)));
           Util.option_map v.snapshot_id
             (fun f -> ("snapshot_id", (String.to_json f)));
           Util.option_map v.size (fun f -> ("size", (Integer.to_json f)));
           Util.option_map v.outpost_arn
             (fun f -> ("outpost_arn", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Some ("availability_zone", (String.to_json v.availability_zone))])
    let parse xml =
      Some
        {
          availability_zone =
            (Xml.required "AvailabilityZone"
               (Util.option_bind (Xml.member "AvailabilityZone" xml)
                  String.parse));
          encrypted =
            (Util.option_bind (Xml.member "encrypted" xml) Boolean.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          outpost_arn =
            (Util.option_bind (Xml.member "OutpostArn" xml) String.parse);
          size = (Util.option_bind (Xml.member "Size" xml) Integer.parse);
          snapshot_id =
            (Util.option_bind (Xml.member "SnapshotId" xml) String.parse);
          volume_type =
            (Util.option_bind (Xml.member "VolumeType" xml) VolumeType.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "AvailabilityZone"
                          ([], (String.to_xml v.availability_zone)))])
                   @
                   [Util.option_map v.encrypted
                      (fun f ->
                         Ezxmlm.make_tag "encrypted" ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.iops
                     (fun f ->
                        Ezxmlm.make_tag "Iops" ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.kms_key_id
                    (fun f ->
                       Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.outpost_arn
                   (fun f ->
                      Ezxmlm.make_tag "OutpostArn" ([], (String.to_xml f)))])
               @
               [Util.option_map v.size
                  (fun f -> Ezxmlm.make_tag "Size" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.snapshot_id
                 (fun f ->
                    Ezxmlm.make_tag "SnapshotId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.volume_type
                (fun f ->
                   Ezxmlm.make_tag "VolumeType" ([], (VolumeType.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TagSpecification"
                      ([], (TagSpecificationList.to_xml [x]))))
              v.tag_specifications))
  end
module Volume = Volume
type input = CreateVolumeRequest.t
type output = Volume.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateVolume"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateVolumeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateVolumeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateVolumeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp Volume.parse)
          (BadResponse
             { body; message = "Could not find well formed Volume." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing Volume - missing field in body or children: "
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