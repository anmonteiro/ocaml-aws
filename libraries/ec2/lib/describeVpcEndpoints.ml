open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVpcEndpointsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      vpc_endpoint_ids: ValueStringList.t
        [@ocaml.doc "<p>One or more endpoint IDs.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>service-name</code>: The name of the service.</p> </li> <li> <p> <code>vpc-id</code>: The ID of the VPC in which the endpoint resides.</p> </li> <li> <p> <code>vpc-endpoint-id</code>: The ID of the endpoint.</p> </li> <li> <p> <code>vpc-endpoint-state</code> - The state of the endpoint (<code>pendingAcceptance</code> | <code>pending</code> | <code>available</code> | <code>deleting</code> | <code>deleted</code> | <code>rejected</code> | <code>failed</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this request. The request returns a token that you can specify in a subsequent call to get the next set of results.</p> <p>Constraint: If the value is greater than 1000, we return only 1000 items.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a prior call.)</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for DescribeVpcEndpoints.</p>"]
    let make ?dry_run  ?(vpc_endpoint_ids= [])  ?(filters= [])  ?max_results 
      ?next_token  () =
      { dry_run; vpc_endpoint_ids; filters; max_results; next_token }
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
                ("VpcEndpointId",
                  (ValueStringList.to_query v.vpc_endpoint_ids)));
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
             ("vpc_endpoint_ids",
               (ValueStringList.to_json v.vpc_endpoint_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          vpc_endpoint_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcEndpointId" xml)
                  ValueStringList.parse));
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
                      (Ezxmlm.make_tag "VpcEndpointId"
                         ([], (ValueStringList.to_xml [x]))))
                 v.vpc_endpoint_ids))
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
  end[@@ocaml.doc "<p>Contains the parameters for DescribeVpcEndpoints.</p>"]
module DescribeVpcEndpointsResult = DescribeVpcEndpointsResult
type input = DescribeVpcEndpointsRequest.t
type output = DescribeVpcEndpointsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeVpcEndpoints"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeVpcEndpointsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeVpcEndpointsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeVpcEndpointsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeVpcEndpointsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeVpcEndpointsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVpcEndpointsResult - missing field in body or children: "
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