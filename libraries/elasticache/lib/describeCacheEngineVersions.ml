open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeCacheEngineVersionsMessage =
  struct
    type t =
      {
      engine: String.t option
        [@ocaml.doc
          "<p>The cache engine to return. Valid values: <code>memcached</code> | <code>redis</code> </p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The cache engine version to return.</p> <p>Example: <code>1.4.14</code> </p>"];
      cache_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>The name of a specific cache parameter group family to return details for.</p> <p>Valid values are: <code>memcached1.4</code> | <code>memcached1.5</code> | <code>redis2.6</code> | <code>redis2.8</code> | <code>redis3.2</code> | <code>redis4.0</code> | <code>redis5.0</code> | </p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 alphanumeric characters</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Cannot end with a hyphen or contain two consecutive hyphens</p> </li> </ul>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 100</p> <p>Constraints: minimum 20; maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      default_only: Boolean.t option
        [@ocaml.doc
          "<p>If <code>true</code>, specifies that only the default version of the specified engine or engine and major version combination is to be returned.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeCacheEngineVersions</code> operation.</p>"]
    let make ?engine  ?engine_version  ?cache_parameter_group_family 
      ?max_records  ?marker  ?default_only  () =
      {
        engine;
        engine_version;
        cache_parameter_group_family;
        max_records;
        marker;
        default_only
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_only
              (fun f -> ("default_only", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.cache_parameter_group_family
             (fun f -> ("cache_parameter_group_family", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          cache_parameter_group_family =
            (Util.option_bind (Xml.member "CacheParameterGroupFamily" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          default_only =
            (Util.option_bind (Xml.member "DefaultOnly" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.engine
                   (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
               @
               [Util.option_map v.engine_version
                  (fun f ->
                     Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
              @
              [Util.option_map v.cache_parameter_group_family
                 (fun f ->
                    Ezxmlm.make_tag "CacheParameterGroupFamily"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_records
                (fun f ->
                   Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           [Util.option_map v.default_only
              (fun f ->
                 Ezxmlm.make_tag "DefaultOnly" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeCacheEngineVersions</code> operation.</p>"]
module CacheEngineVersionMessage = CacheEngineVersionMessage
type input = DescribeCacheEngineVersionsMessage.t
type output = CacheEngineVersionMessage.t
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
         ("Action", ["DescribeCacheEngineVersions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeCacheEngineVersionsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeCacheEngineVersionsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeCacheEngineVersionsResponse" (snd xml))
        (Xml.member "DescribeCacheEngineVersionsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CacheEngineVersionMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CacheEngineVersionMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CacheEngineVersionMessage - missing field in body or children: "
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