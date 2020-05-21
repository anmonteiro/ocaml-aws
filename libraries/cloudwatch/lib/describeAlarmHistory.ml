open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAlarmHistoryInput =
  struct
    type t =
      {
      alarm_name: String.t option
        [@ocaml.doc "<p>The name of the alarm.</p>"];
      history_item_type: HistoryItemType.t option
        [@ocaml.doc "<p>The type of alarm histories to retrieve.</p>"];
      start_date: DateTime.t option
        [@ocaml.doc "<p>The starting date to retrieve alarm history.</p>"];
      end_date: DateTime.t option
        [@ocaml.doc "<p>The ending date to retrieve alarm history.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of alarm history records to retrieve.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token returned by a previous call to indicate that there is more data available.</p>"]}
    let make ?alarm_name  ?history_item_type  ?start_date  ?end_date 
      ?max_records  ?next_token  () =
      {
        alarm_name;
        history_item_type;
        start_date;
        end_date;
        max_records;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (DateTime.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (DateTime.to_json f)));
           Util.option_map v.history_item_type
             (fun f -> ("history_item_type", (HistoryItemType.to_json f)));
           Util.option_map v.alarm_name
             (fun f -> ("alarm_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          alarm_name =
            (Util.option_bind (Xml.member "AlarmName" xml) String.parse);
          history_item_type =
            (Util.option_bind (Xml.member "HistoryItemType" xml)
               HistoryItemType.parse);
          start_date =
            (Util.option_bind (Xml.member "StartDate" xml) DateTime.parse);
          end_date =
            (Util.option_bind (Xml.member "EndDate" xml) DateTime.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.alarm_name
                   (fun f ->
                      Ezxmlm.make_tag "AlarmName" ([], (String.to_xml f)))])
               @
               [Util.option_map v.history_item_type
                  (fun f ->
                     Ezxmlm.make_tag "HistoryItemType"
                       ([], (HistoryItemType.to_xml f)))])
              @
              [Util.option_map v.start_date
                 (fun f ->
                    Ezxmlm.make_tag "StartDate" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.end_date
                (fun f -> Ezxmlm.make_tag "EndDate" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeAlarmHistoryOutput = DescribeAlarmHistoryOutput
type input = DescribeAlarmHistoryInput.t
type output = DescribeAlarmHistoryOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["DescribeAlarmHistory"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeAlarmHistoryInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeAlarmHistoryInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeAlarmHistoryResponse" (snd xml))
        (Xml.member "DescribeAlarmHistoryResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeAlarmHistoryOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeAlarmHistoryOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeAlarmHistoryOutput - missing field in body or children: "
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