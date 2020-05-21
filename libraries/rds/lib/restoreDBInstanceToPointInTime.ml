open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RestoreDBInstanceToPointInTimeMessage =
  struct
    type t =
      {
      source_d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the source DB instance from which to restore.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DB instance.</p> </li> </ul>"];
      target_d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The name of the new DB instance to be created.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul>"];
      restore_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time to restore from.</p> <p>Valid Values: Value must be a time in Universal Coordinated Time (UTC) format</p> <p>Constraints:</p> <ul> <li> <p>Must be before the latest restorable time for the DB instance</p> </li> <li> <p>Can't be specified if the <code>UseLatestRestorableTime</code> parameter is enabled</p> </li> </ul> <p>Example: <code>2009-09-07T23:45:00Z</code> </p>"];
      use_latest_restorable_time: Boolean.t option
        [@ocaml.doc
          "<p> A value that indicates whether the DB instance is restored from the latest backup time. By default, the DB instance isn't restored from the latest backup time. </p> <p>Constraints: Can't be specified if the <code>RestoreTime</code> parameter is provided.</p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The compute and memory capacity of the Amazon RDS DB instance, for example, <code>db.m4.large</code>. Not all DB instance classes are available in all AWS Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html\">DB Instance Class</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Default: The same DBInstanceClass as the original DB instance.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the database accepts connections.</p> <p>Constraints: Value must be <code>1150-65535</code> </p> <p>Default: The same port as the original DB instance.</p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone (AZ) where the DB instance will be created.</p> <p>Default: A random, system-chosen Availability Zone.</p> <p>Constraint: You can't specify the <code>AvailabilityZone</code> parameter if the DB instance is a Multi-AZ deployment.</p> <p>Example: <code>us-east-1a</code> </p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The DB subnet group name to use for the new instance.</p> <p>Constraints: If supplied, must match the name of an existing DBSubnetGroup.</p> <p>Example: <code>mySubnetgroup</code> </p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is a Multi-AZ deployment.</p> <p>Constraint: You can't specify the <code>AvailabilityZone</code> parameter if the DB instance is a Multi-AZ deployment.</p>"];
      publicly_accessible: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is publicly accessible. When the DB instance is publicly accessible, it is an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. When the DB instance isn't publicly accessible, it is an internal instance with a DNS name that resolves to a private IP address. For more information, see <a>CreateDBInstance</a>.</p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether minor version upgrades are applied automatically to the DB instance during the maintenance window.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>License model information for the restored DB instance.</p> <p>Default: Same as source.</p> <p> Valid values: <code>license-included</code> | <code>bring-your-own-license</code> | <code>general-public-license</code> </p>"];
      d_b_name: String.t option
        [@ocaml.doc
          "<p>The database name for the restored DB instance.</p> <note> <p>This parameter isn't used for the MySQL or MariaDB engines.</p> </note>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The database engine to use for the new instance.</p> <p>Default: The same as source</p> <p>Constraint: Must be compatible with the engine of the source</p> <p>Valid Values:</p> <ul> <li> <p> <code>mariadb</code> </p> </li> <li> <p> <code>mysql</code> </p> </li> <li> <p> <code>oracle-ee</code> </p> </li> <li> <p> <code>oracle-se2</code> </p> </li> <li> <p> <code>oracle-se1</code> </p> </li> <li> <p> <code>oracle-se</code> </p> </li> <li> <p> <code>postgres</code> </p> </li> <li> <p> <code>sqlserver-ee</code> </p> </li> <li> <p> <code>sqlserver-se</code> </p> </li> <li> <p> <code>sqlserver-ex</code> </p> </li> <li> <p> <code>sqlserver-web</code> </p> </li> </ul>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance.</p> <p>Constraints: Must be an integer greater than 1000.</p> <p> <b>SQL Server</b> </p> <p>Setting the IOPS value for the SQL Server database engine isn't supported.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the option group to be used for the restored DB instance.</p> <p>Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group, and that option group can't be removed from a DB instance once it is associated with a DB instance</p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the restored DB instance to snapshots of the DB instance. By default, tags are not copied.</p>"];
      tags: TagList.t ;
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type to be associated with the DB instance.</p> <p> Valid values: <code>standard | gp2 | io1</code> </p> <p> If you specify <code>io1</code>, you must also include a value for the <code>Iops</code> parameter. </p> <p> Default: <code>io1</code> if the <code>Iops</code> parameter is specified, otherwise <code>gp2</code> </p>"];
      tde_credential_arn: String.t option
        [@ocaml.doc
          "<p>The ARN from the key store with which to associate the instance for TDE encryption.</p>"];
      tde_credential_password: String.t option
        [@ocaml.doc
          "<p>The password for the given ARN from the key store in order to access the device.</p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p> A list of EC2 VPC security groups to associate with this DB instance. </p> <p> Default: The default EC2 VPC security group for the DB subnet group's VPC. </p>"];
      domain: String.t option
        [@ocaml.doc
          "<p>Specify the Active Directory directory ID to restore the DB instance in. The domain must be created prior to this operation. Currently, only Microsoft SQL Server and Oracle DB instances can be created in an Active Directory Domain. </p> <p>For Microsoft SQL Server DB instances, Amazon RDS can use Windows Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_SQLServerWinAuth.html\"> Using Windows Authentication with an Amazon RDS DB Instance Running Microsoft SQL Server</a> in the <i>Amazon RDS User Guide</i>.</p> <p>For Oracle DB instances, Amazon RDS can use Kerberos Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-kerberos.html\"> Using Kerberos Authentication with Amazon RDS for Oracle</a> in the <i>Amazon RDS User Guide</i>.</p>"];
      domain_i_a_m_role_name: String.t option
        [@ocaml.doc
          "<p>Specify the name of the IAM role to be used when making API calls to the Directory Service.</p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled. For information about the supported DB engines, see <a>CreateDBInstance</a>.</p> <p>For more information about IAM database authentication, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication for MySQL and PostgreSQL</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of logs that the restored DB instance is to export to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs</a> in the <i>Amazon RDS User Guide</i>.</p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"];
      use_default_processor_features: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance class of the DB instance uses its default processor features.</p>"];
      d_b_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group to associate with this DB instance.</p> <p>If you do not specify a value for <code>DBParameterGroupName</code>, then the default <code>DBParameterGroup</code> for the specified DB engine is used.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing DBParameterGroup.</p> </li> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html\"> Deleting a DB Instance</a>. </p>"];
      source_dbi_resource_id: String.t option
        [@ocaml.doc
          "<p>The resource ID of the source DB instance from which to restore.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?source_d_b_instance_identifier  ~target_d_b_instance_identifier
       ?restore_time  ?use_latest_restorable_time  ?d_b_instance_class  ?port
       ?availability_zone  ?d_b_subnet_group_name  ?multi_a_z 
      ?publicly_accessible  ?auto_minor_version_upgrade  ?license_model 
      ?d_b_name  ?engine  ?iops  ?option_group_name  ?copy_tags_to_snapshot 
      ?(tags= [])  ?storage_type  ?tde_credential_arn 
      ?tde_credential_password  ?(vpc_security_group_ids= [])  ?domain 
      ?domain_i_a_m_role_name  ?enable_i_a_m_database_authentication 
      ?(enable_cloudwatch_logs_exports= [])  ?(processor_features= []) 
      ?use_default_processor_features  ?d_b_parameter_group_name 
      ?deletion_protection  ?source_dbi_resource_id  () =
      {
        source_d_b_instance_identifier;
        target_d_b_instance_identifier;
        restore_time;
        use_latest_restorable_time;
        d_b_instance_class;
        port;
        availability_zone;
        d_b_subnet_group_name;
        multi_a_z;
        publicly_accessible;
        auto_minor_version_upgrade;
        license_model;
        d_b_name;
        engine;
        iops;
        option_group_name;
        copy_tags_to_snapshot;
        tags;
        storage_type;
        tde_credential_arn;
        tde_credential_password;
        vpc_security_group_ids;
        domain;
        domain_i_a_m_role_name;
        enable_i_a_m_database_authentication;
        enable_cloudwatch_logs_exports;
        processor_features;
        use_default_processor_features;
        d_b_parameter_group_name;
        deletion_protection;
        source_dbi_resource_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.source_dbi_resource_id
              (fun f -> ("source_dbi_resource_id", (String.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.d_b_parameter_group_name
             (fun f -> ("d_b_parameter_group_name", (String.to_json f)));
           Util.option_map v.use_default_processor_features
             (fun f ->
                ("use_default_processor_features", (Boolean.to_json f)));
           Some
             ("processor_features",
               (ProcessorFeatureList.to_json v.processor_features));
           Some
             ("enable_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enable_cloudwatch_logs_exports));
           Util.option_map v.enable_i_a_m_database_authentication
             (fun f ->
                ("enable_i_a_m_database_authentication", (Boolean.to_json f)));
           Util.option_map v.domain_i_a_m_role_name
             (fun f -> ("domain_i_a_m_role_name", (String.to_json f)));
           Util.option_map v.domain (fun f -> ("domain", (String.to_json f)));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Util.option_map v.tde_credential_password
             (fun f -> ("tde_credential_password", (String.to_json f)));
           Util.option_map v.tde_credential_arn
             (fun f -> ("tde_credential_arn", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.d_b_name
             (fun f -> ("d_b_name", (String.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.publicly_accessible
             (fun f -> ("publicly_accessible", (Boolean.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.use_latest_restorable_time
             (fun f -> ("use_latest_restorable_time", (Boolean.to_json f)));
           Util.option_map v.restore_time
             (fun f -> ("restore_time", (DateTime.to_json f)));
           Some
             ("target_d_b_instance_identifier",
               (String.to_json v.target_d_b_instance_identifier));
           Util.option_map v.source_d_b_instance_identifier
             (fun f -> ("source_d_b_instance_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          source_d_b_instance_identifier =
            (Util.option_bind (Xml.member "SourceDBInstanceIdentifier" xml)
               String.parse);
          target_d_b_instance_identifier =
            (Xml.required "TargetDBInstanceIdentifier"
               (Util.option_bind
                  (Xml.member "TargetDBInstanceIdentifier" xml) String.parse));
          restore_time =
            (Util.option_bind (Xml.member "RestoreTime" xml) DateTime.parse);
          use_latest_restorable_time =
            (Util.option_bind (Xml.member "UseLatestRestorableTime" xml)
               Boolean.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          publicly_accessible =
            (Util.option_bind (Xml.member "PubliclyAccessible" xml)
               Boolean.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          d_b_name =
            (Util.option_bind (Xml.member "DBName" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          tde_credential_arn =
            (Util.option_bind (Xml.member "TdeCredentialArn" xml)
               String.parse);
          tde_credential_password =
            (Util.option_bind (Xml.member "TdeCredentialPassword" xml)
               String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          domain = (Util.option_bind (Xml.member "Domain" xml) String.parse);
          domain_i_a_m_role_name =
            (Util.option_bind (Xml.member "DomainIAMRoleName" xml)
               String.parse);
          enable_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "EnableIAMDatabaseAuthentication" xml)
               Boolean.parse);
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
          d_b_parameter_group_name =
            (Util.option_bind (Xml.member "DBParameterGroupName" xml)
               String.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          source_dbi_resource_id =
            (Util.option_bind (Xml.member "SourceDbiResourceId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((((([] @
                                         [Util.option_map
                                            v.source_d_b_instance_identifier
                                            (fun f ->
                                               Ezxmlm.make_tag
                                                 "SourceDBInstanceIdentifier"
                                                 ([], (String.to_xml f)))])
                                        @
                                        [Some
                                           (Ezxmlm.make_tag
                                              "TargetDBInstanceIdentifier"
                                              ([],
                                                (String.to_xml
                                                   v.target_d_b_instance_identifier)))])
                                       @
                                       [Util.option_map v.restore_time
                                          (fun f ->
                                             Ezxmlm.make_tag "RestoreTime"
                                               ([], (DateTime.to_xml f)))])
                                      @
                                      [Util.option_map
                                         v.use_latest_restorable_time
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "UseLatestRestorableTime"
                                              ([], (Boolean.to_xml f)))])
                                     @
                                     [Util.option_map v.d_b_instance_class
                                        (fun f ->
                                           Ezxmlm.make_tag "DBInstanceClass"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.port
                                       (fun f ->
                                          Ezxmlm.make_tag "Port"
                                            ([], (Integer.to_xml f)))])
                                   @
                                   [Util.option_map v.availability_zone
                                      (fun f ->
                                         Ezxmlm.make_tag "AvailabilityZone"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.d_b_subnet_group_name
                                     (fun f ->
                                        Ezxmlm.make_tag "DBSubnetGroupName"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.multi_a_z
                                    (fun f ->
                                       Ezxmlm.make_tag "MultiAZ"
                                         ([], (Boolean.to_xml f)))])
                                @
                                [Util.option_map v.publicly_accessible
                                   (fun f ->
                                      Ezxmlm.make_tag "PubliclyAccessible"
                                        ([], (Boolean.to_xml f)))])
                               @
                               [Util.option_map v.auto_minor_version_upgrade
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
                             [Util.option_map v.d_b_name
                                (fun f ->
                                   Ezxmlm.make_tag "DBName"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.engine
                               (fun f ->
                                  Ezxmlm.make_tag "Engine"
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
                         [Util.option_map v.copy_tags_to_snapshot
                            (fun f ->
                               Ezxmlm.make_tag "CopyTagsToSnapshot"
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
                      [Util.option_map v.tde_credential_arn
                         (fun f ->
                            Ezxmlm.make_tag "TdeCredentialArn"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.tde_credential_password
                        (fun f ->
                           Ezxmlm.make_tag "TdeCredentialPassword"
                             ([], (String.to_xml f)))])
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "VpcSecurityGroupIds"
                               ([], (VpcSecurityGroupIdList.to_xml [x]))))
                       v.vpc_security_group_ids))
                   @
                   [Util.option_map v.domain
                      (fun f ->
                         Ezxmlm.make_tag "Domain" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.domain_i_a_m_role_name
                     (fun f ->
                        Ezxmlm.make_tag "DomainIAMRoleName"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.enable_i_a_m_database_authentication
                    (fun f ->
                       Ezxmlm.make_tag "EnableIAMDatabaseAuthentication"
                         ([], (Boolean.to_xml f)))])
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
             [Util.option_map v.d_b_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "DBParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.deletion_protection
               (fun f ->
                  Ezxmlm.make_tag "DeletionProtection"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.source_dbi_resource_id
              (fun f ->
                 Ezxmlm.make_tag "SourceDbiResourceId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module RestoreDBInstanceToPointInTimeResult =
  RestoreDBInstanceToPointInTimeResult
type input = RestoreDBInstanceToPointInTimeMessage.t
type output = RestoreDBInstanceToPointInTimeResult.t
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
         ("Action", ["RestoreDBInstanceToPointInTime"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (RestoreDBInstanceToPointInTimeMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RestoreDBInstanceToPointInTimeMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RestoreDBInstanceToPointInTimeResponse" (snd xml))
        (Xml.member "RestoreDBInstanceToPointInTimeResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RestoreDBInstanceToPointInTimeResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RestoreDBInstanceToPointInTimeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RestoreDBInstanceToPointInTimeResult - missing field in body or children: "
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