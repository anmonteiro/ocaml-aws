open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVolumeStatusRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>action.code</code> - The action code for the event (for example, <code>enable-volume-io</code>).</p> </li> <li> <p> <code>action.description</code> - A description of the action.</p> </li> <li> <p> <code>action.event-id</code> - The event ID associated with the action.</p> </li> <li> <p> <code>availability-zone</code> - The Availability Zone of the instance.</p> </li> <li> <p> <code>event.description</code> - A description of the event.</p> </li> <li> <p> <code>event.event-id</code> - The event ID.</p> </li> <li> <p> <code>event.event-type</code> - The event type (for <code>io-enabled</code>: <code>passed</code> | <code>failed</code>; for <code>io-performance</code>: <code>io-performance:degraded</code> | <code>io-performance:severely-degraded</code> | <code>io-performance:stalled</code>).</p> </li> <li> <p> <code>event.not-after</code> - The latest end time for the event.</p> </li> <li> <p> <code>event.not-before</code> - The earliest start time for the event.</p> </li> <li> <p> <code>volume-status.details-name</code> - The cause for <code>volume-status.status</code> (<code>io-enabled</code> | <code>io-performance</code>).</p> </li> <li> <p> <code>volume-status.details-status</code> - The status of <code>volume-status.details-name</code> (for <code>io-enabled</code>: <code>passed</code> | <code>failed</code>; for <code>io-performance</code>: <code>normal</code> | <code>degraded</code> | <code>severely-degraded</code> | <code>stalled</code>).</p> </li> <li> <p> <code>volume-status.status</code> - The status of the volume (<code>ok</code> | <code>impaired</code> | <code>warning</code> | <code>insufficient-data</code>).</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of volume results returned by <code>DescribeVolumeStatus</code> in paginated output. When this parameter is used, the request only returns <code>MaxResults</code> results in a single page along with a <code>NextToken</code> response element. The remaining results of the initial request can be seen by sending another request with the returned <code>NextToken</code> value. This value can be between 5 and 1000; if <code>MaxResults</code> is given a value larger than 1000, only 1000 results are returned. If this parameter is not used, then <code>DescribeVolumeStatus</code> returns all results. You cannot specify this parameter and the volume IDs parameter in the same request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The <code>NextToken</code> value to include in a future <code>DescribeVolumeStatus</code> request. When the results of the request exceed <code>MaxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>"];
      volume_ids: VolumeIdStringList.t
        [@ocaml.doc
          "<p>The IDs of the volumes.</p> <p>Default: Describes all your volumes.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(filters= [])  ?max_results  ?next_token  ?(volume_ids= []) 
      ?dry_run  () =
      { filters; max_results; next_token; volume_ids; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("VolumeId", (VolumeIdStringList.to_query v.volume_ids)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("volume_ids", (VolumeIdStringList.to_json v.volume_ids));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          volume_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VolumeId" xml)
                  VolumeIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
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
                    (Ezxmlm.make_tag "VolumeId"
                       ([], (VolumeIdStringList.to_xml [x])))) v.volume_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeVolumeStatusResult = DescribeVolumeStatusResult
type input = DescribeVolumeStatusRequest.t
type output = DescribeVolumeStatusResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeVolumeStatus"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeVolumeStatusRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeVolumeStatusRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeVolumeStatusResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeVolumeStatusResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeVolumeStatusResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVolumeStatusResult - missing field in body or children: "
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