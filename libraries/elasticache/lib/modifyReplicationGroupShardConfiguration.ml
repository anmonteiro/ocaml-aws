open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyReplicationGroupShardConfigurationMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The name of the Redis (cluster mode enabled) cluster (replication group) on which the shards are to be configured.</p>"];
      node_group_count: Integer.t
        [@ocaml.doc
          "<p>The number of node groups (shards) that results from the modification of the shard configuration.</p>"];
      apply_immediately: Boolean.t
        [@ocaml.doc
          "<p>Indicates that the shard reconfiguration process begins immediately. At present, the only permitted value for this parameter is <code>true</code>.</p> <p>Value: true</p>"];
      resharding_configuration: ReshardingConfigurationList.t
        [@ocaml.doc
          "<p>Specifies the preferred availability zones for each node group in the cluster. If the value of <code>NodeGroupCount</code> is greater than the current number of node groups (shards), you can use this parameter to specify the preferred availability zones of the cluster's shards. If you omit this parameter ElastiCache selects availability zones for you.</p> <p>You can specify this parameter only if the value of <code>NodeGroupCount</code> is greater than the current number of node groups (shards).</p>"];
      node_groups_to_remove: NodeGroupsToRemoveList.t
        [@ocaml.doc
          "<p>If the value of <code>NodeGroupCount</code> is less than the current number of node groups (shards), then either <code>NodeGroupsToRemove</code> or <code>NodeGroupsToRetain</code> is required. <code>NodeGroupsToRemove</code> is a list of <code>NodeGroupId</code>s to remove from the cluster.</p> <p>ElastiCache for Redis will attempt to remove all node groups listed by <code>NodeGroupsToRemove</code> from the cluster.</p>"];
      node_groups_to_retain: NodeGroupsToRetainList.t
        [@ocaml.doc
          "<p>If the value of <code>NodeGroupCount</code> is less than the current number of node groups (shards), then either <code>NodeGroupsToRemove</code> or <code>NodeGroupsToRetain</code> is required. <code>NodeGroupsToRetain</code> is a list of <code>NodeGroupId</code>s to retain in the cluster.</p> <p>ElastiCache for Redis will attempt to remove all node groups except those listed by <code>NodeGroupsToRetain</code> from the cluster.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input for a <code>ModifyReplicationGroupShardConfiguration</code> operation.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Represents the input for a <code>ModifyReplicationGroupShardConfiguration</code> operation.</p>"]
module ModifyReplicationGroupShardConfigurationResult =
  ModifyReplicationGroupShardConfigurationResult
type input = ModifyReplicationGroupShardConfigurationMessage.t
type output = ModifyReplicationGroupShardConfigurationResult.t
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
         ("Action", ["ModifyReplicationGroupShardConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyReplicationGroupShardConfigurationMessage.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (ModifyReplicationGroupShardConfigurationMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyReplicationGroupShardConfigurationResponse"
           (snd xml))
        (Xml.member "ModifyReplicationGroupShardConfigurationResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyReplicationGroupShardConfigurationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyReplicationGroupShardConfigurationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyReplicationGroupShardConfigurationResult - missing field in body or children: "
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