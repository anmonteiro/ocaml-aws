open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeUpdateActionsMessage =
  struct
    type t =
      {
      service_update_name: String.t option
        [@ocaml.doc "<p>The unique ID of the service update</p>"];
      replication_group_ids: ReplicationGroupIdList.t
        [@ocaml.doc "<p>The replication group IDs</p>"];
      cache_cluster_ids: CacheClusterIdList.t
        [@ocaml.doc "<p>The cache cluster IDs</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The Elasticache engine to which the update applies. Either Redis or Memcached </p>"];
      service_update_status: ServiceUpdateStatusList.t
        [@ocaml.doc "<p>The status of the service update</p>"];
      service_update_time_range: TimeRangeFilter.t option
        [@ocaml.doc
          "<p>The range of time specified to search for service updates that are in available status</p>"];
      update_action_status: UpdateActionStatusList.t
        [@ocaml.doc "<p>The status of the update action.</p>"];
      show_node_level_update_status: Boolean.t option
        [@ocaml.doc
          "<p>Dictates whether to include node level update status in the response </p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module UpdateActionsMessage = UpdateActionsMessage
type input = DescribeUpdateActionsMessage.t
type output = UpdateActionsMessage.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DescribeUpdateActions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeUpdateActionsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeUpdateActionsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeUpdateActionsResponse" (snd xml))
        (Xml.member "DescribeUpdateActionsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp UpdateActionsMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed UpdateActionsMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateActionsMessage - missing field in body or children: "
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