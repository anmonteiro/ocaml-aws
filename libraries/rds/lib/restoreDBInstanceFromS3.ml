open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RestoreDBInstanceFromS3Message =
  struct
    type t =
      {
      d_b_name: String.t option
        [@ocaml.doc
          "<p>The name of the database to create when the DB instance is created. Follow the naming rules specified in <code>CreateDBInstance</code>. </p>"];
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier. This parameter is stored as a lowercase string. </p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>mydbinstance</code> </p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>The amount of storage (in gigabytes) to allocate initially for the DB instance. Follow the allocation rules specified in <code>CreateDBInstance</code>. </p> <note> <p>Be sure to allocate enough memory for your new DB instance so that the restore operation can succeed. You can also allocate additional memory for future growth. </p> </note>"];
      d_b_instance_class: String.t
        [@ocaml.doc
          "<p>The compute and memory capacity of the DB instance, for example, <code>db.m4.large</code>. Not all DB instance classes are available in all AWS Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html\">DB Instance Class</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Importing from Amazon S3 isn't supported on the db.t2.micro DB instance class. </p>"];
      engine: String.t
        [@ocaml.doc
          "<p>The name of the database engine to be used for this instance. </p> <p>Valid Values: <code>mysql</code> </p>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>The name for the master user. </p> <p>Constraints: </p> <ul> <li> <p>Must be 1 to 16 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul>"];
      master_user_password: String.t option
        [@ocaml.doc
          "<p>The password for the master user. The password can include any printable ASCII character except \"/\", \"\"\", or \"@\". </p> <p>Constraints: Must contain from 8 to 41 characters.</p>"];
      d_b_security_groups: DBSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of DB security groups to associate with this DB instance.</p> <p>Default: The default DB security group for the database engine.</p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of VPC security groups to associate with this DB instance. </p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone that the DB instance is created in. For information about AWS Regions and Availability Zones, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html\">Regions and Availability Zones</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Default: A random, system-chosen Availability Zone in the endpoint's AWS Region. </p> <p> Example: <code>us-east-1d</code> </p> <p>Constraint: The <code>AvailabilityZone</code> parameter can't be specified if the DB instance is a Multi-AZ deployment. The specified Availability Zone must be in the same AWS Region as the current endpoint. </p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>A DB subnet group to associate with this DB instance.</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>The time range each week during which system maintenance can occur, in Universal Coordinated Time (UTC). For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance\">Amazon RDS Maintenance Window</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>ddd:hh24:mi-ddd:hh24:mi</code>.</p> </li> <li> <p>Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred backup window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"];
      d_b_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group to associate with this DB instance.</p> <p>If you do not specify a value for <code>DBParameterGroupName</code>, then the default <code>DBParameterGroup</code> for the specified DB engine is used.</p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. For more information, see <code>CreateDBInstance</code>. </p>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p>The time range each day during which automated backups are created if automated backups are enabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow\">The Backup Window</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>hh24:mi-hh24:mi</code>.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred maintenance window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the database accepts connections. </p> <p>Type: Integer </p> <p>Valid Values: <code>1150</code>-<code>65535</code> </p> <p>Default: <code>3306</code> </p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is a Multi-AZ deployment. If the DB instance is a Multi-AZ deployment, you can't set the <code>AvailabilityZone</code> parameter. </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the database engine to use. Choose the latest minor version of your database engine. For information about engine versions, see <code>CreateDBInstance</code>, or call <code>DescribeDBEngineVersions</code>. </p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether minor engine upgrades are applied automatically to the DB instance during the maintenance window. By default, minor engine upgrades are not applied automatically. </p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>The license model for this DB instance. Use <code>general-public-license</code>. </p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The amount of Provisioned IOPS (input/output operations per second) to allocate initially for the DB instance. For information about valid Iops values, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS\">Amazon RDS Provisioned IOPS Storage to Improve Performance</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the option group to associate with this DB instance. If this argument is omitted, the default option group for the specified engine is used. </p>"];
      publicly_accessible: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is publicly accessible. When the DB instance is publicly accessible, it is an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. When the DB instance isn't publicly accessible, it is an internal instance with a DNS name that resolves to a private IP address. For more information, see <a>CreateDBInstance</a>.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>A list of tags to associate with this DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html\">Tagging Amazon RDS Resources</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type to be associated with the DB instance. </p> <p>Valid values: <code>standard</code> | <code>gp2</code> | <code>io1</code> </p> <p>If you specify <code>io1</code>, you must also include a value for the <code>Iops</code> parameter. </p> <p>Default: <code>io1</code> if the <code>Iops</code> parameter is specified; otherwise <code>gp2</code> </p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the new DB instance is encrypted or not. </p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for an encrypted DB instance. </p> <p>The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a DB instance with the same AWS account that owns the KMS encryption key used to encrypt the new DB instance, then you can use the KMS key alias instead of the ARN for the KM encryption key. </p> <p>If the <code>StorageEncrypted</code> parameter is enabled, and you do not specify a value for the <code>KmsKeyId</code> parameter, then Amazon RDS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region. </p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the DB instance to snapshots of the DB instance. By default, tags are not copied. </p>"];
      monitoring_interval: Integer.t option
        [@ocaml.doc
          "<p>The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. </p> <p>If <code>MonitoringRoleArn</code> is specified, then you must also set <code>MonitoringInterval</code> to a value other than 0. </p> <p>Valid Values: 0, 1, 5, 10, 15, 30, 60 </p> <p>Default: <code>0</code> </p>"];
      monitoring_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, <code>arn:aws:iam:123456789012:role/emaccess</code>. For information on creating a monitoring role, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling\">Setting Up and Enabling Enhanced Monitoring</a> in the <i>Amazon RDS User Guide.</i> </p> <p>If <code>MonitoringInterval</code> is set to a value other than 0, then you must supply a <code>MonitoringRoleArn</code> value. </p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled. For information about the supported DB engines, see <a>CreateDBInstance</a>.</p> <p>For more information about IAM database authentication, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication for MySQL and PostgreSQL</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      source_engine: String.t
        [@ocaml.doc
          "<p>The name of the engine of your source database. </p> <p>Valid Values: <code>mysql</code> </p>"];
      source_engine_version: String.t
        [@ocaml.doc
          "<p>The engine version of your source database. </p> <p>Valid Values: <code>5.6</code> </p>"];
      s3_bucket_name: String.t
        [@ocaml.doc
          "<p>The name of your Amazon S3 bucket that contains your database backup file. </p>"];
      s3_prefix: String.t option
        [@ocaml.doc "<p>The prefix of your Amazon S3 bucket. </p>"];
      s3_ingestion_role_arn: String.t
        [@ocaml.doc
          "<p>An AWS Identity and Access Management (IAM) role to allow Amazon RDS to access your Amazon S3 bucket. </p>"];
      enable_performance_insights: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable Performance Insights for the DB instance. </p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html\">Using Amazon Performance Insights</a> in the <i>Amazon Relational Database Service User Guide</i>. </p>"];
      performance_insights_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), the KMS key identifier, or the KMS key alias for the KMS encryption key. </p> <p>If you do not specify a value for <code>PerformanceInsightsKMSKeyId</code>, then Amazon RDS uses your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p>"];
      performance_insights_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). </p>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of logs that the restored DB instance is to export to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs</a> in the <i>Amazon RDS User Guide</i>.</p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"];
      use_default_processor_features: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance class of the DB instance uses its default processor features.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html\"> Deleting a DB Instance</a>. </p>"]}
    let make ?d_b_name  ~d_b_instance_identifier  ?allocated_storage 
      ~d_b_instance_class  ~engine  ?master_username  ?master_user_password 
      ?(d_b_security_groups= [])  ?(vpc_security_group_ids= []) 
      ?availability_zone  ?d_b_subnet_group_name 
      ?preferred_maintenance_window  ?d_b_parameter_group_name 
      ?backup_retention_period  ?preferred_backup_window  ?port  ?multi_a_z 
      ?engine_version  ?auto_minor_version_upgrade  ?license_model  ?iops 
      ?option_group_name  ?publicly_accessible  ?(tags= [])  ?storage_type 
      ?storage_encrypted  ?kms_key_id  ?copy_tags_to_snapshot 
      ?monitoring_interval  ?monitoring_role_arn 
      ?enable_i_a_m_database_authentication  ~source_engine 
      ~source_engine_version  ~s3_bucket_name  ?s3_prefix 
      ~s3_ingestion_role_arn  ?enable_performance_insights 
      ?performance_insights_k_m_s_key_id 
      ?performance_insights_retention_period 
      ?(enable_cloudwatch_logs_exports= [])  ?(processor_features= []) 
      ?use_default_processor_features  ?deletion_protection  () =
      {
        d_b_name;
        d_b_instance_identifier;
        allocated_storage;
        d_b_instance_class;
        engine;
        master_username;
        master_user_password;
        d_b_security_groups;
        vpc_security_group_ids;
        availability_zone;
        d_b_subnet_group_name;
        preferred_maintenance_window;
        d_b_parameter_group_name;
        backup_retention_period;
        preferred_backup_window;
        port;
        multi_a_z;
        engine_version;
        auto_minor_version_upgrade;
        license_model;
        iops;
        option_group_name;
        publicly_accessible;
        tags;
        storage_type;
        storage_encrypted;
        kms_key_id;
        copy_tags_to_snapshot;
        monitoring_interval;
        monitoring_role_arn;
        enable_i_a_m_database_authentication;
        source_engine;
        source_engine_version;
        s3_bucket_name;
        s3_prefix;
        s3_ingestion_role_arn;
        enable_performance_insights;
        performance_insights_k_m_s_key_id;
        performance_insights_retention_period;
        enable_cloudwatch_logs_exports;
        processor_features;
        use_default_processor_features;
        deletion_protection
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.deletion_protection
              (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.use_default_processor_features
             (fun f ->
                ("use_default_processor_features", (Boolean.to_json f)));
           Some
             ("processor_features",
               (ProcessorFeatureList.to_json v.processor_features));
           Some
             ("enable_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enable_cloudwatch_logs_exports));
           Util.option_map v.performance_insights_retention_period
             (fun f ->
                ("performance_insights_retention_period",
                  (Integer.to_json f)));
           Util.option_map v.performance_insights_k_m_s_key_id
             (fun f ->
                ("performance_insights_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.enable_performance_insights
             (fun f -> ("enable_performance_insights", (Boolean.to_json f)));
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
           Util.option_map v.monitoring_role_arn
             (fun f -> ("monitoring_role_arn", (String.to_json f)));
           Util.option_map v.monitoring_interval
             (fun f -> ("monitoring_interval", (Integer.to_json f)));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.publicly_accessible
             (fun f -> ("publicly_accessible", (Boolean.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
           Util.option_map v.d_b_parameter_group_name
             (fun f -> ("d_b_parameter_group_name", (String.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Some
             ("d_b_security_groups",
               (DBSecurityGroupNameList.to_json v.d_b_security_groups));
           Util.option_map v.master_user_password
             (fun f -> ("master_user_password", (String.to_json f)));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
           Some ("engine", (String.to_json v.engine));
           Some ("d_b_instance_class", (String.to_json v.d_b_instance_class));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier));
           Util.option_map v.d_b_name
             (fun f -> ("d_b_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_name =
            (Util.option_bind (Xml.member "DBName" xml) String.parse);
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          d_b_instance_class =
            (Xml.required "DBInstanceClass"
               (Util.option_bind (Xml.member "DBInstanceClass" xml)
                  String.parse));
          engine =
            (Xml.required "Engine"
               (Util.option_bind (Xml.member "Engine" xml) String.parse));
          master_username =
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          master_user_password =
            (Util.option_bind (Xml.member "MasterUserPassword" xml)
               String.parse);
          d_b_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSecurityGroups" xml)
                  DBSecurityGroupNameList.parse));
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          d_b_parameter_group_name =
            (Util.option_bind (Xml.member "DBParameterGroupName" xml)
               String.parse);
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          preferred_backup_window =
            (Util.option_bind (Xml.member "PreferredBackupWindow" xml)
               String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          publicly_accessible =
            (Util.option_bind (Xml.member "PubliclyAccessible" xml)
               Boolean.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          monitoring_interval =
            (Util.option_bind (Xml.member "MonitoringInterval" xml)
               Integer.parse);
          monitoring_role_arn =
            (Util.option_bind (Xml.member "MonitoringRoleArn" xml)
               String.parse);
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
          enable_performance_insights =
            (Util.option_bind (Xml.member "EnablePerformanceInsights" xml)
               Boolean.parse);
          performance_insights_k_m_s_key_id =
            (Util.option_bind (Xml.member "PerformanceInsightsKMSKeyId" xml)
               String.parse);
          performance_insights_retention_period =
            (Util.option_bind
               (Xml.member "PerformanceInsightsRetentionPeriod" xml)
               Integer.parse);
          enable_cloudwatch_logs_exports =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "EnableCloudwatchLogsExports" xml)
                  LogTypeList.parse));
          processor_features =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProcessorFeatures" xml)
                  ProcessorFeatureList.parse));
          use_default_processor_features =
            (Util.option_bind (Xml.member "UseDefaultProcessorFeatures" xml)
               Boolean.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((((((((((((((((([] @
                                                     [Util.option_map
                                                        v.d_b_name
                                                        (fun f ->
                                                           Ezxmlm.make_tag
                                                             "DBName"
                                                             ([],
                                                               (String.to_xml
                                                                  f)))])
                                                    @
                                                    [Some
                                                       (Ezxmlm.make_tag
                                                          "DBInstanceIdentifier"
                                                          ([],
                                                            (String.to_xml
                                                               v.d_b_instance_identifier)))])
                                                   @
                                                   [Util.option_map
                                                      v.allocated_storage
                                                      (fun f ->
                                                         Ezxmlm.make_tag
                                                           "AllocatedStorage"
                                                           ([],
                                                             (Integer.to_xml
                                                                f)))])
                                                  @
                                                  [Some
                                                     (Ezxmlm.make_tag
                                                        "DBInstanceClass"
                                                        ([],
                                                          (String.to_xml
                                                             v.d_b_instance_class)))])
                                                 @
                                                 [Some
                                                    (Ezxmlm.make_tag "Engine"
                                                       ([],
                                                         (String.to_xml
                                                            v.engine)))])
                                                @
                                                [Util.option_map
                                                   v.master_username
                                                   (fun f ->
                                                      Ezxmlm.make_tag
                                                        "MasterUsername"
                                                        ([],
                                                          (String.to_xml f)))])
                                               @
                                               [Util.option_map
                                                  v.master_user_password
                                                  (fun f ->
                                                     Ezxmlm.make_tag
                                                       "MasterUserPassword"
                                                       ([],
                                                         (String.to_xml f)))])
                                              @
                                              (List.map
                                                 (fun x ->
                                                    Some
                                                      (Ezxmlm.make_tag
                                                         "DBSecurityGroups"
                                                         ([],
                                                           (DBSecurityGroupNameList.to_xml
                                                              [x]))))
                                                 v.d_b_security_groups))
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
                                            [Util.option_map
                                               v.availability_zone
                                               (fun f ->
                                                  Ezxmlm.make_tag
                                                    "AvailabilityZone"
                                                    ([], (String.to_xml f)))])
                                           @
                                           [Util.option_map
                                              v.d_b_subnet_group_name
                                              (fun f ->
                                                 Ezxmlm.make_tag
                                                   "DBSubnetGroupName"
                                                   ([], (String.to_xml f)))])
                                          @
                                          [Util.option_map
                                             v.preferred_maintenance_window
                                             (fun f ->
                                                Ezxmlm.make_tag
                                                  "PreferredMaintenanceWindow"
                                                  ([], (String.to_xml f)))])
                                         @
                                         [Util.option_map
                                            v.d_b_parameter_group_name
                                            (fun f ->
                                               Ezxmlm.make_tag
                                                 "DBParameterGroupName"
                                                 ([], (String.to_xml f)))])
                                        @
                                        [Util.option_map
                                           v.backup_retention_period
                                           (fun f ->
                                              Ezxmlm.make_tag
                                                "BackupRetentionPeriod"
                                                ([], (Integer.to_xml f)))])
                                       @
                                       [Util.option_map
                                          v.preferred_backup_window
                                          (fun f ->
                                             Ezxmlm.make_tag
                                               "PreferredBackupWindow"
                                               ([], (String.to_xml f)))])
                                      @
                                      [Util.option_map v.port
                                         (fun f ->
                                            Ezxmlm.make_tag "Port"
                                              ([], (Integer.to_xml f)))])
                                     @
                                     [Util.option_map v.multi_a_z
                                        (fun f ->
                                           Ezxmlm.make_tag "MultiAZ"
                                             ([], (Boolean.to_xml f)))])
                                    @
                                    [Util.option_map v.engine_version
                                       (fun f ->
                                          Ezxmlm.make_tag "EngineVersion"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Util.option_map
                                      v.auto_minor_version_upgrade
                                      (fun f ->
                                         Ezxmlm.make_tag
                                           "AutoMinorVersionUpgrade"
                                           ([], (Boolean.to_xml f)))])
                                  @
                                  [Util.option_map v.license_model
                                     (fun f ->
                                        Ezxmlm.make_tag "LicenseModel"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.iops
                                    (fun f ->
                                       Ezxmlm.make_tag "Iops"
                                         ([], (Integer.to_xml f)))])
                                @
                                [Util.option_map v.option_group_name
                                   (fun f ->
                                      Ezxmlm.make_tag "OptionGroupName"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.publicly_accessible
                                  (fun f ->
                                     Ezxmlm.make_tag "PubliclyAccessible"
                                       ([], (Boolean.to_xml f)))])
                              @
                              (List.map
                                 (fun x ->
                                    Some
                                      (Ezxmlm.make_tag "Tags"
                                         ([], (TagList.to_xml [x])))) v.tags))
                             @
                             [Util.option_map v.storage_type
                                (fun f ->
                                   Ezxmlm.make_tag "StorageType"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.storage_encrypted
                               (fun f ->
                                  Ezxmlm.make_tag "StorageEncrypted"
                                    ([], (Boolean.to_xml f)))])
                           @
                           [Util.option_map v.kms_key_id
                              (fun f ->
                                 Ezxmlm.make_tag "KmsKeyId"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.copy_tags_to_snapshot
                             (fun f ->
                                Ezxmlm.make_tag "CopyTagsToSnapshot"
                                  ([], (Boolean.to_xml f)))])
                         @
                         [Util.option_map v.monitoring_interval
                            (fun f ->
                               Ezxmlm.make_tag "MonitoringInterval"
                                 ([], (Integer.to_xml f)))])
                        @
                        [Util.option_map v.monitoring_role_arn
                           (fun f ->
                              Ezxmlm.make_tag "MonitoringRoleArn"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map
                          v.enable_i_a_m_database_authentication
                          (fun f ->
                             Ezxmlm.make_tag
                               "EnableIAMDatabaseAuthentication"
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
                 [Util.option_map v.enable_performance_insights
                    (fun f ->
                       Ezxmlm.make_tag "EnablePerformanceInsights"
                         ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.performance_insights_k_m_s_key_id
                   (fun f ->
                      Ezxmlm.make_tag "PerformanceInsightsKMSKeyId"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.performance_insights_retention_period
                  (fun f ->
                     Ezxmlm.make_tag "PerformanceInsightsRetentionPeriod"
                       ([], (Integer.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "EnableCloudwatchLogsExports"
                         ([], (LogTypeList.to_xml [x]))))
                 v.enable_cloudwatch_logs_exports))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ProcessorFeatures"
                        ([], (ProcessorFeatureList.to_xml [x]))))
                v.processor_features))
            @
            [Util.option_map v.use_default_processor_features
               (fun f ->
                  Ezxmlm.make_tag "UseDefaultProcessorFeatures"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.deletion_protection
              (fun f ->
                 Ezxmlm.make_tag "DeletionProtection"
                   ([], (Boolean.to_xml f)))])
  end
module RestoreDBInstanceFromS3Result = RestoreDBInstanceFromS3Result
type input = RestoreDBInstanceFromS3Message.t
type output = RestoreDBInstanceFromS3Result.t
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
         ("Action", ["RestoreDBInstanceFromS3"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RestoreDBInstanceFromS3Message.to_query req))))) in
  (`POST, uri,
    (Headers.render (RestoreDBInstanceFromS3Message.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RestoreDBInstanceFromS3Response" (snd xml))
        (Xml.member "RestoreDBInstanceFromS3Result") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RestoreDBInstanceFromS3Result.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RestoreDBInstanceFromS3Result."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RestoreDBInstanceFromS3Result - missing field in body or children: "
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