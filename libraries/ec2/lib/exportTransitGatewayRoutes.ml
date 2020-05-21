open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ExportTransitGatewayRoutesRequest =
  struct
    type t =
      {
      transit_gateway_route_table_id: String.t
        [@ocaml.doc "<p>The ID of the route table.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters. The possible values are:</p> <ul> <li> <p> <code>attachment.transit-gateway-attachment-id</code> - The id of the transit gateway attachment.</p> </li> <li> <p> <code>attachment.resource-id</code> - The resource id of the transit gateway attachment.</p> </li> <li> <p> <code>route-search.exact-match</code> - The exact match of the specified filter.</p> </li> <li> <p> <code>route-search.longest-prefix-match</code> - The longest prefix that matches the route.</p> </li> <li> <p> <code>route-search.subnet-of-match</code> - The routes with a subnet that match the specified CIDR filter.</p> </li> <li> <p> <code>route-search.supernet-of-match</code> - The routes with a CIDR that encompass the CIDR filter. For example, if you have 10.0.1.0/29 and 10.0.1.0/31 routes in your route table and you specify supernet-of-match as 10.0.1.0/30, then the result returns 10.0.1.0/29.</p> </li> <li> <p> <code>state</code> - The state of the attachment (<code>available</code> | <code>deleted</code> | <code>deleting</code> | <code>failed</code> | <code>modifying</code> | <code>pendingAcceptance</code> | <code>pending</code> | <code>rollingBack</code> | <code>rejected</code> | <code>rejecting</code>).</p> </li> <li> <p> <code>transit-gateway-route-destination-cidr-block</code> - The CIDR range.</p> </li> <li> <p> <code>type</code> - The type of route (<code>active</code> | <code>blackhole</code>).</p> </li> </ul>"];
      s3_bucket: String.t [@ocaml.doc "<p>The name of the S3 bucket.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~transit_gateway_route_table_id  ?(filters= [])  ~s3_bucket 
      ?dry_run  () =
      { transit_gateway_route_table_id; filters; s3_bucket; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("S3Bucket", (String.to_query v.s3_bucket)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("TransitGatewayRouteTableId",
                  (String.to_query v.transit_gateway_route_table_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("s3_bucket", (String.to_json v.s3_bucket));
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("transit_gateway_route_table_id",
               (String.to_json v.transit_gateway_route_table_id))])
    let parse xml =
      Some
        {
          transit_gateway_route_table_id =
            (Xml.required "TransitGatewayRouteTableId"
               (Util.option_bind
                  (Xml.member "TransitGatewayRouteTableId" xml) String.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          s3_bucket =
            (Xml.required "S3Bucket"
               (Util.option_bind (Xml.member "S3Bucket" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "TransitGatewayRouteTableId"
                    ([], (String.to_xml v.transit_gateway_route_table_id)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Some
               (Ezxmlm.make_tag "S3Bucket" ([], (String.to_xml v.s3_bucket)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ExportTransitGatewayRoutesResult = ExportTransitGatewayRoutesResult
type input = ExportTransitGatewayRoutesRequest.t
type output = ExportTransitGatewayRoutesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ExportTransitGatewayRoutes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ExportTransitGatewayRoutesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ExportTransitGatewayRoutesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ExportTransitGatewayRoutesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ExportTransitGatewayRoutesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ExportTransitGatewayRoutesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ExportTransitGatewayRoutesResult - missing field in body or children: "
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