open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetMetricStatisticsInput =
  struct
    type t =
      {
      namespace: String.t
        [@ocaml.doc
          "<p>The namespace of the metric, with or without spaces.</p>"];
      metric_name: String.t
        [@ocaml.doc "<p>The name of the metric, with or without spaces.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>The dimensions. If the metric contains multiple dimensions, you must include a value for each dimension. CloudWatch treats each unique combination of dimensions as a separate metric. If a specific combination of dimensions was not published, you can't retrieve statistics for it. You must specify the same dimensions that were used when the metrics were created. For an example, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#dimension-combinations\">Dimension Combinations</a> in the <i>Amazon CloudWatch User Guide</i>. For more information about specifying dimensions, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html\">Publishing Metrics</a> in the <i>Amazon CloudWatch User Guide</i>.</p>"];
      start_time: DateTime.t
        [@ocaml.doc
          "<p>The time stamp that determines the first data point to return. Start times are evaluated relative to the time that CloudWatch receives the request.</p> <p>The value specified is inclusive; results include data points with the specified time stamp. In a raw HTTP query, the time stamp must be in ISO 8601 UTC format (for example, 2016-10-03T23:00:00Z).</p> <p>CloudWatch rounds the specified time stamp as follows:</p> <ul> <li> <p>Start time less than 15 days ago - Round down to the nearest whole minute. For example, 12:32:34 is rounded down to 12:32:00.</p> </li> <li> <p>Start time between 15 and 63 days ago - Round down to the nearest 5-minute clock interval. For example, 12:32:34 is rounded down to 12:30:00.</p> </li> <li> <p>Start time greater than 63 days ago - Round down to the nearest 1-hour clock interval. For example, 12:32:34 is rounded down to 12:00:00.</p> </li> </ul> <p>If you set <code>Period</code> to 5, 10, or 30, the start time of your request is rounded down to the nearest time that corresponds to even 5-, 10-, or 30-second divisions of a minute. For example, if you make a query at (HH:mm:ss) 01:05:23 for the previous 10-second period, the start time of your request is rounded down and you receive data from 01:05:10 to 01:05:20. If you make a query at 15:07:17 for the previous 5 minutes of data, using a period of 5 seconds, you receive data timestamped between 15:02:15 and 15:07:15. </p>"];
      end_time: DateTime.t
        [@ocaml.doc
          "<p>The time stamp that determines the last data point to return.</p> <p>The value specified is exclusive; results include data points up to the specified time stamp. In a raw HTTP query, the time stamp must be in ISO 8601 UTC format (for example, 2016-10-10T23:00:00Z).</p>"];
      period: Integer.t
        [@ocaml.doc
          "<p>The granularity, in seconds, of the returned data points. For metrics with regular resolution, a period can be as short as one minute (60 seconds) and must be a multiple of 60. For high-resolution metrics that are collected at intervals of less than one minute, the period can be 1, 5, 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics stored by a <code>PutMetricData</code> call that includes a <code>StorageResolution</code> of 1 second.</p> <p>If the <code>StartTime</code> parameter specifies a time stamp that is greater than 3 hours ago, you must specify the period as follows or no data points in that time range is returned:</p> <ul> <li> <p>Start time between 3 hours and 15 days ago - Use a multiple of 60 seconds (1 minute).</p> </li> <li> <p>Start time between 15 and 63 days ago - Use a multiple of 300 seconds (5 minutes).</p> </li> <li> <p>Start time greater than 63 days ago - Use a multiple of 3600 seconds (1 hour).</p> </li> </ul>"];
      statistics: Statistics.t
        [@ocaml.doc
          "<p>The metric statistics, other than percentile. For percentile statistics, use <code>ExtendedStatistics</code>. When calling <code>GetMetricStatistics</code>, you must specify either <code>Statistics</code> or <code>ExtendedStatistics</code>, but not both.</p>"];
      extended_statistics: ExtendedStatistics.t
        [@ocaml.doc
          "<p>The percentile statistics. Specify values between p0.0 and p100. When calling <code>GetMetricStatistics</code>, you must specify either <code>Statistics</code> or <code>ExtendedStatistics</code>, but not both. Percentile statistics are not available for metrics when any of the metric values are negative numbers.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc
          "<p>The unit for a given metric. If you omit <code>Unit</code>, all data that was collected with any unit is returned, along with the corresponding units that were specified when the data was reported to CloudWatch. If you specify a unit, the operation returns only data data that was collected with that unit specified. If you specify a unit that does not match the data collected, the results of the operation are null. CloudWatch does not perform unit conversions.</p>"]}
    let make ~namespace  ~metric_name  ?(dimensions= [])  ~start_time 
      ~end_time  ~period  ?(statistics= [])  ?(extended_statistics= []) 
      ?unit  () =
      {
        namespace;
        metric_name;
        dimensions;
        start_time;
        end_time;
        period;
        statistics;
        extended_statistics;
        unit
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.unit
              (fun f -> ("unit", (StandardUnit.to_json f)));
           Some
             ("extended_statistics",
               (ExtendedStatistics.to_json v.extended_statistics));
           Some ("statistics", (Statistics.to_json v.statistics));
           Some ("period", (Integer.to_json v.period));
           Some ("end_time", (DateTime.to_json v.end_time));
           Some ("start_time", (DateTime.to_json v.start_time));
           Some ("dimensions", (Dimensions.to_json v.dimensions));
           Some ("metric_name", (String.to_json v.metric_name));
           Some ("namespace", (String.to_json v.namespace))])
    let parse xml =
      Some
        {
          namespace =
            (Xml.required "Namespace"
               (Util.option_bind (Xml.member "Namespace" xml) String.parse));
          metric_name =
            (Xml.required "MetricName"
               (Util.option_bind (Xml.member "MetricName" xml) String.parse));
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  Dimensions.parse));
          start_time =
            (Xml.required "StartTime"
               (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse));
          end_time =
            (Xml.required "EndTime"
               (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse));
          period =
            (Xml.required "Period"
               (Util.option_bind (Xml.member "Period" xml) Integer.parse));
          statistics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Statistics" xml)
                  Statistics.parse));
          extended_statistics =
            (Util.of_option []
               (Util.option_bind (Xml.member "ExtendedStatistics" xml)
                  ExtendedStatistics.parse));
          unit =
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "Namespace"
                         ([], (String.to_xml v.namespace)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "MetricName"
                        ([], (String.to_xml v.metric_name)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "Dimensions"
                            ([], (Dimensions.to_xml [x])))) v.dimensions))
                @
                [Some
                   (Ezxmlm.make_tag "StartTime"
                      ([], (DateTime.to_xml v.start_time)))])
               @
               [Some
                  (Ezxmlm.make_tag "EndTime"
                     ([], (DateTime.to_xml v.end_time)))])
              @
              [Some
                 (Ezxmlm.make_tag "Period" ([], (Integer.to_xml v.period)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Statistics"
                        ([], (Statistics.to_xml [x])))) v.statistics))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ExtendedStatistics"
                       ([], (ExtendedStatistics.to_xml [x]))))
               v.extended_statistics))
           @
           [Util.option_map v.unit
              (fun f -> Ezxmlm.make_tag "Unit" ([], (StandardUnit.to_xml f)))])
  end
module GetMetricStatisticsOutput = GetMetricStatisticsOutput
type input = GetMetricStatisticsInput.t
type output = GetMetricStatisticsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["GetMetricStatistics"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetMetricStatisticsInput.to_query req))))) in
  (`POST, uri, (Headers.render (GetMetricStatisticsInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetMetricStatisticsResponse" (snd xml))
        (Xml.member "GetMetricStatisticsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetMetricStatisticsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetMetricStatisticsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetMetricStatisticsOutput - missing field in body or children: "
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