open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t
        [@ocaml.doc
          "<p>The cluster identifier for the cluster to be deleted. This parameter is not case sensitive.</p>"];
      final_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>The user-supplied name of a final cluster snapshot. This is the unique name that identifies the snapshot. ElastiCache creates the snapshot, and then deletes the cluster immediately afterward.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DeleteCacheCluster</code> operation.</p>"]
    let make ~cache_cluster_id  ?final_snapshot_identifier  () =
      { cache_cluster_id; final_snapshot_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.final_snapshot_identifier
              (fun f -> ("final_snapshot_identifier", (String.to_json f)));
           Some ("cache_cluster_id", (String.to_json v.cache_cluster_id))])
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DeleteCacheCluster</code> operation.</p>"]
module DeleteCacheClusterResult = DeleteCacheClusterResult
type input = DeleteCacheClusterMessage.t
type output = DeleteCacheClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DeleteCacheCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteCacheClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteCacheClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteCacheClusterResponse" (snd xml))
        (Xml.member "DeleteCacheClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteCacheClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteCacheClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteCacheClusterResult - missing field in body or children: "
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