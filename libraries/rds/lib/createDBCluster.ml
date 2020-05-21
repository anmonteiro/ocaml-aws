open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBClusterMessage =
  struct
    type t =
      {
      availability_zones: AvailabilityZones.t
        [@ocaml.doc
          "<p>A list of Availability Zones (AZs) where instances in the DB cluster can be created. For information on AWS Regions and Availability Zones, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.RegionsAndAvailabilityZones.html\">Choosing the Regions and Availability Zones</a> in the <i>Amazon Aurora User Guide</i>. </p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which automated backups are retained.</p> <p>Default: 1</p> <p>Constraints:</p> <ul> <li> <p>Must be a value from 1 to 35</p> </li> </ul>"];
      character_set_name: String.t option
        [@ocaml.doc
          "<p>A value that indicates that the DB cluster should be associated with the specified CharacterSet.</p>"];
      database_name: String.t option
        [@ocaml.doc
          "<p>The name for your database of up to 64 alpha-numeric characters. If you do not provide a name, Amazon RDS will not create a database in the DB cluster you are creating.</p>"];
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The DB cluster identifier. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>my-cluster1</code> </p>"];
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p> The name of the DB cluster parameter group to associate with this DB cluster. If you do not specify a value, then the default DB cluster parameter group for the specified DB engine and version is used. </p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing DB cluster parameter group.</p> </li> </ul>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of EC2 VPC security groups to associate with this DB cluster.</p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>A DB subnet group to associate with this DB cluster.</p> <p>Constraints: Must match the name of an existing DBSubnetGroup. Must not be default.</p> <p>Example: <code>mySubnetgroup</code> </p>"];
      engine: String.t
        [@ocaml.doc
          "<p>The name of the database engine to be used for this DB cluster.</p> <p>Valid Values: <code>aurora</code> (for MySQL 5.6-compatible Aurora), <code>aurora-mysql</code> (for MySQL 5.7-compatible Aurora), and <code>aurora-postgresql</code> </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the database engine to use.</p> <p>To list all of the available engine versions for <code>aurora</code> (for MySQL 5.6-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-mysql</code> (for MySQL 5.7-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-mysql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-postgresql</code>, use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-postgresql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p> <b>Aurora MySQL</b> </p> <p>Example: <code>5.6.10a</code>, <code>5.6.mysql_aurora.1.19.2</code>, <code>5.7.12</code>, <code>5.7.mysql_aurora.2.04.5</code> </p> <p> <b>Aurora PostgreSQL</b> </p> <p>Example: <code>9.6.3</code>, <code>10.7</code> </p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the instances in the DB cluster accept connections.</p> <p> Default: <code>3306</code> if engine is set as aurora or <code>5432</code> if set to aurora-postgresql. </p>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>The name of the master user for the DB cluster.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 16 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul>"];
      master_user_password: String.t option
        [@ocaml.doc
          "<p>The password for the master database user. This password can contain any printable ASCII character except \"/\", \"\"\", or \"@\".</p> <p>Constraints: Must contain from 8 to 41 characters.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>A value that indicates that the DB cluster should be associated with the specified option group.</p> <p>Permanent options can't be removed from an option group. The option group can't be removed from a DB cluster once it is associated with a DB cluster.</p>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p>The daily time range during which automated backups are created if automated backups are enabled using the <code>BackupRetentionPeriod</code> parameter. </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora\"> Adjusting the Preferred DB Cluster Maintenance Window</a> in the <i>Amazon Aurora User Guide.</i> </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>hh24:mi-hh24:mi</code>.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred maintenance window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).</p> <p>Format: <code>ddd:hh24:mi-ddd:hh24:mi</code> </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora\"> Adjusting the Preferred DB Cluster Maintenance Window</a> in the <i>Amazon Aurora User Guide.</i> </p> <p>Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.</p> <p>Constraints: Minimum 30-minute window.</p>"];
      replication_source_identifier: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the source DB instance or DB cluster if this DB cluster is created as a Read Replica.</p>"];
      tags: TagList.t [@ocaml.doc "<p>Tags to assign to the DB cluster.</p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB cluster is encrypted.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for an encrypted DB cluster.</p> <p>The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a DB cluster with the same AWS account that owns the KMS encryption key used to encrypt the new DB cluster, then you can use the KMS key alias instead of the ARN for the KMS encryption key.</p> <p>If an encryption key isn't specified in <code>KmsKeyId</code>:</p> <ul> <li> <p>If <code>ReplicationSourceIdentifier</code> identifies an encrypted source, then Amazon RDS will use the encryption key used to encrypt the source. Otherwise, Amazon RDS will use your default encryption key. </p> </li> <li> <p>If the <code>StorageEncrypted</code> parameter is enabled and <code>ReplicationSourceIdentifier</code> isn't specified, then Amazon RDS will use your default encryption key.</p> </li> </ul> <p>AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p> <p>If you create a Read Replica of an encrypted DB cluster in another AWS Region, you must set <code>KmsKeyId</code> to a KMS key ID that is valid in the destination AWS Region. This key is used to encrypt the Read Replica in that AWS Region.</p>"];
      pre_signed_url: String.t option
        [@ocaml.doc
          "<p>A URL that contains a Signature Version 4 signed request for the <code>CreateDBCluster</code> action to be called in the source AWS Region where the DB cluster is replicated from. You only need to specify <code>PreSignedUrl</code> when you are performing cross-region replication from an encrypted DB cluster.</p> <p>The pre-signed URL must be a valid request for the <code>CreateDBCluster</code> API action that can be executed in the source AWS Region that contains the encrypted DB cluster to be copied.</p> <p>The pre-signed URL request must contain the following parameter values:</p> <ul> <li> <p> <code>KmsKeyId</code> - The AWS KMS key identifier for the key to use to encrypt the copy of the DB cluster in the destination AWS Region. This should refer to the same KMS key for both the <code>CreateDBCluster</code> action that is called in the destination AWS Region, and the action contained in the pre-signed URL.</p> </li> <li> <p> <code>DestinationRegion</code> - The name of the AWS Region that Aurora Read Replica will be created in.</p> </li> <li> <p> <code>ReplicationSourceIdentifier</code> - The DB cluster identifier for the encrypted DB cluster to be copied. This identifier must be in the Amazon Resource Name (ARN) format for the source AWS Region. For example, if you are copying an encrypted DB cluster from the us-west-2 AWS Region, then your <code>ReplicationSourceIdentifier</code> would look like Example: <code>arn:aws:rds:us-west-2:123456789012:cluster:aurora-cluster1</code>.</p> </li> </ul> <p>To learn how to generate a Signature Version 4 signed request, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html\"> Authenticating Requests: Using Query Parameters (AWS Signature Version 4)</a> and <a href=\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\"> Signature Version 4 Signing Process</a>.</p> <note> <p>If you are using an AWS SDK tool or the AWS CLI, you can specify <code>SourceRegion</code> (or <code>--source-region</code> for the AWS CLI) instead of specifying <code>PreSignedUrl</code> manually. Specifying <code>SourceRegion</code> autogenerates a pre-signed URL that is a valid request for the operation that can be executed in the source AWS Region.</p> </note>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication</a> in the <i>Amazon Aurora User Guide.</i> </p>"];
      backtrack_window: Long.t option
        [@ocaml.doc
          "<p>The target backtrack window, in seconds. To disable backtracking, set this value to 0. </p> <p>Default: 0</p> <p>Constraints:</p> <ul> <li> <p>If specified, this value must be set to a number from 0 to 259,200 (72 hours).</p> </li> </ul>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      engine_mode: String.t option
        [@ocaml.doc
          "<p>The DB engine mode of the DB cluster, either <code>provisioned</code>, <code>serverless</code>, <code>parallelquery</code>, <code>global</code>, or <code>multimaster</code>.</p>"];
      scaling_configuration: ScalingConfiguration.t option
        [@ocaml.doc
          "<p>For DB clusters in <code>serverless</code> DB engine mode, the scaling properties of the DB cluster.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled.</p>"];
      global_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> The global cluster ID of an Aurora cluster that becomes the primary cluster in the new global database cluster. </p>"];
      enable_http_endpoint: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable the HTTP endpoint for an Aurora Serverless DB cluster. By default, the HTTP endpoint is disabled.</p> <p>When enabled, the HTTP endpoint provides a connectionless web service API for running SQL queries on the Aurora Serverless DB cluster. You can also query your database from inside the RDS console with the query editor.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html\">Using the Data API for Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the DB cluster to snapshots of the DB cluster. The default is not to copy them.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?(availability_zones= [])  ?backup_retention_period 
      ?character_set_name  ?database_name  ~d_b_cluster_identifier 
      ?d_b_cluster_parameter_group_name  ?(vpc_security_group_ids= []) 
      ?d_b_subnet_group_name  ~engine  ?engine_version  ?port 
      ?master_username  ?master_user_password  ?option_group_name 
      ?preferred_backup_window  ?preferred_maintenance_window 
      ?replication_source_identifier  ?(tags= [])  ?storage_encrypted 
      ?kms_key_id  ?pre_signed_url  ?enable_i_a_m_database_authentication 
      ?backtrack_window  ?(enable_cloudwatch_logs_exports= [])  ?engine_mode 
      ?scaling_configuration  ?deletion_protection 
      ?global_cluster_identifier  ?enable_http_endpoint 
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
        replication_source_identifier;
        tags;
        storage_encrypted;
        kms_key_id;
        pre_signed_url;
        enable_i_a_m_database_authentication;
        backtrack_window;
        enable_cloudwatch_logs_exports;
        engine_mode;
        scaling_configuration;
        deletion_protection;
        global_cluster_identifier;
        enable_http_endpoint;
        copy_tags_to_snapshot
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.copy_tags_to_snapshot
              (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.enable_http_endpoint
             (fun f -> ("enable_http_endpoint", (Boolean.to_json f)));
           Util.option_map v.global_cluster_identifier
             (fun f -> ("global_cluster_identifier", (String.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
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
           Util.option_map v.pre_signed_url
             (fun f -> ("pre_signed_url", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.replication_source_identifier
             (fun f -> ("replication_source_identifier", (String.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.master_user_password
             (fun f -> ("master_user_password", (String.to_json f)));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
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
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          master_user_password =
            (Util.option_bind (Xml.member "MasterUserPassword" xml)
               String.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          preferred_backup_window =
            (Util.option_bind (Xml.member "PreferredBackupWindow" xml)
               String.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          replication_source_identifier =
            (Util.option_bind (Xml.member "ReplicationSourceIdentifier" xml)
               String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          pre_signed_url =
            (Util.option_bind (Xml.member "PreSignedUrl" xml) String.parse);
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
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          global_cluster_identifier =
            (Util.option_bind (Xml.member "GlobalClusterIdentifier" xml)
               String.parse);
          enable_http_endpoint =
            (Util.option_bind (Xml.member "EnableHttpEndpoint" xml)
               Boolean.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((([] @
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
                                            Ezxmlm.make_tag
                                              "CharacterSetName"
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
                             [Util.option_map v.master_username
                                (fun f ->
                                   Ezxmlm.make_tag "MasterUsername"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.master_user_password
                               (fun f ->
                                  Ezxmlm.make_tag "MasterUserPassword"
                                    ([], (String.to_xml f)))])
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
                        [Util.option_map v.replication_source_identifier
                           (fun f ->
                              Ezxmlm.make_tag "ReplicationSourceIdentifier"
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
                    [Util.option_map v.pre_signed_url
                       (fun f ->
                          Ezxmlm.make_tag "PreSignedUrl"
                            ([], (String.to_xml f)))])
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
              [Util.option_map v.deletion_protection
                 (fun f ->
                    Ezxmlm.make_tag "DeletionProtection"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.global_cluster_identifier
                (fun f ->
                   Ezxmlm.make_tag "GlobalClusterIdentifier"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.enable_http_endpoint
               (fun f ->
                  Ezxmlm.make_tag "EnableHttpEndpoint"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.copy_tags_to_snapshot
              (fun f ->
                 Ezxmlm.make_tag "CopyTagsToSnapshot"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module CreateDBClusterResult = CreateDBClusterResult
type input = CreateDBClusterMessage.t
type output = CreateDBClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateDBClusterMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateDBClusterResponse" (snd xml))
        (Xml.member "CreateDBClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateDBClusterResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateDBClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBClusterResult - missing field in body or children: "
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