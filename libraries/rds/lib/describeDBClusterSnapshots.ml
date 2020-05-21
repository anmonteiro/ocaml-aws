open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBClusterSnapshotsMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The ID of the DB cluster to retrieve the list of DB cluster snapshots for. This parameter can't be used in conjunction with the <code>DBClusterSnapshotIdentifier</code> parameter. This parameter isn't case-sensitive. </p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the identifier of an existing DBCluster.</p> </li> </ul>"];
      d_b_cluster_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>A specific DB cluster snapshot identifier to describe. This parameter can't be used in conjunction with the <code>DBClusterIdentifier</code> parameter. This value is stored as a lowercase string. </p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the identifier of an existing DBClusterSnapshot.</p> </li> <li> <p>If this identifier is for an automated snapshot, the <code>SnapshotType</code> parameter must also be specified.</p> </li> </ul>"];
      snapshot_type: String.t option
        [@ocaml.doc
          "<p>The type of DB cluster snapshots to be returned. You can specify one of the following values:</p> <ul> <li> <p> <code>automated</code> - Return all DB cluster snapshots that have been automatically taken by Amazon RDS for my AWS account.</p> </li> <li> <p> <code>manual</code> - Return all DB cluster snapshots that have been taken by my AWS account.</p> </li> <li> <p> <code>shared</code> - Return all manual DB cluster snapshots that have been shared to my AWS account.</p> </li> <li> <p> <code>public</code> - Return all DB cluster snapshots that have been marked as public.</p> </li> </ul> <p>If you don't specify a <code>SnapshotType</code> value, then both automated and manual DB cluster snapshots are returned. You can include shared DB cluster snapshots with these results by enabling the <code>IncludeShared</code> parameter. You can include public DB cluster snapshots with these results by enabling the <code>IncludePublic</code> parameter.</p> <p>The <code>IncludeShared</code> and <code>IncludePublic</code> parameters don't apply for <code>SnapshotType</code> values of <code>manual</code> or <code>automated</code>. The <code>IncludePublic</code> parameter doesn't apply when <code>SnapshotType</code> is set to <code>shared</code>. The <code>IncludeShared</code> parameter doesn't apply when <code>SnapshotType</code> is set to <code>public</code>.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>A filter that specifies one or more DB cluster snapshots to describe.</p> <p>Supported filters:</p> <ul> <li> <p> <code>db-cluster-id</code> - Accepts DB cluster identifiers and DB cluster Amazon Resource Names (ARNs).</p> </li> <li> <p> <code>db-cluster-snapshot-id</code> - Accepts DB cluster snapshot identifiers.</p> </li> <li> <p> <code>snapshot-type</code> - Accepts types of DB cluster snapshots.</p> </li> <li> <p> <code>engine</code> - Accepts names of database engines.</p> </li> </ul>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional pagination token provided by a previous <code>DescribeDBClusterSnapshots</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      include_shared: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to include shared manual DB cluster snapshots from other AWS accounts that this AWS account has been given permission to copy or restore. By default, these snapshots are not included.</p> <p>You can give an AWS account permission to restore a manual DB cluster snapshot from another AWS account by the <code>ModifyDBClusterSnapshotAttribute</code> API action.</p>"];
      include_public: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to include manual DB cluster snapshots that are public and can be copied or restored by any AWS account. By default, the public snapshots are not included.</p> <p>You can share a manual DB cluster snapshot as public by using the <a>ModifyDBClusterSnapshotAttribute</a> API action.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?d_b_cluster_identifier  ?d_b_cluster_snapshot_identifier 
      ?snapshot_type  ?(filters= [])  ?max_records  ?marker  ?include_shared 
      ?include_public  () =
      {
        d_b_cluster_identifier;
        d_b_cluster_snapshot_identifier;
        snapshot_type;
        filters;
        max_records;
        marker;
        include_shared;
        include_public
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.include_public
              (fun f -> ("include_public", (Boolean.to_json f)));
           Util.option_map v.include_shared
             (fun f -> ("include_shared", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.snapshot_type
             (fun f -> ("snapshot_type", (String.to_json f)));
           Util.option_map v.d_b_cluster_snapshot_identifier
             (fun f ->
                ("d_b_cluster_snapshot_identifier", (String.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          d_b_cluster_snapshot_identifier =
            (Util.option_bind (Xml.member "DBClusterSnapshotIdentifier" xml)
               String.parse);
          snapshot_type =
            (Util.option_bind (Xml.member "SnapshotType" xml) String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          include_shared =
            (Util.option_bind (Xml.member "IncludeShared" xml) Boolean.parse);
          include_public =
            (Util.option_bind (Xml.member "IncludePublic" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.d_b_cluster_identifier
                     (fun f ->
                        Ezxmlm.make_tag "DBClusterIdentifier"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.d_b_cluster_snapshot_identifier
                    (fun f ->
                       Ezxmlm.make_tag "DBClusterSnapshotIdentifier"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.snapshot_type
                   (fun f ->
                      Ezxmlm.make_tag "SnapshotType" ([], (String.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Filters"
                          ([], (FilterList.to_xml [x])))) v.filters))
              @
              [Util.option_map v.max_records
                 (fun f ->
                    Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.marker
                (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
            @
            [Util.option_map v.include_shared
               (fun f ->
                  Ezxmlm.make_tag "IncludeShared" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.include_public
              (fun f ->
                 Ezxmlm.make_tag "IncludePublic" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module DBClusterSnapshotMessage = DBClusterSnapshotMessage
type input = DescribeDBClusterSnapshotsMessage.t
type output = DBClusterSnapshotMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["DescribeDBClusterSnapshots"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDBClusterSnapshotsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeDBClusterSnapshotsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeDBClusterSnapshotsResponse" (snd xml))
        (Xml.member "DescribeDBClusterSnapshotsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBClusterSnapshotMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DBClusterSnapshotMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterSnapshotMessage - missing field in body or children: "
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