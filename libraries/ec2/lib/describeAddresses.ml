open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAddressesRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters. Filter names and values are case-sensitive.</p> <ul> <li> <p> <code>allocation-id</code> - [EC2-VPC] The allocation ID for the address.</p> </li> <li> <p> <code>association-id</code> - [EC2-VPC] The association ID for the address.</p> </li> <li> <p> <code>domain</code> - Indicates whether the address is for use in EC2-Classic (<code>standard</code>) or in a VPC (<code>vpc</code>).</p> </li> <li> <p> <code>instance-id</code> - The ID of the instance the address is associated with, if any.</p> </li> <li> <p> <code>network-border-group</code> - The location from where the IP address is advertised.</p> </li> <li> <p> <code>network-interface-id</code> - [EC2-VPC] The ID of the network interface that the address is associated with, if any.</p> </li> <li> <p> <code>network-interface-owner-id</code> - The AWS account ID of the owner.</p> </li> <li> <p> <code>private-ip-address</code> - [EC2-VPC] The private IP address associated with the Elastic IP address.</p> </li> <li> <p> <code>public-ip</code> - The Elastic IP address.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      public_ips: PublicIpStringList.t
        [@ocaml.doc
          "<p>One or more Elastic IP addresses.</p> <p>Default: Describes all your Elastic IP addresses.</p>"];
      allocation_ids: AllocationIdList.t
        [@ocaml.doc "<p>[EC2-VPC] Information about the allocation IDs.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(filters= [])  ?(public_ips= [])  ?(allocation_ids= []) 
      ?dry_run  () = { filters; public_ips; allocation_ids; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("AllocationId",
                  (AllocationIdList.to_query v.allocation_ids)));
           Some
             (Query.Pair
                ("PublicIp", (PublicIpStringList.to_query v.public_ips)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("allocation_ids", (AllocationIdList.to_json v.allocation_ids));
           Some ("public_ips", (PublicIpStringList.to_json v.public_ips));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          public_ips =
            (Util.of_option []
               (Util.option_bind (Xml.member "PublicIp" xml)
                  PublicIpStringList.parse));
          allocation_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "AllocationId" xml)
                  AllocationIdList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "PublicIp"
                        ([], (PublicIpStringList.to_xml [x])))) v.public_ips))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AllocationId"
                       ([], (AllocationIdList.to_xml [x])))) v.allocation_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeAddressesResult = DescribeAddressesResult
type input = DescribeAddressesRequest.t
type output = DescribeAddressesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeAddresses"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeAddressesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeAddressesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeAddressesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeAddressesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeAddressesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeAddressesResult - missing field in body or children: "
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