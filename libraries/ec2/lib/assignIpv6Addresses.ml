open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssignIpv6AddressesRequest =
  struct
    type t =
      {
      ipv6_address_count: Integer.t option
        [@ocaml.doc
          "<p>The number of IPv6 addresses to assign to the network interface. Amazon EC2 automatically selects the IPv6 addresses from the subnet range. You can't use this option if specifying specific IPv6 addresses.</p>"];
      ipv6_addresses: Ipv6AddressList.t
        [@ocaml.doc
          "<p>One or more specific IPv6 addresses to be assigned to the network interface. You can't use this option if you're specifying a number of IPv6 addresses.</p>"];
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"]}
    let make ?ipv6_address_count  ?(ipv6_addresses= []) 
      ~network_interface_id  () =
      { ipv6_address_count; ipv6_addresses; network_interface_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("NetworkInterfaceId",
                   (String.to_query v.network_interface_id)));
           Some
             (Query.Pair
                ("Ipv6Addresses",
                  (Ipv6AddressList.to_query v.ipv6_addresses)));
           Util.option_map v.ipv6_address_count
             (fun f -> Query.Pair ("Ipv6AddressCount", (Integer.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("network_interface_id",
                (String.to_json v.network_interface_id));
           Some
             ("ipv6_addresses", (Ipv6AddressList.to_json v.ipv6_addresses));
           Util.option_map v.ipv6_address_count
             (fun f -> ("ipv6_address_count", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          ipv6_address_count =
            (Util.option_bind (Xml.member "ipv6AddressCount" xml)
               Integer.parse);
          ipv6_addresses =
            (Util.of_option []
               (Util.option_bind (Xml.member "ipv6Addresses" xml)
                  Ipv6AddressList.parse));
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.ipv6_address_count
                (fun f ->
                   Ezxmlm.make_tag "ipv6AddressCount"
                     ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ipv6Addresses"
                       ([], (Ipv6AddressList.to_xml [x])))) v.ipv6_addresses))
           @
           [Some
              (Ezxmlm.make_tag "networkInterfaceId"
                 ([], (String.to_xml v.network_interface_id)))])
  end
module AssignIpv6AddressesResult = AssignIpv6AddressesResult
type input = AssignIpv6AddressesRequest.t
type output = AssignIpv6AddressesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["AssignIpv6Addresses"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssignIpv6AddressesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AssignIpv6AddressesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AssignIpv6AddressesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp AssignIpv6AddressesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssignIpv6AddressesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssignIpv6AddressesResult - missing field in body or children: "
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