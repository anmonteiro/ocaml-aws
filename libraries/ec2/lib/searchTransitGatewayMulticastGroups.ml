open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SearchTransitGatewayMulticastGroupsRequest =
  struct
    type t =
      {
      transit_gateway_multicast_domain_id: String.t option
        [@ocaml.doc "<p>The ID of the transit gateway multicast domain.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters. The possible values are:</p> <ul> <li> <p> <code>group-ip-address</code> - The IP address of the transit gateway multicast group.</p> </li> <li> <p> <code>is-group-member</code> - The resource is a group member. Valid values are <code>true</code> | <code>false</code>.</p> </li> <li> <p> <code>is-group-source</code> - The resource is a group source. Valid values are <code>true</code> | <code>false</code>.</p> </li> <li> <p> <code>member-type</code> - The member type. Valid values are <code>igmp</code> | <code>static</code>.</p> </li> <li> <p> <code>resource-id</code> - The ID of the resource.</p> </li> <li> <p> <code>resource-type</code> - The type of resource. Valid values are <code>vpc</code> | <code>vpn</code> | <code>direct-connect-gateway</code> | <code>tgw-peering</code>.</p> </li> <li> <p> <code>source-type</code> - The source type. Valid values are <code>igmp</code> | <code>static</code>.</p> </li> <li> <p> <code>state</code> - The state of the subnet association. Valid values are <code>associated</code> | <code>associated</code> | <code>disassociated</code> | <code>disassociating</code>.</p> </li> <li> <p> <code>subnet-id</code> - The ID of the subnet.</p> </li> <li> <p> <code>transit-gateway-attachment-id</code> - The id of the transit gateway attachment.</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?transit_gateway_multicast_domain_id  ?(filters= []) 
      ?max_results  ?next_token  ?dry_run  () =
      {
        transit_gateway_multicast_domain_id;
        filters;
        max_results;
        next_token;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.transit_gateway_multicast_domain_id
             (fun f ->
                Query.Pair
                  ("TransitGatewayMulticastDomainId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.transit_gateway_multicast_domain_id
             (fun f ->
                ("transit_gateway_multicast_domain_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          transit_gateway_multicast_domain_id =
            (Util.option_bind
               (Xml.member "TransitGatewayMulticastDomainId" xml)
               String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.transit_gateway_multicast_domain_id
                  (fun f ->
                     Ezxmlm.make_tag "TransitGatewayMulticastDomainId"
                       ([], (String.to_xml f)))])
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
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module SearchTransitGatewayMulticastGroupsResult =
  SearchTransitGatewayMulticastGroupsResult
type input = SearchTransitGatewayMulticastGroupsRequest.t
type output = SearchTransitGatewayMulticastGroupsResult.t
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
         ("Action", ["SearchTransitGatewayMulticastGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (SearchTransitGatewayMulticastGroupsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (SearchTransitGatewayMulticastGroupsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "SearchTransitGatewayMulticastGroupsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             SearchTransitGatewayMulticastGroupsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed SearchTransitGatewayMulticastGroupsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing SearchTransitGatewayMulticastGroupsResult - missing field in body or children: "
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