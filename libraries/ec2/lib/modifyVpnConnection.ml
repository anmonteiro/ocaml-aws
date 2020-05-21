open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpnConnectionRequest =
  struct
    type t =
      {
      vpn_connection_id: String.t
        [@ocaml.doc "<p>The ID of the VPN connection.</p>"];
      transit_gateway_id: String.t option
        [@ocaml.doc "<p>The ID of the transit gateway.</p>"];
      customer_gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of the customer gateway at your end of the VPN connection.</p>"];
      vpn_gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of the virtual private gateway at the AWS side of the VPN connection.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~vpn_connection_id  ?transit_gateway_id  ?customer_gateway_id 
      ?vpn_gateway_id  ?dry_run  () =
      {
        vpn_connection_id;
        transit_gateway_id;
        customer_gateway_id;
        vpn_gateway_id;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.vpn_gateway_id
             (fun f -> Query.Pair ("VpnGatewayId", (String.to_query f)));
           Util.option_map v.customer_gateway_id
             (fun f -> Query.Pair ("CustomerGatewayId", (String.to_query f)));
           Util.option_map v.transit_gateway_id
             (fun f -> Query.Pair ("TransitGatewayId", (String.to_query f)));
           Some
             (Query.Pair
                ("VpnConnectionId", (String.to_query v.vpn_connection_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.vpn_gateway_id
             (fun f -> ("vpn_gateway_id", (String.to_json f)));
           Util.option_map v.customer_gateway_id
             (fun f -> ("customer_gateway_id", (String.to_json f)));
           Util.option_map v.transit_gateway_id
             (fun f -> ("transit_gateway_id", (String.to_json f)));
           Some ("vpn_connection_id", (String.to_json v.vpn_connection_id))])
    let parse xml =
      Some
        {
          vpn_connection_id =
            (Xml.required "VpnConnectionId"
               (Util.option_bind (Xml.member "VpnConnectionId" xml)
                  String.parse));
          transit_gateway_id =
            (Util.option_bind (Xml.member "TransitGatewayId" xml)
               String.parse);
          customer_gateway_id =
            (Util.option_bind (Xml.member "CustomerGatewayId" xml)
               String.parse);
          vpn_gateway_id =
            (Util.option_bind (Xml.member "VpnGatewayId" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "VpnConnectionId"
                     ([], (String.to_xml v.vpn_connection_id)))])
              @
              [Util.option_map v.transit_gateway_id
                 (fun f ->
                    Ezxmlm.make_tag "TransitGatewayId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.customer_gateway_id
                (fun f ->
                   Ezxmlm.make_tag "CustomerGatewayId"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.vpn_gateway_id
               (fun f ->
                  Ezxmlm.make_tag "VpnGatewayId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyVpnConnectionResult = ModifyVpnConnectionResult
type input = ModifyVpnConnectionRequest.t
type output = ModifyVpnConnectionResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ModifyVpnConnection"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyVpnConnectionRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyVpnConnectionRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyVpnConnectionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyVpnConnectionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyVpnConnectionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVpnConnectionResult - missing field in body or children: "
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