open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module BatchApplyUpdateActionMessage =
  struct
    type t =
      {
      replication_group_ids: ReplicationGroupIdList.t
        [@ocaml.doc "<p>The replication group IDs</p>"];
      cache_cluster_ids: CacheClusterIdList.t
        [@ocaml.doc "<p>The cache cluster IDs</p>"];
      service_update_name: String.t
        [@ocaml.doc "<p>The unique ID of the service update</p>"]}
    let make ?(replication_group_ids= [])  ?(cache_cluster_ids= []) 
      ~service_update_name  () =
      { replication_group_ids; cache_cluster_ids; service_update_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end
module UpdateActionResultsMessage = UpdateActionResultsMessage
type input = BatchApplyUpdateActionMessage.t
type output = UpdateActionResultsMessage.t
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
         ("Action", ["BatchApplyUpdateAction"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (BatchApplyUpdateActionMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (BatchApplyUpdateActionMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "BatchApplyUpdateActionResponse" (snd xml))
        (Xml.member "BatchApplyUpdateActionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp UpdateActionResultsMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UpdateActionResultsMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateActionResultsMessage - missing field in body or children: "
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