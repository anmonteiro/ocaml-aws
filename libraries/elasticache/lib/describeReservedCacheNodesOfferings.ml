open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReservedCacheNodesOfferingsMessage =
  struct
    type t =
      {
      reserved_cache_nodes_offering_id: String.t option
        [@ocaml.doc
          "<p>The offering identifier filter value. Use this parameter to show only the available offering that matches the specified reservation identifier.</p> <p>Example: <code>438012d3-4052-4cc7-b2e3-8d3372e0e706</code> </p>"];
      cache_node_type: String.t option
        [@ocaml.doc
          "<p>The cache node type filter value. Use this parameter to show only the available offerings matching the specified cache node type.</p> <p>The following node types are supported by ElastiCache. Generally speaking, the current generation types provide more memory and computational power at lower cost when compared to their equivalent previous generation counterparts.</p> <ul> <li> <p>General purpose:</p> <ul> <li> <p>Current generation: </p> <p> <b>M5 node types:</b> <code>cache.m5.large</code>, <code>cache.m5.xlarge</code>, <code>cache.m5.2xlarge</code>, <code>cache.m5.4xlarge</code>, <code>cache.m5.12xlarge</code>, <code>cache.m5.24xlarge</code> </p> <p> <b>M4 node types:</b> <code>cache.m4.large</code>, <code>cache.m4.xlarge</code>, <code>cache.m4.2xlarge</code>, <code>cache.m4.4xlarge</code>, <code>cache.m4.10xlarge</code> </p> <p> <b>T2 node types:</b> <code>cache.t2.micro</code>, <code>cache.t2.small</code>, <code>cache.t2.medium</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>T1 node types:</b> <code>cache.t1.micro</code> </p> <p> <b>M1 node types:</b> <code>cache.m1.small</code>, <code>cache.m1.medium</code>, <code>cache.m1.large</code>, <code>cache.m1.xlarge</code> </p> <p> <b>M3 node types:</b> <code>cache.m3.medium</code>, <code>cache.m3.large</code>, <code>cache.m3.xlarge</code>, <code>cache.m3.2xlarge</code> </p> </li> </ul> </li> <li> <p>Compute optimized:</p> <ul> <li> <p>Previous generation: (not recommended)</p> <p> <b>C1 node types:</b> <code>cache.c1.xlarge</code> </p> </li> </ul> </li> <li> <p>Memory optimized:</p> <ul> <li> <p>Current generation: </p> <p> <b>R5 node types:</b> <code>cache.r5.large</code>, <code>cache.r5.xlarge</code>, <code>cache.r5.2xlarge</code>, <code>cache.r5.4xlarge</code>, <code>cache.r5.12xlarge</code>, <code>cache.r5.24xlarge</code> </p> <p> <b>R4 node types:</b> <code>cache.r4.large</code>, <code>cache.r4.xlarge</code>, <code>cache.r4.2xlarge</code>, <code>cache.r4.4xlarge</code>, <code>cache.r4.8xlarge</code>, <code>cache.r4.16xlarge</code> </p> </li> <li> <p>Previous generation: (not recommended)</p> <p> <b>M2 node types:</b> <code>cache.m2.xlarge</code>, <code>cache.m2.2xlarge</code>, <code>cache.m2.4xlarge</code> </p> <p> <b>R3 node types:</b> <code>cache.r3.large</code>, <code>cache.r3.xlarge</code>, <code>cache.r3.2xlarge</code>, <code>cache.r3.4xlarge</code>, <code>cache.r3.8xlarge</code> </p> </li> </ul> </li> </ul> <p> <b>Additional node type info</b> </p> <ul> <li> <p>All current generation instance types are created in Amazon VPC by default.</p> </li> <li> <p>Redis append-only files (AOF) are not supported for T1 or T2 instances.</p> </li> <li> <p>Redis Multi-AZ with automatic failover is not supported on T1 instances.</p> </li> <li> <p>Redis configuration variables <code>appendonly</code> and <code>appendfsync</code> are not supported on Redis version 2.8.22 and later.</p> </li> </ul>"];
      duration: String.t option
        [@ocaml.doc
          "<p>Duration filter value, specified in years or seconds. Use this parameter to show only reservations for a given duration.</p> <p>Valid Values: <code>1 | 3 | 31536000 | 94608000</code> </p>"];
      product_description: String.t option
        [@ocaml.doc
          "<p>The product description filter value. Use this parameter to show only the available offerings matching the specified product description.</p>"];
      offering_type: String.t option
        [@ocaml.doc
          "<p>The offering type filter value. Use this parameter to show only the available offerings matching the specified offering type.</p> <p>Valid Values: <code>\"Light Utilization\"|\"Medium Utilization\"|\"Heavy Utilization\"</code> </p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 100</p> <p>Constraints: minimum 20; maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeReservedCacheNodesOfferings</code> operation.</p>"]
    let make ?reserved_cache_nodes_offering_id  ?cache_node_type  ?duration 
      ?product_description  ?offering_type  ?max_records  ?marker  () =
      {
        reserved_cache_nodes_offering_id;
        cache_node_type;
        duration;
        product_description;
        offering_type;
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
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (String.to_json f)));
           Util.option_map v.cache_node_type
             (fun f -> ("cache_node_type", (String.to_json f)));
           Util.option_map v.reserved_cache_nodes_offering_id
             (fun f ->
                ("reserved_cache_nodes_offering_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          reserved_cache_nodes_offering_id =
            (Util.option_bind (Xml.member "ReservedCacheNodesOfferingId" xml)
               String.parse);
          cache_node_type =
            (Util.option_bind (Xml.member "CacheNodeType" xml) String.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) String.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.reserved_cache_nodes_offering_id
                    (fun f ->
                       Ezxmlm.make_tag "ReservedCacheNodesOfferingId"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.cache_node_type
                   (fun f ->
                      Ezxmlm.make_tag "CacheNodeType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.duration
                  (fun f ->
                     Ezxmlm.make_tag "Duration" ([], (String.to_xml f)))])
              @
              [Util.option_map v.product_description
                 (fun f ->
                    Ezxmlm.make_tag "ProductDescription"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.offering_type
                (fun f ->
                   Ezxmlm.make_tag "OfferingType" ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeReservedCacheNodesOfferings</code> operation.</p>"]
module ReservedCacheNodesOfferingMessage = ReservedCacheNodesOfferingMessage
type input = DescribeReservedCacheNodesOfferingsMessage.t
type output = ReservedCacheNodesOfferingMessage.t
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
         ("Action", ["DescribeReservedCacheNodesOfferings"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeReservedCacheNodesOfferingsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeReservedCacheNodesOfferingsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeReservedCacheNodesOfferingsResponse" (snd xml))
        (Xml.member "DescribeReservedCacheNodesOfferingsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ReservedCacheNodesOfferingMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ReservedCacheNodesOfferingMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReservedCacheNodesOfferingMessage - missing field in body or children: "
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