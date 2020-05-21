open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeInstancesRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>affinity</code> - The affinity setting for an instance running on a Dedicated Host (<code>default</code> | <code>host</code>).</p> </li> <li> <p> <code>architecture</code> - The instance architecture (<code>i386</code> | <code>x86_64</code> | <code>arm64</code>).</p> </li> <li> <p> <code>availability-zone</code> - The Availability Zone of the instance.</p> </li> <li> <p> <code>block-device-mapping.attach-time</code> - The attach time for an EBS volume mapped to the instance, for example, <code>2010-09-15T17:15:20.000Z</code>.</p> </li> <li> <p> <code>block-device-mapping.delete-on-termination</code> - A Boolean that indicates whether the EBS volume is deleted on instance termination.</p> </li> <li> <p> <code>block-device-mapping.device-name</code> - The device name specified in the block device mapping (for example, <code>/dev/sdh</code> or <code>xvdh</code>).</p> </li> <li> <p> <code>block-device-mapping.status</code> - The status for the EBS volume (<code>attaching</code> | <code>attached</code> | <code>detaching</code> | <code>detached</code>).</p> </li> <li> <p> <code>block-device-mapping.volume-id</code> - The volume ID of the EBS volume.</p> </li> <li> <p> <code>client-token</code> - The idempotency token you provided when you launched the instance.</p> </li> <li> <p> <code>dns-name</code> - The public DNS name of the instance.</p> </li> <li> <p> <code>group-id</code> - The ID of the security group for the instance. EC2-Classic only.</p> </li> <li> <p> <code>group-name</code> - The name of the security group for the instance. EC2-Classic only.</p> </li> <li> <p> <code>hibernation-options.configured</code> - A Boolean that indicates whether the instance is enabled for hibernation. A value of <code>true</code> means that the instance is enabled for hibernation. </p> </li> <li> <p> <code>host-id</code> - The ID of the Dedicated Host on which the instance is running, if applicable.</p> </li> <li> <p> <code>hypervisor</code> - The hypervisor type of the instance (<code>ovm</code> | <code>xen</code>).</p> </li> <li> <p> <code>iam-instance-profile.arn</code> - The instance profile associated with the instance. Specified as an ARN.</p> </li> <li> <p> <code>image-id</code> - The ID of the image used to launch the instance.</p> </li> <li> <p> <code>instance-id</code> - The ID of the instance.</p> </li> <li> <p> <code>instance-lifecycle</code> - Indicates whether this is a Spot Instance or a Scheduled Instance (<code>spot</code> | <code>scheduled</code>).</p> </li> <li> <p> <code>instance-state-code</code> - The state of the instance, as a 16-bit unsigned integer. The high byte is used for internal purposes and should be ignored. The low byte is set based on the state represented. The valid values are: 0 (pending), 16 (running), 32 (shutting-down), 48 (terminated), 64 (stopping), and 80 (stopped).</p> </li> <li> <p> <code>instance-state-name</code> - The state of the instance (<code>pending</code> | <code>running</code> | <code>shutting-down</code> | <code>terminated</code> | <code>stopping</code> | <code>stopped</code>).</p> </li> <li> <p> <code>instance-type</code> - The type of instance (for example, <code>t2.micro</code>).</p> </li> <li> <p> <code>instance.group-id</code> - The ID of the security group for the instance. </p> </li> <li> <p> <code>instance.group-name</code> - The name of the security group for the instance. </p> </li> <li> <p> <code>ip-address</code> - The public IPv4 address of the instance.</p> </li> <li> <p> <code>kernel-id</code> - The kernel ID.</p> </li> <li> <p> <code>key-name</code> - The name of the key pair used when the instance was launched.</p> </li> <li> <p> <code>launch-index</code> - When launching multiple instances, this is the index for the instance in the launch group (for example, 0, 1, 2, and so on). </p> </li> <li> <p> <code>launch-time</code> - The time when the instance was launched.</p> </li> <li> <p> <code>metadata-options.http-tokens</code> - The metadata request authorization state (<code>optional</code> | <code>required</code>)</p> </li> <li> <p> <code>metadata-options.http-put-response-hop-limit</code> - The http metadata request put response hop limit (integer, possible values <code>1</code> to <code>64</code>)</p> </li> <li> <p> <code>metadata-options.http-endpoint</code> - Enable or disable metadata access on http endpoint (<code>enabled</code> | <code>disabled</code>)</p> </li> <li> <p> <code>monitoring-state</code> - Indicates whether detailed monitoring is enabled (<code>disabled</code> | <code>enabled</code>).</p> </li> <li> <p> <code>network-interface.addresses.private-ip-address</code> - The private IPv4 address associated with the network interface.</p> </li> <li> <p> <code>network-interface.addresses.primary</code> - Specifies whether the IPv4 address of the network interface is the primary private IPv4 address.</p> </li> <li> <p> <code>network-interface.addresses.association.public-ip</code> - The ID of the association of an Elastic IP address (IPv4) with a network interface.</p> </li> <li> <p> <code>network-interface.addresses.association.ip-owner-id</code> - The owner ID of the private IPv4 address associated with the network interface.</p> </li> <li> <p> <code>network-interface.association.public-ip</code> - The address of the Elastic IP address (IPv4) bound to the network interface.</p> </li> <li> <p> <code>network-interface.association.ip-owner-id</code> - The owner of the Elastic IP address (IPv4) associated with the network interface.</p> </li> <li> <p> <code>network-interface.association.allocation-id</code> - The allocation ID returned when you allocated the Elastic IP address (IPv4) for your network interface.</p> </li> <li> <p> <code>network-interface.association.association-id</code> - The association ID returned when the network interface was associated with an IPv4 address.</p> </li> <li> <p> <code>network-interface.attachment.attachment-id</code> - The ID of the interface attachment.</p> </li> <li> <p> <code>network-interface.attachment.instance-id</code> - The ID of the instance to which the network interface is attached.</p> </li> <li> <p> <code>network-interface.attachment.instance-owner-id</code> - The owner ID of the instance to which the network interface is attached.</p> </li> <li> <p> <code>network-interface.attachment.device-index</code> - The device index to which the network interface is attached.</p> </li> <li> <p> <code>network-interface.attachment.status</code> - The status of the attachment (<code>attaching</code> | <code>attached</code> | <code>detaching</code> | <code>detached</code>).</p> </li> <li> <p> <code>network-interface.attachment.attach-time</code> - The time that the network interface was attached to an instance.</p> </li> <li> <p> <code>network-interface.attachment.delete-on-termination</code> - Specifies whether the attachment is deleted when an instance is terminated.</p> </li> <li> <p> <code>network-interface.availability-zone</code> - The Availability Zone for the network interface.</p> </li> <li> <p> <code>network-interface.description</code> - The description of the network interface.</p> </li> <li> <p> <code>network-interface.group-id</code> - The ID of a security group associated with the network interface.</p> </li> <li> <p> <code>network-interface.group-name</code> - The name of a security group associated with the network interface.</p> </li> <li> <p> <code>network-interface.ipv6-addresses.ipv6-address</code> - The IPv6 address associated with the network interface.</p> </li> <li> <p> <code>network-interface.mac-address</code> - The MAC address of the network interface.</p> </li> <li> <p> <code>network-interface.network-interface-id</code> - The ID of the network interface.</p> </li> <li> <p> <code>network-interface.owner-id</code> - The ID of the owner of the network interface.</p> </li> <li> <p> <code>network-interface.private-dns-name</code> - The private DNS name of the network interface.</p> </li> <li> <p> <code>network-interface.requester-id</code> - The requester ID for the network interface.</p> </li> <li> <p> <code>network-interface.requester-managed</code> - Indicates whether the network interface is being managed by AWS.</p> </li> <li> <p> <code>network-interface.status</code> - The status of the network interface (<code>available</code>) | <code>in-use</code>).</p> </li> <li> <p> <code>network-interface.source-dest-check</code> - Whether the network interface performs source/destination checking. A value of <code>true</code> means that checking is enabled, and <code>false</code> means that checking is disabled. The value must be <code>false</code> for the network interface to perform network address translation (NAT) in your VPC.</p> </li> <li> <p> <code>network-interface.subnet-id</code> - The ID of the subnet for the network interface.</p> </li> <li> <p> <code>network-interface.vpc-id</code> - The ID of the VPC for the network interface.</p> </li> <li> <p> <code>owner-id</code> - The AWS account ID of the instance owner.</p> </li> <li> <p> <code>placement-group-name</code> - The name of the placement group for the instance.</p> </li> <li> <p> <code>placement-partition-number</code> - The partition in which the instance is located.</p> </li> <li> <p> <code>platform</code> - The platform. To list only Windows instances, use <code>windows</code>.</p> </li> <li> <p> <code>private-dns-name</code> - The private IPv4 DNS name of the instance.</p> </li> <li> <p> <code>private-ip-address</code> - The private IPv4 address of the instance.</p> </li> <li> <p> <code>product-code</code> - The product code associated with the AMI used to launch the instance.</p> </li> <li> <p> <code>product-code.type</code> - The type of product code (<code>devpay</code> | <code>marketplace</code>).</p> </li> <li> <p> <code>ramdisk-id</code> - The RAM disk ID.</p> </li> <li> <p> <code>reason</code> - The reason for the current state of the instance (for example, shows \"User Initiated [date]\" when you stop or terminate the instance). Similar to the state-reason-code filter.</p> </li> <li> <p> <code>requester-id</code> - The ID of the entity that launched the instance on your behalf (for example, AWS Management Console, Auto Scaling, and so on).</p> </li> <li> <p> <code>reservation-id</code> - The ID of the instance's reservation. A reservation ID is created any time you launch an instance. A reservation ID has a one-to-one relationship with an instance launch request, but can be associated with more than one instance if you launch multiple instances using the same launch request. For example, if you launch one instance, you get one reservation ID. If you launch ten instances using the same launch request, you also get one reservation ID.</p> </li> <li> <p> <code>root-device-name</code> - The device name of the root device volume (for example, <code>/dev/sda1</code>).</p> </li> <li> <p> <code>root-device-type</code> - The type of the root device volume (<code>ebs</code> | <code>instance-store</code>).</p> </li> <li> <p> <code>source-dest-check</code> - Indicates whether the instance performs source/destination checking. A value of <code>true</code> means that checking is enabled, and <code>false</code> means that checking is disabled. The value must be <code>false</code> for the instance to perform network address translation (NAT) in your VPC. </p> </li> <li> <p> <code>spot-instance-request-id</code> - The ID of the Spot Instance request.</p> </li> <li> <p> <code>state-reason-code</code> - The reason code for the state change.</p> </li> <li> <p> <code>state-reason-message</code> - A message that describes the state change.</p> </li> <li> <p> <code>subnet-id</code> - The ID of the subnet for the instance.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources that have a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>tenancy</code> - The tenancy of an instance (<code>dedicated</code> | <code>default</code> | <code>host</code>).</p> </li> <li> <p> <code>virtualization-type</code> - The virtualization type of the instance (<code>paravirtual</code> | <code>hvm</code>).</p> </li> <li> <p> <code>vpc-id</code> - The ID of the VPC that the instance is running in.</p> </li> </ul>"];
      instance_ids: InstanceIdStringList.t
        [@ocaml.doc
          "<p>The instance IDs.</p> <p>Default: Describes all your instances.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value. This value can be between 5 and 1000. You cannot specify this parameter and the instance IDs parameter in the same call.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to request the next page of results.</p>"]}
    let make ?(filters= [])  ?(instance_ids= [])  ?dry_run  ?max_results 
      ?next_token  () =
      { filters; instance_ids; dry_run; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("InstanceId",
                  (InstanceIdStringList.to_query v.instance_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("instance_ids", (InstanceIdStringList.to_json v.instance_ids));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          instance_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceId" xml)
                  InstanceIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Filter"
                          ([], (FilterList.to_xml [x])))) v.filters))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "InstanceId"
                         ([], (InstanceIdStringList.to_xml [x]))))
                 v.instance_ids))
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
  end
module DescribeInstancesResult = DescribeInstancesResult
type input = DescribeInstancesRequest.t
type output = DescribeInstancesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeInstancesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeInstancesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeInstancesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeInstancesResult - missing field in body or children: "
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