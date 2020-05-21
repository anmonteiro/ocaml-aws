open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeNatGatewaysRequest =
  struct
    type t =
      {
      filter: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>nat-gateway-id</code> - The ID of the NAT gateway.</p> </li> <li> <p> <code>state</code> - The state of the NAT gateway (<code>pending</code> | <code>failed</code> | <code>available</code> | <code>deleting</code> | <code>deleted</code>).</p> </li> <li> <p> <code>subnet-id</code> - The ID of the subnet in which the NAT gateway resides.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>vpc-id</code> - The ID of the VPC in which the NAT gateway resides.</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"];
      nat_gateway_ids: ValueStringList.t
        [@ocaml.doc "<p>One or more NAT gateway IDs.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"]}
    let make ?(filter= [])  ?max_results  ?(nat_gateway_ids= [])  ?next_token
       () = { filter; max_results; nat_gateway_ids; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some
             (Query.Pair
                ("NatGatewayId",
                  (ValueStringList.to_query v.nat_gateway_ids)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filter)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("nat_gateway_ids", (ValueStringList.to_json v.nat_gateway_ids));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filter", (FilterList.to_json v.filter))])
    let parse xml =
      Some
        {
          filter =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          nat_gateway_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "NatGatewayId" xml)
                  ValueStringList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filter))
             @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "NatGatewayId"
                       ([], (ValueStringList.to_xml [x])))) v.nat_gateway_ids))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeNatGatewaysResult = DescribeNatGatewaysResult
type input = DescribeNatGatewaysRequest.t
type output = DescribeNatGatewaysResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeNatGateways"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeNatGatewaysRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeNatGatewaysRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeNatGatewaysResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeNatGatewaysResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeNatGatewaysResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeNatGatewaysResult - missing field in body or children: "
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