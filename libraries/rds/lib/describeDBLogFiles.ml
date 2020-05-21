open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBLogFilesMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The customer-assigned name of the DB instance that contains the log files you want to list.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBInstance.</p> </li> </ul>"];
      filename_contains: String.t option
        [@ocaml.doc
          "<p>Filters the available log files for log file names that contain the specified string.</p>"];
      file_last_written: Long.t option
        [@ocaml.doc
          "<p>Filters the available log files for files written since the specified date, in POSIX timestamp format with milliseconds.</p>"];
      file_size: Long.t option
        [@ocaml.doc
          "<p>Filters the available log files for files larger than the specified size.</p>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified MaxRecords value, a pagination token called a marker is included in the response so you can retrieve the remaining results.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>The pagination token provided in the previous request. If this parameter is specified the response includes only records beyond the marker, up to MaxRecords.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_instance_identifier  ?filename_contains  ?file_last_written
       ?file_size  ?(filters= [])  ?max_records  ?marker  () =
      {
        d_b_instance_identifier;
        filename_contains;
        file_last_written;
        file_size;
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
           Util.option_map v.file_size
             (fun f -> ("file_size", (Long.to_json f)));
           Util.option_map v.file_last_written
             (fun f -> ("file_last_written", (Long.to_json f)));
           Util.option_map v.filename_contains
             (fun f -> ("filename_contains", (String.to_json f)));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          filename_contains =
            (Util.option_bind (Xml.member "FilenameContains" xml)
               String.parse);
          file_last_written =
            (Util.option_bind (Xml.member "FileLastWritten" xml) Long.parse);
          file_size =
            (Util.option_bind (Xml.member "FileSize" xml) Long.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "DBInstanceIdentifier"
                       ([], (String.to_xml v.d_b_instance_identifier)))])
                @
                [Util.option_map v.filename_contains
                   (fun f ->
                      Ezxmlm.make_tag "FilenameContains"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.file_last_written
                  (fun f ->
                     Ezxmlm.make_tag "FileLastWritten" ([], (Long.to_xml f)))])
              @
              [Util.option_map v.file_size
                 (fun f -> Ezxmlm.make_tag "FileSize" ([], (Long.to_xml f)))])
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
module DescribeDBLogFilesResponse = DescribeDBLogFilesResponse
type input = DescribeDBLogFilesMessage.t
type output = DescribeDBLogFilesResponse.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DescribeDBLogFiles"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeDBLogFilesMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeDBLogFilesMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeDBLogFilesResponse" (snd xml))
        (Xml.member "DescribeDBLogFilesResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeDBLogFilesResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeDBLogFilesResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeDBLogFilesResponse - missing field in body or children: "
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