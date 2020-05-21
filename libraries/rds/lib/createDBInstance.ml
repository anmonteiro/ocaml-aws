open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBInstanceMessage =
  struct
    type t =
      {
      d_b_name: String.t option
        [@ocaml.doc
          "<p>The meaning of this parameter differs according to the database engine you use.</p> <p> <b>MySQL</b> </p> <p>The name of the database to create when the DB instance is created. If this parameter isn't specified, no database is created in the DB instance.</p> <p>Constraints:</p> <ul> <li> <p>Must contain 1 to 64 letters or numbers.</p> </li> <li> <p>Can't be a word reserved by the specified database engine</p> </li> </ul> <p> <b>MariaDB</b> </p> <p>The name of the database to create when the DB instance is created. If this parameter isn't specified, no database is created in the DB instance.</p> <p>Constraints:</p> <ul> <li> <p>Must contain 1 to 64 letters or numbers.</p> </li> <li> <p>Can't be a word reserved by the specified database engine</p> </li> </ul> <p> <b>PostgreSQL</b> </p> <p>The name of the database to create when the DB instance is created. If this parameter isn't specified, the default \"postgres\" database is created in the DB instance.</p> <p>Constraints:</p> <ul> <li> <p>Must contain 1 to 63 letters, numbers, or underscores.</p> </li> <li> <p>Must begin with a letter or an underscore. Subsequent characters can be letters, underscores, or digits (0-9).</p> </li> <li> <p>Can't be a word reserved by the specified database engine</p> </li> </ul> <p> <b>Oracle</b> </p> <p>The Oracle System ID (SID) of the created DB instance. If you specify <code>null</code>, the default value <code>ORCL</code> is used. You can't specify the string NULL, or any other reserved word, for <code>DBName</code>. </p> <p>Default: <code>ORCL</code> </p> <p>Constraints:</p> <ul> <li> <p>Can't be longer than 8 characters</p> </li> </ul> <p> <b>SQL Server</b> </p> <p>Not applicable. Must be null.</p> <p> <b>Amazon Aurora</b> </p> <p>The name of the database to create when the primary instance of the DB cluster is created. If this parameter isn't specified, no database is created in the DB instance.</p> <p>Constraints:</p> <ul> <li> <p>Must contain 1 to 64 letters or numbers.</p> </li> <li> <p>Can't be a word reserved by the specified database engine</p> </li> </ul>"];
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>mydbinstance</code> </p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>The amount of storage (in gibibytes) to allocate for the DB instance.</p> <p>Type: Integer</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. Aurora cluster volumes automatically grow as the amount of data in your database increases, though you are only charged for the space that you use in an Aurora cluster volume.</p> <p> <b>MySQL</b> </p> <p>Constraints to the amount of storage for each storage type are the following: </p> <ul> <li> <p>General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.</p> </li> <li> <p>Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.</p> </li> <li> <p>Magnetic storage (standard): Must be an integer from 5 to 3072.</p> </li> </ul> <p> <b>MariaDB</b> </p> <p>Constraints to the amount of storage for each storage type are the following: </p> <ul> <li> <p>General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.</p> </li> <li> <p>Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.</p> </li> <li> <p>Magnetic storage (standard): Must be an integer from 5 to 3072.</p> </li> </ul> <p> <b>PostgreSQL</b> </p> <p>Constraints to the amount of storage for each storage type are the following: </p> <ul> <li> <p>General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.</p> </li> <li> <p>Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.</p> </li> <li> <p>Magnetic storage (standard): Must be an integer from 5 to 3072.</p> </li> </ul> <p> <b>Oracle</b> </p> <p>Constraints to the amount of storage for each storage type are the following: </p> <ul> <li> <p>General Purpose (SSD) storage (gp2): Must be an integer from 20 to 65536.</p> </li> <li> <p>Provisioned IOPS storage (io1): Must be an integer from 100 to 65536.</p> </li> <li> <p>Magnetic storage (standard): Must be an integer from 10 to 3072.</p> </li> </ul> <p> <b>SQL Server</b> </p> <p>Constraints to the amount of storage for each storage type are the following: </p> <ul> <li> <p>General Purpose (SSD) storage (gp2):</p> <ul> <li> <p>Enterprise and Standard editions: Must be an integer from 200 to 16384.</p> </li> <li> <p>Web and Express editions: Must be an integer from 20 to 16384.</p> </li> </ul> </li> <li> <p>Provisioned IOPS storage (io1):</p> <ul> <li> <p>Enterprise and Standard editions: Must be an integer from 200 to 16384.</p> </li> <li> <p>Web and Express editions: Must be an integer from 100 to 16384.</p> </li> </ul> </li> <li> <p>Magnetic storage (standard):</p> <ul> <li> <p>Enterprise and Standard editions: Must be an integer from 200 to 1024.</p> </li> <li> <p>Web and Express editions: Must be an integer from 20 to 1024.</p> </li> </ul> </li> </ul>"];
      d_b_instance_class: String.t
        [@ocaml.doc
          "<p>The compute and memory capacity of the DB instance, for example, <code>db.m4.large</code>. Not all DB instance classes are available in all AWS Regions, or for all database engines. For the full list of DB instance classes, and availability for your engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html\">DB Instance Class</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      engine: String.t
        [@ocaml.doc
          "<p>The name of the database engine to be used for this instance. </p> <p>Not every database engine is available for every AWS Region. </p> <p>Valid Values: </p> <ul> <li> <p> <code>aurora</code> (for MySQL 5.6-compatible Aurora)</p> </li> <li> <p> <code>aurora-mysql</code> (for MySQL 5.7-compatible Aurora)</p> </li> <li> <p> <code>aurora-postgresql</code> </p> </li> <li> <p> <code>mariadb</code> </p> </li> <li> <p> <code>mysql</code> </p> </li> <li> <p> <code>oracle-ee</code> </p> </li> <li> <p> <code>oracle-se2</code> </p> </li> <li> <p> <code>oracle-se1</code> </p> </li> <li> <p> <code>oracle-se</code> </p> </li> <li> <p> <code>postgres</code> </p> </li> <li> <p> <code>sqlserver-ee</code> </p> </li> <li> <p> <code>sqlserver-se</code> </p> </li> <li> <p> <code>sqlserver-ex</code> </p> </li> <li> <p> <code>sqlserver-web</code> </p> </li> </ul>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>The name for the master user.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The name for the master user is managed by the DB cluster. </p> <p> <b>MariaDB</b> </p> <p>Constraints:</p> <ul> <li> <p>Required for MariaDB.</p> </li> <li> <p>Must be 1 to 16 letters or numbers.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul> <p> <b>Microsoft SQL Server</b> </p> <p>Constraints:</p> <ul> <li> <p>Required for SQL Server.</p> </li> <li> <p>Must be 1 to 128 letters or numbers.</p> </li> <li> <p>The first character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul> <p> <b>MySQL</b> </p> <p>Constraints:</p> <ul> <li> <p>Required for MySQL.</p> </li> <li> <p>Must be 1 to 16 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul> <p> <b>Oracle</b> </p> <p>Constraints:</p> <ul> <li> <p>Required for Oracle.</p> </li> <li> <p>Must be 1 to 30 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul> <p> <b>PostgreSQL</b> </p> <p>Constraints:</p> <ul> <li> <p>Required for PostgreSQL.</p> </li> <li> <p>Must be 1 to 63 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't be a reserved word for the chosen database engine.</p> </li> </ul>"];
      master_user_password: String.t option
        [@ocaml.doc
          "<p>The password for the master user. The password can include any printable ASCII character except \"/\", \"\"\", or \"@\".</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The password for the master user is managed by the DB cluster.</p> <p> <b>MariaDB</b> </p> <p>Constraints: Must contain from 8 to 41 characters.</p> <p> <b>Microsoft SQL Server</b> </p> <p>Constraints: Must contain from 8 to 128 characters.</p> <p> <b>MySQL</b> </p> <p>Constraints: Must contain from 8 to 41 characters.</p> <p> <b>Oracle</b> </p> <p>Constraints: Must contain from 8 to 30 characters.</p> <p> <b>PostgreSQL</b> </p> <p>Constraints: Must contain from 8 to 128 characters.</p>"];
      d_b_security_groups: DBSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of DB security groups to associate with this DB instance.</p> <p>Default: The default DB security group for the database engine.</p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of Amazon EC2 VPC security groups to associate with this DB instance.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The associated list of EC2 VPC security groups is managed by the DB cluster.</p> <p>Default: The default EC2 VPC security group for the DB subnet group's VPC.</p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p> The Availability Zone (AZ) where the database will be created. For information on AWS Regions and Availability Zones, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html\">Regions and Availability Zones</a>. </p> <p>Default: A random, system-chosen Availability Zone in the endpoint's AWS Region.</p> <p> Example: <code>us-east-1d</code> </p> <p> Constraint: The <code>AvailabilityZone</code> parameter can't be specified if the DB instance is a Multi-AZ deployment. The specified Availability Zone must be in the same AWS Region as the current endpoint. </p> <note> <p>If you're creating a DB instance in an RDS on VMware environment, specify the identifier of the custom Availability Zone to create the DB instance in.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p> </note>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>A DB subnet group to associate with this DB instance.</p> <p>If there is no DB subnet group, then it is a non-VPC DB instance.</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>The time range each week during which system maintenance can occur, in Universal Coordinated Time (UTC). For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#Concepts.DBMaintenance\">Amazon RDS Maintenance Window</a>. </p> <p> Format: <code>ddd:hh24:mi-ddd:hh24:mi</code> </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. </p> <p>Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.</p> <p>Constraints: Minimum 30-minute window.</p>"];
      d_b_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group to associate with this DB instance. If you do not specify a value, then the default DB parameter group for the specified DB engine and version is used.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The retention period for automated backups is managed by the DB cluster.</p> <p>Default: 1</p> <p>Constraints:</p> <ul> <li> <p>Must be a value from 0 to 35</p> </li> <li> <p>Can't be set to 0 if the DB instance is a source to Read Replicas</p> </li> </ul>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p> The daily time range during which automated backups are created if automated backups are enabled, using the <code>BackupRetentionPeriod</code> parameter. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html#USER_WorkingWithAutomatedBackups.BackupWindow\">The Backup Window</a> in the <i>Amazon RDS User Guide</i>. </p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The daily time range for creating automated backups is managed by the DB cluster.</p> <p> The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow\"> Adjusting the Preferred DB Instance Maintenance Window</a> in the <i>Amazon RDS User Guide</i>. </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>hh24:mi-hh24:mi</code>.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred maintenance window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the database accepts connections.</p> <p> <b>MySQL</b> </p> <p> Default: <code>3306</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p>Type: Integer</p> <p> <b>MariaDB</b> </p> <p> Default: <code>3306</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p>Type: Integer</p> <p> <b>PostgreSQL</b> </p> <p> Default: <code>5432</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p>Type: Integer</p> <p> <b>Oracle</b> </p> <p> Default: <code>1521</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p> <b>SQL Server</b> </p> <p> Default: <code>1433</code> </p> <p> Valid Values: <code>1150-65535</code> except for <code>1434</code>, <code>3389</code>, <code>47001</code>, <code>49152</code>, and <code>49152</code> through <code>49156</code>. </p> <p> <b>Amazon Aurora</b> </p> <p> Default: <code>3306</code> </p> <p> Valid Values: <code>1150-65535</code> </p> <p>Type: Integer</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is a Multi-AZ deployment. You can't set the <code>AvailabilityZone</code> parameter if the DB instance is a Multi-AZ deployment.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the database engine to use.</p> <p>For a list of valid engine versions, use the <code>DescribeDBEngineVersions</code> action.</p> <p>The following are the database engines and links to information about the major and minor versions that are available with Amazon RDS. Not every database engine is available for every AWS Region.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The version number of the database engine to be used by the DB instance is managed by the DB cluster.</p> <p> <b>MariaDB</b> </p> <p>See <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MariaDB.html#MariaDB.Concepts.VersionMgmt\">MariaDB on Amazon RDS Versions</a> in the <i>Amazon RDS User Guide.</i> </p> <p> <b>Microsoft SQL Server</b> </p> <p>See <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.FeatureSupport\">Version and Feature Support on Amazon RDS</a> in the <i>Amazon RDS User Guide.</i> </p> <p> <b>MySQL</b> </p> <p>See <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt\">MySQL on Amazon RDS Versions</a> in the <i>Amazon RDS User Guide.</i> </p> <p> <b>Oracle</b> </p> <p>See <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Appendix.Oracle.PatchComposition.html\">Oracle Database Engine Release Notes</a> in the <i>Amazon RDS User Guide.</i> </p> <p> <b>PostgreSQL</b> </p> <p>See <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts.General.DBVersions\">Supported PostgreSQL Database Versions</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether minor engine upgrades are applied automatically to the DB instance during the maintenance window. By default, minor engine upgrades are applied automatically.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>License model information for this DB instance.</p> <p> Valid values: <code>license-included</code> | <code>bring-your-own-license</code> | <code>general-public-license</code> </p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for the DB instance. For information about valid Iops values, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Storage.html#USER_PIOPS\">Amazon RDS Provisioned IOPS Storage to Improve Performance</a> in the <i>Amazon RDS User Guide</i>. </p> <p>Constraints: For MariaDB, MySQL, Oracle, and PostgreSQL DB instances, must be a multiple between .5 and 50 of the storage amount for the DB instance. For SQL Server DB instances, must be a multiple between 1 and 50 of the storage amount for the DB instance. </p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>Indicates that the DB instance should be associated with the specified option group.</p> <p>Permanent options, such as the TDE option for Oracle Advanced Security TDE, can't be removed from an option group, and that option group can't be removed from a DB instance once it is associated with a DB instance</p>"];
      character_set_name: String.t option
        [@ocaml.doc
          "<p>For supported engines, indicates that the DB instance should be associated with the specified CharacterSet.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The character set is managed by the DB cluster. For more information, see <code>CreateDBCluster</code>.</p>"];
      publicly_accessible: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is publicly accessible. When the DB instance is publicly accessible, it is an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. When the DB instance isn't publicly accessible, it is an internal instance with a DNS name that resolves to a private IP address.</p> <p>Default: The default behavior varies depending on whether <code>DBSubnetGroupName</code> is specified.</p> <p>If <code>DBSubnetGroupName</code> isn't specified, and <code>PubliclyAccessible</code> isn't specified, the following applies:</p> <ul> <li> <p>If the default VPC in the target region doesn\226\128\153t have an Internet gateway attached to it, the DB instance is private.</p> </li> <li> <p>If the default VPC in the target region has an Internet gateway attached to it, the DB instance is public.</p> </li> </ul> <p>If <code>DBSubnetGroupName</code> is specified, and <code>PubliclyAccessible</code> isn't specified, the following applies:</p> <ul> <li> <p>If the subnets are part of a VPC that doesn\226\128\153t have an Internet gateway attached to it, the DB instance is private.</p> </li> <li> <p>If the subnets are part of a VPC that has an Internet gateway attached to it, the DB instance is public.</p> </li> </ul>"];
      tags: TagList.t
        [@ocaml.doc "<p>Tags to assign to the DB instance.</p>"];
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the DB cluster that the instance will belong to.</p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type to be associated with the DB instance.</p> <p> Valid values: <code>standard | gp2 | io1</code> </p> <p> If you specify <code>io1</code>, you must also include a value for the <code>Iops</code> parameter. </p> <p> Default: <code>io1</code> if the <code>Iops</code> parameter is specified, otherwise <code>gp2</code> </p>"];
      tde_credential_arn: String.t option
        [@ocaml.doc
          "<p>The ARN from the key store with which to associate the instance for TDE encryption.</p>"];
      tde_credential_password: String.t option
        [@ocaml.doc
          "<p>The password for the given ARN from the key store in order to access the device.</p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance is encrypted. By default, it isn't encrypted.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The encryption for DB instances is managed by the DB cluster.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for an encrypted DB instance.</p> <p>The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are creating a DB instance with the same AWS account that owns the KMS encryption key used to encrypt the new DB instance, then you can use the KMS key alias instead of the ARN for the KM encryption key.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. The KMS key identifier is managed by the DB cluster. For more information, see <code>CreateDBCluster</code>.</p> <p>If <code>StorageEncrypted</code> is enabled, and you do not specify a value for the <code>KmsKeyId</code> parameter, then Amazon RDS will use your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p>"];
      domain: String.t option
        [@ocaml.doc
          "<p>The Active Directory directory ID to create the DB instance in. Currently, only Microsoft SQL Server and Oracle DB instances can be created in an Active Directory Domain.</p> <p>For Microsoft SQL Server DB instances, Amazon RDS can use Windows Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_SQLServerWinAuth.html\"> Using Windows Authentication with an Amazon RDS DB Instance Running Microsoft SQL Server</a> in the <i>Amazon RDS User Guide</i>.</p> <p>For Oracle DB instance, Amazon RDS can use Kerberos Authentication to authenticate users that connect to the DB instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/oracle-kerberos.html\"> Using Kerberos Authentication with Amazon RDS for Oracle</a> in the <i>Amazon RDS User Guide</i>.</p> <p/>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy tags from the DB instance to snapshots of the DB instance. By default, tags are not copied.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. Copying tags to snapshots is managed by the DB cluster. Setting this value for an Aurora DB instance has no effect on the DB cluster setting.</p>"];
      monitoring_interval: Integer.t option
        [@ocaml.doc
          "<p>The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0.</p> <p>If <code>MonitoringRoleArn</code> is specified, then you must also set <code>MonitoringInterval</code> to a value other than 0.</p> <p>Valid Values: <code>0, 1, 5, 10, 15, 30, 60</code> </p>"];
      monitoring_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to Amazon CloudWatch Logs. For example, <code>arn:aws:iam:123456789012:role/emaccess</code>. For information on creating a monitoring role, go to <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html#USER_Monitoring.OS.Enabling\">Setting Up and Enabling Enhanced Monitoring</a> in the <i>Amazon RDS User Guide</i>.</p> <p>If <code>MonitoringInterval</code> is set to a value other than 0, then you must supply a <code>MonitoringRoleArn</code> value.</p>"];
      domain_i_a_m_role_name: String.t option
        [@ocaml.doc
          "<p>Specify the name of the IAM role to be used when making API calls to the Directory Service.</p>"];
      promotion_tier: Integer.t option
        [@ocaml.doc
          "<p>A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance\"> Fault Tolerance for an Aurora DB Cluster</a> in the <i>Amazon Aurora User Guide</i>. </p> <p>Default: 1</p> <p>Valid Values: 0 - 15</p>"];
      timezone: String.t option
        [@ocaml.doc
          "<p>The time zone of the DB instance. The time zone parameter is currently supported only by <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_SQLServer.html#SQLServer.Concepts.General.TimeZone\">Microsoft SQL Server</a>. </p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.</p> <p>You can enable IAM database authentication for the following database engines:</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. Mapping AWS IAM accounts to database accounts is managed by the DB cluster.</p> <p> <b>MySQL</b> </p> <ul> <li> <p>For MySQL 5.6, minor version 5.6.34 or higher</p> </li> <li> <p>For MySQL 5.7, minor version 5.7.16 or higher</p> </li> <li> <p>For MySQL 8.0, minor version 8.0.16 or higher</p> </li> </ul> <p> <b>PostgreSQL</b> </p> <ul> <li> <p>For PostgreSQL 9.5, minor version 9.5.15 or higher</p> </li> <li> <p>For PostgreSQL 9.6, minor version 9.6.11 or higher</p> </li> <li> <p>PostgreSQL 10.6, 10.7, and 10.9</p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication for MySQL and PostgreSQL</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      enable_performance_insights: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable Performance Insights for the DB instance. </p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_PerfInsights.html\">Using Amazon Performance Insights</a> in the <i>Amazon Relational Database Service User Guide</i>. </p>"];
      performance_insights_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key.</p> <p>If you do not specify a value for <code>PerformanceInsightsKMSKeyId</code>, then Amazon RDS uses your default encryption key. AWS KMS creates the default encryption key for your AWS account. Your AWS account has a different default encryption key for each AWS Region.</p>"];
      performance_insights_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). </p>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of log types that need to be enabled for exporting to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs </a> in the <i>Amazon Relational Database Service User Guide</i>.</p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html\"> Deleting a DB Instance</a>. </p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. You can enable or disable deletion protection for the DB cluster. For more information, see <code>CreateDBCluster</code>. DB instances in a DB cluster can be deleted even when deletion protection is enabled for the DB cluster. </p>"];
      max_allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>The upper limit to which Amazon RDS can automatically scale the storage of the DB instance.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?d_b_name  ~d_b_instance_identifier  ?allocated_storage 
      ~d_b_instance_class  ~engine  ?master_username  ?master_user_password 
      ?(d_b_security_groups= [])  ?(vpc_security_group_ids= []) 
      ?availability_zone  ?d_b_subnet_group_name 
      ?preferred_maintenance_window  ?d_b_parameter_group_name 
      ?backup_retention_period  ?preferred_backup_window  ?port  ?multi_a_z 
      ?engine_version  ?auto_minor_version_upgrade  ?license_model  ?iops 
      ?option_group_name  ?character_set_name  ?publicly_accessible  ?(tags=
      [])  ?d_b_cluster_identifier  ?storage_type  ?tde_credential_arn 
      ?tde_credential_password  ?storage_encrypted  ?kms_key_id  ?domain 
      ?copy_tags_to_snapshot  ?monitoring_interval  ?monitoring_role_arn 
      ?domain_i_a_m_role_name  ?promotion_tier  ?timezone 
      ?enable_i_a_m_database_authentication  ?enable_performance_insights 
      ?performance_insights_k_m_s_key_id 
      ?performance_insights_retention_period 
      ?(enable_cloudwatch_logs_exports= [])  ?(processor_features= []) 
      ?deletion_protection  ?max_allocated_storage  () =
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
        character_set_name;
        publicly_accessible;
        tags;
        d_b_cluster_identifier;
        storage_type;
        tde_credential_arn;
        tde_credential_password;
        storage_encrypted;
        kms_key_id;
        domain;
        copy_tags_to_snapshot;
        monitoring_interval;
        monitoring_role_arn;
        domain_i_a_m_role_name;
        promotion_tier;
        timezone;
        enable_i_a_m_database_authentication;
        enable_performance_insights;
        performance_insights_k_m_s_key_id;
        performance_insights_retention_period;
        enable_cloudwatch_logs_exports;
        processor_features;
        deletion_protection;
        max_allocated_storage
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_allocated_storage
              (fun f -> ("max_allocated_storage", (Integer.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
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
           Util.option_map v.timezone
             (fun f -> ("timezone", (String.to_json f)));
           Util.option_map v.promotion_tier
             (fun f -> ("promotion_tier", (Integer.to_json f)));
           Util.option_map v.domain_i_a_m_role_name
             (fun f -> ("domain_i_a_m_role_name", (String.to_json f)));
           Util.option_map v.monitoring_role_arn
             (fun f -> ("monitoring_role_arn", (String.to_json f)));
           Util.option_map v.monitoring_interval
             (fun f -> ("monitoring_interval", (Integer.to_json f)));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.domain (fun f -> ("domain", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.tde_credential_password
             (fun f -> ("tde_credential_password", (String.to_json f)));
           Util.option_map v.tde_credential_arn
             (fun f -> ("tde_credential_arn", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.publicly_accessible
             (fun f -> ("publicly_accessible", (Boolean.to_json f)));
           Util.option_map v.character_set_name
             (fun f -> ("character_set_name", (String.to_json f)));
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
          character_set_name =
            (Util.option_bind (Xml.member "CharacterSetName" xml)
               String.parse);
          publicly_accessible =
            (Util.option_bind (Xml.member "PubliclyAccessible" xml)
               Boolean.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          tde_credential_arn =
            (Util.option_bind (Xml.member "TdeCredentialArn" xml)
               String.parse);
          tde_credential_password =
            (Util.option_bind (Xml.member "TdeCredentialPassword" xml)
               String.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          domain = (Util.option_bind (Xml.member "Domain" xml) String.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          monitoring_interval =
            (Util.option_bind (Xml.member "MonitoringInterval" xml)
               Integer.parse);
          monitoring_role_arn =
            (Util.option_bind (Xml.member "MonitoringRoleArn" xml)
               String.parse);
          domain_i_a_m_role_name =
            (Util.option_bind (Xml.member "DomainIAMRoleName" xml)
               String.parse);
          promotion_tier =
            (Util.option_bind (Xml.member "PromotionTier" xml) Integer.parse);
          timezone =
            (Util.option_bind (Xml.member "Timezone" xml) String.parse);
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
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          max_allocated_storage =
            (Util.option_bind (Xml.member "MaxAllocatedStorage" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((((((((((((((((((([] @
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
                                                       (Ezxmlm.make_tag
                                                          "Engine"
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
                                                       ([],
                                                         (String.to_xml f)))])
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
                                  [Util.option_map v.character_set_name
                                     (fun f ->
                                        Ezxmlm.make_tag "CharacterSetName"
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
                                           ([], (TagList.to_xml [x]))))
                                   v.tags))
                               @
                               [Util.option_map v.d_b_cluster_identifier
                                  (fun f ->
                                     Ezxmlm.make_tag "DBClusterIdentifier"
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
                   [Util.option_map v.timezone
                      (fun f ->
                         Ezxmlm.make_tag "Timezone" ([], (String.to_xml f)))])
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
            [Util.option_map v.deletion_protection
               (fun f ->
                  Ezxmlm.make_tag "DeletionProtection"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.max_allocated_storage
              (fun f ->
                 Ezxmlm.make_tag "MaxAllocatedStorage"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module CreateDBInstanceResult = CreateDBInstanceResult
type input = CreateDBInstanceMessage.t
type output = CreateDBInstanceResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateDBInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBInstanceMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateDBInstanceMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateDBInstanceResponse" (snd xml))
        (Xml.member "CreateDBInstanceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateDBInstanceResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateDBInstanceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBInstanceResult - missing field in body or children: "
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