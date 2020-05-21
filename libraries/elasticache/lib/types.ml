open Aws
open Aws.BaseTypes
module NodeUpdateInitiatedBy =
  struct
    type t =
      | System 
      | Customer 
    let str_to_t = [("customer", Customer); ("system", System)]
    let t_to_str = [(Customer, "customer"); (System, "system")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module NodeUpdateStatus =
  struct
    type t =
      | Not_applied 
      | Waiting_to_start 
      | In_progress 
      | Stopping 
      | Stopped 
      | Complete 
    let str_to_t =
      [("complete", Complete);
      ("stopped", Stopped);
      ("stopping", Stopping);
      ("in-progress", In_progress);
      ("waiting-to-start", Waiting_to_start);
      ("not-applied", Not_applied)]
    let t_to_str =
      [(Complete, "complete");
      (Stopped, "stopped");
      (Stopping, "stopping");
      (In_progress, "in-progress");
      (Waiting_to_start, "waiting-to-start");
      (Not_applied, "not-applied")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module Endpoint =
  struct
    type t =
      {
      address: String.t option
        [@ocaml.doc "<p>The DNS hostname of the cache node.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number that the cache engine is listening on.</p>"]}
    [@@ocaml.doc
      "<p>Represents the information required for client programs to connect to a cache node.</p>"]
    let make ?address  ?port  () = { address; port }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.address
             (fun f -> ("address", (String.to_json f)))])
    let parse xml =
      Some
        {
          address =
            (Util.option_bind (Xml.member "Address" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.address
               (fun f -> Ezxmlm.make_tag "Address" ([], (String.to_xml f)))])
           @
           [Util.option_map v.port
              (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the information required for client programs to connect to a cache node.</p>"]
module AvailabilityZonesList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "AvailabilityZone" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module NodeGroupMemberUpdateStatus =
  struct
    type t =
      {
      cache_cluster_id: String.t option
        [@ocaml.doc "<p>The cache cluster ID</p>"];
      cache_node_id: String.t option
        [@ocaml.doc "<p>The node ID of the cache cluster</p>"];
      node_update_status: NodeUpdateStatus.t option
        [@ocaml.doc "<p>The update status of the node</p>"];
      node_deletion_date: DateTime.t option
        [@ocaml.doc "<p>The deletion date of the node</p>"];
      node_update_start_date: DateTime.t option
        [@ocaml.doc "<p>The start date of the update for a node</p>"];
      node_update_end_date: DateTime.t option
        [@ocaml.doc "<p>The end date of the update for a node</p>"];
      node_update_initiated_by: NodeUpdateInitiatedBy.t option
        [@ocaml.doc
          "<p>Reflects whether the update was initiated by the customer or automatically applied</p>"];
      node_update_initiated_date: DateTime.t option
        [@ocaml.doc "<p>The date when the update is triggered</p>"];
      node_update_status_modified_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when the NodeUpdateStatus was last modified</p>"]}
    [@@ocaml.doc
      "<p>The status of the service update on the node group member </p>"]
    let make ?cache_cluster_id  ?cache_node_id  ?node_update_status 
      ?node_deletion_date  ?node_update_start_date  ?node_update_end_date 
      ?node_update_initiated_by  ?node_update_initiated_date 
      ?node_update_status_modified_date  () =
      {
        cache_cluster_id;
        cache_node_id;
        node_update_status;
        node_deletion_date;
        node_update_start_date;
        node_update_end_date;
        node_update_initiated_by;
        node_update_initiated_date;
        node_update_status_modified_date
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.node_update_status_modified_date
              (fun f ->
                 ("node_update_status_modified_date", (DateTime.to_json f)));
           Util.option_map v.node_update_initiated_date
             (fun f -> ("node_update_initiated_date", (DateTime.to_json f)));
           Util.option_map v.node_update_initiated_by
             (fun f ->
                ("node_update_initiated_by",
                  (NodeUpdateInitiatedBy.to_json f)));
           Util.option_map v.node_update_end_date
             (fun f -> ("node_update_end_date", (DateTime.to_json f)));
           Util.option_map v.node_update_start_date
             (fun f -> ("node_update_start_date", (DateTime.to_json f)));
           Util.option_map v.node_deletion_date
             (fun f -> ("node_deletion_date", (DateTime.to_json f)));
           Util.option_map v.node_update_status
             (fun f -> ("node_update_status", (NodeUpdateStatus.to_json f)));
           Util.option_map v.cache_node_id
             (fun f -> ("cache_node_id", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          cache_node_id =
            (Util.option_bind (Xml.member "CacheNodeId" xml) String.parse);
          node_update_status =
            (Util.option_bind (Xml.member "NodeUpdateStatus" xml)
               NodeUpdateStatus.parse);
          node_deletion_date =
            (Util.option_bind (Xml.member "NodeDeletionDate" xml)
               DateTime.parse);
          node_update_start_date =
            (Util.option_bind (Xml.member "NodeUpdateStartDate" xml)
               DateTime.parse);
          node_update_end_date =
            (Util.option_bind (Xml.member "NodeUpdateEndDate" xml)
               DateTime.parse);
          node_update_initiated_by =
            (Util.option_bind (Xml.member "NodeUpdateInitiatedBy" xml)
               NodeUpdateInitiatedBy.parse);
          node_update_initiated_date =
            (Util.option_bind (Xml.member "NodeUpdateInitiatedDate" xml)
               DateTime.parse);
          node_update_status_modified_date =
            (Util.option_bind (Xml.member "NodeUpdateStatusModifiedDate" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.cache_cluster_id
                      (fun f ->
                         Ezxmlm.make_tag "CacheClusterId"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.cache_node_id
                     (fun f ->
                        Ezxmlm.make_tag "CacheNodeId" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.node_update_status
                    (fun f ->
                       Ezxmlm.make_tag "NodeUpdateStatus"
                         ([], (NodeUpdateStatus.to_xml f)))])
                @
                [Util.option_map v.node_deletion_date
                   (fun f ->
                      Ezxmlm.make_tag "NodeDeletionDate"
                        ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.node_update_start_date
                  (fun f ->
                     Ezxmlm.make_tag "NodeUpdateStartDate"
                       ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.node_update_end_date
                 (fun f ->
                    Ezxmlm.make_tag "NodeUpdateEndDate"
                      ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.node_update_initiated_by
                (fun f ->
                   Ezxmlm.make_tag "NodeUpdateInitiatedBy"
                     ([], (NodeUpdateInitiatedBy.to_xml f)))])
            @
            [Util.option_map v.node_update_initiated_date
               (fun f ->
                  Ezxmlm.make_tag "NodeUpdateInitiatedDate"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.node_update_status_modified_date
              (fun f ->
                 Ezxmlm.make_tag "NodeUpdateStatusModifiedDate"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>The status of the service update on the node group member </p>"]
module NodeGroupMember =
  struct
    type t =
      {
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>The ID of the cluster to which the node belongs.</p>"];
      cache_node_id: String.t option
        [@ocaml.doc
          "<p>The ID of the node within its cluster. A node ID is a numeric identifier (0001, 0002, etc.).</p>"];
      read_endpoint: Endpoint.t option
        [@ocaml.doc
          "<p>The information required for client programs to connect to a node for read operations. The read endpoint is only applicable on Redis (cluster mode disabled) clusters.</p>"];
      preferred_availability_zone: String.t option
        [@ocaml.doc
          "<p>The name of the Availability Zone in which the node is located.</p>"];
      current_role: String.t option
        [@ocaml.doc
          "<p>The role that is currently assigned to the node - <code>primary</code> or <code>replica</code>. This member is only applicable for Redis (cluster mode disabled) replication groups.</p>"]}
    [@@ocaml.doc
      "<p>Represents a single node within a node group (shard).</p>"]
    let make ?cache_cluster_id  ?cache_node_id  ?read_endpoint 
      ?preferred_availability_zone  ?current_role  () =
      {
        cache_cluster_id;
        cache_node_id;
        read_endpoint;
        preferred_availability_zone;
        current_role
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.current_role
              (fun f -> ("current_role", (String.to_json f)));
           Util.option_map v.preferred_availability_zone
             (fun f -> ("preferred_availability_zone", (String.to_json f)));
           Util.option_map v.read_endpoint
             (fun f -> ("read_endpoint", (Endpoint.to_json f)));
           Util.option_map v.cache_node_id
             (fun f -> ("cache_node_id", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          cache_node_id =
            (Util.option_bind (Xml.member "CacheNodeId" xml) String.parse);
          read_endpoint =
            (Util.option_bind (Xml.member "ReadEndpoint" xml) Endpoint.parse);
          preferred_availability_zone =
            (Util.option_bind (Xml.member "PreferredAvailabilityZone" xml)
               String.parse);
          current_role =
            (Util.option_bind (Xml.member "CurrentRole" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.cache_cluster_id
                  (fun f ->
                     Ezxmlm.make_tag "CacheClusterId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.cache_node_id
                 (fun f ->
                    Ezxmlm.make_tag "CacheNodeId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.read_endpoint
                (fun f ->
                   Ezxmlm.make_tag "ReadEndpoint" ([], (Endpoint.to_xml f)))])
            @
            [Util.option_map v.preferred_availability_zone
               (fun f ->
                  Ezxmlm.make_tag "PreferredAvailabilityZone"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.current_role
              (fun f -> Ezxmlm.make_tag "CurrentRole" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a single node within a node group (shard).</p>"]
module NodeGroupConfiguration =
  struct
    type t =
      {
      node_group_id: String.t option
        [@ocaml.doc
          "<p>Either the ElastiCache for Redis supplied 4-digit id or a user supplied id for the node group these configuration values apply to.</p>"];
      slots: String.t option
        [@ocaml.doc
          "<p>A string that specifies the keyspace for a particular node group. Keyspaces range from 0 to 16,383. The string is in the format <code>startkey-endkey</code>.</p> <p>Example: <code>\"0-3999\"</code> </p>"];
      replica_count: Integer.t option
        [@ocaml.doc
          "<p>The number of read replica nodes in this node group (shard).</p>"];
      primary_availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone where the primary node of this node group (shard) is launched.</p>"];
      replica_availability_zones: AvailabilityZonesList.t
        [@ocaml.doc
          "<p>A list of Availability Zones to be used for the read replicas. The number of Availability Zones in this list must match the value of <code>ReplicaCount</code> or <code>ReplicasPerNodeGroup</code> if not specified.</p>"]}
    [@@ocaml.doc
      "<p>Node group (shard) configuration options. Each node group (shard) configuration has the following: <code>Slots</code>, <code>PrimaryAvailabilityZone</code>, <code>ReplicaAvailabilityZones</code>, <code>ReplicaCount</code>.</p>"]
    let make ?node_group_id  ?slots  ?replica_count 
      ?primary_availability_zone  ?(replica_availability_zones= [])  () =
      {
        node_group_id;
        slots;
        replica_count;
        primary_availability_zone;
        replica_availability_zones
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("replica_availability_zones",
                (AvailabilityZonesList.to_json v.replica_availability_zones));
           Util.option_map v.primary_availability_zone
             (fun f -> ("primary_availability_zone", (String.to_json f)));
           Util.option_map v.replica_count
             (fun f -> ("replica_count", (Integer.to_json f)));
           Util.option_map v.slots (fun f -> ("slots", (String.to_json f)));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          node_group_id =
            (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse);
          slots = (Util.option_bind (Xml.member "Slots" xml) String.parse);
          replica_count =
            (Util.option_bind (Xml.member "ReplicaCount" xml) Integer.parse);
          primary_availability_zone =
            (Util.option_bind (Xml.member "PrimaryAvailabilityZone" xml)
               String.parse);
          replica_availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicaAvailabilityZones" xml)
                  AvailabilityZonesList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.node_group_id
                  (fun f ->
                     Ezxmlm.make_tag "NodeGroupId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.slots
                 (fun f -> Ezxmlm.make_tag "Slots" ([], (String.to_xml f)))])
             @
             [Util.option_map v.replica_count
                (fun f ->
                   Ezxmlm.make_tag "ReplicaCount" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.primary_availability_zone
               (fun f ->
                  Ezxmlm.make_tag "PrimaryAvailabilityZone"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ReplicaAvailabilityZones"
                      ([], (AvailabilityZonesList.to_xml [x]))))
              v.replica_availability_zones))
  end[@@ocaml.doc
       "<p>Node group (shard) configuration options. Each node group (shard) configuration has the following: <code>Slots</code>, <code>PrimaryAvailabilityZone</code>, <code>ReplicaAvailabilityZones</code>, <code>ReplicaCount</code>.</p>"]
module AvailabilityZone =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Availability Zone.</p>"]}[@@ocaml.doc
                                                                   "<p>Describes an Availability Zone in which the cluster is launched.</p>"]
    let make ?name  () = { name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some { name = (Util.option_bind (Xml.member "Name" xml) String.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.name
              (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an Availability Zone in which the cluster is launched.</p>"]
module CacheNodeTypeSpecificValue =
  struct
    type t =
      {
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The cache node type for which this value applies.</p>"];
      value: String.t option
        [@ocaml.doc "<p>The value for the cache node type.</p>"]}[@@ocaml.doc
                                                                   "<p>A value that applies only to a certain cache node type.</p>"]
    let make ?cache_node_type  ?value  () = { cache_node_type; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.cache_node_type
               (fun f ->
                  Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A value that applies only to a certain cache node type.</p>"]
module NodeGroupMemberUpdateStatusList =
  struct
    type t = NodeGroupMemberUpdateStatus.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list NodeGroupMemberUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list NodeGroupMemberUpdateStatus.to_headers v
    let to_json v = `List (List.map NodeGroupMemberUpdateStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map NodeGroupMemberUpdateStatus.parse
           (Xml.members "NodeGroupMemberUpdateStatus" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (NodeGroupMemberUpdateStatus.to_xml x))) v
  end
module NodeGroupMemberList =
  struct
    type t = NodeGroupMember.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NodeGroupMember.to_query v
    let to_headers v = Headers.to_headers_list NodeGroupMember.to_headers v
    let to_json v = `List (List.map NodeGroupMember.to_json v)
    let parse xml =
      Util.option_all
        (List.map NodeGroupMember.parse (Xml.members "NodeGroupMember" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (NodeGroupMember.to_xml x)))
        v
  end
module SlotMigration =
  struct
    type t =
      {
      progress_percentage: Double.t option
        [@ocaml.doc
          "<p>The percentage of the slot migration that is complete.</p>"]}
    [@@ocaml.doc
      "<p>Represents the progress of an online resharding operation.</p>"]
    let make ?progress_percentage  () = { progress_percentage }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.progress_percentage
              (fun f -> ("progress_percentage", (Double.to_json f)))])
    let parse xml =
      Some
        {
          progress_percentage =
            (Util.option_bind (Xml.member "ProgressPercentage" xml)
               Double.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.progress_percentage
              (fun f ->
                 Ezxmlm.make_tag "ProgressPercentage" ([], (Double.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the progress of an online resharding operation.</p>"]
module RecurringCharge =
  struct
    type t =
      {
      recurring_charge_amount: Double.t option
        [@ocaml.doc "<p>The monetary amount of the recurring charge.</p>"];
      recurring_charge_frequency: String.t option
        [@ocaml.doc "<p>The frequency of the recurring charge.</p>"]}
    [@@ocaml.doc
      "<p>Contains the specific price and frequency of a recurring charges for a reserved cache node, or for a reserved cache node offering.</p>"]
    let make ?recurring_charge_amount  ?recurring_charge_frequency  () =
      { recurring_charge_amount; recurring_charge_frequency }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.recurring_charge_frequency
              (fun f -> ("recurring_charge_frequency", (String.to_json f)));
           Util.option_map v.recurring_charge_amount
             (fun f -> ("recurring_charge_amount", (Double.to_json f)))])
    let parse xml =
      Some
        {
          recurring_charge_amount =
            (Util.option_bind (Xml.member "RecurringChargeAmount" xml)
               Double.parse);
          recurring_charge_frequency =
            (Util.option_bind (Xml.member "RecurringChargeFrequency" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.recurring_charge_amount
               (fun f ->
                  Ezxmlm.make_tag "RecurringChargeAmount"
                    ([], (Double.to_xml f)))])
           @
           [Util.option_map v.recurring_charge_frequency
              (fun f ->
                 Ezxmlm.make_tag "RecurringChargeFrequency"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the specific price and frequency of a recurring charges for a reserved cache node, or for a reserved cache node offering.</p>"]
module NodeSnapshot =
  struct
    type t =
      {
      cache_cluster_id: String.t option
        [@ocaml.doc "<p>A unique identifier for the source cluster.</p>"];
      node_group_id: String.t option
        [@ocaml.doc
          "<p>A unique identifier for the source node group (shard).</p>"];
      cache_node_id: String.t option
        [@ocaml.doc
          "<p>The cache node identifier for the node in the source cluster.</p>"];
      node_group_configuration: NodeGroupConfiguration.t option
        [@ocaml.doc
          "<p>The configuration for the source node group (shard).</p>"];
      cache_size: String.t option
        [@ocaml.doc "<p>The size of the cache on the source cache node.</p>"];
      cache_node_create_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the cache node was created in the source cluster.</p>"];
      snapshot_create_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the source node's metadata and cache data set was obtained for the snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Represents an individual cache node in a snapshot of a cluster.</p>"]
    let make ?cache_cluster_id  ?node_group_id  ?cache_node_id 
      ?node_group_configuration  ?cache_size  ?cache_node_create_time 
      ?snapshot_create_time  () =
      {
        cache_cluster_id;
        node_group_id;
        cache_node_id;
        node_group_configuration;
        cache_size;
        cache_node_create_time;
        snapshot_create_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot_create_time
              (fun f -> ("snapshot_create_time", (DateTime.to_json f)));
           Util.option_map v.cache_node_create_time
             (fun f -> ("cache_node_create_time", (DateTime.to_json f)));
           Util.option_map v.cache_size
             (fun f -> ("cache_size", (String.to_json f)));
           Util.option_map v.node_group_configuration
             (fun f ->
                ("node_group_configuration",
                  (NodeGroupConfiguration.to_json f)));
           Util.option_map v.cache_node_id
             (fun f -> ("cache_node_id", (String.to_json f)));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          node_group_id =
            (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse);
          cache_node_id =
            (Util.option_bind (Xml.member "CacheNodeId" xml) String.parse);
          node_group_configuration =
            (Util.option_bind (Xml.member "NodeGroupConfiguration" xml)
               NodeGroupConfiguration.parse);
          cache_size =
            (Util.option_bind (Xml.member "CacheSize" xml) String.parse);
          cache_node_create_time =
            (Util.option_bind (Xml.member "CacheNodeCreateTime" xml)
               DateTime.parse);
          snapshot_create_time =
            (Util.option_bind (Xml.member "SnapshotCreateTime" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.cache_cluster_id
                    (fun f ->
                       Ezxmlm.make_tag "CacheClusterId"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.node_group_id
                   (fun f ->
                      Ezxmlm.make_tag "NodeGroupId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.cache_node_id
                  (fun f ->
                     Ezxmlm.make_tag "CacheNodeId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.node_group_configuration
                 (fun f ->
                    Ezxmlm.make_tag "NodeGroupConfiguration"
                      ([], (NodeGroupConfiguration.to_xml f)))])
             @
             [Util.option_map v.cache_size
                (fun f -> Ezxmlm.make_tag "CacheSize" ([], (String.to_xml f)))])
            @
            [Util.option_map v.cache_node_create_time
               (fun f ->
                  Ezxmlm.make_tag "CacheNodeCreateTime"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.snapshot_create_time
              (fun f ->
                 Ezxmlm.make_tag "SnapshotCreateTime"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents an individual cache node in a snapshot of a cluster.</p>"]
module Subnet =
  struct
    type t =
      {
      subnet_identifier: String.t option
        [@ocaml.doc "<p>The unique identifier for the subnet.</p>"];
      subnet_availability_zone: AvailabilityZone.t option
        [@ocaml.doc
          "<p>The Availability Zone associated with the subnet.</p>"]}
    [@@ocaml.doc
      "<p>Represents the subnet associated with a cluster. This parameter refers to subnets defined in Amazon Virtual Private Cloud (Amazon VPC) and used with ElastiCache.</p>"]
    let make ?subnet_identifier  ?subnet_availability_zone  () =
      { subnet_identifier; subnet_availability_zone }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.subnet_availability_zone
              (fun f ->
                 ("subnet_availability_zone", (AvailabilityZone.to_json f)));
           Util.option_map v.subnet_identifier
             (fun f -> ("subnet_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          subnet_identifier =
            (Util.option_bind (Xml.member "SubnetIdentifier" xml)
               String.parse);
          subnet_availability_zone =
            (Util.option_bind (Xml.member "SubnetAvailabilityZone" xml)
               AvailabilityZone.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.subnet_identifier
               (fun f ->
                  Ezxmlm.make_tag "SubnetIdentifier" ([], (String.to_xml f)))])
           @
           [Util.option_map v.subnet_availability_zone
              (fun f ->
                 Ezxmlm.make_tag "SubnetAvailabilityZone"
                   ([], (AvailabilityZone.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the subnet associated with a cluster. This parameter refers to subnets defined in Amazon Virtual Private Cloud (Amazon VPC) and used with ElastiCache.</p>"]
module CacheNode =
  struct
    type t =
      {
      cache_node_id: String.t option
        [@ocaml.doc
          "<p>The cache node identifier. A node ID is a numeric identifier (0001, 0002, etc.). The combination of cluster ID and node ID uniquely identifies every cache node used in a customer's AWS account.</p>"];
      cache_node_status: String.t option
        [@ocaml.doc "<p>The current state of this cache node.</p>"];
      cache_node_create_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the cache node was created.</p>"];
      endpoint: Endpoint.t option
        [@ocaml.doc "<p>The hostname for connecting to this cache node.</p>"];
      parameter_group_status: String.t option
        [@ocaml.doc
          "<p>The status of the parameter group applied to this cache node.</p>"];
      source_cache_node_id: String.t option
        [@ocaml.doc
          "<p>The ID of the primary node to which this read replica node is synchronized. If this field is empty, this node is not associated with a primary cluster.</p>"];
      customer_availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone where this node was created and now resides.</p>"]}
    [@@ocaml.doc
      "<p>Represents an individual cache node within a cluster. Each cache node runs its own instance of the cluster's protocol-compliant caching software - either Memcached or Redis.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"]
    let make ?cache_node_id  ?cache_node_status  ?cache_node_create_time 
      ?endpoint  ?parameter_group_status  ?source_cache_node_id 
      ?customer_availability_zone  () =
      {
        cache_node_id;
        cache_node_status;
        cache_node_create_time;
        endpoint;
        parameter_group_status;
        source_cache_node_id;
        customer_availability_zone
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.customer_availability_zone
              (fun f -> ("customer_availability_zone", (String.to_json f)));
           Util.option_map v.source_cache_node_id
             (fun f -> ("source_cache_node_id", (String.to_json f)));
           Util.option_map v.parameter_group_status
             (fun f -> ("parameter_group_status", (String.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (Endpoint.to_json f)));
           Util.option_map v.cache_node_create_time
             (fun f -> ("cache_node_create_time", (DateTime.to_json f)));
           Util.option_map v.cache_node_status
             (fun f -> ("cache_node_status", (String.to_json f)));
           Util.option_map v.cache_node_id
             (fun f -> ("cache_node_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_node_id =
            (Util.option_bind (Xml.member "CacheNodeId" xml) String.parse);
          cache_node_status =
            (Util.option_bind (Xml.member "CacheNodeStatus" xml) String.parse);
          cache_node_create_time =
            (Util.option_bind (Xml.member "CacheNodeCreateTime" xml)
               DateTime.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) Endpoint.parse);
          parameter_group_status =
            (Util.option_bind (Xml.member "ParameterGroupStatus" xml)
               String.parse);
          source_cache_node_id =
            (Util.option_bind (Xml.member "SourceCacheNodeId" xml)
               String.parse);
          customer_availability_zone =
            (Util.option_bind (Xml.member "CustomerAvailabilityZone" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.cache_node_id
                    (fun f ->
                       Ezxmlm.make_tag "CacheNodeId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.cache_node_status
                   (fun f ->
                      Ezxmlm.make_tag "CacheNodeStatus"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.cache_node_create_time
                  (fun f ->
                     Ezxmlm.make_tag "CacheNodeCreateTime"
                       ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.endpoint
                 (fun f ->
                    Ezxmlm.make_tag "Endpoint" ([], (Endpoint.to_xml f)))])
             @
             [Util.option_map v.parameter_group_status
                (fun f ->
                   Ezxmlm.make_tag "ParameterGroupStatus"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.source_cache_node_id
               (fun f ->
                  Ezxmlm.make_tag "SourceCacheNodeId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.customer_availability_zone
              (fun f ->
                 Ezxmlm.make_tag "CustomerAvailabilityZone"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents an individual cache node within a cluster. Each cache node runs its own instance of the cluster's protocol-compliant caching software - either Memcached or Redis.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"]
module CacheNodeIdsList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "CacheNodeId" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module CacheSecurityGroupMembership =
  struct
    type t =
      {
      cache_security_group_name: String.t option
        [@ocaml.doc "<p>The name of the cache security group.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The membership status in the cache security group. The status changes when a cache security group is modified, or when the cache security groups assigned to a cluster are modified.</p>"]}
    [@@ocaml.doc
      "<p>Represents a cluster's status within a particular cache security group.</p>"]
    let make ?cache_security_group_name  ?status  () =
      { cache_security_group_name; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.cache_security_group_name
             (fun f -> ("cache_security_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.cache_security_group_name
               (fun f ->
                  Ezxmlm.make_tag "CacheSecurityGroupName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a cluster's status within a particular cache security group.</p>"]
module AuthTokenUpdateStatus =
  struct
    type t =
      | SETTING 
      | ROTATING 
    let str_to_t = [("ROTATING", ROTATING); ("SETTING", SETTING)]
    let t_to_str = [(ROTATING, "ROTATING"); (SETTING, "SETTING")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module SecurityGroupMembership =
  struct
    type t =
      {
      security_group_id: String.t option
        [@ocaml.doc "<p>The identifier of the cache security group.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the cache security group membership. The status changes whenever a cache security group is modified, or when the cache security groups assigned to a cluster are modified.</p>"]}
    [@@ocaml.doc
      "<p>Represents a single cache security group and its status.</p>"]
    let make ?security_group_id  ?status  () = { security_group_id; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.security_group_id
             (fun f -> ("security_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          security_group_id =
            (Util.option_bind (Xml.member "SecurityGroupId" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.security_group_id
               (fun f ->
                  Ezxmlm.make_tag "SecurityGroupId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a single cache security group and its status.</p>"]
module CacheNodeTypeSpecificValueList =
  struct
    type t = CacheNodeTypeSpecificValue.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list CacheNodeTypeSpecificValue.to_query v
    let to_headers v =
      Headers.to_headers_list CacheNodeTypeSpecificValue.to_headers v
    let to_json v = `List (List.map CacheNodeTypeSpecificValue.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheNodeTypeSpecificValue.parse
           (Xml.members "CacheNodeTypeSpecificValue" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (CacheNodeTypeSpecificValue.to_xml x))) v
  end
module ChangeType =
  struct
    type t =
      | Immediate 
      | Requires_reboot 
    let str_to_t =
      [("requires-reboot", Requires_reboot); ("immediate", Immediate)]
    let t_to_str =
      [(Requires_reboot, "requires-reboot"); (Immediate, "immediate")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module CacheNodeUpdateStatus =
  struct
    type t =
      {
      cache_node_id: String.t option
        [@ocaml.doc "<p>The node ID of the cache cluster</p>"];
      node_update_status: NodeUpdateStatus.t option
        [@ocaml.doc "<p>The update status of the node</p>"];
      node_deletion_date: DateTime.t option
        [@ocaml.doc "<p>The deletion date of the node</p>"];
      node_update_start_date: DateTime.t option
        [@ocaml.doc "<p>The start date of the update for a node</p>"];
      node_update_end_date: DateTime.t option
        [@ocaml.doc "<p>The end date of the update for a node</p>"];
      node_update_initiated_by: NodeUpdateInitiatedBy.t option
        [@ocaml.doc
          "<p>Reflects whether the update was initiated by the customer or automatically applied</p>"];
      node_update_initiated_date: DateTime.t option
        [@ocaml.doc "<p>The date when the update is triggered</p>"];
      node_update_status_modified_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when the NodeUpdateStatus was last modified&gt;</p>"]}
    [@@ocaml.doc "<p>The status of the service update on the cache node</p>"]
    let make ?cache_node_id  ?node_update_status  ?node_deletion_date 
      ?node_update_start_date  ?node_update_end_date 
      ?node_update_initiated_by  ?node_update_initiated_date 
      ?node_update_status_modified_date  () =
      {
        cache_node_id;
        node_update_status;
        node_deletion_date;
        node_update_start_date;
        node_update_end_date;
        node_update_initiated_by;
        node_update_initiated_date;
        node_update_status_modified_date
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.node_update_status_modified_date
              (fun f ->
                 ("node_update_status_modified_date", (DateTime.to_json f)));
           Util.option_map v.node_update_initiated_date
             (fun f -> ("node_update_initiated_date", (DateTime.to_json f)));
           Util.option_map v.node_update_initiated_by
             (fun f ->
                ("node_update_initiated_by",
                  (NodeUpdateInitiatedBy.to_json f)));
           Util.option_map v.node_update_end_date
             (fun f -> ("node_update_end_date", (DateTime.to_json f)));
           Util.option_map v.node_update_start_date
             (fun f -> ("node_update_start_date", (DateTime.to_json f)));
           Util.option_map v.node_deletion_date
             (fun f -> ("node_deletion_date", (DateTime.to_json f)));
           Util.option_map v.node_update_status
             (fun f -> ("node_update_status", (NodeUpdateStatus.to_json f)));
           Util.option_map v.cache_node_id
             (fun f -> ("cache_node_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_node_id =
            (Util.option_bind (Xml.member "CacheNodeId" xml) String.parse);
          node_update_status =
            (Util.option_bind (Xml.member "NodeUpdateStatus" xml)
               NodeUpdateStatus.parse);
          node_deletion_date =
            (Util.option_bind (Xml.member "NodeDeletionDate" xml)
               DateTime.parse);
          node_update_start_date =
            (Util.option_bind (Xml.member "NodeUpdateStartDate" xml)
               DateTime.parse);
          node_update_end_date =
            (Util.option_bind (Xml.member "NodeUpdateEndDate" xml)
               DateTime.parse);
          node_update_initiated_by =
            (Util.option_bind (Xml.member "NodeUpdateInitiatedBy" xml)
               NodeUpdateInitiatedBy.parse);
          node_update_initiated_date =
            (Util.option_bind (Xml.member "NodeUpdateInitiatedDate" xml)
               DateTime.parse);
          node_update_status_modified_date =
            (Util.option_bind (Xml.member "NodeUpdateStatusModifiedDate" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.cache_node_id
                     (fun f ->
                        Ezxmlm.make_tag "CacheNodeId" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.node_update_status
                    (fun f ->
                       Ezxmlm.make_tag "NodeUpdateStatus"
                         ([], (NodeUpdateStatus.to_xml f)))])
                @
                [Util.option_map v.node_deletion_date
                   (fun f ->
                      Ezxmlm.make_tag "NodeDeletionDate"
                        ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.node_update_start_date
                  (fun f ->
                     Ezxmlm.make_tag "NodeUpdateStartDate"
                       ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.node_update_end_date
                 (fun f ->
                    Ezxmlm.make_tag "NodeUpdateEndDate"
                      ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.node_update_initiated_by
                (fun f ->
                   Ezxmlm.make_tag "NodeUpdateInitiatedBy"
                     ([], (NodeUpdateInitiatedBy.to_xml f)))])
            @
            [Util.option_map v.node_update_initiated_date
               (fun f ->
                  Ezxmlm.make_tag "NodeUpdateInitiatedDate"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.node_update_status_modified_date
              (fun f ->
                 Ezxmlm.make_tag "NodeUpdateStatusModifiedDate"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>The status of the service update on the cache node</p>"]
module NodeGroupUpdateStatus =
  struct
    type t =
      {
      node_group_id: String.t option
        [@ocaml.doc "<p>The ID of the node group</p>"];
      node_group_member_update_status: NodeGroupMemberUpdateStatusList.t
        [@ocaml.doc
          "<p>The status of the service update on the node group member</p>"]}
    [@@ocaml.doc
      "<p>The status of the service update on the node group </p>"]
    let make ?node_group_id  ?(node_group_member_update_status= [])  () =
      { node_group_id; node_group_member_update_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("node_group_member_update_status",
                (NodeGroupMemberUpdateStatusList.to_json
                   v.node_group_member_update_status));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          node_group_id =
            (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse);
          node_group_member_update_status =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "NodeGroupMemberUpdateStatus" xml)
                  NodeGroupMemberUpdateStatusList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.node_group_id
               (fun f ->
                  Ezxmlm.make_tag "NodeGroupId" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "NodeGroupMemberUpdateStatus"
                      ([], (NodeGroupMemberUpdateStatusList.to_xml [x]))))
              v.node_group_member_update_status))
  end[@@ocaml.doc
       "<p>The status of the service update on the node group </p>"]
module NodeGroup =
  struct
    type t =
      {
      node_group_id: String.t option
        [@ocaml.doc
          "<p>The identifier for the node group (shard). A Redis (cluster mode disabled) replication group contains only 1 node group; therefore, the node group ID is 0001. A Redis (cluster mode enabled) replication group contains 1 to 90 node groups numbered 0001 to 0090. Optionally, the user can provide the id for a node group. </p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The current state of this replication group - <code>creating</code>, <code>available</code>, etc.</p>"];
      primary_endpoint: Endpoint.t option
        [@ocaml.doc
          "<p>The endpoint of the primary node in this node group (shard).</p>"];
      reader_endpoint: Endpoint.t option
        [@ocaml.doc
          "<p>The endpoint of the replica nodes in this node group (shard).</p>"];
      slots: String.t option
        [@ocaml.doc "<p>The keyspace for this node group (shard).</p>"];
      node_group_members: NodeGroupMemberList.t
        [@ocaml.doc
          "<p>A list containing information about individual nodes within the node group (shard).</p>"]}
    [@@ocaml.doc
      "<p>Represents a collection of cache nodes in a replication group. One node in the node group is the read/write primary node. All the other nodes are read-only Replica nodes.</p>"]
    let make ?node_group_id  ?status  ?primary_endpoint  ?reader_endpoint 
      ?slots  ?(node_group_members= [])  () =
      {
        node_group_id;
        status;
        primary_endpoint;
        reader_endpoint;
        slots;
        node_group_members
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("node_group_members",
                (NodeGroupMemberList.to_json v.node_group_members));
           Util.option_map v.slots (fun f -> ("slots", (String.to_json f)));
           Util.option_map v.reader_endpoint
             (fun f -> ("reader_endpoint", (Endpoint.to_json f)));
           Util.option_map v.primary_endpoint
             (fun f -> ("primary_endpoint", (Endpoint.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          node_group_id =
            (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          primary_endpoint =
            (Util.option_bind (Xml.member "PrimaryEndpoint" xml)
               Endpoint.parse);
          reader_endpoint =
            (Util.option_bind (Xml.member "ReaderEndpoint" xml)
               Endpoint.parse);
          slots = (Util.option_bind (Xml.member "Slots" xml) String.parse);
          node_group_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeGroupMembers" xml)
                  NodeGroupMemberList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.node_group_id
                   (fun f ->
                      Ezxmlm.make_tag "NodeGroupId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.status
                  (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
              @
              [Util.option_map v.primary_endpoint
                 (fun f ->
                    Ezxmlm.make_tag "PrimaryEndpoint"
                      ([], (Endpoint.to_xml f)))])
             @
             [Util.option_map v.reader_endpoint
                (fun f ->
                   Ezxmlm.make_tag "ReaderEndpoint" ([], (Endpoint.to_xml f)))])
            @
            [Util.option_map v.slots
               (fun f -> Ezxmlm.make_tag "Slots" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "NodeGroupMembers"
                      ([], (NodeGroupMemberList.to_xml [x]))))
              v.node_group_members))
  end[@@ocaml.doc
       "<p>Represents a collection of cache nodes in a replication group. One node in the node group is the read/write primary node. All the other nodes are read-only Replica nodes.</p>"]
module PendingAutomaticFailoverStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("disabled", Disabled); ("enabled", Enabled)]
    let t_to_str = [(Disabled, "disabled"); (Enabled, "enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ReshardingStatus =
  struct
    type t =
      {
      slot_migration: SlotMigration.t option
        [@ocaml.doc
          "<p>Represents the progress of an online resharding operation.</p>"]}
    [@@ocaml.doc "<p>The status of an online resharding operation.</p>"]
    let make ?slot_migration  () = { slot_migration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.slot_migration
              (fun f -> ("slot_migration", (SlotMigration.to_json f)))])
    let parse xml =
      Some
        {
          slot_migration =
            (Util.option_bind (Xml.member "SlotMigration" xml)
               SlotMigration.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.slot_migration
              (fun f ->
                 Ezxmlm.make_tag "SlotMigration"
                   ([], (SlotMigration.to_xml f)))])
  end[@@ocaml.doc "<p>The status of an online resharding operation.</p>"]
module EC2SecurityGroup =
  struct
    type t =
      {
      status: String.t option
        [@ocaml.doc "<p>The status of the Amazon EC2 security group.</p>"];
      e_c2_security_group_name: String.t option
        [@ocaml.doc "<p>The name of the Amazon EC2 security group.</p>"];
      e_c2_security_group_owner_id: String.t option
        [@ocaml.doc
          "<p>The AWS account ID of the Amazon EC2 security group owner.</p>"]}
    [@@ocaml.doc
      "<p>Provides ownership and status information for an Amazon EC2 security group.</p>"]
    let make ?status  ?e_c2_security_group_name 
      ?e_c2_security_group_owner_id  () =
      { status; e_c2_security_group_name; e_c2_security_group_owner_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f -> ("e_c2_security_group_owner_id", (String.to_json f)));
           Util.option_map v.e_c2_security_group_name
             (fun f -> ("e_c2_security_group_name", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)))])
    let parse xml =
      Some
        {
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          e_c2_security_group_name =
            (Util.option_bind (Xml.member "EC2SecurityGroupName" xml)
               String.parse);
          e_c2_security_group_owner_id =
            (Util.option_bind (Xml.member "EC2SecurityGroupOwnerId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.status
                (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
            @
            [Util.option_map v.e_c2_security_group_name
               (fun f ->
                  Ezxmlm.make_tag "EC2SecurityGroupName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f ->
                 Ezxmlm.make_tag "EC2SecurityGroupOwnerId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Provides ownership and status information for an Amazon EC2 security group.</p>"]
module RecurringChargeList =
  struct
    type t = RecurringCharge.t list
    let make elems () = elems
    let to_query v = Query.to_query_list RecurringCharge.to_query v
    let to_headers v = Headers.to_headers_list RecurringCharge.to_headers v
    let to_json v = `List (List.map RecurringCharge.to_json v)
    let parse xml =
      Util.option_all
        (List.map RecurringCharge.parse (Xml.members "RecurringCharge" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (RecurringCharge.to_xml x)))
        v
  end
module AutomaticFailoverStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
      | Enabling 
      | Disabling 
    let str_to_t =
      [("disabling", Disabling);
      ("enabling", Enabling);
      ("disabled", Disabled);
      ("enabled", Enabled)]
    let t_to_str =
      [(Disabling, "disabling");
      (Enabling, "enabling");
      (Disabled, "disabled");
      (Enabled, "enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module NodeSnapshotList =
  struct
    type t = NodeSnapshot.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NodeSnapshot.to_query v
    let to_headers v = Headers.to_headers_list NodeSnapshot.to_headers v
    let to_json v = `List (List.map NodeSnapshot.to_json v)
    let parse xml =
      Util.option_all
        (List.map NodeSnapshot.parse (Xml.members "NodeSnapshot" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (NodeSnapshot.to_xml x))) v
  end
module ServiceUpdateSeverity =
  struct
    type t =
      | Critical 
      | Important 
      | Medium 
      | Low 
    let str_to_t =
      [("low", Low);
      ("medium", Medium);
      ("important", Important);
      ("critical", Critical)]
    let t_to_str =
      [(Low, "low");
      (Medium, "medium");
      (Important, "important");
      (Critical, "critical")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ServiceUpdateStatus =
  struct
    type t =
      | Available 
      | Cancelled 
      | Expired 
    let str_to_t =
      [("expired", Expired);
      ("cancelled", Cancelled);
      ("available", Available)]
    let t_to_str =
      [(Expired, "expired");
      (Cancelled, "cancelled");
      (Available, "available")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ServiceUpdateType =
  struct
    type t =
      | Security_update 
    let str_to_t = [("security-update", Security_update)]
    let t_to_str = [(Security_update, "security-update")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module SubnetList =
  struct
    type t = Subnet.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Subnet.to_query v
    let to_headers v = Headers.to_headers_list Subnet.to_headers v
    let to_json v = `List (List.map Subnet.to_json v)
    let parse xml =
      Util.option_all (List.map Subnet.parse (Xml.members "Subnet" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Subnet.to_xml x))) v
  end
module PreferredAvailabilityZoneList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "PreferredAvailabilityZone" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module CacheNodeList =
  struct
    type t = CacheNode.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheNode.to_query v
    let to_headers v = Headers.to_headers_list CacheNode.to_headers v
    let to_json v = `List (List.map CacheNode.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheNode.parse (Xml.members "CacheNode" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (CacheNode.to_xml x)))
        v
  end
module CacheParameterGroupStatus =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option
        [@ocaml.doc "<p>The name of the cache parameter group.</p>"];
      parameter_apply_status: String.t option
        [@ocaml.doc "<p>The status of parameter updates.</p>"];
      cache_node_ids_to_reboot: CacheNodeIdsList.t
        [@ocaml.doc
          "<p>A list of the cache node IDs which need to be rebooted for parameter changes to be applied. A node ID is a numeric identifier (0001, 0002, etc.).</p>"]}
    [@@ocaml.doc "<p>Status of the cache parameter group.</p>"]
    let make ?cache_parameter_group_name  ?parameter_apply_status 
      ?(cache_node_ids_to_reboot= [])  () =
      {
        cache_parameter_group_name;
        parameter_apply_status;
        cache_node_ids_to_reboot
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_node_ids_to_reboot",
                (CacheNodeIdsList.to_json v.cache_node_ids_to_reboot));
           Util.option_map v.parameter_apply_status
             (fun f -> ("parameter_apply_status", (String.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          parameter_apply_status =
            (Util.option_bind (Xml.member "ParameterApplyStatus" xml)
               String.parse);
          cache_node_ids_to_reboot =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheNodeIdsToReboot" xml)
                  CacheNodeIdsList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cache_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.parameter_apply_status
               (fun f ->
                  Ezxmlm.make_tag "ParameterApplyStatus"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheNodeIdsToReboot"
                      ([], (CacheNodeIdsList.to_xml [x]))))
              v.cache_node_ids_to_reboot))
  end[@@ocaml.doc "<p>Status of the cache parameter group.</p>"]
module CacheSecurityGroupMembershipList =
  struct
    type t = CacheSecurityGroupMembership.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list CacheSecurityGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list CacheSecurityGroupMembership.to_headers v
    let to_json v = `List (List.map CacheSecurityGroupMembership.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheSecurityGroupMembership.parse
           (Xml.members "CacheSecurityGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (CacheSecurityGroupMembership.to_xml x))) v
  end
module NotificationConfiguration =
  struct
    type t =
      {
      topic_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) that identifies the topic.</p>"];
      topic_status: String.t option
        [@ocaml.doc "<p>The current state of the topic.</p>"]}[@@ocaml.doc
                                                                "<p>Describes a notification topic and its status. Notification topics are used for publishing ElastiCache events to subscribers using Amazon Simple Notification Service (SNS).</p>"]
    let make ?topic_arn  ?topic_status  () = { topic_arn; topic_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.topic_status
              (fun f -> ("topic_status", (String.to_json f)));
           Util.option_map v.topic_arn
             (fun f -> ("topic_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          topic_arn =
            (Util.option_bind (Xml.member "TopicArn" xml) String.parse);
          topic_status =
            (Util.option_bind (Xml.member "TopicStatus" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.topic_arn
               (fun f -> Ezxmlm.make_tag "TopicArn" ([], (String.to_xml f)))])
           @
           [Util.option_map v.topic_status
              (fun f -> Ezxmlm.make_tag "TopicStatus" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a notification topic and its status. Notification topics are used for publishing ElastiCache events to subscribers using Amazon Simple Notification Service (SNS).</p>"]
module PendingModifiedValues =
  struct
    type t =
      {
      num_cache_nodes: Integer.t option
        [@ocaml.doc
          "<p>The new number of cache nodes for the cluster.</p> <p>For clusters running Redis, this value must be 1. For clusters running Memcached, this value must be between 1 and 20.</p>"];
      cache_node_ids_to_remove: CacheNodeIdsList.t
        [@ocaml.doc
          "<p>A list of cache node IDs that are being removed (or will be removed) from the cluster. A node ID is a 4-digit numeric identifier (0001, 0002, etc.).</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The new cache engine version that the cluster runs.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The cache node type that this cluster or replication group is scaled to.</p>"];
      auth_token_status: AuthTokenUpdateStatus.t option
        [@ocaml.doc "<p>The auth token status</p>"]}[@@ocaml.doc
                                                      "<p>A group of settings that are applied to the cluster in the future, or that are currently being applied.</p>"]
    let make ?num_cache_nodes  ?(cache_node_ids_to_remove= []) 
      ?engine_version  ?cache_node_type  ?auth_token_status  () =
      {
        num_cache_nodes;
        cache_node_ids_to_remove;
        engine_version;
        cache_node_type;
        auth_token_status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.auth_token_status
              (fun f ->
                 ("auth_token_status", (AuthTokenUpdateStatus.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Some
             ("cache_node_ids_to_remove",
               (CacheNodeIdsList.to_json v.cache_node_ids_to_remove));
           Util.option_map v.num_cache_nodes
             (fun f -> ("num_cache_nodes", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          num_cache_nodes =
            (Util.option_bind (Xml.member "NumCacheNodes" xml) Integer.parse);
          cache_node_ids_to_remove =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheNodeIdsToRemove" xml)
                  CacheNodeIdsList.parse));
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          auth_token_status =
            (Util.option_bind (Xml.member "AuthTokenStatus" xml)
               AuthTokenUpdateStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.num_cache_nodes
                  (fun f ->
                     Ezxmlm.make_tag "NumCacheNodes" ([], (Integer.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "CacheNodeIdsToRemove"
                         ([], (CacheNodeIdsList.to_xml [x]))))
                 v.cache_node_ids_to_remove))
             @
             [Util.option_map v.engine_version
                (fun f ->
                   Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
            @
            [Util.option_map v.cache_node_type
               (fun f ->
                  Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
           @
           [Util.option_map v.auth_token_status
              (fun f ->
                 Ezxmlm.make_tag "AuthTokenStatus"
                   ([], (AuthTokenUpdateStatus.to_xml f)))])
  end[@@ocaml.doc
       "<p>A group of settings that are applied to the cluster in the future, or that are currently being applied.</p>"]
module SecurityGroupMembershipList =
  struct
    type t = SecurityGroupMembership.t list
    let make elems () = elems
    let to_query v = Query.to_query_list SecurityGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list SecurityGroupMembership.to_headers v
    let to_json v = `List (List.map SecurityGroupMembership.to_json v)
    let parse xml =
      Util.option_all
        (List.map SecurityGroupMembership.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (SecurityGroupMembership.to_xml x)))
        v
  end
module CacheNodeTypeSpecificParameter =
  struct
    type t =
      {
      parameter_name: String.t option
        [@ocaml.doc "<p>The name of the parameter.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the parameter.</p>"];
      source: String.t option
        [@ocaml.doc "<p>The source of the parameter value.</p>"];
      data_type: String.t option
        [@ocaml.doc "<p>The valid data type for the parameter.</p>"];
      allowed_values: String.t option
        [@ocaml.doc "<p>The valid range of values for the parameter.</p>"];
      is_modifiable: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether (<code>true</code>) or not (<code>false</code>) the parameter can be modified. Some parameters have security or operational implications that prevent them from being changed.</p>"];
      minimum_engine_version: String.t option
        [@ocaml.doc
          "<p>The earliest cache engine version to which the parameter can apply.</p>"];
      cache_node_type_specific_values: CacheNodeTypeSpecificValueList.t
        [@ocaml.doc
          "<p>A list of cache node types and their corresponding values for this parameter.</p>"];
      change_type: ChangeType.t option
        [@ocaml.doc
          "<p>Indicates whether a change to the parameter is applied immediately or requires a reboot for the change to be applied. You can force a reboot or wait until the next maintenance window's reboot. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Rebooting.html\">Rebooting a Cluster</a>.</p>"]}
    [@@ocaml.doc
      "<p>A parameter that has a different value for each cache node type it is applied to. For example, in a Redis cluster, a <code>cache.m1.large</code> cache node type would have a larger <code>maxmemory</code> value than a <code>cache.m1.small</code> type.</p>"]
    let make ?parameter_name  ?description  ?source  ?data_type 
      ?allowed_values  ?is_modifiable  ?minimum_engine_version 
      ?(cache_node_type_specific_values= [])  ?change_type  () =
      {
        parameter_name;
        description;
        source;
        data_type;
        allowed_values;
        is_modifiable;
        minimum_engine_version;
        cache_node_type_specific_values;
        change_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.change_type
              (fun f -> ("change_type", (ChangeType.to_json f)));
           Some
             ("cache_node_type_specific_values",
               (CacheNodeTypeSpecificValueList.to_json
                  v.cache_node_type_specific_values));
           Util.option_map v.minimum_engine_version
             (fun f -> ("minimum_engine_version", (String.to_json f)));
           Util.option_map v.is_modifiable
             (fun f -> ("is_modifiable", (Boolean.to_json f)));
           Util.option_map v.allowed_values
             (fun f -> ("allowed_values", (String.to_json f)));
           Util.option_map v.data_type
             (fun f -> ("data_type", (String.to_json f)));
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.parameter_name
             (fun f -> ("parameter_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_name =
            (Util.option_bind (Xml.member "ParameterName" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          source = (Util.option_bind (Xml.member "Source" xml) String.parse);
          data_type =
            (Util.option_bind (Xml.member "DataType" xml) String.parse);
          allowed_values =
            (Util.option_bind (Xml.member "AllowedValues" xml) String.parse);
          is_modifiable =
            (Util.option_bind (Xml.member "IsModifiable" xml) Boolean.parse);
          minimum_engine_version =
            (Util.option_bind (Xml.member "MinimumEngineVersion" xml)
               String.parse);
          cache_node_type_specific_values =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "CacheNodeTypeSpecificValues" xml)
                  CacheNodeTypeSpecificValueList.parse));
          change_type =
            (Util.option_bind (Xml.member "ChangeType" xml) ChangeType.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.parameter_name
                      (fun f ->
                         Ezxmlm.make_tag "ParameterName"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.description
                     (fun f ->
                        Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.source
                    (fun f ->
                       Ezxmlm.make_tag "Source" ([], (String.to_xml f)))])
                @
                [Util.option_map v.data_type
                   (fun f ->
                      Ezxmlm.make_tag "DataType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.allowed_values
                  (fun f ->
                     Ezxmlm.make_tag "AllowedValues" ([], (String.to_xml f)))])
              @
              [Util.option_map v.is_modifiable
                 (fun f ->
                    Ezxmlm.make_tag "IsModifiable" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.minimum_engine_version
                (fun f ->
                   Ezxmlm.make_tag "MinimumEngineVersion"
                     ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "CacheNodeTypeSpecificValues"
                       ([], (CacheNodeTypeSpecificValueList.to_xml [x]))))
               v.cache_node_type_specific_values))
           @
           [Util.option_map v.change_type
              (fun f ->
                 Ezxmlm.make_tag "ChangeType" ([], (ChangeType.to_xml f)))])
  end[@@ocaml.doc
       "<p>A parameter that has a different value for each cache node type it is applied to. For example, in a Redis cluster, a <code>cache.m1.large</code> cache node type would have a larger <code>maxmemory</code> value than a <code>cache.m1.small</code> type.</p>"]
module Parameter =
  struct
    type t =
      {
      parameter_name: String.t option
        [@ocaml.doc "<p>The name of the parameter.</p>"];
      parameter_value: String.t option
        [@ocaml.doc "<p>The value of the parameter.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the parameter.</p>"];
      source: String.t option
        [@ocaml.doc "<p>The source of the parameter.</p>"];
      data_type: String.t option
        [@ocaml.doc "<p>The valid data type for the parameter.</p>"];
      allowed_values: String.t option
        [@ocaml.doc "<p>The valid range of values for the parameter.</p>"];
      is_modifiable: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether (<code>true</code>) or not (<code>false</code>) the parameter can be modified. Some parameters have security or operational implications that prevent them from being changed.</p>"];
      minimum_engine_version: String.t option
        [@ocaml.doc
          "<p>The earliest cache engine version to which the parameter can apply.</p>"];
      change_type: ChangeType.t option
        [@ocaml.doc
          "<p>Indicates whether a change to the parameter is applied immediately or requires a reboot for the change to be applied. You can force a reboot or wait until the next maintenance window's reboot. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.Rebooting.html\">Rebooting a Cluster</a>.</p>"]}
    [@@ocaml.doc
      "<p>Describes an individual setting that controls some aspect of ElastiCache behavior.</p>"]
    let make ?parameter_name  ?parameter_value  ?description  ?source 
      ?data_type  ?allowed_values  ?is_modifiable  ?minimum_engine_version 
      ?change_type  () =
      {
        parameter_name;
        parameter_value;
        description;
        source;
        data_type;
        allowed_values;
        is_modifiable;
        minimum_engine_version;
        change_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.change_type
              (fun f -> ("change_type", (ChangeType.to_json f)));
           Util.option_map v.minimum_engine_version
             (fun f -> ("minimum_engine_version", (String.to_json f)));
           Util.option_map v.is_modifiable
             (fun f -> ("is_modifiable", (Boolean.to_json f)));
           Util.option_map v.allowed_values
             (fun f -> ("allowed_values", (String.to_json f)));
           Util.option_map v.data_type
             (fun f -> ("data_type", (String.to_json f)));
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.parameter_value
             (fun f -> ("parameter_value", (String.to_json f)));
           Util.option_map v.parameter_name
             (fun f -> ("parameter_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_name =
            (Util.option_bind (Xml.member "ParameterName" xml) String.parse);
          parameter_value =
            (Util.option_bind (Xml.member "ParameterValue" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          source = (Util.option_bind (Xml.member "Source" xml) String.parse);
          data_type =
            (Util.option_bind (Xml.member "DataType" xml) String.parse);
          allowed_values =
            (Util.option_bind (Xml.member "AllowedValues" xml) String.parse);
          is_modifiable =
            (Util.option_bind (Xml.member "IsModifiable" xml) Boolean.parse);
          minimum_engine_version =
            (Util.option_bind (Xml.member "MinimumEngineVersion" xml)
               String.parse);
          change_type =
            (Util.option_bind (Xml.member "ChangeType" xml) ChangeType.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.parameter_name
                      (fun f ->
                         Ezxmlm.make_tag "ParameterName"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.parameter_value
                     (fun f ->
                        Ezxmlm.make_tag "ParameterValue"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.description
                    (fun f ->
                       Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
                @
                [Util.option_map v.source
                   (fun f -> Ezxmlm.make_tag "Source" ([], (String.to_xml f)))])
               @
               [Util.option_map v.data_type
                  (fun f ->
                     Ezxmlm.make_tag "DataType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.allowed_values
                 (fun f ->
                    Ezxmlm.make_tag "AllowedValues" ([], (String.to_xml f)))])
             @
             [Util.option_map v.is_modifiable
                (fun f ->
                   Ezxmlm.make_tag "IsModifiable" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.minimum_engine_version
               (fun f ->
                  Ezxmlm.make_tag "MinimumEngineVersion"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.change_type
              (fun f ->
                 Ezxmlm.make_tag "ChangeType" ([], (ChangeType.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an individual setting that controls some aspect of ElastiCache behavior.</p>"]
module CacheNodeUpdateStatusList =
  struct
    type t = CacheNodeUpdateStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheNodeUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list CacheNodeUpdateStatus.to_headers v
    let to_json v = `List (List.map CacheNodeUpdateStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheNodeUpdateStatus.parse
           (Xml.members "CacheNodeUpdateStatus" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheNodeUpdateStatus.to_xml x))) v
  end
module NodeGroupUpdateStatusList =
  struct
    type t = NodeGroupUpdateStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NodeGroupUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list NodeGroupUpdateStatus.to_headers v
    let to_json v = `List (List.map NodeGroupUpdateStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map NodeGroupUpdateStatus.parse
           (Xml.members "NodeGroupUpdateStatus" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (NodeGroupUpdateStatus.to_xml x))) v
  end
module SlaMet =
  struct
    type t =
      | Yes 
      | No 
      | N_a 
    let str_to_t = [("n/a", N_a); ("no", No); ("yes", Yes)]
    let t_to_str = [(N_a, "n/a"); (No, "no"); (Yes, "yes")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module UpdateActionStatus =
  struct
    type t =
      | Not_applied 
      | Waiting_to_start 
      | In_progress 
      | Stopping 
      | Stopped 
      | Complete 
    let str_to_t =
      [("complete", Complete);
      ("stopped", Stopped);
      ("stopping", Stopping);
      ("in-progress", In_progress);
      ("waiting-to-start", Waiting_to_start);
      ("not-applied", Not_applied)]
    let t_to_str =
      [(Complete, "complete");
      (Stopped, "stopped");
      (Stopping, "stopping");
      (In_progress, "in-progress");
      (Waiting_to_start, "waiting-to-start");
      (Not_applied, "not-applied")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module SourceType =
  struct
    type t =
      | Cache_cluster 
      | Cache_parameter_group 
      | Cache_security_group 
      | Cache_subnet_group 
      | Replication_group 
    let str_to_t =
      [("replication-group", Replication_group);
      ("cache-subnet-group", Cache_subnet_group);
      ("cache-security-group", Cache_security_group);
      ("cache-parameter-group", Cache_parameter_group);
      ("cache-cluster", Cache_cluster)]
    let t_to_str =
      [(Replication_group, "replication-group");
      (Cache_subnet_group, "cache-subnet-group");
      (Cache_security_group, "cache-security-group");
      (Cache_parameter_group, "cache-parameter-group");
      (Cache_cluster, "cache-cluster")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ClusterIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "ClusterId" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module NodeGroupList =
  struct
    type t = NodeGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NodeGroup.to_query v
    let to_headers v = Headers.to_headers_list NodeGroup.to_headers v
    let to_json v = `List (List.map NodeGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map NodeGroup.parse (Xml.members "NodeGroup" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (NodeGroup.to_xml x)))
        v
  end
module ReplicationGroupPendingModifiedValues =
  struct
    type t =
      {
      primary_cluster_id: String.t option
        [@ocaml.doc
          "<p>The primary cluster ID that is applied immediately (if <code>--apply-immediately</code> was specified), or during the next maintenance window.</p>"];
      automatic_failover_status: PendingAutomaticFailoverStatus.t option
        [@ocaml.doc
          "<p>Indicates the status of Multi-AZ with automatic failover for this Redis replication group.</p> <p>Amazon ElastiCache for Redis does not support Multi-AZ with automatic failover on:</p> <ul> <li> <p>Redis versions earlier than 2.8.6.</p> </li> <li> <p>Redis (cluster mode disabled): T1 node types.</p> </li> <li> <p>Redis (cluster mode enabled): T1 node types.</p> </li> </ul>"];
      resharding: ReshardingStatus.t option
        [@ocaml.doc "<p>The status of an online resharding operation.</p>"];
      auth_token_status: AuthTokenUpdateStatus.t option
        [@ocaml.doc "<p>The auth token status</p>"]}[@@ocaml.doc
                                                      "<p>The settings to be applied to the Redis replication group, either immediately or during the next maintenance window.</p>"]
    let make ?primary_cluster_id  ?automatic_failover_status  ?resharding 
      ?auth_token_status  () =
      {
        primary_cluster_id;
        automatic_failover_status;
        resharding;
        auth_token_status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.auth_token_status
              (fun f ->
                 ("auth_token_status", (AuthTokenUpdateStatus.to_json f)));
           Util.option_map v.resharding
             (fun f -> ("resharding", (ReshardingStatus.to_json f)));
           Util.option_map v.automatic_failover_status
             (fun f ->
                ("automatic_failover_status",
                  (PendingAutomaticFailoverStatus.to_json f)));
           Util.option_map v.primary_cluster_id
             (fun f -> ("primary_cluster_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          primary_cluster_id =
            (Util.option_bind (Xml.member "PrimaryClusterId" xml)
               String.parse);
          automatic_failover_status =
            (Util.option_bind (Xml.member "AutomaticFailoverStatus" xml)
               PendingAutomaticFailoverStatus.parse);
          resharding =
            (Util.option_bind (Xml.member "Resharding" xml)
               ReshardingStatus.parse);
          auth_token_status =
            (Util.option_bind (Xml.member "AuthTokenStatus" xml)
               AuthTokenUpdateStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.primary_cluster_id
                 (fun f ->
                    Ezxmlm.make_tag "PrimaryClusterId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.automatic_failover_status
                (fun f ->
                   Ezxmlm.make_tag "AutomaticFailoverStatus"
                     ([], (PendingAutomaticFailoverStatus.to_xml f)))])
            @
            [Util.option_map v.resharding
               (fun f ->
                  Ezxmlm.make_tag "Resharding"
                    ([], (ReshardingStatus.to_xml f)))])
           @
           [Util.option_map v.auth_token_status
              (fun f ->
                 Ezxmlm.make_tag "AuthTokenStatus"
                   ([], (AuthTokenUpdateStatus.to_xml f)))])
  end[@@ocaml.doc
       "<p>The settings to be applied to the Redis replication group, either immediately or during the next maintenance window.</p>"]
module EC2SecurityGroupList =
  struct
    type t = EC2SecurityGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EC2SecurityGroup.to_query v
    let to_headers v = Headers.to_headers_list EC2SecurityGroup.to_headers v
    let to_json v = `List (List.map EC2SecurityGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map EC2SecurityGroup.parse (Xml.members "EC2SecurityGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (EC2SecurityGroup.to_xml x)))
        v
  end
module CustomerNodeEndpoint =
  struct
    type t =
      {
      address: String.t option
        [@ocaml.doc "<p>The address of the node endpoint</p>"];
      port: Integer.t option
        [@ocaml.doc "<p>The port of the node endpoint</p>"]}[@@ocaml.doc
                                                              "<p>The endpoint from which data should be migrated.</p>"]
    let make ?address  ?port  () = { address; port }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.address
             (fun f -> ("address", (String.to_json f)))])
    let parse xml =
      Some
        {
          address =
            (Util.option_bind (Xml.member "Address" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.address
               (fun f -> Ezxmlm.make_tag "Address" ([], (String.to_xml f)))])
           @
           [Util.option_map v.port
              (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc "<p>The endpoint from which data should be migrated.</p>"]
module ReservedCacheNodesOffering =
  struct
    type t =
      {
      reserved_cache_nodes_offering_id: String.t option
        [@ocaml.doc
          "<p>A unique identifier for the reserved cache node offering.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The cache node type for the reserved cache node.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      duration: Integer.t option
        [@ocaml.doc "<p>The duration of the offering. in seconds.</p>"];
      fixed_price: Double.t option
        [@ocaml.doc "<p>The fixed price charged for this offering.</p>"];
      usage_price: Double.t option
        [@ocaml.doc "<p>The hourly price charged for this offering.</p>"];
      product_description: String.t option
        [@ocaml.doc "<p>The cache engine used by the offering.</p>"];
      offering_type: String.t option [@ocaml.doc "<p>The offering type.</p>"];
      recurring_charges: RecurringChargeList.t
        [@ocaml.doc
          "<p>The recurring price charged to run this reserved cache node.</p>"]}
    [@@ocaml.doc
      "<p>Describes all of the attributes of a reserved cache node offering.</p>"]
    let make ?reserved_cache_nodes_offering_id  ?cache_node_type  ?duration 
      ?fixed_price  ?usage_price  ?product_description  ?offering_type 
      ?(recurring_charges= [])  () =
      {
        reserved_cache_nodes_offering_id;
        cache_node_type;
        duration;
        fixed_price;
        usage_price;
        product_description;
        offering_type;
        recurring_charges
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("recurring_charges",
                (RecurringChargeList.to_json v.recurring_charges));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.usage_price
             (fun f -> ("usage_price", (Double.to_json f)));
           Util.option_map v.fixed_price
             (fun f -> ("fixed_price", (Double.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.reserved_cache_nodes_offering_id
             (fun f ->
                ("reserved_cache_nodes_offering_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          reserved_cache_nodes_offering_id =
            (Util.option_bind (Xml.member "ReservedCacheNodesOfferingId" xml)
               String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) Integer.parse);
          fixed_price =
            (Util.option_bind (Xml.member "FixedPrice" xml) Double.parse);
          usage_price =
            (Util.option_bind (Xml.member "UsagePrice" xml) Double.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          recurring_charges =
            (Util.of_option []
               (Util.option_bind (Xml.member "RecurringCharges" xml)
                  RecurringChargeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.reserved_cache_nodes_offering_id
                     (fun f ->
                        Ezxmlm.make_tag "ReservedCacheNodesOfferingId"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.cache_node_type
                    (fun f ->
                       Ezxmlm.make_tag "CacheNodeType"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.duration
                   (fun f ->
                      Ezxmlm.make_tag "Duration" ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.fixed_price
                  (fun f ->
                     Ezxmlm.make_tag "FixedPrice" ([], (Double.to_xml f)))])
              @
              [Util.option_map v.usage_price
                 (fun f ->
                    Ezxmlm.make_tag "UsagePrice" ([], (Double.to_xml f)))])
             @
             [Util.option_map v.product_description
                (fun f ->
                   Ezxmlm.make_tag "ProductDescription"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.offering_type
               (fun f ->
                  Ezxmlm.make_tag "OfferingType" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RecurringCharges"
                      ([], (RecurringChargeList.to_xml [x]))))
              v.recurring_charges))
  end[@@ocaml.doc
       "<p>Describes all of the attributes of a reserved cache node offering.</p>"]
module CacheParameterGroup =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option
        [@ocaml.doc "<p>The name of the cache parameter group.</p>"];
      cache_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>The name of the cache parameter group family that this cache parameter group is compatible with.</p> <p>Valid values are: <code>memcached1.4</code> | <code>memcached1.5</code> | <code>redis2.6</code> | <code>redis2.8</code> | <code>redis3.2</code> | <code>redis4.0</code> | <code>redis5.0</code> | </p>"];
      description: String.t option
        [@ocaml.doc "<p>The description for this cache parameter group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>CreateCacheParameterGroup</code> operation.</p>"]
    let make ?cache_parameter_group_name  ?cache_parameter_group_family 
      ?description  () =
      { cache_parameter_group_name; cache_parameter_group_family; description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.cache_parameter_group_family
             (fun f -> ("cache_parameter_group_family", (String.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          cache_parameter_group_family =
            (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cache_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.cache_parameter_group_family
               (fun f ->
                  Ezxmlm.make_tag "CacheParameterGroupFamily"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the output of a <code>CreateCacheParameterGroup</code> operation.</p>"]
module Snapshot =
  struct
    type t =
      {
      snapshot_name: String.t option
        [@ocaml.doc
          "<p>The name of a snapshot. For an automatic snapshot, the name is system-generated. For a manual snapshot, this is the user-provided name.</p>"];
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier of the source replication group.</p>"];
      replication_group_description: String.t option
        [@ocaml.doc "<p>A description of the source replication group.</p>"];
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>The user-supplied identifier of the source cluster.</p>"];
      snapshot_status: String.t option
        [@ocaml.doc
          "<p>The status of the snapshot. Valid values: <code>creating</code> | <code>available</code> | <code>restoring</code> | <code>copying</code> | <code>deleting</code>.</p>"];
      snapshot_source: String.t option
        [@ocaml.doc
          "<p>Indicates whether the snapshot is from an automatic backup (<code>automated</code>) or was created manually (<code>manual</code>).</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The name of the compute and memory capacity node type for the source cluster.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The name of the cache engine (<code>memcached</code> or <code>redis</code>) used by the source cluster.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version of the cache engine version that is used by the source cluster.</p>"];
      num_cache_nodes: Integer.t option
        [@ocaml.doc
          "<p>The number of cache nodes in the source cluster.</p> <p>For clusters running Redis, this value must be 1. For clusters running Memcached, this value must be between 1 and 20.</p>"];
      preferred_availability_zone: String.t option
        [@ocaml.doc
          "<p>The name of the Availability Zone in which the source cluster is located.</p>"];
      cache_cluster_create_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the source cluster was created.</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.</p> <p>Valid values for <code>ddd</code> are:</p> <ul> <li> <p> <code>sun</code> </p> </li> <li> <p> <code>mon</code> </p> </li> <li> <p> <code>tue</code> </p> </li> <li> <p> <code>wed</code> </p> </li> <li> <p> <code>thu</code> </p> </li> <li> <p> <code>fri</code> </p> </li> <li> <p> <code>sat</code> </p> </li> </ul> <p>Example: <code>sun:23:00-mon:01:30</code> </p>"];
      topic_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the topic used by the source cluster for publishing notifications.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number used by each cache nodes in the source cluster.</p>"];
      cache_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The cache parameter group that is associated with the source cluster.</p>"];
      cache_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the cache subnet group associated with the source cluster.</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>The Amazon Virtual Private Cloud identifier (VPC ID) of the cache subnet group for the source cluster.</p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc "<p>This parameter is currently disabled.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>For an automatic snapshot, the number of days for which ElastiCache retains the snapshot before deleting it.</p> <p>For manual snapshots, this field reflects the <code>SnapshotRetentionLimit</code> for the source cluster when the snapshot was created. This field is otherwise ignored: Manual snapshots do not expire, and can only be deleted using the <code>DeleteSnapshot</code> operation. </p> <p> <b>Important</b> If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off.</p>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range during which ElastiCache takes daily snapshots of the source cluster.</p>"];
      num_node_groups: Integer.t option
        [@ocaml.doc
          "<p>The number of node groups (shards) in this snapshot. When restoring from a snapshot, the number of node groups (shards) in the snapshot and in the restored replication group must be the same.</p>"];
      automatic_failover: AutomaticFailoverStatus.t option
        [@ocaml.doc
          "<p>Indicates the status of Multi-AZ with automatic failover for the source Redis replication group.</p> <p>Amazon ElastiCache for Redis does not support Multi-AZ with automatic failover on:</p> <ul> <li> <p>Redis versions earlier than 2.8.6.</p> </li> <li> <p>Redis (cluster mode disabled): T1 node types.</p> </li> <li> <p>Redis (cluster mode enabled): T1 node types.</p> </li> </ul>"];
      node_snapshots: NodeSnapshotList.t
        [@ocaml.doc
          "<p>A list of the cache nodes in the source cluster.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the KMS key used to encrypt the snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Represents a copy of an entire Redis cluster as of the time when the snapshot was taken.</p>"]
    let make ?snapshot_name  ?replication_group_id 
      ?replication_group_description  ?cache_cluster_id  ?snapshot_status 
      ?snapshot_source  ?cache_node_type  ?engine  ?engine_version 
      ?num_cache_nodes  ?preferred_availability_zone 
      ?cache_cluster_create_time  ?preferred_maintenance_window  ?topic_arn 
      ?port  ?cache_parameter_group_name  ?cache_subnet_group_name  ?vpc_id 
      ?auto_minor_version_upgrade  ?snapshot_retention_limit 
      ?snapshot_window  ?num_node_groups  ?automatic_failover 
      ?(node_snapshots= [])  ?kms_key_id  () =
      {
        snapshot_name;
        replication_group_id;
        replication_group_description;
        cache_cluster_id;
        snapshot_status;
        snapshot_source;
        cache_node_type;
        engine;
        engine_version;
        num_cache_nodes;
        preferred_availability_zone;
        cache_cluster_create_time;
        preferred_maintenance_window;
        topic_arn;
        port;
        cache_parameter_group_name;
        cache_subnet_group_name;
        vpc_id;
        auto_minor_version_upgrade;
        snapshot_retention_limit;
        snapshot_window;
        num_node_groups;
        automatic_failover;
        node_snapshots;
        kms_key_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.kms_key_id
              (fun f -> ("kms_key_id", (String.to_json f)));
           Some
             ("node_snapshots", (NodeSnapshotList.to_json v.node_snapshots));
           Util.option_map v.automatic_failover
             (fun f ->
                ("automatic_failover", (AutomaticFailoverStatus.to_json f)));
           Util.option_map v.num_node_groups
             (fun f -> ("num_node_groups", (Integer.to_json f)));
           Util.option_map v.snapshot_window
             (fun f -> ("snapshot_window", (String.to_json f)));
           Util.option_map v.snapshot_retention_limit
             (fun f -> ("snapshot_retention_limit", (Integer.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.cache_subnet_group_name
             (fun f -> ("cache_subnet_group_name", (String.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.topic_arn
             (fun f -> ("topic_arn", (String.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.cache_cluster_create_time
             (fun f -> ("cache_cluster_create_time", (DateTime.to_json f)));
           Util.option_map v.preferred_availability_zone
             (fun f -> ("preferred_availability_zone", (String.to_json f)));
           Util.option_map v.num_cache_nodes
             (fun f -> ("num_cache_nodes", (Integer.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.snapshot_source
             (fun f -> ("snapshot_source", (String.to_json f)));
           Util.option_map v.snapshot_status
             (fun f -> ("snapshot_status", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_description
             (fun f -> ("replication_group_description", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)));
           Util.option_map v.snapshot_name
             (fun f -> ("snapshot_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          snapshot_name =
            (Util.option_bind (Xml.member "SnapshotName" xml) String.parse);
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          replication_group_description =
            (Util.option_bind (Xml.member "ReplicationGroupDescription" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          snapshot_status =
            (Util.option_bind (Xml.member "SnapshotStatus" xml) String.parse);
          snapshot_source =
            (Util.option_bind (Xml.member "SnapshotSource" xml) String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          num_cache_nodes =
            (Util.option_bind (Xml.member "NumCacheNodes" xml) Integer.parse);
          preferred_availability_zone =
            (Util.option_bind (Xml.member "PreferredAvailabilityZone" xml)
               String.parse);
          cache_cluster_create_time =
            (Util.option_bind (Xml.member "CacheClusterCreateTime" xml)
               DateTime.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          topic_arn =
            (Util.option_bind (Xml.member "TopicArn" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          cache_subnet_group_name =
            (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
               String.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          snapshot_retention_limit =
            (Util.option_bind (Xml.member "SnapshotRetentionLimit" xml)
               Integer.parse);
          snapshot_window =
            (Util.option_bind (Xml.member "SnapshotWindow" xml) String.parse);
          num_node_groups =
            (Util.option_bind (Xml.member "NumNodeGroups" xml) Integer.parse);
          automatic_failover =
            (Util.option_bind (Xml.member "AutomaticFailover" xml)
               AutomaticFailoverStatus.parse);
          node_snapshots =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeSnapshots" xml)
                  NodeSnapshotList.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((([] @
                                   [Util.option_map v.snapshot_name
                                      (fun f ->
                                         Ezxmlm.make_tag "SnapshotName"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.replication_group_id
                                     (fun f ->
                                        Ezxmlm.make_tag "ReplicationGroupId"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map
                                    v.replication_group_description
                                    (fun f ->
                                       Ezxmlm.make_tag
                                         "ReplicationGroupDescription"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.cache_cluster_id
                                   (fun f ->
                                      Ezxmlm.make_tag "CacheClusterId"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.snapshot_status
                                  (fun f ->
                                     Ezxmlm.make_tag "SnapshotStatus"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.snapshot_source
                                 (fun f ->
                                    Ezxmlm.make_tag "SnapshotSource"
                                      ([], (String.to_xml f)))])
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
                          [Util.option_map v.num_cache_nodes
                             (fun f ->
                                Ezxmlm.make_tag "NumCacheNodes"
                                  ([], (Integer.to_xml f)))])
                         @
                         [Util.option_map v.preferred_availability_zone
                            (fun f ->
                               Ezxmlm.make_tag "PreferredAvailabilityZone"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.cache_cluster_create_time
                           (fun f ->
                              Ezxmlm.make_tag "CacheClusterCreateTime"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.preferred_maintenance_window
                          (fun f ->
                             Ezxmlm.make_tag "PreferredMaintenanceWindow"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.topic_arn
                         (fun f ->
                            Ezxmlm.make_tag "TopicArn"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.port
                        (fun f ->
                           Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
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
                  [Util.option_map v.vpc_id
                     (fun f ->
                        Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
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
              [Util.option_map v.num_node_groups
                 (fun f ->
                    Ezxmlm.make_tag "NumNodeGroups" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.automatic_failover
                (fun f ->
                   Ezxmlm.make_tag "AutomaticFailover"
                     ([], (AutomaticFailoverStatus.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "NodeSnapshots"
                       ([], (NodeSnapshotList.to_xml [x])))) v.node_snapshots))
           @
           [Util.option_map v.kms_key_id
              (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a copy of an entire Redis cluster as of the time when the snapshot was taken.</p>"]
module ServiceUpdate =
  struct
    type t =
      {
      service_update_name: String.t option
        [@ocaml.doc "<p>The unique ID of the service update</p>"];
      service_update_release_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when the service update is initially available</p>"];
      service_update_end_date: DateTime.t option
        [@ocaml.doc
          "<p>The date after which the service update is no longer available</p>"];
      service_update_severity: ServiceUpdateSeverity.t option
        [@ocaml.doc "<p>The severity of the service update</p>"];
      service_update_recommended_apply_by_date: DateTime.t option
        [@ocaml.doc
          "<p>The recommendend date to apply the service update in order to ensure compliance. For information on compliance, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/elasticache-compliance.html#elasticache-compliance-self-service\">Self-Service Security Updates for Compliance</a>.</p>"];
      service_update_status: ServiceUpdateStatus.t option
        [@ocaml.doc "<p>The status of the service update</p>"];
      service_update_description: String.t option
        [@ocaml.doc "<p>Provides details of the service update</p>"];
      service_update_type: ServiceUpdateType.t option
        [@ocaml.doc "<p>Reflects the nature of the service update</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The Elasticache engine to which the update applies. Either Redis or Memcached</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The Elasticache engine version to which the update applies. Either Redis or Memcached engine version</p>"];
      auto_update_after_recommended_apply_by_date: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the service update will be automatically applied once the recommended apply-by date has expired. </p>"];
      estimated_update_time: String.t option
        [@ocaml.doc
          "<p>The estimated length of time the service update will take</p>"]}
    [@@ocaml.doc
      "<p>An update that you can apply to your Redis clusters.</p>"]
    let make ?service_update_name  ?service_update_release_date 
      ?service_update_end_date  ?service_update_severity 
      ?service_update_recommended_apply_by_date  ?service_update_status 
      ?service_update_description  ?service_update_type  ?engine 
      ?engine_version  ?auto_update_after_recommended_apply_by_date 
      ?estimated_update_time  () =
      {
        service_update_name;
        service_update_release_date;
        service_update_end_date;
        service_update_severity;
        service_update_recommended_apply_by_date;
        service_update_status;
        service_update_description;
        service_update_type;
        engine;
        engine_version;
        auto_update_after_recommended_apply_by_date;
        estimated_update_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.estimated_update_time
              (fun f -> ("estimated_update_time", (String.to_json f)));
           Util.option_map v.auto_update_after_recommended_apply_by_date
             (fun f ->
                ("auto_update_after_recommended_apply_by_date",
                  (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.service_update_type
             (fun f -> ("service_update_type", (ServiceUpdateType.to_json f)));
           Util.option_map v.service_update_description
             (fun f -> ("service_update_description", (String.to_json f)));
           Util.option_map v.service_update_status
             (fun f ->
                ("service_update_status", (ServiceUpdateStatus.to_json f)));
           Util.option_map v.service_update_recommended_apply_by_date
             (fun f ->
                ("service_update_recommended_apply_by_date",
                  (DateTime.to_json f)));
           Util.option_map v.service_update_severity
             (fun f ->
                ("service_update_severity",
                  (ServiceUpdateSeverity.to_json f)));
           Util.option_map v.service_update_end_date
             (fun f -> ("service_update_end_date", (DateTime.to_json f)));
           Util.option_map v.service_update_release_date
             (fun f -> ("service_update_release_date", (DateTime.to_json f)));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          service_update_release_date =
            (Util.option_bind (Xml.member "ServiceUpdateReleaseDate" xml)
               DateTime.parse);
          service_update_end_date =
            (Util.option_bind (Xml.member "ServiceUpdateEndDate" xml)
               DateTime.parse);
          service_update_severity =
            (Util.option_bind (Xml.member "ServiceUpdateSeverity" xml)
               ServiceUpdateSeverity.parse);
          service_update_recommended_apply_by_date =
            (Util.option_bind
               (Xml.member "ServiceUpdateRecommendedApplyByDate" xml)
               DateTime.parse);
          service_update_status =
            (Util.option_bind (Xml.member "ServiceUpdateStatus" xml)
               ServiceUpdateStatus.parse);
          service_update_description =
            (Util.option_bind (Xml.member "ServiceUpdateDescription" xml)
               String.parse);
          service_update_type =
            (Util.option_bind (Xml.member "ServiceUpdateType" xml)
               ServiceUpdateType.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          auto_update_after_recommended_apply_by_date =
            (Util.option_bind
               (Xml.member "AutoUpdateAfterRecommendedApplyByDate" xml)
               Boolean.parse);
          estimated_update_time =
            (Util.option_bind (Xml.member "EstimatedUpdateTime" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.service_update_name
                         (fun f ->
                            Ezxmlm.make_tag "ServiceUpdateName"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.service_update_release_date
                        (fun f ->
                           Ezxmlm.make_tag "ServiceUpdateReleaseDate"
                             ([], (DateTime.to_xml f)))])
                    @
                    [Util.option_map v.service_update_end_date
                       (fun f ->
                          Ezxmlm.make_tag "ServiceUpdateEndDate"
                            ([], (DateTime.to_xml f)))])
                   @
                   [Util.option_map v.service_update_severity
                      (fun f ->
                         Ezxmlm.make_tag "ServiceUpdateSeverity"
                           ([], (ServiceUpdateSeverity.to_xml f)))])
                  @
                  [Util.option_map v.service_update_recommended_apply_by_date
                     (fun f ->
                        Ezxmlm.make_tag "ServiceUpdateRecommendedApplyByDate"
                          ([], (DateTime.to_xml f)))])
                 @
                 [Util.option_map v.service_update_status
                    (fun f ->
                       Ezxmlm.make_tag "ServiceUpdateStatus"
                         ([], (ServiceUpdateStatus.to_xml f)))])
                @
                [Util.option_map v.service_update_description
                   (fun f ->
                      Ezxmlm.make_tag "ServiceUpdateDescription"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.service_update_type
                  (fun f ->
                     Ezxmlm.make_tag "ServiceUpdateType"
                       ([], (ServiceUpdateType.to_xml f)))])
              @
              [Util.option_map v.engine
                 (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
             @
             [Util.option_map v.engine_version
                (fun f ->
                   Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
            @
            [Util.option_map v.auto_update_after_recommended_apply_by_date
               (fun f ->
                  Ezxmlm.make_tag "AutoUpdateAfterRecommendedApplyByDate"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.estimated_update_time
              (fun f ->
                 Ezxmlm.make_tag "EstimatedUpdateTime"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>An update that you can apply to your Redis clusters.</p>"]
module CacheSubnetGroup =
  struct
    type t =
      {
      cache_subnet_group_name: String.t option
        [@ocaml.doc "<p>The name of the cache subnet group.</p>"];
      cache_subnet_group_description: String.t option
        [@ocaml.doc "<p>The description of the cache subnet group.</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>The Amazon Virtual Private Cloud identifier (VPC ID) of the cache subnet group.</p>"];
      subnets: SubnetList.t
        [@ocaml.doc
          "<p>A list of subnets associated with the cache subnet group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of one of the following operations:</p> <ul> <li> <p> <code>CreateCacheSubnetGroup</code> </p> </li> <li> <p> <code>ModifyCacheSubnetGroup</code> </p> </li> </ul>"]
    let make ?cache_subnet_group_name  ?cache_subnet_group_description 
      ?vpc_id  ?(subnets= [])  () =
      {
        cache_subnet_group_name;
        cache_subnet_group_description;
        vpc_id;
        subnets
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnets", (SubnetList.to_json v.subnets));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.cache_subnet_group_description
             (fun f -> ("cache_subnet_group_description", (String.to_json f)));
           Util.option_map v.cache_subnet_group_name
             (fun f -> ("cache_subnet_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
               String.parse);
          cache_subnet_group_description =
            (Util.option_bind (Xml.member "CacheSubnetGroupDescription" xml)
               String.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          subnets =
            (Util.of_option []
               (Util.option_bind (Xml.member "Subnets" xml) SubnetList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.cache_subnet_group_name
                 (fun f ->
                    Ezxmlm.make_tag "CacheSubnetGroupName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.cache_subnet_group_description
                (fun f ->
                   Ezxmlm.make_tag "CacheSubnetGroupDescription"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.vpc_id
               (fun f -> Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Subnets" ([], (SubnetList.to_xml [x]))))
              v.subnets))
  end[@@ocaml.doc
       "<p>Represents the output of one of the following operations:</p> <ul> <li> <p> <code>CreateCacheSubnetGroup</code> </p> </li> <li> <p> <code>ModifyCacheSubnetGroup</code> </p> </li> </ul>"]
module Tag =
  struct
    type t =
      {
      key: String.t option
        [@ocaml.doc "<p>The key for the tag. May not be null.</p>"];
      value: String.t option
        [@ocaml.doc "<p>The tag's value. May be null.</p>"]}[@@ocaml.doc
                                                              "<p>A cost allocation Tag that can be added to an ElastiCache cluster or replication group. Tags are composed of a Key/Value pair. A tag with a null Value is permitted.</p>"]
    let make ?key  ?value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let parse xml =
      Some
        {
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.key
               (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A cost allocation Tag that can be added to an ElastiCache cluster or replication group. Tags are composed of a Key/Value pair. A tag with a null Value is permitted.</p>"]
module ConfigureShard =
  struct
    type t =
      {
      node_group_id: String.t
        [@ocaml.doc
          "<p>The 4-digit id for the node group you are configuring. For Redis (cluster mode disabled) replication groups, the node group id is always 0001. To find a Redis (cluster mode enabled)'s node group's (shard's) id, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/shard-find-id.html\">Finding a Shard's Id</a>.</p>"];
      new_replica_count: Integer.t
        [@ocaml.doc
          "<p>The number of replicas you want in this node group at the end of this operation. The maximum value for <code>NewReplicaCount</code> is 5. The minimum value depends upon the type of Redis replication group you are working with.</p> <p>The minimum number of replicas in a shard or replication group is:</p> <ul> <li> <p>Redis (cluster mode disabled)</p> <ul> <li> <p>If Multi-AZ with Automatic Failover is enabled: 1</p> </li> <li> <p>If Multi-AZ with Automatic Failover is not enable: 0</p> </li> </ul> </li> <li> <p>Redis (cluster mode enabled): 0 (though you will not be able to failover to a replica if your primary node fails)</p> </li> </ul>"];
      preferred_availability_zones: PreferredAvailabilityZoneList.t
        [@ocaml.doc
          "<p>A list of <code>PreferredAvailabilityZone</code> strings that specify which availability zones the replication group's nodes are to be in. The nummber of <code>PreferredAvailabilityZone</code> values must equal the value of <code>NewReplicaCount</code> plus 1 to account for the primary node. If this member of <code>ReplicaConfiguration</code> is omitted, ElastiCache for Redis selects the availability zone for each of the replicas.</p>"]}
    [@@ocaml.doc
      "<p>Node group (shard) configuration options when adding or removing replicas. Each node group (shard) configuration has the following members: NodeGroupId, NewReplicaCount, and PreferredAvailabilityZones. </p>"]
    let make ~node_group_id  ~new_replica_count 
      ?(preferred_availability_zones= [])  () =
      { node_group_id; new_replica_count; preferred_availability_zones }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("preferred_availability_zones",
                (PreferredAvailabilityZoneList.to_json
                   v.preferred_availability_zones));
           Some ("new_replica_count", (Integer.to_json v.new_replica_count));
           Some ("node_group_id", (String.to_json v.node_group_id))])
    let parse xml =
      Some
        {
          node_group_id =
            (Xml.required "NodeGroupId"
               (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse));
          new_replica_count =
            (Xml.required "NewReplicaCount"
               (Util.option_bind (Xml.member "NewReplicaCount" xml)
                  Integer.parse));
          preferred_availability_zones =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "PreferredAvailabilityZones" xml)
                  PreferredAvailabilityZoneList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "NodeGroupId"
                   ([], (String.to_xml v.node_group_id)))])
            @
            [Some
               (Ezxmlm.make_tag "NewReplicaCount"
                  ([], (Integer.to_xml v.new_replica_count)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "PreferredAvailabilityZones"
                      ([], (PreferredAvailabilityZoneList.to_xml [x]))))
              v.preferred_availability_zones))
  end[@@ocaml.doc
       "<p>Node group (shard) configuration options when adding or removing replicas. Each node group (shard) configuration has the following members: NodeGroupId, NewReplicaCount, and PreferredAvailabilityZones. </p>"]
module ParameterNameValue =
  struct
    type t =
      {
      parameter_name: String.t option
        [@ocaml.doc "<p>The name of the parameter.</p>"];
      parameter_value: String.t option
        [@ocaml.doc "<p>The value of the parameter.</p>"]}[@@ocaml.doc
                                                            "<p>Describes a name-value pair that is used to update the value of a parameter.</p>"]
    let make ?parameter_name  ?parameter_value  () =
      { parameter_name; parameter_value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameter_value
              (fun f -> ("parameter_value", (String.to_json f)));
           Util.option_map v.parameter_name
             (fun f -> ("parameter_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_name =
            (Util.option_bind (Xml.member "ParameterName" xml) String.parse);
          parameter_value =
            (Util.option_bind (Xml.member "ParameterValue" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.parameter_name
               (fun f ->
                  Ezxmlm.make_tag "ParameterName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.parameter_value
              (fun f ->
                 Ezxmlm.make_tag "ParameterValue" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a name-value pair that is used to update the value of a parameter.</p>"]
module CacheCluster =
  struct
    type t =
      {
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>The user-supplied identifier of the cluster. This identifier is a unique key that identifies a cluster.</p>"];
      configuration_endpoint: Endpoint.t option
        [@ocaml.doc
          "<p>Represents a Memcached cluster endpoint which, if Automatic Discovery is enabled on the cluster, can be used by an application to connect to any node in the cluster. The configuration endpoint will always have <code>.cfg</code> in it.</p> <p>Example: <code>mem-3.9dvc4r<u>.cfg</u>.usw2.cache.amazonaws.com:11211</code> </p>"];
      client_download_landing_page: String.t option
        [@ocaml.doc
          "<p>The URL of the web page where you can download the latest ElastiCache client library.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The name of the compute and memory capacity node type for the cluster.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The name of the cache engine (<code>memcached</code> or <code>redis</code>) to be used for this cluster.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version of the cache engine that is used in this cluster.</p>"];
      cache_cluster_status: String.t option
        [@ocaml.doc
          "<p>The current state of this cluster, one of the following values: <code>available</code>, <code>creating</code>, <code>deleted</code>, <code>deleting</code>, <code>incompatible-network</code>, <code>modifying</code>, <code>rebooting cluster nodes</code>, <code>restore-failed</code>, or <code>snapshotting</code>.</p>"];
      num_cache_nodes: Integer.t option
        [@ocaml.doc
          "<p>The number of cache nodes in the cluster.</p> <p>For clusters running Redis, this value must be 1. For clusters running Memcached, this value must be between 1 and 20.</p>"];
      preferred_availability_zone: String.t option
        [@ocaml.doc
          "<p>The name of the Availability Zone in which the cluster is located or \"Multiple\" if the cache nodes are located in different Availability Zones.</p>"];
      cache_cluster_create_time: DateTime.t option
        [@ocaml.doc "<p>The date and time when the cluster was created.</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which maintenance on the cluster is performed. It is specified as a range in the format ddd:hh24:mi-ddd:hh24:mi (24H Clock UTC). The minimum maintenance window is a 60 minute period.</p> <p>Valid values for <code>ddd</code> are:</p> <ul> <li> <p> <code>sun</code> </p> </li> <li> <p> <code>mon</code> </p> </li> <li> <p> <code>tue</code> </p> </li> <li> <p> <code>wed</code> </p> </li> <li> <p> <code>thu</code> </p> </li> <li> <p> <code>fri</code> </p> </li> <li> <p> <code>sat</code> </p> </li> </ul> <p>Example: <code>sun:23:00-mon:01:30</code> </p>"];
      pending_modified_values: PendingModifiedValues.t option ;
      notification_configuration: NotificationConfiguration.t option
        [@ocaml.doc
          "<p>Describes a notification topic and its status. Notification topics are used for publishing ElastiCache events to subscribers using Amazon Simple Notification Service (SNS). </p>"];
      cache_security_groups: CacheSecurityGroupMembershipList.t
        [@ocaml.doc
          "<p>A list of cache security group elements, composed of name and status sub-elements.</p>"];
      cache_parameter_group: CacheParameterGroupStatus.t option
        [@ocaml.doc "<p>Status of the cache parameter group.</p>"];
      cache_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the cache subnet group associated with the cluster.</p>"];
      cache_nodes: CacheNodeList.t
        [@ocaml.doc
          "<p>A list of cache nodes that are members of the cluster.</p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc "<p>This parameter is currently disabled.</p>"];
      security_groups: SecurityGroupMembershipList.t
        [@ocaml.doc
          "<p>A list of VPC Security Groups associated with the cluster.</p>"];
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>The replication group to which this cluster belongs. If this field is empty, the cluster is not associated with any replication group.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which ElastiCache retains automatic cluster snapshots before deleting them. For example, if you set <code>SnapshotRetentionLimit</code> to 5, a snapshot that was taken today is retained for 5 days before being deleted.</p> <important> <p> If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off.</p> </important>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your cluster.</p> <p>Example: <code>05:00-09:00</code> </p>"];
      auth_token_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables using an <code>AuthToken</code> (password) when issuing Redis commands.</p> <p>Default: <code>false</code> </p>"];
      auth_token_last_modified_date: DateTime.t option
        [@ocaml.doc "<p>The date the auth token was last modified</p>"];
      transit_encryption_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables in-transit encryption when set to <code>true</code>.</p> <p>You cannot modify the value of <code>TransitEncryptionEnabled</code> after the cluster is created. To enable in-transit encryption on a cluster you must set <code>TransitEncryptionEnabled</code> to <code>true</code> when you create a cluster.</p> <p> <b>Required:</b> Only available when creating a replication group in an Amazon VPC using redis version <code>3.2.6</code>, <code>4.x</code> or later.</p> <p>Default: <code>false</code> </p>"];
      at_rest_encryption_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables encryption at-rest when set to <code>true</code>.</p> <p>You cannot modify the value of <code>AtRestEncryptionEnabled</code> after the cluster is created. To enable at-rest encryption on a cluster you must set <code>AtRestEncryptionEnabled</code> to <code>true</code> when you create a cluster.</p> <p> <b>Required:</b> Only available when creating a replication group in an Amazon VPC using redis version <code>3.2.6</code>, <code>4.x</code> or later.</p> <p>Default: <code>false</code> </p>"]}
    [@@ocaml.doc
      "<p>Contains all of the attributes of a specific cluster.</p>"]
    let make ?cache_cluster_id  ?configuration_endpoint 
      ?client_download_landing_page  ?cache_node_type  ?engine 
      ?engine_version  ?cache_cluster_status  ?num_cache_nodes 
      ?preferred_availability_zone  ?cache_cluster_create_time 
      ?preferred_maintenance_window  ?pending_modified_values 
      ?notification_configuration  ?(cache_security_groups= []) 
      ?cache_parameter_group  ?cache_subnet_group_name  ?(cache_nodes= []) 
      ?auto_minor_version_upgrade  ?(security_groups= []) 
      ?replication_group_id  ?snapshot_retention_limit  ?snapshot_window 
      ?auth_token_enabled  ?auth_token_last_modified_date 
      ?transit_encryption_enabled  ?at_rest_encryption_enabled  () =
      {
        cache_cluster_id;
        configuration_endpoint;
        client_download_landing_page;
        cache_node_type;
        engine;
        engine_version;
        cache_cluster_status;
        num_cache_nodes;
        preferred_availability_zone;
        cache_cluster_create_time;
        preferred_maintenance_window;
        pending_modified_values;
        notification_configuration;
        cache_security_groups;
        cache_parameter_group;
        cache_subnet_group_name;
        cache_nodes;
        auto_minor_version_upgrade;
        security_groups;
        replication_group_id;
        snapshot_retention_limit;
        snapshot_window;
        auth_token_enabled;
        auth_token_last_modified_date;
        transit_encryption_enabled;
        at_rest_encryption_enabled
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.at_rest_encryption_enabled
              (fun f -> ("at_rest_encryption_enabled", (Boolean.to_json f)));
           Util.option_map v.transit_encryption_enabled
             (fun f -> ("transit_encryption_enabled", (Boolean.to_json f)));
           Util.option_map v.auth_token_last_modified_date
             (fun f ->
                ("auth_token_last_modified_date", (DateTime.to_json f)));
           Util.option_map v.auth_token_enabled
             (fun f -> ("auth_token_enabled", (Boolean.to_json f)));
           Util.option_map v.snapshot_window
             (fun f -> ("snapshot_window", (String.to_json f)));
           Util.option_map v.snapshot_retention_limit
             (fun f -> ("snapshot_retention_limit", (Integer.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)));
           Some
             ("security_groups",
               (SecurityGroupMembershipList.to_json v.security_groups));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Some ("cache_nodes", (CacheNodeList.to_json v.cache_nodes));
           Util.option_map v.cache_subnet_group_name
             (fun f -> ("cache_subnet_group_name", (String.to_json f)));
           Util.option_map v.cache_parameter_group
             (fun f ->
                ("cache_parameter_group",
                  (CacheParameterGroupStatus.to_json f)));
           Some
             ("cache_security_groups",
               (CacheSecurityGroupMembershipList.to_json
                  v.cache_security_groups));
           Util.option_map v.notification_configuration
             (fun f ->
                ("notification_configuration",
                  (NotificationConfiguration.to_json f)));
           Util.option_map v.pending_modified_values
             (fun f ->
                ("pending_modified_values",
                  (PendingModifiedValues.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.cache_cluster_create_time
             (fun f -> ("cache_cluster_create_time", (DateTime.to_json f)));
           Util.option_map v.preferred_availability_zone
             (fun f -> ("preferred_availability_zone", (String.to_json f)));
           Util.option_map v.num_cache_nodes
             (fun f -> ("num_cache_nodes", (Integer.to_json f)));
           Util.option_map v.cache_cluster_status
             (fun f -> ("cache_cluster_status", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.client_download_landing_page
             (fun f -> ("client_download_landing_page", (String.to_json f)));
           Util.option_map v.configuration_endpoint
             (fun f -> ("configuration_endpoint", (Endpoint.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          configuration_endpoint =
            (Util.option_bind (Xml.member "ConfigurationEndpoint" xml)
               Endpoint.parse);
          client_download_landing_page =
            (Util.option_bind (Xml.member "ClientDownloadLandingPage" xml)
               String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          cache_cluster_status =
            (Util.option_bind (Xml.member "CacheClusterStatus" xml)
               String.parse);
          num_cache_nodes =
            (Util.option_bind (Xml.member "NumCacheNodes" xml) Integer.parse);
          preferred_availability_zone =
            (Util.option_bind (Xml.member "PreferredAvailabilityZone" xml)
               String.parse);
          cache_cluster_create_time =
            (Util.option_bind (Xml.member "CacheClusterCreateTime" xml)
               DateTime.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          pending_modified_values =
            (Util.option_bind (Xml.member "PendingModifiedValues" xml)
               PendingModifiedValues.parse);
          notification_configuration =
            (Util.option_bind (Xml.member "NotificationConfiguration" xml)
               NotificationConfiguration.parse);
          cache_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSecurityGroups" xml)
                  CacheSecurityGroupMembershipList.parse));
          cache_parameter_group =
            (Util.option_bind (Xml.member "CacheParameterGroup" xml)
               CacheParameterGroupStatus.parse);
          cache_subnet_group_name =
            (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
               String.parse);
          cache_nodes =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheNodes" xml)
                  CacheNodeList.parse));
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroups" xml)
                  SecurityGroupMembershipList.parse));
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          snapshot_retention_limit =
            (Util.option_bind (Xml.member "SnapshotRetentionLimit" xml)
               Integer.parse);
          snapshot_window =
            (Util.option_bind (Xml.member "SnapshotWindow" xml) String.parse);
          auth_token_enabled =
            (Util.option_bind (Xml.member "AuthTokenEnabled" xml)
               Boolean.parse);
          auth_token_last_modified_date =
            (Util.option_bind (Xml.member "AuthTokenLastModifiedDate" xml)
               DateTime.parse);
          transit_encryption_enabled =
            (Util.option_bind (Xml.member "TransitEncryptionEnabled" xml)
               Boolean.parse);
          at_rest_encryption_enabled =
            (Util.option_bind (Xml.member "AtRestEncryptionEnabled" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((([] @
                                    [Util.option_map v.cache_cluster_id
                                       (fun f ->
                                          Ezxmlm.make_tag "CacheClusterId"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Util.option_map v.configuration_endpoint
                                      (fun f ->
                                         Ezxmlm.make_tag
                                           "ConfigurationEndpoint"
                                           ([], (Endpoint.to_xml f)))])
                                  @
                                  [Util.option_map
                                     v.client_download_landing_page
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "ClientDownloadLandingPage"
                                          ([], (String.to_xml f)))])
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
                              [Util.option_map v.cache_cluster_status
                                 (fun f ->
                                    Ezxmlm.make_tag "CacheClusterStatus"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.num_cache_nodes
                                (fun f ->
                                   Ezxmlm.make_tag "NumCacheNodes"
                                     ([], (Integer.to_xml f)))])
                            @
                            [Util.option_map v.preferred_availability_zone
                               (fun f ->
                                  Ezxmlm.make_tag "PreferredAvailabilityZone"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.cache_cluster_create_time
                              (fun f ->
                                 Ezxmlm.make_tag "CacheClusterCreateTime"
                                   ([], (DateTime.to_xml f)))])
                          @
                          [Util.option_map v.preferred_maintenance_window
                             (fun f ->
                                Ezxmlm.make_tag "PreferredMaintenanceWindow"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.pending_modified_values
                            (fun f ->
                               Ezxmlm.make_tag "PendingModifiedValues"
                                 ([], (PendingModifiedValues.to_xml f)))])
                        @
                        [Util.option_map v.notification_configuration
                           (fun f ->
                              Ezxmlm.make_tag "NotificationConfiguration"
                                ([], (NotificationConfiguration.to_xml f)))])
                       @
                       (List.map
                          (fun x ->
                             Some
                               (Ezxmlm.make_tag "CacheSecurityGroups"
                                  ([],
                                    (CacheSecurityGroupMembershipList.to_xml
                                       [x])))) v.cache_security_groups))
                      @
                      [Util.option_map v.cache_parameter_group
                         (fun f ->
                            Ezxmlm.make_tag "CacheParameterGroup"
                              ([], (CacheParameterGroupStatus.to_xml f)))])
                     @
                     [Util.option_map v.cache_subnet_group_name
                        (fun f ->
                           Ezxmlm.make_tag "CacheSubnetGroupName"
                             ([], (String.to_xml f)))])
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "CacheNodes"
                               ([], (CacheNodeList.to_xml [x]))))
                       v.cache_nodes))
                   @
                   [Util.option_map v.auto_minor_version_upgrade
                      (fun f ->
                         Ezxmlm.make_tag "AutoMinorVersionUpgrade"
                           ([], (Boolean.to_xml f)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "SecurityGroups"
                             ([], (SecurityGroupMembershipList.to_xml [x]))))
                     v.security_groups))
                 @
                 [Util.option_map v.replication_group_id
                    (fun f ->
                       Ezxmlm.make_tag "ReplicationGroupId"
                         ([], (String.to_xml f)))])
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
              [Util.option_map v.auth_token_enabled
                 (fun f ->
                    Ezxmlm.make_tag "AuthTokenEnabled"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.auth_token_last_modified_date
                (fun f ->
                   Ezxmlm.make_tag "AuthTokenLastModifiedDate"
                     ([], (DateTime.to_xml f)))])
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
  end[@@ocaml.doc
       "<p>Contains all of the attributes of a specific cluster.</p>"]
module CacheNodeTypeSpecificParametersList =
  struct
    type t = CacheNodeTypeSpecificParameter.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list CacheNodeTypeSpecificParameter.to_query v
    let to_headers v =
      Headers.to_headers_list CacheNodeTypeSpecificParameter.to_headers v
    let to_json v = `List (List.map CacheNodeTypeSpecificParameter.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheNodeTypeSpecificParameter.parse
           (Xml.members "CacheNodeTypeSpecificParameter" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (CacheNodeTypeSpecificParameter.to_xml x))) v
  end
module ParametersList =
  struct
    type t = Parameter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Parameter.to_query v
    let to_headers v = Headers.to_headers_list Parameter.to_headers v
    let to_json v = `List (List.map Parameter.to_json v)
    let parse xml =
      Util.option_all
        (List.map Parameter.parse (Xml.members "Parameter" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Parameter.to_xml x)))
        v
  end
module ReshardingConfiguration =
  struct
    type t =
      {
      node_group_id: String.t option
        [@ocaml.doc
          "<p>Either the ElastiCache for Redis supplied 4-digit id or a user supplied id for the node group these configuration values apply to.</p>"];
      preferred_availability_zones: AvailabilityZonesList.t
        [@ocaml.doc
          "<p>A list of preferred availability zones for the nodes in this cluster.</p>"]}
    [@@ocaml.doc
      "<p>A list of <code>PreferredAvailabilityZones</code> objects that specifies the configuration of a node group in the resharded cluster.</p>"]
    let make ?node_group_id  ?(preferred_availability_zones= [])  () =
      { node_group_id; preferred_availability_zones }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("preferred_availability_zones",
                (AvailabilityZonesList.to_json v.preferred_availability_zones));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          node_group_id =
            (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse);
          preferred_availability_zones =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "PreferredAvailabilityZones" xml)
                  AvailabilityZonesList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.node_group_id
               (fun f ->
                  Ezxmlm.make_tag "NodeGroupId" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "PreferredAvailabilityZones"
                      ([], (AvailabilityZonesList.to_xml [x]))))
              v.preferred_availability_zones))
  end[@@ocaml.doc
       "<p>A list of <code>PreferredAvailabilityZones</code> objects that specifies the configuration of a node group in the resharded cluster.</p>"]
module UpdateAction =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc "<p>The ID of the replication group</p>"];
      cache_cluster_id: String.t option
        [@ocaml.doc "<p>The ID of the cache cluster</p>"];
      service_update_name: String.t option
        [@ocaml.doc "<p>The unique ID of the service update</p>"];
      service_update_release_date: DateTime.t option
        [@ocaml.doc "<p>The date the update is first available</p>"];
      service_update_severity: ServiceUpdateSeverity.t option
        [@ocaml.doc "<p>The severity of the service update</p>"];
      service_update_status: ServiceUpdateStatus.t option
        [@ocaml.doc "<p>The status of the service update</p>"];
      service_update_recommended_apply_by_date: DateTime.t option
        [@ocaml.doc
          "<p>The recommended date to apply the service update to ensure compliance. For information on compliance, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/elasticache-compliance.html#elasticache-compliance-self-service\">Self-Service Security Updates for Compliance</a>.</p>"];
      service_update_type: ServiceUpdateType.t option
        [@ocaml.doc "<p>Reflects the nature of the service update </p>"];
      update_action_available_date: DateTime.t option
        [@ocaml.doc
          "<p>The date that the service update is available to a replication group</p>"];
      update_action_status: UpdateActionStatus.t option
        [@ocaml.doc "<p>The status of the update action</p>"];
      nodes_updated: String.t option
        [@ocaml.doc
          "<p>The progress of the service update on the replication group</p>"];
      update_action_status_modified_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when the UpdateActionStatus was last modified</p>"];
      sla_met: SlaMet.t option
        [@ocaml.doc
          "<p>If yes, all nodes in the replication group have been updated by the recommended apply-by date. If no, at least one node in the replication group have not been updated by the recommended apply-by date. If N/A, the replication group was created after the recommended apply-by date.</p>"];
      node_group_update_status: NodeGroupUpdateStatusList.t
        [@ocaml.doc
          "<p>The status of the service update on the node group</p>"];
      cache_node_update_status: CacheNodeUpdateStatusList.t
        [@ocaml.doc
          "<p>The status of the service update on the cache node</p>"];
      estimated_update_time: String.t option
        [@ocaml.doc
          "<p>The estimated length of time for the update to complete</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The Elasticache engine to which the update applies. Either Redis or Memcached</p>"]}
    [@@ocaml.doc
      "<p>The status of the service update for a specific replication group</p>"]
    let make ?replication_group_id  ?cache_cluster_id  ?service_update_name 
      ?service_update_release_date  ?service_update_severity 
      ?service_update_status  ?service_update_recommended_apply_by_date 
      ?service_update_type  ?update_action_available_date 
      ?update_action_status  ?nodes_updated 
      ?update_action_status_modified_date  ?sla_met 
      ?(node_group_update_status= [])  ?(cache_node_update_status= []) 
      ?estimated_update_time  ?engine  () =
      {
        replication_group_id;
        cache_cluster_id;
        service_update_name;
        service_update_release_date;
        service_update_severity;
        service_update_status;
        service_update_recommended_apply_by_date;
        service_update_type;
        update_action_available_date;
        update_action_status;
        nodes_updated;
        update_action_status_modified_date;
        sla_met;
        node_group_update_status;
        cache_node_update_status;
        estimated_update_time;
        engine
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.engine
              (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.estimated_update_time
             (fun f -> ("estimated_update_time", (String.to_json f)));
           Some
             ("cache_node_update_status",
               (CacheNodeUpdateStatusList.to_json v.cache_node_update_status));
           Some
             ("node_group_update_status",
               (NodeGroupUpdateStatusList.to_json v.node_group_update_status));
           Util.option_map v.sla_met
             (fun f -> ("sla_met", (SlaMet.to_json f)));
           Util.option_map v.update_action_status_modified_date
             (fun f ->
                ("update_action_status_modified_date", (DateTime.to_json f)));
           Util.option_map v.nodes_updated
             (fun f -> ("nodes_updated", (String.to_json f)));
           Util.option_map v.update_action_status
             (fun f ->
                ("update_action_status", (UpdateActionStatus.to_json f)));
           Util.option_map v.update_action_available_date
             (fun f -> ("update_action_available_date", (DateTime.to_json f)));
           Util.option_map v.service_update_type
             (fun f -> ("service_update_type", (ServiceUpdateType.to_json f)));
           Util.option_map v.service_update_recommended_apply_by_date
             (fun f ->
                ("service_update_recommended_apply_by_date",
                  (DateTime.to_json f)));
           Util.option_map v.service_update_status
             (fun f ->
                ("service_update_status", (ServiceUpdateStatus.to_json f)));
           Util.option_map v.service_update_severity
             (fun f ->
                ("service_update_severity",
                  (ServiceUpdateSeverity.to_json f)));
           Util.option_map v.service_update_release_date
             (fun f -> ("service_update_release_date", (DateTime.to_json f)));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          service_update_release_date =
            (Util.option_bind (Xml.member "ServiceUpdateReleaseDate" xml)
               DateTime.parse);
          service_update_severity =
            (Util.option_bind (Xml.member "ServiceUpdateSeverity" xml)
               ServiceUpdateSeverity.parse);
          service_update_status =
            (Util.option_bind (Xml.member "ServiceUpdateStatus" xml)
               ServiceUpdateStatus.parse);
          service_update_recommended_apply_by_date =
            (Util.option_bind
               (Xml.member "ServiceUpdateRecommendedApplyByDate" xml)
               DateTime.parse);
          service_update_type =
            (Util.option_bind (Xml.member "ServiceUpdateType" xml)
               ServiceUpdateType.parse);
          update_action_available_date =
            (Util.option_bind (Xml.member "UpdateActionAvailableDate" xml)
               DateTime.parse);
          update_action_status =
            (Util.option_bind (Xml.member "UpdateActionStatus" xml)
               UpdateActionStatus.parse);
          nodes_updated =
            (Util.option_bind (Xml.member "NodesUpdated" xml) String.parse);
          update_action_status_modified_date =
            (Util.option_bind
               (Xml.member "UpdateActionStatusModifiedDate" xml)
               DateTime.parse);
          sla_met = (Util.option_bind (Xml.member "SlaMet" xml) SlaMet.parse);
          node_group_update_status =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeGroupUpdateStatus" xml)
                  NodeGroupUpdateStatusList.parse));
          cache_node_update_status =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheNodeUpdateStatus" xml)
                  CacheNodeUpdateStatusList.parse));
          estimated_update_time =
            (Util.option_bind (Xml.member "EstimatedUpdateTime" xml)
               String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Util.option_map v.replication_group_id
                              (fun f ->
                                 Ezxmlm.make_tag "ReplicationGroupId"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.cache_cluster_id
                             (fun f ->
                                Ezxmlm.make_tag "CacheClusterId"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.service_update_name
                            (fun f ->
                               Ezxmlm.make_tag "ServiceUpdateName"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.service_update_release_date
                           (fun f ->
                              Ezxmlm.make_tag "ServiceUpdateReleaseDate"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.service_update_severity
                          (fun f ->
                             Ezxmlm.make_tag "ServiceUpdateSeverity"
                               ([], (ServiceUpdateSeverity.to_xml f)))])
                      @
                      [Util.option_map v.service_update_status
                         (fun f ->
                            Ezxmlm.make_tag "ServiceUpdateStatus"
                              ([], (ServiceUpdateStatus.to_xml f)))])
                     @
                     [Util.option_map
                        v.service_update_recommended_apply_by_date
                        (fun f ->
                           Ezxmlm.make_tag
                             "ServiceUpdateRecommendedApplyByDate"
                             ([], (DateTime.to_xml f)))])
                    @
                    [Util.option_map v.service_update_type
                       (fun f ->
                          Ezxmlm.make_tag "ServiceUpdateType"
                            ([], (ServiceUpdateType.to_xml f)))])
                   @
                   [Util.option_map v.update_action_available_date
                      (fun f ->
                         Ezxmlm.make_tag "UpdateActionAvailableDate"
                           ([], (DateTime.to_xml f)))])
                  @
                  [Util.option_map v.update_action_status
                     (fun f ->
                        Ezxmlm.make_tag "UpdateActionStatus"
                          ([], (UpdateActionStatus.to_xml f)))])
                 @
                 [Util.option_map v.nodes_updated
                    (fun f ->
                       Ezxmlm.make_tag "NodesUpdated" ([], (String.to_xml f)))])
                @
                [Util.option_map v.update_action_status_modified_date
                   (fun f ->
                      Ezxmlm.make_tag "UpdateActionStatusModifiedDate"
                        ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.sla_met
                  (fun f -> Ezxmlm.make_tag "SlaMet" ([], (SlaMet.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "NodeGroupUpdateStatus"
                         ([], (NodeGroupUpdateStatusList.to_xml [x]))))
                 v.node_group_update_status))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "CacheNodeUpdateStatus"
                        ([], (CacheNodeUpdateStatusList.to_xml [x]))))
                v.cache_node_update_status))
            @
            [Util.option_map v.estimated_update_time
               (fun f ->
                  Ezxmlm.make_tag "EstimatedUpdateTime"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.engine
              (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The status of the service update for a specific replication group</p>"]
module Event =
  struct
    type t =
      {
      source_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier for the source of the event. For example, if the event occurred at the cluster level, the identifier would be the name of the cluster.</p>"];
      source_type: SourceType.t option
        [@ocaml.doc
          "<p>Specifies the origin of this event - a cluster, a parameter group, a security group, etc.</p>"];
      message: String.t option [@ocaml.doc "<p>The text of the event.</p>"];
      date: DateTime.t option
        [@ocaml.doc "<p>The date and time when the event occurred.</p>"]}
    [@@ocaml.doc
      "<p>Represents a single occurrence of something interesting within the system. Some examples of events are creating a cluster, adding or removing a cache node, or rebooting a node.</p>"]
    let make ?source_identifier  ?source_type  ?message  ?date  () =
      { source_identifier; source_type; message; date }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)));
           Util.option_map v.message
             (fun f -> ("message", (String.to_json f)));
           Util.option_map v.source_type
             (fun f -> ("source_type", (SourceType.to_json f)));
           Util.option_map v.source_identifier
             (fun f -> ("source_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          source_identifier =
            (Util.option_bind (Xml.member "SourceIdentifier" xml)
               String.parse);
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) SourceType.parse);
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse);
          date = (Util.option_bind (Xml.member "Date" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.source_identifier
                 (fun f ->
                    Ezxmlm.make_tag "SourceIdentifier"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.source_type
                (fun f ->
                   Ezxmlm.make_tag "SourceType" ([], (SourceType.to_xml f)))])
            @
            [Util.option_map v.message
               (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
           @
           [Util.option_map v.date
              (fun f -> Ezxmlm.make_tag "Date" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents a single occurrence of something interesting within the system. Some examples of events are creating a cluster, adding or removing a cache node, or rebooting a node.</p>"]
module ProcessedUpdateAction =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc "<p>The ID of the replication group</p>"];
      cache_cluster_id: String.t option
        [@ocaml.doc "<p>The ID of the cache cluster</p>"];
      service_update_name: String.t option
        [@ocaml.doc "<p>The unique ID of the service update</p>"];
      update_action_status: UpdateActionStatus.t option
        [@ocaml.doc
          "<p>The status of the update action on the Redis cluster</p>"]}
    [@@ocaml.doc
      "<p>Update action that has been processed for the corresponding apply/stop request</p>"]
    let make ?replication_group_id  ?cache_cluster_id  ?service_update_name 
      ?update_action_status  () =
      {
        replication_group_id;
        cache_cluster_id;
        service_update_name;
        update_action_status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.update_action_status
              (fun f ->
                 ("update_action_status", (UpdateActionStatus.to_json f)));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          update_action_status =
            (Util.option_bind (Xml.member "UpdateActionStatus" xml)
               UpdateActionStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.replication_group_id
                 (fun f ->
                    Ezxmlm.make_tag "ReplicationGroupId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.cache_cluster_id
                (fun f ->
                   Ezxmlm.make_tag "CacheClusterId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.service_update_name
               (fun f ->
                  Ezxmlm.make_tag "ServiceUpdateName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.update_action_status
              (fun f ->
                 Ezxmlm.make_tag "UpdateActionStatus"
                   ([], (UpdateActionStatus.to_xml f)))])
  end[@@ocaml.doc
       "<p>Update action that has been processed for the corresponding apply/stop request</p>"]
module UnprocessedUpdateAction =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc "<p>The replication group ID</p>"];
      cache_cluster_id: String.t option
        [@ocaml.doc "<p>The ID of the cache cluster</p>"];
      service_update_name: String.t option
        [@ocaml.doc "<p>The unique ID of the service update</p>"];
      error_type: String.t option
        [@ocaml.doc
          "<p>The error type for requests that are not processed</p>"];
      error_message: String.t option
        [@ocaml.doc
          "<p>The error message that describes the reason the request was not processed</p>"]}
    [@@ocaml.doc
      "<p>Update action that has failed to be processed for the corresponding apply/stop request</p>"]
    let make ?replication_group_id  ?cache_cluster_id  ?service_update_name 
      ?error_type  ?error_message  () =
      {
        replication_group_id;
        cache_cluster_id;
        service_update_name;
        error_type;
        error_message
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.error_message
              (fun f -> ("error_message", (String.to_json f)));
           Util.option_map v.error_type
             (fun f -> ("error_type", (String.to_json f)));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          error_type =
            (Util.option_bind (Xml.member "ErrorType" xml) String.parse);
          error_message =
            (Util.option_bind (Xml.member "ErrorMessage" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.replication_group_id
                  (fun f ->
                     Ezxmlm.make_tag "ReplicationGroupId"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.cache_cluster_id
                 (fun f ->
                    Ezxmlm.make_tag "CacheClusterId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.service_update_name
                (fun f ->
                   Ezxmlm.make_tag "ServiceUpdateName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.error_type
               (fun f -> Ezxmlm.make_tag "ErrorType" ([], (String.to_xml f)))])
           @
           [Util.option_map v.error_message
              (fun f ->
                 Ezxmlm.make_tag "ErrorMessage" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Update action that has failed to be processed for the corresponding apply/stop request</p>"]
module ReplicationGroup =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc "<p>The identifier for the replication group.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The user supplied description of the replication group.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The current state of this replication group - <code>creating</code>, <code>available</code>, <code>modifying</code>, <code>deleting</code>, <code>create-failed</code>, <code>snapshotting</code>.</p>"];
      pending_modified_values: ReplicationGroupPendingModifiedValues.t option
        [@ocaml.doc
          "<p>A group of settings to be applied to the replication group, either immediately or during the next maintenance window.</p>"];
      member_clusters: ClusterIdList.t
        [@ocaml.doc
          "<p>The names of all the cache clusters that are part of this replication group.</p>"];
      node_groups: NodeGroupList.t
        [@ocaml.doc
          "<p>A list of node groups in this replication group. For Redis (cluster mode disabled) replication groups, this is a single-element list. For Redis (cluster mode enabled) replication groups, the list contains an entry for each node group (shard).</p>"];
      snapshotting_cluster_id: String.t option
        [@ocaml.doc
          "<p>The cluster ID that is used as the daily snapshot source for the replication group.</p>"];
      automatic_failover: AutomaticFailoverStatus.t option
        [@ocaml.doc
          "<p>Indicates the status of Multi-AZ with automatic failover for this Redis replication group.</p> <p>Amazon ElastiCache for Redis does not support Multi-AZ with automatic failover on:</p> <ul> <li> <p>Redis versions earlier than 2.8.6.</p> </li> <li> <p>Redis (cluster mode disabled): T1 node types.</p> </li> <li> <p>Redis (cluster mode enabled): T1 node types.</p> </li> </ul>"];
      configuration_endpoint: Endpoint.t option
        [@ocaml.doc
          "<p>The configuration endpoint for this replication group. Use the configuration endpoint to connect to this replication group.</p>"];
      snapshot_retention_limit: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which ElastiCache retains automatic cluster snapshots before deleting them. For example, if you set <code>SnapshotRetentionLimit</code> to 5, a snapshot that was taken today is retained for 5 days before being deleted.</p> <important> <p> If the value of <code>SnapshotRetentionLimit</code> is set to zero (0), backups are turned off.</p> </important>"];
      snapshot_window: String.t option
        [@ocaml.doc
          "<p>The daily time range (in UTC) during which ElastiCache begins taking a daily snapshot of your node group (shard).</p> <p>Example: <code>05:00-09:00</code> </p> <p>If you do not specify this parameter, ElastiCache automatically chooses an appropriate time range.</p> <note> <p>This parameter is only valid if the <code>Engine</code> parameter is <code>redis</code>.</p> </note>"];
      cluster_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag indicating whether or not this replication group is cluster enabled; i.e., whether its data can be partitioned across multiple shards (API/CLI: node groups).</p> <p>Valid values: <code>true</code> | <code>false</code> </p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The name of the compute and memory capacity node type for each node in the replication group.</p>"];
      auth_token_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables using an <code>AuthToken</code> (password) when issuing Redis commands.</p> <p>Default: <code>false</code> </p>"];
      auth_token_last_modified_date: DateTime.t option
        [@ocaml.doc "<p>The date the auth token was last modified</p>"];
      transit_encryption_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables in-transit encryption when set to <code>true</code>.</p> <p>You cannot modify the value of <code>TransitEncryptionEnabled</code> after the cluster is created. To enable in-transit encryption on a cluster you must set <code>TransitEncryptionEnabled</code> to <code>true</code> when you create a cluster.</p> <p> <b>Required:</b> Only available when creating a replication group in an Amazon VPC using redis version <code>3.2.6</code>, <code>4.x</code> or later.</p> <p>Default: <code>false</code> </p>"];
      at_rest_encryption_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A flag that enables encryption at-rest when set to <code>true</code>.</p> <p>You cannot modify the value of <code>AtRestEncryptionEnabled</code> after the cluster is created. To enable encryption at-rest on a cluster you must set <code>AtRestEncryptionEnabled</code> to <code>true</code> when you create a cluster.</p> <p> <b>Required:</b> Only available when creating a replication group in an Amazon VPC using redis version <code>3.2.6</code>, <code>4.x</code> or later.</p> <p>Default: <code>false</code> </p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the KMS key used to encrypt the disk in the cluster.</p>"]}
    [@@ocaml.doc
      "<p>Contains all of the attributes of a specific Redis replication group.</p>"]
    let make ?replication_group_id  ?description  ?status 
      ?pending_modified_values  ?(member_clusters= [])  ?(node_groups= []) 
      ?snapshotting_cluster_id  ?automatic_failover  ?configuration_endpoint 
      ?snapshot_retention_limit  ?snapshot_window  ?cluster_enabled 
      ?cache_node_type  ?auth_token_enabled  ?auth_token_last_modified_date 
      ?transit_encryption_enabled  ?at_rest_encryption_enabled  ?kms_key_id 
      () =
      {
        replication_group_id;
        description;
        status;
        pending_modified_values;
        member_clusters;
        node_groups;
        snapshotting_cluster_id;
        automatic_failover;
        configuration_endpoint;
        snapshot_retention_limit;
        snapshot_window;
        cluster_enabled;
        cache_node_type;
        auth_token_enabled;
        auth_token_last_modified_date;
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
           Util.option_map v.auth_token_last_modified_date
             (fun f ->
                ("auth_token_last_modified_date", (DateTime.to_json f)));
           Util.option_map v.auth_token_enabled
             (fun f -> ("auth_token_enabled", (Boolean.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.cluster_enabled
             (fun f -> ("cluster_enabled", (Boolean.to_json f)));
           Util.option_map v.snapshot_window
             (fun f -> ("snapshot_window", (String.to_json f)));
           Util.option_map v.snapshot_retention_limit
             (fun f -> ("snapshot_retention_limit", (Integer.to_json f)));
           Util.option_map v.configuration_endpoint
             (fun f -> ("configuration_endpoint", (Endpoint.to_json f)));
           Util.option_map v.automatic_failover
             (fun f ->
                ("automatic_failover", (AutomaticFailoverStatus.to_json f)));
           Util.option_map v.snapshotting_cluster_id
             (fun f -> ("snapshotting_cluster_id", (String.to_json f)));
           Some ("node_groups", (NodeGroupList.to_json v.node_groups));
           Some
             ("member_clusters", (ClusterIdList.to_json v.member_clusters));
           Util.option_map v.pending_modified_values
             (fun f ->
                ("pending_modified_values",
                  (ReplicationGroupPendingModifiedValues.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          pending_modified_values =
            (Util.option_bind (Xml.member "PendingModifiedValues" xml)
               ReplicationGroupPendingModifiedValues.parse);
          member_clusters =
            (Util.of_option []
               (Util.option_bind (Xml.member "MemberClusters" xml)
                  ClusterIdList.parse));
          node_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeGroups" xml)
                  NodeGroupList.parse));
          snapshotting_cluster_id =
            (Util.option_bind (Xml.member "SnapshottingClusterId" xml)
               String.parse);
          automatic_failover =
            (Util.option_bind (Xml.member "AutomaticFailover" xml)
               AutomaticFailoverStatus.parse);
          configuration_endpoint =
            (Util.option_bind (Xml.member "ConfigurationEndpoint" xml)
               Endpoint.parse);
          snapshot_retention_limit =
            (Util.option_bind (Xml.member "SnapshotRetentionLimit" xml)
               Integer.parse);
          snapshot_window =
            (Util.option_bind (Xml.member "SnapshotWindow" xml) String.parse);
          cluster_enabled =
            (Util.option_bind (Xml.member "ClusterEnabled" xml) Boolean.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          auth_token_enabled =
            (Util.option_bind (Xml.member "AuthTokenEnabled" xml)
               Boolean.parse);
          auth_token_last_modified_date =
            (Util.option_bind (Xml.member "AuthTokenLastModifiedDate" xml)
               DateTime.parse);
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
        (((((((((((((((((([] @
                            [Util.option_map v.replication_group_id
                               (fun f ->
                                  Ezxmlm.make_tag "ReplicationGroupId"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.description
                              (fun f ->
                                 Ezxmlm.make_tag "Description"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.status
                             (fun f ->
                                Ezxmlm.make_tag "Status"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.pending_modified_values
                            (fun f ->
                               Ezxmlm.make_tag "PendingModifiedValues"
                                 ([],
                                   (ReplicationGroupPendingModifiedValues.to_xml
                                      f)))])
                        @
                        (List.map
                           (fun x ->
                              Some
                                (Ezxmlm.make_tag "MemberClusters"
                                   ([], (ClusterIdList.to_xml [x]))))
                           v.member_clusters))
                       @
                       (List.map
                          (fun x ->
                             Some
                               (Ezxmlm.make_tag "NodeGroups"
                                  ([], (NodeGroupList.to_xml [x]))))
                          v.node_groups))
                      @
                      [Util.option_map v.snapshotting_cluster_id
                         (fun f ->
                            Ezxmlm.make_tag "SnapshottingClusterId"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.automatic_failover
                        (fun f ->
                           Ezxmlm.make_tag "AutomaticFailover"
                             ([], (AutomaticFailoverStatus.to_xml f)))])
                    @
                    [Util.option_map v.configuration_endpoint
                       (fun f ->
                          Ezxmlm.make_tag "ConfigurationEndpoint"
                            ([], (Endpoint.to_xml f)))])
                   @
                   [Util.option_map v.snapshot_retention_limit
                      (fun f ->
                         Ezxmlm.make_tag "SnapshotRetentionLimit"
                           ([], (Integer.to_xml f)))])
                  @
                  [Util.option_map v.snapshot_window
                     (fun f ->
                        Ezxmlm.make_tag "SnapshotWindow"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.cluster_enabled
                    (fun f ->
                       Ezxmlm.make_tag "ClusterEnabled"
                         ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.cache_node_type
                   (fun f ->
                      Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.auth_token_enabled
                  (fun f ->
                     Ezxmlm.make_tag "AuthTokenEnabled"
                       ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.auth_token_last_modified_date
                 (fun f ->
                    Ezxmlm.make_tag "AuthTokenLastModifiedDate"
                      ([], (DateTime.to_xml f)))])
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
       "<p>Contains all of the attributes of a specific Redis replication group.</p>"]
module CacheEngineVersion =
  struct
    type t =
      {
      engine: String.t option
        [@ocaml.doc "<p>The name of the cache engine.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>The version number of the cache engine.</p>"];
      cache_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>The name of the cache parameter group family associated with this cache engine.</p> <p>Valid values are: <code>memcached1.4</code> | <code>memcached1.5</code> | <code>redis2.6</code> | <code>redis2.8</code> | <code>redis3.2</code> | <code>redis4.0</code> | <code>redis5.0</code> | </p>"];
      cache_engine_description: String.t option
        [@ocaml.doc "<p>The description of the cache engine.</p>"];
      cache_engine_version_description: String.t option
        [@ocaml.doc "<p>The description of the cache engine version.</p>"]}
    [@@ocaml.doc
      "<p>Provides all of the details about a particular cache engine version.</p>"]
    let make ?engine  ?engine_version  ?cache_parameter_group_family 
      ?cache_engine_description  ?cache_engine_version_description  () =
      {
        engine;
        engine_version;
        cache_parameter_group_family;
        cache_engine_description;
        cache_engine_version_description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_engine_version_description
              (fun f ->
                 ("cache_engine_version_description", (String.to_json f)));
           Util.option_map v.cache_engine_description
             (fun f -> ("cache_engine_description", (String.to_json f)));
           Util.option_map v.cache_parameter_group_family
             (fun f -> ("cache_parameter_group_family", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          cache_parameter_group_family =
            (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
               String.parse);
          cache_engine_description =
            (Util.option_bind (Xml.member "CacheEngineDescription" xml)
               String.parse);
          cache_engine_version_description =
            (Util.option_bind
               (Xml.member "CacheEngineVersionDescription" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.engine
                  (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
              @
              [Util.option_map v.engine_version
                 (fun f ->
                    Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
             @
             [Util.option_map v.cache_parameter_group_family
                (fun f ->
                   Ezxmlm.make_tag "CacheParameterGroupFamily"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.cache_engine_description
               (fun f ->
                  Ezxmlm.make_tag "CacheEngineDescription"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.cache_engine_version_description
              (fun f ->
                 Ezxmlm.make_tag "CacheEngineVersionDescription"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Provides all of the details about a particular cache engine version.</p>"]
module CacheSecurityGroup =
  struct
    type t =
      {
      owner_id: String.t option
        [@ocaml.doc
          "<p>The AWS account ID of the cache security group owner.</p>"];
      cache_security_group_name: String.t option
        [@ocaml.doc "<p>The name of the cache security group.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the cache security group.</p>"];
      e_c2_security_groups: EC2SecurityGroupList.t
        [@ocaml.doc
          "<p>A list of Amazon EC2 security groups that are associated with this cache security group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of one of the following operations:</p> <ul> <li> <p> <code>AuthorizeCacheSecurityGroupIngress</code> </p> </li> <li> <p> <code>CreateCacheSecurityGroup</code> </p> </li> <li> <p> <code>RevokeCacheSecurityGroupIngress</code> </p> </li> </ul>"]
    let make ?owner_id  ?cache_security_group_name  ?description 
      ?(e_c2_security_groups= [])  () =
      {
        owner_id;
        cache_security_group_name;
        description;
        e_c2_security_groups
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("e_c2_security_groups",
                (EC2SecurityGroupList.to_json v.e_c2_security_groups));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.cache_security_group_name
             (fun f -> ("cache_security_group_name", (String.to_json f)));
           Util.option_map v.owner_id
             (fun f -> ("owner_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          owner_id =
            (Util.option_bind (Xml.member "OwnerId" xml) String.parse);
          cache_security_group_name =
            (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          e_c2_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "EC2SecurityGroups" xml)
                  EC2SecurityGroupList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.owner_id
                 (fun f -> Ezxmlm.make_tag "OwnerId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.cache_security_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheSecurityGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "EC2SecurityGroups"
                      ([], (EC2SecurityGroupList.to_xml [x]))))
              v.e_c2_security_groups))
  end[@@ocaml.doc
       "<p>Represents the output of one of the following operations:</p> <ul> <li> <p> <code>AuthorizeCacheSecurityGroupIngress</code> </p> </li> <li> <p> <code>CreateCacheSecurityGroup</code> </p> </li> <li> <p> <code>RevokeCacheSecurityGroupIngress</code> </p> </li> </ul>"]
module ReservedCacheNode =
  struct
    type t =
      {
      reserved_cache_node_id: String.t option
        [@ocaml.doc "<p>The unique identifier for the reservation.</p>"];
      reserved_cache_nodes_offering_id: String.t option
        [@ocaml.doc "<p>The offering identifier.</p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The cache node type for the reserved cache nodes.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      start_time: DateTime.t option
        [@ocaml.doc "<p>The time the reservation started.</p>"];
      duration: Integer.t option
        [@ocaml.doc "<p>The duration of the reservation in seconds.</p>"];
      fixed_price: Double.t option
        [@ocaml.doc
          "<p>The fixed price charged for this reserved cache node.</p>"];
      usage_price: Double.t option
        [@ocaml.doc
          "<p>The hourly price charged for this reserved cache node.</p>"];
      cache_node_count: Integer.t option
        [@ocaml.doc
          "<p>The number of cache nodes that have been reserved.</p>"];
      product_description: String.t option
        [@ocaml.doc "<p>The description of the reserved cache node.</p>"];
      offering_type: String.t option
        [@ocaml.doc "<p>The offering type of this reserved cache node.</p>"];
      state: String.t option
        [@ocaml.doc "<p>The state of the reserved cache node.</p>"];
      recurring_charges: RecurringChargeList.t
        [@ocaml.doc
          "<p>The recurring price charged to run this reserved cache node.</p>"];
      reservation_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the reserved cache node.</p> <p>Example: <code>arn:aws:elasticache:us-east-1:123456789012:reserved-instance:ri-2017-03-27-08-33-25-582</code> </p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>PurchaseReservedCacheNodesOffering</code> operation.</p>"]
    let make ?reserved_cache_node_id  ?reserved_cache_nodes_offering_id 
      ?cache_node_type  ?start_time  ?duration  ?fixed_price  ?usage_price 
      ?cache_node_count  ?product_description  ?offering_type  ?state 
      ?(recurring_charges= [])  ?reservation_a_r_n  () =
      {
        reserved_cache_node_id;
        reserved_cache_nodes_offering_id;
        cache_node_type;
        start_time;
        duration;
        fixed_price;
        usage_price;
        cache_node_count;
        product_description;
        offering_type;
        state;
        recurring_charges;
        reservation_a_r_n
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reservation_a_r_n
              (fun f -> ("reservation_a_r_n", (String.to_json f)));
           Some
             ("recurring_charges",
               (RecurringChargeList.to_json v.recurring_charges));
           Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.cache_node_count
             (fun f -> ("cache_node_count", (Integer.to_json f)));
           Util.option_map v.usage_price
             (fun f -> ("usage_price", (Double.to_json f)));
           Util.option_map v.fixed_price
             (fun f -> ("fixed_price", (Double.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.reserved_cache_nodes_offering_id
             (fun f ->
                ("reserved_cache_nodes_offering_id", (String.to_json f)));
           Util.option_map v.reserved_cache_node_id
             (fun f -> ("reserved_cache_node_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          reserved_cache_node_id =
            (Util.option_bind (Xml.member "ReservedCacheNodeId" xml)
               String.parse);
          reserved_cache_nodes_offering_id =
            (Util.option_bind (Xml.member "ReservedCacheNodesOfferingId" xml)
               String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) Integer.parse);
          fixed_price =
            (Util.option_bind (Xml.member "FixedPrice" xml) Double.parse);
          usage_price =
            (Util.option_bind (Xml.member "UsagePrice" xml) Double.parse);
          cache_node_count =
            (Util.option_bind (Xml.member "CacheNodeCount" xml) Integer.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          state = (Util.option_bind (Xml.member "State" xml) String.parse);
          recurring_charges =
            (Util.of_option []
               (Util.option_bind (Xml.member "RecurringCharges" xml)
                  RecurringChargeList.parse));
          reservation_a_r_n =
            (Util.option_bind (Xml.member "ReservationARN" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Util.option_map v.reserved_cache_node_id
                          (fun f ->
                             Ezxmlm.make_tag "ReservedCacheNodeId"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.reserved_cache_nodes_offering_id
                         (fun f ->
                            Ezxmlm.make_tag "ReservedCacheNodesOfferingId"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.cache_node_type
                        (fun f ->
                           Ezxmlm.make_tag "CacheNodeType"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.start_time
                       (fun f ->
                          Ezxmlm.make_tag "StartTime"
                            ([], (DateTime.to_xml f)))])
                   @
                   [Util.option_map v.duration
                      (fun f ->
                         Ezxmlm.make_tag "Duration" ([], (Integer.to_xml f)))])
                  @
                  [Util.option_map v.fixed_price
                     (fun f ->
                        Ezxmlm.make_tag "FixedPrice" ([], (Double.to_xml f)))])
                 @
                 [Util.option_map v.usage_price
                    (fun f ->
                       Ezxmlm.make_tag "UsagePrice" ([], (Double.to_xml f)))])
                @
                [Util.option_map v.cache_node_count
                   (fun f ->
                      Ezxmlm.make_tag "CacheNodeCount"
                        ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.product_description
                  (fun f ->
                     Ezxmlm.make_tag "ProductDescription"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.offering_type
                 (fun f ->
                    Ezxmlm.make_tag "OfferingType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.state
                (fun f -> Ezxmlm.make_tag "State" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RecurringCharges"
                       ([], (RecurringChargeList.to_xml [x]))))
               v.recurring_charges))
           @
           [Util.option_map v.reservation_a_r_n
              (fun f ->
                 Ezxmlm.make_tag "ReservationARN" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the output of a <code>PurchaseReservedCacheNodesOffering</code> operation.</p>"]
module CustomerNodeEndpointList =
  struct
    type t = CustomerNodeEndpoint.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CustomerNodeEndpoint.to_query v
    let to_headers v =
      Headers.to_headers_list CustomerNodeEndpoint.to_headers v
    let to_json v = `List (List.map CustomerNodeEndpoint.to_json v)
    let parse xml =
      Util.option_all
        (List.map CustomerNodeEndpoint.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CustomerNodeEndpoint.to_xml x))) v
  end
module ReservedCacheNodesOfferingList =
  struct
    type t = ReservedCacheNodesOffering.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ReservedCacheNodesOffering.to_query v
    let to_headers v =
      Headers.to_headers_list ReservedCacheNodesOffering.to_headers v
    let to_json v = `List (List.map ReservedCacheNodesOffering.to_json v)
    let parse xml =
      Util.option_all
        (List.map ReservedCacheNodesOffering.parse
           (Xml.members "ReservedCacheNodesOffering" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ReservedCacheNodesOffering.to_xml x))) v
  end
module CacheParameterGroupList =
  struct
    type t = CacheParameterGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheParameterGroup.to_query v
    let to_headers v =
      Headers.to_headers_list CacheParameterGroup.to_headers v
    let to_json v = `List (List.map CacheParameterGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheParameterGroup.parse
           (Xml.members "CacheParameterGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheParameterGroup.to_xml x))) v
  end
module SnapshotList =
  struct
    type t = Snapshot.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Snapshot.to_query v
    let to_headers v = Headers.to_headers_list Snapshot.to_headers v
    let to_json v = `List (List.map Snapshot.to_json v)
    let parse xml =
      Util.option_all (List.map Snapshot.parse (Xml.members "Snapshot" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Snapshot.to_xml x)))
        v
  end
module ServiceUpdateStatusList =
  struct
    type t = ServiceUpdateStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ServiceUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list ServiceUpdateStatus.to_headers v
    let to_json v = `List (List.map ServiceUpdateStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map ServiceUpdateStatus.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ServiceUpdateStatus.to_xml x))) v
  end
module ServiceUpdateList =
  struct
    type t = ServiceUpdate.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ServiceUpdate.to_query v
    let to_headers v = Headers.to_headers_list ServiceUpdate.to_headers v
    let to_json v = `List (List.map ServiceUpdate.to_json v)
    let parse xml =
      Util.option_all
        (List.map ServiceUpdate.parse (Xml.members "ServiceUpdate" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ServiceUpdate.to_xml x))) v
  end
module CacheSubnetGroups =
  struct
    type t = CacheSubnetGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheSubnetGroup.to_query v
    let to_headers v = Headers.to_headers_list CacheSubnetGroup.to_headers v
    let to_json v = `List (List.map CacheSubnetGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheSubnetGroup.parse (Xml.members "CacheSubnetGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (CacheSubnetGroup.to_xml x)))
        v
  end
module TagList =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "Tag" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end
module RemoveReplicasList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ReplicaConfigurationList =
  struct
    type t = ConfigureShard.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ConfigureShard.to_query v
    let to_headers v = Headers.to_headers_list ConfigureShard.to_headers v
    let to_json v = `List (List.map ConfigureShard.to_json v)
    let parse xml =
      Util.option_all
        (List.map ConfigureShard.parse (Xml.members "ConfigureShard" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ConfigureShard.to_xml x))) v
  end
module ParameterNameValueList =
  struct
    type t = ParameterNameValue.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParameterNameValue.to_query v
    let to_headers v =
      Headers.to_headers_list ParameterNameValue.to_headers v
    let to_json v = `List (List.map ParameterNameValue.to_json v)
    let parse xml =
      Util.option_all
        (List.map ParameterNameValue.parse
           (Xml.members "ParameterNameValue" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ParameterNameValue.to_xml x))) v
  end
module SubnetIdentifierList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "SubnetIdentifier" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module CacheSecurityGroupNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "CacheSecurityGroupName" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module NodeGroupConfigurationList =
  struct
    type t = NodeGroupConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NodeGroupConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list NodeGroupConfiguration.to_headers v
    let to_json v = `List (List.map NodeGroupConfiguration.to_json v)
    let parse xml =
      Util.option_all
        (List.map NodeGroupConfiguration.parse
           (Xml.members "NodeGroupConfiguration" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (NodeGroupConfiguration.to_xml x)))
        v
  end
module SecurityGroupIdsList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "SecurityGroupId" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module SnapshotArnsList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "SnapshotArn" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module CacheClusterList =
  struct
    type t = CacheCluster.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheCluster.to_query v
    let to_headers v = Headers.to_headers_list CacheCluster.to_headers v
    let to_json v = `List (List.map CacheCluster.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheCluster.parse (Xml.members "CacheCluster" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (CacheCluster.to_xml x))) v
  end
module EngineDefaults =
  struct
    type t =
      {
      cache_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the cache parameter group family to which the engine default parameters apply.</p> <p>Valid values are: <code>memcached1.4</code> | <code>memcached1.5</code> | <code>redis2.6</code> | <code>redis2.8</code> | <code>redis3.2</code> | <code>redis4.0</code> | <code>redis5.0</code> | </p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      parameters: ParametersList.t
        [@ocaml.doc "<p>Contains a list of engine default parameters.</p>"];
      cache_node_type_specific_parameters:
        CacheNodeTypeSpecificParametersList.t
        [@ocaml.doc
          "<p>A list of parameters specific to a particular cache node type. Each element in the list contains detailed information about one parameter.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeEngineDefaultParameters</code> operation.</p>"]
    let make ?cache_parameter_group_family  ?marker  ?(parameters= []) 
      ?(cache_node_type_specific_parameters= [])  () =
      {
        cache_parameter_group_family;
        marker;
        parameters;
        cache_node_type_specific_parameters
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_node_type_specific_parameters",
                (CacheNodeTypeSpecificParametersList.to_json
                   v.cache_node_type_specific_parameters));
           Some ("parameters", (ParametersList.to_json v.parameters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.cache_parameter_group_family
             (fun f -> ("cache_parameter_group_family", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_parameter_group_family =
            (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
               String.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse));
          cache_node_type_specific_parameters =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "CacheNodeTypeSpecificParameters" xml)
                  CacheNodeTypeSpecificParametersList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.cache_parameter_group_family
                 (fun f ->
                    Ezxmlm.make_tag "CacheParameterGroupFamily"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.marker
                (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Parameters"
                       ([], (ParametersList.to_xml [x])))) v.parameters))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheNodeTypeSpecificParameters"
                      ([], (CacheNodeTypeSpecificParametersList.to_xml [x]))))
              v.cache_node_type_specific_parameters))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeEngineDefaultParameters</code> operation.</p>"]
module NodeGroupsToRemoveList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "NodeGroupToRemove" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module NodeGroupsToRetainList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "NodeGroupToRetain" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ReshardingConfigurationList =
  struct
    type t = ReshardingConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReshardingConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list ReshardingConfiguration.to_headers v
    let to_json v = `List (List.map ReshardingConfiguration.to_json v)
    let parse xml =
      Util.option_all
        (List.map ReshardingConfiguration.parse
           (Xml.members "ReshardingConfiguration" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ReshardingConfiguration.to_xml x)))
        v
  end
module CacheClusterIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ReplicationGroupIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module TimeRangeFilter =
  struct
    type t =
      {
      start_time: DateTime.t option
        [@ocaml.doc "<p>The start time of the time range filter</p>"];
      end_time: DateTime.t option
        [@ocaml.doc "<p>The end time of the time range filter</p>"]}[@@ocaml.doc
                                                                    "<p>Filters update actions from the service updates that are in available status during the time range.</p>"]
    let make ?start_time  ?end_time  () = { start_time; end_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_time
              (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)))])
    let parse xml =
      Some
        {
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.start_time
               (fun f ->
                  Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.end_time
              (fun f -> Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Filters update actions from the service updates that are in available status during the time range.</p>"]
module UpdateActionStatusList =
  struct
    type t = UpdateActionStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list UpdateActionStatus.to_query v
    let to_headers v =
      Headers.to_headers_list UpdateActionStatus.to_headers v
    let to_json v = `List (List.map UpdateActionStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map UpdateActionStatus.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (UpdateActionStatus.to_xml x))) v
  end
module UpdateActionList =
  struct
    type t = UpdateAction.t list
    let make elems () = elems
    let to_query v = Query.to_query_list UpdateAction.to_query v
    let to_headers v = Headers.to_headers_list UpdateAction.to_headers v
    let to_json v = `List (List.map UpdateAction.to_json v)
    let parse xml =
      Util.option_all
        (List.map UpdateAction.parse (Xml.members "UpdateAction" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (UpdateAction.to_xml x))) v
  end
module EventList =
  struct
    type t = Event.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Event.to_query v
    let to_headers v = Headers.to_headers_list Event.to_headers v
    let to_json v = `List (List.map Event.to_json v)
    let parse xml =
      Util.option_all (List.map Event.parse (Xml.members "Event" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Event.to_xml x))) v
  end
module NodeTypeList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module AZMode =
  struct
    type t =
      | Single_az 
      | Cross_az 
    let str_to_t = [("cross-az", Cross_az); ("single-az", Single_az)]
    let t_to_str = [(Cross_az, "cross-az"); (Single_az, "single-az")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ProcessedUpdateActionList =
  struct
    type t = ProcessedUpdateAction.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ProcessedUpdateAction.to_query v
    let to_headers v =
      Headers.to_headers_list ProcessedUpdateAction.to_headers v
    let to_json v = `List (List.map ProcessedUpdateAction.to_json v)
    let parse xml =
      Util.option_all
        (List.map ProcessedUpdateAction.parse
           (Xml.members "ProcessedUpdateAction" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ProcessedUpdateAction.to_xml x))) v
  end
module UnprocessedUpdateActionList =
  struct
    type t = UnprocessedUpdateAction.t list
    let make elems () = elems
    let to_query v = Query.to_query_list UnprocessedUpdateAction.to_query v
    let to_headers v =
      Headers.to_headers_list UnprocessedUpdateAction.to_headers v
    let to_json v = `List (List.map UnprocessedUpdateAction.to_json v)
    let parse xml =
      Util.option_all
        (List.map UnprocessedUpdateAction.parse
           (Xml.members "UnprocessedUpdateAction" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (UnprocessedUpdateAction.to_xml x)))
        v
  end
module KeyList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ReplicationGroupList =
  struct
    type t = ReplicationGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReplicationGroup.to_query v
    let to_headers v = Headers.to_headers_list ReplicationGroup.to_headers v
    let to_json v = `List (List.map ReplicationGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map ReplicationGroup.parse (Xml.members "ReplicationGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ReplicationGroup.to_xml x)))
        v
  end
module AuthTokenUpdateStrategyType =
  struct
    type t =
      | SET 
      | ROTATE 
    let str_to_t = [("ROTATE", ROTATE); ("SET", SET)]
    let t_to_str = [(ROTATE, "ROTATE"); (SET, "SET")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module CacheEngineVersionList =
  struct
    type t = CacheEngineVersion.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheEngineVersion.to_query v
    let to_headers v =
      Headers.to_headers_list CacheEngineVersion.to_headers v
    let to_json v = `List (List.map CacheEngineVersion.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheEngineVersion.parse
           (Xml.members "CacheEngineVersion" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheEngineVersion.to_xml x))) v
  end
module CacheSecurityGroups =
  struct
    type t = CacheSecurityGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CacheSecurityGroup.to_query v
    let to_headers v =
      Headers.to_headers_list CacheSecurityGroup.to_headers v
    let to_json v = `List (List.map CacheSecurityGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map CacheSecurityGroup.parse
           (Xml.members "CacheSecurityGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheSecurityGroup.to_xml x))) v
  end
module ReservedCacheNodeList =
  struct
    type t = ReservedCacheNode.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReservedCacheNode.to_query v
    let to_headers v = Headers.to_headers_list ReservedCacheNode.to_headers v
    let to_json v = `List (List.map ReservedCacheNode.to_json v)
    let parse xml =
      Util.option_all
        (List.map ReservedCacheNode.parse
           (Xml.members "ReservedCacheNode" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ReservedCacheNode.to_xml x)))
        v
  end
module CreateCacheSecurityGroupResult =
  struct
    type t = {
      cache_security_group: CacheSecurityGroup.t option }
    let make ?cache_security_group  () = { cache_security_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_security_group
              (fun f ->
                 ("cache_security_group", (CacheSecurityGroup.to_json f)))])
    let parse xml =
      Some
        {
          cache_security_group =
            (Util.option_bind (Xml.member "CacheSecurityGroup" xml)
               CacheSecurityGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_security_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSecurityGroup"
                   ([], (CacheSecurityGroup.to_xml f)))])
  end
module ReservedCacheNodesOfferingMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      reserved_cache_nodes_offerings: ReservedCacheNodesOfferingList.t
        [@ocaml.doc
          "<p>A list of reserved cache node offerings. Each element in the list contains detailed information about one offering.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeReservedCacheNodesOfferings</code> operation.</p>"]
    let make ?marker  ?(reserved_cache_nodes_offerings= [])  () =
      { marker; reserved_cache_nodes_offerings }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_cache_nodes_offerings",
                (ReservedCacheNodesOfferingList.to_json
                   v.reserved_cache_nodes_offerings));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          reserved_cache_nodes_offerings =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ReservedCacheNodesOfferings" xml)
                  ReservedCacheNodesOfferingList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ReservedCacheNodesOfferings"
                      ([], (ReservedCacheNodesOfferingList.to_xml [x]))))
              v.reserved_cache_nodes_offerings))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeReservedCacheNodesOfferings</code> operation.</p>"]
module CacheParameterGroupsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      cache_parameter_groups: CacheParameterGroupList.t
        [@ocaml.doc
          "<p>A list of cache parameter groups. Each element in the list contains detailed information about one cache parameter group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeCacheParameterGroups</code> operation.</p>"]
    let make ?marker  ?(cache_parameter_groups= [])  () =
      { marker; cache_parameter_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_parameter_groups",
                (CacheParameterGroupList.to_json v.cache_parameter_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_parameter_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheParameterGroups" xml)
                  CacheParameterGroupList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheParameterGroups"
                      ([], (CacheParameterGroupList.to_xml [x]))))
              v.cache_parameter_groups))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeCacheParameterGroups</code> operation.</p>"]
module DeleteReplicationGroupResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module DescribeSnapshotsListMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      snapshots: SnapshotList.t
        [@ocaml.doc
          "<p>A list of snapshots. Each item in the list contains detailed information about one snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeSnapshots</code> operation.</p>"]
    let make ?marker  ?(snapshots= [])  () = { marker; snapshots }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("snapshots", (SnapshotList.to_json v.snapshots));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          snapshots =
            (Util.of_option []
               (Util.option_bind (Xml.member "Snapshots" xml)
                  SnapshotList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Snapshots"
                      ([], (SnapshotList.to_xml [x])))) v.snapshots))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeSnapshots</code> operation.</p>"]
module CreateReplicationGroupResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module ModifyCacheSubnetGroupResult =
  struct
    type t = {
      cache_subnet_group: CacheSubnetGroup.t option }
    let make ?cache_subnet_group  () = { cache_subnet_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_subnet_group
              (fun f -> ("cache_subnet_group", (CacheSubnetGroup.to_json f)))])
    let parse xml =
      Some
        {
          cache_subnet_group =
            (Util.option_bind (Xml.member "CacheSubnetGroup" xml)
               CacheSubnetGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_subnet_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSubnetGroup"
                   ([], (CacheSubnetGroup.to_xml f)))])
  end
module DeleteCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
  end
module ServiceUpdatesMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      service_updates: ServiceUpdateList.t
        [@ocaml.doc "<p>A list of service updates</p>"]}
    let make ?marker  ?(service_updates= [])  () =
      { marker; service_updates }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("service_updates",
                (ServiceUpdateList.to_json v.service_updates));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          service_updates =
            (Util.of_option []
               (Util.option_bind (Xml.member "ServiceUpdates" xml)
                  ServiceUpdateList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ServiceUpdates"
                      ([], (ServiceUpdateList.to_xml [x]))))
              v.service_updates))
  end
module CacheSubnetGroupMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      cache_subnet_groups: CacheSubnetGroups.t
        [@ocaml.doc
          "<p>A list of cache subnet groups. Each element in the list contains detailed information about one group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeCacheSubnetGroups</code> operation.</p>"]
    let make ?marker  ?(cache_subnet_groups= [])  () =
      { marker; cache_subnet_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_subnet_groups",
                (CacheSubnetGroups.to_json v.cache_subnet_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_subnet_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSubnetGroups" xml)
                  CacheSubnetGroups.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheSubnetGroups"
                      ([], (CacheSubnetGroups.to_xml [x]))))
              v.cache_subnet_groups))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeCacheSubnetGroups</code> operation.</p>"]
module DecreaseReplicaCountResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module CompleteMigrationResponse =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module TagListMessage =
  struct
    type t =
      {
      tag_list: TagList.t
        [@ocaml.doc
          "<p>A list of cost allocation tags as key-value pairs.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output from the <code>AddTagsToResource</code>, <code>ListTagsForResource</code>, and <code>RemoveTagsFromResource</code> operations.</p>"]
    let make ?(tag_list= [])  () = { tag_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_list", (TagList.to_json v.tag_list))])
    let parse xml =
      Some
        {
          tag_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagList" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagList" ([], (TagList.to_xml [x]))))
              v.tag_list))
  end[@@ocaml.doc
       "<p>Represents the output from the <code>AddTagsToResource</code>, <code>ListTagsForResource</code>, and <code>RemoveTagsFromResource</code> operations.</p>"]
module IncreaseReplicaCountResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module CopySnapshotResult =
  struct
    type t = {
      snapshot: Snapshot.t option }
    let make ?snapshot  () = { snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot
              (fun f -> ("snapshot", (Snapshot.to_json f)))])
    let parse xml =
      Some
        {
          snapshot =
            (Util.option_bind (Xml.member "Snapshot" xml) Snapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.snapshot
              (fun f -> Ezxmlm.make_tag "Snapshot" ([], (Snapshot.to_xml f)))])
  end
module RevokeCacheSecurityGroupIngressResult =
  struct
    type t = {
      cache_security_group: CacheSecurityGroup.t option }
    let make ?cache_security_group  () = { cache_security_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_security_group
              (fun f ->
                 ("cache_security_group", (CacheSecurityGroup.to_json f)))])
    let parse xml =
      Some
        {
          cache_security_group =
            (Util.option_bind (Xml.member "CacheSecurityGroup" xml)
               CacheSecurityGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_security_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSecurityGroup"
                   ([], (CacheSecurityGroup.to_xml f)))])
  end
module CacheClusterMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      cache_clusters: CacheClusterList.t
        [@ocaml.doc
          "<p>A list of clusters. Each item in the list contains detailed information about one cluster.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeCacheClusters</code> operation.</p>"]
    let make ?marker  ?(cache_clusters= [])  () = { marker; cache_clusters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_clusters", (CacheClusterList.to_json v.cache_clusters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_clusters =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheClusters" xml)
                  CacheClusterList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheClusters"
                      ([], (CacheClusterList.to_xml [x])))) v.cache_clusters))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeCacheClusters</code> operation.</p>"]
module DescribeEngineDefaultParametersResult =
  struct
    type t = {
      engine_defaults: EngineDefaults.t }
    let make ~engine_defaults  () = { engine_defaults }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("engine_defaults", (EngineDefaults.to_json v.engine_defaults))])
    let parse xml =
      Some
        {
          engine_defaults =
            (Xml.required "EngineDefaults"
               (Util.option_bind (Xml.member "EngineDefaults" xml)
                  EngineDefaults.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "EngineDefaults"
                 ([], (EngineDefaults.to_xml v.engine_defaults)))])
  end
module DeleteSnapshotResult =
  struct
    type t = {
      snapshot: Snapshot.t option }
    let make ?snapshot  () = { snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot
              (fun f -> ("snapshot", (Snapshot.to_json f)))])
    let parse xml =
      Some
        {
          snapshot =
            (Util.option_bind (Xml.member "Snapshot" xml) Snapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.snapshot
              (fun f -> Ezxmlm.make_tag "Snapshot" ([], (Snapshot.to_xml f)))])
  end
module CreateCacheParameterGroupResult =
  struct
    type t = {
      cache_parameter_group: CacheParameterGroup.t option }
    let make ?cache_parameter_group  () = { cache_parameter_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_parameter_group
              (fun f ->
                 ("cache_parameter_group", (CacheParameterGroup.to_json f)))])
    let parse xml =
      Some
        {
          cache_parameter_group =
            (Util.option_bind (Xml.member "CacheParameterGroup" xml)
               CacheParameterGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_parameter_group
              (fun f ->
                 Ezxmlm.make_tag "CacheParameterGroup"
                   ([], (CacheParameterGroup.to_xml f)))])
  end
module CreateCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
  end
module AuthorizeCacheSecurityGroupIngressResult =
  struct
    type t = {
      cache_security_group: CacheSecurityGroup.t option }
    let make ?cache_security_group  () = { cache_security_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_security_group
              (fun f ->
                 ("cache_security_group", (CacheSecurityGroup.to_json f)))])
    let parse xml =
      Some
        {
          cache_security_group =
            (Util.option_bind (Xml.member "CacheSecurityGroup" xml)
               CacheSecurityGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_security_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSecurityGroup"
                   ([], (CacheSecurityGroup.to_xml f)))])
  end
module ModifyReplicationGroupShardConfigurationResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module UpdateActionsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      update_actions: UpdateActionList.t
        [@ocaml.doc "<p>Returns a list of update actions</p>"]}
    let make ?marker  ?(update_actions= [])  () = { marker; update_actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("update_actions", (UpdateActionList.to_json v.update_actions));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          update_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "UpdateActions" xml)
                  UpdateActionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "UpdateActions"
                      ([], (UpdateActionList.to_xml [x])))) v.update_actions))
  end
module EventsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      events: EventList.t
        [@ocaml.doc
          "<p>A list of events. Each element in the list contains detailed information about one event.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeEvents</code> operation.</p>"]
    let make ?marker  ?(events= [])  () = { marker; events }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("events", (EventList.to_json v.events));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          events =
            (Util.of_option []
               (Util.option_bind (Xml.member "Events" xml) EventList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Events" ([], (EventList.to_xml [x]))))
              v.events))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeEvents</code> operation.</p>"]
module AllowedNodeTypeModificationsMessage =
  struct
    type t =
      {
      scale_up_modifications: NodeTypeList.t
        [@ocaml.doc
          "<p>A string list, each element of which specifies a cache node type which you can use to scale your cluster or replication group.</p> <p>When scaling up a Redis cluster or replication group using <code>ModifyCacheCluster</code> or <code>ModifyReplicationGroup</code>, use a value from this list for the <code>CacheNodeType</code> parameter.</p>"];
      scale_down_modifications: NodeTypeList.t
        [@ocaml.doc
          "<p>A string list, each element of which specifies a cache node type which you can use to scale your cluster or replication group.</p> <p>When scaling down on a Redis cluster or replication group using <code>ModifyCacheCluster</code> or <code>ModifyReplicationGroup</code>, use a value from this list for the <code>CacheNodeType</code> parameter.</p>"]}
    [@@ocaml.doc
      "<p>Represents the allowed node types you can use to modify your cluster or replication group.</p>"]
    let make ?(scale_up_modifications= [])  ?(scale_down_modifications= []) 
      () = { scale_up_modifications; scale_down_modifications }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scale_down_modifications",
                (NodeTypeList.to_json v.scale_down_modifications));
           Some
             ("scale_up_modifications",
               (NodeTypeList.to_json v.scale_up_modifications))])
    let parse xml =
      Some
        {
          scale_up_modifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "ScaleUpModifications" xml)
                  NodeTypeList.parse));
          scale_down_modifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "ScaleDownModifications" xml)
                  NodeTypeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ScaleUpModifications"
                       ([], (NodeTypeList.to_xml [x]))))
               v.scale_up_modifications))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ScaleDownModifications"
                      ([], (NodeTypeList.to_xml [x]))))
              v.scale_down_modifications))
  end[@@ocaml.doc
       "<p>Represents the allowed node types you can use to modify your cluster or replication group.</p>"]
module CreateSnapshotResult =
  struct
    type t = {
      snapshot: Snapshot.t option }
    let make ?snapshot  () = { snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot
              (fun f -> ("snapshot", (Snapshot.to_json f)))])
    let parse xml =
      Some
        {
          snapshot =
            (Util.option_bind (Xml.member "Snapshot" xml) Snapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.snapshot
              (fun f -> Ezxmlm.make_tag "Snapshot" ([], (Snapshot.to_xml f)))])
  end
module ModifyCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
  end
module UpdateActionResultsMessage =
  struct
    type t =
      {
      processed_update_actions: ProcessedUpdateActionList.t
        [@ocaml.doc
          "<p>Update actions that have been processed successfully</p>"];
      unprocessed_update_actions: UnprocessedUpdateActionList.t
        [@ocaml.doc
          "<p>Update actions that haven't been processed successfully</p>"]}
    let make ?(processed_update_actions= [])  ?(unprocessed_update_actions=
      [])  () = { processed_update_actions; unprocessed_update_actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("unprocessed_update_actions",
                (UnprocessedUpdateActionList.to_json
                   v.unprocessed_update_actions));
           Some
             ("processed_update_actions",
               (ProcessedUpdateActionList.to_json v.processed_update_actions))])
    let parse xml =
      Some
        {
          processed_update_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProcessedUpdateActions" xml)
                  ProcessedUpdateActionList.parse));
          unprocessed_update_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "UnprocessedUpdateActions" xml)
                  UnprocessedUpdateActionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ProcessedUpdateActions"
                       ([], (ProcessedUpdateActionList.to_xml [x]))))
               v.processed_update_actions))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "UnprocessedUpdateActions"
                      ([], (UnprocessedUpdateActionList.to_xml [x]))))
              v.unprocessed_update_actions))
  end
module ReplicationGroupMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      replication_groups: ReplicationGroupList.t
        [@ocaml.doc
          "<p>A list of replication groups. Each item in the list contains detailed information about one replication group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeReplicationGroups</code> operation.</p>"]
    let make ?marker  ?(replication_groups= [])  () =
      { marker; replication_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("replication_groups",
                (ReplicationGroupList.to_json v.replication_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          replication_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicationGroups" xml)
                  ReplicationGroupList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ReplicationGroups"
                      ([], (ReplicationGroupList.to_xml [x]))))
              v.replication_groups))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeReplicationGroups</code> operation.</p>"]
module CacheParameterGroupDetails =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      parameters: ParametersList.t
        [@ocaml.doc "<p>A list of <a>Parameter</a> instances.</p>"];
      cache_node_type_specific_parameters:
        CacheNodeTypeSpecificParametersList.t
        [@ocaml.doc
          "<p>A list of parameters specific to a particular cache node type. Each element in the list contains detailed information about one parameter.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeCacheParameters</code> operation.</p>"]
    let make ?marker  ?(parameters= []) 
      ?(cache_node_type_specific_parameters= [])  () =
      { marker; parameters; cache_node_type_specific_parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_node_type_specific_parameters",
                (CacheNodeTypeSpecificParametersList.to_json
                   v.cache_node_type_specific_parameters));
           Some ("parameters", (ParametersList.to_json v.parameters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse));
          cache_node_type_specific_parameters =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "CacheNodeTypeSpecificParameters" xml)
                  CacheNodeTypeSpecificParametersList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.marker
                (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Parameters"
                       ([], (ParametersList.to_xml [x])))) v.parameters))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheNodeTypeSpecificParameters"
                      ([], (CacheNodeTypeSpecificParametersList.to_xml [x]))))
              v.cache_node_type_specific_parameters))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeCacheParameters</code> operation.</p>"]
module TestFailoverResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module CacheEngineVersionMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      cache_engine_versions: CacheEngineVersionList.t
        [@ocaml.doc
          "<p>A list of cache engine version details. Each element in the list contains detailed information about one cache engine version.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <a>DescribeCacheEngineVersions</a> operation.</p>"]
    let make ?marker  ?(cache_engine_versions= [])  () =
      { marker; cache_engine_versions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_engine_versions",
                (CacheEngineVersionList.to_json v.cache_engine_versions));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_engine_versions =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheEngineVersions" xml)
                  CacheEngineVersionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheEngineVersions"
                      ([], (CacheEngineVersionList.to_xml [x]))))
              v.cache_engine_versions))
  end[@@ocaml.doc
       "<p>Represents the output of a <a>DescribeCacheEngineVersions</a> operation.</p>"]
module PurchaseReservedCacheNodesOfferingResult =
  struct
    type t = {
      reserved_cache_node: ReservedCacheNode.t option }
    let make ?reserved_cache_node  () = { reserved_cache_node }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reserved_cache_node
              (fun f ->
                 ("reserved_cache_node", (ReservedCacheNode.to_json f)))])
    let parse xml =
      Some
        {
          reserved_cache_node =
            (Util.option_bind (Xml.member "ReservedCacheNode" xml)
               ReservedCacheNode.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.reserved_cache_node
              (fun f ->
                 Ezxmlm.make_tag "ReservedCacheNode"
                   ([], (ReservedCacheNode.to_xml f)))])
  end
module ModifyReplicationGroupResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module CacheSecurityGroupMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      cache_security_groups: CacheSecurityGroups.t
        [@ocaml.doc
          "<p>A list of cache security groups. Each element in the list contains detailed information about one group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeCacheSecurityGroups</code> operation.</p>"]
    let make ?marker  ?(cache_security_groups= [])  () =
      { marker; cache_security_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_security_groups",
                (CacheSecurityGroups.to_json v.cache_security_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSecurityGroups" xml)
                  CacheSecurityGroups.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheSecurityGroups"
                      ([], (CacheSecurityGroups.to_xml [x]))))
              v.cache_security_groups))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeCacheSecurityGroups</code> operation.</p>"]
module RebootCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
  end
module StartMigrationResponse =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
  end
module CreateCacheSubnetGroupResult =
  struct
    type t = {
      cache_subnet_group: CacheSubnetGroup.t option }
    let make ?cache_subnet_group  () = { cache_subnet_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_subnet_group
              (fun f -> ("cache_subnet_group", (CacheSubnetGroup.to_json f)))])
    let parse xml =
      Some
        {
          cache_subnet_group =
            (Util.option_bind (Xml.member "CacheSubnetGroup" xml)
               CacheSubnetGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_subnet_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSubnetGroup"
                   ([], (CacheSubnetGroup.to_xml f)))])
  end
module CacheParameterGroupNameMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option
        [@ocaml.doc "<p>The name of the cache parameter group.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of one of the following operations:</p> <ul> <li> <p> <code>ModifyCacheParameterGroup</code> </p> </li> <li> <p> <code>ResetCacheParameterGroup</code> </p> </li> </ul>"]
    let make ?cache_parameter_group_name  () = { cache_parameter_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_parameter_group_name
              (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_parameter_group_name
              (fun f ->
                 Ezxmlm.make_tag "CacheParameterGroupName"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the output of one of the following operations:</p> <ul> <li> <p> <code>ModifyCacheParameterGroup</code> </p> </li> <li> <p> <code>ResetCacheParameterGroup</code> </p> </li> </ul>"]
module ReservedCacheNodeMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>Provides an identifier to allow retrieval of paginated results.</p>"];
      reserved_cache_nodes: ReservedCacheNodeList.t
        [@ocaml.doc
          "<p>A list of reserved cache nodes. Each element in the list contains detailed information about one node.</p>"]}
    [@@ocaml.doc
      "<p>Represents the output of a <code>DescribeReservedCacheNodes</code> operation.</p>"]
    let make ?marker  ?(reserved_cache_nodes= [])  () =
      { marker; reserved_cache_nodes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_cache_nodes",
                (ReservedCacheNodeList.to_json v.reserved_cache_nodes));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          reserved_cache_nodes =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReservedCacheNodes" xml)
                  ReservedCacheNodeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ReservedCacheNodes"
                      ([], (ReservedCacheNodeList.to_xml [x]))))
              v.reserved_cache_nodes))
  end[@@ocaml.doc
       "<p>Represents the output of a <code>DescribeReservedCacheNodes</code> operation.</p>"]