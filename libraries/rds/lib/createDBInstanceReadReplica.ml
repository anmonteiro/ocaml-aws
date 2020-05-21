open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBInstanceReadReplicaMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier of the Read Replica. This identifier is the unique key that identifies a DB instance. This parameter is stored as a lowercase string.</p>"];
      source_d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the DB instance that will act as the source for the Read Replica. Each DB instance can have up to five Read Replicas.</p> <p>Constraints:</p> <ul> <li> <p>Must be the identifier of an existing MySQL, MariaDB, Oracle, or PostgreSQL DB instance.</p> </li> <li> <p>Can specify a DB instance that is a MySQL Read Replica only if the source is running MySQL 5.6 or later.</p> </li> <li> <p>For the limitations of Oracle Read Replicas, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-read-replicas.html\">Read Replica Limitations with Oracle</a> in the <i>Amazon RDS User Guide</i>.</p> </li> <li> <p>Can specify a DB instance that is a PostgreSQL DB instance only if the source is running PostgreSQL 9.3.5 or later (9.4.7 and higher for cross-region replication).</p> </li> <li> <p>The specified DB instance must have automatic backups enabled, its backup retention period must be greater than 0.</p> </li> <li> <p>If the source DB instance is in the same AWS Region as the Read Replica, specify a valid DB instance identifier.</p> </li> <li> <p>If the source DB instance is in a different AWS Region than the Read Replica, specify a valid DB instance ARN. For more information, go to <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing\"> Constructing an ARN for Amazon RDS</a> in the <i>Amazon RDS User Guide</i>.</p> </li> </ul>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The compute and memory capacity of the Read Replica, for example, <code>db.m4.large</code>. Not all DB instance classes are available in all AWS Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html\">DB Instance Class</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Default: Inherits from the source DB instance.</p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone (AZ) where the Read Replica will be created.</p> <p>Default: A random, system-chosen Availability Zone in the endpoint's AWS Region.</p> <p> Example: <code>us-east-1d</code> </p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number that the DB instance uses for connections.</p> <p>Default: Inherits from the source DB instance</p> <p>Valid Values: <code>1150-65535</code> </p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the Read Replica is in a Multi-AZ deployment. </p> <p>You can create a Read Replica as a Multi-AZ DB instance. RDS creates a standby of your replica in another Availability Zone for failover support for the replica. Creating your Read Replica as a Multi-AZ DB instance is independent of whether the source database is a Multi-AZ DB instance. </p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether minor engine upgrades are applied automatically to the Read Replica during the maintenance window.</p> <p>Default: Inherits from the source DB instance</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The option group the DB instance is associated with. If omitted, the option group associated with the source instance is used.</p>"];
      d_b_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group to associate with this DB instance.</p> <p>If you do not specify a value for <code>DBParameterGroupName</code>, then Amazon RDS uses the <code>DBParameterGroup</code> of source DB instance for a same region Read Replica, or the default <code>DBParameterGroup</code> for the specified DB engine for a cross region Read Replica.</p> <note> <p>Currently, specifying a parameter group for this operation is only supported for Oracle DB instances.</p> </note> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul>"];
      publicly_accessible: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is publicly accessible. When the DB instance is publicly accessible, it is an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. When the DB instance isn't publicly accessible, it is an internal instance with a DNS name that resolves to a private IP address. For more information, see <a>CreateDBInstance</a>.</p>"];
      tags: TagList.t ;
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>Specifies a DB subnet group for the DB instance. The new DB instance is created in the VPC associated with the DB subnet group. If no DB subnet group is specified, then the new DB instance isn't created in a VPC.</p> <p>Constraints:</p> <ul> <li> <p>Can only be specified if the source DB instance identifier specifies a DB instance in another AWS Region.</p> </li> <li> <p>If supplied, must match the name of an existing DBSubnetGroup.</p> </li> <li> <p>The specified DB subnet group must be in the same AWS Region in which the operation is running.</p> </li> <li> <p>All Read Replicas in one AWS Region that are created from the same source DB instance must either:&gt;</p> <ul> <li> <p>Specify DB subnet groups from the same VPC. All these Read Replicas are created in the same VPC.</p> </li> <li> <p>Not specify a DB subnet group. All these Read Replicas are created outside of any VPC.</p> </li> </ul> </li> </ul> <p>Example: <code>mySubnetgroup</code> </p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p> A list of EC2 VPC security groups to associate with the Read Replica. </p> <p> Default: The default EC2 VPC security group for the DB subnet group's VPC. </p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type to be associated with the Read Replica.</p> <p> Valid values: <code>standard | gp2 | io1</code> </p> <p> If you specify <code>io1</code>, you must also include a value for the <code>Iops</code> parameter. </p> <p> Default: <code>io1</code> if the <code>Iops</code> parameter is specified, otherwise <code>gp2</code> </p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the Read Replica to snapshots of the Read Replica. By default, tags are not copied.</p>"];
      monitoring_interval: Integer.t option
        [@ocaml.doc
          "<p>The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the Read Replica. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0.</p> <p>If <code>MonitoringRoleArn</code> is specified, then you must also set <code>MonitoringInterval</code> to a value other than 0.</p> <p>Valid Values: <code>0, 1, 5, 10, 15, 30, 60</code> </p>"];
      monitoring_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, <code>arn:aws:iam:123456789012:role/emaccess</code>. For information on creating a monitoring role, go to <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html#USER_Monitoring.OS.IAMRole\">To create an IAM role for Amazon RDS Enhanced Monitoring</a> in the <i>Amazon RDS User Guide</i>.</p> <p>If <code>MonitoringInterval</code> is set to a value other than 0, then you must supply a <code>MonitoringRoleArn</code> value.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key ID for an encrypted Read Replica. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key. </p> <p>If you create an encrypted Read Replica in the same AWS Region as the source DB instance, then you do not have to specify a value for this parameter. The Read Replica is encrypted with the same KMS key as the source DB instance. </p> <p>If you create an encrypted Read Replica in a different AWS Region, then you must specify a KMS key for the destination AWS Region. KMS encryption keys are specific to the AWS Region that they are created in, and you can't use encryption keys from one AWS Region in another AWS Region. </p> <p>You can't create an encrypted Read Replica from an unencrypted DB instance. </p>"];
      pre_signed_url: String.t option
        [@ocaml.doc
          "<p>The URL that contains a Signature Version 4 signed request for the <code>CreateDBInstanceReadReplica</code> API action in the source AWS Region that contains the source DB instance. </p> <p>You must specify this parameter when you create an encrypted Read Replica from another AWS Region by using the Amazon RDS API. Don't specify <code>PreSignedUrl</code> when you are creating an encrypted Read Replica in the same AWS Region. </p> <p>The presigned URL must be a valid request for the <code>CreateDBInstanceReadReplica</code> API action that can be executed in the source AWS Region that contains the encrypted source DB instance. The presigned URL request must contain the following parameter values: </p> <ul> <li> <p> <code>DestinationRegion</code> - The AWS Region that the encrypted Read Replica is created in. This AWS Region is the same one where the <code>CreateDBInstanceReadReplica</code> action is called that contains this presigned URL. </p> <p>For example, if you create an encrypted DB instance in the us-west-1 AWS Region, from a source DB instance in the us-east-2 AWS Region, then you call the <code>CreateDBInstanceReadReplica</code> action in the us-east-1 AWS Region and provide a presigned URL that contains a call to the <code>CreateDBInstanceReadReplica</code> action in the us-west-2 AWS Region. For this example, the <code>DestinationRegion</code> in the presigned URL must be set to the us-east-1 AWS Region. </p> </li> <li> <p> <code>KmsKeyId</code> - The AWS KMS key identifier for the key to use to encrypt the Read Replica in the destination AWS Region. This is the same identifier for both the <code>CreateDBInstanceReadReplica</code> action that is called in the destination AWS Region, and the action contained in the presigned URL. </p> </li> <li> <p> <code>SourceDBInstanceIdentifier</code> - The DB instance identifier for the encrypted DB instance to be replicated. This identifier must be in the Amazon Resource Name (ARN) format for the source AWS Region. For example, if you are creating an encrypted Read Replica from a DB instance in the us-west-2 AWS Region, then your <code>SourceDBInstanceIdentifier</code> looks like the following example: <code>arn:aws:rds:us-west-2:123456789012:instance:mysql-instance1-20161115</code>. </p> </li> </ul> <p>To learn how to generate a Signature Version 4 signed request, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/sigv4-query-string-auth.html\">Authenticating Requests: Using Query Parameters (AWS Signature Version 4)</a> and <a href=\"https://docs.aws.amazon.com/general/latest/gr/signature-version-4.html\">Signature Version 4 Signing Process</a>. </p> <note> <p>If you are using an AWS SDK tool or the AWS CLI, you can specify <code>SourceRegion</code> (or <code>--source-region</code> for the AWS CLI) instead of specifying <code>PreSignedUrl</code> manually. Specifying <code>SourceRegion</code> autogenerates a pre-signed URL that is a valid request for the operation that can be executed in the source AWS Region.</p> </note>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled. For information about the supported DB engines, see <a>CreateDBInstance</a>.</p> <p>For more information about IAM database authentication, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication for MySQL and PostgreSQL</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      enable_performance_insights: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable Performance Insights for the Read Replica. </p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html\">Using Amazon Performance Insights</a> in the <i>Amazon RDS User Guide</i>. </p>"];
      performance_insights_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key.</p> <p>If you do not specify a value for <code>PerformanceInsightsKMSKeyId</code>, then Amazon RDS uses your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p>"];
      performance_insights_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). </p>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of logs that the new DB instance is to export to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs </a> in the <i>Amazon RDS User Guide</i>.</p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"];
      use_default_processor_features: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance class of the DB instance uses its default processor features.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html\"> Deleting a DB Instance</a>. </p>"];
      domain: String.t option
        [@ocaml.doc
          "<p>The Active Directory directory ID to create the DB instance in.</p> <p>For Oracle DB instances, Amazon RDS can use Kerberos Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-kerberos.html\"> Using Kerberos Authentication with Amazon RDS for Oracle</a> in the <i>Amazon RDS User Guide</i>.</p>"];
      domain_i_a_m_role_name: String.t option
        [@ocaml.doc
          "<p>Specify the name of the IAM role to be used when making API calls to the Directory Service.</p>"]}
    let make ~d_b_instance_identifier  ~source_d_b_instance_identifier 
      ?d_b_instance_class  ?availability_zone  ?port  ?multi_a_z 
      ?auto_minor_version_upgrade  ?iops  ?option_group_name 
      ?d_b_parameter_group_name  ?publicly_accessible  ?(tags= []) 
      ?d_b_subnet_group_name  ?(vpc_security_group_ids= [])  ?storage_type 
      ?copy_tags_to_snapshot  ?monitoring_interval  ?monitoring_role_arn 
      ?kms_key_id  ?pre_signed_url  ?enable_i_a_m_database_authentication 
      ?enable_performance_insights  ?performance_insights_k_m_s_key_id 
      ?performance_insights_retention_period 
      ?(enable_cloudwatch_logs_exports= [])  ?(processor_features= []) 
      ?use_default_processor_features  ?deletion_protection  ?domain 
      ?domain_i_a_m_role_name  () =
      {
        d_b_instance_identifier;
        source_d_b_instance_identifier;
        d_b_instance_class;
        availability_zone;
        port;
        multi_a_z;
        auto_minor_version_upgrade;
        iops;
        option_group_name;
        d_b_parameter_group_name;
        publicly_accessible;
        tags;
        d_b_subnet_group_name;
        vpc_security_group_ids;
        storage_type;
        copy_tags_to_snapshot;
        monitoring_interval;
        monitoring_role_arn;
        kms_key_id;
        pre_signed_url;
        enable_i_a_m_database_authentication;
        enable_performance_insights;
        performance_insights_k_m_s_key_id;
        performance_insights_retention_period;
        enable_cloudwatch_logs_exports;
        processor_features;
        use_default_processor_features;
        deletion_protection;
        domain;
        domain_i_a_m_role_name
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.domain_i_a_m_role_name
              (fun f -> ("domain_i_a_m_role_name", (String.to_json f)));
           Util.option_map v.domain (fun f -> ("domain", (String.to_json f)));
           Util.option_map v.deletion_protection
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
           Util.option_map v.enable_i_a_m_database_authentication
             (fun f ->
                ("enable_i_a_m_database_authentication", (Boolean.to_json f)));
           Util.option_map v.pre_signed_url
             (fun f -> ("pre_signed_url", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.monitoring_role_arn
             (fun f -> ("monitoring_role_arn", (String.to_json f)));
           Util.option_map v.monitoring_interval
             (fun f -> ("monitoring_interval", (Integer.to_json f)));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.publicly_accessible
             (fun f -> ("publicly_accessible", (Boolean.to_json f)));
           Util.option_map v.d_b_parameter_group_name
             (fun f -> ("d_b_parameter_group_name", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Some
             ("source_d_b_instance_identifier",
               (String.to_json v.source_d_b_instance_identifier));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          source_d_b_instance_identifier =
            (Xml.required "SourceDBInstanceIdentifier"
               (Util.option_bind
                  (Xml.member "SourceDBInstanceIdentifier" xml) String.parse));
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          d_b_parameter_group_name =
            (Util.option_bind (Xml.member "DBParameterGroupName" xml)
               String.parse);
          publicly_accessible =
            (Util.option_bind (Xml.member "PubliclyAccessible" xml)
               Boolean.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          monitoring_interval =
            (Util.option_bind (Xml.member "MonitoringInterval" xml)
               Integer.parse);
          monitoring_role_arn =
            (Util.option_bind (Xml.member "MonitoringRoleArn" xml)
               String.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          pre_signed_url =
            (Util.option_bind (Xml.member "PreSignedUrl" xml) String.parse);
          enable_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "EnableIAMDatabaseAuthentication" xml)
               Boolean.parse);
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
               Boolean.parse);
          domain = (Util.option_bind (Xml.member "Domain" xml) String.parse);
          domain_i_a_m_role_name =
            (Util.option_bind (Xml.member "DomainIAMRoleName" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((([] @
                                        [Some
                                           (Ezxmlm.make_tag
                                              "DBInstanceIdentifier"
                                              ([],
                                                (String.to_xml
                                                   v.d_b_instance_identifier)))])
                                       @
                                       [Some
                                          (Ezxmlm.make_tag
                                             "SourceDBInstanceIdentifier"
                                             ([],
                                               (String.to_xml
                                                  v.source_d_b_instance_identifier)))])
                                      @
                                      [Util.option_map v.d_b_instance_class
                                         (fun f ->
                                            Ezxmlm.make_tag "DBInstanceClass"
                                              ([], (String.to_xml f)))])
                                     @
                                     [Util.option_map v.availability_zone
                                        (fun f ->
                                           Ezxmlm.make_tag "AvailabilityZone"
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
                                  [Util.option_map
                                     v.auto_minor_version_upgrade
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "AutoMinorVersionUpgrade"
                                          ([], (Boolean.to_xml f)))])
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
                               [Util.option_map v.d_b_parameter_group_name
                                  (fun f ->
                                     Ezxmlm.make_tag "DBParameterGroupName"
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
                            [Util.option_map v.d_b_subnet_group_name
                               (fun f ->
                                  Ezxmlm.make_tag "DBSubnetGroupName"
                                    ([], (String.to_xml f)))])
                           @
                           (List.map
                              (fun x ->
                                 Some
                                   (Ezxmlm.make_tag "VpcSecurityGroupIds"
                                      ([],
                                        (VpcSecurityGroupIdList.to_xml [x]))))
                              v.vpc_security_group_ids))
                          @
                          [Util.option_map v.storage_type
                             (fun f ->
                                Ezxmlm.make_tag "StorageType"
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
                      [Util.option_map v.kms_key_id
                         (fun f ->
                            Ezxmlm.make_tag "KmsKeyId"
                              ([], (String.to_xml f)))])
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
            @
            [Util.option_map v.domain
               (fun f -> Ezxmlm.make_tag "Domain" ([], (String.to_xml f)))])
           @
           [Util.option_map v.domain_i_a_m_role_name
              (fun f ->
                 Ezxmlm.make_tag "DomainIAMRoleName" ([], (String.to_xml f)))])
  end
module CreateDBInstanceReadReplicaResult = CreateDBInstanceReadReplicaResult
type input = CreateDBInstanceReadReplicaMessage.t
type output = CreateDBInstanceReadReplicaResult.t
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
         ("Action", ["CreateDBInstanceReadReplica"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateDBInstanceReadReplicaMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateDBInstanceReadReplicaMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateDBInstanceReadReplicaResponse" (snd xml))
        (Xml.member "CreateDBInstanceReadReplicaResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateDBInstanceReadReplicaResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateDBInstanceReadReplicaResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBInstanceReadReplicaResult - missing field in body or children: "
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