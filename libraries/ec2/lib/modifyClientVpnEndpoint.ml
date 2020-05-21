open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyClientVpnEndpointRequest =
  struct
    type t =
      {
      client_vpn_endpoint_id: String.t
        [@ocaml.doc "<p>The ID of the Client VPN endpoint to modify.</p>"];
      server_certificate_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the server certificate to be used. The server certificate must be provisioned in AWS Certificate Manager (ACM).</p>"];
      connection_log_options: ConnectionLogOptions.t option
        [@ocaml.doc
          "<p>Information about the client connection logging options.</p> <p>If you enable client connection logging, data about client connections is sent to a Cloudwatch Logs log stream. The following information is logged:</p> <ul> <li> <p>Client connection requests</p> </li> <li> <p>Client connection results (successful and unsuccessful)</p> </li> <li> <p>Reasons for unsuccessful client connection requests</p> </li> <li> <p>Client connection termination time</p> </li> </ul>"];
      dns_servers: DnsServersOptionsModifyStructure.t option
        [@ocaml.doc
          "<p>Information about the DNS servers to be used by Client VPN connections. A Client VPN endpoint can have up to two DNS servers.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A brief description of the Client VPN endpoint.</p>"];
      split_tunnel: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the VPN is split-tunnel.</p> <p>For information about split-tunnel VPN endpoints, see <a href=\"https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/split-tunnel-vpn.html\">Split-Tunnel AWS Client VPN Endpoint</a> in the <i>AWS Client VPN Administrator Guide</i>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~client_vpn_endpoint_id  ?server_certificate_arn 
      ?connection_log_options  ?dns_servers  ?description  ?split_tunnel 
      ?dry_run  () =
      {
        client_vpn_endpoint_id;
        server_certificate_arn;
        connection_log_options;
        dns_servers;
        description;
        split_tunnel;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.split_tunnel
             (fun f -> Query.Pair ("SplitTunnel", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.dns_servers
             (fun f ->
                Query.Pair
                  ("DnsServers",
                    (DnsServersOptionsModifyStructure.to_query f)));
           Util.option_map v.connection_log_options
             (fun f ->
                Query.Pair
                  ("ConnectionLogOptions", (ConnectionLogOptions.to_query f)));
           Util.option_map v.server_certificate_arn
             (fun f ->
                Query.Pair ("ServerCertificateArn", (String.to_query f)));
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
           Util.option_map v.split_tunnel
             (fun f -> ("split_tunnel", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.dns_servers
             (fun f ->
                ("dns_servers", (DnsServersOptionsModifyStructure.to_json f)));
           Util.option_map v.connection_log_options
             (fun f ->
                ("connection_log_options", (ConnectionLogOptions.to_json f)));
           Util.option_map v.server_certificate_arn
             (fun f -> ("server_certificate_arn", (String.to_json f)));
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
          server_certificate_arn =
            (Util.option_bind (Xml.member "ServerCertificateArn" xml)
               String.parse);
          connection_log_options =
            (Util.option_bind (Xml.member "ConnectionLogOptions" xml)
               ConnectionLogOptions.parse);
          dns_servers =
            (Util.option_bind (Xml.member "DnsServers" xml)
               DnsServersOptionsModifyStructure.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          split_tunnel =
            (Util.option_bind (Xml.member "SplitTunnel" xml) Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "ClientVpnEndpointId"
                       ([], (String.to_xml v.client_vpn_endpoint_id)))])
                @
                [Util.option_map v.server_certificate_arn
                   (fun f ->
                      Ezxmlm.make_tag "ServerCertificateArn"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.connection_log_options
                  (fun f ->
                     Ezxmlm.make_tag "ConnectionLogOptions"
                       ([], (ConnectionLogOptions.to_xml f)))])
              @
              [Util.option_map v.dns_servers
                 (fun f ->
                    Ezxmlm.make_tag "DnsServers"
                      ([], (DnsServersOptionsModifyStructure.to_xml f)))])
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
  end
module ModifyClientVpnEndpointResult = ModifyClientVpnEndpointResult
type input = ModifyClientVpnEndpointRequest.t
type output = ModifyClientVpnEndpointResult.t
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
         ("Action", ["ModifyClientVpnEndpoint"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyClientVpnEndpointRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyClientVpnEndpointRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyClientVpnEndpointResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyClientVpnEndpointResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyClientVpnEndpointResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyClientVpnEndpointResult - missing field in body or children: "
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