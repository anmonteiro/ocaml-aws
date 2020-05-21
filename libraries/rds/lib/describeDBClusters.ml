open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBClustersMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The user-supplied DB cluster identifier. If this parameter is specified, information from only the specific DB cluster is returned. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match an existing DBClusterIdentifier.</p> </li> </ul>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>A filter that specifies one or more DB clusters to describe.</p> <p>Supported filters:</p> <ul> <li> <p> <code>db-cluster-id</code> - Accepts DB cluster identifiers and DB cluster Amazon Resource Names (ARNs). The results list will only include information about the DB clusters identified by these ARNs.</p> </li> </ul>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional pagination token provided by a previous <code>DescribeDBClusters</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      include_shared: Boolean.t option
        [@ocaml.doc
          "<p>Optional Boolean parameter that specifies whether the output includes information about clusters shared from other AWS accounts.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?d_b_cluster_identifier  ?(filters= [])  ?max_records  ?marker 
      ?include_shared  () =
      { d_b_cluster_identifier; filters; max_records; marker; include_shared
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.include_shared
              (fun f -> ("include_shared", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          include_shared =
            (Util.option_bind (Xml.member "IncludeShared" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.d_b_cluster_identifier
                  (fun f ->
                     Ezxmlm.make_tag "DBClusterIdentifier"
                       ([], (String.to_xml f)))])
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
  end[@@ocaml.doc "<p/>"]
module DBClusterMessage = DBClusterMessage
type input = DescribeDBClustersMessage.t
type output = DBClusterMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DescribeDBClusters"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDBClustersMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeDBClustersMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeDBClustersResponse" (snd xml))
        (Xml.member "DescribeDBClustersResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBClusterMessage.parse)
          (BadResponse
             { body; message = "Could not find well formed DBClusterMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterMessage - missing field in body or children: "
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