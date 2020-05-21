open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpnTunnelOptionsRequest =
  struct
    type t =
      {
      vpn_connection_id: String.t
        [@ocaml.doc "<p>The ID of the AWS Site-to-Site VPN connection.</p>"];
      vpn_tunnel_outside_ip_address: String.t
        [@ocaml.doc "<p>The external IP address of the VPN tunnel.</p>"];
      tunnel_options: ModifyVpnTunnelOptionsSpecification.t
        [@ocaml.doc "<p>The tunnel options to modify.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~vpn_connection_id  ~vpn_tunnel_outside_ip_address 
      ~tunnel_options  ?dry_run  () =
      {
        vpn_connection_id;
        vpn_tunnel_outside_ip_address;
        tunnel_options;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TunnelOptions",
                  (ModifyVpnTunnelOptionsSpecification.to_query
                     v.tunnel_options)));
           Some
             (Query.Pair
                ("VpnTunnelOutsideIpAddress",
                  (String.to_query v.vpn_tunnel_outside_ip_address)));
           Some
             (Query.Pair
                ("VpnConnectionId", (String.to_query v.vpn_connection_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tunnel_options",
               (ModifyVpnTunnelOptionsSpecification.to_json v.tunnel_options));
           Some
             ("vpn_tunnel_outside_ip_address",
               (String.to_json v.vpn_tunnel_outside_ip_address));
           Some ("vpn_connection_id", (String.to_json v.vpn_connection_id))])
    let parse xml =
      Some
        {
          vpn_connection_id =
            (Xml.required "VpnConnectionId"
               (Util.option_bind (Xml.member "VpnConnectionId" xml)
                  String.parse));
          vpn_tunnel_outside_ip_address =
            (Xml.required "VpnTunnelOutsideIpAddress"
               (Util.option_bind (Xml.member "VpnTunnelOutsideIpAddress" xml)
                  String.parse));
          tunnel_options =
            (Xml.required "TunnelOptions"
               (Util.option_bind (Xml.member "TunnelOptions" xml)
                  ModifyVpnTunnelOptionsSpecification.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "VpnConnectionId"
                    ([], (String.to_xml v.vpn_connection_id)))])
             @
             [Some
                (Ezxmlm.make_tag "VpnTunnelOutsideIpAddress"
                   ([], (String.to_xml v.vpn_tunnel_outside_ip_address)))])
            @
            [Some
               (Ezxmlm.make_tag "TunnelOptions"
                  ([],
                    (ModifyVpnTunnelOptionsSpecification.to_xml
                       v.tunnel_options)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyVpnTunnelOptionsResult = ModifyVpnTunnelOptionsResult
type input = ModifyVpnTunnelOptionsRequest.t
type output = ModifyVpnTunnelOptionsResult.t
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
         ("Action", ["ModifyVpnTunnelOptions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyVpnTunnelOptionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyVpnTunnelOptionsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyVpnTunnelOptionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyVpnTunnelOptionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyVpnTunnelOptionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVpnTunnelOptionsResult - missing field in body or children: "
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