open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The DB cluster identifier for the cluster being modified. This parameter isn't case-sensitive.</p> <p>Constraints: This identifier must match the identifier of an existing DB cluster.</p>"];
      new_d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The new DB cluster identifier for the DB cluster when renaming a DB cluster. This value is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens</p> </li> <li> <p>The first character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-cluster2</code> </p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the modifications in this request and any pending modifications are asynchronously applied as soon as possible, regardless of the <code>PreferredMaintenanceWindow</code> setting for the DB cluster. If this parameter is disabled, changes to the DB cluster are applied during the next maintenance window.</p> <p>The <code>ApplyImmediately</code> parameter only affects the <code>EnableIAMDatabaseAuthentication</code>, <code>MasterUserPassword</code>, and <code>NewDBClusterIdentifier</code> values. If the <code>ApplyImmediately</code> parameter is disabled, then changes to the <code>EnableIAMDatabaseAuthentication</code>, <code>MasterUserPassword</code>, and <code>NewDBClusterIdentifier</code> values are applied during the next maintenance window. All other changes are applied immediately, regardless of the value of the <code>ApplyImmediately</code> parameter.</p> <p>By default, this parameter is disabled.</p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which automated backups are retained. You must specify a minimum value of 1.</p> <p>Default: 1</p> <p>Constraints:</p> <ul> <li> <p>Must be a value from 1 to 35</p> </li> </ul>"];
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB cluster parameter group to use for the DB cluster.</p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of VPC security groups that the DB cluster will belong to.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the DB cluster accepts connections.</p> <p>Constraints: Value must be <code>1150-65535</code> </p> <p>Default: The same port as the original DB cluster.</p>"];
      master_user_password: String.t option
        [@ocaml.doc
          "<p>The new password for the master database user. This password can contain any printable ASCII character except \"/\", \"\"\", or \"@\".</p> <p>Constraints: Must contain from 8 to 41 characters.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>A value that indicates that the DB cluster should be associated with the specified option group. Changing this parameter doesn't result in an outage except in the following case, and the change is applied during the next maintenance window unless the <code>ApplyImmediately</code> is enabled for this request. If the parameter change results in an option group that enables OEM, this change can cause a brief (sub-second) period during which new connections are rejected but existing connections are not interrupted. </p> <p>Permanent options can't be removed from an option group. The option group can't be removed from a DB cluster once it is associated with a DB cluster.</p>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p>The daily time range during which automated backups are created if automated backups are enabled, using the <code>BackupRetentionPeriod</code> parameter. </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora\"> Adjusting the Preferred DB Cluster Maintenance Window</a> in the <i>Amazon Aurora User Guide.</i> </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>hh24:mi-hh24:mi</code>.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred maintenance window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>The weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).</p> <p>Format: <code>ddd:hh24:mi-ddd:hh24:mi</code> </p> <p>The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region, occurring on a random day of the week. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_UpgradeDBInstance.Maintenance.html#AdjustingTheMaintenanceWindow.Aurora\"> Adjusting the Preferred DB Cluster Maintenance Window</a> in the <i>Amazon Aurora User Guide.</i> </p> <p>Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun.</p> <p>Constraints: Minimum 30-minute window.</p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication</a> in the <i>Amazon Aurora User Guide.</i> </p>"];
      backtrack_window: Long.t option
        [@ocaml.doc
          "<p>The target backtrack window, in seconds. To disable backtracking, set this value to 0.</p> <p>Default: 0</p> <p>Constraints:</p> <ul> <li> <p>If specified, this value must be set to a number from 0 to 259,200 (72 hours).</p> </li> </ul>"];
      cloudwatch_logs_export_configuration:
        CloudwatchLogsExportConfiguration.t option
        [@ocaml.doc
          "<p>The configuration setting for the log types to be enabled for export to CloudWatch Logs for a specific DB cluster.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the database engine to which you want to upgrade. Changing this parameter results in an outage. The change is applied during the next maintenance window unless <code>ApplyImmediately</code> is enabled.</p> <p>To list all of the available engine versions for <code>aurora</code> (for MySQL 5.6-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-mysql</code> (for MySQL 5.7-compatible Aurora), use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-mysql --query \"DBEngineVersions[].EngineVersion\"</code> </p> <p>To list all of the available engine versions for <code>aurora-postgresql</code>, use the following command:</p> <p> <code>aws rds describe-db-engine-versions --engine aurora-postgresql --query \"DBEngineVersions[].EngineVersion\"</code> </p>"];
      allow_major_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether major version upgrades are allowed.</p> <p>Constraints: You must allow major version upgrades when specifying a value for the <code>EngineVersion</code> parameter that is a different major version than the DB cluster's current version.</p>"];
      d_b_instance_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group to apply to all instances of the DB cluster. </p> <note> <p>When you apply a parameter group using the <code>DBInstanceParameterGroupName</code> parameter, the DB cluster isn't rebooted automatically. Also, parameter changes aren't applied during the next maintenance window but instead are applied immediately.</p> </note> <p>Default: The existing name setting</p> <p>Constraints:</p> <ul> <li> <p>The DB parameter group must be in the same DB parameter group family as this DB cluster.</p> </li> <li> <p>The <code>DBInstanceParameterGroupName</code> parameter is only valid in combination with the <code>AllowMajorVersionUpgrade</code> parameter.</p> </li> </ul>"];
      scaling_configuration: ScalingConfiguration.t option
        [@ocaml.doc
          "<p>The scaling properties of the DB cluster. You can only modify scaling properties for DB clusters in <code>serverless</code> DB engine mode.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. </p>"];
      enable_http_endpoint: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable the HTTP endpoint for an Aurora Serverless DB cluster. By default, the HTTP endpoint is disabled.</p> <p>When enabled, the HTTP endpoint provides a connectionless web service API for running SQL queries on the Aurora Serverless DB cluster. You can also query your database from inside the RDS console with the query editor.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html\">Using the Data API for Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the DB cluster to snapshots of the DB cluster. The default is not to copy them.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_identifier  ?new_d_b_cluster_identifier 
      ?apply_immediately  ?backup_retention_period 
      ?d_b_cluster_parameter_group_name  ?(vpc_security_group_ids= [])  ?port
       ?master_user_password  ?option_group_name  ?preferred_backup_window 
      ?preferred_maintenance_window  ?enable_i_a_m_database_authentication 
      ?backtrack_window  ?cloudwatch_logs_export_configuration 
      ?engine_version  ?allow_major_version_upgrade 
      ?d_b_instance_parameter_group_name  ?scaling_configuration 
      ?deletion_protection  ?enable_http_endpoint  ?copy_tags_to_snapshot  ()
      =
      {
        d_b_cluster_identifier;
        new_d_b_cluster_identifier;
        apply_immediately;
        backup_retention_period;
        d_b_cluster_parameter_group_name;
        vpc_security_group_ids;
        port;
        master_user_password;
        option_group_name;
        preferred_backup_window;
        preferred_maintenance_window;
        enable_i_a_m_database_authentication;
        backtrack_window;
        cloudwatch_logs_export_configuration;
        engine_version;
        allow_major_version_upgrade;
        d_b_instance_parameter_group_name;
        scaling_configuration;
        deletion_protection;
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
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.scaling_configuration
             (fun f ->
                ("scaling_configuration", (ScalingConfiguration.to_json f)));
           Util.option_map v.d_b_instance_parameter_group_name
             (fun f ->
                ("d_b_instance_parameter_group_name", (String.to_json f)));
           Util.option_map v.allow_major_version_upgrade
             (fun f -> ("allow_major_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.cloudwatch_logs_export_configuration
             (fun f ->
                ("cloudwatch_logs_export_configuration",
                  (CloudwatchLogsExportConfiguration.to_json f)));
           Util.option_map v.backtrack_window
             (fun f -> ("backtrack_window", (Long.to_json f)));
           Util.option_map v.enable_i_a_m_database_authentication
             (fun f ->
                ("enable_i_a_m_database_authentication", (Boolean.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.master_user_password
             (fun f -> ("master_user_password", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Util.option_map v.d_b_cluster_parameter_group_name
             (fun f ->
                ("d_b_cluster_parameter_group_name", (String.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
           Util.option_map v.apply_immediately
             (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Util.option_map v.new_d_b_cluster_identifier
             (fun f -> ("new_d_b_cluster_identifier", (String.to_json f)));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          new_d_b_cluster_identifier =
            (Util.option_bind (Xml.member "NewDBClusterIdentifier" xml)
               String.parse);
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse);
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          d_b_cluster_parameter_group_name =
            (Util.option_bind (Xml.member "DBClusterParameterGroupName" xml)
               String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
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
          enable_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "EnableIAMDatabaseAuthentication" xml)
               Boolean.parse);
          backtrack_window =
            (Util.option_bind (Xml.member "BacktrackWindow" xml) Long.parse);
          cloudwatch_logs_export_configuration =
            (Util.option_bind
               (Xml.member "CloudwatchLogsExportConfiguration" xml)
               CloudwatchLogsExportConfiguration.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          allow_major_version_upgrade =
            (Util.option_bind (Xml.member "AllowMajorVersionUpgrade" xml)
               Boolean.parse);
          d_b_instance_parameter_group_name =
            (Util.option_bind (Xml.member "DBInstanceParameterGroupName" xml)
               String.parse);
          scaling_configuration =
            (Util.option_bind (Xml.member "ScalingConfiguration" xml)
               ScalingConfiguration.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          enable_http_endpoint =
            (Util.option_bind (Xml.member "EnableHttpEndpoint" xml)
               Boolean.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((([] @
                               [Some
                                  (Ezxmlm.make_tag "DBClusterIdentifier"
                                     ([],
                                       (String.to_xml
                                          v.d_b_cluster_identifier)))])
                              @
                              [Util.option_map v.new_d_b_cluster_identifier
                                 (fun f ->
                                    Ezxmlm.make_tag "NewDBClusterIdentifier"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.apply_immediately
                                (fun f ->
                                   Ezxmlm.make_tag "ApplyImmediately"
                                     ([], (Boolean.to_xml f)))])
                            @
                            [Util.option_map v.backup_retention_period
                               (fun f ->
                                  Ezxmlm.make_tag "BackupRetentionPeriod"
                                    ([], (Integer.to_xml f)))])
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
                                  (Ezxmlm.make_tag "VpcSecurityGroupIds"
                                     ([],
                                       (VpcSecurityGroupIdList.to_xml [x]))))
                             v.vpc_security_group_ids))
                         @
                         [Util.option_map v.port
                            (fun f ->
                               Ezxmlm.make_tag "Port"
                                 ([], (Integer.to_xml f)))])
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
                  [Util.option_map v.cloudwatch_logs_export_configuration
                     (fun f ->
                        Ezxmlm.make_tag "CloudwatchLogsExportConfiguration"
                          ([], (CloudwatchLogsExportConfiguration.to_xml f)))])
                 @
                 [Util.option_map v.engine_version
                    (fun f ->
                       Ezxmlm.make_tag "EngineVersion"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.allow_major_version_upgrade
                   (fun f ->
                      Ezxmlm.make_tag "AllowMajorVersionUpgrade"
                        ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.d_b_instance_parameter_group_name
                  (fun f ->
                     Ezxmlm.make_tag "DBInstanceParameterGroupName"
                       ([], (String.to_xml f)))])
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
module ModifyDBClusterResult = ModifyDBClusterResult
type input = ModifyDBClusterMessage.t
type output = ModifyDBClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyDBClusterMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyDBClusterResponse" (snd xml))
        (Xml.member "ModifyDBClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyDBClusterResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyDBClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBClusterResult - missing field in body or children: "
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