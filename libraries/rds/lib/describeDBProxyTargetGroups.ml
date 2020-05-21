open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBProxyTargetGroupsRequest =
  struct
    type t =
      {
      d_b_proxy_name: String.t
        [@ocaml.doc
          "<p>The identifier of the <code>DBProxy</code> associated with the target group.</p>"];
      target_group_name: String.t option
        [@ocaml.doc
          "<p>The identifier of the <code>DBProxyTargetGroup</code> to describe.</p>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter is not currently supported.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so that the remaining results can be retrieved. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"]}
    let make ~d_b_proxy_name  ?target_group_name  ?(filters= [])  ?marker 
      ?max_records  () =
      { d_b_proxy_name; target_group_name; filters; marker; max_records }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_records
              (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.target_group_name
             (fun f -> ("target_group_name", (String.to_json f)));
           Some ("d_b_proxy_name", (String.to_json v.d_b_proxy_name))])
    let parse xml =
      Some
        {
          d_b_proxy_name =
            (Xml.required "DBProxyName"
               (Util.option_bind (Xml.member "DBProxyName" xml) String.parse));
          target_group_name =
            (Util.option_bind (Xml.member "TargetGroupName" xml) String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "DBProxyName"
                     ([], (String.to_xml v.d_b_proxy_name)))])
              @
              [Util.option_map v.target_group_name
                 (fun f ->
                    Ezxmlm.make_tag "TargetGroupName" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filters" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_records
              (fun f -> Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
  end
module DescribeDBProxyTargetGroupsResponse =
  DescribeDBProxyTargetGroupsResponse
type input = DescribeDBProxyTargetGroupsRequest.t
type output = DescribeDBProxyTargetGroupsResponse.t
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
         ("Action", ["DescribeDBProxyTargetGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeDBProxyTargetGroupsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeDBProxyTargetGroupsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeDBProxyTargetGroupsResponse" (snd xml))
        (Xml.member "DescribeDBProxyTargetGroupsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeDBProxyTargetGroupsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeDBProxyTargetGroupsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeDBProxyTargetGroupsResponse - missing field in body or children: "
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