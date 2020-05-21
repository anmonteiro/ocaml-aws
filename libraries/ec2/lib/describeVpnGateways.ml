open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVpnGatewaysRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>amazon-side-asn</code> - The Autonomous System Number (ASN) for the Amazon side of the gateway.</p> </li> <li> <p> <code>attachment.state</code> - The current state of the attachment between the gateway and the VPC (<code>attaching</code> | <code>attached</code> | <code>detaching</code> | <code>detached</code>).</p> </li> <li> <p> <code>attachment.vpc-id</code> - The ID of an attached VPC.</p> </li> <li> <p> <code>availability-zone</code> - The Availability Zone for the virtual private gateway (if applicable).</p> </li> <li> <p> <code>state</code> - The state of the virtual private gateway (<code>pending</code> | <code>available</code> | <code>deleting</code> | <code>deleted</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>type</code> - The type of virtual private gateway. Currently the only supported type is <code>ipsec.1</code>.</p> </li> <li> <p> <code>vpn-gateway-id</code> - The ID of the virtual private gateway.</p> </li> </ul>"];
      vpn_gateway_ids: VpnGatewayIdStringList.t
        [@ocaml.doc
          "<p>One or more virtual private gateway IDs.</p> <p>Default: Describes all your virtual private gateways.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for DescribeVpnGateways.</p>"]
    let make ?(filters= [])  ?(vpn_gateway_ids= [])  ?dry_run  () =
      { filters; vpn_gateway_ids; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("VpnGatewayId",
                  (VpnGatewayIdStringList.to_query v.vpn_gateway_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("vpn_gateway_ids",
               (VpnGatewayIdStringList.to_json v.vpn_gateway_ids));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          vpn_gateway_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpnGatewayId" xml)
                  VpnGatewayIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "VpnGatewayId"
                       ([], (VpnGatewayIdStringList.to_xml [x]))))
               v.vpn_gateway_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for DescribeVpnGateways.</p>"]
module DescribeVpnGatewaysResult = DescribeVpnGatewaysResult
type input = DescribeVpnGatewaysRequest.t
type output = DescribeVpnGatewaysResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeVpnGateways"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeVpnGatewaysRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeVpnGatewaysRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeVpnGatewaysResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeVpnGatewaysResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeVpnGatewaysResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVpnGatewaysResult - missing field in body or children: "
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