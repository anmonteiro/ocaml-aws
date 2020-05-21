open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeregisterTransitGatewayMulticastGroupSourcesRequest =
  struct
    type t =
      {
      transit_gateway_multicast_domain_id: String.t option
        [@ocaml.doc "<p>The ID of the transit gateway multicast domain.</p>"];
      group_ip_address: String.t option
        [@ocaml.doc
          "<p>The IP address assigned to the transit gateway multicast group.</p>"];
      network_interface_ids: ValueStringList.t
        [@ocaml.doc
          "<p>The IDs of the group sources' network interfaces.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?transit_gateway_multicast_domain_id  ?group_ip_address 
      ?(network_interface_ids= [])  ?dry_run  () =
      {
        transit_gateway_multicast_domain_id;
        group_ip_address;
        network_interface_ids;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterfaceIds",
                  (ValueStringList.to_query v.network_interface_ids)));
           Util.option_map v.group_ip_address
             (fun f -> Query.Pair ("GroupIpAddress", (String.to_query f)));
           Util.option_map v.transit_gateway_multicast_domain_id
             (fun f ->
                Query.Pair
                  ("TransitGatewayMulticastDomainId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("network_interface_ids",
               (ValueStringList.to_json v.network_interface_ids));
           Util.option_map v.group_ip_address
             (fun f -> ("group_ip_address", (String.to_json f)));
           Util.option_map v.transit_gateway_multicast_domain_id
             (fun f ->
                ("transit_gateway_multicast_domain_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          transit_gateway_multicast_domain_id =
            (Util.option_bind
               (Xml.member "TransitGatewayMulticastDomainId" xml)
               String.parse);
          group_ip_address =
            (Util.option_bind (Xml.member "GroupIpAddress" xml) String.parse);
          network_interface_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "NetworkInterfaceIds" xml)
                  ValueStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.transit_gateway_multicast_domain_id
                 (fun f ->
                    Ezxmlm.make_tag "TransitGatewayMulticastDomainId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.group_ip_address
                (fun f ->
                   Ezxmlm.make_tag "GroupIpAddress" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "NetworkInterfaceIds"
                       ([], (ValueStringList.to_xml [x]))))
               v.network_interface_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module DeregisterTransitGatewayMulticastGroupSourcesResult =
  DeregisterTransitGatewayMulticastGroupSourcesResult
type input = DeregisterTransitGatewayMulticastGroupSourcesRequest.t
type output = DeregisterTransitGatewayMulticastGroupSourcesResult.t
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
         ("Action", ["DeregisterTransitGatewayMulticastGroupSources"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DeregisterTransitGatewayMulticastGroupSourcesRequest.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (DeregisterTransitGatewayMulticastGroupSourcesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DeregisterTransitGatewayMulticastGroupSourcesResponse"
        (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DeregisterTransitGatewayMulticastGroupSourcesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeregisterTransitGatewayMulticastGroupSourcesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeregisterTransitGatewayMulticastGroupSourcesResult - missing field in body or children: "
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