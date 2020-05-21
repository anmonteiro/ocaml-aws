open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeNetworkInterfacesRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>addresses.private-ip-address</code> - The private IPv4 addresses associated with the network interface.</p> </li> <li> <p> <code>addresses.primary</code> - Whether the private IPv4 address is the primary IP address associated with the network interface. </p> </li> <li> <p> <code>addresses.association.public-ip</code> - The association ID returned when the network interface was associated with the Elastic IP address (IPv4).</p> </li> <li> <p> <code>addresses.association.owner-id</code> - The owner ID of the addresses associated with the network interface.</p> </li> <li> <p> <code>association.association-id</code> - The association ID returned when the network interface was associated with an IPv4 address.</p> </li> <li> <p> <code>association.allocation-id</code> - The allocation ID returned when you allocated the Elastic IP address (IPv4) for your network interface.</p> </li> <li> <p> <code>association.ip-owner-id</code> - The owner of the Elastic IP address (IPv4) associated with the network interface.</p> </li> <li> <p> <code>association.public-ip</code> - The address of the Elastic IP address (IPv4) bound to the network interface.</p> </li> <li> <p> <code>association.public-dns-name</code> - The public DNS name for the network interface (IPv4).</p> </li> <li> <p> <code>attachment.attachment-id</code> - The ID of the interface attachment.</p> </li> <li> <p> <code>attachment.attach-time</code> - The time that the network interface was attached to an instance.</p> </li> <li> <p> <code>attachment.delete-on-termination</code> - Indicates whether the attachment is deleted when an instance is terminated.</p> </li> <li> <p> <code>attachment.device-index</code> - The device index to which the network interface is attached.</p> </li> <li> <p> <code>attachment.instance-id</code> - The ID of the instance to which the network interface is attached.</p> </li> <li> <p> <code>attachment.instance-owner-id</code> - The owner ID of the instance to which the network interface is attached.</p> </li> <li> <p> <code>attachment.nat-gateway-id</code> - The ID of the NAT gateway to which the network interface is attached.</p> </li> <li> <p> <code>attachment.status</code> - The status of the attachment (<code>attaching</code> | <code>attached</code> | <code>detaching</code> | <code>detached</code>).</p> </li> <li> <p> <code>availability-zone</code> - The Availability Zone of the network interface.</p> </li> <li> <p> <code>description</code> - The description of the network interface.</p> </li> <li> <p> <code>group-id</code> - The ID of a security group associated with the network interface.</p> </li> <li> <p> <code>group-name</code> - The name of a security group associated with the network interface.</p> </li> <li> <p> <code>ipv6-addresses.ipv6-address</code> - An IPv6 address associated with the network interface.</p> </li> <li> <p> <code>mac-address</code> - The MAC address of the network interface.</p> </li> <li> <p> <code>network-interface-id</code> - The ID of the network interface.</p> </li> <li> <p> <code>owner-id</code> - The AWS account ID of the network interface owner.</p> </li> <li> <p> <code>private-ip-address</code> - The private IPv4 address or addresses of the network interface.</p> </li> <li> <p> <code>private-dns-name</code> - The private DNS name of the network interface (IPv4).</p> </li> <li> <p> <code>requester-id</code> - The ID of the entity that launched the instance on your behalf (for example, AWS Management Console, Auto Scaling, and so on).</p> </li> <li> <p> <code>requester-managed</code> - Indicates whether the network interface is being managed by an AWS service (for example, AWS Management Console, Auto Scaling, and so on).</p> </li> <li> <p> <code>source-dest-check</code> - Indicates whether the network interface performs source/destination checking. A value of <code>true</code> means checking is enabled, and <code>false</code> means checking is disabled. The value must be <code>false</code> for the network interface to perform network address translation (NAT) in your VPC. </p> </li> <li> <p> <code>status</code> - The status of the network interface. If the network interface is not attached to an instance, the status is <code>available</code>; if a network interface is attached to an instance the status is <code>in-use</code>.</p> </li> <li> <p> <code>subnet-id</code> - The ID of the subnet for the network interface.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>vpc-id</code> - The ID of the VPC for the network interface.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      network_interface_ids: NetworkInterfaceIdList.t
        [@ocaml.doc
          "<p>One or more network interface IDs.</p> <p>Default: Describes all your network interfaces.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this request. The request returns a token that you can specify in a subsequent call to get the next set of results. You cannot specify this parameter and the network interface IDs parameter in the same request.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeNetworkInterfaces.</p>"]
    let make ?(filters= [])  ?dry_run  ?(network_interface_ids= []) 
      ?next_token  ?max_results  () =
      { filters; dry_run; network_interface_ids; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some
             (Query.Pair
                ("NetworkInterfaceId",
                  (NetworkInterfaceIdList.to_query v.network_interface_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("network_interface_ids",
               (NetworkInterfaceIdList.to_json v.network_interface_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          network_interface_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "NetworkInterfaceId" xml)
                  NetworkInterfaceIdList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "filter"
                          ([], (FilterList.to_xml [x])))) v.filters))
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "NetworkInterfaceId"
                        ([], (NetworkInterfaceIdList.to_xml [x]))))
                v.network_interface_ids))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeNetworkInterfaces.</p>"]
module DescribeNetworkInterfacesResult = DescribeNetworkInterfacesResult
type input = DescribeNetworkInterfacesRequest.t
type output = DescribeNetworkInterfacesResult.t
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
         ("Action", ["DescribeNetworkInterfaces"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeNetworkInterfacesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeNetworkInterfacesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeNetworkInterfacesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeNetworkInterfacesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeNetworkInterfacesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeNetworkInterfacesResult - missing field in body or children: "
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