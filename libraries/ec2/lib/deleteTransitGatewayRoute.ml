open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteTransitGatewayRouteRequest =
  struct
    type t =
      {
      transit_gateway_route_table_id: String.t
        [@ocaml.doc "<p>The ID of the transit gateway route table.</p>"];
      destination_cidr_block: String.t
        [@ocaml.doc
          "<p>The CIDR range for the route. This must match the CIDR for the route exactly.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~transit_gateway_route_table_id  ~destination_cidr_block 
      ?dry_run  () =
      { transit_gateway_route_table_id; destination_cidr_block; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("DestinationCidrBlock",
                  (String.to_query v.destination_cidr_block)));
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
           Some
             ("destination_cidr_block",
               (String.to_json v.destination_cidr_block));
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
          destination_cidr_block =
            (Xml.required "DestinationCidrBlock"
               (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
                  String.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "TransitGatewayRouteTableId"
                   ([], (String.to_xml v.transit_gateway_route_table_id)))])
            @
            [Some
               (Ezxmlm.make_tag "DestinationCidrBlock"
                  ([], (String.to_xml v.destination_cidr_block)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module DeleteTransitGatewayRouteResult = DeleteTransitGatewayRouteResult
type input = DeleteTransitGatewayRouteRequest.t
type output = DeleteTransitGatewayRouteResult.t
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
         ("Action", ["DeleteTransitGatewayRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteTransitGatewayRouteRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteTransitGatewayRouteRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DeleteTransitGatewayRouteResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteTransitGatewayRouteResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteTransitGatewayRouteResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteTransitGatewayRouteResult - missing field in body or children: "
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