open Aws
open Aws.BaseTypes
open CalendarLib
type calendar = Calendar.t
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Endpoint =
  struct
    type t = {
      address: String.t option ;
      port: Integer.t option }
    let make ?address  ?port  () = { address; port }
    let parse xml =
      Some
        {
          address =
            (Util.option_bind (Xml.member "Address" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.address
               (fun f -> Ezxmlm.make_tag "Address" ([], (String.to_xml f)))])
           @
           [Util.option_map v.port
              (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.address
             (fun f -> ("address", (String.to_json f)))])
    let of_json j =
      {
        address = (Util.option_map (Json.lookup j "address") String.of_json);
        port = (Util.option_map (Json.lookup j "port") Integer.of_json)
      }
  end
module AvailabilityZonesList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "AvailabilityZone" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module NodeGroupMemberUpdateStatus =
  struct
    type t =
      {
      cache_cluster_id: String.t option ;
      cache_node_id: String.t option ;
      node_update_status: NodeUpdateStatus.t option ;
      node_deletion_date: DateTime.t option ;
      node_update_start_date: DateTime.t option ;
      node_update_end_date: DateTime.t option ;
      node_update_initiated_by: NodeUpdateInitiatedBy.t option ;
      node_update_initiated_date: DateTime.t option ;
      node_update_status_modified_date: DateTime.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        cache_node_id =
          (Util.option_map (Json.lookup j "cache_node_id") String.of_json);
        node_update_status =
          (Util.option_map (Json.lookup j "node_update_status")
             NodeUpdateStatus.of_json);
        node_deletion_date =
          (Util.option_map (Json.lookup j "node_deletion_date")
             DateTime.of_json);
        node_update_start_date =
          (Util.option_map (Json.lookup j "node_update_start_date")
             DateTime.of_json);
        node_update_end_date =
          (Util.option_map (Json.lookup j "node_update_end_date")
             DateTime.of_json);
        node_update_initiated_by =
          (Util.option_map (Json.lookup j "node_update_initiated_by")
             NodeUpdateInitiatedBy.of_json);
        node_update_initiated_date =
          (Util.option_map (Json.lookup j "node_update_initiated_date")
             DateTime.of_json);
        node_update_status_modified_date =
          (Util.option_map (Json.lookup j "node_update_status_modified_date")
             DateTime.of_json)
      }
  end
module NodeGroupMember =
  struct
    type t =
      {
      cache_cluster_id: String.t option ;
      cache_node_id: String.t option ;
      read_endpoint: Endpoint.t option ;
      preferred_availability_zone: String.t option ;
      current_role: String.t option }
    let make ?cache_cluster_id  ?cache_node_id  ?read_endpoint 
      ?preferred_availability_zone  ?current_role  () =
      {
        cache_cluster_id;
        cache_node_id;
        read_endpoint;
        preferred_availability_zone;
        current_role
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        cache_node_id =
          (Util.option_map (Json.lookup j "cache_node_id") String.of_json);
        read_endpoint =
          (Util.option_map (Json.lookup j "read_endpoint") Endpoint.of_json);
        preferred_availability_zone =
          (Util.option_map (Json.lookup j "preferred_availability_zone")
             String.of_json);
        current_role =
          (Util.option_map (Json.lookup j "current_role") String.of_json)
      }
  end
module NodeGroupConfiguration =
  struct
    type t =
      {
      node_group_id: String.t option ;
      slots: String.t option ;
      replica_count: Integer.t option ;
      primary_availability_zone: String.t option ;
      replica_availability_zones: AvailabilityZonesList.t }
    let make ?node_group_id  ?slots  ?replica_count 
      ?primary_availability_zone  ?(replica_availability_zones= [])  () =
      {
        node_group_id;
        slots;
        replica_count;
        primary_availability_zone;
        replica_availability_zones
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        node_group_id =
          (Util.option_map (Json.lookup j "node_group_id") String.of_json);
        slots = (Util.option_map (Json.lookup j "slots") String.of_json);
        replica_count =
          (Util.option_map (Json.lookup j "replica_count") Integer.of_json);
        primary_availability_zone =
          (Util.option_map (Json.lookup j "primary_availability_zone")
             String.of_json);
        replica_availability_zones =
          (AvailabilityZonesList.of_json
             (Util.of_option_exn (Json.lookup j "replica_availability_zones")))
      }
  end
module AvailabilityZone =
  struct
    type t = {
      name: String.t option }
    let make ?name  () = { name }
    let parse xml =
      Some { name = (Util.option_bind (Xml.member "Name" xml) String.parse) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.name
              (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      { name = (Util.option_map (Json.lookup j "name") String.of_json) }
  end
module CacheNodeTypeSpecificValue =
  struct
    type t = {
      cache_node_type: String.t option ;
      value: String.t option }
    let make ?cache_node_type  ?value  () = { cache_node_type; value }
    let parse xml =
      Some
        {
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.cache_node_type
               (fun f ->
                  Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)))])
    let of_json j =
      {
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        value = (Util.option_map (Json.lookup j "value") String.of_json)
      }
  end
module NodeGroupMemberUpdateStatusList =
  struct
    type t = NodeGroupMemberUpdateStatus.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NodeGroupMemberUpdateStatus.parse
           (Xml.members "NodeGroupMemberUpdateStatus" xml))
    let to_query v =
      Query.to_query_list NodeGroupMemberUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list NodeGroupMemberUpdateStatus.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (NodeGroupMemberUpdateStatus.to_xml x))) v
    let to_json v = `List (List.map NodeGroupMemberUpdateStatus.to_json v)
    let of_json j = Json.to_list NodeGroupMemberUpdateStatus.of_json j
  end
module NodeGroupMemberList =
  struct
    type t = NodeGroupMember.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NodeGroupMember.parse (Xml.members "NodeGroupMember" xml))
    let to_query v = Query.to_query_list NodeGroupMember.to_query v
    let to_headers v = Headers.to_headers_list NodeGroupMember.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (NodeGroupMember.to_xml x)))
        v
    let to_json v = `List (List.map NodeGroupMember.to_json v)
    let of_json j = Json.to_list NodeGroupMember.of_json j
  end
module SlotMigration =
  struct
    type t = {
      progress_percentage: Double.t option }
    let make ?progress_percentage  () = { progress_percentage }
    let parse xml =
      Some
        {
          progress_percentage =
            (Util.option_bind (Xml.member "ProgressPercentage" xml)
               Double.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.progress_percentage
              (fun f ->
                 Ezxmlm.make_tag "ProgressPercentage" ([], (Double.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.progress_percentage
              (fun f -> ("progress_percentage", (Double.to_json f)))])
    let of_json j =
      {
        progress_percentage =
          (Util.option_map (Json.lookup j "progress_percentage")
             Double.of_json)
      }
  end
module RecurringCharge =
  struct
    type t =
      {
      recurring_charge_amount: Double.t option ;
      recurring_charge_frequency: String.t option }
    let make ?recurring_charge_amount  ?recurring_charge_frequency  () =
      { recurring_charge_amount; recurring_charge_frequency }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.recurring_charge_frequency
              (fun f -> ("recurring_charge_frequency", (String.to_json f)));
           Util.option_map v.recurring_charge_amount
             (fun f -> ("recurring_charge_amount", (Double.to_json f)))])
    let of_json j =
      {
        recurring_charge_amount =
          (Util.option_map (Json.lookup j "recurring_charge_amount")
             Double.of_json);
        recurring_charge_frequency =
          (Util.option_map (Json.lookup j "recurring_charge_frequency")
             String.of_json)
      }
  end
module NodeSnapshot =
  struct
    type t =
      {
      cache_cluster_id: String.t option ;
      node_group_id: String.t option ;
      cache_node_id: String.t option ;
      node_group_configuration: NodeGroupConfiguration.t option ;
      cache_size: String.t option ;
      cache_node_create_time: DateTime.t option ;
      snapshot_create_time: DateTime.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        node_group_id =
          (Util.option_map (Json.lookup j "node_group_id") String.of_json);
        cache_node_id =
          (Util.option_map (Json.lookup j "cache_node_id") String.of_json);
        node_group_configuration =
          (Util.option_map (Json.lookup j "node_group_configuration")
             NodeGroupConfiguration.of_json);
        cache_size =
          (Util.option_map (Json.lookup j "cache_size") String.of_json);
        cache_node_create_time =
          (Util.option_map (Json.lookup j "cache_node_create_time")
             DateTime.of_json);
        snapshot_create_time =
          (Util.option_map (Json.lookup j "snapshot_create_time")
             DateTime.of_json)
      }
  end
module Subnet =
  struct
    type t =
      {
      subnet_identifier: String.t option ;
      subnet_availability_zone: AvailabilityZone.t option }
    let make ?subnet_identifier  ?subnet_availability_zone  () =
      { subnet_identifier; subnet_availability_zone }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.subnet_availability_zone
              (fun f ->
                 ("subnet_availability_zone", (AvailabilityZone.to_json f)));
           Util.option_map v.subnet_identifier
             (fun f -> ("subnet_identifier", (String.to_json f)))])
    let of_json j =
      {
        subnet_identifier =
          (Util.option_map (Json.lookup j "subnet_identifier") String.of_json);
        subnet_availability_zone =
          (Util.option_map (Json.lookup j "subnet_availability_zone")
             AvailabilityZone.of_json)
      }
  end
module CacheNode =
  struct
    type t =
      {
      cache_node_id: String.t option ;
      cache_node_status: String.t option ;
      cache_node_create_time: DateTime.t option ;
      endpoint: Endpoint.t option ;
      parameter_group_status: String.t option ;
      source_cache_node_id: String.t option ;
      customer_availability_zone: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_node_id =
          (Util.option_map (Json.lookup j "cache_node_id") String.of_json);
        cache_node_status =
          (Util.option_map (Json.lookup j "cache_node_status") String.of_json);
        cache_node_create_time =
          (Util.option_map (Json.lookup j "cache_node_create_time")
             DateTime.of_json);
        endpoint =
          (Util.option_map (Json.lookup j "endpoint") Endpoint.of_json);
        parameter_group_status =
          (Util.option_map (Json.lookup j "parameter_group_status")
             String.of_json);
        source_cache_node_id =
          (Util.option_map (Json.lookup j "source_cache_node_id")
             String.of_json);
        customer_availability_zone =
          (Util.option_map (Json.lookup j "customer_availability_zone")
             String.of_json)
      }
  end
module CacheNodeIdsList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "CacheNodeId" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CacheSecurityGroupMembership =
  struct
    type t =
      {
      cache_security_group_name: String.t option ;
      status: String.t option }
    let make ?cache_security_group_name  ?status  () =
      { cache_security_group_name; status }
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.cache_security_group_name
             (fun f -> ("cache_security_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_security_group_name =
          (Util.option_map (Json.lookup j "cache_security_group_name")
             String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json)
      }
  end
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module SecurityGroupMembership =
  struct
    type t = {
      security_group_id: String.t option ;
      status: String.t option }
    let make ?security_group_id  ?status  () = { security_group_id; status }
    let parse xml =
      Some
        {
          security_group_id =
            (Util.option_bind (Xml.member "SecurityGroupId" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.security_group_id
               (fun f ->
                  Ezxmlm.make_tag "SecurityGroupId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.security_group_id
             (fun f -> ("security_group_id", (String.to_json f)))])
    let of_json j =
      {
        security_group_id =
          (Util.option_map (Json.lookup j "security_group_id") String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json)
      }
  end
module CacheNodeTypeSpecificValueList =
  struct
    type t = CacheNodeTypeSpecificValue.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheNodeTypeSpecificValue.parse
           (Xml.members "CacheNodeTypeSpecificValue" xml))
    let to_query v =
      Query.to_query_list CacheNodeTypeSpecificValue.to_query v
    let to_headers v =
      Headers.to_headers_list CacheNodeTypeSpecificValue.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (CacheNodeTypeSpecificValue.to_xml x))) v
    let to_json v = `List (List.map CacheNodeTypeSpecificValue.to_json v)
    let of_json j = Json.to_list CacheNodeTypeSpecificValue.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module CacheNodeUpdateStatus =
  struct
    type t =
      {
      cache_node_id: String.t option ;
      node_update_status: NodeUpdateStatus.t option ;
      node_deletion_date: DateTime.t option ;
      node_update_start_date: DateTime.t option ;
      node_update_end_date: DateTime.t option ;
      node_update_initiated_by: NodeUpdateInitiatedBy.t option ;
      node_update_initiated_date: DateTime.t option ;
      node_update_status_modified_date: DateTime.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_node_id =
          (Util.option_map (Json.lookup j "cache_node_id") String.of_json);
        node_update_status =
          (Util.option_map (Json.lookup j "node_update_status")
             NodeUpdateStatus.of_json);
        node_deletion_date =
          (Util.option_map (Json.lookup j "node_deletion_date")
             DateTime.of_json);
        node_update_start_date =
          (Util.option_map (Json.lookup j "node_update_start_date")
             DateTime.of_json);
        node_update_end_date =
          (Util.option_map (Json.lookup j "node_update_end_date")
             DateTime.of_json);
        node_update_initiated_by =
          (Util.option_map (Json.lookup j "node_update_initiated_by")
             NodeUpdateInitiatedBy.of_json);
        node_update_initiated_date =
          (Util.option_map (Json.lookup j "node_update_initiated_date")
             DateTime.of_json);
        node_update_status_modified_date =
          (Util.option_map (Json.lookup j "node_update_status_modified_date")
             DateTime.of_json)
      }
  end
module NodeGroupUpdateStatus =
  struct
    type t =
      {
      node_group_id: String.t option ;
      node_group_member_update_status: NodeGroupMemberUpdateStatusList.t }
    let make ?node_group_id  ?(node_group_member_update_status= [])  () =
      { node_group_id; node_group_member_update_status }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("node_group_member_update_status",
                (NodeGroupMemberUpdateStatusList.to_json
                   v.node_group_member_update_status));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)))])
    let of_json j =
      {
        node_group_id =
          (Util.option_map (Json.lookup j "node_group_id") String.of_json);
        node_group_member_update_status =
          (NodeGroupMemberUpdateStatusList.of_json
             (Util.of_option_exn
                (Json.lookup j "node_group_member_update_status")))
      }
  end
module NodeGroup =
  struct
    type t =
      {
      node_group_id: String.t option ;
      status: String.t option ;
      primary_endpoint: Endpoint.t option ;
      reader_endpoint: Endpoint.t option ;
      slots: String.t option ;
      node_group_members: NodeGroupMemberList.t }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        node_group_id =
          (Util.option_map (Json.lookup j "node_group_id") String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        primary_endpoint =
          (Util.option_map (Json.lookup j "primary_endpoint")
             Endpoint.of_json);
        reader_endpoint =
          (Util.option_map (Json.lookup j "reader_endpoint") Endpoint.of_json);
        slots = (Util.option_map (Json.lookup j "slots") String.of_json);
        node_group_members =
          (NodeGroupMemberList.of_json
             (Util.of_option_exn (Json.lookup j "node_group_members")))
      }
  end
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ReshardingStatus =
  struct
    type t = {
      slot_migration: SlotMigration.t option }
    let make ?slot_migration  () = { slot_migration }
    let parse xml =
      Some
        {
          slot_migration =
            (Util.option_bind (Xml.member "SlotMigration" xml)
               SlotMigration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.slot_migration
              (fun f ->
                 Ezxmlm.make_tag "SlotMigration"
                   ([], (SlotMigration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.slot_migration
              (fun f -> ("slot_migration", (SlotMigration.to_json f)))])
    let of_json j =
      {
        slot_migration =
          (Util.option_map (Json.lookup j "slot_migration")
             SlotMigration.of_json)
      }
  end
module EC2SecurityGroup =
  struct
    type t =
      {
      status: String.t option ;
      e_c2_security_group_name: String.t option ;
      e_c2_security_group_owner_id: String.t option }
    let make ?status  ?e_c2_security_group_name 
      ?e_c2_security_group_owner_id  () =
      { status; e_c2_security_group_name; e_c2_security_group_owner_id }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f -> ("e_c2_security_group_owner_id", (String.to_json f)));
           Util.option_map v.e_c2_security_group_name
             (fun f -> ("e_c2_security_group_name", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)))])
    let of_json j =
      {
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        e_c2_security_group_name =
          (Util.option_map (Json.lookup j "e_c2_security_group_name")
             String.of_json);
        e_c2_security_group_owner_id =
          (Util.option_map (Json.lookup j "e_c2_security_group_owner_id")
             String.of_json)
      }
  end
module RecurringChargeList =
  struct
    type t = RecurringCharge.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map RecurringCharge.parse (Xml.members "RecurringCharge" xml))
    let to_query v = Query.to_query_list RecurringCharge.to_query v
    let to_headers v = Headers.to_headers_list RecurringCharge.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (RecurringCharge.to_xml x)))
        v
    let to_json v = `List (List.map RecurringCharge.to_json v)
    let of_json j = Json.to_list RecurringCharge.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module NodeSnapshotList =
  struct
    type t = NodeSnapshot.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NodeSnapshot.parse (Xml.members "NodeSnapshot" xml))
    let to_query v = Query.to_query_list NodeSnapshot.to_query v
    let to_headers v = Headers.to_headers_list NodeSnapshot.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (NodeSnapshot.to_xml x))) v
    let to_json v = `List (List.map NodeSnapshot.to_json v)
    let of_json j = Json.to_list NodeSnapshot.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module SubnetList =
  struct
    type t = Subnet.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Subnet.parse (Xml.members "Subnet" xml))
    let to_query v = Query.to_query_list Subnet.to_query v
    let to_headers v = Headers.to_headers_list Subnet.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Subnet.to_xml x))) v
    let to_json v = `List (List.map Subnet.to_json v)
    let of_json j = Json.to_list Subnet.of_json j
  end
module PreferredAvailabilityZoneList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "PreferredAvailabilityZone" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CacheNodeList =
  struct
    type t = CacheNode.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheNode.parse (Xml.members "CacheNode" xml))
    let to_query v = Query.to_query_list CacheNode.to_query v
    let to_headers v = Headers.to_headers_list CacheNode.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (CacheNode.to_xml x)))
        v
    let to_json v = `List (List.map CacheNode.to_json v)
    let of_json j = Json.to_list CacheNode.of_json j
  end
module CacheParameterGroupStatus =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option ;
      parameter_apply_status: String.t option ;
      cache_node_ids_to_reboot: CacheNodeIdsList.t }
    let make ?cache_parameter_group_name  ?parameter_apply_status 
      ?(cache_node_ids_to_reboot= [])  () =
      {
        cache_parameter_group_name;
        parameter_apply_status;
        cache_node_ids_to_reboot
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        parameter_apply_status =
          (Util.option_map (Json.lookup j "parameter_apply_status")
             String.of_json);
        cache_node_ids_to_reboot =
          (CacheNodeIdsList.of_json
             (Util.of_option_exn (Json.lookup j "cache_node_ids_to_reboot")))
      }
  end
module CacheSecurityGroupMembershipList =
  struct
    type t = CacheSecurityGroupMembership.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheSecurityGroupMembership.parse
           (Xml.members "CacheSecurityGroup" xml))
    let to_query v =
      Query.to_query_list CacheSecurityGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list CacheSecurityGroupMembership.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (CacheSecurityGroupMembership.to_xml x))) v
    let to_json v = `List (List.map CacheSecurityGroupMembership.to_json v)
    let of_json j = Json.to_list CacheSecurityGroupMembership.of_json j
  end
