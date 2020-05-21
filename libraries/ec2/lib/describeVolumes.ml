open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeVolumesRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>attachment.attach-time</code> - The time stamp when the attachment initiated.</p> </li> <li> <p> <code>attachment.delete-on-termination</code> - Whether the volume is deleted on instance termination.</p> </li> <li> <p> <code>attachment.device</code> - The device name specified in the block device mapping (for example, <code>/dev/sda1</code>).</p> </li> <li> <p> <code>attachment.instance-id</code> - The ID of the instance the volume is attached to.</p> </li> <li> <p> <code>attachment.status</code> - The attachment state (<code>attaching</code> | <code>attached</code> | <code>detaching</code>).</p> </li> <li> <p> <code>availability-zone</code> - The Availability Zone in which the volume was created.</p> </li> <li> <p> <code>create-time</code> - The time stamp when the volume was created.</p> </li> <li> <p> <code>encrypted</code> - Indicates whether the volume is encrypted (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>size</code> - The size of the volume, in GiB.</p> </li> <li> <p> <code>snapshot-id</code> - The snapshot from which the volume was created.</p> </li> <li> <p> <code>status</code> - The status of the volume (<code>creating</code> | <code>available</code> | <code>in-use</code> | <code>deleting</code> | <code>deleted</code> | <code>error</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>volume-id</code> - The volume ID.</p> </li> <li> <p> <code>volume-type</code> - The Amazon EBS volume type. This can be <code>gp2</code> for General Purpose SSD, <code>io1</code> for Provisioned IOPS SSD, <code>st1</code> for Throughput Optimized HDD, <code>sc1</code> for Cold HDD, or <code>standard</code> for Magnetic volumes.</p> </li> </ul>"];
      volume_ids: VolumeIdStringList.t [@ocaml.doc "<p>The volume IDs.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of volume results returned by <code>DescribeVolumes</code> in paginated output. When this parameter is used, <code>DescribeVolumes</code> only returns <code>MaxResults</code> results in a single page along with a <code>NextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>DescribeVolumes</code> request with the returned <code>NextToken</code> value. This value can be between 5 and 500; if <code>MaxResults</code> is given a value larger than 500, only 500 results are returned. If this parameter is not used, then <code>DescribeVolumes</code> returns all results. You cannot specify this parameter and the volume IDs parameter in the same request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The <code>NextToken</code> value returned from a previous paginated <code>DescribeVolumes</code> request where <code>MaxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>NextToken</code> value. This value is <code>null</code> when there are no more results to return.</p>"]}
    let make ?(filters= [])  ?(volume_ids= [])  ?dry_run  ?max_results 
      ?next_token  () =
      { filters; volume_ids; dry_run; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("VolumeId", (VolumeIdStringList.to_query v.volume_ids)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("volume_ids", (VolumeIdStringList.to_json v.volume_ids));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          volume_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VolumeId" xml)
                  VolumeIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse)
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
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "VolumeId"
                         ([], (VolumeIdStringList.to_xml [x])))) v.volume_ids))
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
  end
module DescribeVolumesResult = DescribeVolumesResult
type input = DescribeVolumesRequest.t
type output = DescribeVolumesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeVolumes"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeVolumesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeVolumesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeVolumesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeVolumesResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeVolumesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeVolumesResult - missing field in body or children: "
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