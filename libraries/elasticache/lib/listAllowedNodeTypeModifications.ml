open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListAllowedNodeTypeModificationsMessage =
  struct
    type t =
      {
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>The name of the cluster you want to scale up to a larger node instanced type. ElastiCache uses the cluster id to identify the current node type of this cluster and from that to create a list of node types you can scale up to.</p> <important> <p>You must provide a value for either the <code>CacheClusterId</code> or the <code>ReplicationGroupId</code>.</p> </important>"];
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>The name of the replication group want to scale up to a larger node type. ElastiCache uses the replication group id to identify the current node type being used by this replication group, and from that to create a list of node types you can scale up to.</p> <important> <p>You must provide a value for either the <code>CacheClusterId</code> or the <code>ReplicationGroupId</code>.</p> </important>"]}
    [@@ocaml.doc
      "<p>The input parameters for the <code>ListAllowedNodeTypeModifications</code> operation.</p>"]
    let make ?cache_cluster_id  ?replication_group_id  () =
      { cache_cluster_id; replication_group_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_group_id
              (fun f -> ("replication_group_id", (String.to_json f)));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse)
        }
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
  end[@@ocaml.doc
       "<p>The input parameters for the <code>ListAllowedNodeTypeModifications</code> operation.</p>"]
module AllowedNodeTypeModificationsMessage =
  AllowedNodeTypeModificationsMessage
type input = ListAllowedNodeTypeModificationsMessage.t
type output = AllowedNodeTypeModificationsMessage.t
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
         ("Action", ["ListAllowedNodeTypeModifications"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ListAllowedNodeTypeModificationsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ListAllowedNodeTypeModificationsMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ListAllowedNodeTypeModificationsResponse" (snd xml))
        (Xml.member "ListAllowedNodeTypeModificationsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AllowedNodeTypeModificationsMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AllowedNodeTypeModificationsMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AllowedNodeTypeModificationsMessage - missing field in body or children: "
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