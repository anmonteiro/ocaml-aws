open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBSnapshotsMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>The ID of the DB instance to retrieve the list of DB snapshots for. This parameter can't be used in conjunction with <code>DBSnapshotIdentifier</code>. This parameter isn't case-sensitive. </p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the identifier of an existing DBInstance.</p> </li> </ul>"];
      d_b_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p> A specific DB snapshot identifier to describe. This parameter can't be used in conjunction with <code>DBInstanceIdentifier</code>. This value is stored as a lowercase string. </p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the identifier of an existing DBSnapshot.</p> </li> <li> <p>If this identifier is for an automated snapshot, the <code>SnapshotType</code> parameter must also be specified.</p> </li> </ul>"];
      snapshot_type: String.t option
        [@ocaml.doc
          "<p>The type of snapshots to be returned. You can specify one of the following values:</p> <ul> <li> <p> <code>automated</code> - Return all DB snapshots that have been automatically taken by Amazon RDS for my AWS account.</p> </li> <li> <p> <code>manual</code> - Return all DB snapshots that have been taken by my AWS account.</p> </li> <li> <p> <code>shared</code> - Return all manual DB snapshots that have been shared to my AWS account.</p> </li> <li> <p> <code>public</code> - Return all DB snapshots that have been marked as public.</p> </li> <li> <p> <code>awsbackup</code> - Return the DB snapshots managed by the AWS Backup service.</p> <p>For information about AWS Backup, see the <a href=\"https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html\"> <i>AWS Backup Developer Guide.</i> </a> </p> <p>The <code>awsbackup</code> type does not apply to Aurora.</p> </li> </ul> <p>If you don't specify a <code>SnapshotType</code> value, then both automated and manual snapshots are returned. Shared and public DB snapshots are not included in the returned results by default. You can include shared snapshots with these results by enabling the <code>IncludeShared</code> parameter. You can include public snapshots with these results by enabling the <code>IncludePublic</code> parameter.</p> <p>The <code>IncludeShared</code> and <code>IncludePublic</code> parameters don't apply for <code>SnapshotType</code> values of <code>manual</code> or <code>automated</code>. The <code>IncludePublic</code> parameter doesn't apply when <code>SnapshotType</code> is set to <code>shared</code>. The <code>IncludeShared</code> parameter doesn't apply when <code>SnapshotType</code> is set to <code>public</code>.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>A filter that specifies one or more DB snapshots to describe.</p> <p>Supported filters:</p> <ul> <li> <p> <code>db-instance-id</code> - Accepts DB instance identifiers and DB instance Amazon Resource Names (ARNs).</p> </li> <li> <p> <code>db-snapshot-id</code> - Accepts DB snapshot identifiers.</p> </li> <li> <p> <code>dbi-resource-id</code> - Accepts identifiers of source DB instances.</p> </li> <li> <p> <code>snapshot-type</code> - Accepts types of DB snapshots.</p> </li> <li> <p> <code>engine</code> - Accepts names of database engines.</p> </li> </ul>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so that you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeDBSnapshots</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      include_shared: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to include shared manual DB cluster snapshots from other AWS accounts that this AWS account has been given permission to copy or restore. By default, these snapshots are not included.</p> <p>You can give an AWS account permission to restore a manual DB snapshot from another AWS account by using the <code>ModifyDBSnapshotAttribute</code> API action.</p>"];
      include_public: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to include manual DB cluster snapshots that are public and can be copied or restored by any AWS account. By default, the public snapshots are not included.</p> <p>You can share a manual DB snapshot as public by using the <a>ModifyDBSnapshotAttribute</a> API.</p>"];
      dbi_resource_id: String.t option
        [@ocaml.doc "<p>A specific DB resource ID to describe.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?d_b_instance_identifier  ?d_b_snapshot_identifier 
      ?snapshot_type  ?(filters= [])  ?max_records  ?marker  ?include_shared 
      ?include_public  ?dbi_resource_id  () =
      {
        d_b_instance_identifier;
        d_b_snapshot_identifier;
        snapshot_type;
        filters;
        max_records;
        marker;
        include_shared;
        include_public;
        dbi_resource_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dbi_resource_id
              (fun f -> ("dbi_resource_id", (String.to_json f)));
           Util.option_map v.include_public
             (fun f -> ("include_public", (Boolean.to_json f)));
           Util.option_map v.include_shared
             (fun f -> ("include_shared", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.snapshot_type
             (fun f -> ("snapshot_type", (String.to_json f)));
           Util.option_map v.d_b_snapshot_identifier
             (fun f -> ("d_b_snapshot_identifier", (String.to_json f)));
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
               String.parse);
          d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "DBSnapshotIdentifier" xml)
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
            (Util.option_bind (Xml.member "IncludePublic" xml) Boolean.parse);
          dbi_resource_id =
            (Util.option_bind (Xml.member "DbiResourceId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.d_b_instance_identifier
                      (fun f ->
                         Ezxmlm.make_tag "DBInstanceIdentifier"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.d_b_snapshot_identifier
                     (fun f ->
                        Ezxmlm.make_tag "DBSnapshotIdentifier"
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
           @
           [Util.option_map v.dbi_resource_id
              (fun f ->
                 Ezxmlm.make_tag "DbiResourceId" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module DBSnapshotMessage = DBSnapshotMessage
type input = DescribeDBSnapshotsMessage.t
type output = DBSnapshotMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DescribeDBSnapshots"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDBSnapshotsMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeDBSnapshotsMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeDBSnapshotsResponse" (snd xml))
        (Xml.member "DescribeDBSnapshotsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBSnapshotMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DBSnapshotMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBSnapshotMessage - missing field in body or children: "
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