open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeNetworkInterfacePermissionsRequest =
  struct
    type t =
      {
      network_interface_permission_ids: NetworkInterfacePermissionIdList.t
        [@ocaml.doc "<p>One or more network interface permission IDs.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>network-interface-permission.network-interface-permission-id</code> - The ID of the permission.</p> </li> <li> <p> <code>network-interface-permission.network-interface-id</code> - The ID of the network interface.</p> </li> <li> <p> <code>network-interface-permission.aws-account-id</code> - The AWS account ID.</p> </li> <li> <p> <code>network-interface-permission.aws-service</code> - The AWS service.</p> </li> <li> <p> <code>network-interface-permission.permission</code> - The type of permission (<code>INSTANCE-ATTACH</code> | <code>EIP-ASSOCIATE</code>).</p> </li> </ul>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to request the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value. If this parameter is not specified, up to 50 results are returned by default.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeNetworkInterfacePermissions.</p>"]
    let make ?(network_interface_permission_ids= [])  ?(filters= []) 
      ?next_token  ?max_results  () =
      { network_interface_permission_ids; filters; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("NetworkInterfacePermissionId",
                  (NetworkInterfacePermissionIdList.to_query
                     v.network_interface_permission_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("network_interface_permission_ids",
               (NetworkInterfacePermissionIdList.to_json
                  v.network_interface_permission_ids))])
    let parse xml =
      Some
        {
          network_interface_permission_ids =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "NetworkInterfacePermissionId" xml)
                  NetworkInterfacePermissionIdList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "NetworkInterfacePermissionId"
                         ([], (NetworkInterfacePermissionIdList.to_xml [x]))))
                 v.network_interface_permission_ids))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeNetworkInterfacePermissions.</p>"]
module DescribeNetworkInterfacePermissionsResult =
  DescribeNetworkInterfacePermissionsResult
type input = DescribeNetworkInterfacePermissionsRequest.t
type output = DescribeNetworkInterfacePermissionsResult.t
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
         ("Action", ["DescribeNetworkInterfacePermissions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeNetworkInterfacePermissionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeNetworkInterfacePermissionsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeNetworkInterfacePermissionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeNetworkInterfacePermissionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeNetworkInterfacePermissionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeNetworkInterfacePermissionsResult - missing field in body or children: "
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