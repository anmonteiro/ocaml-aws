open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDhcpOptionsRequest =
  struct
    type t =
      {
      dhcp_options_ids: DhcpOptionsIdStringList.t
        [@ocaml.doc
          "<p>The IDs of one or more DHCP options sets.</p> <p>Default: Describes all your DHCP options sets.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>dhcp-options-id</code> - The ID of a DHCP options set.</p> </li> <li> <p> <code>key</code> - The key for one of the options (for example, <code>domain-name</code>).</p> </li> <li> <p> <code>value</code> - The value for one of the options.</p> </li> <li> <p> <code>owner-id</code> - The ID of the AWS account that owns the DHCP options set.</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return with a single call. To retrieve the remaining results, make another call with the returned <code>nextToken</code> value.</p>"]}
    let make ?(dhcp_options_ids= [])  ?(filters= [])  ?dry_run  ?next_token 
      ?max_results  () =
      { dhcp_options_ids; filters; dry_run; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Some
             (Query.Pair
                ("DhcpOptionsId",
                  (DhcpOptionsIdStringList.to_query v.dhcp_options_ids)))])
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
           Some ("filters", (FilterList.to_json v.filters));
           Some
             ("dhcp_options_ids",
               (DhcpOptionsIdStringList.to_json v.dhcp_options_ids))])
    let parse xml =
      Some
        {
          dhcp_options_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "DhcpOptionsId" xml)
                  DhcpOptionsIdStringList.parse));
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
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
                       (Ezxmlm.make_tag "DhcpOptionsId"
                          ([], (DhcpOptionsIdStringList.to_xml [x]))))
                  v.dhcp_options_ids))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filters))
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
module DescribeDhcpOptionsResult = DescribeDhcpOptionsResult
type input = DescribeDhcpOptionsRequest.t
type output = DescribeDhcpOptionsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeDhcpOptions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDhcpOptionsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeDhcpOptionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeDhcpOptionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeDhcpOptionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeDhcpOptionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeDhcpOptionsResult - missing field in body or children: "
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