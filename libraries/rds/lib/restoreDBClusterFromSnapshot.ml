open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RestoreDBClusterFromSnapshotMessage =
  struct
    type t =
      {
      availability_zones: AvailabilityZones.t
        [@ocaml.doc
          "<p>Provides the list of Availability Zones (AZs) where instances in the restored DB cluster can be created.</p>"];
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The name of the DB cluster to create from the DB snapshot or DB cluster snapshot. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-snapshot-id</code> </p>"];
      snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the DB snapshot or DB cluster snapshot to restore from.</p> <p>You can use either the name or the Amazon Resource Name (ARN) to specify a DB cluster snapshot. However, you can use only the ARN to specify a DB snapshot.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing Snapshot.</p> </li> </ul>"];
      engine: String.t
        [@ocaml.doc
          "<p>The database engine to use for the new DB cluster.</p> <p>Default: The same as source</p> <p>Constraint: Must be compatible with the engine of the source</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version of the database engine to use for the new DB cluster.</p> <p>To list all of the available engine versions for <code>aurora</code> (for MySQL 5.6-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-mysql</code> (for MySQL 5.7-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-mysql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-postgresql</code>, use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-postgresql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <note> <p>If you aren't using the default engine version, then you must specify the engine version.</p> </note> <p> <b>Aurora MySQL</b> </p> <p>Example: <code>5.6.10a</code>, <code>5.6.mysql_aurora.1.19.2</code>, <code>5.7.12</code>, <code>5.7.mysql_aurora.2.04.5</code> </p> <p> <b>Aurora PostgreSQL</b> </p> <p>Example: <code>9.6.3</code>, <code>10.7</code> </p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the new DB cluster accepts connections.</p> <p>Constraints: This value must be <code>1150-65535</code> </p> <p>Default: The same port as the original DB cluster.</p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB subnet group to use for the new DB cluster.</p> <p>Constraints: If supplied, must match the name of an existing DB subnet group.</p> <p>Example: <code>mySubnetgroup</code> </p>"];
      database_name: String.t option
        [@ocaml.doc "<p>The database name for the restored DB cluster.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the option group to use for the restored DB cluster.</p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of VPC security groups that the new DB cluster will belong to.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The tags to be assigned to the restored DB cluster.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier to use when restoring an encrypted DB cluster from a DB snapshot or DB cluster snapshot.</p> <p>The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are restoring a DB cluster with the same AWS account that owns the KMS encryption key used to encrypt the new DB cluster, then you can use the KMS key alias instead of the ARN for the KMS encryption key.</p> <p>If you don't specify a value for the <code>KmsKeyId</code> parameter, then the following occurs:</p> <ul> <li> <p>If the DB snapshot or DB cluster snapshot in <code>SnapshotIdentifier</code> is encrypted, then the restored DB cluster is encrypted using the KMS key that was used to encrypt the DB snapshot or DB cluster snapshot.</p> </li> <li> <p>If the DB snapshot or DB cluster snapshot in <code>SnapshotIdentifier</code> isn't encrypted, then the restored DB cluster isn't encrypted.</p> </li> </ul>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication</a> in the <i>Amazon Aurora User Guide.</i> </p>"];
      backtrack_window: Long.t option
        [@ocaml.doc
          "<p>The target backtrack window, in seconds. To disable backtracking, set this value to 0.</p> <p>Default: 0</p> <p>Constraints:</p> <ul> <li> <p>If specified, this value must be set to a number from 0 to 259,200 (72 hours).</p> </li> </ul>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of logs that the restored DB cluster is to export to Amazon CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs </a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      engine_mode: String.t option
        [@ocaml.doc
          "<p>The DB engine mode of the DB cluster, either <code>provisioned</code>, <code>serverless</code>, <code>parallelquery</code>, <code>global</code>, or <code>multimaster</code>.</p>"];
      scaling_configuration: ScalingConfiguration.t option
        [@ocaml.doc
          "<p>For DB clusters in <code>serverless</code> DB engine mode, the scaling properties of the DB cluster.</p>"];
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB cluster parameter group to associate with this DB cluster. If this argument is omitted, the default DB cluster parameter group for the specified engine is used.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing default DB cluster parameter group.</p> </li> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. </p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the restored DB cluster to snapshots of the restored DB cluster. The default is not to copy them.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?(availability_zones= [])  ~d_b_cluster_identifier 
      ~snapshot_identifier  ~engine  ?engine_version  ?port 
      ?d_b_subnet_group_name  ?database_name  ?option_group_name 
      ?(vpc_security_group_ids= [])  ?(tags= [])  ?kms_key_id 
      ?enable_i_a_m_database_authentication  ?backtrack_window 
      ?(enable_cloudwatch_logs_exports= [])  ?engine_mode 
      ?scaling_configuration  ?d_b_cluster_parameter_group_name 
      ?deletion_protection  ?copy_tags_to_snapshot  () =
      {
        availability_zones;
        d_b_cluster_identifier;
        snapshot_identifier;
        engine;
        engine_version;
        port;
        d_b_subnet_group_name;
        database_name;
        option_group_name;
        vpc_security_group_ids;
        tags;
        kms_key_id;
        enable_i_a_m_database_authentication;
        backtrack_window;
        enable_cloudwatch_logs_exports;
        engine_mode;
        scaling_configuration;
        d_b_cluster_parameter_group_name;
        deletion_protection;
        copy_tags_to_snapshot
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.copy_tags_to_snapshot
              (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.d_b_cluster_parameter_group_name
             (fun f ->
                ("d_b_cluster_parameter_group_name", (String.to_json f)));
           Util.option_map v.scaling_configuration
             (fun f ->
                ("scaling_configuration", (ScalingConfiguration.to_json f)));
           Util.option_map v.engine_mode
             (fun f -> ("engine_mode", (String.to_json f)));
           Some
             ("enable_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enable_cloudwatch_logs_exports));
           Util.option_map v.backtrack_window
             (fun f -> ("backtrack_window", (Long.to_json f)));
           Util.option_map v.enable_i_a_m_database_authentication
             (fun f ->
                ("enable_i_a_m_database_authentication", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.database_name
             (fun f -> ("database_name", (String.to_json f)));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Some ("engine", (String.to_json v.engine));
           Some
             ("snapshot_identifier", (String.to_json v.snapshot_identifier));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier));
           Some
             ("availability_zones",
               (AvailabilityZones.to_json v.availability_zones))])
    let parse xml =
      Some
        {
          availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "AvailabilityZones" xml)
                  AvailabilityZones.parse));
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          snapshot_identifier =
            (Xml.required "SnapshotIdentifier"
               (Util.option_bind (Xml.member "SnapshotIdentifier" xml)
                  String.parse));
          engine =
            (Xml.required "Engine"
               (Util.option_bind (Xml.member "Engine" xml) String.parse));
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          database_name =
            (Util.option_bind (Xml.member "DatabaseName" xml) String.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          enable_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "EnableIAMDatabaseAuthentication" xml)
               Boolean.parse);
          backtrack_window =
            (Util.option_bind (Xml.member "BacktrackWindow" xml) Long.parse);
          enable_cloudwatch_logs_exports =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "EnableCloudwatchLogsExports" xml)
                  LogTypeList.parse));
          engine_mode =
            (Util.option_bind (Xml.member "EngineMode" xml) String.parse);
          scaling_configuration =
            (Util.option_bind (Xml.member "ScalingConfiguration" xml)
               ScalingConfiguration.parse);
          d_b_cluster_parameter_group_name =
            (Util.option_bind (Xml.member "DBClusterParameterGroupName" xml)
               String.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((([] @
                              (List.map
                                 (fun x ->
                                    Some
                                      (Ezxmlm.make_tag "AvailabilityZones"
                                         ([], (AvailabilityZones.to_xml [x]))))
                                 v.availability_zones))
                             @
                             [Some
                                (Ezxmlm.make_tag "DBClusterIdentifier"
                                   ([],
                                     (String.to_xml v.d_b_cluster_identifier)))])
                            @
                            [Some
                               (Ezxmlm.make_tag "SnapshotIdentifier"
                                  ([], (String.to_xml v.snapshot_identifier)))])
                           @
                           [Some
                              (Ezxmlm.make_tag "Engine"
                                 ([], (String.to_xml v.engine)))])
                          @
                          [Util.option_map v.engine_version
                             (fun f ->
                                Ezxmlm.make_tag "EngineVersion"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.port
                            (fun f ->
                               Ezxmlm.make_tag "Port"
                                 ([], (Integer.to_xml f)))])
                        @
                        [Util.option_map v.d_b_subnet_group_name
                           (fun f ->
                              Ezxmlm.make_tag "DBSubnetGroupName"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.database_name
                          (fun f ->
                             Ezxmlm.make_tag "DatabaseName"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.option_group_name
                         (fun f ->
                            Ezxmlm.make_tag "OptionGroupName"
                              ([], (String.to_xml f)))])
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "VpcSecurityGroupIds"
                                ([], (VpcSecurityGroupIdList.to_xml [x]))))
                        v.vpc_security_group_ids))
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "Tags"
                               ([], (TagList.to_xml [x])))) v.tags))
                   @
                   [Util.option_map v.kms_key_id
                      (fun f ->
                         Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.enable_i_a_m_database_authentication
                     (fun f ->
                        Ezxmlm.make_tag "EnableIAMDatabaseAuthentication"
                          ([], (Boolean.to_xml f)))])
                 @
                 [Util.option_map v.backtrack_window
                    (fun f ->
                       Ezxmlm.make_tag "BacktrackWindow"
                         ([], (Long.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "EnableCloudwatchLogsExports"
                           ([], (LogTypeList.to_xml [x]))))
                   v.enable_cloudwatch_logs_exports))
               @
               [Util.option_map v.engine_mode
                  (fun f ->
                     Ezxmlm.make_tag "EngineMode" ([], (String.to_xml f)))])
              @
              [Util.option_map v.scaling_configuration
                 (fun f ->
                    Ezxmlm.make_tag "ScalingConfiguration"
                      ([], (ScalingConfiguration.to_xml f)))])
             @
             [Util.option_map v.d_b_cluster_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "DBClusterParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.deletion_protection
               (fun f ->
                  Ezxmlm.make_tag "DeletionProtection"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.copy_tags_to_snapshot
              (fun f ->
                 Ezxmlm.make_tag "CopyTagsToSnapshot"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module RestoreDBClusterFromSnapshotResult =
  RestoreDBClusterFromSnapshotResult
type input = RestoreDBClusterFromSnapshotMessage.t
type output = RestoreDBClusterFromSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["RestoreDBClusterFromSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (RestoreDBClusterFromSnapshotMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RestoreDBClusterFromSnapshotMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RestoreDBClusterFromSnapshotResponse" (snd xml))
        (Xml.member "RestoreDBClusterFromSnapshotResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RestoreDBClusterFromSnapshotResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RestoreDBClusterFromSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RestoreDBClusterFromSnapshotResult - missing field in body or children: "
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