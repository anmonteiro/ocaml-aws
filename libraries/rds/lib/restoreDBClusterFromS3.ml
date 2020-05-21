open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RestoreDBClusterFromS3Message =
  struct
    type t =
      {
      availability_zones: AvailabilityZones.t
        [@ocaml.doc
          "<p>A list of Availability Zones (AZs) where instances in the restored DB cluster can be created.</p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which automated backups of the restored DB cluster are retained. You must specify a minimum value of 1.</p> <p>Default: 1</p> <p>Constraints:</p> <ul> <li> <p>Must be a value from 1 to 35</p> </li> </ul>"];
      character_set_name: String.t option
        [@ocaml.doc
          "<p>A value that indicates that the restored DB cluster should be associated with the specified CharacterSet.</p>"];
      database_name: String.t option
        [@ocaml.doc "<p>The database name for the restored DB cluster.</p>"];
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The name of the DB cluster to create from the source data in the Amazon S3 bucket. This parameter is isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>my-cluster1</code> </p>"];
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB cluster parameter group to associate with the restored DB cluster. If this argument is omitted, <code>default.aurora5.6</code> is used. </p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing DBClusterParameterGroup.</p> </li> </ul>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of EC2 VPC security groups to associate with the restored DB cluster.</p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>A DB subnet group to associate with the restored DB cluster.</p> <p>Constraints: If supplied, must match the name of an existing DBSubnetGroup. </p> <p>Example: <code>mySubnetgroup</code> </p>"];
      engine: String.t
        [@ocaml.doc
          "<p>The name of the database engine to be used for the restored DB cluster.</p> <p>Valid Values: <code>aurora</code>, <code>aurora-postgresql</code> </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the database engine to use.</p> <p>To list all of the available engine versions for <code>aurora</code> (for MySQL 5.6-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-mysql</code> (for MySQL 5.7-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-mysql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-postgresql</code>, use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-postgresql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p> <b>Aurora MySQL</b> </p> <p>Example: <code>5.6.10a</code>, <code>5.6.mysql_aurora.1.19.2</code>, <code>5.7.12</code>, <code>5.7.mysql_aurora.2.04.5</code> </p> <p> <b>Aurora PostgreSQL</b> </p> <p>Example: <code>9.6.3</code>, <code>10.7</code> </p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the instances in the restored DB cluster accept connections.</p> <p> Default: <code>3306</code> </p>"];
      master_username: String.t
        [@ocaml.doc
          "<p>The name of the master user for the restored DB cluster.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 16 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul>"];
      master_user_password: String.t
        [@ocaml.doc
          "<p>The password for the master database user. This password can contain any printable ASCII character except \"/\", \"\"\", or \"@\".</p> <p>Constraints: Must contain from 8 to 41 characters.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>A value that indicates that the restored DB cluster should be associated with the specified option group.</p> <p>Permanent options can't be removed from an option group. An option group can't be removed from a DB cluster once it is associated with a DB cluster.</p>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p>The daily time range during which automated backups are created if automated backups are enabled using the <code>BackupRetentionPeriod</code> parameter. </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora\"> Adjusting the Preferred Maintenance Window</a> in the <i>Amazon Aurora User Guide.</i> </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>hh24:mi-hh24:mi</code>.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred maintenance window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).</p> <p>Format: <code>ddd:hh24:mi-ddd:hh24:mi</code> </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora\"> Adjusting the Preferred Maintenance Window</a> in the <i>Amazon Aurora User Guide.</i> </p> <p>Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.</p> <p>Constraints: Minimum 30-minute window.</p>"];
      tags: TagList.t ;
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the restored DB cluster is encrypted.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for an encrypted DB cluster.</p> <p>The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a DB cluster with the same AWS account that owns the KMS encryption key used to encrypt the new DB cluster, then you can use the KMS key alias instead of the ARN for the KM encryption key.</p> <p>If the StorageEncrypted parameter is enabled, and you do not specify a value for the <code>KmsKeyId</code> parameter, then Amazon RDS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication</a> in the <i>Amazon Aurora User Guide.</i> </p>"];
      source_engine: String.t
        [@ocaml.doc
          "<p>The identifier for the database engine that was backed up to create the files stored in the Amazon S3 bucket. </p> <p>Valid values: <code>mysql</code> </p>"];
      source_engine_version: String.t
        [@ocaml.doc
          "<p>The version of the database that the backup files were created from.</p> <p>MySQL version 5.5 and 5.6 are supported. </p> <p>Example: <code>5.6.22</code> </p>"];
      s3_bucket_name: String.t
        [@ocaml.doc
          "<p>The name of the Amazon S3 bucket that contains the data used to create the Amazon Aurora DB cluster.</p>"];
      s3_prefix: String.t option
        [@ocaml.doc
          "<p>The prefix for all of the file names that contain the data used to create the Amazon Aurora DB cluster. If you do not specify a <b>SourceS3Prefix</b> value, then the Amazon Aurora DB cluster is created by using all of the files in the Amazon S3 bucket.</p>"];
      s3_ingestion_role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the AWS Identity and Access Management (IAM) role that authorizes Amazon RDS to access the Amazon S3 bucket on your behalf.</p>"];
      backtrack_window: Long.t option
        [@ocaml.doc
          "<p>The target backtrack window, in seconds. To disable backtracking, set this value to 0.</p> <p>Default: 0</p> <p>Constraints:</p> <ul> <li> <p>If specified, this value must be set to a number from 0 to 259,200 (72 hours).</p> </li> </ul>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of logs that the restored DB cluster is to export to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. </p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the restored DB cluster to snapshots of the restored DB cluster. The default is not to copy them.</p>"]}
    let make ?(availability_zones= [])  ?backup_retention_period 
      ?character_set_name  ?database_name  ~d_b_cluster_identifier 
      ?d_b_cluster_parameter_group_name  ?(vpc_security_group_ids= []) 
      ?d_b_subnet_group_name  ~engine  ?engine_version  ?port 
      ~master_username  ~master_user_password  ?option_group_name 
      ?preferred_backup_window  ?preferred_maintenance_window  ?(tags= []) 
      ?storage_encrypted  ?kms_key_id  ?enable_i_a_m_database_authentication 
      ~source_engine  ~source_engine_version  ~s3_bucket_name  ?s3_prefix 
      ~s3_ingestion_role_arn  ?backtrack_window 
      ?(enable_cloudwatch_logs_exports= [])  ?deletion_protection 
      ?copy_tags_to_snapshot  () =
      {
        availability_zones;
        backup_retention_period;
        character_set_name;
        database_name;
        d_b_cluster_identifier;
        d_b_cluster_parameter_group_name;
        vpc_security_group_ids;
        d_b_subnet_group_name;
        engine;
        engine_version;
        port;
        master_username;
        master_user_password;
        option_group_name;
        preferred_backup_window;
        preferred_maintenance_window;
        tags;
        storage_encrypted;
        kms_key_id;
        enable_i_a_m_database_authentication;
        source_engine;
        source_engine_version;
        s3_bucket_name;
        s3_prefix;
        s3_ingestion_role_arn;
        backtrack_window;
        enable_cloudwatch_logs_exports;
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
           Some
             ("enable_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enable_cloudwatch_logs_exports));
           Util.option_map v.backtrack_window
             (fun f -> ("backtrack_window", (Long.to_json f)));
           Some
             ("s3_ingestion_role_arn",
               (String.to_json v.s3_ingestion_role_arn));
           Util.option_map v.s3_prefix
             (fun f -> ("s3_prefix", (String.to_json f)));
           Some ("s3_bucket_name", (String.to_json v.s3_bucket_name));
           Some
             ("source_engine_version",
               (String.to_json v.source_engine_version));
           Some ("source_engine", (String.to_json v.source_engine));
           Util.option_map v.enable_i_a_m_database_authentication
             (fun f ->
                ("enable_i_a_m_database_authentication", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Some
             ("master_user_password",
               (String.to_json v.master_user_password));
           Some ("master_username", (String.to_json v.master_username));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Some ("engine", (String.to_json v.engine));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Util.option_map v.d_b_cluster_parameter_group_name
             (fun f ->
                ("d_b_cluster_parameter_group_name", (String.to_json f)));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier));
           Util.option_map v.database_name
             (fun f -> ("database_name", (String.to_json f)));
           Util.option_map v.character_set_name
             (fun f -> ("character_set_name", (String.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
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
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          character_set_name =
            (Util.option_bind (Xml.member "CharacterSetName" xml)
               String.parse);
          database_name =
            (Util.option_bind (Xml.member "DatabaseName" xml) String.parse);
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          d_b_cluster_parameter_group_name =
            (Util.option_bind (Xml.member "DBClusterParameterGroupName" xml)
               String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          engine =
            (Xml.required "Engine"
               (Util.option_bind (Xml.member "Engine" xml) String.parse));
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          master_username =
            (Xml.required "MasterUsername"
               (Util.option_bind (Xml.member "MasterUsername" xml)
                  String.parse));
          master_user_password =
            (Xml.required "MasterUserPassword"
               (Util.option_bind (Xml.member "MasterUserPassword" xml)
                  String.parse));
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          preferred_backup_window =
            (Util.option_bind (Xml.member "PreferredBackupWindow" xml)
               String.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          enable_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "EnableIAMDatabaseAuthentication" xml)
               Boolean.parse);
          source_engine =
            (Xml.required "SourceEngine"
               (Util.option_bind (Xml.member "SourceEngine" xml) String.parse));
          source_engine_version =
            (Xml.required "SourceEngineVersion"
               (Util.option_bind (Xml.member "SourceEngineVersion" xml)
                  String.parse));
          s3_bucket_name =
            (Xml.required "S3BucketName"
               (Util.option_bind (Xml.member "S3BucketName" xml) String.parse));
          s3_prefix =
            (Util.option_bind (Xml.member "S3Prefix" xml) String.parse);
          s3_ingestion_role_arn =
            (Xml.required "S3IngestionRoleArn"
               (Util.option_bind (Xml.member "S3IngestionRoleArn" xml)
                  String.parse));
          backtrack_window =
            (Util.option_bind (Xml.member "BacktrackWindow" xml) Long.parse);
          enable_cloudwatch_logs_exports =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "EnableCloudwatchLogsExports" xml)
                  LogTypeList.parse));
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((([] @
                                       (List.map
                                          (fun x ->
                                             Some
                                               (Ezxmlm.make_tag
                                                  "AvailabilityZones"
                                                  ([],
                                                    (AvailabilityZones.to_xml
                                                       [x]))))
                                          v.availability_zones))
                                      @
                                      [Util.option_map
                                         v.backup_retention_period
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "BackupRetentionPeriod"
                                              ([], (Integer.to_xml f)))])
                                     @
                                     [Util.option_map v.character_set_name
                                        (fun f ->
                                           Ezxmlm.make_tag "CharacterSetName"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.database_name
                                       (fun f ->
                                          Ezxmlm.make_tag "DatabaseName"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Some
                                      (Ezxmlm.make_tag "DBClusterIdentifier"
                                         ([],
                                           (String.to_xml
                                              v.d_b_cluster_identifier)))])
                                  @
                                  [Util.option_map
                                     v.d_b_cluster_parameter_group_name
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "DBClusterParameterGroupName"
                                          ([], (String.to_xml f)))])
                                 @
                                 (List.map
                                    (fun x ->
                                       Some
                                         (Ezxmlm.make_tag
                                            "VpcSecurityGroupIds"
                                            ([],
                                              (VpcSecurityGroupIdList.to_xml
                                                 [x]))))
                                    v.vpc_security_group_ids))
                                @
                                [Util.option_map v.d_b_subnet_group_name
                                   (fun f ->
                                      Ezxmlm.make_tag "DBSubnetGroupName"
                                        ([], (String.to_xml f)))])
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
                            [Some
                               (Ezxmlm.make_tag "MasterUsername"
                                  ([], (String.to_xml v.master_username)))])
                           @
                           [Some
                              (Ezxmlm.make_tag "MasterUserPassword"
                                 ([], (String.to_xml v.master_user_password)))])
                          @
                          [Util.option_map v.option_group_name
                             (fun f ->
                                Ezxmlm.make_tag "OptionGroupName"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.preferred_backup_window
                            (fun f ->
                               Ezxmlm.make_tag "PreferredBackupWindow"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.preferred_maintenance_window
                           (fun f ->
                              Ezxmlm.make_tag "PreferredMaintenanceWindow"
                                ([], (String.to_xml f)))])
                       @
                       (List.map
                          (fun x ->
                             Some
                               (Ezxmlm.make_tag "Tags"
                                  ([], (TagList.to_xml [x])))) v.tags))
                      @
                      [Util.option_map v.storage_encrypted
                         (fun f ->
                            Ezxmlm.make_tag "StorageEncrypted"
                              ([], (Boolean.to_xml f)))])
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
                   [Some
                      (Ezxmlm.make_tag "SourceEngine"
                         ([], (String.to_xml v.source_engine)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "SourceEngineVersion"
                        ([], (String.to_xml v.source_engine_version)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "S3BucketName"
                       ([], (String.to_xml v.s3_bucket_name)))])
                @
                [Util.option_map v.s3_prefix
                   (fun f ->
                      Ezxmlm.make_tag "S3Prefix" ([], (String.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "S3IngestionRoleArn"
                     ([], (String.to_xml v.s3_ingestion_role_arn)))])
              @
              [Util.option_map v.backtrack_window
                 (fun f ->
                    Ezxmlm.make_tag "BacktrackWindow" ([], (Long.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "EnableCloudwatchLogsExports"
                        ([], (LogTypeList.to_xml [x]))))
                v.enable_cloudwatch_logs_exports))
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
  end
module RestoreDBClusterFromS3Result = RestoreDBClusterFromS3Result
type input = RestoreDBClusterFromS3Message.t
type output = RestoreDBClusterFromS3Result.t
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
         ("Action", ["RestoreDBClusterFromS3"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RestoreDBClusterFromS3Message.to_query req))))) in
  (`POST, uri,
    (Headers.render (RestoreDBClusterFromS3Message.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RestoreDBClusterFromS3Response" (snd xml))
        (Xml.member "RestoreDBClusterFromS3Result") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RestoreDBClusterFromS3Result.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RestoreDBClusterFromS3Result."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RestoreDBClusterFromS3Result - missing field in body or children: "
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