open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UnassignIpv6AddressesRequest =
  struct
    type t =
      {
      ipv6_addresses: Ipv6AddressList.t
        [@ocaml.doc
          "<p>The IPv6 addresses to unassign from the network interface.</p>"];
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"]}
    let make ~ipv6_addresses  ~network_interface_id  () =
      { ipv6_addresses; network_interface_id }
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
                  (Ipv6AddressList.to_query v.ipv6_addresses)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("network_interface_id",
                (String.to_json v.network_interface_id));
           Some
             ("ipv6_addresses", (Ipv6AddressList.to_json v.ipv6_addresses))])
    let parse xml =
      Some
        {
          ipv6_addresses =
            (Xml.required "ipv6Addresses"
               (Util.option_bind (Xml.member "ipv6Addresses" xml)
                  Ipv6AddressList.parse));
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
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
module UnassignIpv6AddressesResult = UnassignIpv6AddressesResult
type input = UnassignIpv6AddressesRequest.t
type output = UnassignIpv6AddressesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["UnassignIpv6Addresses"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UnassignIpv6AddressesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (UnassignIpv6AddressesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "UnassignIpv6AddressesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp UnassignIpv6AddressesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UnassignIpv6AddressesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UnassignIpv6AddressesResult - missing field in body or children: "
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