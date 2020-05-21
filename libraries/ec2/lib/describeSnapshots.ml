open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSnapshotsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>description</code> - A description of the snapshot.</p> </li> <li> <p> <code>encrypted</code> - Indicates whether the snapshot is encrypted (<code>true</code> | <code>false</code>)</p> </li> <li> <p> <code>owner-alias</code> - Value from an Amazon-maintained list (<code>amazon</code> | <code>self</code> | <code>all</code> | <code>aws-marketplace</code> | <code>microsoft</code>) of snapshot owners. Not to be confused with the user-configured AWS account alias, which is set from the IAM console.</p> </li> <li> <p> <code>owner-id</code> - The ID of the AWS account that owns the snapshot.</p> </li> <li> <p> <code>progress</code> - The progress of the snapshot, as a percentage (for example, 80%).</p> </li> <li> <p> <code>snapshot-id</code> - The snapshot ID.</p> </li> <li> <p> <code>start-time</code> - The time stamp when the snapshot was initiated.</p> </li> <li> <p> <code>status</code> - The status of the snapshot (<code>pending</code> | <code>completed</code> | <code>error</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>volume-id</code> - The ID of the volume the snapshot is for.</p> </li> <li> <p> <code>volume-size</code> - The size of the volume, in GiB.</p> </li> </ul>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of snapshot results returned by <code>DescribeSnapshots</code> in paginated output. When this parameter is used, <code>DescribeSnapshots</code> only returns <code>MaxResults</code> results in a single page along with a <code>NextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>DescribeSnapshots</code> request with the returned <code>NextToken</code> value. This value can be between 5 and 1000; if <code>MaxResults</code> is given a value larger than 1000, only 1000 results are returned. If this parameter is not used, then <code>DescribeSnapshots</code> returns all results. You cannot specify this parameter and the snapshot IDs parameter in the same request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The <code>NextToken</code> value returned from a previous paginated <code>DescribeSnapshots</code> request where <code>MaxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>NextToken</code> value. This value is <code>null</code> when there are no more results to return.</p>"];
      owner_ids: OwnerStringList.t
        [@ocaml.doc "<p>Describes the snapshots owned by these owners.</p>"];
      restorable_by_user_ids: RestorableByStringList.t
        [@ocaml.doc
          "<p>The IDs of the AWS accounts that can create volumes from the snapshot.</p>"];
      snapshot_ids: SnapshotIdStringList.t
        [@ocaml.doc
          "<p>The snapshot IDs.</p> <p>Default: Describes the snapshots for which you have create volume permissions.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(filters= [])  ?max_results  ?next_token  ?(owner_ids= []) 
      ?(restorable_by_user_ids= [])  ?(snapshot_ids= [])  ?dry_run  () =
      {
        filters;
        max_results;
        next_token;
        owner_ids;
        restorable_by_user_ids;
        snapshot_ids;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("SnapshotId",
                  (SnapshotIdStringList.to_query v.snapshot_ids)));
           Some
             (Query.Pair
                ("RestorableBy",
                  (RestorableByStringList.to_query v.restorable_by_user_ids)));
           Some
             (Query.Pair ("Owner", (OwnerStringList.to_query v.owner_ids)));
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
           Some
             ("snapshot_ids", (SnapshotIdStringList.to_json v.snapshot_ids));
           Some
             ("restorable_by_user_ids",
               (RestorableByStringList.to_json v.restorable_by_user_ids));
           Some ("owner_ids", (OwnerStringList.to_json v.owner_ids));
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
          owner_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "Owner" xml)
                  OwnerStringList.parse));
          restorable_by_user_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "RestorableBy" xml)
                  RestorableByStringList.parse));
          snapshot_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "SnapshotId" xml)
                  SnapshotIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
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
                  (fun f ->
                     Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Owner"
                         ([], (OwnerStringList.to_xml [x])))) v.owner_ids))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "RestorableBy"
                        ([], (RestorableByStringList.to_xml [x]))))
                v.restorable_by_user_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "SnapshotId"
                       ([], (SnapshotIdStringList.to_xml [x]))))
               v.snapshot_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeSnapshotsResult = DescribeSnapshotsResult
type input = DescribeSnapshotsRequest.t
type output = DescribeSnapshotsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DescribeSnapshots"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeSnapshotsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeSnapshotsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeSnapshotsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeSnapshotsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSnapshotsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSnapshotsResult - missing field in body or children: "
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