module NotificationConfiguration =
  struct
    type t = {
      topic_arn: String.t option ;
      topic_status: String.t option }
    let make ?topic_arn  ?topic_status  () = { topic_arn; topic_status }
    let parse xml =
      Some
        {
          topic_arn =
            (Util.option_bind (Xml.member "TopicArn" xml) String.parse);
          topic_status =
            (Util.option_bind (Xml.member "TopicStatus" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.topic_arn
               (fun f -> Ezxmlm.make_tag "TopicArn" ([], (String.to_xml f)))])
           @
           [Util.option_map v.topic_status
              (fun f -> Ezxmlm.make_tag "TopicStatus" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.topic_status
              (fun f -> ("topic_status", (String.to_json f)));
           Util.option_map v.topic_arn
             (fun f -> ("topic_arn", (String.to_json f)))])
    let of_json j =
      {
        topic_arn =
          (Util.option_map (Json.lookup j "topic_arn") String.of_json);
        topic_status =
          (Util.option_map (Json.lookup j "topic_status") String.of_json)
      }
  end
module PendingModifiedValues =
  struct
    type t =
      {
      num_cache_nodes: Integer.t option ;
      cache_node_ids_to_remove: CacheNodeIdsList.t ;
      engine_version: String.t option ;
      cache_node_type: String.t option ;
      auth_token_status: AuthTokenUpdateStatus.t option }
    let make ?num_cache_nodes  ?(cache_node_ids_to_remove= []) 
      ?engine_version  ?cache_node_type  ?auth_token_status  () =
      {
        num_cache_nodes;
        cache_node_ids_to_remove;
        engine_version;
        cache_node_type;
        auth_token_status
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        num_cache_nodes =
          (Util.option_map (Json.lookup j "num_cache_nodes") Integer.of_json);
        cache_node_ids_to_remove =
          (CacheNodeIdsList.of_json
             (Util.of_option_exn (Json.lookup j "cache_node_ids_to_remove")));
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        auth_token_status =
          (Util.option_map (Json.lookup j "auth_token_status")
             AuthTokenUpdateStatus.of_json)
      }
  end
module SecurityGroupMembershipList =
  struct
    type t = SecurityGroupMembership.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map SecurityGroupMembership.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list SecurityGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list SecurityGroupMembership.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (SecurityGroupMembership.to_xml x)))
        v
    let to_json v = `List (List.map SecurityGroupMembership.to_json v)
    let of_json j = Json.to_list SecurityGroupMembership.of_json j
  end
module CacheNodeTypeSpecificParameter =
  struct
    type t =
      {
      parameter_name: String.t option ;
      description: String.t option ;
      source: String.t option ;
      data_type: String.t option ;
      allowed_values: String.t option ;
      is_modifiable: Boolean.t option ;
      minimum_engine_version: String.t option ;
      cache_node_type_specific_values: CacheNodeTypeSpecificValueList.t ;
      change_type: ChangeType.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        parameter_name =
          (Util.option_map (Json.lookup j "parameter_name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        source = (Util.option_map (Json.lookup j "source") String.of_json);
        data_type =
          (Util.option_map (Json.lookup j "data_type") String.of_json);
        allowed_values =
          (Util.option_map (Json.lookup j "allowed_values") String.of_json);
        is_modifiable =
          (Util.option_map (Json.lookup j "is_modifiable") Boolean.of_json);
        minimum_engine_version =
          (Util.option_map (Json.lookup j "minimum_engine_version")
             String.of_json);
        cache_node_type_specific_values =
          (CacheNodeTypeSpecificValueList.of_json
             (Util.of_option_exn
                (Json.lookup j "cache_node_type_specific_values")));
        change_type =
          (Util.option_map (Json.lookup j "change_type") ChangeType.of_json)
      }
  end
module Parameter =
  struct
    type t =
      {
      parameter_name: String.t option ;
      parameter_value: String.t option ;
      description: String.t option ;
      source: String.t option ;
      data_type: String.t option ;
      allowed_values: String.t option ;
      is_modifiable: Boolean.t option ;
      minimum_engine_version: String.t option ;
      change_type: ChangeType.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        parameter_name =
          (Util.option_map (Json.lookup j "parameter_name") String.of_json);
        parameter_value =
          (Util.option_map (Json.lookup j "parameter_value") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        source = (Util.option_map (Json.lookup j "source") String.of_json);
        data_type =
          (Util.option_map (Json.lookup j "data_type") String.of_json);
        allowed_values =
          (Util.option_map (Json.lookup j "allowed_values") String.of_json);
        is_modifiable =
          (Util.option_map (Json.lookup j "is_modifiable") Boolean.of_json);
        minimum_engine_version =
          (Util.option_map (Json.lookup j "minimum_engine_version")
             String.of_json);
        change_type =
          (Util.option_map (Json.lookup j "change_type") ChangeType.of_json)
      }
  end
module CacheNodeUpdateStatusList =
  struct
    type t = CacheNodeUpdateStatus.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheNodeUpdateStatus.parse
           (Xml.members "CacheNodeUpdateStatus" xml))
    let to_query v = Query.to_query_list CacheNodeUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list CacheNodeUpdateStatus.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheNodeUpdateStatus.to_xml x))) v
    let to_json v = `List (List.map CacheNodeUpdateStatus.to_json v)
    let of_json j = Json.to_list CacheNodeUpdateStatus.of_json j
  end
module NodeGroupUpdateStatusList =
  struct
    type t = NodeGroupUpdateStatus.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NodeGroupUpdateStatus.parse
           (Xml.members "NodeGroupUpdateStatus" xml))
    let to_query v = Query.to_query_list NodeGroupUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list NodeGroupUpdateStatus.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (NodeGroupUpdateStatus.to_xml x))) v
    let to_json v = `List (List.map NodeGroupUpdateStatus.to_json v)
    let of_json j = Json.to_list NodeGroupUpdateStatus.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ClusterIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "ClusterId" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module NodeGroupList =
  struct
    type t = NodeGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NodeGroup.parse (Xml.members "NodeGroup" xml))
    let to_query v = Query.to_query_list NodeGroup.to_query v
    let to_headers v = Headers.to_headers_list NodeGroup.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (NodeGroup.to_xml x)))
        v
    let to_json v = `List (List.map NodeGroup.to_json v)
    let of_json j = Json.to_list NodeGroup.of_json j
  end
module ReplicationGroupPendingModifiedValues =
  struct
    type t =
      {
      primary_cluster_id: String.t option ;
      automatic_failover_status: PendingAutomaticFailoverStatus.t option ;
      resharding: ReshardingStatus.t option ;
      auth_token_status: AuthTokenUpdateStatus.t option }
    let make ?primary_cluster_id  ?automatic_failover_status  ?resharding 
      ?auth_token_status  () =
      {
        primary_cluster_id;
        automatic_failover_status;
        resharding;
        auth_token_status
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        primary_cluster_id =
          (Util.option_map (Json.lookup j "primary_cluster_id")
             String.of_json);
        automatic_failover_status =
          (Util.option_map (Json.lookup j "automatic_failover_status")
             PendingAutomaticFailoverStatus.of_json);
        resharding =
          (Util.option_map (Json.lookup j "resharding")
             ReshardingStatus.of_json);
        auth_token_status =
          (Util.option_map (Json.lookup j "auth_token_status")
             AuthTokenUpdateStatus.of_json)
      }
  end
module EC2SecurityGroupList =
  struct
    type t = EC2SecurityGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map EC2SecurityGroup.parse (Xml.members "EC2SecurityGroup" xml))
    let to_query v = Query.to_query_list EC2SecurityGroup.to_query v
    let to_headers v = Headers.to_headers_list EC2SecurityGroup.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (EC2SecurityGroup.to_xml x)))
        v
    let to_json v = `List (List.map EC2SecurityGroup.to_json v)
    let of_json j = Json.to_list EC2SecurityGroup.of_json j
  end
module CustomerNodeEndpoint =
  struct
    type t = {
      address: String.t option ;
      port: Integer.t option }
    let make ?address  ?port  () = { address; port }
    let parse xml =
      Some
        {
          address =
            (Util.option_bind (Xml.member "Address" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.address
               (fun f -> Ezxmlm.make_tag "Address" ([], (String.to_xml f)))])
           @
           [Util.option_map v.port
              (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.address
             (fun f -> ("address", (String.to_json f)))])
    let of_json j =
      {
        address = (Util.option_map (Json.lookup j "address") String.of_json);
        port = (Util.option_map (Json.lookup j "port") Integer.of_json)
      }
  end
module ReservedCacheNodesOffering =
  struct
    type t =
      {
      reserved_cache_nodes_offering_id: String.t option ;
      cache_node_type: String.t option ;
      duration: Integer.t option ;
      fixed_price: Double.t option ;
      usage_price: Double.t option ;
      product_description: String.t option ;
      offering_type: String.t option ;
      recurring_charges: RecurringChargeList.t }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        reserved_cache_nodes_offering_id =
          (Util.option_map (Json.lookup j "reserved_cache_nodes_offering_id")
             String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        fixed_price =
          (Util.option_map (Json.lookup j "fixed_price") Double.of_json);
        usage_price =
          (Util.option_map (Json.lookup j "usage_price") Double.of_json);
        product_description =
          (Util.option_map (Json.lookup j "product_description")
             String.of_json);
        offering_type =
          (Util.option_map (Json.lookup j "offering_type") String.of_json);
        recurring_charges =
          (RecurringChargeList.of_json
             (Util.of_option_exn (Json.lookup j "recurring_charges")))
      }
  end
module CacheParameterGroup =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option ;
      cache_parameter_group_family: String.t option ;
      description: String.t option }
    let make ?cache_parameter_group_name  ?cache_parameter_group_family 
      ?description  () =
      { cache_parameter_group_name; cache_parameter_group_family; description
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.cache_parameter_group_family
             (fun f -> ("cache_parameter_group_family", (String.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        cache_parameter_group_family =
          (Util.option_map (Json.lookup j "cache_parameter_group_family")
             String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json)
      }
  end
module Snapshot =
  struct
    type t =
      {
      snapshot_name: String.t option ;
      replication_group_id: String.t option ;
      replication_group_description: String.t option ;
      cache_cluster_id: String.t option ;
      snapshot_status: String.t option ;
      snapshot_source: String.t option ;
      cache_node_type: String.t option ;
      engine: String.t option ;
      engine_version: String.t option ;
      num_cache_nodes: Integer.t option ;
      preferred_availability_zone: String.t option ;
      cache_cluster_create_time: DateTime.t option ;
      preferred_maintenance_window: String.t option ;
      topic_arn: String.t option ;
      port: Integer.t option ;
      cache_parameter_group_name: String.t option ;
      cache_subnet_group_name: String.t option ;
      vpc_id: String.t option ;
      auto_minor_version_upgrade: Boolean.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      num_node_groups: Integer.t option ;
      automatic_failover: AutomaticFailoverStatus.t option ;
      node_snapshots: NodeSnapshotList.t ;
      kms_key_id: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        snapshot_name =
          (Util.option_map (Json.lookup j "snapshot_name") String.of_json);
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        replication_group_description =
          (Util.option_map (Json.lookup j "replication_group_description")
             String.of_json);
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        snapshot_status =
          (Util.option_map (Json.lookup j "snapshot_status") String.of_json);
        snapshot_source =
          (Util.option_map (Json.lookup j "snapshot_source") String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        num_cache_nodes =
          (Util.option_map (Json.lookup j "num_cache_nodes") Integer.of_json);
        preferred_availability_zone =
          (Util.option_map (Json.lookup j "preferred_availability_zone")
             String.of_json);
        cache_cluster_create_time =
          (Util.option_map (Json.lookup j "cache_cluster_create_time")
             DateTime.of_json);
        preferred_maintenance_window =
          (Util.option_map (Json.lookup j "preferred_maintenance_window")
             String.of_json);
        topic_arn =
          (Util.option_map (Json.lookup j "topic_arn") String.of_json);
        port = (Util.option_map (Json.lookup j "port") Integer.of_json);
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        cache_subnet_group_name =
          (Util.option_map (Json.lookup j "cache_subnet_group_name")
             String.of_json);
        vpc_id = (Util.option_map (Json.lookup j "vpc_id") String.of_json);
        auto_minor_version_upgrade =
          (Util.option_map (Json.lookup j "auto_minor_version_upgrade")
             Boolean.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        num_node_groups =
          (Util.option_map (Json.lookup j "num_node_groups") Integer.of_json);
        automatic_failover =
          (Util.option_map (Json.lookup j "automatic_failover")
             AutomaticFailoverStatus.of_json);
        node_snapshots =
          (NodeSnapshotList.of_json
             (Util.of_option_exn (Json.lookup j "node_snapshots")));
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json)
      }
  end
module ServiceUpdate =
  struct
    type t =
      {
      service_update_name: String.t option ;
      service_update_release_date: DateTime.t option ;
      service_update_end_date: DateTime.t option ;
      service_update_severity: ServiceUpdateSeverity.t option ;
      service_update_recommended_apply_by_date: DateTime.t option ;
      service_update_status: ServiceUpdateStatus.t option ;
      service_update_description: String.t option ;
      service_update_type: ServiceUpdateType.t option ;
      engine: String.t option ;
      engine_version: String.t option ;
      auto_update_after_recommended_apply_by_date: Boolean.t option ;
      estimated_update_time: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        service_update_name =
          (Util.option_map (Json.lookup j "service_update_name")
             String.of_json);
        service_update_release_date =
          (Util.option_map (Json.lookup j "service_update_release_date")
             DateTime.of_json);
        service_update_end_date =
          (Util.option_map (Json.lookup j "service_update_end_date")
             DateTime.of_json);
        service_update_severity =
          (Util.option_map (Json.lookup j "service_update_severity")
             ServiceUpdateSeverity.of_json);
        service_update_recommended_apply_by_date =
          (Util.option_map
             (Json.lookup j "service_update_recommended_apply_by_date")
             DateTime.of_json);
        service_update_status =
          (Util.option_map (Json.lookup j "service_update_status")
             ServiceUpdateStatus.of_json);
        service_update_description =
          (Util.option_map (Json.lookup j "service_update_description")
             String.of_json);
        service_update_type =
          (Util.option_map (Json.lookup j "service_update_type")
             ServiceUpdateType.of_json);
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        auto_update_after_recommended_apply_by_date =
          (Util.option_map
             (Json.lookup j "auto_update_after_recommended_apply_by_date")
             Boolean.of_json);
        estimated_update_time =
          (Util.option_map (Json.lookup j "estimated_update_time")
             String.of_json)
      }
  end
module CacheSubnetGroup =
  struct
    type t =
      {
      cache_subnet_group_name: String.t option ;
      cache_subnet_group_description: String.t option ;
      vpc_id: String.t option ;
      subnets: SubnetList.t }
    let make ?cache_subnet_group_name  ?cache_subnet_group_description 
      ?vpc_id  ?(subnets= [])  () =
      {
        cache_subnet_group_name;
        cache_subnet_group_description;
        vpc_id;
        subnets
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnets", (SubnetList.to_json v.subnets));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.cache_subnet_group_description
             (fun f -> ("cache_subnet_group_description", (String.to_json f)));
           Util.option_map v.cache_subnet_group_name
             (fun f -> ("cache_subnet_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_subnet_group_name =
          (Util.option_map (Json.lookup j "cache_subnet_group_name")
             String.of_json);
        cache_subnet_group_description =
          (Util.option_map (Json.lookup j "cache_subnet_group_description")
             String.of_json);
        vpc_id = (Util.option_map (Json.lookup j "vpc_id") String.of_json);
        subnets =
          (SubnetList.of_json (Util.of_option_exn (Json.lookup j "subnets")))
      }
  end
module Tag =
  struct
    type t = {
      key: String.t option ;
      value: String.t option }
    let make ?key  ?value  () = { key; value }
    let parse xml =
      Some
        {
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.key
               (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        value = (Util.option_map (Json.lookup j "value") String.of_json)
      }
  end
module ConfigureShard =
  struct
    type t =
      {
      node_group_id: String.t ;
      new_replica_count: Integer.t ;
      preferred_availability_zones: PreferredAvailabilityZoneList.t }
    let make ~node_group_id  ~new_replica_count 
      ?(preferred_availability_zones= [])  () =
      { node_group_id; new_replica_count; preferred_availability_zones }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("preferred_availability_zones",
                (PreferredAvailabilityZoneList.to_json
                   v.preferred_availability_zones));
           Some ("new_replica_count", (Integer.to_json v.new_replica_count));
           Some ("node_group_id", (String.to_json v.node_group_id))])
    let of_json j =
      {
        node_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "node_group_id")));
        new_replica_count =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "new_replica_count")));
        preferred_availability_zones =
          (PreferredAvailabilityZoneList.of_json
             (Util.of_option_exn
                (Json.lookup j "preferred_availability_zones")))
      }
  end
module ParameterNameValue =
  struct
    type t =
      {
      parameter_name: String.t option ;
      parameter_value: String.t option }
    let make ?parameter_name  ?parameter_value  () =
      { parameter_name; parameter_value }
    let parse xml =
      Some
        {
          parameter_name =
            (Util.option_bind (Xml.member "ParameterName" xml) String.parse);
          parameter_value =
            (Util.option_bind (Xml.member "ParameterValue" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameter_value
              (fun f -> ("parameter_value", (String.to_json f)));
           Util.option_map v.parameter_name
             (fun f -> ("parameter_name", (String.to_json f)))])
    let of_json j =
      {
        parameter_name =
          (Util.option_map (Json.lookup j "parameter_name") String.of_json);
        parameter_value =
          (Util.option_map (Json.lookup j "parameter_value") String.of_json)
      }
  end
module CacheCluster =
  struct
    type t =
      {
      cache_cluster_id: String.t option ;
      configuration_endpoint: Endpoint.t option ;
      client_download_landing_page: String.t option ;
      cache_node_type: String.t option ;
      engine: String.t option ;
      engine_version: String.t option ;
      cache_cluster_status: String.t option ;
      num_cache_nodes: Integer.t option ;
      preferred_availability_zone: String.t option ;
      cache_cluster_create_time: DateTime.t option ;
      preferred_maintenance_window: String.t option ;
      pending_modified_values: PendingModifiedValues.t option ;
      notification_configuration: NotificationConfiguration.t option ;
      cache_security_groups: CacheSecurityGroupMembershipList.t ;
      cache_parameter_group: CacheParameterGroupStatus.t option ;
      cache_subnet_group_name: String.t option ;
      cache_nodes: CacheNodeList.t ;
      auto_minor_version_upgrade: Boolean.t option ;
      security_groups: SecurityGroupMembershipList.t ;
      replication_group_id: String.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      auth_token_enabled: Boolean.t option ;
      auth_token_last_modified_date: DateTime.t option ;
      transit_encryption_enabled: Boolean.t option ;
      at_rest_encryption_enabled: Boolean.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        configuration_endpoint =
          (Util.option_map (Json.lookup j "configuration_endpoint")
             Endpoint.of_json);
        client_download_landing_page =
          (Util.option_map (Json.lookup j "client_download_landing_page")
             String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        cache_cluster_status =
          (Util.option_map (Json.lookup j "cache_cluster_status")
             String.of_json);
        num_cache_nodes =
          (Util.option_map (Json.lookup j "num_cache_nodes") Integer.of_json);
        preferred_availability_zone =
          (Util.option_map (Json.lookup j "preferred_availability_zone")
             String.of_json);
        cache_cluster_create_time =
          (Util.option_map (Json.lookup j "cache_cluster_create_time")
             DateTime.of_json);
        preferred_maintenance_window =
          (Util.option_map (Json.lookup j "preferred_maintenance_window")
             String.of_json);
        pending_modified_values =
          (Util.option_map (Json.lookup j "pending_modified_values")
             PendingModifiedValues.of_json);
        notification_configuration =
          (Util.option_map (Json.lookup j "notification_configuration")
             NotificationConfiguration.of_json);
        cache_security_groups =
          (CacheSecurityGroupMembershipList.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_groups")));
        cache_parameter_group =
          (Util.option_map (Json.lookup j "cache_parameter_group")
             CacheParameterGroupStatus.of_json);
        cache_subnet_group_name =
          (Util.option_map (Json.lookup j "cache_subnet_group_name")
             String.of_json);
        cache_nodes =
          (CacheNodeList.of_json
             (Util.of_option_exn (Json.lookup j "cache_nodes")));
        auto_minor_version_upgrade =
          (Util.option_map (Json.lookup j "auto_minor_version_upgrade")
             Boolean.of_json);
        security_groups =
          (SecurityGroupMembershipList.of_json
             (Util.of_option_exn (Json.lookup j "security_groups")));
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        auth_token_enabled =
          (Util.option_map (Json.lookup j "auth_token_enabled")
             Boolean.of_json);
        auth_token_last_modified_date =
          (Util.option_map (Json.lookup j "auth_token_last_modified_date")
             DateTime.of_json);
        transit_encryption_enabled =
          (Util.option_map (Json.lookup j "transit_encryption_enabled")
             Boolean.of_json);
        at_rest_encryption_enabled =
          (Util.option_map (Json.lookup j "at_rest_encryption_enabled")
             Boolean.of_json)
      }
  end
module CacheNodeTypeSpecificParametersList =
  struct
    type t = CacheNodeTypeSpecificParameter.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheNodeTypeSpecificParameter.parse
           (Xml.members "CacheNodeTypeSpecificParameter" xml))
    let to_query v =
      Query.to_query_list CacheNodeTypeSpecificParameter.to_query v
    let to_headers v =
      Headers.to_headers_list CacheNodeTypeSpecificParameter.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (CacheNodeTypeSpecificParameter.to_xml x))) v
    let to_json v = `List (List.map CacheNodeTypeSpecificParameter.to_json v)
    let of_json j = Json.to_list CacheNodeTypeSpecificParameter.of_json j
  end
