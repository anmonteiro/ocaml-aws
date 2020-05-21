open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RebootCacheClusterMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t
        [@ocaml.doc
          "<p>The cluster identifier. This parameter is stored as a lowercase string.</p>"];
      cache_node_ids_to_reboot: CacheNodeIdsList.t
        [@ocaml.doc
          "<p>A list of cache node IDs to reboot. A node ID is a numeric identifier (0001, 0002, etc.). To reboot an entire cluster, specify all of the cache node IDs.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>RebootCacheCluster</code> operation.</p>"]
    let make ~cache_cluster_id  ~cache_node_ids_to_reboot  () =
      { cache_cluster_id; cache_node_ids_to_reboot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("cache_node_ids_to_reboot",
                (CacheNodeIdsList.to_json v.cache_node_ids_to_reboot));
           Some ("cache_cluster_id", (String.to_json v.cache_cluster_id))])
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>RebootCacheCluster</code> operation.</p>"]
module RebootCacheClusterResult = RebootCacheClusterResult
type input = RebootCacheClusterMessage.t
type output = RebootCacheClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["RebootCacheCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RebootCacheClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (RebootCacheClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "RebootCacheClusterResponse" (snd xml))
        (Xml.member "RebootCacheClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp RebootCacheClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RebootCacheClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RebootCacheClusterResult - missing field in body or children: "
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