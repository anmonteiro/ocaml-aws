open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetMetricDataInput =
  struct
    type t =
      {
      metric_data_queries: MetricDataQueries.t
        [@ocaml.doc
          "<p>The metric queries to be returned. A single <code>GetMetricData</code> call can include as many as 100 <code>MetricDataQuery</code> structures. Each of these structures can specify either a metric to retrieve, or a math expression to perform on retrieved data. </p>"];
      start_time: DateTime.t
        [@ocaml.doc
          "<p>The time stamp indicating the earliest data to be returned.</p> <p>The value specified is inclusive; results include data points with the specified time stamp. </p> <p>CloudWatch rounds the specified time stamp as follows:</p> <ul> <li> <p>Start time less than 15 days ago - Round down to the nearest whole minute. For example, 12:32:34 is rounded down to 12:32:00.</p> </li> <li> <p>Start time between 15 and 63 days ago - Round down to the nearest 5-minute clock interval. For example, 12:32:34 is rounded down to 12:30:00.</p> </li> <li> <p>Start time greater than 63 days ago - Round down to the nearest 1-hour clock interval. For example, 12:32:34 is rounded down to 12:00:00.</p> </li> </ul> <p>If you set <code>Period</code> to 5, 10, or 30, the start time of your request is rounded down to the nearest time that corresponds to even 5-, 10-, or 30-second divisions of a minute. For example, if you make a query at (HH:mm:ss) 01:05:23 for the previous 10-second period, the start time of your request is rounded down and you receive data from 01:05:10 to 01:05:20. If you make a query at 15:07:17 for the previous 5 minutes of data, using a period of 5 seconds, you receive data timestamped between 15:02:15 and 15:07:15. </p> <p>For better performance, specify <code>StartTime</code> and <code>EndTime</code> values that align with the value of the metric's <code>Period</code> and sync up with the beginning and end of an hour. For example, if the <code>Period</code> of a metric is 5 minutes, specifying 12:05 or 12:30 as <code>StartTime</code> can get a faster response from CloudWatch than setting 12:07 or 12:29 as the <code>StartTime</code>.</p>"];
      end_time: DateTime.t
        [@ocaml.doc
          "<p>The time stamp indicating the latest data to be returned.</p> <p>The value specified is exclusive; results include data points up to the specified time stamp.</p> <p>For better performance, specify <code>StartTime</code> and <code>EndTime</code> values that align with the value of the metric's <code>Period</code> and sync up with the beginning and end of an hour. For example, if the <code>Period</code> of a metric is 5 minutes, specifying 12:05 or 12:30 as <code>EndTime</code> can get a faster response from CloudWatch than setting 12:07 or 12:29 as the <code>EndTime</code>.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>Include this value, if it was returned by the previous call, to get the next set of data points.</p>"];
      scan_by: ScanBy.t option
        [@ocaml.doc
          "<p>The order in which data points should be returned. <code>TimestampDescending</code> returns the newest data first and paginates when the <code>MaxDatapoints</code> limit is reached. <code>TimestampAscending</code> returns the oldest data first and paginates when the <code>MaxDatapoints</code> limit is reached.</p>"];
      max_datapoints: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of data points the request should return before paginating. If you omit this, the default of 100,800 is used.</p>"]}
    let make ~metric_data_queries  ~start_time  ~end_time  ?next_token 
      ?scan_by  ?max_datapoints  () =
      {
        metric_data_queries;
        start_time;
        end_time;
        next_token;
        scan_by;
        max_datapoints
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_datapoints
              (fun f -> ("max_datapoints", (Integer.to_json f)));
           Util.option_map v.scan_by
             (fun f -> ("scan_by", (ScanBy.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("end_time", (DateTime.to_json v.end_time));
           Some ("start_time", (DateTime.to_json v.start_time));
           Some
             ("metric_data_queries",
               (MetricDataQueries.to_json v.metric_data_queries))])
    let parse xml =
      Some
        {
          metric_data_queries =
            (Xml.required "MetricDataQueries"
               (Util.option_bind (Xml.member "MetricDataQueries" xml)
                  MetricDataQueries.parse));
          start_time =
            (Xml.required "StartTime"
               (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse));
          end_time =
            (Xml.required "EndTime"
               (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          scan_by = (Util.option_bind (Xml.member "ScanBy" xml) ScanBy.parse);
          max_datapoints =
            (Util.option_bind (Xml.member "MaxDatapoints" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "MetricDataQueries"
                           ([], (MetricDataQueries.to_xml [x]))))
                   v.metric_data_queries))
               @
               [Some
                  (Ezxmlm.make_tag "StartTime"
                     ([], (DateTime.to_xml v.start_time)))])
              @
              [Some
                 (Ezxmlm.make_tag "EndTime"
                    ([], (DateTime.to_xml v.end_time)))])
             @
             [Util.option_map v.next_token
                (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
            @
            [Util.option_map v.scan_by
               (fun f -> Ezxmlm.make_tag "ScanBy" ([], (ScanBy.to_xml f)))])
           @
           [Util.option_map v.max_datapoints
              (fun f ->
                 Ezxmlm.make_tag "MaxDatapoints" ([], (Integer.to_xml f)))])
  end
module GetMetricDataOutput = GetMetricDataOutput
type input = GetMetricDataInput.t
type output = GetMetricDataOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["GetMetricData"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetMetricDataInput.to_query req))))) in
  (`POST, uri, (Headers.render (GetMetricDataInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetMetricDataResponse" (snd xml))
        (Xml.member "GetMetricDataResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetMetricDataOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetMetricDataOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetMetricDataOutput - missing field in body or children: "
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