module ParametersList =
  struct
    type t = Parameter.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map Parameter.parse (Xml.members "Parameter" xml))
    let to_query v = Query.to_query_list Parameter.to_query v
    let to_headers v = Headers.to_headers_list Parameter.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Parameter.to_xml x)))
        v
    let to_json v = `List (List.map Parameter.to_json v)
    let of_json j = Json.to_list Parameter.of_json j
  end
module ReshardingConfiguration =
  struct
    type t =
      {
      node_group_id: String.t option ;
      preferred_availability_zones: AvailabilityZonesList.t }
    let make ?node_group_id  ?(preferred_availability_zones= [])  () =
      { node_group_id; preferred_availability_zones }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("preferred_availability_zones",
                (AvailabilityZonesList.to_json v.preferred_availability_zones));
           Util.option_map v.node_group_id
             (fun f -> ("node_group_id", (String.to_json f)))])
    let of_json j =
      {
        node_group_id =
          (Util.option_map (Json.lookup j "node_group_id") String.of_json);
        preferred_availability_zones =
          (AvailabilityZonesList.of_json
             (Util.of_option_exn
                (Json.lookup j "preferred_availability_zones")))
      }
  end
module UpdateAction =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      cache_cluster_id: String.t option ;
      service_update_name: String.t option ;
      service_update_release_date: DateTime.t option ;
      service_update_severity: ServiceUpdateSeverity.t option ;
      service_update_status: ServiceUpdateStatus.t option ;
      service_update_recommended_apply_by_date: DateTime.t option ;
      service_update_type: ServiceUpdateType.t option ;
      update_action_available_date: DateTime.t option ;
      update_action_status: UpdateActionStatus.t option ;
      nodes_updated: String.t option ;
      update_action_status_modified_date: DateTime.t option ;
      sla_met: SlaMet.t option ;
      node_group_update_status: NodeGroupUpdateStatusList.t ;
      cache_node_update_status: CacheNodeUpdateStatusList.t ;
      estimated_update_time: String.t option ;
      engine: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        service_update_name =
          (Util.option_map (Json.lookup j "service_update_name")
             String.of_json);
        service_update_release_date =
          (Util.option_map (Json.lookup j "service_update_release_date")
             DateTime.of_json);
        service_update_severity =
          (Util.option_map (Json.lookup j "service_update_severity")
             ServiceUpdateSeverity.of_json);
        service_update_status =
          (Util.option_map (Json.lookup j "service_update_status")
             ServiceUpdateStatus.of_json);
        service_update_recommended_apply_by_date =
          (Util.option_map
             (Json.lookup j "service_update_recommended_apply_by_date")
             DateTime.of_json);
        service_update_type =
          (Util.option_map (Json.lookup j "service_update_type")
             ServiceUpdateType.of_json);
        update_action_available_date =
          (Util.option_map (Json.lookup j "update_action_available_date")
             DateTime.of_json);
        update_action_status =
          (Util.option_map (Json.lookup j "update_action_status")
             UpdateActionStatus.of_json);
        nodes_updated =
          (Util.option_map (Json.lookup j "nodes_updated") String.of_json);
        update_action_status_modified_date =
          (Util.option_map
             (Json.lookup j "update_action_status_modified_date")
             DateTime.of_json);
        sla_met = (Util.option_map (Json.lookup j "sla_met") SlaMet.of_json);
        node_group_update_status =
          (NodeGroupUpdateStatusList.of_json
             (Util.of_option_exn (Json.lookup j "node_group_update_status")));
        cache_node_update_status =
          (CacheNodeUpdateStatusList.of_json
             (Util.of_option_exn (Json.lookup j "cache_node_update_status")));
        estimated_update_time =
          (Util.option_map (Json.lookup j "estimated_update_time")
             String.of_json);
        engine = (Util.option_map (Json.lookup j "engine") String.of_json)
      }
  end
module Event =
  struct
    type t =
      {
      source_identifier: String.t option ;
      source_type: SourceType.t option ;
      message: String.t option ;
      date: DateTime.t option }
    let make ?source_identifier  ?source_type  ?message  ?date  () =
      { source_identifier; source_type; message; date }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        source_identifier =
          (Util.option_map (Json.lookup j "source_identifier") String.of_json);
        source_type =
          (Util.option_map (Json.lookup j "source_type") SourceType.of_json);
        message = (Util.option_map (Json.lookup j "message") String.of_json);
        date = (Util.option_map (Json.lookup j "date") DateTime.of_json)
      }
  end
module ProcessedUpdateAction =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      cache_cluster_id: String.t option ;
      service_update_name: String.t option ;
      update_action_status: UpdateActionStatus.t option }
    let make ?replication_group_id  ?cache_cluster_id  ?service_update_name 
      ?update_action_status  () =
      {
        replication_group_id;
        cache_cluster_id;
        service_update_name;
        update_action_status
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        service_update_name =
          (Util.option_map (Json.lookup j "service_update_name")
             String.of_json);
        update_action_status =
          (Util.option_map (Json.lookup j "update_action_status")
             UpdateActionStatus.of_json)
      }
  end
module UnprocessedUpdateAction =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      cache_cluster_id: String.t option ;
      service_update_name: String.t option ;
      error_type: String.t option ;
      error_message: String.t option }
    let make ?replication_group_id  ?cache_cluster_id  ?service_update_name 
      ?error_type  ?error_message  () =
      {
        replication_group_id;
        cache_cluster_id;
        service_update_name;
        error_type;
        error_message
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        service_update_name =
          (Util.option_map (Json.lookup j "service_update_name")
             String.of_json);
        error_type =
          (Util.option_map (Json.lookup j "error_type") String.of_json);
        error_message =
          (Util.option_map (Json.lookup j "error_message") String.of_json)
      }
  end
module ReplicationGroup =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      description: String.t option ;
      status: String.t option ;
      pending_modified_values: ReplicationGroupPendingModifiedValues.t option ;
      member_clusters: ClusterIdList.t ;
      node_groups: NodeGroupList.t ;
      snapshotting_cluster_id: String.t option ;
      automatic_failover: AutomaticFailoverStatus.t option ;
      configuration_endpoint: Endpoint.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      cluster_enabled: Boolean.t option ;
      cache_node_type: String.t option ;
      auth_token_enabled: Boolean.t option ;
      auth_token_last_modified_date: DateTime.t option ;
      transit_encryption_enabled: Boolean.t option ;
      at_rest_encryption_enabled: Boolean.t option ;
      kms_key_id: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        pending_modified_values =
          (Util.option_map (Json.lookup j "pending_modified_values")
             ReplicationGroupPendingModifiedValues.of_json);
        member_clusters =
          (ClusterIdList.of_json
             (Util.of_option_exn (Json.lookup j "member_clusters")));
        node_groups =
          (NodeGroupList.of_json
             (Util.of_option_exn (Json.lookup j "node_groups")));
        snapshotting_cluster_id =
          (Util.option_map (Json.lookup j "snapshotting_cluster_id")
             String.of_json);
        automatic_failover =
          (Util.option_map (Json.lookup j "automatic_failover")
             AutomaticFailoverStatus.of_json);
        configuration_endpoint =
          (Util.option_map (Json.lookup j "configuration_endpoint")
             Endpoint.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        cluster_enabled =
          (Util.option_map (Json.lookup j "cluster_enabled") Boolean.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        auth_token_enabled =
          (Util.option_map (Json.lookup j "auth_token_enabled")
             Boolean.of_json);
        auth_token_last_modified_date =
          (Util.option_map (Json.lookup j "auth_token_last_modified_date")
             DateTime.of_json);
        transit_encryption_enabled =
          (Util.option_map (Json.lookup j "transit_encryption_enabled")
             Boolean.of_json);
        at_rest_encryption_enabled =
          (Util.option_map (Json.lookup j "at_rest_encryption_enabled")
             Boolean.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json)
      }
  end
module CacheEngineVersion =
  struct
    type t =
      {
      engine: String.t option ;
      engine_version: String.t option ;
      cache_parameter_group_family: String.t option ;
      cache_engine_description: String.t option ;
      cache_engine_version_description: String.t option }
    let make ?engine  ?engine_version  ?cache_parameter_group_family 
      ?cache_engine_description  ?cache_engine_version_description  () =
      {
        engine;
        engine_version;
        cache_parameter_group_family;
        cache_engine_description;
        cache_engine_version_description
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        cache_parameter_group_family =
          (Util.option_map (Json.lookup j "cache_parameter_group_family")
             String.of_json);
        cache_engine_description =
          (Util.option_map (Json.lookup j "cache_engine_description")
             String.of_json);
        cache_engine_version_description =
          (Util.option_map (Json.lookup j "cache_engine_version_description")
             String.of_json)
      }
  end
module CacheSecurityGroup =
  struct
    type t =
      {
      owner_id: String.t option ;
      cache_security_group_name: String.t option ;
      description: String.t option ;
      e_c2_security_groups: EC2SecurityGroupList.t }
    let make ?owner_id  ?cache_security_group_name  ?description 
      ?(e_c2_security_groups= [])  () =
      {
        owner_id;
        cache_security_group_name;
        description;
        e_c2_security_groups
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        owner_id =
          (Util.option_map (Json.lookup j "owner_id") String.of_json);
        cache_security_group_name =
          (Util.option_map (Json.lookup j "cache_security_group_name")
             String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        e_c2_security_groups =
          (EC2SecurityGroupList.of_json
             (Util.of_option_exn (Json.lookup j "e_c2_security_groups")))
      }
  end
module ReservedCacheNode =
  struct
    type t =
      {
      reserved_cache_node_id: String.t option ;
      reserved_cache_nodes_offering_id: String.t option ;
      cache_node_type: String.t option ;
      start_time: DateTime.t option ;
      duration: Integer.t option ;
      fixed_price: Double.t option ;
      usage_price: Double.t option ;
      cache_node_count: Integer.t option ;
      product_description: String.t option ;
      offering_type: String.t option ;
      state: String.t option ;
      recurring_charges: RecurringChargeList.t ;
      reservation_a_r_n: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        reserved_cache_node_id =
          (Util.option_map (Json.lookup j "reserved_cache_node_id")
             String.of_json);
        reserved_cache_nodes_offering_id =
          (Util.option_map (Json.lookup j "reserved_cache_nodes_offering_id")
             String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        fixed_price =
          (Util.option_map (Json.lookup j "fixed_price") Double.of_json);
        usage_price =
          (Util.option_map (Json.lookup j "usage_price") Double.of_json);
        cache_node_count =
          (Util.option_map (Json.lookup j "cache_node_count") Integer.of_json);
        product_description =
          (Util.option_map (Json.lookup j "product_description")
             String.of_json);
        offering_type =
          (Util.option_map (Json.lookup j "offering_type") String.of_json);
        state = (Util.option_map (Json.lookup j "state") String.of_json);
        recurring_charges =
          (RecurringChargeList.of_json
             (Util.of_option_exn (Json.lookup j "recurring_charges")));
        reservation_a_r_n =
          (Util.option_map (Json.lookup j "reservation_a_r_n") String.of_json)
      }
  end
module CustomerNodeEndpointList =
  struct
    type t = CustomerNodeEndpoint.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CustomerNodeEndpoint.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list CustomerNodeEndpoint.to_query v
    let to_headers v =
      Headers.to_headers_list CustomerNodeEndpoint.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CustomerNodeEndpoint.to_xml x))) v
    let to_json v = `List (List.map CustomerNodeEndpoint.to_json v)
    let of_json j = Json.to_list CustomerNodeEndpoint.of_json j
  end
module ReservedCacheNodesOfferingList =
  struct
    type t = ReservedCacheNodesOffering.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ReservedCacheNodesOffering.parse
           (Xml.members "ReservedCacheNodesOffering" xml))
    let to_query v =
      Query.to_query_list ReservedCacheNodesOffering.to_query v
    let to_headers v =
      Headers.to_headers_list ReservedCacheNodesOffering.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ReservedCacheNodesOffering.to_xml x))) v
    let to_json v = `List (List.map ReservedCacheNodesOffering.to_json v)
    let of_json j = Json.to_list ReservedCacheNodesOffering.of_json j
  end
module CacheParameterGroupList =
  struct
    type t = CacheParameterGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheParameterGroup.parse
           (Xml.members "CacheParameterGroup" xml))
    let to_query v = Query.to_query_list CacheParameterGroup.to_query v
    let to_headers v =
      Headers.to_headers_list CacheParameterGroup.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheParameterGroup.to_xml x))) v
    let to_json v = `List (List.map CacheParameterGroup.to_json v)
    let of_json j = Json.to_list CacheParameterGroup.of_json j
  end
module SnapshotList =
  struct
    type t = Snapshot.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Snapshot.parse (Xml.members "Snapshot" xml))
    let to_query v = Query.to_query_list Snapshot.to_query v
    let to_headers v = Headers.to_headers_list Snapshot.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Snapshot.to_xml x)))
        v
    let to_json v = `List (List.map Snapshot.to_json v)
    let of_json j = Json.to_list Snapshot.of_json j
  end
module ServiceUpdateStatusList =
  struct
    type t = ServiceUpdateStatus.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ServiceUpdateStatus.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list ServiceUpdateStatus.to_query v
    let to_headers v =
      Headers.to_headers_list ServiceUpdateStatus.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ServiceUpdateStatus.to_xml x))) v
    let to_json v = `List (List.map ServiceUpdateStatus.to_json v)
    let of_json j = Json.to_list ServiceUpdateStatus.of_json j
  end
module ServiceUpdateList =
  struct
    type t = ServiceUpdate.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ServiceUpdate.parse (Xml.members "ServiceUpdate" xml))
    let to_query v = Query.to_query_list ServiceUpdate.to_query v
    let to_headers v = Headers.to_headers_list ServiceUpdate.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ServiceUpdate.to_xml x))) v
    let to_json v = `List (List.map ServiceUpdate.to_json v)
    let of_json j = Json.to_list ServiceUpdate.of_json j
  end
module CacheSubnetGroups =
  struct
    type t = CacheSubnetGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheSubnetGroup.parse (Xml.members "CacheSubnetGroup" xml))
    let to_query v = Query.to_query_list CacheSubnetGroup.to_query v
    let to_headers v = Headers.to_headers_list CacheSubnetGroup.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (CacheSubnetGroup.to_xml x)))
        v
    let to_json v = `List (List.map CacheSubnetGroup.to_json v)
    let of_json j = Json.to_list CacheSubnetGroup.of_json j
  end
module TagList =
  struct
    type t = Tag.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "Tag" xml))
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
    let to_json v = `List (List.map Tag.to_json v)
    let of_json j = Json.to_list Tag.of_json j
  end
module RemoveReplicasList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ReplicaConfigurationList =
  struct
    type t = ConfigureShard.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ConfigureShard.parse (Xml.members "ConfigureShard" xml))
    let to_query v = Query.to_query_list ConfigureShard.to_query v
    let to_headers v = Headers.to_headers_list ConfigureShard.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ConfigureShard.to_xml x))) v
    let to_json v = `List (List.map ConfigureShard.to_json v)
    let of_json j = Json.to_list ConfigureShard.of_json j
  end
module ParameterNameValueList =
  struct
    type t = ParameterNameValue.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ParameterNameValue.parse
           (Xml.members "ParameterNameValue" xml))
    let to_query v = Query.to_query_list ParameterNameValue.to_query v
    let to_headers v =
      Headers.to_headers_list ParameterNameValue.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ParameterNameValue.to_xml x))) v
    let to_json v = `List (List.map ParameterNameValue.to_json v)
    let of_json j = Json.to_list ParameterNameValue.of_json j
  end
module SubnetIdentifierList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "SubnetIdentifier" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CacheSecurityGroupNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "CacheSecurityGroupName" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module NodeGroupConfigurationList =
  struct
    type t = NodeGroupConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map NodeGroupConfiguration.parse
           (Xml.members "NodeGroupConfiguration" xml))
    let to_query v = Query.to_query_list NodeGroupConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list NodeGroupConfiguration.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (NodeGroupConfiguration.to_xml x)))
        v
    let to_json v = `List (List.map NodeGroupConfiguration.to_json v)
    let of_json j = Json.to_list NodeGroupConfiguration.of_json j
  end
