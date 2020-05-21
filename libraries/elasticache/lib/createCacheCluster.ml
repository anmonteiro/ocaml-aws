open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t
        [@ocaml.doc
          "<p>The node group (shard) identifier. This parameter is stored as a lowercase string.</p> <p> <b>Constraints:</b> </p> <ul> <li> <p>A name must contain from 1 to 50 alphanumeric characters or hyphens.</p> </li> <li> <p>The first character must be a letter.</p> </li> <li> <p>A name cannot end with a hyphen or contain two consecutive hyphens.</p> </li> </ul>"];
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>The ID of the replication group to which this cluster should belong. If this parameter is specified, the cluster is added to the specified replication group as a read replica; otherwise, the cluster is a standalone primary that is not part of any replication group.</p> <p>If the specified replication group is Multi-AZ enabled and the Availability Zone is not specified, the cluster is created in Availability Zones that provide the best spread of read replicas across Availability Zones.</p> <note> <p>This parameter is only valid if the <code>Engine</code> parameter is <code>redis</code>.</p> </note>"];
      a_z_mode: AZMode.t option
        [@ocaml.doc
          "<p>Specifies whether the nodes in this Memcached cluster are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region.</p> <p>This parameter is only supported for Memcached clusters.</p> <p>If the <code>AZMode</code> and <code>PreferredAvailabilityZones</code> are not specified, ElastiCache assumes <code>single-az</code> mode.</p>"];
      preferred_availability_zone: String.t option
        [@ocaml.doc
          "<p>The EC2 Availability Zone in which the cluster is created.</p> <p>All nodes belonging to this Memcached cluster are placed in the preferred Availability Zone. If you want to create your nodes across multiple Availability Zones, use <code>PreferredAvailabilityZones</code>.</p> <p>Default: System chosen Availability Zone.</p>"];
      preferred_availability_zones: PreferredAvailabilityZoneList.t
        [@ocaml.doc
          "<p>A list of the Availability Zones in which cache nodes are created. The order of the zones in the list is not important.</p> <p>This option is only supported on Memcached.</p> <note> <p>If you are creating your cluster in an Amazon VPC (recommended) you can only locate nodes in Availability Zones that are associated with the subnets in the selected subnet group.</p> <p>The number of Availability Zones listed must equal the value of <code>NumCacheNodes</code>.</p> </note> <p>If you want all the nodes in the same Availability Zone, use <code>PreferredAvailabilityZone</code> instead, or repeat the Availability Zone multiple times in the list.</p> <p>Default: System chosen Availability Zones.</p>"];
      num_cache_nodes: Integer.t option
        [@ocaml.doc
          "<p>The initial number of cache nodes that the cluster has.</p> <p>For clusters running Redis, this value must be 1. For clusters running Memcached, this value must be between 1 and 20.</p> <p>If you need more than 20 nodes for your Memcached cluster, please fill out the ElastiCache Limit Increase Request form at <a href=\"http://aws.amazon.com/contact-us/elasticache-node-limit-request/\">http://aws.amazon.com/contact-us/elasticache-node-limit-request/</a>.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The compute and memory capacity of the nodes in the node group (shard).</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The name of the cache engine to be used for this cluster.</p> <p>Valid values for this parameter are: <code>memcached</code> | <code>redis</code> </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the cache engine to be used for this cluster. To view the supported cache engine versions, use the DescribeCacheEngineVersions operation.</p> <p> <b>Important:</b> You can upgrade to a newer engine version (see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SelectEngine.html#VersionManagement\">Selecting a Cache Engine and Version</a>), but you cannot downgrade to an earlier engine version. If you want to use an earlier engine version, you must delete the existing cluster or replication group and create it anew with the earlier engine version. </p>"];
      cache_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the parameter group to associate with this cluster. If this argument is omitted, the default parameter group for the specified engine is used. You cannot use any parameter group which has <code>cluster-enabled='yes'</code> when creating a cluster.</p>"];
      cache_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the subnet group to be used for the cluster.</p> <p>Use this parameter only when you are creating a cluster in an Amazon Virtual Private Cloud (Amazon VPC).</p> <important> <p>If you're going to launch your cluster in an Amazon VPC, you need to create a subnet group before you start creating a cluster. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SubnetGroups.html\">Subnets and Subnet Groups</a>.</p> </important>"];
      cache_security_group_names: CacheSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of security group names to associate with this cluster.</p> <p>Use this parameter only when you are creating a cluster outside of an Amazon Virtual Private Cloud (Amazon VPC).</p>"];
      security_group_ids: SecurityGroupIdsList.t
        [@ocaml.doc
          "<p>One or more VPC security groups associated with the cluster.</p> <p>Use this parameter only when you are creating a cluster in an Amazon Virtual Private Cloud (Amazon VPC).</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>A list of cost allocation tags to be added to this resource.</p>"];
      snapshot_arns: SnapshotArnsList.t
        [@ocaml.doc
          "<p>A single-element string list containing an Amazon Resource Name (ARN) that uniquely identifies a Redis RDB snapshot file stored in Amazon S3. The snapshot file is used to populate the node group (shard). The Amazon S3 object name in the ARN cannot contain any commas.</p> <note> <p>This parameter is only valid if the <code>Engine</code> parameter is <code>redis</code>.</p> </note> <p>Example of an Amazon S3 ARN: <code>arn:aws:s3:::my_bucket/snapshot1.rdb</code> </p>"];
      snapshot_name: String.t option
        [@ocaml.doc
          "<p>The name of a Redis snapshot from which to restore data into the new node group (shard). The snapshot status changes to <code>restoring</code> while the new node group (shard) is being created.</p> <note> <p>This parameter is only valid if the <code>Engine</code> parameter is <code>redis</code>.</p> </note>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Valid values for <code>ddd</code> are:</p> <p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.</p> <p>Valid values for <code>ddd</code> are:</p> <ul> <li> <p> <code>sun</code> </p> </li> <li> <p> <code>mon</code> </p> </li> <li> <p> <code>tue</code> </p> </li> <li> <p> <code>wed</code> </p> </li> <li> <p> <code>thu</code> </p> </li> <li> <p> <code>fri</code> </p> </li> <li> <p> <code>sat</code> </p> </li> </ul> <p>Example: <code>sun:23:00-mon:01:30</code> </p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which each of the cache nodes accepts connections.</p>"];
      notification_topic_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications are sent.</p> <note> <p>The Amazon SNS topic owner must be the same as the cluster owner.</p> </note>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc "<p>This parameter is currently disabled.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which ElastiCache retains automatic snapshots before deleting them. For example, if you set <code>SnapshotRetentionLimit</code> to 5, a snapshot taken today is retained for 5 days before being deleted.</p> <note> <p>This parameter is only valid if the <code>Engine</code> parameter is <code>redis</code>.</p> </note> <p>Default: 0 (i.e., automatic backups are disabled for this cache cluster).</p>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group (shard).</p> <p>Example: <code>05:00-09:00</code> </p> <p>If you do not specify this parameter, ElastiCache automatically chooses an appropriate time range.</p> <note> <p>This parameter is only valid if the <code>Engine</code> parameter is <code>redis</code>.</p> </note>"];
      auth_token: String.t option
        [@ocaml.doc
          "<p> <b>Reserved parameter.</b> The password used to access a password protected server.</p> <p>Password constraints:</p> <ul> <li> <p>Must be only printable ASCII characters.</p> </li> <li> <p>Must be at least 16 characters and no more than 128 characters in length.</p> </li> <li> <p>The only permitted printable special characters are !, &amp;, #, $, ^, &lt;, &gt;, and -. Other printable special characters cannot be used in the AUTH token.</p> </li> </ul> <p>For more information, see <a href=\"http://redis.io/commands/AUTH\">AUTH password</a> at http://redis.io/commands/AUTH.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a CreateCacheCluster operation.</p>"]
    let make ~cache_cluster_id  ?replication_group_id  ?a_z_mode 
      ?preferred_availability_zone  ?(preferred_availability_zones= []) 
      ?num_cache_nodes  ?cache_node_type  ?engine  ?engine_version 
      ?cache_parameter_group_name  ?cache_subnet_group_name 
      ?(cache_security_group_names= [])  ?(security_group_ids= [])  ?(tags=
      [])  ?(snapshot_arns= [])  ?snapshot_name 
      ?preferred_maintenance_window  ?port  ?notification_topic_arn 
      ?auto_minor_version_upgrade  ?snapshot_retention_limit 
      ?snapshot_window  ?auth_token  () =
      {
        cache_cluster_id;
        replication_group_id;
        a_z_mode;
        preferred_availability_zone;
        preferred_availability_zones;
        num_cache_nodes;
        cache_node_type;
        engine;
        engine_version;
        cache_parameter_group_name;
        cache_subnet_group_name;
        cache_security_group_names;
        security_group_ids;
        tags;
        snapshot_arns;
        snapshot_name;
        preferred_maintenance_window;
        port;
        notification_topic_arn;
        auto_minor_version_upgrade;
        snapshot_retention_limit;
        snapshot_window;
        auth_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.auth_token
              (fun f -> ("auth_token", (String.to_json f)));
           Util.option_map v.snapshot_window
             (fun f -> ("snapshot_window", (String.to_json f)));
           Util.option_map v.snapshot_retention_limit
             (fun f -> ("snapshot_retention_limit", (Integer.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.notification_topic_arn
             (fun f -> ("notification_topic_arn", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.snapshot_name
             (fun f -> ("snapshot_name", (String.to_json f)));
           Some ("snapshot_arns", (SnapshotArnsList.to_json v.snapshot_arns));
           Some ("tags", (TagList.to_json v.tags));
           Some
             ("security_group_ids",
               (SecurityGroupIdsList.to_json v.security_group_ids));
           Some
             ("cache_security_group_names",
               (CacheSecurityGroupNameList.to_json
                  v.cache_security_group_names));
           Util.option_map v.cache_subnet_group_name
             (fun f -> ("cache_subnet_group_name", (String.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.num_cache_nodes
             (fun f -> ("num_cache_nodes", (Integer.to_json f)));
           Some
             ("preferred_availability_zones",
               (PreferredAvailabilityZoneList.to_json
                  v.preferred_availability_zones));
           Util.option_map v.preferred_availability_zone
             (fun f -> ("preferred_availability_zone", (String.to_json f)));
           Util.option_map v.a_z_mode
             (fun f -> ("a_z_mode", (AZMode.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)));
           Some ("cache_cluster_id", (String.to_json v.cache_cluster_id))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Xml.required "CacheClusterId"
               (Util.option_bind (Xml.member "CacheClusterId" xml)
                  String.parse));
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          a_z_mode =
            (Util.option_bind (Xml.member "AZMode" xml) AZMode.parse);
          preferred_availability_zone =
            (Util.option_bind (Xml.member "PreferredAvailabilityZone" xml)
               String.parse);
          preferred_availability_zones =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "PreferredAvailabilityZones" xml)
                  PreferredAvailabilityZoneList.parse));
          num_cache_nodes =
            (Util.option_bind (Xml.member "NumCacheNodes" xml) Integer.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          cache_subnet_group_name =
            (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
               String.parse);
          cache_security_group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSecurityGroupNames" xml)
                  CacheSecurityGroupNameList.parse));
          security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroupIds" xml)
                  SecurityGroupIdsList.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          snapshot_arns =
            (Util.of_option []
               (Util.option_bind (Xml.member "SnapshotArns" xml)
                  SnapshotArnsList.parse));
          snapshot_name =
            (Util.option_bind (Xml.member "SnapshotName" xml) String.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          notification_topic_arn =
            (Util.option_bind (Xml.member "NotificationTopicArn" xml)
               String.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          snapshot_retention_limit =
            (Util.option_bind (Xml.member "SnapshotRetentionLimit" xml)
               Integer.parse);
          snapshot_window =
            (Util.option_bind (Xml.member "SnapshotWindow" xml) String.parse);
          auth_token =
            (Util.option_bind (Xml.member "AuthToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((([] @
                                 [Some
                                    (Ezxmlm.make_tag "CacheClusterId"
                                       ([],
                                         (String.to_xml v.cache_cluster_id)))])
                                @
                                [Util.option_map v.replication_group_id
                                   (fun f ->
                                      Ezxmlm.make_tag "ReplicationGroupId"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.a_z_mode
                                  (fun f ->
                                     Ezxmlm.make_tag "AZMode"
                                       ([], (AZMode.to_xml f)))])
                              @
                              [Util.option_map v.preferred_availability_zone
                                 (fun f ->
                                    Ezxmlm.make_tag
                                      "PreferredAvailabilityZone"
                                      ([], (String.to_xml f)))])
                             @
                             (List.map
                                (fun x ->
                                   Some
                                     (Ezxmlm.make_tag
                                        "PreferredAvailabilityZones"
                                        ([],
                                          (PreferredAvailabilityZoneList.to_xml
                                             [x]))))
                                v.preferred_availability_zones))
                            @
                            [Util.option_map v.num_cache_nodes
                               (fun f ->
                                  Ezxmlm.make_tag "NumCacheNodes"
                                    ([], (Integer.to_xml f)))])
                           @
                           [Util.option_map v.cache_node_type
                              (fun f ->
                                 Ezxmlm.make_tag "CacheNodeType"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.engine
                             (fun f ->
                                Ezxmlm.make_tag "Engine"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.engine_version
                            (fun f ->
                               Ezxmlm.make_tag "EngineVersion"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.cache_parameter_group_name
                           (fun f ->
                              Ezxmlm.make_tag "CacheParameterGroupName"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.cache_subnet_group_name
                          (fun f ->
                             Ezxmlm.make_tag "CacheSubnetGroupName"
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
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "Tags"
                               ([], (TagList.to_xml [x])))) v.tags))
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "SnapshotArns"
                              ([], (SnapshotArnsList.to_xml [x]))))
                      v.snapshot_arns))
                  @
                  [Util.option_map v.snapshot_name
                     (fun f ->
                        Ezxmlm.make_tag "SnapshotName"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.preferred_maintenance_window
                    (fun f ->
                       Ezxmlm.make_tag "PreferredMaintenanceWindow"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.port
                   (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.notification_topic_arn
                  (fun f ->
                     Ezxmlm.make_tag "NotificationTopicArn"
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
           [Util.option_map v.auth_token
              (fun f -> Ezxmlm.make_tag "AuthToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a CreateCacheCluster operation.</p>"]
module CreateCacheClusterResult = CreateCacheClusterResult
type input = CreateCacheClusterMessage.t
type output = CreateCacheClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["CreateCacheCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateCacheClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateCacheClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateCacheClusterResponse" (snd xml))
        (Xml.member "CreateCacheClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateCacheClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCacheClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCacheClusterResult - missing field in body or children: "
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