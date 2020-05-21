open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBClusterParametersMessage =
  struct
    type t =
      {
      d_b_cluster_parameter_group_name: String.t
        [@ocaml.doc
          "<p>The name of a specific DB cluster parameter group to return parameter details for.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing DBClusterParameterGroup.</p> </li> </ul>"];
      source: String.t option
        [@ocaml.doc
          "<p> A value that indicates to return only parameters for a specific source. Parameter sources can be <code>engine</code>, <code>service</code>, or <code>customer</code>. </p>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeDBClusterParameters</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_parameter_group_name  ?source  ?(filters= []) 
      ?max_records  ?marker  () =
      {
        d_b_cluster_parameter_group_name;
        source;
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
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Some
             ("d_b_cluster_parameter_group_name",
               (String.to_json v.d_b_cluster_parameter_group_name))])
    let parse xml =
      Some
        {
          d_b_cluster_parameter_group_name =
            (Xml.required "DBClusterParameterGroupName"
               (Util.option_bind
                  (Xml.member "DBClusterParameterGroupName" xml) String.parse));
          source = (Util.option_bind (Xml.member "Source" xml) String.parse);
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
               [Some
                  (Ezxmlm.make_tag "DBClusterParameterGroupName"
                     ([], (String.to_xml v.d_b_cluster_parameter_group_name)))])
              @
              [Util.option_map v.source
                 (fun f -> Ezxmlm.make_tag "Source" ([], (String.to_xml f)))])
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
  end[@@ocaml.doc "<p/>"]
module DBClusterParameterGroupDetails = DBClusterParameterGroupDetails
type input = DescribeDBClusterParametersMessage.t
type output = DBClusterParameterGroupDetails.t
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
         ("Action", ["DescribeDBClusterParameters"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeDBClusterParametersMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeDBClusterParametersMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeDBClusterParametersResponse" (snd xml))
        (Xml.member "DescribeDBClusterParametersResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DBClusterParameterGroupDetails.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DBClusterParameterGroupDetails."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBClusterParameterGroupDetails - missing field in body or children: "
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