module SecurityGroupIdsList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "SecurityGroupId" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module SnapshotArnsList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "SnapshotArn" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CacheClusterList =
  struct
    type t = CacheCluster.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheCluster.parse (Xml.members "CacheCluster" xml))
    let to_query v = Query.to_query_list CacheCluster.to_query v
    let to_headers v = Headers.to_headers_list CacheCluster.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (CacheCluster.to_xml x))) v
    let to_json v = `List (List.map CacheCluster.to_json v)
    let of_json j = Json.to_list CacheCluster.of_json j
  end
module EngineDefaults =
  struct
    type t =
      {
      cache_parameter_group_family: String.t option ;
      marker: String.t option ;
      parameters: ParametersList.t ;
      cache_node_type_specific_parameters:
        CacheNodeTypeSpecificParametersList.t }
    let make ?cache_parameter_group_family  ?marker  ?(parameters= []) 
      ?(cache_node_type_specific_parameters= [])  () =
      {
        cache_parameter_group_family;
        marker;
        parameters;
        cache_node_type_specific_parameters
      }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_parameter_group_family =
          (Util.option_map (Json.lookup j "cache_parameter_group_family")
             String.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        parameters =
          (ParametersList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        cache_node_type_specific_parameters =
          (CacheNodeTypeSpecificParametersList.of_json
             (Util.of_option_exn
                (Json.lookup j "cache_node_type_specific_parameters")))
      }
  end
module NodeGroupsToRemoveList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "NodeGroupToRemove" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module NodeGroupsToRetainList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "NodeGroupToRetain" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ReshardingConfigurationList =
  struct
    type t = ReshardingConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ReshardingConfiguration.parse
           (Xml.members "ReshardingConfiguration" xml))
    let to_query v = Query.to_query_list ReshardingConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list ReshardingConfiguration.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ReshardingConfiguration.to_xml x)))
        v
    let to_json v = `List (List.map ReshardingConfiguration.to_json v)
    let of_json j = Json.to_list ReshardingConfiguration.of_json j
  end
module CacheClusterIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ReplicationGroupIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module TimeRangeFilter =
  struct
    type t = {
      start_time: DateTime.t option ;
      end_time: DateTime.t option }
    let make ?start_time  ?end_time  () = { start_time; end_time }
    let parse xml =
      Some
        {
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.start_time
               (fun f ->
                  Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.end_time
              (fun f -> Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_time
              (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)))])
    let of_json j =
      {
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json)
      }
  end
module UpdateActionStatusList =
  struct
    type t = UpdateActionStatus.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map UpdateActionStatus.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list UpdateActionStatus.to_query v
    let to_headers v =
      Headers.to_headers_list UpdateActionStatus.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (UpdateActionStatus.to_xml x))) v
    let to_json v = `List (List.map UpdateActionStatus.to_json v)
    let of_json j = Json.to_list UpdateActionStatus.of_json j
  end
module UpdateActionList =
  struct
    type t = UpdateAction.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map UpdateAction.parse (Xml.members "UpdateAction" xml))
    let to_query v = Query.to_query_list UpdateAction.to_query v
    let to_headers v = Headers.to_headers_list UpdateAction.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (UpdateAction.to_xml x))) v
    let to_json v = `List (List.map UpdateAction.to_json v)
    let of_json j = Json.to_list UpdateAction.of_json j
  end
module EventList =
  struct
    type t = Event.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Event.parse (Xml.members "Event" xml))
    let to_query v = Query.to_query_list Event.to_query v
    let to_headers v = Headers.to_headers_list Event.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Event.to_xml x))) v
    let to_json v = `List (List.map Event.to_json v)
    let of_json j = Json.to_list Event.of_json j
  end
module NodeTypeList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ProcessedUpdateActionList =
  struct
    type t = ProcessedUpdateAction.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ProcessedUpdateAction.parse
           (Xml.members "ProcessedUpdateAction" xml))
    let to_query v = Query.to_query_list ProcessedUpdateAction.to_query v
    let to_headers v =
      Headers.to_headers_list ProcessedUpdateAction.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ProcessedUpdateAction.to_xml x))) v
    let to_json v = `List (List.map ProcessedUpdateAction.to_json v)
    let of_json j = Json.to_list ProcessedUpdateAction.of_json j
  end
module UnprocessedUpdateActionList =
  struct
    type t = UnprocessedUpdateAction.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map UnprocessedUpdateAction.parse
           (Xml.members "UnprocessedUpdateAction" xml))
    let to_query v = Query.to_query_list UnprocessedUpdateAction.to_query v
    let to_headers v =
      Headers.to_headers_list UnprocessedUpdateAction.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (UnprocessedUpdateAction.to_xml x)))
        v
    let to_json v = `List (List.map UnprocessedUpdateAction.to_json v)
    let of_json j = Json.to_list UnprocessedUpdateAction.of_json j
  end
module KeyList =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ReplicationGroupList =
  struct
    type t = ReplicationGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ReplicationGroup.parse (Xml.members "ReplicationGroup" xml))
    let to_query v = Query.to_query_list ReplicationGroup.to_query v
    let to_headers v = Headers.to_headers_list ReplicationGroup.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ReplicationGroup.to_xml x)))
        v
    let to_json v = `List (List.map ReplicationGroup.to_json v)
    let of_json j = Json.to_list ReplicationGroup.of_json j
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
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module CacheEngineVersionList =
  struct
    type t = CacheEngineVersion.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheEngineVersion.parse
           (Xml.members "CacheEngineVersion" xml))
    let to_query v = Query.to_query_list CacheEngineVersion.to_query v
    let to_headers v =
      Headers.to_headers_list CacheEngineVersion.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheEngineVersion.to_xml x))) v
    let to_json v = `List (List.map CacheEngineVersion.to_json v)
    let of_json j = Json.to_list CacheEngineVersion.of_json j
  end
module CacheSecurityGroups =
  struct
    type t = CacheSecurityGroup.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map CacheSecurityGroup.parse
           (Xml.members "CacheSecurityGroup" xml))
    let to_query v = Query.to_query_list CacheSecurityGroup.to_query v
    let to_headers v =
      Headers.to_headers_list CacheSecurityGroup.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CacheSecurityGroup.to_xml x))) v
    let to_json v = `List (List.map CacheSecurityGroup.to_json v)
    let of_json j = Json.to_list CacheSecurityGroup.of_json j
  end
