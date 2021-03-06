open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeClientVpnEndpointsRequest =
  struct
    type t =
      {
      client_vpn_endpoint_ids: ValueStringList.t
        [@ocaml.doc "<p>The ID of the Client VPN endpoint.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results can be seen by sending another request with the nextToken value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters. Filter names and values are case-sensitive.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(client_vpn_endpoint_ids= [])  ?max_results  ?next_token 
      ?(filters= [])  ?dry_run  () =
      { client_vpn_endpoint_ids; max_results; next_token; filters; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some
             (Query.Pair
                ("ClientVpnEndpointId",
                  (ValueStringList.to_query v.client_vpn_endpoint_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some
             ("client_vpn_endpoint_ids",
               (ValueStringList.to_json v.client_vpn_endpoint_ids))])
    let parse xml =
      Some
        {
          client_vpn_endpoint_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ClientVpnEndpointId" xml)
                  ValueStringList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ClientVpnEndpointId"
                          ([], (ValueStringList.to_xml [x]))))
                  v.client_vpn_endpoint_ids))
              @
              [Util.option_map v.max_results
                 (fun f ->
                    Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.next_token
                (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
               v.filters))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeClientVpnEndpointsResult = DescribeClientVpnEndpointsResult
type input = DescribeClientVpnEndpointsRequest.t
type output = DescribeClientVpnEndpointsResult.t
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
         ("Action", ["DescribeClientVpnEndpoints"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeClientVpnEndpointsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeClientVpnEndpointsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeClientVpnEndpointsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeClientVpnEndpointsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeClientVpnEndpointsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeClientVpnEndpointsResult - missing field in body or children: "
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