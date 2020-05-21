open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyReplicationGroupMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The identifier of the replication group to modify.</p>"];
      replication_group_description: String.t option
        [@ocaml.doc
          "<p>A description for the replication group. Maximum length is 255 characters.</p>"];
      primary_cluster_id: String.t option
        [@ocaml.doc
          "<p>For replication groups with a single primary, if this parameter is specified, ElastiCache promotes the specified cluster in the specified replication group to the primary role. The nodes of all other clusters in the replication group are read replicas.</p>"];
      snapshotting_cluster_id: String.t option
        [@ocaml.doc
          "<p>The cluster ID that is used as the daily snapshot source for the replication group. This parameter cannot be set for Redis (cluster mode enabled) replication groups.</p>"];
      automatic_failover_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Determines whether a read replica is automatically promoted to read/write primary if the existing primary encounters a failure.</p> <p>Valid values: <code>true</code> | <code>false</code> </p> <p>Amazon ElastiCache for Redis does not support Multi-AZ with automatic failover on:</p> <ul> <li> <p>Redis versions earlier than 2.8.6.</p> </li> <li> <p>Redis (cluster mode disabled): T1 node types.</p> </li> <li> <p>Redis (cluster mode enabled): T1 node types.</p> </li> </ul>"];
      node_group_id: String.t option
        [@ocaml.doc "<p>Deprecated. This parameter is not used.</p>"];
      cache_security_group_names: CacheSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of cache security group names to authorize for the clusters in this replication group. This change is asynchronously applied as soon as possible.</p> <p>This parameter can be used only with replication group containing clusters running outside of an Amazon Virtual Private Cloud (Amazon VPC).</p> <p>Constraints: Must contain no more than 255 alphanumeric characters. Must not be <code>Default</code>.</p>"];
      security_group_ids: SecurityGroupIdsList.t
        [@ocaml.doc
          "<p>Specifies the VPC Security Groups associated with the clusters in the replication group.</p> <p>This parameter can be used only with replication group containing clusters running in an Amazon Virtual Private Cloud (Amazon VPC).</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.</p> <p>Valid values for <code>ddd</code> are:</p> <ul> <li> <p> <code>sun</code> </p> </li> <li> <p> <code>mon</code> </p> </li> <li> <p> <code>tue</code> </p> </li> <li> <p> <code>wed</code> </p> </li> <li> <p> <code>thu</code> </p> </li> <li> <p> <code>fri</code> </p> </li> <li> <p> <code>sat</code> </p> </li> </ul> <p>Example: <code>sun:23:00-mon:01:30</code> </p>"];
      notification_topic_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon SNS topic to which notifications are sent.</p> <note> <p>The Amazon SNS topic owner must be same as the replication group owner. </p> </note>"];
      cache_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the cache parameter group to apply to all of the clusters in this replication group. This change is asynchronously applied as soon as possible for parameters when the <code>ApplyImmediately</code> parameter is specified as <code>true</code> for this request.</p>"];
      notification_topic_status: String.t option
        [@ocaml.doc
          "<p>The status of the Amazon SNS notification topic for the replication group. Notifications are sent only if the status is <code>active</code>.</p> <p>Valid values: <code>active</code> | <code>inactive</code> </p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>If <code>true</code>, this parameter causes the modifications in this request and any pending modifications to be applied, asynchronously and as soon as possible, regardless of the <code>PreferredMaintenanceWindow</code> setting for the replication group.</p> <p>If <code>false</code>, changes to the nodes in the replication group are applied on the next maintenance reboot, or the next failure reboot, whichever occurs first.</p> <p>Valid values: <code>true</code> | <code>false</code> </p> <p>Default: <code>false</code> </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The upgraded version of the cache engine to be run on the clusters in the replication group.</p> <p> <b>Important:</b> You can upgrade to a newer engine version (see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SelectEngine.html#VersionManagement\">Selecting a Cache Engine and Version</a>), but you cannot downgrade to an earlier engine version. If you want to use an earlier engine version, you must delete the existing replication group and create it anew with the earlier engine version. </p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc "<p>This parameter is currently disabled.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which ElastiCache retains automatic node group (shard) snapshots before deleting them. For example, if you set <code>SnapshotRetentionLimit</code> to 5, a snapshot that was taken today is retained for 5 days before being deleted.</p> <p> <b>Important</b> If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off.</p>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of the node group (shard) specified by <code>SnapshottingClusterId</code>.</p> <p>Example: <code>05:00-09:00</code> </p> <p>If you do not specify this parameter, ElastiCache automatically chooses an appropriate time range.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>A valid cache node type that you want to scale this replication group to.</p>"];
      auth_token: String.t option
        [@ocaml.doc
          "<p>Reserved parameter. The password used to access a password protected server. This parameter must be specified with the <code>auth-token-update-strategy </code> parameter. Password constraints:</p> <ul> <li> <p>Must be only printable ASCII characters</p> </li> <li> <p>Must be at least 16 characters and no more than 128 characters in length</p> </li> <li> <p>Cannot contain any of the following characters: '/', '\"', or '@', '%'</p> </li> </ul> <p> For more information, see AUTH password at <a href=\"http://redis.io/commands/AUTH\">AUTH</a>.</p>"];
      auth_token_update_strategy: AuthTokenUpdateStrategyType.t option
        [@ocaml.doc
          "<p>Specifies the strategy to use to update the AUTH token. This parameter must be specified with the <code>auth-token</code> parameter. Possible values:</p> <ul> <li> <p>Rotate</p> </li> <li> <p>Set</p> </li> </ul> <p> For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/auth.html\">Authenticating Users with Redis AUTH</a> </p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>ModifyReplicationGroups</code> operation.</p>"]
    let make ~replication_group_id  ?replication_group_description 
      ?primary_cluster_id  ?snapshotting_cluster_id 
      ?automatic_failover_enabled  ?node_group_id 
      ?(cache_security_group_names= [])  ?(security_group_ids= []) 
      ?preferred_maintenance_window  ?notification_topic_arn 
      ?cache_parameter_group_name  ?notification_topic_status 
      ?apply_immediately  ?engine_version  ?auto_minor_version_upgrade 
      ?snapshot_retention_limit  ?snapshot_window  ?cache_node_type 
      ?auth_token  ?auth_token_update_strategy  () =
      {
        replication_group_id;
        replication_group_description;
        primary_cluster_id;
        snapshotting_cluster_id;
        automatic_failover_enabled;
        node_group_id;
        cache_security_group_names;
        security_group_ids;
        preferred_maintenance_window;
        notification_topic_arn;
        cache_parameter_group_name;
        notification_topic_status;
        apply_immediately;
        engine_version;
        auto_minor_version_upgrade;
        snapshot_retention_limit;
        snapshot_window;
        cache_node_type;
        auth_token;
        auth_token_update_strategy
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.auth_token_update_strategy
              (fun f ->
                 ("auth_token_update_strategy",
                   (AuthTokenUpdateStrategyType.to_json f)));
           Util.option_map v.auth_token
             (fun f -> ("auth_token", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.snapshot_window
             (fun f -> ("snapshot_window", (String.to_json f)));
           Util.option_map v.snapshot_retention_limit
             (fun f -> ("snapshot_retention_limit", (Integer.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.apply_immediately
             (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Util.option_map v.notification_topic_status
             (fun f -> ("notification_topic_status", (String.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)));
           Util.option_map v.notification_topic_arn
             (fun f -> ("notification_topic_arn", (String.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Some
             ("security_group_ids",
               (SecurityGroupIdsList.to_json v.security_group_ids));
           Some
             ("cache_security_group_names",
               (CacheSecurityGroupNameList.to_json
                  v.cache_security_group_names));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)));
           Util.option_map v.automatic_failover_enabled
             (fun f -> ("automatic_failover_enabled", (Boolean.to_json f)));
           Util.option_map v.snapshotting_cluster_id
             (fun f -> ("snapshotting_cluster_id", (String.to_json f)));
           Util.option_map v.primary_cluster_id
             (fun f -> ("primary_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_description
             (fun f -> ("replication_group_description", (String.to_json f)));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          replication_group_description =
            (Util.option_bind (Xml.member "ReplicationGroupDescription" xml)
               String.parse);
          primary_cluster_id =
            (Util.option_bind (Xml.member "PrimaryClusterId" xml)
               String.parse);
          snapshotting_cluster_id =
            (Util.option_bind (Xml.member "SnapshottingClusterId" xml)
               String.parse);
          automatic_failover_enabled =
            (Util.option_bind (Xml.member "AutomaticFailoverEnabled" xml)
               Boolean.parse);
          node_group_id =
            (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse);
          cache_security_group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSecurityGroupNames" xml)
                  CacheSecurityGroupNameList.parse));
          security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroupIds" xml)
                  SecurityGroupIdsList.parse));
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          notification_topic_arn =
            (Util.option_bind (Xml.member "NotificationTopicArn" xml)
               String.parse);
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          notification_topic_status =
            (Util.option_bind (Xml.member "NotificationTopicStatus" xml)
               String.parse);
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          snapshot_retention_limit =
            (Util.option_bind (Xml.member "SnapshotRetentionLimit" xml)
               Integer.parse);
          snapshot_window =
            (Util.option_bind (Xml.member "SnapshotWindow" xml) String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          auth_token =
            (Util.option_bind (Xml.member "AuthToken" xml) String.parse);
          auth_token_update_strategy =
            (Util.option_bind (Xml.member "AuthTokenUpdateStrategy" xml)
               AuthTokenUpdateStrategyType.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((([] @
                              [Some
                                 (Ezxmlm.make_tag "ReplicationGroupId"
                                    ([],
                                      (String.to_xml v.replication_group_id)))])
                             @
                             [Util.option_map v.replication_group_description
                                (fun f ->
                                   Ezxmlm.make_tag
                                     "ReplicationGroupDescription"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.primary_cluster_id
                               (fun f ->
                                  Ezxmlm.make_tag "PrimaryClusterId"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.snapshotting_cluster_id
                              (fun f ->
                                 Ezxmlm.make_tag "SnapshottingClusterId"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.automatic_failover_enabled
                             (fun f ->
                                Ezxmlm.make_tag "AutomaticFailoverEnabled"
                                  ([], (Boolean.to_xml f)))])
                         @
                         [Util.option_map v.node_group_id
                            (fun f ->
                               Ezxmlm.make_tag "NodeGroupId"
                                 ([], (String.to_xml f)))])
                        @
                        (List.map
                           (fun x ->
                              Some
                                (Ezxmlm.make_tag "CacheSecurityGroupNames"
                                   ([],
                                     (CacheSecurityGroupNameList.to_xml [x]))))
                           v.cache_security_group_names))
                       @
                       (List.map
                          (fun x ->
                             Some
                               (Ezxmlm.make_tag "SecurityGroupIds"
                                  ([], (SecurityGroupIdsList.to_xml [x]))))
                          v.security_group_ids))
                      @
                      [Util.option_map v.preferred_maintenance_window
                         (fun f ->
                            Ezxmlm.make_tag "PreferredMaintenanceWindow"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.notification_topic_arn
                        (fun f ->
                           Ezxmlm.make_tag "NotificationTopicArn"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.cache_parameter_group_name
                       (fun f ->
                          Ezxmlm.make_tag "CacheParameterGroupName"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.notification_topic_status
                      (fun f ->
                         Ezxmlm.make_tag "NotificationTopicStatus"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.apply_immediately
                     (fun f ->
                        Ezxmlm.make_tag "ApplyImmediately"
                          ([], (Boolean.to_xml f)))])
                 @
                 [Util.option_map v.engine_version
                    (fun f ->
                       Ezxmlm.make_tag "EngineVersion"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.auto_minor_version_upgrade
                   (fun f ->
                      Ezxmlm.make_tag "AutoMinorVersionUpgrade"
                        ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.snapshot_retention_limit
                  (fun f ->
                     Ezxmlm.make_tag "SnapshotRetentionLimit"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.snapshot_window
                 (fun f ->
                    Ezxmlm.make_tag "SnapshotWindow" ([], (String.to_xml f)))])
             @
             [Util.option_map v.cache_node_type
                (fun f ->
                   Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
            @
            [Util.option_map v.auth_token
               (fun f -> Ezxmlm.make_tag "AuthToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.auth_token_update_strategy
              (fun f ->
                 Ezxmlm.make_tag "AuthTokenUpdateStrategy"
                   ([], (AuthTokenUpdateStrategyType.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>ModifyReplicationGroups</code> operation.</p>"]
module ModifyReplicationGroupResult = ModifyReplicationGroupResult
type input = ModifyReplicationGroupMessage.t
type output = ModifyReplicationGroupResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]);
         ("Action", ["ModifyReplicationGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyReplicationGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyReplicationGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyReplicationGroupResponse" (snd xml))
        (Xml.member "ModifyReplicationGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyReplicationGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyReplicationGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyReplicationGroupResult - missing field in body or children: "
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