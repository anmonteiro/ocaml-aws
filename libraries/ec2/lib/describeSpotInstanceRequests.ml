open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSpotInstanceRequestsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>availability-zone-group</code> - The Availability Zone group.</p> </li> <li> <p> <code>create-time</code> - The time stamp when the Spot Instance request was created.</p> </li> <li> <p> <code>fault-code</code> - The fault code related to the request.</p> </li> <li> <p> <code>fault-message</code> - The fault message related to the request.</p> </li> <li> <p> <code>instance-id</code> - The ID of the instance that fulfilled the request.</p> </li> <li> <p> <code>launch-group</code> - The Spot Instance launch group.</p> </li> <li> <p> <code>launch.block-device-mapping.delete-on-termination</code> - Indicates whether the EBS volume is deleted on instance termination.</p> </li> <li> <p> <code>launch.block-device-mapping.device-name</code> - The device name for the volume in the block device mapping (for example, <code>/dev/sdh</code> or <code>xvdh</code>).</p> </li> <li> <p> <code>launch.block-device-mapping.snapshot-id</code> - The ID of the snapshot for the EBS volume.</p> </li> <li> <p> <code>launch.block-device-mapping.volume-size</code> - The size of the EBS volume, in GiB.</p> </li> <li> <p> <code>launch.block-device-mapping.volume-type</code> - The type of EBS volume: <code>gp2</code> for General Purpose SSD, <code>io1</code> for Provisioned IOPS SSD, <code>st1</code> for Throughput Optimized HDD, <code>sc1</code>for Cold HDD, or <code>standard</code> for Magnetic.</p> </li> <li> <p> <code>launch.group-id</code> - The ID of the security group for the instance.</p> </li> <li> <p> <code>launch.group-name</code> - The name of the security group for the instance.</p> </li> <li> <p> <code>launch.image-id</code> - The ID of the AMI.</p> </li> <li> <p> <code>launch.instance-type</code> - The type of instance (for example, <code>m3.medium</code>).</p> </li> <li> <p> <code>launch.kernel-id</code> - The kernel ID.</p> </li> <li> <p> <code>launch.key-name</code> - The name of the key pair the instance launched with.</p> </li> <li> <p> <code>launch.monitoring-enabled</code> - Whether detailed monitoring is enabled for the Spot Instance.</p> </li> <li> <p> <code>launch.ramdisk-id</code> - The RAM disk ID.</p> </li> <li> <p> <code>launched-availability-zone</code> - The Availability Zone in which the request is launched.</p> </li> <li> <p> <code>network-interface.addresses.primary</code> - Indicates whether the IP address is the primary private IP address.</p> </li> <li> <p> <code>network-interface.delete-on-termination</code> - Indicates whether the network interface is deleted when the instance is terminated.</p> </li> <li> <p> <code>network-interface.description</code> - A description of the network interface.</p> </li> <li> <p> <code>network-interface.device-index</code> - The index of the device for the network interface attachment on the instance.</p> </li> <li> <p> <code>network-interface.group-id</code> - The ID of the security group associated with the network interface.</p> </li> <li> <p> <code>network-interface.network-interface-id</code> - The ID of the network interface.</p> </li> <li> <p> <code>network-interface.private-ip-address</code> - The primary private IP address of the network interface.</p> </li> <li> <p> <code>network-interface.subnet-id</code> - The ID of the subnet for the instance.</p> </li> <li> <p> <code>product-description</code> - The product description associated with the instance (<code>Linux/UNIX</code> | <code>Windows</code>).</p> </li> <li> <p> <code>spot-instance-request-id</code> - The Spot Instance request ID.</p> </li> <li> <p> <code>spot-price</code> - The maximum hourly price for any Spot Instance launched to fulfill the request.</p> </li> <li> <p> <code>state</code> - The state of the Spot Instance request (<code>open</code> | <code>active</code> | <code>closed</code> | <code>cancelled</code> | <code>failed</code>). Spot request status information can help you track your Amazon EC2 Spot Instance requests. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-bid-status.html\">Spot Request Status</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p> </li> <li> <p> <code>status-code</code> - The short code describing the most recent evaluation of your Spot Instance request.</p> </li> <li> <p> <code>status-message</code> - The message explaining the status of the Spot Instance request.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>type</code> - The type of Spot Instance request (<code>one-time</code> | <code>persistent</code>).</p> </li> <li> <p> <code>valid-from</code> - The start date of the request.</p> </li> <li> <p> <code>valid-until</code> - The end date of the request.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      spot_instance_request_ids: SpotInstanceRequestIdList.t
        [@ocaml.doc "<p>One or more Spot Instance request IDs.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to request the next set of results. This value is <code>null</code> when there are no more results to return.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. Specify a value between 5 and 1000. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeSpotInstanceRequests.</p>"]
    let make ?(filters= [])  ?dry_run  ?(spot_instance_request_ids= []) 
      ?next_token  ?max_results  () =
      { filters; dry_run; spot_instance_request_ids; next_token; max_results
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some
             (Query.Pair
                ("SpotInstanceRequestId",
                  (SpotInstanceRequestIdList.to_query
                     v.spot_instance_request_ids)));
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
             ("spot_instance_request_ids",
               (SpotInstanceRequestIdList.to_json v.spot_instance_request_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          spot_instance_request_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "SpotInstanceRequestId" xml)
                  SpotInstanceRequestIdList.parse));
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
                       (Ezxmlm.make_tag "Filter"
                          ([], (FilterList.to_xml [x])))) v.filters))
              @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "SpotInstanceRequestId"
                        ([], (SpotInstanceRequestIdList.to_xml [x]))))
                v.spot_instance_request_ids))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeSpotInstanceRequests.</p>"]
module DescribeSpotInstanceRequestsResult =
  DescribeSpotInstanceRequestsResult
type input = DescribeSpotInstanceRequestsRequest.t
type output = DescribeSpotInstanceRequestsResult.t
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
         ("Action", ["DescribeSpotInstanceRequests"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeSpotInstanceRequestsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeSpotInstanceRequestsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeSpotInstanceRequestsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeSpotInstanceRequestsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSpotInstanceRequestsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSpotInstanceRequestsResult - missing field in body or children: "
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