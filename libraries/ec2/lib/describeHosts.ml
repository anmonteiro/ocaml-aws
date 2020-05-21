open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeHostsRequest =
  struct
    type t =
      {
      filter: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>auto-placement</code> - Whether auto-placement is enabled or disabled (<code>on</code> | <code>off</code>).</p> </li> <li> <p> <code>availability-zone</code> - The Availability Zone of the host.</p> </li> <li> <p> <code>client-token</code> - The idempotency token that you provided when you allocated the host.</p> </li> <li> <p> <code>host-reservation-id</code> - The ID of the reservation assigned to this host.</p> </li> <li> <p> <code>instance-type</code> - The instance type size that the Dedicated Host is configured to support.</p> </li> <li> <p> <code>state</code> - The allocation state of the Dedicated Host (<code>available</code> | <code>under-assessment</code> | <code>permanent-failure</code> | <code>released</code> | <code>released-permanent-failure</code>).</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      host_ids: RequestHostIdList.t
        [@ocaml.doc
          "<p>The IDs of the Dedicated Hosts. The IDs are used for targeted instance launches.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results can be seen by sending another request with the returned <code>nextToken</code> value. This value can be between 5 and 500. If <code>maxResults</code> is given a larger value than 500, you receive an error.</p> <p>You cannot specify this parameter and the host IDs parameter in the same request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use to retrieve the next page of results.</p>"]}
    let make ?(filter= [])  ?(host_ids= [])  ?max_results  ?next_token  () =
      { filter; host_ids; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some
             (Query.Pair ("HostId", (RequestHostIdList.to_query v.host_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filter)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("host_ids", (RequestHostIdList.to_json v.host_ids));
           Some ("filter", (FilterList.to_json v.filter))])
    let parse xml =
      Some
        {
          filter =
            (Util.of_option []
               (Util.option_bind (Xml.member "filter" xml) FilterList.parse));
          host_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "hostId" xml)
                  RequestHostIdList.parse));
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "filter" ([], (FilterList.to_xml [x]))))
                 v.filter))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "hostId"
                        ([], (RequestHostIdList.to_xml [x])))) v.host_ids))
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
  end
module DescribeHostsResult = DescribeHostsResult
type input = DescribeHostsRequest.t
type output = DescribeHostsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeHosts"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeHostsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeHostsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeHostsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeHostsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeHostsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeHostsResult - missing field in body or children: "
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