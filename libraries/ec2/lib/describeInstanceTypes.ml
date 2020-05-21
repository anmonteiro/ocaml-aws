open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeInstanceTypesRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_types: RequestInstanceTypeList.t
        [@ocaml.doc
          "<p>The instance types. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters. Filter names and values are case-sensitive.</p> <ul> <li> <p> <code>auto-recovery-supported</code> - Indicates whether auto recovery is supported. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>bare-metal</code> - Indicates whether it is a bare metal instance type. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>burstable-performance-supported</code> - Indicates whether it is a burstable performance instance type. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>current-generation</code> - Indicates whether this instance type is the latest generation instance type of an instance family. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>ebs-info.ebs-optimized-support</code> - Indicates whether the instance type is EBS-optimized. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>ebs-info.encryption-support</code> - Indicates whether EBS encryption is supported. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>free-tier-eligible</code> - Indicates whether the instance type is eligible to use in the free tier. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>hibernation-supported</code> - Indicates whether On-Demand hibernation is supported. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>hypervisor</code> - The hypervisor used. (<code>nitro</code> | <code>xen</code>)</p> </li> <li> <p> <code>instance-storage-info.disk.count</code> - The number of local disks.</p> </li> <li> <p> <code>instance-storage-info.disk.size-in-gb</code> - The storage size of each instance storage disk, in GB.</p> </li> <li> <p> <code>instance-storage-info.disk.type</code> - The storage technology for the local instance storage disks. (<code>hdd</code> | <code>ssd</code>)</p> </li> <li> <p> <code>instance-storage-info.total-size-in-gb</code> - The total amount of storage available from all local instance storage, in GB.</p> </li> <li> <p> <code>instance-storage-supported</code> - Indicates whether the instance type has local instance storage. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>memory-info.size-in-mib</code> - The memory size.</p> </li> <li> <p> <code>network-info.ena-support</code> - Indicates whether Elastic Network Adapter (ENA) is supported or required. (<code>required</code> | <code>supported</code> | <code>unsupported</code>)</p> </li> <li> <p> <code>network-info.ipv4-addresses-per-interface</code> - The maximum number of private IPv4 addresses per network interface.</p> </li> <li> <p> <code>network-info.ipv6-addresses-per-interface</code> - The maximum number of private IPv6 addresses per network interface.</p> </li> <li> <p> <code>network-info.ipv6-supported</code> - Indicates whether the instance type supports IPv6. (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>network-info.maximum-network-interfaces</code> - The maximum number of network interfaces per instance.</p> </li> <li> <p> <code>network-info.network-performance</code> - Describes the network performance.</p> </li> <li> <p> <code>processor-info.sustained-clock-speed-in-ghz</code> - The CPU clock speed, in GHz.</p> </li> <li> <p> <code>vcpu-info.default-cores</code> - The default number of cores for the instance type.</p> </li> <li> <p> <code>vcpu-info.default-threads-per-core</code> - The default number of threads per cores for the instance type.</p> </li> <li> <p> <code>vcpu-info.default-vcpus</code> - The default number of vCPUs for the instance type.</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results can be seen by sending another request with the next token value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"]}
    let make ?dry_run  ?(instance_types= [])  ?(filters= [])  ?max_results 
      ?next_token  () =
      { dry_run; instance_types; filters; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("InstanceType",
                  (RequestInstanceTypeList.to_query v.instance_types)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("instance_types",
               (RequestInstanceTypeList.to_json v.instance_types));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          instance_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceType" xml)
                  RequestInstanceTypeList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "InstanceType"
                         ([], (RequestInstanceTypeList.to_xml [x]))))
                 v.instance_types))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeInstanceTypesResult = DescribeInstanceTypesResult
type input = DescribeInstanceTypesRequest.t
type output = DescribeInstanceTypesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeInstanceTypes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeInstanceTypesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeInstanceTypesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeInstanceTypesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeInstanceTypesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeInstanceTypesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeInstanceTypesResult - missing field in body or children: "
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