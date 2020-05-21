open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSnapshotsMessage =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>A user-supplied replication group identifier. If this parameter is specified, only snapshots associated with that specific replication group are described.</p>"];
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>A user-supplied cluster identifier. If this parameter is specified, only snapshots associated with that specific cluster are described.</p>"];
      snapshot_name: String.t option
        [@ocaml.doc
          "<p>A user-supplied name of the snapshot. If this parameter is specified, only this snapshot are described.</p>"];
      snapshot_source: String.t option
        [@ocaml.doc
          "<p>If set to <code>system</code>, the output shows snapshots that were automatically created by ElastiCache. If set to <code>user</code> the output shows snapshots that were manually created. If omitted, the output shows both automatically and manually created snapshots.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 50</p> <p>Constraints: minimum 20; maximum 50.</p>"];
      show_node_group_config: Boolean.t option
        [@ocaml.doc
          "<p>A Boolean value which if true, the node group (shard) configuration is included in the snapshot description.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeSnapshotsMessage</code> operation.</p>"]
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeSnapshotsMessage</code> operation.</p>"]
module DescribeSnapshotsListMessage = DescribeSnapshotsListMessage
type input = DescribeSnapshotsMessage.t
type output = DescribeSnapshotsListMessage.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DescribeSnapshots"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeSnapshotsMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeSnapshotsMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeSnapshotsResponse" (snd xml))
        (Xml.member "DescribeSnapshotsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeSnapshotsListMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSnapshotsListMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSnapshotsListMessage - missing field in body or children: "
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