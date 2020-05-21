open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateRouteRequest =
  struct
    type t =
      {
      destination_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv4 CIDR address block used for the destination match. Routing decisions are based on the most specific match.</p>"];
      destination_ipv6_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv6 CIDR block used for the destination match. Routing decisions are based on the most specific match.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      egress_only_internet_gateway_id: String.t option
        [@ocaml.doc
          "<p>[IPv6 traffic only] The ID of an egress-only internet gateway.</p>"];
      gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of an internet gateway or virtual private gateway attached to your VPC.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The ID of a NAT instance in your VPC. The operation fails if you specify an instance ID unless exactly one network interface is attached.</p>"];
      nat_gateway_id: String.t option
        [@ocaml.doc "<p>[IPv4 traffic only] The ID of a NAT gateway.</p>"];
      transit_gateway_id: String.t option
        [@ocaml.doc "<p>The ID of a transit gateway.</p>"];
      local_gateway_id: String.t option
        [@ocaml.doc "<p>The ID of the local gateway.</p>"];
      network_interface_id: String.t option
        [@ocaml.doc "<p>The ID of a network interface.</p>"];
      route_table_id: String.t
        [@ocaml.doc "<p>The ID of the route table for the route.</p>"];
      vpc_peering_connection_id: String.t option
        [@ocaml.doc "<p>The ID of a VPC peering connection.</p>"]}
    let make ?destination_cidr_block  ?destination_ipv6_cidr_block  ?dry_run 
      ?egress_only_internet_gateway_id  ?gateway_id  ?instance_id 
      ?nat_gateway_id  ?transit_gateway_id  ?local_gateway_id 
      ?network_interface_id  ~route_table_id  ?vpc_peering_connection_id  ()
      =
      {
        destination_cidr_block;
        destination_ipv6_cidr_block;
        dry_run;
        egress_only_internet_gateway_id;
        gateway_id;
        instance_id;
        nat_gateway_id;
        transit_gateway_id;
        local_gateway_id;
        network_interface_id;
        route_table_id;
        vpc_peering_connection_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.vpc_peering_connection_id
              (fun f ->
                 Query.Pair ("VpcPeeringConnectionId", (String.to_query f)));
           Some
             (Query.Pair ("RouteTableId", (String.to_query v.route_table_id)));
           Util.option_map v.network_interface_id
             (fun f -> Query.Pair ("NetworkInterfaceId", (String.to_query f)));
           Util.option_map v.local_gateway_id
             (fun f -> Query.Pair ("LocalGatewayId", (String.to_query f)));
           Util.option_map v.transit_gateway_id
             (fun f -> Query.Pair ("TransitGatewayId", (String.to_query f)));
           Util.option_map v.nat_gateway_id
             (fun f -> Query.Pair ("NatGatewayId", (String.to_query f)));
           Util.option_map v.instance_id
             (fun f -> Query.Pair ("InstanceId", (String.to_query f)));
           Util.option_map v.gateway_id
             (fun f -> Query.Pair ("GatewayId", (String.to_query f)));
           Util.option_map v.egress_only_internet_gateway_id
             (fun f ->
                Query.Pair
                  ("EgressOnlyInternetGatewayId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.destination_ipv6_cidr_block
             (fun f ->
                Query.Pair ("DestinationIpv6CidrBlock", (String.to_query f)));
           Util.option_map v.destination_cidr_block
             (fun f ->
                Query.Pair ("DestinationCidrBlock", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.vpc_peering_connection_id
              (fun f -> ("vpc_peering_connection_id", (String.to_json f)));
           Some ("route_table_id", (String.to_json v.route_table_id));
           Util.option_map v.network_interface_id
             (fun f -> ("network_interface_id", (String.to_json f)));
           Util.option_map v.local_gateway_id
             (fun f -> ("local_gateway_id", (String.to_json f)));
           Util.option_map v.transit_gateway_id
             (fun f -> ("transit_gateway_id", (String.to_json f)));
           Util.option_map v.nat_gateway_id
             (fun f -> ("nat_gateway_id", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.gateway_id
             (fun f -> ("gateway_id", (String.to_json f)));
           Util.option_map v.egress_only_internet_gateway_id
             (fun f ->
                ("egress_only_internet_gateway_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.destination_ipv6_cidr_block
             (fun f -> ("destination_ipv6_cidr_block", (String.to_json f)));
           Util.option_map v.destination_cidr_block
             (fun f -> ("destination_cidr_block", (String.to_json f)))])
    let parse xml =
      Some
        {
          destination_cidr_block =
            (Util.option_bind (Xml.member "destinationCidrBlock" xml)
               String.parse);
          destination_ipv6_cidr_block =
            (Util.option_bind (Xml.member "destinationIpv6CidrBlock" xml)
               String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          egress_only_internet_gateway_id =
            (Util.option_bind (Xml.member "egressOnlyInternetGatewayId" xml)
               String.parse);
          gateway_id =
            (Util.option_bind (Xml.member "gatewayId" xml) String.parse);
          instance_id =
            (Util.option_bind (Xml.member "instanceId" xml) String.parse);
          nat_gateway_id =
            (Util.option_bind (Xml.member "natGatewayId" xml) String.parse);
          transit_gateway_id =
            (Util.option_bind (Xml.member "TransitGatewayId" xml)
               String.parse);
          local_gateway_id =
            (Util.option_bind (Xml.member "LocalGatewayId" xml) String.parse);
          network_interface_id =
            (Util.option_bind (Xml.member "networkInterfaceId" xml)
               String.parse);
          route_table_id =
            (Xml.required "routeTableId"
               (Util.option_bind (Xml.member "routeTableId" xml) String.parse));
          vpc_peering_connection_id =
            (Util.option_bind (Xml.member "vpcPeeringConnectionId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.destination_cidr_block
                         (fun f ->
                            Ezxmlm.make_tag "destinationCidrBlock"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.destination_ipv6_cidr_block
                        (fun f ->
                           Ezxmlm.make_tag "destinationIpv6CidrBlock"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.dry_run
                       (fun f ->
                          Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                   @
                   [Util.option_map v.egress_only_internet_gateway_id
                      (fun f ->
                         Ezxmlm.make_tag "egressOnlyInternetGatewayId"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.gateway_id
                     (fun f ->
                        Ezxmlm.make_tag "gatewayId" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.instance_id
                    (fun f ->
                       Ezxmlm.make_tag "instanceId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.nat_gateway_id
                   (fun f ->
                      Ezxmlm.make_tag "natGatewayId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.transit_gateway_id
                  (fun f ->
                     Ezxmlm.make_tag "TransitGatewayId"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.local_gateway_id
                 (fun f ->
                    Ezxmlm.make_tag "LocalGatewayId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.network_interface_id
                (fun f ->
                   Ezxmlm.make_tag "networkInterfaceId"
                     ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "routeTableId"
                  ([], (String.to_xml v.route_table_id)))])
           @
           [Util.option_map v.vpc_peering_connection_id
              (fun f ->
                 Ezxmlm.make_tag "vpcPeeringConnectionId"
                   ([], (String.to_xml f)))])
  end
module CreateRouteResult = CreateRouteResult
type input = CreateRouteRequest.t
type output = CreateRouteResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["CreateRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateRouteRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateRouteRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateRouteResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateRouteResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateRouteResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateRouteResult - missing field in body or children: "
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