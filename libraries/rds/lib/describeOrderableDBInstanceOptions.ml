open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeOrderableDBInstanceOptionsMessage =
  struct
    type t =
      {
      engine: String.t
        [@ocaml.doc
          "<p>The name of the engine to retrieve DB instance options for.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The engine version filter value. Specify this parameter to show only the available offerings matching the specified engine version.</p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The DB instance class filter value. Specify this parameter to show only the available offerings matching the specified DB instance class.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>The license model filter value. Specify this parameter to show only the available offerings matching the specified license model.</p>"];
      vpc: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to show only VPC or non-VPC offerings.</p>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so that you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous DescribeOrderableDBInstanceOptions request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~engine  ?engine_version  ?d_b_instance_class  ?license_model 
      ?vpc  ?(filters= [])  ?max_records  ?marker  () =
      {
        engine;
        engine_version;
        d_b_instance_class;
        license_model;
        vpc;
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
           Util.option_map v.vpc (fun f -> ("vpc", (Boolean.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Some ("engine", (String.to_json v.engine))])
    let parse xml =
      Some
        {
          engine =
            (Xml.required "Engine"
               (Util.option_bind (Xml.member "Engine" xml) String.parse));
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          vpc = (Util.option_bind (Xml.member "Vpc" xml) Boolean.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "Engine" ([], (String.to_xml v.engine)))])
                 @
                 [Util.option_map v.engine_version
                    (fun f ->
                       Ezxmlm.make_tag "EngineVersion"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.d_b_instance_class
                   (fun f ->
                      Ezxmlm.make_tag "DBInstanceClass"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.license_model
                  (fun f ->
                     Ezxmlm.make_tag "LicenseModel" ([], (String.to_xml f)))])
              @
              [Util.option_map v.vpc
                 (fun f -> Ezxmlm.make_tag "Vpc" ([], (Boolean.to_xml f)))])
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
module OrderableDBInstanceOptionsMessage = OrderableDBInstanceOptionsMessage
type input = DescribeOrderableDBInstanceOptionsMessage.t
type output = OrderableDBInstanceOptionsMessage.t
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
         ("Action", ["DescribeOrderableDBInstanceOptions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeOrderableDBInstanceOptionsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeOrderableDBInstanceOptionsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeOrderableDBInstanceOptionsResponse" (snd xml))
        (Xml.member "DescribeOrderableDBInstanceOptionsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp OrderableDBInstanceOptionsMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed OrderableDBInstanceOptionsMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing OrderableDBInstanceOptionsMessage - missing field in body or children: "
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