open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateClientVpnEndpointRequest =
  struct
    type t =
      {
      client_cidr_block: String.t
        [@ocaml.doc
          "<p>The IPv4 address range, in CIDR notation, from which to assign client IP addresses. The address range cannot overlap with the local CIDR of the VPC in which the associated subnet is located, or the routes that you add manually. The address range cannot be changed after the Client VPN endpoint has been created. The CIDR block should be /22 or greater.</p>"];
      server_certificate_arn: String.t
        [@ocaml.doc
          "<p>The ARN of the server certificate. For more information, see the <a href=\"https://docs.aws.amazon.com/acm/latest/userguide/\">AWS Certificate Manager User Guide</a>.</p>"];
      authentication_options: ClientVpnAuthenticationRequestList.t
        [@ocaml.doc
          "<p>Information about the authentication method to be used to authenticate clients.</p>"];
      connection_log_options: ConnectionLogOptions.t
        [@ocaml.doc
          "<p>Information about the client connection logging options.</p> <p>If you enable client connection logging, data about client connections is sent to a Cloudwatch Logs log stream. The following information is logged:</p> <ul> <li> <p>Client connection requests</p> </li> <li> <p>Client connection results (successful and unsuccessful)</p> </li> <li> <p>Reasons for unsuccessful client connection requests</p> </li> <li> <p>Client connection termination time</p> </li> </ul>"];
      dns_servers: ValueStringList.t
        [@ocaml.doc
          "<p>Information about the DNS servers to be used for DNS resolution. A Client VPN endpoint can have up to two DNS servers. If no DNS server is specified, the DNS address configured on the device is used for the DNS server.</p>"];
      transport_protocol: TransportProtocol.t option
        [@ocaml.doc
          "<p>The transport protocol to be used by the VPN session.</p> <p>Default value: <code>udp</code> </p>"];
      description: String.t option
        [@ocaml.doc "<p>A brief description of the Client VPN endpoint.</p>"];
      split_tunnel: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether split-tunnel is enabled on the AWS Client VPN endpoint.</p> <p>By default, split-tunnel on a VPN endpoint is disabled.</p> <p>For information about split-tunnel VPN endpoints, see <a href=\"https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/split-tunnel-vpn.html\">Split-Tunnel AWS Client VPN Endpoint</a> in the <i>AWS Client VPN Administrator Guide</i>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the Client VPN endpoint during creation.</p>"]}
    let make ~client_cidr_block  ~server_certificate_arn 
      ~authentication_options  ~connection_log_options  ?(dns_servers= []) 
      ?transport_protocol  ?description  ?split_tunnel  ?dry_run 
      ?client_token  ?(tag_specifications= [])  () =
      {
        client_cidr_block;
        server_certificate_arn;
        authentication_options;
        connection_log_options;
        dns_servers;
        transport_protocol;
        description;
        split_tunnel;
        dry_run;
        client_token;
        tag_specifications
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TagSpecification",
                   (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.split_tunnel
             (fun f -> Query.Pair ("SplitTunnel", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.transport_protocol
             (fun f ->
                Query.Pair
                  ("TransportProtocol", (TransportProtocol.to_query f)));
           Some
             (Query.Pair
                ("DnsServers", (ValueStringList.to_query v.dns_servers)));
           Some
             (Query.Pair
                ("ConnectionLogOptions",
                  (ConnectionLogOptions.to_query v.connection_log_options)));
           Some
             (Query.Pair
                ("Authentication",
                  (ClientVpnAuthenticationRequestList.to_query
                     v.authentication_options)));
           Some
             (Query.Pair
                ("ServerCertificateArn",
                  (String.to_query v.server_certificate_arn)));
           Some
             (Query.Pair
                ("ClientCidrBlock", (String.to_query v.client_cidr_block)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("tag_specifications",
                (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.split_tunnel
             (fun f -> ("split_tunnel", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.transport_protocol
             (fun f -> ("transport_protocol", (TransportProtocol.to_json f)));
           Some ("dns_servers", (ValueStringList.to_json v.dns_servers));
           Some
             ("connection_log_options",
               (ConnectionLogOptions.to_json v.connection_log_options));
           Some
             ("authentication_options",
               (ClientVpnAuthenticationRequestList.to_json
                  v.authentication_options));
           Some
             ("server_certificate_arn",
               (String.to_json v.server_certificate_arn));
           Some ("client_cidr_block", (String.to_json v.client_cidr_block))])
    let parse xml =
      Some
        {
          client_cidr_block =
            (Xml.required "ClientCidrBlock"
               (Util.option_bind (Xml.member "ClientCidrBlock" xml)
                  String.parse));
          server_certificate_arn =
            (Xml.required "ServerCertificateArn"
               (Util.option_bind (Xml.member "ServerCertificateArn" xml)
                  String.parse));
          authentication_options =
            (Xml.required "Authentication"
               (Util.option_bind (Xml.member "Authentication" xml)
                  ClientVpnAuthenticationRequestList.parse));
          connection_log_options =
            (Xml.required "ConnectionLogOptions"
               (Util.option_bind (Xml.member "ConnectionLogOptions" xml)
                  ConnectionLogOptions.parse));
          dns_servers =
            (Util.of_option []
               (Util.option_bind (Xml.member "DnsServers" xml)
                  ValueStringList.parse));
          transport_protocol =
            (Util.option_bind (Xml.member "TransportProtocol" xml)
               TransportProtocol.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          split_tunnel =
            (Util.option_bind (Xml.member "SplitTunnel" xml) Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Some
                        (Ezxmlm.make_tag "ClientCidrBlock"
                           ([], (String.to_xml v.client_cidr_block)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "ServerCertificateArn"
                          ([], (String.to_xml v.server_certificate_arn)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "Authentication"
                              ([],
                                (ClientVpnAuthenticationRequestList.to_xml
                                   [x])))) v.authentication_options))
                  @
                  [Some
                     (Ezxmlm.make_tag "ConnectionLogOptions"
                        ([],
                          (ConnectionLogOptions.to_xml
                             v.connection_log_options)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "DnsServers"
                            ([], (ValueStringList.to_xml [x]))))
                    v.dns_servers))
                @
                [Util.option_map v.transport_protocol
                   (fun f ->
                      Ezxmlm.make_tag "TransportProtocol"
                        ([], (TransportProtocol.to_xml f)))])
               @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
              @
              [Util.option_map v.split_tunnel
                 (fun f ->
                    Ezxmlm.make_tag "SplitTunnel" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TagSpecification"
                      ([], (TagSpecificationList.to_xml [x]))))
              v.tag_specifications))
  end
module CreateClientVpnEndpointResult = CreateClientVpnEndpointResult
type input = CreateClientVpnEndpointRequest.t
type output = CreateClientVpnEndpointResult.t
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
         ("Action", ["CreateClientVpnEndpoint"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateClientVpnEndpointRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateClientVpnEndpointRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateClientVpnEndpointResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateClientVpnEndpointResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateClientVpnEndpointResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateClientVpnEndpointResult - missing field in body or children: "
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