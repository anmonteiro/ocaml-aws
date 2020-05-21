open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBClusterEndpointsMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The DB cluster identifier of the DB cluster associated with the endpoint. This parameter is stored as a lowercase string.</p>"];
      d_b_cluster_endpoint_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the endpoint to describe. This parameter is stored as a lowercase string.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>A set of name-value pairs that define which endpoints to include in the output. The filters are specified as name-value pairs, in the format <code>Name=<i>endpoint_type</i>,Values=<i>endpoint_type1</i>,<i>endpoint_type2</i>,...</code>. <code>Name</code> can be one of: <code>db-cluster-endpoint-type</code>, <code>db-cluster-endpoint-custom-type</code>, <code>db-cluster-endpoint-id</code>, <code>db-cluster-endpoint-status</code>. <code>Values</code> for the <code> db-cluster-endpoint-type</code> filter can be one or more of: <code>reader</code>, <code>writer</code>, <code>custom</code>. <code>Values</code> for the <code>db-cluster-endpoint-custom-type</code> filter can be one or more of: <code>reader</code>, <code>any</code>. <code>Values</code> for the <code>db-cluster-endpoint-status</code> filter can be one or more of: <code>available</code>, <code>creating</code>, <code>deleting</code>, <code>modifying</code>. </p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeDBClusterEndpoints</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    let make ?d_b_cluster_identifier  ?d_b_cluster_endpoint_identifier 
      ?(filters= [])  ?max_records  ?marker  () =
      {
        d_b_cluster_identifier;
        d_b_cluster_endpoint_identifier;
        filters;
        max_records;
        marker
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.d_b_cluster_endpoint_identifier
             (fun f ->
                ("d_b_cluster_endpoint_identifier", (String.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          d_b_cluster_endpoint_identifier =
            (Util.option_bind (Xml.member "DBClusterEndpointIdentifier" xml)
               String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.d_b_cluster_identifier
                  (fun f ->
                     Ezxmlm.make_tag "DBClusterIdentifier"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.d_b_cluster_endpoint_identifier
                 (fun f ->
                    Ezxmlm.make_tag "DBClusterEndpointIdentifier"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filters" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end
module DBClusterEndpointMessage = DBClusterEndpointMessage
type input = DescribeDBClusterEndpointsMessage.t
type output = DBClusterEndpointMessage.t
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
         ("Action", ["DescribeDBClusterEndpoints"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDBClusterEndpointsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeDBClusterEndpointsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeDBClusterEndpointsResponse" (snd xml))
        (Xml.member "DescribeDBClusterEndpointsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBClusterEndpointMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DBClusterEndpointMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterEndpointMessage - missing field in body or children: "
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