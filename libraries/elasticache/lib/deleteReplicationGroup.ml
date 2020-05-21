open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteReplicationGroupMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The identifier for the cluster to be deleted. This parameter is not case sensitive.</p>"];
      retain_primary_cluster: Boolean.t option
        [@ocaml.doc
          "<p>If set to <code>true</code>, all of the read replicas are deleted, but the primary node is retained.</p>"];
      final_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>The name of a final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster, rather than one of the replicas; this is to ensure that it captures the freshest data. After the final snapshot is taken, the replication group is immediately deleted.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DeleteReplicationGroup</code> operation.</p>"]
    let make ~replication_group_id  ?retain_primary_cluster 
      ?final_snapshot_identifier  () =
      {
        replication_group_id;
        retain_primary_cluster;
        final_snapshot_identifier
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DeleteReplicationGroup</code> operation.</p>"]
module DeleteReplicationGroupResult = DeleteReplicationGroupResult
type input = DeleteReplicationGroupMessage.t
type output = DeleteReplicationGroupResult.t
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
         ("Action", ["DeleteReplicationGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteReplicationGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteReplicationGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DeleteReplicationGroupResponse" (snd xml))
        (Xml.member "DeleteReplicationGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteReplicationGroupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteReplicationGroupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteReplicationGroupResult - missing field in body or children: "
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