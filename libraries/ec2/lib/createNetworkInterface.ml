open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateNetworkInterfaceRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc "<p>A description for the network interface.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      groups: SecurityGroupIdStringList.t
        [@ocaml.doc "<p>The IDs of one or more security groups.</p>"];
      ipv6_address_count: Integer.t option
        [@ocaml.doc
          "<p>The number of IPv6 addresses to assign to a network interface. Amazon EC2 automatically selects the IPv6 addresses from the subnet range. You can't use this option if specifying specific IPv6 addresses. If your subnet has the <code>AssignIpv6AddressOnCreation</code> attribute set to <code>true</code>, you can specify <code>0</code> to override this setting.</p>"];
      ipv6_addresses: InstanceIpv6AddressList.t
        [@ocaml.doc
          "<p>One or more specific IPv6 addresses from the IPv6 CIDR block range of your subnet. You can't use this option if you're specifying a number of IPv6 addresses.</p>"];
      private_ip_address: String.t option
        [@ocaml.doc
          "<p>The primary private IPv4 address of the network interface. If you don't specify an IPv4 address, Amazon EC2 selects one for you from the subnet's IPv4 CIDR range. If you specify an IP address, you cannot indicate any IP addresses specified in <code>privateIpAddresses</code> as primary (only one IP address can be designated as primary).</p>"];
      private_ip_addresses: PrivateIpAddressSpecificationList.t
        [@ocaml.doc "<p>One or more private IPv4 addresses.</p>"];
      secondary_private_ip_address_count: Integer.t option
        [@ocaml.doc
          "<p>The number of secondary private IPv4 addresses to assign to a network interface. When you specify a number of secondary IPv4 addresses, Amazon EC2 selects these IP addresses within the subnet's IPv4 CIDR range. You can't specify this option and specify more than one private IP address using <code>privateIpAddresses</code>.</p> <p>The number of IP addresses you can assign to a network interface varies by instance type. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html#AvailableIpPerENI\">IP Addresses Per ENI Per Instance Type</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>"];
      interface_type: NetworkInterfaceCreationType.t option
        [@ocaml.doc
          "<p>Indicates the type of network interface. To create an Elastic Fabric Adapter (EFA), specify <code>efa</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/efa.html\"> Elastic Fabric Adapter</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      subnet_id: String.t
        [@ocaml.doc
          "<p>The ID of the subnet to associate with the network interface.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for CreateNetworkInterface.</p>"]
    let make ?description  ?dry_run  ?(groups= [])  ?ipv6_address_count 
      ?(ipv6_addresses= [])  ?private_ip_address  ?(private_ip_addresses= [])
       ?secondary_private_ip_address_count  ?interface_type  ~subnet_id  () =
      {
        description;
        dry_run;
        groups;
        ipv6_address_count;
        ipv6_addresses;
        private_ip_address;
        private_ip_addresses;
        secondary_private_ip_address_count;
        interface_type;
        subnet_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("SubnetId", (String.to_query v.subnet_id)));
           Util.option_map v.interface_type
             (fun f ->
                Query.Pair
                  ("InterfaceType",
                    (NetworkInterfaceCreationType.to_query f)));
           Util.option_map v.secondary_private_ip_address_count
             (fun f ->
                Query.Pair
                  ("SecondaryPrivateIpAddressCount", (Integer.to_query f)));
           Some
             (Query.Pair
                ("PrivateIpAddresses",
                  (PrivateIpAddressSpecificationList.to_query
                     v.private_ip_addresses)));
           Util.option_map v.private_ip_address
             (fun f -> Query.Pair ("PrivateIpAddress", (String.to_query f)));
           Some
             (Query.Pair
                ("Ipv6Addresses",
                  (InstanceIpv6AddressList.to_query v.ipv6_addresses)));
           Util.option_map v.ipv6_address_count
             (fun f -> Query.Pair ("Ipv6AddressCount", (Integer.to_query f)));
           Some
             (Query.Pair
                ("SecurityGroupId",
                  (SecurityGroupIdStringList.to_query v.groups)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_id", (String.to_json v.subnet_id));
           Util.option_map v.interface_type
             (fun f ->
                ("interface_type", (NetworkInterfaceCreationType.to_json f)));
           Util.option_map v.secondary_private_ip_address_count
             (fun f ->
                ("secondary_private_ip_address_count", (Integer.to_json f)));
           Some
             ("private_ip_addresses",
               (PrivateIpAddressSpecificationList.to_json
                  v.private_ip_addresses));
           Util.option_map v.private_ip_address
             (fun f -> ("private_ip_address", (String.to_json f)));
           Some
             ("ipv6_addresses",
               (InstanceIpv6AddressList.to_json v.ipv6_addresses));
           Util.option_map v.ipv6_address_count
             (fun f -> ("ipv6_address_count", (Integer.to_json f)));
           Some ("groups", (SecurityGroupIdStringList.to_json v.groups));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "description" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroupId" xml)
                  SecurityGroupIdStringList.parse));
          ipv6_address_count =
            (Util.option_bind (Xml.member "ipv6AddressCount" xml)
               Integer.parse);
          ipv6_addresses =
            (Util.of_option []
               (Util.option_bind (Xml.member "ipv6Addresses" xml)
                  InstanceIpv6AddressList.parse));
          private_ip_address =
            (Util.option_bind (Xml.member "privateIpAddress" xml)
               String.parse);
          private_ip_addresses =
            (Util.of_option []
               (Util.option_bind (Xml.member "privateIpAddresses" xml)
                  PrivateIpAddressSpecificationList.parse));
          secondary_private_ip_address_count =
            (Util.option_bind
               (Xml.member "secondaryPrivateIpAddressCount" xml)
               Integer.parse);
          interface_type =
            (Util.option_bind (Xml.member "InterfaceType" xml)
               NetworkInterfaceCreationType.parse);
          subnet_id =
            (Xml.required "subnetId"
               (Util.option_bind (Xml.member "subnetId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.description
                       (fun f ->
                          Ezxmlm.make_tag "description"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.dry_run
                      (fun f ->
                         Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "SecurityGroupId"
                             ([], (SecurityGroupIdStringList.to_xml [x]))))
                     v.groups))
                 @
                 [Util.option_map v.ipv6_address_count
                    (fun f ->
                       Ezxmlm.make_tag "ipv6AddressCount"
                         ([], (Integer.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "ipv6Addresses"
                           ([], (InstanceIpv6AddressList.to_xml [x]))))
                   v.ipv6_addresses))
               @
               [Util.option_map v.private_ip_address
                  (fun f ->
                     Ezxmlm.make_tag "privateIpAddress"
                       ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "privateIpAddresses"
                         ([], (PrivateIpAddressSpecificationList.to_xml [x]))))
                 v.private_ip_addresses))
             @
             [Util.option_map v.secondary_private_ip_address_count
                (fun f ->
                   Ezxmlm.make_tag "secondaryPrivateIpAddressCount"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.interface_type
               (fun f ->
                  Ezxmlm.make_tag "InterfaceType"
                    ([], (NetworkInterfaceCreationType.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "subnetId" ([], (String.to_xml v.subnet_id)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CreateNetworkInterface.</p>"]
module CreateNetworkInterfaceResult = CreateNetworkInterfaceResult
type input = CreateNetworkInterfaceRequest.t
type output = CreateNetworkInterfaceResult.t
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
         ("Action", ["CreateNetworkInterface"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateNetworkInterfaceRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateNetworkInterfaceRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateNetworkInterfaceResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateNetworkInterfaceResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateNetworkInterfaceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateNetworkInterfaceResult - missing field in body or children: "
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