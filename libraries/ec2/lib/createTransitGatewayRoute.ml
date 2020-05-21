open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTransitGatewayRouteRequest =
  struct
    type t =
      {
      destination_cidr_block: String.t
        [@ocaml.doc
          "<p>The CIDR range used for destination matches. Routing decisions are based on the most specific match.</p>"];
      transit_gateway_route_table_id: String.t
        [@ocaml.doc "<p>The ID of the transit gateway route table.</p>"];
      transit_gateway_attachment_id: String.t option
        [@ocaml.doc "<p>The ID of the attachment.</p>"];
      blackhole: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether to drop traffic that matches this route.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~destination_cidr_block  ~transit_gateway_route_table_id 
      ?transit_gateway_attachment_id  ?blackhole  ?dry_run  () =
      {
        destination_cidr_block;
        transit_gateway_route_table_id;
        transit_gateway_attachment_id;
        blackhole;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.blackhole
             (fun f -> Query.Pair ("Blackhole", (Boolean.to_query f)));
           Util.option_map v.transit_gateway_attachment_id
             (fun f ->
                Query.Pair
                  ("TransitGatewayAttachmentId", (String.to_query f)));
           Some
             (Query.Pair
                ("TransitGatewayRouteTableId",
                  (String.to_query v.transit_gateway_route_table_id)));
           Some
             (Query.Pair
                ("DestinationCidrBlock",
                  (String.to_query v.destination_cidr_block)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.blackhole
             (fun f -> ("blackhole", (Boolean.to_json f)));
           Util.option_map v.transit_gateway_attachment_id
             (fun f -> ("transit_gateway_attachment_id", (String.to_json f)));
           Some
             ("transit_gateway_route_table_id",
               (String.to_json v.transit_gateway_route_table_id));
           Some
             ("destination_cidr_block",
               (String.to_json v.destination_cidr_block))])
    let parse xml =
      Some
        {
          destination_cidr_block =
            (Xml.required "DestinationCidrBlock"
               (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
                  String.parse));
          transit_gateway_route_table_id =
            (Xml.required "TransitGatewayRouteTableId"
               (Util.option_bind
                  (Xml.member "TransitGatewayRouteTableId" xml) String.parse));
          transit_gateway_attachment_id =
            (Util.option_bind (Xml.member "TransitGatewayAttachmentId" xml)
               String.parse);
          blackhole =
            (Util.option_bind (Xml.member "Blackhole" xml) Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "DestinationCidrBlock"
                     ([], (String.to_xml v.destination_cidr_block)))])
              @
              [Some
                 (Ezxmlm.make_tag "TransitGatewayRouteTableId"
                    ([], (String.to_xml v.transit_gateway_route_table_id)))])
             @
             [Util.option_map v.transit_gateway_attachment_id
                (fun f ->
                   Ezxmlm.make_tag "TransitGatewayAttachmentId"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.blackhole
               (fun f -> Ezxmlm.make_tag "Blackhole" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module CreateTransitGatewayRouteResult = CreateTransitGatewayRouteResult
type input = CreateTransitGatewayRouteRequest.t
type output = CreateTransitGatewayRouteResult.t
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
         ("Action", ["CreateTransitGatewayRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateTransitGatewayRouteRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateTransitGatewayRouteRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateTransitGatewayRouteResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTransitGatewayRouteResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTransitGatewayRouteResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTransitGatewayRouteResult - missing field in body or children: "
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