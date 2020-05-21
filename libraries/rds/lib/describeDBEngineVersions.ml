open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBEngineVersionsMessage =
  struct
    type t =
      {
      engine: String.t option
        [@ocaml.doc "<p>The database engine to return.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The database engine version to return.</p> <p>Example: <code>5.1.49</code> </p>"];
      d_b_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>The name of a specific DB parameter group family to return details for.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match an existing DBParameterGroupFamily.</p> </li> </ul>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more than the <code>MaxRecords</code> value is available, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      default_only: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether only the default version of the specified engine or engine and major version combination is returned.</p>"];
      list_supported_character_sets: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to list the supported character sets for each engine version.</p> <p>If this parameter is enabled and the requested engine supports the <code>CharacterSetName</code> parameter for <code>CreateDBInstance</code>, the response includes a list of supported character sets for each engine version. </p>"];
      list_supported_timezones: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to list the supported time zones for each engine version.</p> <p>If this parameter is enabled and the requested engine supports the <code>TimeZone</code> parameter for <code>CreateDBInstance</code>, the response includes a list of supported time zones for each engine version. </p>"];
      include_all: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to include engine versions that aren't available in the list. The default is to list only available engine versions.</p>"]}
    let make ?engine  ?engine_version  ?d_b_parameter_group_family 
      ?(filters= [])  ?max_records  ?marker  ?default_only 
      ?list_supported_character_sets  ?list_supported_timezones  ?include_all
       () =
      {
        engine;
        engine_version;
        d_b_parameter_group_family;
        filters;
        max_records;
        marker;
        default_only;
        list_supported_character_sets;
        list_supported_timezones;
        include_all
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.include_all
              (fun f -> ("include_all", (Boolean.to_json f)));
           Util.option_map v.list_supported_timezones
             (fun f -> ("list_supported_timezones", (Boolean.to_json f)));
           Util.option_map v.list_supported_character_sets
             (fun f -> ("list_supported_character_sets", (Boolean.to_json f)));
           Util.option_map v.default_only
             (fun f -> ("default_only", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.d_b_parameter_group_family
             (fun f -> ("d_b_parameter_group_family", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          d_b_parameter_group_family =
            (Util.option_bind (Xml.member "DBParameterGroupFamily" xml)
               String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          default_only =
            (Util.option_bind (Xml.member "DefaultOnly" xml) Boolean.parse);
          list_supported_character_sets =
            (Util.option_bind (Xml.member "ListSupportedCharacterSets" xml)
               Boolean.parse);
          list_supported_timezones =
            (Util.option_bind (Xml.member "ListSupportedTimezones" xml)
               Boolean.parse);
          include_all =
            (Util.option_bind (Xml.member "IncludeAll" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.engine
                       (fun f ->
                          Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.engine_version
                      (fun f ->
                         Ezxmlm.make_tag "EngineVersion"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.d_b_parameter_group_family
                     (fun f ->
                        Ezxmlm.make_tag "DBParameterGroupFamily"
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
              [Util.option_map v.default_only
                 (fun f ->
                    Ezxmlm.make_tag "DefaultOnly" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.list_supported_character_sets
                (fun f ->
                   Ezxmlm.make_tag "ListSupportedCharacterSets"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.list_supported_timezones
               (fun f ->
                  Ezxmlm.make_tag "ListSupportedTimezones"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.include_all
              (fun f -> Ezxmlm.make_tag "IncludeAll" ([], (Boolean.to_xml f)))])
  end
module DBEngineVersionMessage = DBEngineVersionMessage
type input = DescribeDBEngineVersionsMessage.t
type output = DBEngineVersionMessage.t
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
         ("Action", ["DescribeDBEngineVersions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDBEngineVersionsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeDBEngineVersionsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeDBEngineVersionsResponse" (snd xml))
        (Xml.member "DescribeDBEngineVersionsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DBEngineVersionMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DBEngineVersionMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBEngineVersionMessage - missing field in body or children: "
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