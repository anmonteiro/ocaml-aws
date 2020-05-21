open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReplaceRouteRequest =
  struct
    type t =
      {
      destination_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv4 CIDR address block used for the destination match. The value that you provide must match the CIDR of an existing route in the table.</p>"];
      destination_ipv6_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv6 CIDR address block used for the destination match. The value that you provide must match the CIDR of an existing route in the table.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      egress_only_internet_gateway_id: String.t option
        [@ocaml.doc
          "<p>[IPv6 traffic only] The ID of an egress-only internet gateway.</p>"];
      gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of an internet gateway or virtual private gateway.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of a NAT instance in your VPC.</p>"];
      local_target: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether to reset the local route to its default target (<code>local</code>).</p>"];
      nat_gateway_id: String.t option
        [@ocaml.doc "<p>[IPv4 traffic only] The ID of a NAT gateway.</p>"];
      transit_gateway_id: String.t option
        [@ocaml.doc "<p>The ID of a transit gateway.</p>"];
      local_gateway_id: String.t option
        [@ocaml.doc "<p>The ID of the local gateway.</p>"];
      network_interface_id: String.t option
        [@ocaml.doc "<p>The ID of a network interface.</p>"];
      route_table_id: String.t
        [@ocaml.doc "<p>The ID of the route table.</p>"];
      vpc_peering_connection_id: String.t option
        [@ocaml.doc "<p>The ID of a VPC peering connection.</p>"]}
    let make ?destination_cidr_block  ?destination_ipv6_cidr_block  ?dry_run 
      ?egress_only_internet_gateway_id  ?gateway_id  ?instance_id 
      ?local_target  ?nat_gateway_id  ?transit_gateway_id  ?local_gateway_id 
      ?network_interface_id  ~route_table_id  ?vpc_peering_connection_id  ()
      =
      {
        destination_cidr_block;
        destination_ipv6_cidr_block;
        dry_run;
        egress_only_internet_gateway_id;
        gateway_id;
        instance_id;
        local_target;
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
           Util.option_map v.local_target
             (fun f -> Query.Pair ("LocalTarget", (Boolean.to_query f)));
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
           Util.option_map v.local_target
             (fun f -> ("local_target", (Boolean.to_json f)));
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
          local_target =
            (Util.option_bind (Xml.member "LocalTarget" xml) Boolean.parse);
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
        ((((((((((((([] @
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
                 [Util.option_map v.local_target
                    (fun f ->
                       Ezxmlm.make_tag "LocalTarget" ([], (Boolean.to_xml f)))])
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
module Output = Aws.BaseTypes.Unit
type input = ReplaceRouteRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ReplaceRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ReplaceRouteRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ReplaceRouteRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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