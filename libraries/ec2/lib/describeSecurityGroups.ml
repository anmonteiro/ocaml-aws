open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSecurityGroupsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters. If using multiple filters for rules, the results include security groups for which any combination of rules - not necessarily a single rule - match all filters.</p> <ul> <li> <p> <code>description</code> - The description of the security group.</p> </li> <li> <p> <code>egress.ip-permission.cidr</code> - An IPv4 CIDR block for an outbound security group rule.</p> </li> <li> <p> <code>egress.ip-permission.from-port</code> - For an outbound rule, the start of port range for the TCP and UDP protocols, or an ICMP type number.</p> </li> <li> <p> <code>egress.ip-permission.group-id</code> - The ID of a security group that has been referenced in an outbound security group rule.</p> </li> <li> <p> <code>egress.ip-permission.group-name</code> - The name of a security group that has been referenced in an outbound security group rule.</p> </li> <li> <p> <code>egress.ip-permission.ipv6-cidr</code> - An IPv6 CIDR block for an outbound security group rule.</p> </li> <li> <p> <code>egress.ip-permission.prefix-list-id</code> - The ID (prefix) of the AWS service to which a security group rule allows outbound access.</p> </li> <li> <p> <code>egress.ip-permission.protocol</code> - The IP protocol for an outbound security group rule (<code>tcp</code> | <code>udp</code> | <code>icmp</code> or a protocol number).</p> </li> <li> <p> <code>egress.ip-permission.to-port</code> - For an outbound rule, the end of port range for the TCP and UDP protocols, or an ICMP code.</p> </li> <li> <p> <code>egress.ip-permission.user-id</code> - The ID of an AWS account that has been referenced in an outbound security group rule.</p> </li> <li> <p> <code>group-id</code> - The ID of the security group. </p> </li> <li> <p> <code>group-name</code> - The name of the security group.</p> </li> <li> <p> <code>ip-permission.cidr</code> - An IPv4 CIDR block for an inbound security group rule.</p> </li> <li> <p> <code>ip-permission.from-port</code> - For an inbound rule, the start of port range for the TCP and UDP protocols, or an ICMP type number.</p> </li> <li> <p> <code>ip-permission.group-id</code> - The ID of a security group that has been referenced in an inbound security group rule.</p> </li> <li> <p> <code>ip-permission.group-name</code> - The name of a security group that has been referenced in an inbound security group rule.</p> </li> <li> <p> <code>ip-permission.ipv6-cidr</code> - An IPv6 CIDR block for an inbound security group rule.</p> </li> <li> <p> <code>ip-permission.prefix-list-id</code> - The ID (prefix) of the AWS service from which a security group rule allows inbound access.</p> </li> <li> <p> <code>ip-permission.protocol</code> - The IP protocol for an inbound security group rule (<code>tcp</code> | <code>udp</code> | <code>icmp</code> or a protocol number).</p> </li> <li> <p> <code>ip-permission.to-port</code> - For an inbound rule, the end of port range for the TCP and UDP protocols, or an ICMP code.</p> </li> <li> <p> <code>ip-permission.user-id</code> - The ID of an AWS account that has been referenced in an inbound security group rule.</p> </li> <li> <p> <code>owner-id</code> - The AWS account ID of the owner of the security group.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>vpc-id</code> - The ID of the VPC specified when the security group was created.</p> </li> </ul>"];
      group_ids: GroupIdStringList.t
        [@ocaml.doc
          "<p>The IDs of the security groups. Required for security groups in a nondefault VPC.</p> <p>Default: Describes all your security groups.</p>"];
      group_names: GroupNameStringList.t
        [@ocaml.doc
          "<p>[EC2-Classic and default VPC only] The names of the security groups. You can specify either the security group name or the security group ID. For security groups in a nondefault VPC, use the <code>group-name</code> filter to describe security groups by name.</p> <p>Default: Describes all your security groups.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to request the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. To retrieve the remaining results, make another request with the returned <code>NextToken</code> value. This value can be between 5 and 1000. If this parameter is not specified, then all results are returned.</p>"]}
    let make ?(filters= [])  ?(group_ids= [])  ?(group_names= [])  ?dry_run 
      ?next_token  ?max_results  () =
      { filters; group_ids; group_names; dry_run; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("GroupName", (GroupNameStringList.to_query v.group_names)));
           Some
             (Query.Pair
                ("GroupId", (GroupIdStringList.to_query v.group_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("group_names", (GroupNameStringList.to_json v.group_names));
           Some ("group_ids", (GroupIdStringList.to_json v.group_ids));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "GroupId" xml)
                  GroupIdStringList.parse));
          group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "GroupName" xml)
                  GroupNameStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "Filter"
                           ([], (FilterList.to_xml [x])))) v.filters))
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "GroupId"
                          ([], (GroupIdStringList.to_xml [x])))) v.group_ids))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "GroupName"
                         ([], (GroupNameStringList.to_xml [x]))))
                 v.group_names))
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end
module DescribeSecurityGroupsResult = DescribeSecurityGroupsResult
type input = DescribeSecurityGroupsRequest.t
type output = DescribeSecurityGroupsResult.t
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
         ("Action", ["DescribeSecurityGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeSecurityGroupsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeSecurityGroupsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeSecurityGroupsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeSecurityGroupsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSecurityGroupsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSecurityGroupsResult - missing field in body or children: "
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