module ReservedCacheNodeList =
  struct
    type t = ReservedCacheNode.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map ReservedCacheNode.parse
           (Xml.members "ReservedCacheNode" xml))
    let to_query v = Query.to_query_list ReservedCacheNode.to_query v
    let to_headers v = Headers.to_headers_list ReservedCacheNode.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ReservedCacheNode.to_xml x)))
        v
    let to_json v = `List (List.map ReservedCacheNode.to_json v)
    let of_json j = Json.to_list ReservedCacheNode.of_json j
  end
module StartMigrationMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      customer_node_endpoint_list: CustomerNodeEndpointList.t }
    let make ~replication_group_id  ~customer_node_endpoint_list  () =
      { replication_group_id; customer_node_endpoint_list }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          customer_node_endpoint_list =
            (Xml.required "CustomerNodeEndpointList"
               (Util.option_bind (Xml.member "CustomerNodeEndpointList" xml)
                  CustomerNodeEndpointList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ReplicationGroupId"
                  ([], (String.to_xml v.replication_group_id)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CustomerNodeEndpointList"
                      ([], (CustomerNodeEndpointList.to_xml [x]))))
              v.customer_node_endpoint_list))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("customer_node_endpoint_list",
                (CustomerNodeEndpointList.to_json
                   v.customer_node_endpoint_list));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        customer_node_endpoint_list =
          (CustomerNodeEndpointList.of_json
             (Util.of_option_exn
                (Json.lookup j "customer_node_endpoint_list")))
      }
  end
module CreateCacheSecurityGroupResult =
  struct
    type t = {
      cache_security_group: CacheSecurityGroup.t option }
    let make ?cache_security_group  () = { cache_security_group }
    let parse xml =
      Some
        {
          cache_security_group =
            (Util.option_bind (Xml.member "CacheSecurityGroup" xml)
               CacheSecurityGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_security_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSecurityGroup"
                   ([], (CacheSecurityGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_security_group
              (fun f ->
                 ("cache_security_group", (CacheSecurityGroup.to_json f)))])
    let of_json j =
      {
        cache_security_group =
          (Util.option_map (Json.lookup j "cache_security_group")
             CacheSecurityGroup.of_json)
      }
  end
module ListAllowedNodeTypeModificationsMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t option ;
      replication_group_id: String.t option }
    let make ?cache_cluster_id  ?replication_group_id  () =
      { cache_cluster_id; replication_group_id }
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.cache_cluster_id
               (fun f ->
                  Ezxmlm.make_tag "CacheClusterId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.replication_group_id
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroupId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group_id
              (fun f -> ("replication_group_id", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let of_json j =
      {
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json)
      }
  end
module ReservedCacheNodesOfferingMessage =
  struct
    type t =
      {
      marker: String.t option ;
      reserved_cache_nodes_offerings: ReservedCacheNodesOfferingList.t }
    let make ?marker  ?(reserved_cache_nodes_offerings= [])  () =
      { marker; reserved_cache_nodes_offerings }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_cache_nodes_offerings",
                (ReservedCacheNodesOfferingList.to_json
                   v.reserved_cache_nodes_offerings));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        reserved_cache_nodes_offerings =
          (ReservedCacheNodesOfferingList.of_json
             (Util.of_option_exn
                (Json.lookup j "reserved_cache_nodes_offerings")))
      }
  end
module CacheParameterGroupsMessage =
  struct
    type t =
      {
      marker: String.t option ;
      cache_parameter_groups: CacheParameterGroupList.t }
    let make ?marker  ?(cache_parameter_groups= [])  () =
      { marker; cache_parameter_groups }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_parameter_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheParameterGroups" xml)
                  CacheParameterGroupList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_parameter_groups",
                (CacheParameterGroupList.to_json v.cache_parameter_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        cache_parameter_groups =
          (CacheParameterGroupList.of_json
             (Util.of_option_exn (Json.lookup j "cache_parameter_groups")))
      }
  end
module DescribeCacheClustersMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option ;
      show_cache_node_info: Boolean.t option ;
      show_cache_clusters_not_in_replication_groups: Boolean.t option }
    let make ?cache_cluster_id  ?max_records  ?marker  ?show_cache_node_info 
      ?show_cache_clusters_not_in_replication_groups  () =
      {
        cache_cluster_id;
        max_records;
        marker;
        show_cache_node_info;
        show_cache_clusters_not_in_replication_groups
      }
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          show_cache_node_info =
            (Util.option_bind (Xml.member "ShowCacheNodeInfo" xml)
               Boolean.parse);
          show_cache_clusters_not_in_replication_groups =
            (Util.option_bind
               (Xml.member "ShowCacheClustersNotInReplicationGroups" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.cache_cluster_id
                  (fun f ->
                     Ezxmlm.make_tag "CacheClusterId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.max_records
                 (fun f ->
                    Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.marker
                (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
            @
            [Util.option_map v.show_cache_node_info
               (fun f ->
                  Ezxmlm.make_tag "ShowCacheNodeInfo"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.show_cache_clusters_not_in_replication_groups
              (fun f ->
                 Ezxmlm.make_tag "ShowCacheClustersNotInReplicationGroups"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.show_cache_clusters_not_in_replication_groups
              (fun f ->
                 ("show_cache_clusters_not_in_replication_groups",
                   (Boolean.to_json f)));
           Util.option_map v.show_cache_node_info
             (fun f -> ("show_cache_node_info", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let of_json j =
      {
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        show_cache_node_info =
          (Util.option_map (Json.lookup j "show_cache_node_info")
             Boolean.of_json);
        show_cache_clusters_not_in_replication_groups =
          (Util.option_map
             (Json.lookup j "show_cache_clusters_not_in_replication_groups")
             Boolean.of_json)
      }
  end
module DeleteCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t ;
      final_snapshot_identifier: String.t option }
    let make ~cache_cluster_id  ?final_snapshot_identifier  () =
      { cache_cluster_id; final_snapshot_identifier }
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Xml.required "CacheClusterId"
               (Util.option_bind (Xml.member "CacheClusterId" xml)
                  String.parse));
          final_snapshot_identifier =
            (Util.option_bind (Xml.member "FinalSnapshotIdentifier" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CacheClusterId"
                  ([], (String.to_xml v.cache_cluster_id)))])
           @
           [Util.option_map v.final_snapshot_identifier
              (fun f ->
                 Ezxmlm.make_tag "FinalSnapshotIdentifier"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.final_snapshot_identifier
              (fun f -> ("final_snapshot_identifier", (String.to_json f)));
           Some ("cache_cluster_id", (String.to_json v.cache_cluster_id))])
    let of_json j =
      {
        cache_cluster_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_id")));
        final_snapshot_identifier =
          (Util.option_map (Json.lookup j "final_snapshot_identifier")
             String.of_json)
      }
  end
module DeleteReplicationGroupResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module ServiceUpdateNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeSnapshotsListMessage =
  struct
    type t = {
      marker: String.t option ;
      snapshots: SnapshotList.t }
    let make ?marker  ?(snapshots= [])  () = { marker; snapshots }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          snapshots =
            (Util.of_option []
               (Util.option_bind (Xml.member "Snapshots" xml)
                  SnapshotList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("snapshots", (SnapshotList.to_json v.snapshots));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        snapshots =
          (SnapshotList.of_json
             (Util.of_option_exn (Json.lookup j "snapshots")))
      }
  end
module CreateReplicationGroupResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module DescribeServiceUpdatesMessage =
  struct
    type t =
      {
      service_update_name: String.t option ;
      service_update_status: ServiceUpdateStatusList.t ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?service_update_name  ?(service_update_status= [])  ?max_records
       ?marker  () =
      { service_update_name; service_update_status; max_records; marker }
    let parse xml =
      Some
        {
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          service_update_status =
            (Util.of_option []
               (Util.option_bind (Xml.member "ServiceUpdateStatus" xml)
                  ServiceUpdateStatusList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.service_update_name
                 (fun f ->
                    Ezxmlm.make_tag "ServiceUpdateName"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ServiceUpdateStatus"
                        ([], (ServiceUpdateStatusList.to_xml [x]))))
                v.service_update_status))
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some
             ("service_update_status",
               (ServiceUpdateStatusList.to_json v.service_update_status));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)))])
    let of_json j =
      {
        service_update_name =
          (Util.option_map (Json.lookup j "service_update_name")
             String.of_json);
        service_update_status =
          (ServiceUpdateStatusList.of_json
             (Util.of_option_exn (Json.lookup j "service_update_status")));
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module ModifyCacheSubnetGroupResult =
  struct
    type t = {
      cache_subnet_group: CacheSubnetGroup.t option }
    let make ?cache_subnet_group  () = { cache_subnet_group }
    let parse xml =
      Some
        {
          cache_subnet_group =
            (Util.option_bind (Xml.member "CacheSubnetGroup" xml)
               CacheSubnetGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_subnet_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSubnetGroup"
                   ([], (CacheSubnetGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_subnet_group
              (fun f -> ("cache_subnet_group", (CacheSubnetGroup.to_json f)))])
    let of_json j =
      {
        cache_subnet_group =
          (Util.option_map (Json.lookup j "cache_subnet_group")
             CacheSubnetGroup.of_json)
      }
  end
module CacheParameterGroupAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module SnapshotNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeReplicationGroupsMessage =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?replication_group_id  ?max_records  ?marker  () =
      { replication_group_id; max_records; marker }
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.replication_group_id
                (fun f ->
                   Ezxmlm.make_tag "ReplicationGroupId"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module ReservedCacheNodesOfferingNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DeleteCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let of_json j =
      {
        cache_cluster =
          (Util.option_map (Json.lookup j "cache_cluster")
             CacheCluster.of_json)
      }
  end
module AuthorizationNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ServiceUpdatesMessage =
  struct
    type t = {
      marker: String.t option ;
      service_updates: ServiceUpdateList.t }
    let make ?marker  ?(service_updates= [])  () =
      { marker; service_updates }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          service_updates =
            (Util.of_option []
               (Util.option_bind (Xml.member "ServiceUpdates" xml)
                  ServiceUpdateList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("service_updates",
                (ServiceUpdateList.to_json v.service_updates));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        service_updates =
          (ServiceUpdateList.of_json
             (Util.of_option_exn (Json.lookup j "service_updates")))
      }
  end
module ReplicationGroupAlreadyUnderMigrationFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ReservedCacheNodeAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheSubnetGroupMessage =
  struct
    type t =
      {
      marker: String.t option ;
      cache_subnet_groups: CacheSubnetGroups.t }
    let make ?marker  ?(cache_subnet_groups= [])  () =
      { marker; cache_subnet_groups }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_subnet_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSubnetGroups" xml)
                  CacheSubnetGroups.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_subnet_groups",
                (CacheSubnetGroups.to_json v.cache_subnet_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        cache_subnet_groups =
          (CacheSubnetGroups.of_json
             (Util.of_option_exn (Json.lookup j "cache_subnet_groups")))
      }
  end
module CacheSecurityGroupNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CompleteMigrationMessage =
  struct
    type t = {
      replication_group_id: String.t ;
      force: Boolean.t option }
    let make ~replication_group_id  ?force  () =
      { replication_group_id; force }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          force = (Util.option_bind (Xml.member "Force" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ReplicationGroupId"
                  ([], (String.to_xml v.replication_group_id)))])
           @
           [Util.option_map v.force
              (fun f -> Ezxmlm.make_tag "Force" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        force = (Util.option_map (Json.lookup j "force") Boolean.of_json)
      }
  end
module DeleteCacheParameterGroupMessage =
  struct
    type t = {
      cache_parameter_group_name: String.t }
    let make ~cache_parameter_group_name  () = { cache_parameter_group_name }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Xml.required "CacheParameterGroupName"
               (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "CacheParameterGroupName"
                 ([], (String.to_xml v.cache_parameter_group_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_parameter_group_name",
                (String.to_json v.cache_parameter_group_name))])
    let of_json j =
      {
        cache_parameter_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_parameter_group_name")))
      }
  end
module DecreaseReplicaCountResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module NodeGroupNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module AuthorizeCacheSecurityGroupIngressMessage =
  struct
    type t =
      {
      cache_security_group_name: String.t ;
      e_c2_security_group_name: String.t ;
      e_c2_security_group_owner_id: String.t }
    let make ~cache_security_group_name  ~e_c2_security_group_name 
      ~e_c2_security_group_owner_id  () =
      {
        cache_security_group_name;
        e_c2_security_group_name;
        e_c2_security_group_owner_id
      }
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Xml.required "CacheSecurityGroupName"
               (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
                  String.parse));
          e_c2_security_group_name =
            (Xml.required "EC2SecurityGroupName"
               (Util.option_bind (Xml.member "EC2SecurityGroupName" xml)
                  String.parse));
          e_c2_security_group_owner_id =
            (Xml.required "EC2SecurityGroupOwnerId"
               (Util.option_bind (Xml.member "EC2SecurityGroupOwnerId" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheSecurityGroupName"
                   ([], (String.to_xml v.cache_security_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "EC2SecurityGroupName"
                  ([], (String.to_xml v.e_c2_security_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "EC2SecurityGroupOwnerId"
                 ([], (String.to_xml v.e_c2_security_group_owner_id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("e_c2_security_group_owner_id",
                (String.to_json v.e_c2_security_group_owner_id));
           Some
             ("e_c2_security_group_name",
               (String.to_json v.e_c2_security_group_name));
           Some
             ("cache_security_group_name",
               (String.to_json v.cache_security_group_name))])
    let of_json j =
      {
        cache_security_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_name")));
        e_c2_security_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "e_c2_security_group_name")));
        e_c2_security_group_owner_id =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "e_c2_security_group_owner_id")))
      }
  end
module NodeQuotaForCustomerExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CompleteMigrationResponse =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module DescribeReservedCacheNodesOfferingsMessage =
  struct
    type t =
      {
      reserved_cache_nodes_offering_id: String.t option ;
      cache_node_type: String.t option ;
      duration: String.t option ;
      product_description: String.t option ;
      offering_type: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?reserved_cache_nodes_offering_id  ?cache_node_type  ?duration 
      ?product_description  ?offering_type  ?max_records  ?marker  () =
      {
        reserved_cache_nodes_offering_id;
        cache_node_type;
        duration;
        product_description;
        offering_type;
        max_records;
        marker
      }
    let parse xml =
      Some
        {
          reserved_cache_nodes_offering_id =
            (Util.option_bind (Xml.member "ReservedCacheNodesOfferingId" xml)
               String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) String.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.reserved_cache_nodes_offering_id
                    (fun f ->
                       Ezxmlm.make_tag "ReservedCacheNodesOfferingId"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.cache_node_type
                   (fun f ->
                      Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.duration
                  (fun f ->
                     Ezxmlm.make_tag "Duration" ([], (String.to_xml f)))])
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
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.reserved_cache_nodes_offering_id
             (fun f ->
                ("reserved_cache_nodes_offering_id", (String.to_json f)))])
    let of_json j =
      {
        reserved_cache_nodes_offering_id =
          (Util.option_map (Json.lookup j "reserved_cache_nodes_offering_id")
             String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") String.of_json);
        product_description =
          (Util.option_map (Json.lookup j "product_description")
             String.of_json);
        offering_type =
          (Util.option_map (Json.lookup j "offering_type") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module NodeGroupsPerReplicationGroupQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module TagListMessage =
  struct
    type t = {
      tag_list: TagList.t }
    let make ?(tag_list= [])  () = { tag_list }
    let parse xml =
      Some
        {
          tag_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagList" xml) TagList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagList" ([], (TagList.to_xml [x]))))
              v.tag_list))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_list", (TagList.to_json v.tag_list))])
    let of_json j =
      {
        tag_list =
          (TagList.of_json (Util.of_option_exn (Json.lookup j "tag_list")))
      }
  end
module CacheSecurityGroupQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module PurchaseReservedCacheNodesOfferingMessage =
  struct
    type t =
      {
      reserved_cache_nodes_offering_id: String.t ;
      reserved_cache_node_id: String.t option ;
      cache_node_count: Integer.t option }
    let make ~reserved_cache_nodes_offering_id  ?reserved_cache_node_id 
      ?cache_node_count  () =
      {
        reserved_cache_nodes_offering_id;
        reserved_cache_node_id;
        cache_node_count
      }
    let parse xml =
      Some
        {
          reserved_cache_nodes_offering_id =
            (Xml.required "ReservedCacheNodesOfferingId"
               (Util.option_bind
                  (Xml.member "ReservedCacheNodesOfferingId" xml)
                  String.parse));
          reserved_cache_node_id =
            (Util.option_bind (Xml.member "ReservedCacheNodeId" xml)
               String.parse);
          cache_node_count =
            (Util.option_bind (Xml.member "CacheNodeCount" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ReservedCacheNodesOfferingId"
                   ([], (String.to_xml v.reserved_cache_nodes_offering_id)))])
            @
            [Util.option_map v.reserved_cache_node_id
               (fun f ->
                  Ezxmlm.make_tag "ReservedCacheNodeId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.cache_node_count
              (fun f ->
                 Ezxmlm.make_tag "CacheNodeCount" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_node_count
              (fun f -> ("cache_node_count", (Integer.to_json f)));
           Util.option_map v.reserved_cache_node_id
             (fun f -> ("reserved_cache_node_id", (String.to_json f)));
           Some
             ("reserved_cache_nodes_offering_id",
               (String.to_json v.reserved_cache_nodes_offering_id))])
    let of_json j =
      {
        reserved_cache_nodes_offering_id =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "reserved_cache_nodes_offering_id")));
        reserved_cache_node_id =
          (Util.option_map (Json.lookup j "reserved_cache_node_id")
             String.of_json);
        cache_node_count =
          (Util.option_map (Json.lookup j "cache_node_count") Integer.of_json)
      }
  end
module IncreaseReplicaCountResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module AuthorizationAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DeleteReplicationGroupMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      retain_primary_cluster: Boolean.t option ;
      final_snapshot_identifier: String.t option }
    let make ~replication_group_id  ?retain_primary_cluster 
      ?final_snapshot_identifier  () =
      {
        replication_group_id;
        retain_primary_cluster;
        final_snapshot_identifier
      }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          retain_primary_cluster =
            (Util.option_bind (Xml.member "RetainPrimaryCluster" xml)
               Boolean.parse);
          final_snapshot_identifier =
            (Util.option_bind (Xml.member "FinalSnapshotIdentifier" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ReplicationGroupId"
                   ([], (String.to_xml v.replication_group_id)))])
            @
            [Util.option_map v.retain_primary_cluster
               (fun f ->
                  Ezxmlm.make_tag "RetainPrimaryCluster"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.final_snapshot_identifier
              (fun f ->
                 Ezxmlm.make_tag "FinalSnapshotIdentifier"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.final_snapshot_identifier
              (fun f -> ("final_snapshot_identifier", (String.to_json f)));
           Util.option_map v.retain_primary_cluster
             (fun f -> ("retain_primary_cluster", (Boolean.to_json f)));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        retain_primary_cluster =
          (Util.option_map (Json.lookup j "retain_primary_cluster")
             Boolean.of_json);
        final_snapshot_identifier =
          (Util.option_map (Json.lookup j "final_snapshot_identifier")
             String.of_json)
      }
  end
module TestFailoverMessage =
  struct
    type t = {
      replication_group_id: String.t ;
      node_group_id: String.t }
    let make ~replication_group_id  ~node_group_id  () =
      { replication_group_id; node_group_id }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          node_group_id =
            (Xml.required "NodeGroupId"
               (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ReplicationGroupId"
                  ([], (String.to_xml v.replication_group_id)))])
           @
           [Some
              (Ezxmlm.make_tag "NodeGroupId"
                 ([], (String.to_xml v.node_group_id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("node_group_id", (String.to_json v.node_group_id));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        node_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "node_group_id")))
      }
  end
module ClusterQuotaForCustomerExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module TagNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CopySnapshotResult =
  struct
    type t = {
      snapshot: Snapshot.t option }
    let make ?snapshot  () = { snapshot }
    let parse xml =
      Some
        {
          snapshot =
            (Util.option_bind (Xml.member "Snapshot" xml) Snapshot.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.snapshot
              (fun f -> Ezxmlm.make_tag "Snapshot" ([], (Snapshot.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot
              (fun f -> ("snapshot", (Snapshot.to_json f)))])
    let of_json j =
      {
        snapshot =
          (Util.option_map (Json.lookup j "snapshot") Snapshot.of_json)
      }
  end
module DescribeCacheSecurityGroupsMessage =
  struct
    type t =
      {
      cache_security_group_name: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?cache_security_group_name  ?max_records  ?marker  () =
      { cache_security_group_name; max_records; marker }
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cache_security_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheSecurityGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_security_group_name
             (fun f -> ("cache_security_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_security_group_name =
          (Util.option_map (Json.lookup j "cache_security_group_name")
             String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module TestFailoverNotAvailableFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheSubnetGroupNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DecreaseReplicaCountMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      new_replica_count: Integer.t option ;
      replica_configuration: ReplicaConfigurationList.t ;
      replicas_to_remove: RemoveReplicasList.t ;
      apply_immediately: Boolean.t }
    let make ~replication_group_id  ?new_replica_count 
      ?(replica_configuration= [])  ?(replicas_to_remove= []) 
      ~apply_immediately  () =
      {
        replication_group_id;
        new_replica_count;
        replica_configuration;
        replicas_to_remove;
        apply_immediately
      }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          new_replica_count =
            (Util.option_bind (Xml.member "NewReplicaCount" xml)
               Integer.parse);
          replica_configuration =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicaConfiguration" xml)
                  ReplicaConfigurationList.parse));
          replicas_to_remove =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicasToRemove" xml)
                  RemoveReplicasList.parse));
          apply_immediately =
            (Xml.required "ApplyImmediately"
               (Util.option_bind (Xml.member "ApplyImmediately" xml)
                  Boolean.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "ReplicationGroupId"
                     ([], (String.to_xml v.replication_group_id)))])
              @
              [Util.option_map v.new_replica_count
                 (fun f ->
                    Ezxmlm.make_tag "NewReplicaCount"
                      ([], (Integer.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ReplicaConfiguration"
                        ([], (ReplicaConfigurationList.to_xml [x]))))
                v.replica_configuration))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ReplicasToRemove"
                       ([], (RemoveReplicasList.to_xml [x]))))
               v.replicas_to_remove))
           @
           [Some
              (Ezxmlm.make_tag "ApplyImmediately"
                 ([], (Boolean.to_xml v.apply_immediately)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("apply_immediately", (Boolean.to_json v.apply_immediately));
           Some
             ("replicas_to_remove",
               (RemoveReplicasList.to_json v.replicas_to_remove));
           Some
             ("replica_configuration",
               (ReplicaConfigurationList.to_json v.replica_configuration));
           Util.option_map v.new_replica_count
             (fun f -> ("new_replica_count", (Integer.to_json f)));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        new_replica_count =
          (Util.option_map (Json.lookup j "new_replica_count")
             Integer.of_json);
        replica_configuration =
          (ReplicaConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "replica_configuration")));
        replicas_to_remove =
          (RemoveReplicasList.of_json
             (Util.of_option_exn (Json.lookup j "replicas_to_remove")));
        apply_immediately =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "apply_immediately")))
      }
  end
module ResetCacheParameterGroupMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t ;
      reset_all_parameters: Boolean.t option ;
      parameter_name_values: ParameterNameValueList.t }
    let make ~cache_parameter_group_name  ?reset_all_parameters 
      ?(parameter_name_values= [])  () =
      {
        cache_parameter_group_name;
        reset_all_parameters;
        parameter_name_values
      }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Xml.required "CacheParameterGroupName"
               (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
                  String.parse));
          reset_all_parameters =
            (Util.option_bind (Xml.member "ResetAllParameters" xml)
               Boolean.parse);
          parameter_name_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "ParameterNameValues" xml)
                  ParameterNameValueList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheParameterGroupName"
                   ([], (String.to_xml v.cache_parameter_group_name)))])
            @
            [Util.option_map v.reset_all_parameters
               (fun f ->
                  Ezxmlm.make_tag "ResetAllParameters"
                    ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ParameterNameValues"
                      ([], (ParameterNameValueList.to_xml [x]))))
              v.parameter_name_values))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("parameter_name_values",
                (ParameterNameValueList.to_json v.parameter_name_values));
           Util.option_map v.reset_all_parameters
             (fun f -> ("reset_all_parameters", (Boolean.to_json f)));
           Some
             ("cache_parameter_group_name",
               (String.to_json v.cache_parameter_group_name))])
    let of_json j =
      {
        cache_parameter_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_parameter_group_name")));
        reset_all_parameters =
          (Util.option_map (Json.lookup j "reset_all_parameters")
             Boolean.of_json);
        parameter_name_values =
          (ParameterNameValueList.of_json
             (Util.of_option_exn (Json.lookup j "parameter_name_values")))
      }
  end
module CacheSecurityGroupAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module RevokeCacheSecurityGroupIngressResult =
  struct
    type t = {
      cache_security_group: CacheSecurityGroup.t option }
    let make ?cache_security_group  () = { cache_security_group }
    let parse xml =
      Some
        {
          cache_security_group =
            (Util.option_bind (Xml.member "CacheSecurityGroup" xml)
               CacheSecurityGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_security_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSecurityGroup"
                   ([], (CacheSecurityGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_security_group
              (fun f ->
                 ("cache_security_group", (CacheSecurityGroup.to_json f)))])
    let of_json j =
      {
        cache_security_group =
          (Util.option_map (Json.lookup j "cache_security_group")
             CacheSecurityGroup.of_json)
      }
  end
module DescribeEventsMessage =
  struct
    type t =
      {
      source_identifier: String.t option ;
      source_type: SourceType.t option ;
      start_time: DateTime.t option ;
      end_time: DateTime.t option ;
      duration: Integer.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?source_identifier  ?source_type  ?start_time  ?end_time 
      ?duration  ?max_records  ?marker  () =
      {
        source_identifier;
        source_type;
        start_time;
        end_time;
        duration;
        max_records;
        marker
      }
    let parse xml =
      Some
        {
          source_identifier =
            (Util.option_bind (Xml.member "SourceIdentifier" xml)
               String.parse);
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) SourceType.parse);
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) Integer.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.source_identifier
                    (fun f ->
                       Ezxmlm.make_tag "SourceIdentifier"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.source_type
                   (fun f ->
                      Ezxmlm.make_tag "SourceType"
                        ([], (SourceType.to_xml f)))])
               @
               [Util.option_map v.start_time
                  (fun f ->
                     Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.end_time
                 (fun f ->
                    Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.duration
                (fun f -> Ezxmlm.make_tag "Duration" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.source_type
             (fun f -> ("source_type", (SourceType.to_json f)));
           Util.option_map v.source_identifier
             (fun f -> ("source_identifier", (String.to_json f)))])
    let of_json j =
      {
        source_identifier =
          (Util.option_map (Json.lookup j "source_identifier") String.of_json);
        source_type =
          (Util.option_map (Json.lookup j "source_type") SourceType.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module ModifyCacheSubnetGroupMessage =
  struct
    type t =
      {
      cache_subnet_group_name: String.t ;
      cache_subnet_group_description: String.t option ;
      subnet_ids: SubnetIdentifierList.t }
    let make ~cache_subnet_group_name  ?cache_subnet_group_description 
      ?(subnet_ids= [])  () =
      { cache_subnet_group_name; cache_subnet_group_description; subnet_ids }
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Xml.required "CacheSubnetGroupName"
               (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
                  String.parse));
          cache_subnet_group_description =
            (Util.option_bind (Xml.member "CacheSubnetGroupDescription" xml)
               String.parse);
          subnet_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "SubnetIds" xml)
                  SubnetIdentifierList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheSubnetGroupName"
                   ([], (String.to_xml v.cache_subnet_group_name)))])
            @
            [Util.option_map v.cache_subnet_group_description
               (fun f ->
                  Ezxmlm.make_tag "CacheSubnetGroupDescription"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SubnetIds"
                      ([], (SubnetIdentifierList.to_xml [x])))) v.subnet_ids))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_ids", (SubnetIdentifierList.to_json v.subnet_ids));
           Util.option_map v.cache_subnet_group_description
             (fun f -> ("cache_subnet_group_description", (String.to_json f)));
           Some
             ("cache_subnet_group_name",
               (String.to_json v.cache_subnet_group_name))])
    let of_json j =
      {
        cache_subnet_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_subnet_group_name")));
        cache_subnet_group_description =
          (Util.option_map (Json.lookup j "cache_subnet_group_description")
             String.of_json);
        subnet_ids =
          (SubnetIdentifierList.of_json
             (Util.of_option_exn (Json.lookup j "subnet_ids")))
      }
  end
module ReservedCacheNodeNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module RevokeCacheSecurityGroupIngressMessage =
  struct
    type t =
      {
      cache_security_group_name: String.t ;
      e_c2_security_group_name: String.t ;
      e_c2_security_group_owner_id: String.t }
    let make ~cache_security_group_name  ~e_c2_security_group_name 
      ~e_c2_security_group_owner_id  () =
      {
        cache_security_group_name;
        e_c2_security_group_name;
        e_c2_security_group_owner_id
      }
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Xml.required "CacheSecurityGroupName"
               (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
                  String.parse));
          e_c2_security_group_name =
            (Xml.required "EC2SecurityGroupName"
               (Util.option_bind (Xml.member "EC2SecurityGroupName" xml)
                  String.parse));
          e_c2_security_group_owner_id =
            (Xml.required "EC2SecurityGroupOwnerId"
               (Util.option_bind (Xml.member "EC2SecurityGroupOwnerId" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheSecurityGroupName"
                   ([], (String.to_xml v.cache_security_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "EC2SecurityGroupName"
                  ([], (String.to_xml v.e_c2_security_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "EC2SecurityGroupOwnerId"
                 ([], (String.to_xml v.e_c2_security_group_owner_id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("e_c2_security_group_owner_id",
                (String.to_json v.e_c2_security_group_owner_id));
           Some
             ("e_c2_security_group_name",
               (String.to_json v.e_c2_security_group_name));
           Some
             ("cache_security_group_name",
               (String.to_json v.cache_security_group_name))])
    let of_json j =
      {
        cache_security_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_name")));
        e_c2_security_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "e_c2_security_group_name")));
        e_c2_security_group_owner_id =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "e_c2_security_group_owner_id")))
      }
  end
module ServiceLinkedRoleNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module InvalidReplicationGroupStateFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module SnapshotAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateReplicationGroupMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      replication_group_description: String.t ;
      primary_cluster_id: String.t option ;
      automatic_failover_enabled: Boolean.t option ;
      num_cache_clusters: Integer.t option ;
      preferred_cache_cluster_a_zs: AvailabilityZonesList.t ;
      num_node_groups: Integer.t option ;
      replicas_per_node_group: Integer.t option ;
      node_group_configuration: NodeGroupConfigurationList.t ;
      cache_node_type: String.t option ;
      engine: String.t option ;
      engine_version: String.t option ;
      cache_parameter_group_name: String.t option ;
      cache_subnet_group_name: String.t option ;
      cache_security_group_names: CacheSecurityGroupNameList.t ;
      security_group_ids: SecurityGroupIdsList.t ;
      tags: TagList.t ;
      snapshot_arns: SnapshotArnsList.t ;
      snapshot_name: String.t option ;
      preferred_maintenance_window: String.t option ;
      port: Integer.t option ;
      notification_topic_arn: String.t option ;
      auto_minor_version_upgrade: Boolean.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      auth_token: String.t option ;
      transit_encryption_enabled: Boolean.t option ;
      at_rest_encryption_enabled: Boolean.t option ;
      kms_key_id: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        replication_group_description =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "replication_group_description")));
        primary_cluster_id =
          (Util.option_map (Json.lookup j "primary_cluster_id")
             String.of_json);
        automatic_failover_enabled =
          (Util.option_map (Json.lookup j "automatic_failover_enabled")
             Boolean.of_json);
        num_cache_clusters =
          (Util.option_map (Json.lookup j "num_cache_clusters")
             Integer.of_json);
        preferred_cache_cluster_a_zs =
          (AvailabilityZonesList.of_json
             (Util.of_option_exn
                (Json.lookup j "preferred_cache_cluster_a_zs")));
        num_node_groups =
          (Util.option_map (Json.lookup j "num_node_groups") Integer.of_json);
        replicas_per_node_group =
          (Util.option_map (Json.lookup j "replicas_per_node_group")
             Integer.of_json);
        node_group_configuration =
          (NodeGroupConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "node_group_configuration")));
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        cache_subnet_group_name =
          (Util.option_map (Json.lookup j "cache_subnet_group_name")
             String.of_json);
        cache_security_group_names =
          (CacheSecurityGroupNameList.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_names")));
        security_group_ids =
          (SecurityGroupIdsList.of_json
             (Util.of_option_exn (Json.lookup j "security_group_ids")));
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")));
        snapshot_arns =
          (SnapshotArnsList.of_json
             (Util.of_option_exn (Json.lookup j "snapshot_arns")));
        snapshot_name =
          (Util.option_map (Json.lookup j "snapshot_name") String.of_json);
        preferred_maintenance_window =
          (Util.option_map (Json.lookup j "preferred_maintenance_window")
             String.of_json);
        port = (Util.option_map (Json.lookup j "port") Integer.of_json);
        notification_topic_arn =
          (Util.option_map (Json.lookup j "notification_topic_arn")
             String.of_json);
        auto_minor_version_upgrade =
          (Util.option_map (Json.lookup j "auto_minor_version_upgrade")
             Boolean.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        auth_token =
          (Util.option_map (Json.lookup j "auth_token") String.of_json);
        transit_encryption_enabled =
          (Util.option_map (Json.lookup j "transit_encryption_enabled")
             Boolean.of_json);
        at_rest_encryption_enabled =
          (Util.option_map (Json.lookup j "at_rest_encryption_enabled")
             Boolean.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json)
      }
  end
module InvalidCacheClusterStateFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ReplicationGroupNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheClusterMessage =
  struct
    type t = {
      marker: String.t option ;
      cache_clusters: CacheClusterList.t }
    let make ?marker  ?(cache_clusters= [])  () = { marker; cache_clusters }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_clusters =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheClusters" xml)
                  CacheClusterList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_clusters", (CacheClusterList.to_json v.cache_clusters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        cache_clusters =
          (CacheClusterList.of_json
             (Util.of_option_exn (Json.lookup j "cache_clusters")))
      }
  end
module CacheParameterGroupQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheSubnetGroupAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateCacheSubnetGroupMessage =
  struct
    type t =
      {
      cache_subnet_group_name: String.t ;
      cache_subnet_group_description: String.t ;
      subnet_ids: SubnetIdentifierList.t }
    let make ~cache_subnet_group_name  ~cache_subnet_group_description 
      ~subnet_ids  () =
      { cache_subnet_group_name; cache_subnet_group_description; subnet_ids }
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Xml.required "CacheSubnetGroupName"
               (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
                  String.parse));
          cache_subnet_group_description =
            (Xml.required "CacheSubnetGroupDescription"
               (Util.option_bind
                  (Xml.member "CacheSubnetGroupDescription" xml) String.parse));
          subnet_ids =
            (Xml.required "SubnetIds"
               (Util.option_bind (Xml.member "SubnetIds" xml)
                  SubnetIdentifierList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheSubnetGroupName"
                   ([], (String.to_xml v.cache_subnet_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "CacheSubnetGroupDescription"
                  ([], (String.to_xml v.cache_subnet_group_description)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SubnetIds"
                      ([], (SubnetIdentifierList.to_xml [x])))) v.subnet_ids))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_ids", (SubnetIdentifierList.to_json v.subnet_ids));
           Some
             ("cache_subnet_group_description",
               (String.to_json v.cache_subnet_group_description));
           Some
             ("cache_subnet_group_name",
               (String.to_json v.cache_subnet_group_name))])
    let of_json j =
      {
        cache_subnet_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_subnet_group_name")));
        cache_subnet_group_description =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "cache_subnet_group_description")));
        subnet_ids =
          (SubnetIdentifierList.of_json
             (Util.of_option_exn (Json.lookup j "subnet_ids")))
      }
  end
module RebootCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t ;
      cache_node_ids_to_reboot: CacheNodeIdsList.t }
    let make ~cache_cluster_id  ~cache_node_ids_to_reboot  () =
      { cache_cluster_id; cache_node_ids_to_reboot }
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Xml.required "CacheClusterId"
               (Util.option_bind (Xml.member "CacheClusterId" xml)
                  String.parse));
          cache_node_ids_to_reboot =
            (Xml.required "CacheNodeIdsToReboot"
               (Util.option_bind (Xml.member "CacheNodeIdsToReboot" xml)
                  CacheNodeIdsList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CacheClusterId"
                  ([], (String.to_xml v.cache_cluster_id)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CacheNodeIdsToReboot"
                      ([], (CacheNodeIdsList.to_xml [x]))))
              v.cache_node_ids_to_reboot))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_node_ids_to_reboot",
                (CacheNodeIdsList.to_json v.cache_node_ids_to_reboot));
           Some ("cache_cluster_id", (String.to_json v.cache_cluster_id))])
    let of_json j =
      {
        cache_cluster_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_id")));
        cache_node_ids_to_reboot =
          (CacheNodeIdsList.of_json
             (Util.of_option_exn (Json.lookup j "cache_node_ids_to_reboot")))
      }
  end
module DescribeEngineDefaultParametersResult =
  struct
    type t = {
      engine_defaults: EngineDefaults.t }
    let make ~engine_defaults  () = { engine_defaults }
    let parse xml =
      Some
        {
          engine_defaults =
            (Xml.required "EngineDefaults"
               (Util.option_bind (Xml.member "EngineDefaults" xml)
                  EngineDefaults.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "EngineDefaults"
                 ([], (EngineDefaults.to_xml v.engine_defaults)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("engine_defaults", (EngineDefaults.to_json v.engine_defaults))])
    let of_json j =
      {
        engine_defaults =
          (EngineDefaults.of_json
             (Util.of_option_exn (Json.lookup j "engine_defaults")))
      }
  end
module InvalidParameterValueException =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module TagQuotaPerResourceExceeded =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DeleteSnapshotResult =
  struct
    type t = {
      snapshot: Snapshot.t option }
    let make ?snapshot  () = { snapshot }
    let parse xml =
      Some
        {
          snapshot =
            (Util.option_bind (Xml.member "Snapshot" xml) Snapshot.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.snapshot
              (fun f -> Ezxmlm.make_tag "Snapshot" ([], (Snapshot.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot
              (fun f -> ("snapshot", (Snapshot.to_json f)))])
    let of_json j =
      {
        snapshot =
          (Util.option_map (Json.lookup j "snapshot") Snapshot.of_json)
      }
  end
module ReservedCacheNodeQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module InvalidKMSKeyFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module InsufficientCacheClusterCapacityFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module SnapshotQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module InvalidSubnet =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ModifyReplicationGroupShardConfigurationMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      node_group_count: Integer.t ;
      apply_immediately: Boolean.t ;
      resharding_configuration: ReshardingConfigurationList.t ;
      node_groups_to_remove: NodeGroupsToRemoveList.t ;
      node_groups_to_retain: NodeGroupsToRetainList.t }
    let make ~replication_group_id  ~node_group_count  ~apply_immediately 
      ?(resharding_configuration= [])  ?(node_groups_to_remove= []) 
      ?(node_groups_to_retain= [])  () =
      {
        replication_group_id;
        node_group_count;
        apply_immediately;
        resharding_configuration;
        node_groups_to_remove;
        node_groups_to_retain
      }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          node_group_count =
            (Xml.required "NodeGroupCount"
               (Util.option_bind (Xml.member "NodeGroupCount" xml)
                  Integer.parse));
          apply_immediately =
            (Xml.required "ApplyImmediately"
               (Util.option_bind (Xml.member "ApplyImmediately" xml)
                  Boolean.parse));
          resharding_configuration =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReshardingConfiguration" xml)
                  ReshardingConfigurationList.parse));
          node_groups_to_remove =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeGroupsToRemove" xml)
                  NodeGroupsToRemoveList.parse));
          node_groups_to_retain =
            (Util.of_option []
               (Util.option_bind (Xml.member "NodeGroupsToRetain" xml)
                  NodeGroupsToRetainList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "ReplicationGroupId"
                      ([], (String.to_xml v.replication_group_id)))])
               @
               [Some
                  (Ezxmlm.make_tag "NodeGroupCount"
                     ([], (Integer.to_xml v.node_group_count)))])
              @
              [Some
                 (Ezxmlm.make_tag "ApplyImmediately"
                    ([], (Boolean.to_xml v.apply_immediately)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ReshardingConfiguration"
                        ([], (ReshardingConfigurationList.to_xml [x]))))
                v.resharding_configuration))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "NodeGroupsToRemove"
                       ([], (NodeGroupsToRemoveList.to_xml [x]))))
               v.node_groups_to_remove))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "NodeGroupsToRetain"
                      ([], (NodeGroupsToRetainList.to_xml [x]))))
              v.node_groups_to_retain))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("node_groups_to_retain",
                (NodeGroupsToRetainList.to_json v.node_groups_to_retain));
           Some
             ("node_groups_to_remove",
               (NodeGroupsToRemoveList.to_json v.node_groups_to_remove));
           Some
             ("resharding_configuration",
               (ReshardingConfigurationList.to_json
                  v.resharding_configuration));
           Some ("apply_immediately", (Boolean.to_json v.apply_immediately));
           Some ("node_group_count", (Integer.to_json v.node_group_count));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        node_group_count =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "node_group_count")));
        apply_immediately =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "apply_immediately")));
        resharding_configuration =
          (ReshardingConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "resharding_configuration")));
        node_groups_to_remove =
          (NodeGroupsToRemoveList.of_json
             (Util.of_option_exn (Json.lookup j "node_groups_to_remove")));
        node_groups_to_retain =
          (NodeGroupsToRetainList.of_json
             (Util.of_option_exn (Json.lookup j "node_groups_to_retain")))
      }
  end
module BatchApplyUpdateActionMessage =
  struct
    type t =
      {
      replication_group_ids: ReplicationGroupIdList.t ;
      cache_cluster_ids: CacheClusterIdList.t ;
      service_update_name: String.t }
    let make ?(replication_group_ids= [])  ?(cache_cluster_ids= []) 
      ~service_update_name  () =
      { replication_group_ids; cache_cluster_ids; service_update_name }
    let parse xml =
      Some
        {
          replication_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicationGroupIds" xml)
                  ReplicationGroupIdList.parse));
          cache_cluster_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheClusterIds" xml)
                  CacheClusterIdList.parse));
          service_update_name =
            (Xml.required "ServiceUpdateName"
               (Util.option_bind (Xml.member "ServiceUpdateName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ReplicationGroupIds"
                        ([], (ReplicationGroupIdList.to_xml [x]))))
                v.replication_group_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "CacheClusterIds"
                       ([], (CacheClusterIdList.to_xml [x]))))
               v.cache_cluster_ids))
           @
           [Some
              (Ezxmlm.make_tag "ServiceUpdateName"
                 ([], (String.to_xml v.service_update_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("service_update_name", (String.to_json v.service_update_name));
           Some
             ("cache_cluster_ids",
               (CacheClusterIdList.to_json v.cache_cluster_ids));
           Some
             ("replication_group_ids",
               (ReplicationGroupIdList.to_json v.replication_group_ids))])
    let of_json j =
      {
        replication_group_ids =
          (ReplicationGroupIdList.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_ids")));
        cache_cluster_ids =
          (CacheClusterIdList.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_ids")));
        service_update_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "service_update_name")))
      }
  end
module CreateCacheParameterGroupResult =
  struct
    type t = {
      cache_parameter_group: CacheParameterGroup.t option }
    let make ?cache_parameter_group  () = { cache_parameter_group }
    let parse xml =
      Some
        {
          cache_parameter_group =
            (Util.option_bind (Xml.member "CacheParameterGroup" xml)
               CacheParameterGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_parameter_group
              (fun f ->
                 Ezxmlm.make_tag "CacheParameterGroup"
                   ([], (CacheParameterGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_parameter_group
              (fun f ->
                 ("cache_parameter_group", (CacheParameterGroup.to_json f)))])
    let of_json j =
      {
        cache_parameter_group =
          (Util.option_map (Json.lookup j "cache_parameter_group")
             CacheParameterGroup.of_json)
      }
  end
module ReplicationGroupNotUnderMigrationFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module APICallRateForCustomerExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateCacheSecurityGroupMessage =
  struct
    type t = {
      cache_security_group_name: String.t ;
      description: String.t }
    let make ~cache_security_group_name  ~description  () =
      { cache_security_group_name; description }
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Xml.required "CacheSecurityGroupName"
               (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
                  String.parse));
          description =
            (Xml.required "Description"
               (Util.option_bind (Xml.member "Description" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CacheSecurityGroupName"
                  ([], (String.to_xml v.cache_security_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "Description"
                 ([], (String.to_xml v.description)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("description", (String.to_json v.description));
           Some
             ("cache_security_group_name",
               (String.to_json v.cache_security_group_name))])
    let of_json j =
      {
        cache_security_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_name")));
        description =
          (String.of_json (Util.of_option_exn (Json.lookup j "description")))
      }
  end
module AddTagsToResourceMessage =
  struct
    type t = {
      resource_name: String.t ;
      tags: TagList.t }
    let make ~resource_name  ~tags  () = { resource_name; tags }
    let parse xml =
      Some
        {
          resource_name =
            (Xml.required "ResourceName"
               (Util.option_bind (Xml.member "ResourceName" xml) String.parse));
          tags =
            (Xml.required "Tags"
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceName"
                  ([], (String.to_xml v.resource_name)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some ("resource_name", (String.to_json v.resource_name))])
    let of_json j =
      {
        resource_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "resource_name")));
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module CacheSubnetQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module BatchStopUpdateActionMessage =
  struct
    type t =
      {
      replication_group_ids: ReplicationGroupIdList.t ;
      cache_cluster_ids: CacheClusterIdList.t ;
      service_update_name: String.t }
    let make ?(replication_group_ids= [])  ?(cache_cluster_ids= []) 
      ~service_update_name  () =
      { replication_group_ids; cache_cluster_ids; service_update_name }
    let parse xml =
      Some
        {
          replication_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicationGroupIds" xml)
                  ReplicationGroupIdList.parse));
          cache_cluster_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheClusterIds" xml)
                  CacheClusterIdList.parse));
          service_update_name =
            (Xml.required "ServiceUpdateName"
               (Util.option_bind (Xml.member "ServiceUpdateName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ReplicationGroupIds"
                        ([], (ReplicationGroupIdList.to_xml [x]))))
                v.replication_group_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "CacheClusterIds"
                       ([], (CacheClusterIdList.to_xml [x]))))
               v.cache_cluster_ids))
           @
           [Some
              (Ezxmlm.make_tag "ServiceUpdateName"
                 ([], (String.to_xml v.service_update_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("service_update_name", (String.to_json v.service_update_name));
           Some
             ("cache_cluster_ids",
               (CacheClusterIdList.to_json v.cache_cluster_ids));
           Some
             ("replication_group_ids",
               (ReplicationGroupIdList.to_json v.replication_group_ids))])
    let of_json j =
      {
        replication_group_ids =
          (ReplicationGroupIdList.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_ids")));
        cache_cluster_ids =
          (CacheClusterIdList.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_ids")));
        service_update_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "service_update_name")))
      }
  end
module DescribeReservedCacheNodesMessage =
  struct
    type t =
      {
      reserved_cache_node_id: String.t option ;
      reserved_cache_nodes_offering_id: String.t option ;
      cache_node_type: String.t option ;
      duration: String.t option ;
      product_description: String.t option ;
      offering_type: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?reserved_cache_node_id  ?reserved_cache_nodes_offering_id 
      ?cache_node_type  ?duration  ?product_description  ?offering_type 
      ?max_records  ?marker  () =
      {
        reserved_cache_node_id;
        reserved_cache_nodes_offering_id;
        cache_node_type;
        duration;
        product_description;
        offering_type;
        max_records;
        marker
      }
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
          duration =
            (Util.option_bind (Xml.member "Duration" xml) String.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
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
                      Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.duration
                  (fun f ->
                     Ezxmlm.make_tag "Duration" ([], (String.to_xml f)))])
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
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.reserved_cache_nodes_offering_id
             (fun f ->
                ("reserved_cache_nodes_offering_id", (String.to_json f)));
           Util.option_map v.reserved_cache_node_id
             (fun f -> ("reserved_cache_node_id", (String.to_json f)))])
    let of_json j =
      {
        reserved_cache_node_id =
          (Util.option_map (Json.lookup j "reserved_cache_node_id")
             String.of_json);
        reserved_cache_nodes_offering_id =
          (Util.option_map (Json.lookup j "reserved_cache_nodes_offering_id")
             String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") String.of_json);
        product_description =
          (Util.option_map (Json.lookup j "product_description")
             String.of_json);
        offering_type =
          (Util.option_map (Json.lookup j "offering_type") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module SubnetInUse =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module InvalidVPCNetworkStateFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let of_json j =
      {
        cache_cluster =
          (Util.option_map (Json.lookup j "cache_cluster")
             CacheCluster.of_json)
      }
  end
module AuthorizeCacheSecurityGroupIngressResult =
  struct
    type t = {
      cache_security_group: CacheSecurityGroup.t option }
    let make ?cache_security_group  () = { cache_security_group }
    let parse xml =
      Some
        {
          cache_security_group =
            (Util.option_bind (Xml.member "CacheSecurityGroup" xml)
               CacheSecurityGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_security_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSecurityGroup"
                   ([], (CacheSecurityGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_security_group
              (fun f ->
                 ("cache_security_group", (CacheSecurityGroup.to_json f)))])
    let of_json j =
      {
        cache_security_group =
          (Util.option_map (Json.lookup j "cache_security_group")
             CacheSecurityGroup.of_json)
      }
  end
module InvalidParameterCombinationException =
  struct
    type t = {
      message: String.t option }
    let make ?message  () = { message }
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module CacheClusterNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module SnapshotFeatureNotSupportedFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheParameterGroupNotFoundFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateSnapshotMessage =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      cache_cluster_id: String.t option ;
      snapshot_name: String.t ;
      kms_key_id: String.t option }
    let make ?replication_group_id  ?cache_cluster_id  ~snapshot_name 
      ?kms_key_id  () =
      { replication_group_id; cache_cluster_id; snapshot_name; kms_key_id }
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          snapshot_name =
            (Xml.required "SnapshotName"
               (Util.option_bind (Xml.member "SnapshotName" xml) String.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
            [Some
               (Ezxmlm.make_tag "SnapshotName"
                  ([], (String.to_xml v.snapshot_name)))])
           @
           [Util.option_map v.kms_key_id
              (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.kms_key_id
              (fun f -> ("kms_key_id", (String.to_json f)));
           Some ("snapshot_name", (String.to_json v.snapshot_name));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        snapshot_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "snapshot_name")));
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json)
      }
  end
module InvalidARNFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module InvalidCacheParameterGroupStateFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ModifyReplicationGroupShardConfigurationResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module DescribeSnapshotsMessage =
  struct
    type t =
      {
      replication_group_id: String.t option ;
      cache_cluster_id: String.t option ;
      snapshot_name: String.t option ;
      snapshot_source: String.t option ;
      marker: String.t option ;
      max_records: Integer.t option ;
      show_node_group_config: Boolean.t option }
    let make ?replication_group_id  ?cache_cluster_id  ?snapshot_name 
      ?snapshot_source  ?marker  ?max_records  ?show_node_group_config  () =
      {
        replication_group_id;
        cache_cluster_id;
        snapshot_name;
        snapshot_source;
        marker;
        max_records;
        show_node_group_config
      }
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          snapshot_name =
            (Util.option_bind (Xml.member "SnapshotName" xml) String.parse);
          snapshot_source =
            (Util.option_bind (Xml.member "SnapshotSource" xml) String.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          show_node_group_config =
            (Util.option_bind (Xml.member "ShowNodeGroupConfig" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
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
               [Util.option_map v.snapshot_name
                  (fun f ->
                     Ezxmlm.make_tag "SnapshotName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.snapshot_source
                 (fun f ->
                    Ezxmlm.make_tag "SnapshotSource" ([], (String.to_xml f)))])
             @
             [Util.option_map v.marker
                (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.show_node_group_config
              (fun f ->
                 Ezxmlm.make_tag "ShowNodeGroupConfig"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.show_node_group_config
              (fun f -> ("show_node_group_config", (Boolean.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.snapshot_source
             (fun f -> ("snapshot_source", (String.to_json f)));
           Util.option_map v.snapshot_name
             (fun f -> ("snapshot_name", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let of_json j =
      {
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        cache_cluster_id =
          (Util.option_map (Json.lookup j "cache_cluster_id") String.of_json);
        snapshot_name =
          (Util.option_map (Json.lookup j "snapshot_name") String.of_json);
        snapshot_source =
          (Util.option_map (Json.lookup j "snapshot_source") String.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        show_node_group_config =
          (Util.option_map (Json.lookup j "show_node_group_config")
             Boolean.of_json)
      }
  end
module DescribeUpdateActionsMessage =
  struct
    type t =
      {
      service_update_name: String.t option ;
      replication_group_ids: ReplicationGroupIdList.t ;
      cache_cluster_ids: CacheClusterIdList.t ;
      engine: String.t option ;
      service_update_status: ServiceUpdateStatusList.t ;
      service_update_time_range: TimeRangeFilter.t option ;
      update_action_status: UpdateActionStatusList.t ;
      show_node_level_update_status: Boolean.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?service_update_name  ?(replication_group_ids= []) 
      ?(cache_cluster_ids= [])  ?engine  ?(service_update_status= []) 
      ?service_update_time_range  ?(update_action_status= []) 
      ?show_node_level_update_status  ?max_records  ?marker  () =
      {
        service_update_name;
        replication_group_ids;
        cache_cluster_ids;
        engine;
        service_update_status;
        service_update_time_range;
        update_action_status;
        show_node_level_update_status;
        max_records;
        marker
      }
    let parse xml =
      Some
        {
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          replication_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicationGroupIds" xml)
                  ReplicationGroupIdList.parse));
          cache_cluster_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheClusterIds" xml)
                  CacheClusterIdList.parse));
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          service_update_status =
            (Util.of_option []
               (Util.option_bind (Xml.member "ServiceUpdateStatus" xml)
                  ServiceUpdateStatusList.parse));
          service_update_time_range =
            (Util.option_bind (Xml.member "ServiceUpdateTimeRange" xml)
               TimeRangeFilter.parse);
          update_action_status =
            (Util.of_option []
               (Util.option_bind (Xml.member "UpdateActionStatus" xml)
                  UpdateActionStatusList.parse));
          show_node_level_update_status =
            (Util.option_bind (Xml.member "ShowNodeLevelUpdateStatus" xml)
               Boolean.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.service_update_name
                       (fun f ->
                          Ezxmlm.make_tag "ServiceUpdateName"
                            ([], (String.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "ReplicationGroupIds"
                              ([], (ReplicationGroupIdList.to_xml [x]))))
                      v.replication_group_ids))
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "CacheClusterIds"
                             ([], (CacheClusterIdList.to_xml [x]))))
                     v.cache_cluster_ids))
                 @
                 [Util.option_map v.engine
                    (fun f ->
                       Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "ServiceUpdateStatus"
                           ([], (ServiceUpdateStatusList.to_xml [x]))))
                   v.service_update_status))
               @
               [Util.option_map v.service_update_time_range
                  (fun f ->
                     Ezxmlm.make_tag "ServiceUpdateTimeRange"
                       ([], (TimeRangeFilter.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "UpdateActionStatus"
                         ([], (UpdateActionStatusList.to_xml [x]))))
                 v.update_action_status))
             @
             [Util.option_map v.show_node_level_update_status
                (fun f ->
                   Ezxmlm.make_tag "ShowNodeLevelUpdateStatus"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.show_node_level_update_status
             (fun f -> ("show_node_level_update_status", (Boolean.to_json f)));
           Some
             ("update_action_status",
               (UpdateActionStatusList.to_json v.update_action_status));
           Util.option_map v.service_update_time_range
             (fun f ->
                ("service_update_time_range", (TimeRangeFilter.to_json f)));
           Some
             ("service_update_status",
               (ServiceUpdateStatusList.to_json v.service_update_status));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Some
             ("cache_cluster_ids",
               (CacheClusterIdList.to_json v.cache_cluster_ids));
           Some
             ("replication_group_ids",
               (ReplicationGroupIdList.to_json v.replication_group_ids));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)))])
    let of_json j =
      {
        service_update_name =
          (Util.option_map (Json.lookup j "service_update_name")
             String.of_json);
        replication_group_ids =
          (ReplicationGroupIdList.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_ids")));
        cache_cluster_ids =
          (CacheClusterIdList.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_ids")));
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        service_update_status =
          (ServiceUpdateStatusList.of_json
             (Util.of_option_exn (Json.lookup j "service_update_status")));
        service_update_time_range =
          (Util.option_map (Json.lookup j "service_update_time_range")
             TimeRangeFilter.of_json);
        update_action_status =
          (UpdateActionStatusList.of_json
             (Util.of_option_exn (Json.lookup j "update_action_status")));
        show_node_level_update_status =
          (Util.option_map (Json.lookup j "show_node_level_update_status")
             Boolean.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module DescribeCacheSubnetGroupsMessage =
  struct
    type t =
      {
      cache_subnet_group_name: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?cache_subnet_group_name  ?max_records  ?marker  () =
      { cache_subnet_group_name; max_records; marker }
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cache_subnet_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheSubnetGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_subnet_group_name
             (fun f -> ("cache_subnet_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_subnet_group_name =
          (Util.option_map (Json.lookup j "cache_subnet_group_name")
             String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module UpdateActionsMessage =
  struct
    type t = {
      marker: String.t option ;
      update_actions: UpdateActionList.t }
    let make ?marker  ?(update_actions= [])  () = { marker; update_actions }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          update_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "UpdateActions" xml)
                  UpdateActionList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("update_actions", (UpdateActionList.to_json v.update_actions));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        update_actions =
          (UpdateActionList.of_json
             (Util.of_option_exn (Json.lookup j "update_actions")))
      }
  end
module DeleteCacheSecurityGroupMessage =
  struct
    type t = {
      cache_security_group_name: String.t }
    let make ~cache_security_group_name  () = { cache_security_group_name }
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Xml.required "CacheSecurityGroupName"
               (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "CacheSecurityGroupName"
                 ([], (String.to_xml v.cache_security_group_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_security_group_name",
                (String.to_json v.cache_security_group_name))])
    let of_json j =
      {
        cache_security_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_name")))
      }
  end
module EventsMessage =
  struct
    type t = {
      marker: String.t option ;
      events: EventList.t }
    let make ?marker  ?(events= [])  () = { marker; events }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          events =
            (Util.of_option []
               (Util.option_bind (Xml.member "Events" xml) EventList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("events", (EventList.to_json v.events));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")))
      }
  end
module AllowedNodeTypeModificationsMessage =
  struct
    type t =
      {
      scale_up_modifications: NodeTypeList.t ;
      scale_down_modifications: NodeTypeList.t }
    let make ?(scale_up_modifications= [])  ?(scale_down_modifications= []) 
      () = { scale_up_modifications; scale_down_modifications }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("scale_down_modifications",
                (NodeTypeList.to_json v.scale_down_modifications));
           Some
             ("scale_up_modifications",
               (NodeTypeList.to_json v.scale_up_modifications))])
    let of_json j =
      {
        scale_up_modifications =
          (NodeTypeList.of_json
             (Util.of_option_exn (Json.lookup j "scale_up_modifications")));
        scale_down_modifications =
          (NodeTypeList.of_json
             (Util.of_option_exn (Json.lookup j "scale_down_modifications")))
      }
  end
module CopySnapshotMessage =
  struct
    type t =
      {
      source_snapshot_name: String.t ;
      target_snapshot_name: String.t ;
      target_bucket: String.t option ;
      kms_key_id: String.t option }
    let make ~source_snapshot_name  ~target_snapshot_name  ?target_bucket 
      ?kms_key_id  () =
      { source_snapshot_name; target_snapshot_name; target_bucket; kms_key_id
      }
    let parse xml =
      Some
        {
          source_snapshot_name =
            (Xml.required "SourceSnapshotName"
               (Util.option_bind (Xml.member "SourceSnapshotName" xml)
                  String.parse));
          target_snapshot_name =
            (Xml.required "TargetSnapshotName"
               (Util.option_bind (Xml.member "TargetSnapshotName" xml)
                  String.parse));
          target_bucket =
            (Util.option_bind (Xml.member "TargetBucket" xml) String.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "SourceSnapshotName"
                    ([], (String.to_xml v.source_snapshot_name)))])
             @
             [Some
                (Ezxmlm.make_tag "TargetSnapshotName"
                   ([], (String.to_xml v.target_snapshot_name)))])
            @
            [Util.option_map v.target_bucket
               (fun f ->
                  Ezxmlm.make_tag "TargetBucket" ([], (String.to_xml f)))])
           @
           [Util.option_map v.kms_key_id
              (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.kms_key_id
              (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.target_bucket
             (fun f -> ("target_bucket", (String.to_json f)));
           Some
             ("target_snapshot_name",
               (String.to_json v.target_snapshot_name));
           Some
             ("source_snapshot_name",
               (String.to_json v.source_snapshot_name))])
    let of_json j =
      {
        source_snapshot_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "source_snapshot_name")));
        target_snapshot_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "target_snapshot_name")));
        target_bucket =
          (Util.option_map (Json.lookup j "target_bucket") String.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json)
      }
  end
module CreateSnapshotResult =
  struct
    type t = {
      snapshot: Snapshot.t option }
    let make ?snapshot  () = { snapshot }
    let parse xml =
      Some
        {
          snapshot =
            (Util.option_bind (Xml.member "Snapshot" xml) Snapshot.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.snapshot
              (fun f -> Ezxmlm.make_tag "Snapshot" ([], (Snapshot.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.snapshot
              (fun f -> ("snapshot", (Snapshot.to_json f)))])
    let of_json j =
      {
        snapshot =
          (Util.option_map (Json.lookup j "snapshot") Snapshot.of_json)
      }
  end
module ReplicationGroupAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t ;
      replication_group_id: String.t option ;
      a_z_mode: AZMode.t option ;
      preferred_availability_zone: String.t option ;
      preferred_availability_zones: PreferredAvailabilityZoneList.t ;
      num_cache_nodes: Integer.t option ;
      cache_node_type: String.t option ;
      engine: String.t option ;
      engine_version: String.t option ;
      cache_parameter_group_name: String.t option ;
      cache_subnet_group_name: String.t option ;
      cache_security_group_names: CacheSecurityGroupNameList.t ;
      security_group_ids: SecurityGroupIdsList.t ;
      tags: TagList.t ;
      snapshot_arns: SnapshotArnsList.t ;
      snapshot_name: String.t option ;
      preferred_maintenance_window: String.t option ;
      port: Integer.t option ;
      notification_topic_arn: String.t option ;
      auto_minor_version_upgrade: Boolean.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      auth_token: String.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_cluster_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_id")));
        replication_group_id =
          (Util.option_map (Json.lookup j "replication_group_id")
             String.of_json);
        a_z_mode =
          (Util.option_map (Json.lookup j "a_z_mode") AZMode.of_json);
        preferred_availability_zone =
          (Util.option_map (Json.lookup j "preferred_availability_zone")
             String.of_json);
        preferred_availability_zones =
          (PreferredAvailabilityZoneList.of_json
             (Util.of_option_exn
                (Json.lookup j "preferred_availability_zones")));
        num_cache_nodes =
          (Util.option_map (Json.lookup j "num_cache_nodes") Integer.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        cache_subnet_group_name =
          (Util.option_map (Json.lookup j "cache_subnet_group_name")
             String.of_json);
        cache_security_group_names =
          (CacheSecurityGroupNameList.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_names")));
        security_group_ids =
          (SecurityGroupIdsList.of_json
             (Util.of_option_exn (Json.lookup j "security_group_ids")));
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")));
        snapshot_arns =
          (SnapshotArnsList.of_json
             (Util.of_option_exn (Json.lookup j "snapshot_arns")));
        snapshot_name =
          (Util.option_map (Json.lookup j "snapshot_name") String.of_json);
        preferred_maintenance_window =
          (Util.option_map (Json.lookup j "preferred_maintenance_window")
             String.of_json);
        port = (Util.option_map (Json.lookup j "port") Integer.of_json);
        notification_topic_arn =
          (Util.option_map (Json.lookup j "notification_topic_arn")
             String.of_json);
        auto_minor_version_upgrade =
          (Util.option_map (Json.lookup j "auto_minor_version_upgrade")
             Boolean.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        auth_token =
          (Util.option_map (Json.lookup j "auth_token") String.of_json)
      }
  end
module NodeQuotaForClusterExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeCacheEngineVersionsMessage =
  struct
    type t =
      {
      engine: String.t option ;
      engine_version: String.t option ;
      cache_parameter_group_family: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option ;
      default_only: Boolean.t option }
    let make ?engine  ?engine_version  ?cache_parameter_group_family 
      ?max_records  ?marker  ?default_only  () =
      {
        engine;
        engine_version;
        cache_parameter_group_family;
        max_records;
        marker;
        default_only
      }
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          cache_parameter_group_family =
            (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          default_only =
            (Util.option_bind (Xml.member "DefaultOnly" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
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
             [Util.option_map v.max_records
                (fun f ->
                   Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           [Util.option_map v.default_only
              (fun f ->
                 Ezxmlm.make_tag "DefaultOnly" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_only
              (fun f -> ("default_only", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_parameter_group_family
             (fun f -> ("cache_parameter_group_family", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let of_json j =
      {
        engine = (Util.option_map (Json.lookup j "engine") String.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        cache_parameter_group_family =
          (Util.option_map (Json.lookup j "cache_parameter_group_family")
             String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        default_only =
          (Util.option_map (Json.lookup j "default_only") Boolean.of_json)
      }
  end
module ModifyCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let of_json j =
      {
        cache_cluster =
          (Util.option_map (Json.lookup j "cache_cluster")
             CacheCluster.of_json)
      }
  end
module CacheSubnetGroupInUse =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module UpdateActionResultsMessage =
  struct
    type t =
      {
      processed_update_actions: ProcessedUpdateActionList.t ;
      unprocessed_update_actions: UnprocessedUpdateActionList.t }
    let make ?(processed_update_actions= [])  ?(unprocessed_update_actions=
      [])  () = { processed_update_actions; unprocessed_update_actions }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        processed_update_actions =
          (ProcessedUpdateActionList.of_json
             (Util.of_option_exn (Json.lookup j "processed_update_actions")));
        unprocessed_update_actions =
          (UnprocessedUpdateActionList.of_json
             (Util.of_option_exn (Json.lookup j "unprocessed_update_actions")))
      }
  end
module RemoveTagsFromResourceMessage =
  struct
    type t = {
      resource_name: String.t ;
      tag_keys: KeyList.t }
    let make ~resource_name  ~tag_keys  () = { resource_name; tag_keys }
    let parse xml =
      Some
        {
          resource_name =
            (Xml.required "ResourceName"
               (Util.option_bind (Xml.member "ResourceName" xml) String.parse));
          tag_keys =
            (Xml.required "TagKeys"
               (Util.option_bind (Xml.member "TagKeys" xml) KeyList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ResourceName"
                  ([], (String.to_xml v.resource_name)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagKeys" ([], (KeyList.to_xml [x]))))
              v.tag_keys))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_keys", (KeyList.to_json v.tag_keys));
           Some ("resource_name", (String.to_json v.resource_name))])
    let of_json j =
      {
        resource_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "resource_name")));
        tag_keys =
          (KeyList.of_json (Util.of_option_exn (Json.lookup j "tag_keys")))
      }
  end
module ReplicationGroupMessage =
  struct
    type t =
      {
      marker: String.t option ;
      replication_groups: ReplicationGroupList.t }
    let make ?marker  ?(replication_groups= [])  () =
      { marker; replication_groups }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          replication_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicationGroups" xml)
                  ReplicationGroupList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("replication_groups",
                (ReplicationGroupList.to_json v.replication_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        replication_groups =
          (ReplicationGroupList.of_json
             (Util.of_option_exn (Json.lookup j "replication_groups")))
      }
  end
module DescribeCacheParametersMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t ;
      source: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ~cache_parameter_group_name  ?source  ?max_records  ?marker  ()
      = { cache_parameter_group_name; source; max_records; marker }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Xml.required "CacheParameterGroupName"
               (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
                  String.parse));
          source = (Util.option_bind (Xml.member "Source" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "CacheParameterGroupName"
                    ([], (String.to_xml v.cache_parameter_group_name)))])
             @
             [Util.option_map v.source
                (fun f -> Ezxmlm.make_tag "Source" ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Some
             ("cache_parameter_group_name",
               (String.to_json v.cache_parameter_group_name))])
    let of_json j =
      {
        cache_parameter_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_parameter_group_name")));
        source = (Util.option_map (Json.lookup j "source") String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module CacheParameterGroupDetails =
  struct
    type t =
      {
      marker: String.t option ;
      parameters: ParametersList.t ;
      cache_node_type_specific_parameters:
        CacheNodeTypeSpecificParametersList.t }
    let make ?marker  ?(parameters= []) 
      ?(cache_node_type_specific_parameters= [])  () =
      { marker; parameters; cache_node_type_specific_parameters }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_node_type_specific_parameters",
                (CacheNodeTypeSpecificParametersList.to_json
                   v.cache_node_type_specific_parameters));
           Some ("parameters", (ParametersList.to_json v.parameters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        parameters =
          (ParametersList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        cache_node_type_specific_parameters =
          (CacheNodeTypeSpecificParametersList.of_json
             (Util.of_option_exn
                (Json.lookup j "cache_node_type_specific_parameters")))
      }
  end
module CacheSubnetGroupQuotaExceededFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheClusterAlreadyExistsFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ModifyReplicationGroupMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      replication_group_description: String.t option ;
      primary_cluster_id: String.t option ;
      snapshotting_cluster_id: String.t option ;
      automatic_failover_enabled: Boolean.t option ;
      node_group_id: String.t option ;
      cache_security_group_names: CacheSecurityGroupNameList.t ;
      security_group_ids: SecurityGroupIdsList.t ;
      preferred_maintenance_window: String.t option ;
      notification_topic_arn: String.t option ;
      cache_parameter_group_name: String.t option ;
      notification_topic_status: String.t option ;
      apply_immediately: Boolean.t option ;
      engine_version: String.t option ;
      auto_minor_version_upgrade: Boolean.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      cache_node_type: String.t option ;
      auth_token: String.t option ;
      auth_token_update_strategy: AuthTokenUpdateStrategyType.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        replication_group_description =
          (Util.option_map (Json.lookup j "replication_group_description")
             String.of_json);
        primary_cluster_id =
          (Util.option_map (Json.lookup j "primary_cluster_id")
             String.of_json);
        snapshotting_cluster_id =
          (Util.option_map (Json.lookup j "snapshotting_cluster_id")
             String.of_json);
        automatic_failover_enabled =
          (Util.option_map (Json.lookup j "automatic_failover_enabled")
             Boolean.of_json);
        node_group_id =
          (Util.option_map (Json.lookup j "node_group_id") String.of_json);
        cache_security_group_names =
          (CacheSecurityGroupNameList.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_names")));
        security_group_ids =
          (SecurityGroupIdsList.of_json
             (Util.of_option_exn (Json.lookup j "security_group_ids")));
        preferred_maintenance_window =
          (Util.option_map (Json.lookup j "preferred_maintenance_window")
             String.of_json);
        notification_topic_arn =
          (Util.option_map (Json.lookup j "notification_topic_arn")
             String.of_json);
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        notification_topic_status =
          (Util.option_map (Json.lookup j "notification_topic_status")
             String.of_json);
        apply_immediately =
          (Util.option_map (Json.lookup j "apply_immediately")
             Boolean.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        auto_minor_version_upgrade =
          (Util.option_map (Json.lookup j "auto_minor_version_upgrade")
             Boolean.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        auth_token =
          (Util.option_map (Json.lookup j "auth_token") String.of_json);
        auth_token_update_strategy =
          (Util.option_map (Json.lookup j "auth_token_update_strategy")
             AuthTokenUpdateStrategyType.of_json)
      }
  end
module CreateCacheParameterGroupMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t ;
      cache_parameter_group_family: String.t ;
      description: String.t }
    let make ~cache_parameter_group_name  ~cache_parameter_group_family 
      ~description  () =
      { cache_parameter_group_name; cache_parameter_group_family; description
      }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Xml.required "CacheParameterGroupName"
               (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
                  String.parse));
          cache_parameter_group_family =
            (Xml.required "CacheParameterGroupFamily"
               (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
                  String.parse));
          description =
            (Xml.required "Description"
               (Util.option_bind (Xml.member "Description" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheParameterGroupName"
                   ([], (String.to_xml v.cache_parameter_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "CacheParameterGroupFamily"
                  ([], (String.to_xml v.cache_parameter_group_family)))])
           @
           [Some
              (Ezxmlm.make_tag "Description"
                 ([], (String.to_xml v.description)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("description", (String.to_json v.description));
           Some
             ("cache_parameter_group_family",
               (String.to_json v.cache_parameter_group_family));
           Some
             ("cache_parameter_group_name",
               (String.to_json v.cache_parameter_group_name))])
    let of_json j =
      {
        cache_parameter_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_parameter_group_name")));
        cache_parameter_group_family =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "cache_parameter_group_family")));
        description =
          (String.of_json (Util.of_option_exn (Json.lookup j "description")))
      }
  end
module TestFailoverResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module InvalidCacheSecurityGroupStateFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CacheEngineVersionMessage =
  struct
    type t =
      {
      marker: String.t option ;
      cache_engine_versions: CacheEngineVersionList.t }
    let make ?marker  ?(cache_engine_versions= [])  () =
      { marker; cache_engine_versions }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_engine_versions =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheEngineVersions" xml)
                  CacheEngineVersionList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_engine_versions",
                (CacheEngineVersionList.to_json v.cache_engine_versions));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        cache_engine_versions =
          (CacheEngineVersionList.of_json
             (Util.of_option_exn (Json.lookup j "cache_engine_versions")))
      }
  end
module PurchaseReservedCacheNodesOfferingResult =
  struct
    type t = {
      reserved_cache_node: ReservedCacheNode.t option }
    let make ?reserved_cache_node  () = { reserved_cache_node }
    let parse xml =
      Some
        {
          reserved_cache_node =
            (Util.option_bind (Xml.member "ReservedCacheNode" xml)
               ReservedCacheNode.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.reserved_cache_node
              (fun f ->
                 Ezxmlm.make_tag "ReservedCacheNode"
                   ([], (ReservedCacheNode.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reserved_cache_node
              (fun f ->
                 ("reserved_cache_node", (ReservedCacheNode.to_json f)))])
    let of_json j =
      {
        reserved_cache_node =
          (Util.option_map (Json.lookup j "reserved_cache_node")
             ReservedCacheNode.of_json)
      }
  end
module ModifyReplicationGroupResult =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module CacheSecurityGroupMessage =
  struct
    type t =
      {
      marker: String.t option ;
      cache_security_groups: CacheSecurityGroups.t }
    let make ?marker  ?(cache_security_groups= [])  () =
      { marker; cache_security_groups }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          cache_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "CacheSecurityGroups" xml)
                  CacheSecurityGroups.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_security_groups",
                (CacheSecurityGroups.to_json v.cache_security_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        cache_security_groups =
          (CacheSecurityGroups.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_groups")))
      }
  end
module InvalidSnapshotStateFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ListTagsForResourceMessage =
  struct
    type t = {
      resource_name: String.t }
    let make ~resource_name  () = { resource_name }
    let parse xml =
      Some
        {
          resource_name =
            (Xml.required "ResourceName"
               (Util.option_bind (Xml.member "ResourceName" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "ResourceName"
                 ([], (String.to_xml v.resource_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("resource_name", (String.to_json v.resource_name))])
    let of_json j =
      {
        resource_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "resource_name")))
      }
  end
module DeleteCacheSubnetGroupMessage =
  struct
    type t = {
      cache_subnet_group_name: String.t }
    let make ~cache_subnet_group_name  () = { cache_subnet_group_name }
    let parse xml =
      Some
        {
          cache_subnet_group_name =
            (Xml.required "CacheSubnetGroupName"
               (Util.option_bind (Xml.member "CacheSubnetGroupName" xml)
                  String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "CacheSubnetGroupName"
                 ([], (String.to_xml v.cache_subnet_group_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_subnet_group_name",
                (String.to_json v.cache_subnet_group_name))])
    let of_json j =
      {
        cache_subnet_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_subnet_group_name")))
      }
  end
module DescribeEngineDefaultParametersMessage =
  struct
    type t =
      {
      cache_parameter_group_family: String.t ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ~cache_parameter_group_family  ?max_records  ?marker  () =
      { cache_parameter_group_family; max_records; marker }
    let parse xml =
      Some
        {
          cache_parameter_group_family =
            (Xml.required "CacheParameterGroupFamily"
               (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
                  String.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheParameterGroupFamily"
                   ([], (String.to_xml v.cache_parameter_group_family)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some
             ("cache_parameter_group_family",
               (String.to_json v.cache_parameter_group_family))])
    let of_json j =
      {
        cache_parameter_group_family =
          (String.of_json
             (Util.of_option_exn
                (Json.lookup j "cache_parameter_group_family")));
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module RebootCacheClusterResult =
  struct
    type t = {
      cache_cluster: CacheCluster.t option }
    let make ?cache_cluster  () = { cache_cluster }
    let parse xml =
      Some
        {
          cache_cluster =
            (Util.option_bind (Xml.member "CacheCluster" xml)
               CacheCluster.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_cluster
              (fun f ->
                 Ezxmlm.make_tag "CacheCluster" ([], (CacheCluster.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_cluster
              (fun f -> ("cache_cluster", (CacheCluster.to_json f)))])
    let of_json j =
      {
        cache_cluster =
          (Util.option_map (Json.lookup j "cache_cluster")
             CacheCluster.of_json)
      }
  end
module StartMigrationResponse =
  struct
    type t = {
      replication_group: ReplicationGroup.t option }
    let make ?replication_group  () = { replication_group }
    let parse xml =
      Some
        {
          replication_group =
            (Util.option_bind (Xml.member "ReplicationGroup" xml)
               ReplicationGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_group
              (fun f ->
                 Ezxmlm.make_tag "ReplicationGroup"
                   ([], (ReplicationGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group
              (fun f -> ("replication_group", (ReplicationGroup.to_json f)))])
    let of_json j =
      {
        replication_group =
          (Util.option_map (Json.lookup j "replication_group")
             ReplicationGroup.of_json)
      }
  end
module DeleteSnapshotMessage =
  struct
    type t = {
      snapshot_name: String.t }
    let make ~snapshot_name  () = { snapshot_name }
    let parse xml =
      Some
        {
          snapshot_name =
            (Xml.required "SnapshotName"
               (Util.option_bind (Xml.member "SnapshotName" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "SnapshotName"
                 ([], (String.to_xml v.snapshot_name)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("snapshot_name", (String.to_json v.snapshot_name))])
    let of_json j =
      {
        snapshot_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "snapshot_name")))
      }
  end
module IncreaseReplicaCountMessage =
  struct
    type t =
      {
      replication_group_id: String.t ;
      new_replica_count: Integer.t option ;
      replica_configuration: ReplicaConfigurationList.t ;
      apply_immediately: Boolean.t }
    let make ~replication_group_id  ?new_replica_count 
      ?(replica_configuration= [])  ~apply_immediately  () =
      {
        replication_group_id;
        new_replica_count;
        replica_configuration;
        apply_immediately
      }
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          new_replica_count =
            (Util.option_bind (Xml.member "NewReplicaCount" xml)
               Integer.parse);
          replica_configuration =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicaConfiguration" xml)
                  ReplicaConfigurationList.parse));
          apply_immediately =
            (Xml.required "ApplyImmediately"
               (Util.option_bind (Xml.member "ApplyImmediately" xml)
                  Boolean.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "ReplicationGroupId"
                    ([], (String.to_xml v.replication_group_id)))])
             @
             [Util.option_map v.new_replica_count
                (fun f ->
                   Ezxmlm.make_tag "NewReplicaCount" ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ReplicaConfiguration"
                       ([], (ReplicaConfigurationList.to_xml [x]))))
               v.replica_configuration))
           @
           [Some
              (Ezxmlm.make_tag "ApplyImmediately"
                 ([], (Boolean.to_xml v.apply_immediately)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("apply_immediately", (Boolean.to_json v.apply_immediately));
           Some
             ("replica_configuration",
               (ReplicaConfigurationList.to_json v.replica_configuration));
           Util.option_map v.new_replica_count
             (fun f -> ("new_replica_count", (Integer.to_json f)));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let of_json j =
      {
        replication_group_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "replication_group_id")));
        new_replica_count =
          (Util.option_map (Json.lookup j "new_replica_count")
             Integer.of_json);
        replica_configuration =
          (ReplicaConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "replica_configuration")));
        apply_immediately =
          (Boolean.of_json
             (Util.of_option_exn (Json.lookup j "apply_immediately")))
      }
  end
module ModifyCacheParameterGroupMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t ;
      parameter_name_values: ParameterNameValueList.t }
    let make ~cache_parameter_group_name  ~parameter_name_values  () =
      { cache_parameter_group_name; parameter_name_values }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Xml.required "CacheParameterGroupName"
               (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
                  String.parse));
          parameter_name_values =
            (Xml.required "ParameterNameValues"
               (Util.option_bind (Xml.member "ParameterNameValues" xml)
                  ParameterNameValueList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CacheParameterGroupName"
                  ([], (String.to_xml v.cache_parameter_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ParameterNameValues"
                      ([], (ParameterNameValueList.to_xml [x]))))
              v.parameter_name_values))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("parameter_name_values",
                (ParameterNameValueList.to_json v.parameter_name_values));
           Some
             ("cache_parameter_group_name",
               (String.to_json v.cache_parameter_group_name))])
    let of_json j =
      {
        cache_parameter_group_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_parameter_group_name")));
        parameter_name_values =
          (ParameterNameValueList.of_json
             (Util.of_option_exn (Json.lookup j "parameter_name_values")))
      }
  end
module CreateCacheSubnetGroupResult =
  struct
    type t = {
      cache_subnet_group: CacheSubnetGroup.t option }
    let make ?cache_subnet_group  () = { cache_subnet_group }
    let parse xml =
      Some
        {
          cache_subnet_group =
            (Util.option_bind (Xml.member "CacheSubnetGroup" xml)
               CacheSubnetGroup.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_subnet_group
              (fun f ->
                 Ezxmlm.make_tag "CacheSubnetGroup"
                   ([], (CacheSubnetGroup.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_subnet_group
              (fun f -> ("cache_subnet_group", (CacheSubnetGroup.to_json f)))])
    let of_json j =
      {
        cache_subnet_group =
          (Util.option_map (Json.lookup j "cache_subnet_group")
             CacheSubnetGroup.of_json)
      }
  end
module ModifyCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t ;
      num_cache_nodes: Integer.t option ;
      cache_node_ids_to_remove: CacheNodeIdsList.t ;
      a_z_mode: AZMode.t option ;
      new_availability_zones: PreferredAvailabilityZoneList.t ;
      cache_security_group_names: CacheSecurityGroupNameList.t ;
      security_group_ids: SecurityGroupIdsList.t ;
      preferred_maintenance_window: String.t option ;
      notification_topic_arn: String.t option ;
      cache_parameter_group_name: String.t option ;
      notification_topic_status: String.t option ;
      apply_immediately: Boolean.t option ;
      engine_version: String.t option ;
      auto_minor_version_upgrade: Boolean.t option ;
      snapshot_retention_limit: Integer.t option ;
      snapshot_window: String.t option ;
      cache_node_type: String.t option ;
      auth_token: String.t option ;
      auth_token_update_strategy: AuthTokenUpdateStrategyType.t option }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let of_json j =
      {
        cache_cluster_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "cache_cluster_id")));
        num_cache_nodes =
          (Util.option_map (Json.lookup j "num_cache_nodes") Integer.of_json);
        cache_node_ids_to_remove =
          (CacheNodeIdsList.of_json
             (Util.of_option_exn (Json.lookup j "cache_node_ids_to_remove")));
        a_z_mode =
          (Util.option_map (Json.lookup j "a_z_mode") AZMode.of_json);
        new_availability_zones =
          (PreferredAvailabilityZoneList.of_json
             (Util.of_option_exn (Json.lookup j "new_availability_zones")));
        cache_security_group_names =
          (CacheSecurityGroupNameList.of_json
             (Util.of_option_exn (Json.lookup j "cache_security_group_names")));
        security_group_ids =
          (SecurityGroupIdsList.of_json
             (Util.of_option_exn (Json.lookup j "security_group_ids")));
        preferred_maintenance_window =
          (Util.option_map (Json.lookup j "preferred_maintenance_window")
             String.of_json);
        notification_topic_arn =
          (Util.option_map (Json.lookup j "notification_topic_arn")
             String.of_json);
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        notification_topic_status =
          (Util.option_map (Json.lookup j "notification_topic_status")
             String.of_json);
        apply_immediately =
          (Util.option_map (Json.lookup j "apply_immediately")
             Boolean.of_json);
        engine_version =
          (Util.option_map (Json.lookup j "engine_version") String.of_json);
        auto_minor_version_upgrade =
          (Util.option_map (Json.lookup j "auto_minor_version_upgrade")
             Boolean.of_json);
        snapshot_retention_limit =
          (Util.option_map (Json.lookup j "snapshot_retention_limit")
             Integer.of_json);
        snapshot_window =
          (Util.option_map (Json.lookup j "snapshot_window") String.of_json);
        cache_node_type =
          (Util.option_map (Json.lookup j "cache_node_type") String.of_json);
        auth_token =
          (Util.option_map (Json.lookup j "auth_token") String.of_json);
        auth_token_update_strategy =
          (Util.option_map (Json.lookup j "auth_token_update_strategy")
             AuthTokenUpdateStrategyType.of_json)
      }
  end
module CacheParameterGroupNameMessage =
  struct
    type t = {
      cache_parameter_group_name: String.t option }
    let make ?cache_parameter_group_name  () = { cache_parameter_group_name }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.cache_parameter_group_name
              (fun f ->
                 Ezxmlm.make_tag "CacheParameterGroupName"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cache_parameter_group_name
              (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json)
      }
  end
module DescribeCacheParameterGroupsMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option ;
      max_records: Integer.t option ;
      marker: String.t option }
    let make ?cache_parameter_group_name  ?max_records  ?marker  () =
      { cache_parameter_group_name; max_records; marker }
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cache_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let of_json j =
      {
        cache_parameter_group_name =
          (Util.option_map (Json.lookup j "cache_parameter_group_name")
             String.of_json);
        max_records =
          (Util.option_map (Json.lookup j "max_records") Integer.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json)
      }
  end
module ReservedCacheNodeMessage =
  struct
    type t =
      {
      marker: String.t option ;
      reserved_cache_nodes: ReservedCacheNodeList.t }
    let make ?marker  ?(reserved_cache_nodes= [])  () =
      { marker; reserved_cache_nodes }
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          reserved_cache_nodes =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReservedCacheNodes" xml)
                  ReservedCacheNodeList.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_cache_nodes",
                (ReservedCacheNodeList.to_json v.reserved_cache_nodes));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let of_json j =
      {
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        reserved_cache_nodes =
          (ReservedCacheNodeList.of_json
             (Util.of_option_exn (Json.lookup j "reserved_cache_nodes")))
      }
  end
module NoOperationFault =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end