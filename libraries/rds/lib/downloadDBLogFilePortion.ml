open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DownloadDBLogFilePortionMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The customer-assigned name of the DB instance that contains the log files you want to list.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBInstance.</p> </li> </ul>"];
      log_file_name: String.t
        [@ocaml.doc "<p>The name of the log file to be downloaded.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>The pagination token provided in the previous request or \"0\". If the Marker parameter is specified the response includes only records beyond the marker until the end of the file or up to NumberOfLines.</p>"];
      number_of_lines: Integer.t option
        [@ocaml.doc
          "<p>The number of lines to download. If the number of lines specified results in a file over 1 MB in size, the file is truncated at 1 MB in size.</p> <p>If the NumberOfLines parameter is specified, then the block of lines returned can be from the beginning or the end of the log file, depending on the value of the Marker parameter.</p> <ul> <li> <p>If neither Marker or NumberOfLines are specified, the entire log file is returned up to a maximum of 10000 lines, starting with the most recent log entries first.</p> </li> <li> <p>If NumberOfLines is specified and Marker isn't specified, then the most recent lines from the end of the log file are returned.</p> </li> <li> <p>If Marker is specified as \"0\", then the specified number of lines from the beginning of the log file are returned.</p> </li> <li> <p>You can download the log file in blocks of lines by specifying the size of the block using the NumberOfLines parameter, and by specifying a value of \"0\" for the Marker parameter in your first request. Include the Marker value returned in the response as the Marker value for the next request, continuing until the AdditionalDataPending response element returns false.</p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_instance_identifier  ~log_file_name  ?marker 
      ?number_of_lines  () =
      { d_b_instance_identifier; log_file_name; marker; number_of_lines }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.number_of_lines
              (fun f -> ("number_of_lines", (Integer.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Some ("log_file_name", (String.to_json v.log_file_name));
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
          log_file_name =
            (Xml.required "LogFileName"
               (Util.option_bind (Xml.member "LogFileName" xml) String.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          number_of_lines =
            (Util.option_bind (Xml.member "NumberOfLines" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBInstanceIdentifier"
                    ([], (String.to_xml v.d_b_instance_identifier)))])
             @
             [Some
                (Ezxmlm.make_tag "LogFileName"
                   ([], (String.to_xml v.log_file_name)))])
            @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           [Util.option_map v.number_of_lines
              (fun f ->
                 Ezxmlm.make_tag "NumberOfLines" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module DownloadDBLogFilePortionDetails = DownloadDBLogFilePortionDetails
type input = DownloadDBLogFilePortionMessage.t
type output = DownloadDBLogFilePortionDetails.t
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
         ("Action", ["DownloadDBLogFilePortion"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DownloadDBLogFilePortionMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DownloadDBLogFilePortionMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DownloadDBLogFilePortionResponse" (snd xml))
        (Xml.member "DownloadDBLogFilePortionResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DownloadDBLogFilePortionDetails.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DownloadDBLogFilePortionDetails."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DownloadDBLogFilePortionDetails - missing field in body or children: "
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