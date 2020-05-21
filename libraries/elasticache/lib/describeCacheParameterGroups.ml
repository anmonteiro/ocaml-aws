open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeCacheParameterGroupsMessage =
  struct
    type t =
      {
      cache_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of a specific cache parameter group to return details for.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 100</p> <p>Constraints: minimum 20; maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeCacheParameterGroups</code> operation.</p>"]
    let make ?cache_parameter_group_name  ?max_records  ?marker  () =
      { cache_parameter_group_name; max_records; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_parameter_group_name
             (fun f -> ("cache_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          cache_parameter_group_name =
            (Util.option_bind (Xml.member "CacheParameterGroupName" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cache_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "CacheParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeCacheParameterGroups</code> operation.</p>"]
module CacheParameterGroupsMessage = CacheParameterGroupsMessage
type input = DescribeCacheParameterGroupsMessage.t
type output = CacheParameterGroupsMessage.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]);
         ("Action", ["DescribeCacheParameterGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeCacheParameterGroupsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeCacheParameterGroupsMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeCacheParameterGroupsResponse" (snd xml))
        (Xml.member "DescribeCacheParameterGroupsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CacheParameterGroupsMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CacheParameterGroupsMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CacheParameterGroupsMessage - missing field in body or children: "
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