open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t
        [@ocaml.doc
          "<p>The cluster identifier. This value is stored as a lowercase string.</p>"];
      num_cache_nodes: Integer.t option
        [@ocaml.doc
          "<p>The number of cache nodes that the cluster should have. If the value for <code>NumCacheNodes</code> is greater than the sum of the number of current cache nodes and the number of cache nodes pending creation (which may be zero), more nodes are added. If the value is less than the number of existing cache nodes, nodes are removed. If the value is equal to the number of current cache nodes, any pending add or remove requests are canceled.</p> <p>If you are removing cache nodes, you must use the <code>CacheNodeIdsToRemove</code> parameter to provide the IDs of the specific cache nodes to remove.</p> <p>For clusters running Redis, this value must be 1. For clusters running Memcached, this value must be between 1 and 20.</p> <note> <p>Adding or removing Memcached cache nodes can be applied immediately or as a pending operation (see <code>ApplyImmediately</code>).</p> <p>A pending operation to modify the number of cache nodes in a cluster during its maintenance window, whether by adding or removing nodes in accordance with the scale out architecture, is not queued. The customer's latest request to add or remove nodes to the cluster overrides any previous pending operations to modify the number of cache nodes in the cluster. For example, a request to remove 2 nodes would override a previous pending operation to remove 3 nodes. Similarly, a request to add 2 nodes would override a previous pending operation to remove 3 nodes and vice versa. As Memcached cache nodes may now be provisioned in different Availability Zones with flexible cache node placement, a request to add nodes does not automatically override a previous pending operation to add nodes. The customer can modify the previous pending operation to add more nodes or explicitly cancel the pending request and retry the new request. To cancel pending operations to modify the number of cache nodes in a cluster, use the <code>ModifyCacheCluster</code> request and set <code>NumCacheNodes</code> equal to the number of cache nodes currently in the cluster.</p> </note>"];
      cache_node_ids_to_remove: CacheNodeIdsList.t
        [@ocaml.doc
          "<p>A list of cache node IDs to be removed. A node ID is a numeric identifier (0001, 0002, etc.). This parameter is only valid when <code>NumCacheNodes</code> is less than the existing number of cache nodes. The number of cache node IDs supplied in this parameter must match the difference between the existing number of cache nodes in the cluster or pending cache nodes, whichever is greater, and the value of <code>NumCacheNodes</code> in the request.</p> <p>For example: If you have 3 active cache nodes, 7 pending cache nodes, and the number of cache nodes in this <code>ModifyCacheCluster</code> call is 5, you must list 2 (7 - 5) cache node IDs to remove.</p>"];
      a_z_mode: AZMode.t option
        [@ocaml.doc
          "<p>Specifies whether the new nodes in this Memcached cluster are all created in a single Availability Zone or created across multiple Availability Zones.</p> <p>Valid values: <code>single-az</code> | <code>cross-az</code>.</p> <p>This option is only supported for Memcached clusters.</p> <note> <p>You cannot specify <code>single-az</code> if the Memcached cluster already has cache nodes in different Availability Zones. If <code>cross-az</code> is specified, existing Memcached nodes remain in their current Availability Zone.</p> <p>Only newly created nodes are located in different Availability Zones. </p> </note>"];
      new_availability_zones: PreferredAvailabilityZoneList.t
        [@ocaml.doc
          "<p>The list of Availability Zones where the new Memcached cache nodes are created.</p> <p>This parameter is only valid when <code>NumCacheNodes</code> in the request is greater than the sum of the number of active cache nodes and the number of cache nodes pending creation (which may be zero). The number of Availability Zones supplied in this list must match the cache nodes being added in this request.</p> <p>This option is only supported on Memcached clusters.</p> <p>Scenarios:</p> <ul> <li> <p> <b>Scenario 1:</b> You have 3 active nodes and wish to add 2 nodes. Specify <code>NumCacheNodes=5</code> (3 + 2) and optionally specify two Availability Zones for the two new nodes.</p> </li> <li> <p> <b>Scenario 2:</b> You have 3 active nodes and 2 nodes pending creation (from the scenario 1 call) and want to add 1 more node. Specify <code>NumCacheNodes=6</code> ((3 + 2) + 1) and optionally specify an Availability Zone for the new node.</p> </li> <li> <p> <b>Scenario 3:</b> You want to cancel all pending operations. Specify <code>NumCacheNodes=3</code> to cancel all pending operations.</p> </li> </ul> <p>The Availability Zone placement of nodes pending creation cannot be modified. If you wish to cancel any nodes pending creation, add 0 nodes by setting <code>NumCacheNodes</code> to the number of current nodes.</p> <p>If <code>cross-az</code> is specified, existing Memcached nodes remain in their current Availability Zone. Only newly created nodes can be located in different Availability Zones. For guidance on how to move existing Memcached nodes to different Availability Zones, see the <b>Availability Zone Considerations</b> section of <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/CacheNodes.SupportedTypes.html\">Cache Node Considerations for Memcached</a>.</p> <p> <b>Impact of new add/remove requests upon pending requests</b> </p> <ul> <li> <p>Scenario-1</p> <ul> <li> <p>Pending Action: Delete</p> </li> <li> <p>New Request: Delete</p> </li> <li> <p>Result: The new delete, pending or immediate, replaces the pending delete.</p> </li> </ul> </li> <li> <p>Scenario-2</p> <ul> <li> <p>Pending Action: Delete</p> </li> <li> <p>New Request: Create</p> </li> <li> <p>Result: The new create, pending or immediate, replaces the pending delete.</p> </li> </ul> </li> <li> <p>Scenario-3</p> <ul> <li> <p>Pending Action: Create</p> </li> <li> <p>New Request: Delete</p> </li> <li> <p>Result: The new delete, pending or immediate, replaces the pending create.</p> </li> </ul> </li> <li> <p>Scenario-4</p> <ul> <li> <p>Pending Action: Create</p> </li> <li> <p>New Request: Create</p> </li> <li> <p>Result: The new create is added to the pending create.</p> <important> <p> <b>Important:</b> If the new create request is <b>Apply Immediately - Yes</b>, all creates are performed immediately. If the new create request is <b>Apply Immediately - No</b>, all creates are pending.</p> </important> </li> </ul> </li> </ul>"];
      cache_security_group_names: CacheSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of cache security group names to authorize on this cluster. This change is asynchronously applied as soon as possible.</p> <p>You can use this parameter only with clusters that are created outside of an Amazon Virtual Private Cloud (Amazon VPC).</p> <p>Constraints: Must contain no more than 255 alphanumeric characters. Must not be \"Default\".</p>"];
      security_group_ids: SecurityGroupIdsList.t
        [@ocaml.doc
          "<p>Specifies the VPC Security Groups associated with the cluster.</p> <p>This parameter can be used only with clusters that are created in an Amazon Virtual Private Cloud (Amazon VPC).</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.</p> <p>Valid values for <code>ddd</code> are:</p> <ul> <li> <p> <code>sun</code> </p> </li> <li> <p> <code>mon</code> </p> </li> <li> <p> <code>tue</code> </p> </li> <li> <p> <code>wed</code> </p> </li> <li> <p> <code>thu</code> </p> </li> <li> <p> <code>fri</code> </p> </li> <li> <p> <code>sat</code> </p> </li> </ul> <p>Example: <code>sun:23:00-mon:01:30</code> </p>"];
      notification_topic_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon SNS topic to which notifications are sent.</p> <note> <p>The Amazon SNS topic owner must be same as the cluster owner.</p> </note>"];
      cache_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the cache parameter group to apply to this cluster. This change is asynchronously applied as soon as possible for parameters when the <code>ApplyImmediately</code> parameter is specified as <code>true</code> for this request.</p>"];
      notification_topic_status: String.t option
        [@ocaml.doc
          "<p>The status of the Amazon SNS notification topic. Notifications are sent only if the status is <code>active</code>.</p> <p>Valid values: <code>active</code> | <code>inactive</code> </p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>If <code>true</code>, this parameter causes the modifications in this request and any pending modifications to be applied, asynchronously and as soon as possible, regardless of the <code>PreferredMaintenanceWindow</code> setting for the cluster.</p> <p>If <code>false</code>, changes to the cluster are applied on the next maintenance reboot, or the next failure reboot, whichever occurs first.</p> <important> <p>If you perform a <code>ModifyCacheCluster</code> before a pending modification is applied, the pending modification is replaced by the newer modification.</p> </important> <p>Valid values: <code>true</code> | <code>false</code> </p> <p>Default: <code>false</code> </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The upgraded version of the cache engine to be run on the cache nodes.</p> <p> <b>Important:</b> You can upgrade to a newer engine version (see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SelectEngine.html#VersionManagement\">Selecting a Cache Engine and Version</a>), but you cannot downgrade to an earlier engine version. If you want to use an earlier engine version, you must delete the existing cluster and create it anew with the earlier engine version. </p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc "<p>This parameter is currently disabled.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which ElastiCache retains automatic cluster snapshots before deleting them. For example, if you set <code>SnapshotRetentionLimit</code> to 5, a snapshot that was taken today is retained for 5 days before being deleted.</p> <note> <p>If the value of <code>SnapshotRetentionLimit</code> is set to zero (0), backups are turned off.</p> </note>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your cluster. </p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>A valid cache node type that you want to scale this cluster up to.</p>"];
      auth_token: String.t option
        [@ocaml.doc
          "<p>Reserved parameter. The password used to access a password protected server. This parameter must be specified with the <code>auth-token-update</code> parameter. Password constraints:</p> <ul> <li> <p>Must be only printable ASCII characters</p> </li> <li> <p>Must be at least 16 characters and no more than 128 characters in length</p> </li> <li> <p>Cannot contain any of the following characters: '/', '\"', or '@', '%'</p> </li> </ul> <p> For more information, see AUTH password at <a href=\"http://redis.io/commands/AUTH\">AUTH</a>.</p>"];
      auth_token_update_strategy: AuthTokenUpdateStrategyType.t option
        [@ocaml.doc
          "<p>Specifies the strategy to use to update the AUTH token. This parameter must be specified with the <code>auth-token</code> parameter. Possible values:</p> <ul> <li> <p>Rotate</p> </li> <li> <p>Set</p> </li> </ul> <p> For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/auth.html\">Authenticating Users with Redis AUTH</a> </p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>ModifyCacheCluster</code> operation.</p>"]
    let make ~cache_cluster_id  ?num_cache_nodes  ?(cache_node_ids_to_remove=
      [])  ?a_z_mode  ?(new_availability_zones= []) 
      ?(cache_security_group_names= [])  ?(security_group_ids= []) 
      ?preferred_maintenance_window  ?notification_topic_arn 
      ?cache_parameter_group_name  ?notification_topic_status 
      ?apply_immediately  ?engine_version  ?auto_minor_version_upgrade 
      ?snapshot_retention_limit  ?snapshot_window  ?cache_node_type 
      ?auth_token  ?auth_token_update_strategy  () =
      {
        cache_cluster_id;
        num_cache_nodes;
        cache_node_ids_to_remove;
        a_z_mode;
        new_availability_zones;
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
           Some
             ("new_availability_zones",
               (PreferredAvailabilityZoneList.to_json
                  v.new_availability_zones));
           Util.option_map v.a_z_mode
             (fun f -> ("a_z_mode", (AZMode.to_json f)));
           Some
             ("cache_node_ids_to_remove",
               (CacheNodeIdsList.to_json v.cache_node_ids_to_remove));
           Util.option_map v.num_cache_nodes
             (fun f -> ("num_cache_nodes", (Integer.to_json f)));
           Some ("cache_cluster_id", (String.to_json v.cache_cluster_id))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Xml.required "CacheClusterId"
               (Util.option_bind (Xml.member "CacheClusterId" xml)
                  String.parse));
          num_cache_nodes =
            (Util.option_bind (Xml.member "NumCacheNodes" xml) Integer.parse);
          cache_node_ids_to_remove =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheNodeIdsToRemove" xml)
                  CacheNodeIdsList.parse));
          a_z_mode =
            (Util.option_bind (Xml.member "AZMode" xml) AZMode.parse);
          new_availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "NewAvailabilityZones" xml)
                  PreferredAvailabilityZoneList.parse));
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
        ((((((((((((((((((([] @
                             [Some
                                (Ezxmlm.make_tag "CacheClusterId"
                                   ([], (String.to_xml v.cache_cluster_id)))])
                            @
                            [Util.option_map v.num_cache_nodes
                               (fun f ->
                                  Ezxmlm.make_tag "NumCacheNodes"
                                    ([], (Integer.to_xml f)))])
                           @
                           (List.map
                              (fun x ->
                                 Some
                                   (Ezxmlm.make_tag "CacheNodeIdsToRemove"
                                      ([], (CacheNodeIdsList.to_xml [x]))))
                              v.cache_node_ids_to_remove))
                          @
                          [Util.option_map v.a_z_mode
                             (fun f ->
                                Ezxmlm.make_tag "AZMode"
                                  ([], (AZMode.to_xml f)))])
                         @
                         (List.map
                            (fun x ->
                               Some
                                 (Ezxmlm.make_tag "NewAvailabilityZones"
                                    ([],
                                      (PreferredAvailabilityZoneList.to_xml
                                         [x])))) v.new_availability_zones))
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
       "<p>Represents the input of a <code>ModifyCacheCluster</code> operation.</p>"]
module ModifyCacheClusterResult = ModifyCacheClusterResult
type input = ModifyCacheClusterMessage.t
type output = ModifyCacheClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["ModifyCacheCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyCacheClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyCacheClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyCacheClusterResponse" (snd xml))
        (Xml.member "ModifyCacheClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyCacheClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyCacheClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyCacheClusterResult - missing field in body or children: "
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