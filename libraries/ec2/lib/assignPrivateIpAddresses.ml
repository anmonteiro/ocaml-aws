open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssignPrivateIpAddressesRequest =
  struct
    type t =
      {
      allow_reassignment: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether to allow an IP address that is already assigned to another network interface or instance to be reassigned to the specified network interface.</p>"];
      network_interface_id: String.t
        [@ocaml.doc "<p>The ID of the network interface.</p>"];
      private_ip_addresses: PrivateIpAddressStringList.t
        [@ocaml.doc
          "<p>One or more IP addresses to be assigned as a secondary private IP address to the network interface. You can't specify this parameter when also specifying a number of secondary IP addresses.</p> <p>If you don't specify an IP address, Amazon EC2 automatically selects an IP address within the subnet range.</p>"];
      secondary_private_ip_address_count: Integer.t option
        [@ocaml.doc
          "<p>The number of secondary IP addresses to assign to the network interface. You can't specify this parameter when also specifying private IP addresses.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for AssignPrivateIpAddresses.</p>"]
    let make ?allow_reassignment  ~network_interface_id 
      ?(private_ip_addresses= [])  ?secondary_private_ip_address_count  () =
      {
        allow_reassignment;
        network_interface_id;
        private_ip_addresses;
        secondary_private_ip_address_count
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.secondary_private_ip_address_count
              (fun f ->
                 Query.Pair
                   ("SecondaryPrivateIpAddressCount", (Integer.to_query f)));
           Some
             (Query.Pair
                ("PrivateIpAddress",
                  (PrivateIpAddressStringList.to_query v.private_ip_addresses)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (String.to_query v.network_interface_id)));
           Util.option_map v.allow_reassignment
             (fun f -> Query.Pair ("AllowReassignment", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.secondary_private_ip_address_count
              (fun f ->
                 ("secondary_private_ip_address_count", (Integer.to_json f)));
           Some
             ("private_ip_addresses",
               (PrivateIpAddressStringList.to_json v.private_ip_addresses));
           Some
             ("network_interface_id",
               (String.to_json v.network_interface_id));
           Util.option_map v.allow_reassignment
             (fun f -> ("allow_reassignment", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          allow_reassignment =
            (Util.option_bind (Xml.member "allowReassignment" xml)
               Boolean.parse);
          network_interface_id =
            (Xml.required "networkInterfaceId"
               (Util.option_bind (Xml.member "networkInterfaceId" xml)
                  String.parse));
          private_ip_addresses =
            (Util.of_option []
               (Util.option_bind (Xml.member "privateIpAddress" xml)
                  PrivateIpAddressStringList.parse));
          secondary_private_ip_address_count =
            (Util.option_bind
               (Xml.member "secondaryPrivateIpAddressCount" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.allow_reassignment
                 (fun f ->
                    Ezxmlm.make_tag "allowReassignment"
                      ([], (Boolean.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "networkInterfaceId"
                   ([], (String.to_xml v.network_interface_id)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "privateIpAddress"
                       ([], (PrivateIpAddressStringList.to_xml [x]))))
               v.private_ip_addresses))
           @
           [Util.option_map v.secondary_private_ip_address_count
              (fun f ->
                 Ezxmlm.make_tag "secondaryPrivateIpAddressCount"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for AssignPrivateIpAddresses.</p>"]
module AssignPrivateIpAddressesResult = AssignPrivateIpAddressesResult
type input = AssignPrivateIpAddressesRequest.t
type output = AssignPrivateIpAddressesResult.t
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
         ("Action", ["AssignPrivateIpAddresses"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssignPrivateIpAddressesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AssignPrivateIpAddressesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AssignPrivateIpAddressesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AssignPrivateIpAddressesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssignPrivateIpAddressesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssignPrivateIpAddressesResult - missing field in body or children: "
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