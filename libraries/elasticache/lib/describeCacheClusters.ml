open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeCacheClustersMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>The user-supplied cluster identifier. If this parameter is specified, only information about that specific cluster is returned. This parameter isn't case sensitive.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 100</p> <p>Constraints: minimum 20; maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      show_cache_node_info: Boolean.t option
        [@ocaml.doc
          "<p>An optional flag that can be included in the <code>DescribeCacheCluster</code> request to retrieve information about the individual cache nodes.</p>"];
      show_cache_clusters_not_in_replication_groups: Boolean.t option
        [@ocaml.doc
          "<p>An optional flag that can be included in the <code>DescribeCacheCluster</code> request to show only nodes (API/CLI: clusters) that are not members of a replication group. In practice, this mean Memcached and single node Redis clusters.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeCacheClusters</code> operation.</p>"]
    let make ?cache_cluster_id  ?max_records  ?marker  ?show_cache_node_info 
      ?show_cache_clusters_not_in_replication_groups  () =
      {
        cache_cluster_id;
        max_records;
        marker;
        show_cache_node_info;
        show_cache_clusters_not_in_replication_groups
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeCacheClusters</code> operation.</p>"]
module CacheClusterMessage = CacheClusterMessage
type input = DescribeCacheClustersMessage.t
type output = CacheClusterMessage.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DescribeCacheClusters"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeCacheClustersMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeCacheClustersMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeCacheClustersResponse" (snd xml))
        (Xml.member "DescribeCacheClustersResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CacheClusterMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CacheClusterMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CacheClusterMessage - missing field in body or children: "
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