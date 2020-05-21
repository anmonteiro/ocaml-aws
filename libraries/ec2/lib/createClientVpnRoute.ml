open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateClientVpnRouteRequest =
  struct
    type t =
      {
      client_vpn_endpoint_id: String.t
        [@ocaml.doc
          "<p>The ID of the Client VPN endpoint to which to add the route.</p>"];
      destination_cidr_block: String.t
        [@ocaml.doc
          "<p>The IPv4 address range, in CIDR notation, of the route destination. For example:</p> <ul> <li> <p>To add a route for Internet access, enter <code>0.0.0.0/0</code> </p> </li> <li> <p>To add a route for a peered VPC, enter the peered VPC's IPv4 CIDR range</p> </li> <li> <p>To add a route for an on-premises network, enter the AWS Site-to-Site VPN connection's IPv4 CIDR range</p> </li> </ul> <p>Route address ranges cannot overlap with the CIDR range specified for client allocation.</p>"];
      target_vpc_subnet_id: String.t
        [@ocaml.doc
          "<p>The ID of the subnet through which you want to route traffic. The specified subnet must be an existing target network of the Client VPN endpoint.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A brief description of the route.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~client_vpn_endpoint_id  ~destination_cidr_block 
      ~target_vpc_subnet_id  ?description  ?client_token  ?dry_run  () =
      {
        client_vpn_endpoint_id;
        destination_cidr_block;
        target_vpc_subnet_id;
        description;
        client_token;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Some
             (Query.Pair
                ("TargetVpcSubnetId",
                  (String.to_query v.target_vpc_subnet_id)));
           Some
             (Query.Pair
                ("DestinationCidrBlock",
                  (String.to_query v.destination_cidr_block)));
           Some
             (Query.Pair
                ("ClientVpnEndpointId",
                  (String.to_query v.client_vpn_endpoint_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some
             ("target_vpc_subnet_id",
               (String.to_json v.target_vpc_subnet_id));
           Some
             ("destination_cidr_block",
               (String.to_json v.destination_cidr_block));
           Some
             ("client_vpn_endpoint_id",
               (String.to_json v.client_vpn_endpoint_id))])
    let parse xml =
      Some
        {
          client_vpn_endpoint_id =
            (Xml.required "ClientVpnEndpointId"
               (Util.option_bind (Xml.member "ClientVpnEndpointId" xml)
                  String.parse));
          destination_cidr_block =
            (Xml.required "DestinationCidrBlock"
               (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
                  String.parse));
          target_vpc_subnet_id =
            (Xml.required "TargetVpcSubnetId"
               (Util.option_bind (Xml.member "TargetVpcSubnetId" xml)
                  String.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "ClientVpnEndpointId"
                      ([], (String.to_xml v.client_vpn_endpoint_id)))])
               @
               [Some
                  (Ezxmlm.make_tag "DestinationCidrBlock"
                     ([], (String.to_xml v.destination_cidr_block)))])
              @
              [Some
                 (Ezxmlm.make_tag "TargetVpcSubnetId"
                    ([], (String.to_xml v.target_vpc_subnet_id)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module CreateClientVpnRouteResult = CreateClientVpnRouteResult
type input = CreateClientVpnRouteRequest.t
type output = CreateClientVpnRouteResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateClientVpnRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateClientVpnRouteRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateClientVpnRouteRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateClientVpnRouteResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateClientVpnRouteResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateClientVpnRouteResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateClientVpnRouteResult - missing field in body or children: "
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