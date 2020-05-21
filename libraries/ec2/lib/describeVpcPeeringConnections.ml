open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVpcPeeringConnectionsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>accepter-vpc-info.cidr-block</code> - The IPv4 CIDR block of the accepter VPC.</p> </li> <li> <p> <code>accepter-vpc-info.owner-id</code> - The AWS account ID of the owner of the accepter VPC.</p> </li> <li> <p> <code>accepter-vpc-info.vpc-id</code> - The ID of the accepter VPC.</p> </li> <li> <p> <code>expiration-time</code> - The expiration date and time for the VPC peering connection.</p> </li> <li> <p> <code>requester-vpc-info.cidr-block</code> - The IPv4 CIDR block of the requester's VPC.</p> </li> <li> <p> <code>requester-vpc-info.owner-id</code> - The AWS account ID of the owner of the requester VPC.</p> </li> <li> <p> <code>requester-vpc-info.vpc-id</code> - The ID of the requester VPC.</p> </li> <li> <p> <code>status-code</code> - The status of the VPC peering connection (<code>pending-acceptance</code> | <code>failed</code> | <code>expired</code> | <code>provisioning</code> | <code>active</code> | <code>deleting</code> | <code>deleted</code> | <code>rejected</code>).</p> </li> <li> <p> <code>status-message</code> - A message that provides more information about the status of the VPC peering connection, if applicable.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>vpc-peering-connection-id</code> - The ID of the VPC peering connection.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      vpc_peering_connection_ids: ValueStringList.t
        [@ocaml.doc
          "<p>One or more VPC peering connection IDs.</p> <p>Default: Describes all your VPC peering connections.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"]}
    let make ?(filters= [])  ?dry_run  ?(vpc_peering_connection_ids= []) 
      ?next_token  ?max_results  () =
      { filters; dry_run; vpc_peering_connection_ids; next_token; max_results
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
                ("VpcPeeringConnectionId",
                  (ValueStringList.to_query v.vpc_peering_connection_ids)));
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
             ("vpc_peering_connection_ids",
               (ValueStringList.to_json v.vpc_peering_connection_ids));
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
          vpc_peering_connection_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcPeeringConnectionId" xml)
                  ValueStringList.parse));
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
                     (Ezxmlm.make_tag "VpcPeeringConnectionId"
                        ([], (ValueStringList.to_xml [x]))))
                v.vpc_peering_connection_ids))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end
module DescribeVpcPeeringConnectionsResult =
  DescribeVpcPeeringConnectionsResult
type input = DescribeVpcPeeringConnectionsRequest.t
type output = DescribeVpcPeeringConnectionsResult.t
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
         ("Action", ["DescribeVpcPeeringConnections"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeVpcPeeringConnectionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeVpcPeeringConnectionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeVpcPeeringConnectionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeVpcPeeringConnectionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeVpcPeeringConnectionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVpcPeeringConnectionsResult - missing field in body or children: "
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