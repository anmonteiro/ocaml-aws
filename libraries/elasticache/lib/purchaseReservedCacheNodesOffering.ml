open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PurchaseReservedCacheNodesOfferingMessage =
  struct
    type t =
      {
      reserved_cache_nodes_offering_id: String.t
        [@ocaml.doc
          "<p>The ID of the reserved cache node offering to purchase.</p> <p>Example: <code>438012d3-4052-4cc7-b2e3-8d3372e0e706</code> </p>"];
      reserved_cache_node_id: String.t option
        [@ocaml.doc
          "<p>A customer-specified identifier to track this reservation.</p> <note> <p>The Reserved Cache Node ID is an unique customer-specified identifier to track this reservation. If this parameter is not specified, ElastiCache automatically generates an identifier for the reservation.</p> </note> <p>Example: myreservationID</p>"];
      cache_node_count: Integer.t option
        [@ocaml.doc
          "<p>The number of cache node instances to reserve.</p> <p>Default: <code>1</code> </p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>PurchaseReservedCacheNodesOffering</code> operation.</p>"]
    let make ~reserved_cache_nodes_offering_id  ?reserved_cache_node_id 
      ?cache_node_count  () =
      {
        reserved_cache_nodes_offering_id;
        reserved_cache_node_id;
        cache_node_count
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
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
  end[@@ocaml.doc
       "<p>Represents the input of a <code>PurchaseReservedCacheNodesOffering</code> operation.</p>"]
module PurchaseReservedCacheNodesOfferingResult =
  PurchaseReservedCacheNodesOfferingResult
type input = PurchaseReservedCacheNodesOfferingMessage.t
type output = PurchaseReservedCacheNodesOfferingResult.t
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
         ("Action", ["PurchaseReservedCacheNodesOffering"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (PurchaseReservedCacheNodesOfferingMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (PurchaseReservedCacheNodesOfferingMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "PurchaseReservedCacheNodesOfferingResponse" (snd xml))
        (Xml.member "PurchaseReservedCacheNodesOfferingResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             PurchaseReservedCacheNodesOfferingResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PurchaseReservedCacheNodesOfferingResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PurchaseReservedCacheNodesOfferingResult - missing field in body or children: "
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