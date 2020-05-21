open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCustomAvailabilityZoneMessage =
  struct
    type t =
      {
      custom_availability_zone_name: String.t
        [@ocaml.doc "<p>The name of the custom Availability Zone (AZ).</p>"];
      existing_vpn_id: String.t option
        [@ocaml.doc
          "<p>The ID of an existing virtual private network (VPN) between the Amazon RDS website and the VMware vSphere cluster.</p>"];
      new_vpn_tunnel_name: String.t option
        [@ocaml.doc
          "<p>The name of a new VPN tunnel between the Amazon RDS website and the VMware vSphere cluster.</p> <p>Specify this parameter only if <code>ExistingVpnId</code> isn't specified.</p>"];
      vpn_tunnel_originator_i_p: String.t option
        [@ocaml.doc
          "<p>The IP address of network traffic from your on-premises data center. A custom AZ receives the network traffic.</p> <p>Specify this parameter only if <code>ExistingVpnId</code> isn't specified.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~custom_availability_zone_name  ?existing_vpn_id 
      ?new_vpn_tunnel_name  ?vpn_tunnel_originator_i_p  () =
      {
        custom_availability_zone_name;
        existing_vpn_id;
        new_vpn_tunnel_name;
        vpn_tunnel_originator_i_p
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.vpn_tunnel_originator_i_p
              (fun f -> ("vpn_tunnel_originator_i_p", (String.to_json f)));
           Util.option_map v.new_vpn_tunnel_name
             (fun f -> ("new_vpn_tunnel_name", (String.to_json f)));
           Util.option_map v.existing_vpn_id
             (fun f -> ("existing_vpn_id", (String.to_json f)));
           Some
             ("custom_availability_zone_name",
               (String.to_json v.custom_availability_zone_name))])
    let parse xml =
      Some
        {
          custom_availability_zone_name =
            (Xml.required "CustomAvailabilityZoneName"
               (Util.option_bind
                  (Xml.member "CustomAvailabilityZoneName" xml) String.parse));
          existing_vpn_id =
            (Util.option_bind (Xml.member "ExistingVpnId" xml) String.parse);
          new_vpn_tunnel_name =
            (Util.option_bind (Xml.member "NewVpnTunnelName" xml)
               String.parse);
          vpn_tunnel_originator_i_p =
            (Util.option_bind (Xml.member "VpnTunnelOriginatorIP" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "CustomAvailabilityZoneName"
                    ([], (String.to_xml v.custom_availability_zone_name)))])
             @
             [Util.option_map v.existing_vpn_id
                (fun f ->
                   Ezxmlm.make_tag "ExistingVpnId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.new_vpn_tunnel_name
               (fun f ->
                  Ezxmlm.make_tag "NewVpnTunnelName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.vpn_tunnel_originator_i_p
              (fun f ->
                 Ezxmlm.make_tag "VpnTunnelOriginatorIP"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module CreateCustomAvailabilityZoneResult =
  CreateCustomAvailabilityZoneResult
type input = CreateCustomAvailabilityZoneMessage.t
type output = CreateCustomAvailabilityZoneResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["CreateCustomAvailabilityZone"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateCustomAvailabilityZoneMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateCustomAvailabilityZoneMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateCustomAvailabilityZoneResponse" (snd xml))
        (Xml.member "CreateCustomAvailabilityZoneResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateCustomAvailabilityZoneResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCustomAvailabilityZoneResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCustomAvailabilityZoneResult - missing field in body or children: "
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