open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeCustomerGatewaysRequest =
  struct
    type t =
      {
      customer_gateway_ids: CustomerGatewayIdStringList.t
        [@ocaml.doc
          "<p>One or more customer gateway IDs.</p> <p>Default: Describes all your customer gateways.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>bgp-asn</code> - The customer gateway's Border Gateway Protocol (BGP) Autonomous System Number (ASN).</p> </li> <li> <p> <code>customer-gateway-id</code> - The ID of the customer gateway.</p> </li> <li> <p> <code>ip-address</code> - The IP address of the customer gateway's Internet-routable external interface.</p> </li> <li> <p> <code>state</code> - The state of the customer gateway (<code>pending</code> | <code>available</code> | <code>deleting</code> | <code>deleted</code>).</p> </li> <li> <p> <code>type</code> - The type of customer gateway. Currently, the only supported type is <code>ipsec.1</code>.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeCustomerGateways.</p>"]
    let make ?(customer_gateway_ids= [])  ?(filters= [])  ?dry_run  () =
      { customer_gateway_ids; filters; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("CustomerGatewayId",
                  (CustomerGatewayIdStringList.to_query
                     v.customer_gateway_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("customer_gateway_ids",
               (CustomerGatewayIdStringList.to_json v.customer_gateway_ids))])
    let parse xml =
      Some
        {
          customer_gateway_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "CustomerGatewayId" xml)
                  CustomerGatewayIdStringList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "CustomerGatewayId"
                        ([], (CustomerGatewayIdStringList.to_xml [x]))))
                v.customer_gateway_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
               v.filters))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeCustomerGateways.</p>"]
module DescribeCustomerGatewaysResult = DescribeCustomerGatewaysResult
type input = DescribeCustomerGatewaysRequest.t
type output = DescribeCustomerGatewaysResult.t
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
         ("Action", ["DescribeCustomerGateways"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeCustomerGatewaysRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeCustomerGatewaysRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeCustomerGatewaysResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeCustomerGatewaysResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeCustomerGatewaysResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeCustomerGatewaysResult - missing field in body or children: "
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