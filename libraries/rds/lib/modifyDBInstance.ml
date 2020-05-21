open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBInstanceMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier. This value is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBInstance.</p> </li> </ul>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>The new amount of storage (in gibibytes) to allocate for the DB instance. </p> <p>For MariaDB, MySQL, Oracle, and PostgreSQL, the value supplied must be at least 10% greater than the current value. Values that are not at least 10% greater than the existing value are rounded up so that they are 10% greater than the current value. </p> <p>For the valid values for allocated storage for each engine, see <code>CreateDBInstance</code>. </p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The new compute and memory capacity of the DB instance, for example, <code>db.m4.large</code>. Not all DB instance classes are available in all AWS Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html\">DB Instance Class</a> in the <i>Amazon RDS User Guide.</i> </p> <p>If you modify the DB instance class, an outage occurs during the change. The change is applied during the next maintenance window, unless <code>ApplyImmediately</code> is enabled for this request. </p> <p>Default: Uses existing setting</p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The new DB subnet group for the DB instance. You can use this parameter to move your DB instance to a different VPC. If your DB instance isn't in a VPC, you can also use this parameter to move your DB instance into a VPC. For more information, see <a href=\"http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_VPC.WorkingWithRDSInstanceinaVPC.html#USER_VPC.Non-VPC2VPC\">Updating the VPC for a DB Instance</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Changing the subnet group causes an outage during the change. The change is applied during the next maintenance window, unless you enable <code>ApplyImmediately</code>. </p> <p>Constraints: If supplied, must match the name of an existing DBSubnetGroup.</p> <p>Example: <code>mySubnetGroup</code> </p>"];
      d_b_security_groups: DBSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of DB security groups to authorize on this DB instance. Changing this setting doesn't result in an outage and the change is asynchronously applied as soon as possible.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match existing DBSecurityGroups.</p> </li> </ul>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of EC2 VPC security groups to authorize on this DB instance. This change is asynchronously applied as soon as possible.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The associated list of EC2 VPC security groups is managed by the DB cluster. For more information, see <code>ModifyDBCluster</code>.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match existing VpcSecurityGroupIds.</p> </li> </ul>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the modifications in this request and any pending modifications are asynchronously applied as soon as possible, regardless of the <code>PreferredMaintenanceWindow</code> setting for the DB instance. By default, this parameter is disabled. </p> <p> If this parameter is disabled, changes to the DB instance are applied during the next maintenance window. Some parameter changes can cause an outage and are applied on the next call to <a>RebootDBInstance</a>, or the next failure reboot. Review the table of parameters in <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.DBInstance.Modifying.html\">Modifying a DB Instance</a> in the <i>Amazon RDS User Guide.</i> to see the impact of enabling or disabling <code>ApplyImmediately</code> for each modified parameter and to determine when the changes are applied. </p>"];
      master_user_password: String.t option
        [@ocaml.doc
          "<p>The new password for the master user. The password can include any printable ASCII character except \"/\", \"\"\", or \"@\".</p> <p> Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible. Between the time of the request and the completion of the request, the <code>MasterUserPassword</code> element exists in the <code>PendingModifiedValues</code> element of the operation response. </p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The password for the master user is managed by the DB cluster. For more information, see <code>ModifyDBCluster</code>. </p> <p>Default: Uses existing setting</p> <p> <b>MariaDB</b> </p> <p>Constraints: Must contain from 8 to 41 characters.</p> <p> <b>Microsoft SQL Server</b> </p> <p>Constraints: Must contain from 8 to 128 characters.</p> <p> <b>MySQL</b> </p> <p>Constraints: Must contain from 8 to 41 characters.</p> <p> <b>Oracle</b> </p> <p>Constraints: Must contain from 8 to 30 characters.</p> <p> <b>PostgreSQL</b> </p> <p>Constraints: Must contain from 8 to 128 characters.</p> <note> <p>Amazon RDS API actions never return the password, so this action provides a way to regain access to a primary instance user if the password is lost. This includes restoring privileges that might have been accidentally revoked. </p> </note>"];
      d_b_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group to apply to the DB instance. Changing this setting doesn't result in an outage. The parameter group name itself is changed immediately, but the actual parameter changes are not applied until you reboot the instance without failover. In this case, the DB instance isn't rebooted automatically and the parameter changes isn't applied during the next maintenance window.</p> <p>Default: Uses existing setting</p> <p>Constraints: The DB parameter group must be in the same DB parameter group family as this DB instance.</p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days to retain automated backups. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.</p> <p>Changing this parameter can result in an outage if you change from 0 to a non-zero value or from a non-zero value to 0. These changes are applied during the next maintenance window unless the <code>ApplyImmediately</code> parameter is enabled for this request. If you change the parameter from one non-zero value to another non-zero value, the change is asynchronously applied as soon as possible.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The retention period for automated backups is managed by the DB cluster. For more information, see <code>ModifyDBCluster</code>.</p> <p>Default: Uses existing setting</p> <p>Constraints:</p> <ul> <li> <p>Must be a value from 0 to 35</p> </li> <li> <p>Can be specified for a MySQL Read Replica only if the source is running MySQL 5.6 or later</p> </li> <li> <p>Can be specified for a PostgreSQL Read Replica only if the source is running PostgreSQL 9.3.5</p> </li> <li> <p>Can't be set to 0 if the DB instance is a source to Read Replicas</p> </li> </ul>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p> The daily time range during which automated backups are created if automated backups are enabled, as determined by the <code>BackupRetentionPeriod</code> parameter. Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible. </p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The daily time range for creating automated backups is managed by the DB cluster. For more information, see <code>ModifyDBCluster</code>.</p> <p>Constraints:</p> <ul> <li> <p>Must be in the format hh24:mi-hh24:mi</p> </li> <li> <p>Must be in Universal Time Coordinated (UTC)</p> </li> <li> <p>Must not conflict with the preferred maintenance window</p> </li> <li> <p>Must be at least 30 minutes</p> </li> </ul>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>The weekly time range (in UTC) during which system maintenance can occur, which might result in an outage. Changing this parameter doesn't result in an outage, except in the following situation, and the change is asynchronously applied as soon as possible. If there are pending actions that cause a reboot, and the maintenance window is changed to include the current time, then changing this parameter will cause a reboot of the DB instance. If moving this window to the current time, there must be at least 30 minutes between the current time and end of the window to ensure pending changes are applied.</p> <p>Default: Uses existing setting</p> <p>Format: ddd:hh24:mi-ddd:hh24:mi</p> <p>Valid Days: Mon | Tue | Wed | Thu | Fri | Sat | Sun</p> <p>Constraints: Must be at least 30 minutes</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is a Multi-AZ deployment. Changing this parameter doesn't result in an outage and the change is applied during the next maintenance window unless the <code>ApplyImmediately</code> parameter is enabled for this request. </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p> The version number of the database engine to upgrade to. Changing this parameter results in an outage and the change is applied during the next maintenance window unless the <code>ApplyImmediately</code> parameter is eanbled for this request. </p> <p>For major version upgrades, if a nondefault DB parameter group is currently in use, a new DB parameter group in the DB parameter group family for the new engine version must be specified. The new DB parameter group can be the default for that DB parameter group family.</p> <p>For information about valid engine versions, see <code>CreateDBInstance</code>, or call <code>DescribeDBEngineVersions</code>.</p>"];
      allow_major_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether major version upgrades are allowed. Changing this parameter doesn't result in an outage and the change is asynchronously applied as soon as possible.</p> <p>Constraints: Major version upgrades must be allowed when specifying a value for the EngineVersion parameter that is a different major version than the DB instance's current version.</p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p> A value that indicates whether minor version upgrades are applied automatically to the DB instance during the maintenance window. Changing this parameter doesn't result in an outage except in the following case and the change is asynchronously applied as soon as possible. An outage results if this parameter is enabled during the maintenance window, and a newer minor version is available, and RDS has enabled auto patching for that engine version. </p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>The license model for the DB instance.</p> <p>Valid values: <code>license-included</code> | <code>bring-your-own-license</code> | <code>general-public-license</code> </p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The new Provisioned IOPS (I/O operations per second) value for the RDS instance. </p> <p>Changing this setting doesn't result in an outage and the change is applied during the next maintenance window unless the <code>ApplyImmediately</code> parameter is enabled for this request. If you are migrating from Provisioned IOPS to standard storage, set this value to 0. The DB instance will require a reboot for the change in storage type to take effect. </p> <p>If you choose to migrate your DB instance from using standard storage to using Provisioned IOPS, or from using Provisioned IOPS to using standard storage, the process can take time. The duration of the migration depends on several factors such as database load, storage size, storage type (standard or Provisioned IOPS), amount of IOPS provisioned (if any), and the number of prior scale storage operations. Typical migration times are under 24 hours, but the process can take up to several days in some cases. During the migration, the DB instance is available for use, but might experience performance degradation. While the migration takes place, nightly backups for the instance are suspended. No other Amazon RDS operations can take place for the instance, including modifying the instance, rebooting the instance, deleting the instance, creating a Read Replica for the instance, and creating a DB snapshot of the instance. </p> <p>Constraints: For MariaDB, MySQL, Oracle, and PostgreSQL, the value supplied must be at least 10% greater than the current value. Values that are not at least 10% greater than the existing value are rounded up so that they are 10% greater than the current value. </p> <p>Default: Uses existing setting</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p> Indicates that the DB instance should be associated with the specified option group. Changing this parameter doesn't result in an outage except in the following case and the change is applied during the next maintenance window unless the <code>ApplyImmediately</code> parameter is enabled for this request. If the parameter change results in an option group that enables OEM, this change can cause a brief (sub-second) period during which new connections are rejected but existing connections are not interrupted. </p> <p>Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group, and that option group can't be removed from a DB instance once it is associated with a DB instance</p>"];
      new_d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p> The new DB instance identifier for the DB instance when renaming a DB instance. When you change the DB instance identifier, an instance reboot occurs immediately if you enable <code>ApplyImmediately</code>, or will occur during the next maintenance window if you disable Apply Immediately. This value is stored as a lowercase string. </p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>The first character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>mydbinstance</code> </p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type to be associated with the DB instance. </p> <p>If you specify Provisioned IOPS (<code>io1</code>), you must also include a value for the <code>Iops</code> parameter. </p> <p>If you choose to migrate your DB instance from using standard storage to using Provisioned IOPS, or from using Provisioned IOPS to using standard storage, the process can take time. The duration of the migration depends on several factors such as database load, storage size, storage type (standard or Provisioned IOPS), amount of IOPS provisioned (if any), and the number of prior scale storage operations. Typical migration times are under 24 hours, but the process can take up to several days in some cases. During the migration, the DB instance is available for use, but might experience performance degradation. While the migration takes place, nightly backups for the instance are suspended. No other Amazon RDS operations can take place for the instance, including modifying the instance, rebooting the instance, deleting the instance, creating a Read Replica for the instance, and creating a DB snapshot of the instance. </p> <p> Valid values: <code>standard | gp2 | io1</code> </p> <p>Default: <code>io1</code> if the <code>Iops</code> parameter is specified, otherwise <code>gp2</code> </p>"];
      tde_credential_arn: String.t option
        [@ocaml.doc
          "<p>The ARN from the key store with which to associate the instance for TDE encryption.</p>"];
      tde_credential_password: String.t option
        [@ocaml.doc
          "<p>The password for the given ARN from the key store in order to access the device.</p>"];
      c_a_certificate_identifier: String.t option
        [@ocaml.doc
          "<p>Indicates the certificate that needs to be associated with the instance.</p>"];
      domain: String.t option
        [@ocaml.doc
          "<p>The Active Directory directory ID to move the DB instance to. Specify <code>none</code> to remove the instance from its current domain. The domain must be created prior to this operation. Currently, only Microsoft SQL Server and Oracle DB instances can be created in an Active Directory Domain. </p> <p>For Microsoft SQL Server DB instances, Amazon RDS can use Windows Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_SQLServerWinAuth.html\"> Using Windows Authentication with an Amazon RDS DB Instance Running Microsoft SQL Server</a> in the <i>Amazon RDS User Guide</i>.</p> <p>For Oracle DB instances, Amazon RDS can use Kerberos Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-kerberos.html\"> Using Kerberos Authentication with Amazon RDS for Oracle</a> in the <i>Amazon RDS User Guide</i>.</p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the DB instance to snapshots of the DB instance. By default, tags are not copied.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. Copying tags to snapshots is managed by the DB cluster. Setting this value for an Aurora DB instance has no effect on the DB cluster setting. For more information, see <code>ModifyDBCluster</code>.</p>"];
      monitoring_interval: Integer.t option
        [@ocaml.doc
          "<p>The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0.</p> <p>If <code>MonitoringRoleArn</code> is specified, then you must also set <code>MonitoringInterval</code> to a value other than 0.</p> <p>Valid Values: <code>0, 1, 5, 10, 15, 30, 60</code> </p>"];
      d_b_port_number: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the database accepts connections.</p> <p>The value of the <code>DBPortNumber</code> parameter must not match any of the port values specified for options in the option group for the DB instance.</p> <p>Your database will restart when you change the <code>DBPortNumber</code> value regardless of the value of the <code>ApplyImmediately</code> parameter.</p> <p> <b>MySQL</b> </p> <p> Default: <code>3306</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p> <b>MariaDB</b> </p> <p> Default: <code>3306</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p> <b>PostgreSQL</b> </p> <p> Default: <code>5432</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p>Type: Integer</p> <p> <b>Oracle</b> </p> <p> Default: <code>1521</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p> <b>SQL Server</b> </p> <p> Default: <code>1433</code> </p> <p> Valid Values: <code>1150-65535</code> except for <code>1434</code>, <code>3389</code>, <code>47001</code>, <code>49152</code>, and <code>49152</code> through <code>49156</code>. </p> <p> <b>Amazon Aurora</b> </p> <p> Default: <code>3306</code> </p> <p> Valid Values: <code>1150-65535</code> </p>"];
      publicly_accessible: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is publicly accessible. When the DB instance is publicly accessible, it is an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. When the DB instance isn't publicly accessible, it is an internal instance with a DNS name that resolves to a private IP address. </p> <p> <code>PubliclyAccessible</code> only applies to DB instances in a VPC. The DB instance must be part of a public subnet and <code>PubliclyAccessible</code> must be enabled for it to be publicly accessible. </p> <p>Changes to the <code>PubliclyAccessible</code> parameter are applied immediately regardless of the value of the <code>ApplyImmediately</code> parameter.</p>"];
      monitoring_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, <code>arn:aws:iam:123456789012:role/emaccess</code>. For information on creating a monitoring role, go to <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.html#USER_Monitoring.OS.IAMRole\">To create an IAM role for Amazon RDS Enhanced Monitoring</a> in the <i>Amazon RDS User Guide.</i> </p> <p>If <code>MonitoringInterval</code> is set to a value other than 0, then you must supply a <code>MonitoringRoleArn</code> value.</p>"];
      domain_i_a_m_role_name: String.t option
        [@ocaml.doc
          "<p>The name of the IAM role to use when making API calls to the Directory Service.</p>"];
      promotion_tier: Integer.t option
        [@ocaml.doc
          "<p>A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance\"> Fault Tolerance for an Aurora DB Cluster</a> in the <i>Amazon Aurora User Guide</i>. </p> <p>Default: 1</p> <p>Valid Values: 0 - 15</p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled. For information about the supported DB engines, see <a>CreateDBInstance</a>.</p> <p>For more information about IAM database authentication, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication for MySQL and PostgreSQL</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      enable_performance_insights: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable Performance Insights for the DB instance.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html\">Using Amazon Performance Insights</a> in the <i>Amazon Relational Database Service User Guide</i>. </p>"];
      performance_insights_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key.</p> <p>If you do not specify a value for <code>PerformanceInsightsKMSKeyId</code>, then Amazon RDS uses your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p>"];
      performance_insights_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). </p>"];
      cloudwatch_logs_export_configuration:
        CloudwatchLogsExportConfiguration.t option
        [@ocaml.doc
          "<p>The configuration setting for the log types to be enabled for export to CloudWatch Logs for a specific DB instance.</p> <p>A change to the <code>CloudwatchLogsExportConfiguration</code> parameter is always applied to the DB instance immediately. Therefore, the <code>ApplyImmediately</code> parameter has no effect.</p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"];
      use_default_processor_features: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance class of the DB instance uses its default processor features.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html\"> Deleting a DB Instance</a>. </p>"];
      max_allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>The upper limit to which Amazon RDS can automatically scale the storage of the DB instance.</p>"];
      certificate_rotation_restart: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is restarted when you rotate your SSL/TLS certificate.</p> <p>By default, the DB instance is restarted when you rotate your SSL/TLS certificate. The certificate is not updated until the DB instance is restarted.</p> <important> <p>Set this parameter only if you are <i>not</i> using SSL/TLS to connect to the DB instance.</p> </important> <p>If you are using SSL/TLS to connect to the DB instance, follow the appropriate instructions for your DB engine to rotate your SSL/TLS certificate:</p> <ul> <li> <p>For more information about rotating your SSL/TLS certificate for RDS DB engines, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL-certificate-rotation.html\"> Rotating Your SSL/TLS Certificate.</a> in the <i>Amazon RDS User Guide.</i> </p> </li> <li> <p>For more information about rotating your SSL/TLS certificate for Aurora DB engines, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL-certificate-rotation.html\"> Rotating Your SSL/TLS Certificate</a> in the <i>Amazon Aurora User Guide.</i> </p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_instance_identifier  ?allocated_storage 
      ?d_b_instance_class  ?d_b_subnet_group_name  ?(d_b_security_groups= [])
       ?(vpc_security_group_ids= [])  ?apply_immediately 
      ?master_user_password  ?d_b_parameter_group_name 
      ?backup_retention_period  ?preferred_backup_window 
      ?preferred_maintenance_window  ?multi_a_z  ?engine_version 
      ?allow_major_version_upgrade  ?auto_minor_version_upgrade 
      ?license_model  ?iops  ?option_group_name  ?new_d_b_instance_identifier
       ?storage_type  ?tde_credential_arn  ?tde_credential_password 
      ?c_a_certificate_identifier  ?domain  ?copy_tags_to_snapshot 
      ?monitoring_interval  ?d_b_port_number  ?publicly_accessible 
      ?monitoring_role_arn  ?domain_i_a_m_role_name  ?promotion_tier 
      ?enable_i_a_m_database_authentication  ?enable_performance_insights 
      ?performance_insights_k_m_s_key_id 
      ?performance_insights_retention_period 
      ?cloudwatch_logs_export_configuration  ?(processor_features= []) 
      ?use_default_processor_features  ?deletion_protection 
      ?max_allocated_storage  ?certificate_rotation_restart  () =
      {
        d_b_instance_identifier;
        allocated_storage;
        d_b_instance_class;
        d_b_subnet_group_name;
        d_b_security_groups;
        vpc_security_group_ids;
        apply_immediately;
        master_user_password;
        d_b_parameter_group_name;
        backup_retention_period;
        preferred_backup_window;
        preferred_maintenance_window;
        multi_a_z;
        engine_version;
        allow_major_version_upgrade;
        auto_minor_version_upgrade;
        license_model;
        iops;
        option_group_name;
        new_d_b_instance_identifier;
        storage_type;
        tde_credential_arn;
        tde_credential_password;
        c_a_certificate_identifier;
        domain;
        copy_tags_to_snapshot;
        monitoring_interval;
        d_b_port_number;
        publicly_accessible;
        monitoring_role_arn;
        domain_i_a_m_role_name;
        promotion_tier;
        enable_i_a_m_database_authentication;
        enable_performance_insights;
        performance_insights_k_m_s_key_id;
        performance_insights_retention_period;
        cloudwatch_logs_export_configuration;
        processor_features;
        use_default_processor_features;
        deletion_protection;
        max_allocated_storage;
        certificate_rotation_restart
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.certificate_rotation_restart
              (fun f -> ("certificate_rotation_restart", (Boolean.to_json f)));
           Util.option_map v.max_allocated_storage
             (fun f -> ("max_allocated_storage", (Integer.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.use_default_processor_features
             (fun f ->
                ("use_default_processor_features", (Boolean.to_json f)));
           Some
             ("processor_features",
               (ProcessorFeatureList.to_json v.processor_features));
           Util.option_map v.cloudwatch_logs_export_configuration
             (fun f ->
                ("cloudwatch_logs_export_configuration",
                  (CloudwatchLogsExportConfiguration.to_json f)));
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
           Util.option_map v.promotion_tier
             (fun f -> ("promotion_tier", (Integer.to_json f)));
           Util.option_map v.domain_i_a_m_role_name
             (fun f -> ("domain_i_a_m_role_name", (String.to_json f)));
           Util.option_map v.monitoring_role_arn
             (fun f -> ("monitoring_role_arn", (String.to_json f)));
           Util.option_map v.publicly_accessible
             (fun f -> ("publicly_accessible", (Boolean.to_json f)));
           Util.option_map v.d_b_port_number
             (fun f -> ("d_b_port_number", (Integer.to_json f)));
           Util.option_map v.monitoring_interval
             (fun f -> ("monitoring_interval", (Integer.to_json f)));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.domain (fun f -> ("domain", (String.to_json f)));
           Util.option_map v.c_a_certificate_identifier
             (fun f -> ("c_a_certificate_identifier", (String.to_json f)));
           Util.option_map v.tde_credential_password
             (fun f -> ("tde_credential_password", (String.to_json f)));
           Util.option_map v.tde_credential_arn
             (fun f -> ("tde_credential_arn", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Util.option_map v.new_d_b_instance_identifier
             (fun f -> ("new_d_b_instance_identifier", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.allow_major_version_upgrade
             (fun f -> ("allow_major_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
           Util.option_map v.d_b_parameter_group_name
             (fun f -> ("d_b_parameter_group_name", (String.to_json f)));
           Util.option_map v.master_user_password
             (fun f -> ("master_user_password", (String.to_json f)));
           Util.option_map v.apply_immediately
             (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Some
             ("d_b_security_groups",
               (DBSecurityGroupNameList.to_json v.d_b_security_groups));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
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
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          d_b_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSecurityGroups" xml)
                  DBSecurityGroupNameList.parse));
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse);
          master_user_password =
            (Util.option_bind (Xml.member "MasterUserPassword" xml)
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
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          allow_major_version_upgrade =
            (Util.option_bind (Xml.member "AllowMajorVersionUpgrade" xml)
               Boolean.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          new_d_b_instance_identifier =
            (Util.option_bind (Xml.member "NewDBInstanceIdentifier" xml)
               String.parse);
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          tde_credential_arn =
            (Util.option_bind (Xml.member "TdeCredentialArn" xml)
               String.parse);
          tde_credential_password =
            (Util.option_bind (Xml.member "TdeCredentialPassword" xml)
               String.parse);
          c_a_certificate_identifier =
            (Util.option_bind (Xml.member "CACertificateIdentifier" xml)
               String.parse);
          domain = (Util.option_bind (Xml.member "Domain" xml) String.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          monitoring_interval =
            (Util.option_bind (Xml.member "MonitoringInterval" xml)
               Integer.parse);
          d_b_port_number =
            (Util.option_bind (Xml.member "DBPortNumber" xml) Integer.parse);
          publicly_accessible =
            (Util.option_bind (Xml.member "PubliclyAccessible" xml)
               Boolean.parse);
          monitoring_role_arn =
            (Util.option_bind (Xml.member "MonitoringRoleArn" xml)
               String.parse);
          domain_i_a_m_role_name =
            (Util.option_bind (Xml.member "DomainIAMRoleName" xml)
               String.parse);
          promotion_tier =
            (Util.option_bind (Xml.member "PromotionTier" xml) Integer.parse);
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
          cloudwatch_logs_export_configuration =
            (Util.option_bind
               (Xml.member "CloudwatchLogsExportConfiguration" xml)
               CloudwatchLogsExportConfiguration.parse);
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
          max_allocated_storage =
            (Util.option_bind (Xml.member "MaxAllocatedStorage" xml)
               Integer.parse);
          certificate_rotation_restart =
            (Util.option_bind (Xml.member "CertificateRotationRestart" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((((((((((((((([] @
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
                                                  [Util.option_map
                                                     v.d_b_instance_class
                                                     (fun f ->
                                                        Ezxmlm.make_tag
                                                          "DBInstanceClass"
                                                          ([],
                                                            (String.to_xml f)))])
                                                 @
                                                 [Util.option_map
                                                    v.d_b_subnet_group_name
                                                    (fun f ->
                                                       Ezxmlm.make_tag
                                                         "DBSubnetGroupName"
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
                                                 v.apply_immediately
                                                 (fun f ->
                                                    Ezxmlm.make_tag
                                                      "ApplyImmediately"
                                                      ([],
                                                        (Boolean.to_xml f)))])
                                             @
                                             [Util.option_map
                                                v.master_user_password
                                                (fun f ->
                                                   Ezxmlm.make_tag
                                                     "MasterUserPassword"
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
                                         [Util.option_map
                                            v.preferred_maintenance_window
                                            (fun f ->
                                               Ezxmlm.make_tag
                                                 "PreferredMaintenanceWindow"
                                                 ([], (String.to_xml f)))])
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
                                         v.allow_major_version_upgrade
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "AllowMajorVersionUpgrade"
                                              ([], (Boolean.to_xml f)))])
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
                                 [Util.option_map
                                    v.new_d_b_instance_identifier
                                    (fun f ->
                                       Ezxmlm.make_tag
                                         "NewDBInstanceIdentifier"
                                         ([], (String.to_xml f)))])
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
                             [Util.option_map v.c_a_certificate_identifier
                                (fun f ->
                                   Ezxmlm.make_tag "CACertificateIdentifier"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.domain
                               (fun f ->
                                  Ezxmlm.make_tag "Domain"
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
                         [Util.option_map v.d_b_port_number
                            (fun f ->
                               Ezxmlm.make_tag "DBPortNumber"
                                 ([], (Integer.to_xml f)))])
                        @
                        [Util.option_map v.publicly_accessible
                           (fun f ->
                              Ezxmlm.make_tag "PubliclyAccessible"
                                ([], (Boolean.to_xml f)))])
                       @
                       [Util.option_map v.monitoring_role_arn
                          (fun f ->
                             Ezxmlm.make_tag "MonitoringRoleArn"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.domain_i_a_m_role_name
                         (fun f ->
                            Ezxmlm.make_tag "DomainIAMRoleName"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.promotion_tier
                        (fun f ->
                           Ezxmlm.make_tag "PromotionTier"
                             ([], (Integer.to_xml f)))])
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
                [Util.option_map v.cloudwatch_logs_export_configuration
                   (fun f ->
                      Ezxmlm.make_tag "CloudwatchLogsExportConfiguration"
                        ([], (CloudwatchLogsExportConfiguration.to_xml f)))])
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
            [Util.option_map v.max_allocated_storage
               (fun f ->
                  Ezxmlm.make_tag "MaxAllocatedStorage"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.certificate_rotation_restart
              (fun f ->
                 Ezxmlm.make_tag "CertificateRotationRestart"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module ModifyDBInstanceResult = ModifyDBInstanceResult
type input = ModifyDBInstanceMessage.t
type output = ModifyDBInstanceResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyDBInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBInstanceMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyDBInstanceMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyDBInstanceResponse" (snd xml))
        (Xml.member "ModifyDBInstanceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyDBInstanceResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyDBInstanceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBInstanceResult - missing field in body or children: "
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