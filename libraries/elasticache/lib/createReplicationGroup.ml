open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateReplicationGroupMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The replication group identifier. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>A name must contain from 1 to 40 alphanumeric characters or hyphens.</p> </li> <li> <p>The first character must be a letter.</p> </li> <li> <p>A name cannot end with a hyphen or contain two consecutive hyphens.</p> </li> </ul>"];
      replication_group_description: String.t
        [@ocaml.doc
          "<p>A user-created description for the replication group.</p>"];
      primary_cluster_id: String.t option
        [@ocaml.doc
          "<p>The identifier of the cluster that serves as the primary for this replication group. This cluster must already exist and have a status of <code>available</code>.</p> <p>This parameter is not required if <code>NumCacheClusters</code>, <code>NumNodeGroups</code>, or <code>ReplicasPerNodeGroup</code> is specified.</p>"];
      automatic_failover_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether a read-only replica is automatically promoted to read/write primary if the existing primary fails.</p> <p>If <code>true</code>, Multi-AZ is enabled for this replication group. If <code>false</code>, Multi-AZ is disabled for this replication group.</p> <p> <code>AutomaticFailoverEnabled</code> must be enabled for Redis (cluster mode enabled) replication groups.</p> <p>Default: false</p> <p>Amazon ElastiCache for Redis does not support Multi-AZ with automatic failover on:</p> <ul> <li> <p>Redis versions earlier than 2.8.6.</p> </li> <li> <p>Redis (cluster mode disabled): T1 node types.</p> </li> <li> <p>Redis (cluster mode enabled): T1 node types.</p> </li> </ul>"];
      num_cache_clusters: Integer.t option
        [@ocaml.doc
          "<p>The number of clusters this replication group initially has.</p> <p>This parameter is not used if there is more than one node group (shard). You should use <code>ReplicasPerNodeGroup</code> instead.</p> <p>If <code>AutomaticFailoverEnabled</code> is <code>true</code>, the value of this parameter must be at least 2. If <code>AutomaticFailoverEnabled</code> is <code>false</code> you can omit this parameter (it will default to 1), or you can explicitly set it to a value between 2 and 6.</p> <p>The maximum permitted value for <code>NumCacheClusters</code> is 6 (1 primary plus 5 replicas).</p>"];
      preferred_cache_cluster_a_zs: AvailabilityZonesList.t
        [@ocaml.doc
          "<p>A list of EC2 Availability Zones in which the replication group's clusters are created. The order of the Availability Zones in the list is the order in which clusters are allocated. The primary cluster is created in the first AZ in the list.</p> <p>This parameter is not used if there is more than one node group (shard). You should use <code>NodeGroupConfiguration</code> instead.</p> <note> <p>If you are creating your replication group in an Amazon VPC (recommended), you can only locate clusters in Availability Zones associated with the subnets in the selected subnet group.</p> <p>The number of Availability Zones listed must equal the value of <code>NumCacheClusters</code>.</p> </note> <p>Default: system chosen Availability Zones.</p>"];
      num_node_groups: Integer.t option
        [@ocaml.doc
          "<p>An optional parameter that specifies the number of node groups (shards) for this Redis (cluster mode enabled) replication group. For Redis (cluster mode disabled) either omit this parameter or set it to 1.</p> <p>Default: 1</p>"];
      replicas_per_node_group: Integer.t option
        [@ocaml.doc
          "<p>An optional parameter that specifies the number of replica nodes in each node group (shard). Valid values are 0 to 5.</p>"];
      node_group_configuration: NodeGroupConfigurationList.t
        [@ocaml.doc
          "<p>A list of node group (shard) configuration options. Each node group (shard) configuration has the following members: <code>PrimaryAvailabilityZone</code>, <code>ReplicaAvailabilityZones</code>, <code>ReplicaCount</code>, and <code>Slots</code>.</p> <p>If you're creating a Redis (cluster mode disabled) or a Redis (cluster mode enabled) replication group, you can use this parameter to individually configure each node group (shard), or you can omit this parameter. However, when seeding a Redis (cluster mode enabled) cluster from a S3 rdb file, you must configure each node group (shard) using this parameter because you must specify the slots for each node group.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The compute and memory capacity of the nodes in the node group (shard).</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The name of the cache engine to be used for the clusters in this replication group.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the cache engine to be used for the clusters in this replication group. To view the supported cache engine versions, use the <code>DescribeCacheEngineVersions</code> operation.</p> <p> <b>Important:</b> You can upgrade to a newer engine version (see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SelectEngine.html#VersionManagement\">Selecting a Cache Engine and Version</a>) in the <i>ElastiCache User Guide</i>, but you cannot downgrade to an earlier engine version. If you want to use an earlier engine version, you must delete the existing cluster or replication group and create it anew with the earlier engine version. </p>"];
      cache_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used.</p> <note> <p>If you are restoring to an engine version that is different than the original, you must specify the default version of that version. For example, <code>CacheParameterGroupName=default.redis4.0</code>.</p> </note> <p>If you are running Redis version 3.2.4 or later, only one node group (shard), and want to use a default parameter group, we recommend that you specify the parameter group by name. </p> <ul> <li> <p>To create a Redis (cluster mode disabled) replication group, use <code>CacheParameterGroupName=default.redis3.2</code>.</p> </li> <li> <p>To create a Redis (cluster mode enabled) replication group, use <code>CacheParameterGroupName=default.redis3.2.cluster.on</code>.</p> </li> </ul>"];
      cache_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the cache subnet group to be used for the replication group.</p> <important> <p>If you're going to launch your cluster in an Amazon VPC, you need to create a subnet group before you start creating a cluster. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/SubnetGroups.html\">Subnets and Subnet Groups</a>.</p> </important>"];
      cache_security_group_names: CacheSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of cache security group names to associate with this replication group.</p>"];
      security_group_ids: SecurityGroupIdsList.t
        [@ocaml.doc
          "<p>One or more Amazon VPC security groups associated with this replication group.</p> <p>Use this parameter only when you are creating a replication group in an Amazon Virtual Private Cloud (Amazon VPC).</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>A list of cost allocation tags to be added to this resource. Tags are comma-separated key,value pairs (e.g. Key=<code>myKey</code>, Value=<code>myKeyValue</code>. You can include multiple tags as shown following: Key=<code>myKey</code>, Value=<code>myKeyValue</code> Key=<code>mySecondKey</code>, Value=<code>mySecondKeyValue</code>.</p>"];
      snapshot_arns: SnapshotArnsList.t
        [@ocaml.doc
          "<p>A list of Amazon Resource Names (ARN) that uniquely identify the Redis RDB snapshot files stored in Amazon S3. The snapshot files are used to populate the new replication group. The Amazon S3 object name in the ARN cannot contain any commas. The new replication group will have the number of node groups (console: shards) specified by the parameter <i>NumNodeGroups</i> or the number of node groups configured by <i>NodeGroupConfiguration</i> regardless of the number of ARNs specified here.</p> <p>Example of an Amazon S3 ARN: <code>arn:aws:s3:::my_bucket/snapshot1.rdb</code> </p>"];
      snapshot_name: String.t option
        [@ocaml.doc
          "<p>The name of a snapshot from which to restore data into the new replication group. The snapshot status changes to <code>restoring</code> while the new replication group is being created.</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period. Valid values for <code>ddd</code> are:</p> <p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.</p> <p>Valid values for <code>ddd</code> are:</p> <ul> <li> <p> <code>sun</code> </p> </li> <li> <p> <code>mon</code> </p> </li> <li> <p> <code>tue</code> </p> </li> <li> <p> <code>wed</code> </p> </li> <li> <p> <code>thu</code> </p> </li> <li> <p> <code>fri</code> </p> </li> <li> <p> <code>sat</code> </p> </li> </ul> <p>Example: <code>sun:23:00-mon:01:30</code> </p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which each member of the replication group accepts connections.</p>"];
      notification_topic_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon Simple Notification Service (SNS) topic to which notifications are sent.</p> <note> <p>The Amazon SNS topic owner must be the same as the cluster owner.</p> </note>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc "<p>This parameter is currently disabled.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which ElastiCache retains automatic snapshots before deleting them. For example, if you set <code>SnapshotRetentionLimit</code> to 5, a snapshot that was taken today is retained for 5 days before being deleted.</p> <p>Default: 0 (i.e., automatic backups are disabled for this cluster).</p>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group (shard).</p> <p>Example: <code>05:00-09:00</code> </p> <p>If you do not specify this parameter, ElastiCache automatically chooses an appropriate time range.</p>"];
      auth_token: String.t option
        [@ocaml.doc
          "<p> <b>Reserved parameter.</b> The password used to access a password protected server.</p> <p> <code>AuthToken</code> can be specified only on replication groups where <code>TransitEncryptionEnabled</code> is <code>true</code>.</p> <important> <p>For HIPAA compliance, you must specify <code>TransitEncryptionEnabled</code> as <code>true</code>, an <code>AuthToken</code>, and a <code>CacheSubnetGroup</code>.</p> </important> <p>Password constraints:</p> <ul> <li> <p>Must be only printable ASCII characters.</p> </li> <li> <p>Must be at least 16 characters and no more than 128 characters in length.</p> </li> <li> <p>The only permitted printable special characters are !, &amp;, #, $, ^, &lt;, &gt;, and -. Other printable special characters cannot be used in the AUTH token.</p> </li> </ul> <p>For more information, see <a href=\"http://redis.io/commands/AUTH\">AUTH password</a> at http://redis.io/commands/AUTH.</p>"];
      transit_encryption_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables in-transit encryption when set to <code>true</code>.</p> <p>You cannot modify the value of <code>TransitEncryptionEnabled</code> after the cluster is created. To enable in-transit encryption on a cluster you must set <code>TransitEncryptionEnabled</code> to <code>true</code> when you create a cluster.</p> <p>This parameter is valid only if the <code>Engine</code> parameter is <code>redis</code>, the <code>EngineVersion</code> parameter is <code>3.2.6</code>, <code>4.x</code> or later, and the cluster is being created in an Amazon VPC.</p> <p>If you enable in-transit encryption, you must also specify a value for <code>CacheSubnetGroup</code>.</p> <p> <b>Required:</b> Only available when creating a replication group in an Amazon VPC using redis version <code>3.2.6</code>, <code>4.x</code> or later.</p> <p>Default: <code>false</code> </p> <important> <p>For HIPAA compliance, you must specify <code>TransitEncryptionEnabled</code> as <code>true</code>, an <code>AuthToken</code>, and a <code>CacheSubnetGroup</code>.</p> </important>"];
      at_rest_encryption_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables encryption at rest when set to <code>true</code>.</p> <p>You cannot modify the value of <code>AtRestEncryptionEnabled</code> after the replication group is created. To enable encryption at rest on a replication group you must set <code>AtRestEncryptionEnabled</code> to <code>true</code> when you create the replication group. </p> <p> <b>Required:</b> Only available when creating a replication group in an Amazon VPC using redis version <code>3.2.6</code>, <code>4.x</code> or later.</p> <p>Default: <code>false</code> </p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the KMS key used to encrypt the disk on the cluster.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>CreateReplicationGroup</code> operation.</p>"]
    let make ~replication_group_id  ~replication_group_description 
      ?primary_cluster_id  ?automatic_failover_enabled  ?num_cache_clusters 
      ?(preferred_cache_cluster_a_zs= [])  ?num_node_groups 
      ?replicas_per_node_group  ?(node_group_configuration= []) 
      ?cache_node_type  ?engine  ?engine_version  ?cache_parameter_group_name
       ?cache_subnet_group_name  ?(cache_security_group_names= []) 
      ?(security_group_ids= [])  ?(tags= [])  ?(snapshot_arns= []) 
      ?snapshot_name  ?preferred_maintenance_window  ?port 
      ?notification_topic_arn  ?auto_minor_version_upgrade 
      ?snapshot_retention_limit  ?snapshot_window  ?auth_token 
      ?transit_encryption_enabled  ?at_rest_encryption_enabled  ?kms_key_id 
      () =
      {
        replication_group_id;
        replication_group_description;
        primary_cluster_id;
        automatic_failover_enabled;
        num_cache_clusters;
        preferred_cache_cluster_a_zs;
        num_node_groups;
        replicas_per_node_group;
        node_group_configuration;
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
        auth_token;
        transit_encryption_enabled;
        at_rest_encryption_enabled;
        kms_key_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.kms_key_id
              (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.at_rest_encryption_enabled
             (fun f -> ("at_rest_encryption_enabled", (Boolean.to_json f)));
           Util.option_map v.transit_encryption_enabled
             (fun f -> ("transit_encryption_enabled", (Boolean.to_json f)));
           Util.option_map v.auth_token
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
           Some
             ("node_group_configuration",
               (NodeGroupConfigurationList.to_json v.node_group_configuration));
           Util.option_map v.replicas_per_node_group
             (fun f -> ("replicas_per_node_group", (Integer.to_json f)));
           Util.option_map v.num_node_groups
             (fun f -> ("num_node_groups", (Integer.to_json f)));
           Some
             ("preferred_cache_cluster_a_zs",
               (AvailabilityZonesList.to_json v.preferred_cache_cluster_a_zs));
           Util.option_map v.num_cache_clusters
             (fun f -> ("num_cache_clusters", (Integer.to_json f)));
           Util.option_map v.automatic_failover_enabled
             (fun f -> ("automatic_failover_enabled", (Boolean.to_json f)));
           Util.option_map v.primary_cluster_id
             (fun f -> ("primary_cluster_id", (String.to_json f)));
           Some
             ("replication_group_description",
               (String.to_json v.replication_group_description));
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
            (Xml.required "ReplicationGroupDescription"
               (Util.option_bind
                  (Xml.member "ReplicationGroupDescription" xml) String.parse));
          primary_cluster_id =
            (Util.option_bind (Xml.member "PrimaryClusterId" xml)
               String.parse);
          automatic_failover_enabled =
            (Util.option_bind (Xml.member "AutomaticFailoverEnabled" xml)
               Boolean.parse);
          num_cache_clusters =
            (Util.option_bind (Xml.member "NumCacheClusters" xml)
               Integer.parse);
          preferred_cache_cluster_a_zs =
            (Util.of_option []
               (Util.option_bind (Xml.member "PreferredCacheClusterAZs" xml)
                  AvailabilityZonesList.parse));
          num_node_groups =
            (Util.option_bind (Xml.member "NumNodeGroups" xml) Integer.parse);
          replicas_per_node_group =
            (Util.option_bind (Xml.member "ReplicasPerNodeGroup" xml)
               Integer.parse);
          node_group_configuration =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeGroupConfiguration" xml)
                  NodeGroupConfigurationList.parse));
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
            (Util.option_bind (Xml.member "AuthToken" xml) String.parse);
          transit_encryption_enabled =
            (Util.option_bind (Xml.member "TransitEncryptionEnabled" xml)
               Boolean.parse);
          at_rest_encryption_enabled =
            (Util.option_bind (Xml.member "AtRestEncryptionEnabled" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((([] @
                                       [Some
                                          (Ezxmlm.make_tag
                                             "ReplicationGroupId"
                                             ([],
                                               (String.to_xml
                                                  v.replication_group_id)))])
                                      @
                                      [Some
                                         (Ezxmlm.make_tag
                                            "ReplicationGroupDescription"
                                            ([],
                                              (String.to_xml
                                                 v.replication_group_description)))])
                                     @
                                     [Util.option_map v.primary_cluster_id
                                        (fun f ->
                                           Ezxmlm.make_tag "PrimaryClusterId"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map
                                       v.automatic_failover_enabled
                                       (fun f ->
                                          Ezxmlm.make_tag
                                            "AutomaticFailoverEnabled"
                                            ([], (Boolean.to_xml f)))])
                                   @
                                   [Util.option_map v.num_cache_clusters
                                      (fun f ->
                                         Ezxmlm.make_tag "NumCacheClusters"
                                           ([], (Integer.to_xml f)))])
                                  @
                                  (List.map
                                     (fun x ->
                                        Some
                                          (Ezxmlm.make_tag
                                             "PreferredCacheClusterAZs"
                                             ([],
                                               (AvailabilityZonesList.to_xml
                                                  [x]))))
                                     v.preferred_cache_cluster_a_zs))
                                 @
                                 [Util.option_map v.num_node_groups
                                    (fun f ->
                                       Ezxmlm.make_tag "NumNodeGroups"
                                         ([], (Integer.to_xml f)))])
                                @
                                [Util.option_map v.replicas_per_node_group
                                   (fun f ->
                                      Ezxmlm.make_tag "ReplicasPerNodeGroup"
                                        ([], (Integer.to_xml f)))])
                               @
                               (List.map
                                  (fun x ->
                                     Some
                                       (Ezxmlm.make_tag
                                          "NodeGroupConfiguration"
                                          ([],
                                            (NodeGroupConfigurationList.to_xml
                                               [x]))))
                                  v.node_group_configuration))
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
                      (fun f ->
                         Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
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
                 (fun f ->
                    Ezxmlm.make_tag "AuthToken" ([], (String.to_xml f)))])
             @
             [Util.option_map v.transit_encryption_enabled
                (fun f ->
                   Ezxmlm.make_tag "TransitEncryptionEnabled"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.at_rest_encryption_enabled
               (fun f ->
                  Ezxmlm.make_tag "AtRestEncryptionEnabled"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.kms_key_id
              (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>CreateReplicationGroup</code> operation.</p>"]
module CreateReplicationGroupResult = CreateReplicationGroupResult
type input = CreateReplicationGroupMessage.t
type output = CreateReplicationGroupResult.t
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
         ("Action", ["CreateReplicationGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateReplicationGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateReplicationGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateReplicationGroupResponse" (snd xml))
        (Xml.member "CreateReplicationGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateReplicationGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateReplicationGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateReplicationGroupResult - missing field in body or children: "
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