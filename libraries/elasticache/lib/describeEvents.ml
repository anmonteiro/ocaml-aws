open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeEventsMessage =
  struct
    type t =
      {
      source_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the event source for which events are returned. If not specified, all sources are included in the response.</p>"];
      source_type: SourceType.t option
        [@ocaml.doc
          "<p>The event source to retrieve events for. If no value is specified, all events are returned.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The beginning of the time interval to retrieve events for, specified in ISO 8601 format.</p> <p> <b>Example:</b> 2017-03-30T07:03:49.555Z</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The end of the time interval for which to retrieve events, specified in ISO 8601 format.</p> <p> <b>Example:</b> 2017-03-30T07:03:49.555Z</p>"];
      duration: Integer.t option
        [@ocaml.doc
          "<p>The number of minutes worth of events to retrieve.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 100</p> <p>Constraints: minimum 20; maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeEvents</code> operation.</p>"]
    let make ?source_identifier  ?source_type  ?start_time  ?end_time 
      ?duration  ?max_records  ?marker  () =
      {
        source_identifier;
        source_type;
        start_time;
        end_time;
        duration;
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
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.source_type
             (fun f -> ("source_type", (SourceType.to_json f)));
           Util.option_map v.source_identifier
             (fun f -> ("source_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          source_identifier =
            (Util.option_bind (Xml.member "SourceIdentifier" xml)
               String.parse);
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) SourceType.parse);
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          end_time =
            (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) Integer.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.source_identifier
                    (fun f ->
                       Ezxmlm.make_tag "SourceIdentifier"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.source_type
                   (fun f ->
                      Ezxmlm.make_tag "SourceType"
                        ([], (SourceType.to_xml f)))])
               @
               [Util.option_map v.start_time
                  (fun f ->
                     Ezxmlm.make_tag "StartTime" ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.end_time
                 (fun f ->
                    Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.duration
                (fun f -> Ezxmlm.make_tag "Duration" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeEvents</code> operation.</p>"]
module EventsMessage = EventsMessage
type input = DescribeEventsMessage.t
type output = EventsMessage.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DescribeEvents"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeEventsMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeEventsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeEventsResponse" (snd xml))
        (Xml.member "DescribeEventsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp EventsMessage.parse)
          (BadResponse
             { body; message = "Could not find well formed EventsMessage." })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing EventsMessage - missing field in body or children: "
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