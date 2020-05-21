open Aws
open Aws.BaseTypes
module Dimension =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the dimension.</p>"];
      value: String.t
        [@ocaml.doc
          "<p>The value representing the dimension measurement.</p>"]}
    [@@ocaml.doc "<p>Expands the identity of a metric.</p>"]
    let make ~name  ~value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc "<p>Expands the identity of a metric.</p>"]
module Dimensions =
  struct
    type t = Dimension.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Dimension.to_query v
    let to_headers v = Headers.to_headers_list Dimension.to_headers v
    let to_json v = `List (List.map Dimension.to_json v)
    let parse xml =
      Util.option_all (List.map Dimension.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Dimension.to_xml x)))
        v
  end
module Metric =
  struct
    type t =
      {
      namespace: String.t option
        [@ocaml.doc "<p>The namespace of the metric.</p>"];
      metric_name: String.t option
        [@ocaml.doc
          "<p>The name of the metric. This is a required field.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc "<p>The dimensions for the metric.</p>"]}[@@ocaml.doc
                                                               "<p>Represents a specific metric.</p>"]
    let make ?namespace  ?metric_name  ?(dimensions= [])  () =
      { namespace; metric_name; dimensions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("dimensions", (Dimensions.to_json v.dimensions));
           Util.option_map v.metric_name
             (fun f -> ("metric_name", (String.to_json f)));
           Util.option_map v.namespace
             (fun f -> ("namespace", (String.to_json f)))])
    let parse xml =
      Some
        {
          namespace =
            (Util.option_bind (Xml.member "Namespace" xml) String.parse);
          metric_name =
            (Util.option_bind (Xml.member "MetricName" xml) String.parse);
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  Dimensions.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.namespace
                (fun f -> Ezxmlm.make_tag "Namespace" ([], (String.to_xml f)))])
            @
            [Util.option_map v.metric_name
               (fun f -> Ezxmlm.make_tag "MetricName" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Dimensions"
                      ([], (Dimensions.to_xml [x])))) v.dimensions))
  end[@@ocaml.doc "<p>Represents a specific metric.</p>"]
module StandardUnit =
  struct
    type t =
      | Seconds 
      | Microseconds 
      | Milliseconds 
      | Bytes 
      | Kilobytes 
      | Megabytes 
      | Gigabytes 
      | Terabytes 
      | Bits 
      | Kilobits 
      | Megabits 
      | Gigabits 
      | Terabits 
      | Percent 
      | Count 
      | Bytes_Second 
      | Kilobytes_Second 
      | Megabytes_Second 
      | Gigabytes_Second 
      | Terabytes_Second 
      | Bits_Second 
      | Kilobits_Second 
      | Megabits_Second 
      | Gigabits_Second 
      | Terabits_Second 
      | Count_Second 
      | None 
    let str_to_t =
      [("None", None);
      ("Count/Second", Count_Second);
      ("Terabits/Second", Terabits_Second);
      ("Gigabits/Second", Gigabits_Second);
      ("Megabits/Second", Megabits_Second);
      ("Kilobits/Second", Kilobits_Second);
      ("Bits/Second", Bits_Second);
      ("Terabytes/Second", Terabytes_Second);
      ("Gigabytes/Second", Gigabytes_Second);
      ("Megabytes/Second", Megabytes_Second);
      ("Kilobytes/Second", Kilobytes_Second);
      ("Bytes/Second", Bytes_Second);
      ("Count", Count);
      ("Percent", Percent);
      ("Terabits", Terabits);
      ("Gigabits", Gigabits);
      ("Megabits", Megabits);
      ("Kilobits", Kilobits);
      ("Bits", Bits);
      ("Terabytes", Terabytes);
      ("Gigabytes", Gigabytes);
      ("Megabytes", Megabytes);
      ("Kilobytes", Kilobytes);
      ("Bytes", Bytes);
      ("Milliseconds", Milliseconds);
      ("Microseconds", Microseconds);
      ("Seconds", Seconds)]
    let t_to_str =
      [(None, "None");
      (Count_Second, "Count/Second");
      (Terabits_Second, "Terabits/Second");
      (Gigabits_Second, "Gigabits/Second");
      (Megabits_Second, "Megabits/Second");
      (Kilobits_Second, "Kilobits/Second");
      (Bits_Second, "Bits/Second");
      (Terabytes_Second, "Terabytes/Second");
      (Gigabytes_Second, "Gigabytes/Second");
      (Megabytes_Second, "Megabytes/Second");
      (Kilobytes_Second, "Kilobytes/Second");
      (Bytes_Second, "Bytes/Second");
      (Count, "Count");
      (Percent, "Percent");
      (Terabits, "Terabits");
      (Gigabits, "Gigabits");
      (Megabits, "Megabits");
      (Kilobits, "Kilobits");
      (Bits, "Bits");
      (Terabytes, "Terabytes");
      (Gigabytes, "Gigabytes");
      (Megabytes, "Megabytes");
      (Kilobytes, "Kilobytes");
      (Bytes, "Bytes");
      (Milliseconds, "Milliseconds");
      (Microseconds, "Microseconds");
      (Seconds, "Seconds")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module Range =
  struct
    type t =
      {
      start_time: DateTime.t
        [@ocaml.doc
          "<p>The start time of the range to exclude. The format is <code>yyyy-MM-dd'T'HH:mm:ss</code>. For example, <code>2019-07-01T23:59:59</code>.</p>"];
      end_time: DateTime.t
        [@ocaml.doc
          "<p>The end time of the range to exclude. The format is <code>yyyy-MM-dd'T'HH:mm:ss</code>. For example, <code>2019-07-01T23:59:59</code>.</p>"]}
    [@@ocaml.doc
      "<p>Specifies one range of days or times to exclude from use for training an anomaly detection model.</p>"]
    let make ~start_time  ~end_time  () = { start_time; end_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("end_time", (DateTime.to_json v.end_time));
           Some ("start_time", (DateTime.to_json v.start_time))])
    let parse xml =
      Some
        {
          start_time =
            (Xml.required "StartTime"
               (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse));
          end_time =
            (Xml.required "EndTime"
               (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StartTime"
                  ([], (DateTime.to_xml v.start_time)))])
           @
           [Some
              (Ezxmlm.make_tag "EndTime" ([], (DateTime.to_xml v.end_time)))])
  end[@@ocaml.doc
       "<p>Specifies one range of days or times to exclude from use for training an anomaly detection model.</p>"]
module MetricStat =
  struct
    type t =
      {
      metric: Metric.t
        [@ocaml.doc
          "<p>The metric to return, including the metric name, namespace, and dimensions.</p>"];
      period: Integer.t
        [@ocaml.doc
          "<p>The granularity, in seconds, of the returned data points. For metrics with regular resolution, a period can be as short as one minute (60 seconds) and must be a multiple of 60. For high-resolution metrics that are collected at intervals of less than one minute, the period can be 1, 5, 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics stored by a <code>PutMetricData</code> call that includes a <code>StorageResolution</code> of 1 second.</p> <p>If the <code>StartTime</code> parameter specifies a time stamp that is greater than 3 hours ago, you must specify the period as follows or no data points in that time range is returned:</p> <ul> <li> <p>Start time between 3 hours and 15 days ago - Use a multiple of 60 seconds (1 minute).</p> </li> <li> <p>Start time between 15 and 63 days ago - Use a multiple of 300 seconds (5 minutes).</p> </li> <li> <p>Start time greater than 63 days ago - Use a multiple of 3600 seconds (1 hour).</p> </li> </ul>"];
      stat: String.t
        [@ocaml.doc
          "<p>The statistic to return. It can include any CloudWatch statistic or extended statistic.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc
          "<p>When you are using a <code>Put</code> operation, this defines what unit you want to use when storing the metric.</p> <p>In a <code>Get</code> operation, if you omit <code>Unit</code> then all data that was collected with any unit is returned, along with the corresponding units that were specified when the data was reported to CloudWatch. If you specify a unit, the operation returns only data data that was collected with that unit specified. If you specify a unit that does not match the data collected, the results of the operation are null. CloudWatch does not perform unit conversions.</p>"]}
    [@@ocaml.doc
      "<p>This structure defines the metric to be returned, along with the statistics, period, and units.</p>"]
    let make ~metric  ~period  ~stat  ?unit  () =
      { metric; period; stat; unit }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.unit
              (fun f -> ("unit", (StandardUnit.to_json f)));
           Some ("stat", (String.to_json v.stat));
           Some ("period", (Integer.to_json v.period));
           Some ("metric", (Metric.to_json v.metric))])
    let parse xml =
      Some
        {
          metric =
            (Xml.required "Metric"
               (Util.option_bind (Xml.member "Metric" xml) Metric.parse));
          period =
            (Xml.required "Period"
               (Util.option_bind (Xml.member "Period" xml) Integer.parse));
          stat =
            (Xml.required "Stat"
               (Util.option_bind (Xml.member "Stat" xml) String.parse));
          unit =
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Metric" ([], (Metric.to_xml v.metric)))])
             @
             [Some (Ezxmlm.make_tag "Period" ([], (Integer.to_xml v.period)))])
            @ [Some (Ezxmlm.make_tag "Stat" ([], (String.to_xml v.stat)))])
           @
           [Util.option_map v.unit
              (fun f -> Ezxmlm.make_tag "Unit" ([], (StandardUnit.to_xml f)))])
  end[@@ocaml.doc
       "<p>This structure defines the metric to be returned, along with the statistics, period, and units.</p>"]
module InsightRuleContributorDatapoint =
  struct
    type t =
      {
      timestamp: DateTime.t
        [@ocaml.doc "<p>The timestamp of the data point.</p>"];
      approximate_value: Double.t
        [@ocaml.doc
          "<p>The approximate value that this contributor added during this timestamp.</p>"]}
    [@@ocaml.doc
      "<p>One data point related to one contributor.</p> <p>For more information, see <a>GetInsightRuleReport</a> and <a>InsightRuleContributor</a>.</p>"]
    let make ~timestamp  ~approximate_value  () =
      { timestamp; approximate_value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("approximate_value", (Double.to_json v.approximate_value));
           Some ("timestamp", (DateTime.to_json v.timestamp))])
    let parse xml =
      Some
        {
          timestamp =
            (Xml.required "Timestamp"
               (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse));
          approximate_value =
            (Xml.required "ApproximateValue"
               (Util.option_bind (Xml.member "ApproximateValue" xml)
                  Double.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Timestamp"
                  ([], (DateTime.to_xml v.timestamp)))])
           @
           [Some
              (Ezxmlm.make_tag "ApproximateValue"
                 ([], (Double.to_xml v.approximate_value)))])
  end[@@ocaml.doc
       "<p>One data point related to one contributor.</p> <p>For more information, see <a>GetInsightRuleReport</a> and <a>InsightRuleContributor</a>.</p>"]
module AnomalyDetectorExcludedTimeRanges =
  struct
    type t = Range.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Range.to_query v
    let to_headers v = Headers.to_headers_list Range.to_headers v
    let to_json v = `List (List.map Range.to_json v)
    let parse xml =
      Util.option_all (List.map Range.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Range.to_xml x))) v
  end
module MetricDataQuery =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>A short name used to tie this object to the results in the response. This name must be unique within a single call to <code>GetMetricData</code>. If you are performing math expressions on this set of data, this name represents that data and can serve as a variable in the mathematical expression. The valid characters are letters, numbers, and underscore. The first character must be a lowercase letter.</p>"];
      metric_stat: MetricStat.t option
        [@ocaml.doc
          "<p>The metric to be returned, along with statistics, period, and units. Use this parameter only if this object is retrieving a metric and not performing a math expression on returned data.</p> <p>Within one MetricDataQuery object, you must specify either <code>Expression</code> or <code>MetricStat</code> but not both.</p>"];
      expression: String.t option
        [@ocaml.doc
          "<p>The math expression to be performed on the returned data, if this object is performing a math expression. This expression can use the <code>Id</code> of the other metrics to refer to those metrics, and can also use the <code>Id</code> of other expressions to use the result of those expressions. For more information about metric math expressions, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax\">Metric Math Syntax and Functions</a> in the <i>Amazon CloudWatch User Guide</i>.</p> <p>Within each MetricDataQuery object, you must specify either <code>Expression</code> or <code>MetricStat</code> but not both.</p>"];
      label: String.t option
        [@ocaml.doc
          "<p>A human-readable label for this metric or expression. This is especially useful if this is an expression, so that you know what the value represents. If the metric or expression is shown in a CloudWatch dashboard widget, the label is shown. If Label is omitted, CloudWatch generates a default.</p>"];
      return_data: Boolean.t option
        [@ocaml.doc
          "<p>When used in <code>GetMetricData</code>, this option indicates whether to return the timestamps and raw data values of this metric. If you are performing this call just to do math expressions and do not also need the raw data returned, you can specify <code>False</code>. If you omit this, the default of <code>True</code> is used.</p> <p>When used in <code>PutMetricAlarm</code>, specify <code>True</code> for the one expression result to use as the alarm. For all other metrics and expressions in the same <code>PutMetricAlarm</code> operation, specify <code>ReturnData</code> as False.</p>"];
      period: Integer.t option
        [@ocaml.doc
          "<p>The granularity, in seconds, of the returned data points. For metrics with regular resolution, a period can be as short as one minute (60 seconds) and must be a multiple of 60. For high-resolution metrics that are collected at intervals of less than one minute, the period can be 1, 5, 10, 30, 60, or any multiple of 60. High-resolution metrics are those metrics stored by a <code>PutMetricData</code> operation that includes a <code>StorageResolution of 1 second</code>.</p> <p>If you are performing a <code>GetMetricData</code> operation, use this field only if you are specifying an <code>Expression</code>. Do not use this field when you are specifying a <code>MetricStat</code> in a <code>GetMetricData</code> operation.</p>"]}
    [@@ocaml.doc
      "<p>This structure is used in both <code>GetMetricData</code> and <code>PutMetricAlarm</code>. The supported use of this structure is different for those two operations.</p> <p>When used in <code>GetMetricData</code>, it indicates the metric data to return, and whether this call is just retrieving a batch set of data for one metric, or is performing a math expression on metric data. A single <code>GetMetricData</code> call can include up to 100 <code>MetricDataQuery</code> structures.</p> <p>When used in <code>PutMetricAlarm</code>, it enables you to create an alarm based on a metric math expression. Each <code>MetricDataQuery</code> in the array specifies either a metric to retrieve, or a math expression to be performed on retrieved metrics. A single <code>PutMetricAlarm</code> call can include up to 20 <code>MetricDataQuery</code> structures in the array. The 20 structures can include as many as 10 structures that contain a <code>MetricStat</code> parameter to retrieve a metric, and as many as 10 structures that contain the <code>Expression</code> parameter to perform a math expression. Of those <code>Expression</code> structures, one must have <code>True</code> as the value for <code>ReturnData</code>. The result of this expression is the value the alarm watches.</p> <p>Any expression used in a <code>PutMetricAlarm</code> operation must return a single time series. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax\">Metric Math Syntax and Functions</a> in the <i>Amazon CloudWatch User Guide</i>.</p> <p>Some of the parameters of this structure also have different uses whether you are using this structure in a <code>GetMetricData</code> operation or a <code>PutMetricAlarm</code> operation. These differences are explained in the following parameter list.</p>"]
    let make ~id  ?metric_stat  ?expression  ?label  ?return_data  ?period 
      () = { id; metric_stat; expression; label; return_data; period }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.period
              (fun f -> ("period", (Integer.to_json f)));
           Util.option_map v.return_data
             (fun f -> ("return_data", (Boolean.to_json f)));
           Util.option_map v.label (fun f -> ("label", (String.to_json f)));
           Util.option_map v.expression
             (fun f -> ("expression", (String.to_json f)));
           Util.option_map v.metric_stat
             (fun f -> ("metric_stat", (MetricStat.to_json f)));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          metric_stat =
            (Util.option_bind (Xml.member "MetricStat" xml) MetricStat.parse);
          expression =
            (Util.option_bind (Xml.member "Expression" xml) String.parse);
          label = (Util.option_bind (Xml.member "Label" xml) String.parse);
          return_data =
            (Util.option_bind (Xml.member "ReturnData" xml) Boolean.parse);
          period = (Util.option_bind (Xml.member "Period" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
               @
               [Util.option_map v.metric_stat
                  (fun f ->
                     Ezxmlm.make_tag "MetricStat" ([], (MetricStat.to_xml f)))])
              @
              [Util.option_map v.expression
                 (fun f ->
                    Ezxmlm.make_tag "Expression" ([], (String.to_xml f)))])
             @
             [Util.option_map v.label
                (fun f -> Ezxmlm.make_tag "Label" ([], (String.to_xml f)))])
            @
            [Util.option_map v.return_data
               (fun f ->
                  Ezxmlm.make_tag "ReturnData" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.period
              (fun f -> Ezxmlm.make_tag "Period" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>This structure is used in both <code>GetMetricData</code> and <code>PutMetricAlarm</code>. The supported use of this structure is different for those two operations.</p> <p>When used in <code>GetMetricData</code>, it indicates the metric data to return, and whether this call is just retrieving a batch set of data for one metric, or is performing a math expression on metric data. A single <code>GetMetricData</code> call can include up to 100 <code>MetricDataQuery</code> structures.</p> <p>When used in <code>PutMetricAlarm</code>, it enables you to create an alarm based on a metric math expression. Each <code>MetricDataQuery</code> in the array specifies either a metric to retrieve, or a math expression to be performed on retrieved metrics. A single <code>PutMetricAlarm</code> call can include up to 20 <code>MetricDataQuery</code> structures in the array. The 20 structures can include as many as 10 structures that contain a <code>MetricStat</code> parameter to retrieve a metric, and as many as 10 structures that contain the <code>Expression</code> parameter to perform a math expression. Of those <code>Expression</code> structures, one must have <code>True</code> as the value for <code>ReturnData</code>. The result of this expression is the value the alarm watches.</p> <p>Any expression used in a <code>PutMetricAlarm</code> operation must return a single time series. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/using-metric-math.html#metric-math-syntax\">Metric Math Syntax and Functions</a> in the <i>Amazon CloudWatch User Guide</i>.</p> <p>Some of the parameters of this structure also have different uses whether you are using this structure in a <code>GetMetricData</code> operation or a <code>PutMetricAlarm</code> operation. These differences are explained in the following parameter list.</p>"]
module MessageData =
  struct
    type t =
      {
      code: String.t option
        [@ocaml.doc
          "<p>The error code or status code associated with the message.</p>"];
      value: String.t option [@ocaml.doc "<p>The message text.</p>"]}
    [@@ocaml.doc
      "<p>A message returned by the <code>GetMetricData</code>API, including a code and a description.</p>"]
    let make ?code  ?value  () = { code; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.code (fun f -> ("code", (String.to_json f)))])
    let parse xml =
      Some
        {
          code = (Util.option_bind (Xml.member "Code" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.code
               (fun f -> Ezxmlm.make_tag "Code" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A message returned by the <code>GetMetricData</code>API, including a code and a description.</p>"]
module HistoryItemType =
  struct
    type t =
      | ConfigurationUpdate 
      | StateUpdate 
      | Action 
    let str_to_t =
      [("Action", Action);
      ("StateUpdate", StateUpdate);
      ("ConfigurationUpdate", ConfigurationUpdate)]
    let t_to_str =
      [(Action, "Action");
      (StateUpdate, "StateUpdate");
      (ConfigurationUpdate, "ConfigurationUpdate")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module InsightRuleContributorDatapoints =
  struct
    type t = InsightRuleContributorDatapoint.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list InsightRuleContributorDatapoint.to_query v
    let to_headers v =
      Headers.to_headers_list InsightRuleContributorDatapoint.to_headers v
    let to_json v =
      `List (List.map InsightRuleContributorDatapoint.to_json v)
    let parse xml =
      Util.option_all
        (List.map InsightRuleContributorDatapoint.parse
           (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (InsightRuleContributorDatapoint.to_xml x))) v
  end
module InsightRuleContributorKeys =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module AnomalyDetectorConfiguration =
  struct
    type t =
      {
      excluded_time_ranges: AnomalyDetectorExcludedTimeRanges.t
        [@ocaml.doc
          "<p>An array of time ranges to exclude from use when the anomaly detection model is trained. Use this to make sure that events that could cause unusual values for the metric, such as deployments, aren't used when CloudWatch creates the model.</p>"];
      metric_timezone: String.t option
        [@ocaml.doc
          "<p>The time zone to use for the metric. This is useful to enable the model to automatically account for daylight savings time changes if the metric is sensitive to such time changes.</p> <p>To specify a time zone, use the name of the time zone as specified in the standard tz database. For more information, see <a href=\"https://en.wikipedia.org/wiki/Tz_database\">tz database</a>.</p>"]}
    [@@ocaml.doc
      "<p>The configuration specifies details about how the anomaly detection model is to be trained, including time ranges to exclude from use for training the model and the time zone to use for the metric.</p>"]
    let make ?(excluded_time_ranges= [])  ?metric_timezone  () =
      { excluded_time_ranges; metric_timezone }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metric_timezone
              (fun f -> ("metric_timezone", (String.to_json f)));
           Some
             ("excluded_time_ranges",
               (AnomalyDetectorExcludedTimeRanges.to_json
                  v.excluded_time_ranges))])
    let parse xml =
      Some
        {
          excluded_time_ranges =
            (Util.of_option []
               (Util.option_bind (Xml.member "ExcludedTimeRanges" xml)
                  AnomalyDetectorExcludedTimeRanges.parse));
          metric_timezone =
            (Util.option_bind (Xml.member "MetricTimezone" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ExcludedTimeRanges"
                       ([], (AnomalyDetectorExcludedTimeRanges.to_xml [x]))))
               v.excluded_time_ranges))
           @
           [Util.option_map v.metric_timezone
              (fun f ->
                 Ezxmlm.make_tag "MetricTimezone" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The configuration specifies details about how the anomaly detection model is to be trained, including time ranges to exclude from use for training the model and the time zone to use for the metric.</p>"]
module ComparisonOperator =
  struct
    type t =
      | GreaterThanOrEqualToThreshold 
      | GreaterThanThreshold 
      | LessThanThreshold 
      | LessThanOrEqualToThreshold 
      | LessThanLowerOrGreaterThanUpperThreshold 
      | LessThanLowerThreshold 
      | GreaterThanUpperThreshold 
    let str_to_t =
      [("GreaterThanUpperThreshold", GreaterThanUpperThreshold);
      ("LessThanLowerThreshold", LessThanLowerThreshold);
      ("LessThanLowerOrGreaterThanUpperThreshold",
        LessThanLowerOrGreaterThanUpperThreshold);
      ("LessThanOrEqualToThreshold", LessThanOrEqualToThreshold);
      ("LessThanThreshold", LessThanThreshold);
      ("GreaterThanThreshold", GreaterThanThreshold);
      ("GreaterThanOrEqualToThreshold", GreaterThanOrEqualToThreshold)]
    let t_to_str =
      [(GreaterThanUpperThreshold, "GreaterThanUpperThreshold");
      (LessThanLowerThreshold, "LessThanLowerThreshold");
      (LessThanLowerOrGreaterThanUpperThreshold,
        "LessThanLowerOrGreaterThanUpperThreshold");
      (LessThanOrEqualToThreshold, "LessThanOrEqualToThreshold");
      (LessThanThreshold, "LessThanThreshold");
      (GreaterThanThreshold, "GreaterThanThreshold");
      (GreaterThanOrEqualToThreshold, "GreaterThanOrEqualToThreshold")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module MetricDataQueries =
  struct
    type t = MetricDataQuery.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricDataQuery.to_query v
    let to_headers v = Headers.to_headers_list MetricDataQuery.to_headers v
    let to_json v = `List (List.map MetricDataQuery.to_json v)
    let parse xml =
      Util.option_all
        (List.map MetricDataQuery.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetricDataQuery.to_xml x)))
        v
  end
module ResourceList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module StateValue =
  struct
    type t =
      | OK 
      | ALARM 
      | INSUFFICIENT_DATA 
    let str_to_t =
      [("INSUFFICIENT_DATA", INSUFFICIENT_DATA);
      ("ALARM", ALARM);
      ("OK", OK)]
    let t_to_str =
      [(INSUFFICIENT_DATA, "INSUFFICIENT_DATA");
      (ALARM, "ALARM");
      (OK, "OK")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module Statistic =
  struct
    type t =
      | SampleCount 
      | Average 
      | Sum 
      | Minimum 
      | Maximum 
    let str_to_t =
      [("Maximum", Maximum);
      ("Minimum", Minimum);
      ("Sum", Sum);
      ("Average", Average);
      ("SampleCount", SampleCount)]
    let t_to_str =
      [(Maximum, "Maximum");
      (Minimum, "Minimum");
      (Sum, "Sum");
      (Average, "Average");
      (SampleCount, "SampleCount")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module DatapointValues =
  struct
    type t = Double.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Double.to_query v
    let to_headers v = Headers.to_headers_list Double.to_headers v
    let to_json v = `List (List.map Double.to_json v)
    let parse xml =
      Util.option_all (List.map Double.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Double.to_xml x))) v
  end
module MetricDataResultMessages =
  struct
    type t = MessageData.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MessageData.to_query v
    let to_headers v = Headers.to_headers_list MessageData.to_headers v
    let to_json v = `List (List.map MessageData.to_json v)
    let parse xml =
      Util.option_all (List.map MessageData.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MessageData.to_xml x))) v
  end
module StatusCode =
  struct
    type t =
      | Complete 
      | InternalError 
      | PartialData 
    let str_to_t =
      [("PartialData", PartialData);
      ("InternalError", InternalError);
      ("Complete", Complete)]
    let t_to_str =
      [(PartialData, "PartialData");
      (InternalError, "InternalError");
      (Complete, "Complete")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module Timestamps =
  struct
    type t = DateTime.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DateTime.to_query v
    let to_headers v = Headers.to_headers_list DateTime.to_headers v
    let to_json v = `List (List.map DateTime.to_json v)
    let parse xml =
      Util.option_all (List.map DateTime.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (DateTime.to_xml x)))
        v
  end
module Counts =
  struct
    type t = Double.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Double.to_query v
    let to_headers v = Headers.to_headers_list Double.to_headers v
    let to_json v = `List (List.map Double.to_json v)
    let parse xml =
      Util.option_all (List.map Double.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Double.to_xml x))) v
  end
module StatisticSet =
  struct
    type t =
      {
      sample_count: Double.t
        [@ocaml.doc
          "<p>The number of samples used for the statistic set.</p>"];
      sum: Double.t
        [@ocaml.doc "<p>The sum of values for the sample set.</p>"];
      minimum: Double.t
        [@ocaml.doc "<p>The minimum value of the sample set.</p>"];
      maximum: Double.t
        [@ocaml.doc "<p>The maximum value of the sample set.</p>"]}[@@ocaml.doc
                                                                    "<p>Represents a set of statistics that describes a specific metric. </p>"]
    let make ~sample_count  ~sum  ~minimum  ~maximum  () =
      { sample_count; sum; minimum; maximum }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("maximum", (Double.to_json v.maximum));
           Some ("minimum", (Double.to_json v.minimum));
           Some ("sum", (Double.to_json v.sum));
           Some ("sample_count", (Double.to_json v.sample_count))])
    let parse xml =
      Some
        {
          sample_count =
            (Xml.required "SampleCount"
               (Util.option_bind (Xml.member "SampleCount" xml) Double.parse));
          sum =
            (Xml.required "Sum"
               (Util.option_bind (Xml.member "Sum" xml) Double.parse));
          minimum =
            (Xml.required "Minimum"
               (Util.option_bind (Xml.member "Minimum" xml) Double.parse));
          maximum =
            (Xml.required "Maximum"
               (Util.option_bind (Xml.member "Maximum" xml) Double.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "SampleCount"
                    ([], (Double.to_xml v.sample_count)))])
             @ [Some (Ezxmlm.make_tag "Sum" ([], (Double.to_xml v.sum)))])
            @
            [Some (Ezxmlm.make_tag "Minimum" ([], (Double.to_xml v.minimum)))])
           @
           [Some (Ezxmlm.make_tag "Maximum" ([], (Double.to_xml v.maximum)))])
  end[@@ocaml.doc
       "<p>Represents a set of statistics that describes a specific metric. </p>"]
module Values =
  struct
    type t = Double.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Double.to_query v
    let to_headers v = Headers.to_headers_list Double.to_headers v
    let to_json v = `List (List.map Double.to_json v)
    let parse xml =
      Util.option_all (List.map Double.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Double.to_xml x))) v
  end
module DatapointValueMap =
  struct
    type t = (String.t, Double.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string Double.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc -> ((String.to_string k), (Double.to_json v)) :: acc)
           v [])
    let parse xml = None
    let to_xml v = []
  end
module AlarmHistoryItem =
  struct
    type t =
      {
      alarm_name: String.t option
        [@ocaml.doc "<p>The descriptive name for the alarm.</p>"];
      timestamp: DateTime.t option
        [@ocaml.doc "<p>The time stamp for the alarm history item.</p>"];
      history_item_type: HistoryItemType.t option
        [@ocaml.doc "<p>The type of alarm history item.</p>"];
      history_summary: String.t option
        [@ocaml.doc "<p>A summary of the alarm history, in text format.</p>"];
      history_data: String.t option
        [@ocaml.doc "<p>Data about the alarm, in JSON format.</p>"]}[@@ocaml.doc
                                                                    "<p>Represents the history of a specific alarm.</p>"]
    let make ?alarm_name  ?timestamp  ?history_item_type  ?history_summary 
      ?history_data  () =
      {
        alarm_name;
        timestamp;
        history_item_type;
        history_summary;
        history_data
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.history_data
              (fun f -> ("history_data", (String.to_json f)));
           Util.option_map v.history_summary
             (fun f -> ("history_summary", (String.to_json f)));
           Util.option_map v.history_item_type
             (fun f -> ("history_item_type", (HistoryItemType.to_json f)));
           Util.option_map v.timestamp
             (fun f -> ("timestamp", (DateTime.to_json f)));
           Util.option_map v.alarm_name
             (fun f -> ("alarm_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          alarm_name =
            (Util.option_bind (Xml.member "AlarmName" xml) String.parse);
          timestamp =
            (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse);
          history_item_type =
            (Util.option_bind (Xml.member "HistoryItemType" xml)
               HistoryItemType.parse);
          history_summary =
            (Util.option_bind (Xml.member "HistorySummary" xml) String.parse);
          history_data =
            (Util.option_bind (Xml.member "HistoryData" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.alarm_name
                  (fun f ->
                     Ezxmlm.make_tag "AlarmName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.timestamp
                 (fun f ->
                    Ezxmlm.make_tag "Timestamp" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.history_item_type
                (fun f ->
                   Ezxmlm.make_tag "HistoryItemType"
                     ([], (HistoryItemType.to_xml f)))])
            @
            [Util.option_map v.history_summary
               (fun f ->
                  Ezxmlm.make_tag "HistorySummary" ([], (String.to_xml f)))])
           @
           [Util.option_map v.history_data
              (fun f -> Ezxmlm.make_tag "HistoryData" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Represents the history of a specific alarm.</p>"]
module PartialFailure =
  struct
    type t =
      {
      failure_resource: String.t option
        [@ocaml.doc "<p>The specified rule that could not be deleted.</p>"];
      exception_type: String.t option
        [@ocaml.doc "<p>The type of error.</p>"];
      failure_code: String.t option
        [@ocaml.doc "<p>The code of the error.</p>"];
      failure_description: String.t option
        [@ocaml.doc "<p>A description of the error.</p>"]}[@@ocaml.doc
                                                            "<p>This array is empty if the API operation was successful for all the rules specified in the request. If the operation could not process one of the rules, the following data is returned for each of those rules.</p>"]
    let make ?failure_resource  ?exception_type  ?failure_code 
      ?failure_description  () =
      { failure_resource; exception_type; failure_code; failure_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.failure_description
              (fun f -> ("failure_description", (String.to_json f)));
           Util.option_map v.failure_code
             (fun f -> ("failure_code", (String.to_json f)));
           Util.option_map v.exception_type
             (fun f -> ("exception_type", (String.to_json f)));
           Util.option_map v.failure_resource
             (fun f -> ("failure_resource", (String.to_json f)))])
    let parse xml =
      Some
        {
          failure_resource =
            (Util.option_bind (Xml.member "FailureResource" xml) String.parse);
          exception_type =
            (Util.option_bind (Xml.member "ExceptionType" xml) String.parse);
          failure_code =
            (Util.option_bind (Xml.member "FailureCode" xml) String.parse);
          failure_description =
            (Util.option_bind (Xml.member "FailureDescription" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.failure_resource
                 (fun f ->
                    Ezxmlm.make_tag "FailureResource" ([], (String.to_xml f)))])
             @
             [Util.option_map v.exception_type
                (fun f ->
                   Ezxmlm.make_tag "ExceptionType" ([], (String.to_xml f)))])
            @
            [Util.option_map v.failure_code
               (fun f ->
                  Ezxmlm.make_tag "FailureCode" ([], (String.to_xml f)))])
           @
           [Util.option_map v.failure_description
              (fun f ->
                 Ezxmlm.make_tag "FailureDescription" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This array is empty if the API operation was successful for all the rules specified in the request. If the operation could not process one of the rules, the following data is returned for each of those rules.</p>"]
module DimensionFilter =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The dimension name to be matched.</p>"];
      value: String.t option
        [@ocaml.doc "<p>The value of the dimension to be matched.</p>"]}
    [@@ocaml.doc "<p>Represents filters for a dimension.</p>"]
    let make ~name  ?value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Represents filters for a dimension.</p>"]
module Tag =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>A string that you can use to assign a value. The combination of tag keys and values can help you organize and categorize your resources.</p>"];
      value: String.t
        [@ocaml.doc "<p>The value for the specified tag key.</p>"]}[@@ocaml.doc
                                                                    "<p>A key-value pair associated with a CloudWatch resource.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key))])
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>A key-value pair associated with a CloudWatch resource.</p>"]
module InsightRuleContributor =
  struct
    type t =
      {
      keys: InsightRuleContributorKeys.t
        [@ocaml.doc
          "<p>One of the log entry field keywords that is used to define contributors for this rule.</p>"];
      approximate_aggregate_value: Double.t
        [@ocaml.doc
          "<p>An approximation of the aggregate value that comes from this contributor.</p>"];
      datapoints: InsightRuleContributorDatapoints.t
        [@ocaml.doc
          "<p>An array of the data points where this contributor is present. Only the data points when this contributor appeared are included in the array.</p>"]}
    [@@ocaml.doc
      "<p>One of the unique contributors found by a Contributor Insights rule. If the rule contains multiple keys, then a unique contributor is a unique combination of values from all the keys in the rule.</p> <p>If the rule contains a single key, then each unique contributor is each unique value for this key.</p> <p>For more information, see <a>GetInsightRuleReport</a>.</p>"]
    let make ~keys  ~approximate_aggregate_value  ~datapoints  () =
      { keys; approximate_aggregate_value; datapoints }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("datapoints",
                (InsightRuleContributorDatapoints.to_json v.datapoints));
           Some
             ("approximate_aggregate_value",
               (Double.to_json v.approximate_aggregate_value));
           Some ("keys", (InsightRuleContributorKeys.to_json v.keys))])
    let parse xml =
      Some
        {
          keys =
            (Xml.required "Keys"
               (Util.option_bind (Xml.member "Keys" xml)
                  InsightRuleContributorKeys.parse));
          approximate_aggregate_value =
            (Xml.required "ApproximateAggregateValue"
               (Util.option_bind (Xml.member "ApproximateAggregateValue" xml)
                  Double.parse));
          datapoints =
            (Xml.required "Datapoints"
               (Util.option_bind (Xml.member "Datapoints" xml)
                  InsightRuleContributorDatapoints.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Keys"
                        ([], (InsightRuleContributorKeys.to_xml [x]))))
                v.keys))
            @
            [Some
               (Ezxmlm.make_tag "ApproximateAggregateValue"
                  ([], (Double.to_xml v.approximate_aggregate_value)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Datapoints"
                      ([], (InsightRuleContributorDatapoints.to_xml [x]))))
              v.datapoints))
  end[@@ocaml.doc
       "<p>One of the unique contributors found by a Contributor Insights rule. If the rule contains multiple keys, then a unique contributor is a unique combination of values from all the keys in the rule.</p> <p>If the rule contains a single key, then each unique contributor is each unique value for this key.</p> <p>For more information, see <a>GetInsightRuleReport</a>.</p>"]
module InsightRuleMetricDatapoint =
  struct
    type t =
      {
      timestamp: DateTime.t
        [@ocaml.doc "<p>The timestamp of the data point.</p>"];
      unique_contributors: Double.t option
        [@ocaml.doc
          "<p>The number of unique contributors who published data during this timestamp.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"];
      max_contributor_value: Double.t option
        [@ocaml.doc
          "<p>The maximum value provided by one contributor during this timestamp. Each timestamp is evaluated separately, so the identity of the max contributor could be different for each timestamp.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"];
      sample_count: Double.t option
        [@ocaml.doc
          "<p>The number of occurrences that matched the rule during this data point.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"];
      average: Double.t option
        [@ocaml.doc
          "<p>The average value from all contributors during the time period represented by that data point.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"];
      sum: Double.t option
        [@ocaml.doc
          "<p>The sum of the values from all contributors during the time period represented by that data point.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"];
      minimum: Double.t option
        [@ocaml.doc
          "<p>The minimum value from a single contributor during the time period represented by that data point.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"];
      maximum: Double.t option
        [@ocaml.doc
          "<p>The maximum value from a single occurence from a single contributor during the time period represented by that data point.</p> <p>This statistic is returned only if you included it in the <code>Metrics</code> array in your request.</p>"]}
    [@@ocaml.doc
      "<p>One data point from the metric time series returned in a Contributor Insights rule report.</p> <p>For more information, see <a>GetInsightRuleReport</a>.</p>"]
    let make ~timestamp  ?unique_contributors  ?max_contributor_value 
      ?sample_count  ?average  ?sum  ?minimum  ?maximum  () =
      {
        timestamp;
        unique_contributors;
        max_contributor_value;
        sample_count;
        average;
        sum;
        minimum;
        maximum
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.maximum
              (fun f -> ("maximum", (Double.to_json f)));
           Util.option_map v.minimum
             (fun f -> ("minimum", (Double.to_json f)));
           Util.option_map v.sum (fun f -> ("sum", (Double.to_json f)));
           Util.option_map v.average
             (fun f -> ("average", (Double.to_json f)));
           Util.option_map v.sample_count
             (fun f -> ("sample_count", (Double.to_json f)));
           Util.option_map v.max_contributor_value
             (fun f -> ("max_contributor_value", (Double.to_json f)));
           Util.option_map v.unique_contributors
             (fun f -> ("unique_contributors", (Double.to_json f)));
           Some ("timestamp", (DateTime.to_json v.timestamp))])
    let parse xml =
      Some
        {
          timestamp =
            (Xml.required "Timestamp"
               (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse));
          unique_contributors =
            (Util.option_bind (Xml.member "UniqueContributors" xml)
               Double.parse);
          max_contributor_value =
            (Util.option_bind (Xml.member "MaxContributorValue" xml)
               Double.parse);
          sample_count =
            (Util.option_bind (Xml.member "SampleCount" xml) Double.parse);
          average =
            (Util.option_bind (Xml.member "Average" xml) Double.parse);
          sum = (Util.option_bind (Xml.member "Sum" xml) Double.parse);
          minimum =
            (Util.option_bind (Xml.member "Minimum" xml) Double.parse);
          maximum =
            (Util.option_bind (Xml.member "Maximum" xml) Double.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "Timestamp"
                        ([], (DateTime.to_xml v.timestamp)))])
                 @
                 [Util.option_map v.unique_contributors
                    (fun f ->
                       Ezxmlm.make_tag "UniqueContributors"
                         ([], (Double.to_xml f)))])
                @
                [Util.option_map v.max_contributor_value
                   (fun f ->
                      Ezxmlm.make_tag "MaxContributorValue"
                        ([], (Double.to_xml f)))])
               @
               [Util.option_map v.sample_count
                  (fun f ->
                     Ezxmlm.make_tag "SampleCount" ([], (Double.to_xml f)))])
              @
              [Util.option_map v.average
                 (fun f -> Ezxmlm.make_tag "Average" ([], (Double.to_xml f)))])
             @
             [Util.option_map v.sum
                (fun f -> Ezxmlm.make_tag "Sum" ([], (Double.to_xml f)))])
            @
            [Util.option_map v.minimum
               (fun f -> Ezxmlm.make_tag "Minimum" ([], (Double.to_xml f)))])
           @
           [Util.option_map v.maximum
              (fun f -> Ezxmlm.make_tag "Maximum" ([], (Double.to_xml f)))])
  end[@@ocaml.doc
       "<p>One data point from the metric time series returned in a Contributor Insights rule report.</p> <p>For more information, see <a>GetInsightRuleReport</a>.</p>"]
module AnomalyDetector =
  struct
    type t =
      {
      namespace: String.t option
        [@ocaml.doc
          "<p>The namespace of the metric associated with the anomaly detection model.</p>"];
      metric_name: String.t option
        [@ocaml.doc
          "<p>The name of the metric associated with the anomaly detection model.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>The metric dimensions associated with the anomaly detection model.</p>"];
      stat: String.t option
        [@ocaml.doc
          "<p>The statistic associated with the anomaly detection model.</p>"];
      configuration: AnomalyDetectorConfiguration.t option
        [@ocaml.doc
          "<p>The configuration specifies details about how the anomaly detection model is to be trained, including time ranges to exclude from use for training the model, and the time zone to use for the metric.</p>"]}
    [@@ocaml.doc
      "<p>An anomaly detection model associated with a particular CloudWatch metric and statistic. You can use the model to display a band of expected normal values when the metric is graphed.</p>"]
    let make ?namespace  ?metric_name  ?(dimensions= [])  ?stat 
      ?configuration  () =
      { namespace; metric_name; dimensions; stat; configuration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.configuration
              (fun f ->
                 ("configuration", (AnomalyDetectorConfiguration.to_json f)));
           Util.option_map v.stat (fun f -> ("stat", (String.to_json f)));
           Some ("dimensions", (Dimensions.to_json v.dimensions));
           Util.option_map v.metric_name
             (fun f -> ("metric_name", (String.to_json f)));
           Util.option_map v.namespace
             (fun f -> ("namespace", (String.to_json f)))])
    let parse xml =
      Some
        {
          namespace =
            (Util.option_bind (Xml.member "Namespace" xml) String.parse);
          metric_name =
            (Util.option_bind (Xml.member "MetricName" xml) String.parse);
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  Dimensions.parse));
          stat = (Util.option_bind (Xml.member "Stat" xml) String.parse);
          configuration =
            (Util.option_bind (Xml.member "Configuration" xml)
               AnomalyDetectorConfiguration.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.namespace
                  (fun f ->
                     Ezxmlm.make_tag "Namespace" ([], (String.to_xml f)))])
              @
              [Util.option_map v.metric_name
                 (fun f ->
                    Ezxmlm.make_tag "MetricName" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Dimensions"
                        ([], (Dimensions.to_xml [x])))) v.dimensions))
            @
            [Util.option_map v.stat
               (fun f -> Ezxmlm.make_tag "Stat" ([], (String.to_xml f)))])
           @
           [Util.option_map v.configuration
              (fun f ->
                 Ezxmlm.make_tag "Configuration"
                   ([], (AnomalyDetectorConfiguration.to_xml f)))])
  end[@@ocaml.doc
       "<p>An anomaly detection model associated with a particular CloudWatch metric and statistic. You can use the model to display a band of expected normal values when the metric is graphed.</p>"]
module MetricAlarm =
  struct
    type t =
      {
      alarm_name: String.t option
        [@ocaml.doc "<p>The name of the alarm.</p>"];
      alarm_arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the alarm.</p>"];
      alarm_description: String.t option
        [@ocaml.doc "<p>The description of the alarm.</p>"];
      alarm_configuration_updated_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time stamp of the last update to the alarm configuration.</p>"];
      actions_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether actions should be executed during any changes to the alarm state.</p>"];
      o_k_actions: ResourceList.t
        [@ocaml.doc
          "<p>The actions to execute when this alarm transitions to the <code>OK</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p>"];
      alarm_actions: ResourceList.t
        [@ocaml.doc
          "<p>The actions to execute when this alarm transitions to the <code>ALARM</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p>"];
      insufficient_data_actions: ResourceList.t
        [@ocaml.doc
          "<p>The actions to execute when this alarm transitions to the <code>INSUFFICIENT_DATA</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN).</p>"];
      state_value: StateValue.t option
        [@ocaml.doc "<p>The state value for the alarm.</p>"];
      state_reason: String.t option
        [@ocaml.doc
          "<p>An explanation for the alarm state, in text format.</p>"];
      state_reason_data: String.t option
        [@ocaml.doc
          "<p>An explanation for the alarm state, in JSON format.</p>"];
      state_updated_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time stamp of the last update to the alarm state.</p>"];
      metric_name: String.t option
        [@ocaml.doc
          "<p>The name of the metric associated with the alarm, if this is an alarm based on a single metric.</p>"];
      namespace: String.t option
        [@ocaml.doc
          "<p>The namespace of the metric associated with the alarm.</p>"];
      statistic: Statistic.t option
        [@ocaml.doc
          "<p>The statistic for the metric associated with the alarm, other than percentile. For percentile statistics, use <code>ExtendedStatistic</code>.</p>"];
      extended_statistic: String.t option
        [@ocaml.doc
          "<p>The percentile statistic for the metric associated with the alarm. Specify a value between p0.0 and p100.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>The dimensions for the metric associated with the alarm.</p>"];
      period: Integer.t option
        [@ocaml.doc
          "<p>The period, in seconds, over which the statistic is applied.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc
          "<p>The unit of the metric associated with the alarm.</p>"];
      evaluation_periods: Integer.t option
        [@ocaml.doc
          "<p>The number of periods over which data is compared to the specified threshold.</p>"];
      datapoints_to_alarm: Integer.t option
        [@ocaml.doc
          "<p>The number of data points that must be breaching to trigger the alarm.</p>"];
      threshold: Double.t option
        [@ocaml.doc
          "<p>The value to compare with the specified statistic.</p>"];
      comparison_operator: ComparisonOperator.t option
        [@ocaml.doc
          "<p>The arithmetic operation to use when comparing the specified statistic and threshold. The specified statistic value is used as the first operand.</p>"];
      treat_missing_data: String.t option
        [@ocaml.doc
          "<p>Sets how this alarm is to handle missing data points. If this parameter is omitted, the default behavior of <code>missing</code> is used.</p>"];
      evaluate_low_sample_count_percentile: String.t option
        [@ocaml.doc
          "<p>Used only for alarms based on percentiles. If <code>ignore</code>, the alarm state does not change during periods with too few data points to be statistically significant. If <code>evaluate</code> or this parameter is not used, the alarm is always evaluated and possibly changes state no matter how many data points are available.</p>"];
      metrics: MetricDataQueries.t
        [@ocaml.doc
          "<p>An array of MetricDataQuery structures, used in an alarm based on a metric math expression. Each structure either retrieves a metric or performs a math expression. One item in the Metrics array is the math expression that the alarm watches. This expression by designated by having <code>ReturnValue</code> set to true.</p>"];
      threshold_metric_id: String.t option
        [@ocaml.doc
          "<p>In an alarm based on an anomaly detection model, this is the ID of the <code>ANOMALY_DETECTION_BAND</code> function used as the threshold for the alarm.</p>"]}
    [@@ocaml.doc "<p>Represents an alarm.</p>"]
    let make ?alarm_name  ?alarm_arn  ?alarm_description 
      ?alarm_configuration_updated_timestamp  ?actions_enabled 
      ?(o_k_actions= [])  ?(alarm_actions= [])  ?(insufficient_data_actions=
      [])  ?state_value  ?state_reason  ?state_reason_data 
      ?state_updated_timestamp  ?metric_name  ?namespace  ?statistic 
      ?extended_statistic  ?(dimensions= [])  ?period  ?unit 
      ?evaluation_periods  ?datapoints_to_alarm  ?threshold 
      ?comparison_operator  ?treat_missing_data 
      ?evaluate_low_sample_count_percentile  ?(metrics= []) 
      ?threshold_metric_id  () =
      {
        alarm_name;
        alarm_arn;
        alarm_description;
        alarm_configuration_updated_timestamp;
        actions_enabled;
        o_k_actions;
        alarm_actions;
        insufficient_data_actions;
        state_value;
        state_reason;
        state_reason_data;
        state_updated_timestamp;
        metric_name;
        namespace;
        statistic;
        extended_statistic;
        dimensions;
        period;
        unit;
        evaluation_periods;
        datapoints_to_alarm;
        threshold;
        comparison_operator;
        treat_missing_data;
        evaluate_low_sample_count_percentile;
        metrics;
        threshold_metric_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.threshold_metric_id
              (fun f -> ("threshold_metric_id", (String.to_json f)));
           Some ("metrics", (MetricDataQueries.to_json v.metrics));
           Util.option_map v.evaluate_low_sample_count_percentile
             (fun f ->
                ("evaluate_low_sample_count_percentile", (String.to_json f)));
           Util.option_map v.treat_missing_data
             (fun f -> ("treat_missing_data", (String.to_json f)));
           Util.option_map v.comparison_operator
             (fun f ->
                ("comparison_operator", (ComparisonOperator.to_json f)));
           Util.option_map v.threshold
             (fun f -> ("threshold", (Double.to_json f)));
           Util.option_map v.datapoints_to_alarm
             (fun f -> ("datapoints_to_alarm", (Integer.to_json f)));
           Util.option_map v.evaluation_periods
             (fun f -> ("evaluation_periods", (Integer.to_json f)));
           Util.option_map v.unit
             (fun f -> ("unit", (StandardUnit.to_json f)));
           Util.option_map v.period
             (fun f -> ("period", (Integer.to_json f)));
           Some ("dimensions", (Dimensions.to_json v.dimensions));
           Util.option_map v.extended_statistic
             (fun f -> ("extended_statistic", (String.to_json f)));
           Util.option_map v.statistic
             (fun f -> ("statistic", (Statistic.to_json f)));
           Util.option_map v.namespace
             (fun f -> ("namespace", (String.to_json f)));
           Util.option_map v.metric_name
             (fun f -> ("metric_name", (String.to_json f)));
           Util.option_map v.state_updated_timestamp
             (fun f -> ("state_updated_timestamp", (DateTime.to_json f)));
           Util.option_map v.state_reason_data
             (fun f -> ("state_reason_data", (String.to_json f)));
           Util.option_map v.state_reason
             (fun f -> ("state_reason", (String.to_json f)));
           Util.option_map v.state_value
             (fun f -> ("state_value", (StateValue.to_json f)));
           Some
             ("insufficient_data_actions",
               (ResourceList.to_json v.insufficient_data_actions));
           Some ("alarm_actions", (ResourceList.to_json v.alarm_actions));
           Some ("o_k_actions", (ResourceList.to_json v.o_k_actions));
           Util.option_map v.actions_enabled
             (fun f -> ("actions_enabled", (Boolean.to_json f)));
           Util.option_map v.alarm_configuration_updated_timestamp
             (fun f ->
                ("alarm_configuration_updated_timestamp",
                  (DateTime.to_json f)));
           Util.option_map v.alarm_description
             (fun f -> ("alarm_description", (String.to_json f)));
           Util.option_map v.alarm_arn
             (fun f -> ("alarm_arn", (String.to_json f)));
           Util.option_map v.alarm_name
             (fun f -> ("alarm_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          alarm_name =
            (Util.option_bind (Xml.member "AlarmName" xml) String.parse);
          alarm_arn =
            (Util.option_bind (Xml.member "AlarmArn" xml) String.parse);
          alarm_description =
            (Util.option_bind (Xml.member "AlarmDescription" xml)
               String.parse);
          alarm_configuration_updated_timestamp =
            (Util.option_bind
               (Xml.member "AlarmConfigurationUpdatedTimestamp" xml)
               DateTime.parse);
          actions_enabled =
            (Util.option_bind (Xml.member "ActionsEnabled" xml) Boolean.parse);
          o_k_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "OKActions" xml)
                  ResourceList.parse));
          alarm_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "AlarmActions" xml)
                  ResourceList.parse));
          insufficient_data_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "InsufficientDataActions" xml)
                  ResourceList.parse));
          state_value =
            (Util.option_bind (Xml.member "StateValue" xml) StateValue.parse);
          state_reason =
            (Util.option_bind (Xml.member "StateReason" xml) String.parse);
          state_reason_data =
            (Util.option_bind (Xml.member "StateReasonData" xml) String.parse);
          state_updated_timestamp =
            (Util.option_bind (Xml.member "StateUpdatedTimestamp" xml)
               DateTime.parse);
          metric_name =
            (Util.option_bind (Xml.member "MetricName" xml) String.parse);
          namespace =
            (Util.option_bind (Xml.member "Namespace" xml) String.parse);
          statistic =
            (Util.option_bind (Xml.member "Statistic" xml) Statistic.parse);
          extended_statistic =
            (Util.option_bind (Xml.member "ExtendedStatistic" xml)
               String.parse);
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  Dimensions.parse));
          period = (Util.option_bind (Xml.member "Period" xml) Integer.parse);
          unit =
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse);
          evaluation_periods =
            (Util.option_bind (Xml.member "EvaluationPeriods" xml)
               Integer.parse);
          datapoints_to_alarm =
            (Util.option_bind (Xml.member "DatapointsToAlarm" xml)
               Integer.parse);
          threshold =
            (Util.option_bind (Xml.member "Threshold" xml) Double.parse);
          comparison_operator =
            (Util.option_bind (Xml.member "ComparisonOperator" xml)
               ComparisonOperator.parse);
          treat_missing_data =
            (Util.option_bind (Xml.member "TreatMissingData" xml)
               String.parse);
          evaluate_low_sample_count_percentile =
            (Util.option_bind
               (Xml.member "EvaluateLowSampleCountPercentile" xml)
               String.parse);
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml)
                  MetricDataQueries.parse));
          threshold_metric_id =
            (Util.option_bind (Xml.member "ThresholdMetricId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((([] @
                                     [Util.option_map v.alarm_name
                                        (fun f ->
                                           Ezxmlm.make_tag "AlarmName"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.alarm_arn
                                       (fun f ->
                                          Ezxmlm.make_tag "AlarmArn"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Util.option_map v.alarm_description
                                      (fun f ->
                                         Ezxmlm.make_tag "AlarmDescription"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map
                                     v.alarm_configuration_updated_timestamp
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "AlarmConfigurationUpdatedTimestamp"
                                          ([], (DateTime.to_xml f)))])
                                 @
                                 [Util.option_map v.actions_enabled
                                    (fun f ->
                                       Ezxmlm.make_tag "ActionsEnabled"
                                         ([], (Boolean.to_xml f)))])
                                @
                                (List.map
                                   (fun x ->
                                      Some
                                        (Ezxmlm.make_tag "OKActions"
                                           ([], (ResourceList.to_xml [x]))))
                                   v.o_k_actions))
                               @
                               (List.map
                                  (fun x ->
                                     Some
                                       (Ezxmlm.make_tag "AlarmActions"
                                          ([], (ResourceList.to_xml [x]))))
                                  v.alarm_actions))
                              @
                              (List.map
                                 (fun x ->
                                    Some
                                      (Ezxmlm.make_tag
                                         "InsufficientDataActions"
                                         ([], (ResourceList.to_xml [x]))))
                                 v.insufficient_data_actions))
                             @
                             [Util.option_map v.state_value
                                (fun f ->
                                   Ezxmlm.make_tag "StateValue"
                                     ([], (StateValue.to_xml f)))])
                            @
                            [Util.option_map v.state_reason
                               (fun f ->
                                  Ezxmlm.make_tag "StateReason"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.state_reason_data
                              (fun f ->
                                 Ezxmlm.make_tag "StateReasonData"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.state_updated_timestamp
                             (fun f ->
                                Ezxmlm.make_tag "StateUpdatedTimestamp"
                                  ([], (DateTime.to_xml f)))])
                         @
                         [Util.option_map v.metric_name
                            (fun f ->
                               Ezxmlm.make_tag "MetricName"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.namespace
                           (fun f ->
                              Ezxmlm.make_tag "Namespace"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.statistic
                          (fun f ->
                             Ezxmlm.make_tag "Statistic"
                               ([], (Statistic.to_xml f)))])
                      @
                      [Util.option_map v.extended_statistic
                         (fun f ->
                            Ezxmlm.make_tag "ExtendedStatistic"
                              ([], (String.to_xml f)))])
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "Dimensions"
                                ([], (Dimensions.to_xml [x])))) v.dimensions))
                    @
                    [Util.option_map v.period
                       (fun f ->
                          Ezxmlm.make_tag "Period" ([], (Integer.to_xml f)))])
                   @
                   [Util.option_map v.unit
                      (fun f ->
                         Ezxmlm.make_tag "Unit" ([], (StandardUnit.to_xml f)))])
                  @
                  [Util.option_map v.evaluation_periods
                     (fun f ->
                        Ezxmlm.make_tag "EvaluationPeriods"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.datapoints_to_alarm
                    (fun f ->
                       Ezxmlm.make_tag "DatapointsToAlarm"
                         ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.threshold
                   (fun f ->
                      Ezxmlm.make_tag "Threshold" ([], (Double.to_xml f)))])
               @
               [Util.option_map v.comparison_operator
                  (fun f ->
                     Ezxmlm.make_tag "ComparisonOperator"
                       ([], (ComparisonOperator.to_xml f)))])
              @
              [Util.option_map v.treat_missing_data
                 (fun f ->
                    Ezxmlm.make_tag "TreatMissingData"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.evaluate_low_sample_count_percentile
                (fun f ->
                   Ezxmlm.make_tag "EvaluateLowSampleCountPercentile"
                     ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Metrics"
                       ([], (MetricDataQueries.to_xml [x])))) v.metrics))
           @
           [Util.option_map v.threshold_metric_id
              (fun f ->
                 Ezxmlm.make_tag "ThresholdMetricId" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>Represents an alarm.</p>"]
module MetricDataResult =
  struct
    type t =
      {
      id: String.t option
        [@ocaml.doc
          "<p>The short name you specified to represent this metric.</p>"];
      label: String.t option
        [@ocaml.doc
          "<p>The human-readable label associated with the data.</p>"];
      timestamps: Timestamps.t
        [@ocaml.doc
          "<p>The timestamps for the data points, formatted in Unix timestamp format. The number of timestamps always matches the number of values and the value for Timestamps[x] is Values[x].</p>"];
      values: DatapointValues.t
        [@ocaml.doc
          "<p>The data points for the metric corresponding to <code>Timestamps</code>. The number of values always matches the number of timestamps and the timestamp for Values[x] is Timestamps[x].</p>"];
      status_code: StatusCode.t option
        [@ocaml.doc
          "<p>The status of the returned data. <code>Complete</code> indicates that all data points in the requested time range were returned. <code>PartialData</code> means that an incomplete set of data points were returned. You can use the <code>NextToken</code> value that was returned and repeat your request to get more data points. <code>NextToken</code> is not returned if you are performing a math expression. <code>InternalError</code> indicates that an error occurred. Retry your request using <code>NextToken</code>, if present.</p>"];
      messages: MetricDataResultMessages.t
        [@ocaml.doc
          "<p>A list of messages with additional information about the data returned.</p>"]}
    [@@ocaml.doc
      "<p>A <code>GetMetricData</code> call returns an array of <code>MetricDataResult</code> structures. Each of these structures includes the data points for that metric, along with the timestamps of those data points and other identifying information.</p>"]
    let make ?id  ?label  ?(timestamps= [])  ?(values= [])  ?status_code 
      ?(messages= [])  () =
      { id; label; timestamps; values; status_code; messages }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("messages", (MetricDataResultMessages.to_json v.messages));
           Util.option_map v.status_code
             (fun f -> ("status_code", (StatusCode.to_json f)));
           Some ("values", (DatapointValues.to_json v.values));
           Some ("timestamps", (Timestamps.to_json v.timestamps));
           Util.option_map v.label (fun f -> ("label", (String.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          label = (Util.option_bind (Xml.member "Label" xml) String.parse);
          timestamps =
            (Util.of_option []
               (Util.option_bind (Xml.member "Timestamps" xml)
                  Timestamps.parse));
          values =
            (Util.of_option []
               (Util.option_bind (Xml.member "Values" xml)
                  DatapointValues.parse));
          status_code =
            (Util.option_bind (Xml.member "StatusCode" xml) StatusCode.parse);
          messages =
            (Util.of_option []
               (Util.option_bind (Xml.member "Messages" xml)
                  MetricDataResultMessages.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.id
                   (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
               @
               [Util.option_map v.label
                  (fun f -> Ezxmlm.make_tag "Label" ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Timestamps"
                         ([], (Timestamps.to_xml [x])))) v.timestamps))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Values"
                        ([], (DatapointValues.to_xml [x])))) v.values))
            @
            [Util.option_map v.status_code
               (fun f ->
                  Ezxmlm.make_tag "StatusCode" ([], (StatusCode.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Messages"
                      ([], (MetricDataResultMessages.to_xml [x]))))
              v.messages))
  end[@@ocaml.doc
       "<p>A <code>GetMetricData</code> call returns an array of <code>MetricDataResult</code> structures. Each of these structures includes the data points for that metric, along with the timestamps of those data points and other identifying information.</p>"]
module DashboardEntry =
  struct
    type t =
      {
      dashboard_name: String.t option
        [@ocaml.doc "<p>The name of the dashboard.</p>"];
      dashboard_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the dashboard.</p>"];
      last_modified: DateTime.t option
        [@ocaml.doc
          "<p>The time stamp of when the dashboard was last modified, either by an API call or through the console. This number is expressed as the number of milliseconds since Jan 1, 1970 00:00:00 UTC.</p>"];
      size: Long.t option
        [@ocaml.doc "<p>The size of the dashboard, in bytes.</p>"]}[@@ocaml.doc
                                                                    "<p>Represents a specific dashboard.</p>"]
    let make ?dashboard_name  ?dashboard_arn  ?last_modified  ?size  () =
      { dashboard_name; dashboard_arn; last_modified; size }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.size (fun f -> ("size", (Long.to_json f)));
           Util.option_map v.last_modified
             (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.dashboard_arn
             (fun f -> ("dashboard_arn", (String.to_json f)));
           Util.option_map v.dashboard_name
             (fun f -> ("dashboard_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          dashboard_name =
            (Util.option_bind (Xml.member "DashboardName" xml) String.parse);
          dashboard_arn =
            (Util.option_bind (Xml.member "DashboardArn" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse);
          size = (Util.option_bind (Xml.member "Size" xml) Long.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dashboard_name
                 (fun f ->
                    Ezxmlm.make_tag "DashboardName" ([], (String.to_xml f)))])
             @
             [Util.option_map v.dashboard_arn
                (fun f ->
                   Ezxmlm.make_tag "DashboardArn" ([], (String.to_xml f)))])
            @
            [Util.option_map v.last_modified
               (fun f ->
                  Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.size
              (fun f -> Ezxmlm.make_tag "Size" ([], (Long.to_xml f)))])
  end[@@ocaml.doc "<p>Represents a specific dashboard.</p>"]
module DashboardValidationMessage =
  struct
    type t =
      {
      data_path: String.t option
        [@ocaml.doc "<p>The data path related to the message.</p>"];
      message: String.t option
        [@ocaml.doc "<p>A message describing the error or warning.</p>"]}
    [@@ocaml.doc "<p>An error or warning for the operation.</p>"]
    let make ?data_path  ?message  () = { data_path; message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)));
           Util.option_map v.data_path
             (fun f -> ("data_path", (String.to_json f)))])
    let parse xml =
      Some
        {
          data_path =
            (Util.option_bind (Xml.member "DataPath" xml) String.parse);
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.data_path
               (fun f -> Ezxmlm.make_tag "DataPath" ([], (String.to_xml f)))])
           @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>An error or warning for the operation.</p>"]
module InsightRule =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the rule.</p>"];
      state: String.t
        [@ocaml.doc
          "<p>Indicates whether the rule is enabled or disabled.</p>"];
      schema: String.t
        [@ocaml.doc
          "<p>For rules that you create, this is always <code>{\"Name\": \"CloudWatchLogRule\", \"Version\": 1}</code>. For built-in rules, this is <code>{\"Name\": \"ServiceLogRule\", \"Version\": 1}</code> </p>"];
      definition: String.t
        [@ocaml.doc
          "<p>The definition of the rule, as a JSON object. The definition contains the keywords used to define contributors, the value to aggregate on if this rule returns a sum instead of a count, and the filters. For details on the valid syntax, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/ContributorInsights-RuleSyntax.html\">Contributor Insights Rule Syntax</a>.</p>"]}
    [@@ocaml.doc
      "<p>This structure contains the definition for a Contributor Insights rule.</p>"]
    let make ~name  ~state  ~schema  ~definition  () =
      { name; state; schema; definition }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("definition", (String.to_json v.definition));
           Some ("schema", (String.to_json v.schema));
           Some ("state", (String.to_json v.state));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          state =
            (Xml.required "State"
               (Util.option_bind (Xml.member "State" xml) String.parse));
          schema =
            (Xml.required "Schema"
               (Util.option_bind (Xml.member "Schema" xml) String.parse));
          definition =
            (Xml.required "Definition"
               (Util.option_bind (Xml.member "Definition" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
             @ [Some (Ezxmlm.make_tag "State" ([], (String.to_xml v.state)))])
            @
            [Some (Ezxmlm.make_tag "Schema" ([], (String.to_xml v.schema)))])
           @
           [Some
              (Ezxmlm.make_tag "Definition"
                 ([], (String.to_xml v.definition)))])
  end[@@ocaml.doc
       "<p>This structure contains the definition for a Contributor Insights rule.</p>"]
module MetricDatum =
  struct
    type t =
      {
      metric_name: String.t [@ocaml.doc "<p>The name of the metric.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc "<p>The dimensions associated with the metric.</p>"];
      timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time the metric data was received, expressed as the number of milliseconds since Jan 1, 1970 00:00:00 UTC.</p>"];
      value: Double.t option
        [@ocaml.doc
          "<p>The value for the metric.</p> <p>Although the parameter accepts numbers of type Double, CloudWatch rejects values that are either too small or too large. Values must be in the range of -2^360 to 2^360. In addition, special values (for example, NaN, +Infinity, -Infinity) are not supported.</p>"];
      statistic_values: StatisticSet.t option
        [@ocaml.doc "<p>The statistical values for the metric.</p>"];
      values: Values.t
        [@ocaml.doc
          "<p>Array of numbers representing the values for the metric during the period. Each unique value is listed just once in this array, and the corresponding number in the <code>Counts</code> array specifies the number of times that value occurred during the period. You can include up to 150 unique values in each <code>PutMetricData</code> action that specifies a <code>Values</code> array.</p> <p>Although the <code>Values</code> array accepts numbers of type <code>Double</code>, CloudWatch rejects values that are either too small or too large. Values must be in the range of -2^360 to 2^360. In addition, special values (for example, NaN, +Infinity, -Infinity) are not supported.</p>"];
      counts: Counts.t
        [@ocaml.doc
          "<p>Array of numbers that is used along with the <code>Values</code> array. Each number in the <code>Count</code> array is the number of times the corresponding value in the <code>Values</code> array occurred during the period. </p> <p>If you omit the <code>Counts</code> array, the default of 1 is used as the value for each count. If you include a <code>Counts</code> array, it must include the same amount of values as the <code>Values</code> array.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc
          "<p>When you are using a <code>Put</code> operation, this defines what unit you want to use when storing the metric.</p> <p>In a <code>Get</code> operation, this displays the unit that is used for the metric.</p>"];
      storage_resolution: Integer.t option
        [@ocaml.doc
          "<p>Valid values are 1 and 60. Setting this to 1 specifies this metric as a high-resolution metric, so that CloudWatch stores the metric with sub-minute resolution down to one second. Setting this to 60 specifies this metric as a regular-resolution metric, which CloudWatch stores at 1-minute resolution. Currently, high resolution is available only for custom metrics. For more information about high-resolution metrics, see <a href=\"https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html#high-resolution-metrics\">High-Resolution Metrics</a> in the <i>Amazon CloudWatch User Guide</i>. </p> <p>This field is optional, if you do not specify it the default of 60 is used.</p>"]}
    [@@ocaml.doc
      "<p>Encapsulates the information sent to either create a metric or add new values to be aggregated into an existing metric.</p>"]
    let make ~metric_name  ?(dimensions= [])  ?timestamp  ?value 
      ?statistic_values  ?(values= [])  ?(counts= [])  ?unit 
      ?storage_resolution  () =
      {
        metric_name;
        dimensions;
        timestamp;
        value;
        statistic_values;
        values;
        counts;
        unit;
        storage_resolution
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.storage_resolution
              (fun f -> ("storage_resolution", (Integer.to_json f)));
           Util.option_map v.unit
             (fun f -> ("unit", (StandardUnit.to_json f)));
           Some ("counts", (Counts.to_json v.counts));
           Some ("values", (Values.to_json v.values));
           Util.option_map v.statistic_values
             (fun f -> ("statistic_values", (StatisticSet.to_json f)));
           Util.option_map v.value (fun f -> ("value", (Double.to_json f)));
           Util.option_map v.timestamp
             (fun f -> ("timestamp", (DateTime.to_json f)));
           Some ("dimensions", (Dimensions.to_json v.dimensions));
           Some ("metric_name", (String.to_json v.metric_name))])
    let parse xml =
      Some
        {
          metric_name =
            (Xml.required "MetricName"
               (Util.option_bind (Xml.member "MetricName" xml) String.parse));
          dimensions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Dimensions" xml)
                  Dimensions.parse));
          timestamp =
            (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse);
          value = (Util.option_bind (Xml.member "Value" xml) Double.parse);
          statistic_values =
            (Util.option_bind (Xml.member "StatisticValues" xml)
               StatisticSet.parse);
          values =
            (Util.of_option []
               (Util.option_bind (Xml.member "Values" xml) Values.parse));
          counts =
            (Util.of_option []
               (Util.option_bind (Xml.member "Counts" xml) Counts.parse));
          unit =
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse);
          storage_resolution =
            (Util.option_bind (Xml.member "StorageResolution" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
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
                 [Util.option_map v.timestamp
                    (fun f ->
                       Ezxmlm.make_tag "Timestamp" ([], (DateTime.to_xml f)))])
                @
                [Util.option_map v.value
                   (fun f -> Ezxmlm.make_tag "Value" ([], (Double.to_xml f)))])
               @
               [Util.option_map v.statistic_values
                  (fun f ->
                     Ezxmlm.make_tag "StatisticValues"
                       ([], (StatisticSet.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some (Ezxmlm.make_tag "Values" ([], (Values.to_xml [x]))))
                 v.values))
             @
             (List.map
                (fun x ->
                   Some (Ezxmlm.make_tag "Counts" ([], (Counts.to_xml [x]))))
                v.counts))
            @
            [Util.option_map v.unit
               (fun f -> Ezxmlm.make_tag "Unit" ([], (StandardUnit.to_xml f)))])
           @
           [Util.option_map v.storage_resolution
              (fun f ->
                 Ezxmlm.make_tag "StorageResolution" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Encapsulates the information sent to either create a metric or add new values to be aggregated into an existing metric.</p>"]
module Datapoint =
  struct
    type t =
      {
      timestamp: DateTime.t option
        [@ocaml.doc "<p>The time stamp used for the data point.</p>"];
      sample_count: Double.t option
        [@ocaml.doc
          "<p>The number of metric values that contributed to the aggregate value of this data point.</p>"];
      average: Double.t option
        [@ocaml.doc
          "<p>The average of the metric values that correspond to the data point.</p>"];
      sum: Double.t option
        [@ocaml.doc
          "<p>The sum of the metric values for the data point.</p>"];
      minimum: Double.t option
        [@ocaml.doc "<p>The minimum metric value for the data point.</p>"];
      maximum: Double.t option
        [@ocaml.doc "<p>The maximum metric value for the data point.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc "<p>The standard unit for the data point.</p>"];
      extended_statistics: DatapointValueMap.t option
        [@ocaml.doc "<p>The percentile statistic for the data point.</p>"]}
    [@@ocaml.doc
      "<p>Encapsulates the statistical data that CloudWatch computes from metric data.</p>"]
    let make ?timestamp  ?sample_count  ?average  ?sum  ?minimum  ?maximum 
      ?unit  ?extended_statistics  () =
      {
        timestamp;
        sample_count;
        average;
        sum;
        minimum;
        maximum;
        unit;
        extended_statistics
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.extended_statistics
              (fun f ->
                 ("extended_statistics", (DatapointValueMap.to_json f)));
           Util.option_map v.unit
             (fun f -> ("unit", (StandardUnit.to_json f)));
           Util.option_map v.maximum
             (fun f -> ("maximum", (Double.to_json f)));
           Util.option_map v.minimum
             (fun f -> ("minimum", (Double.to_json f)));
           Util.option_map v.sum (fun f -> ("sum", (Double.to_json f)));
           Util.option_map v.average
             (fun f -> ("average", (Double.to_json f)));
           Util.option_map v.sample_count
             (fun f -> ("sample_count", (Double.to_json f)));
           Util.option_map v.timestamp
             (fun f -> ("timestamp", (DateTime.to_json f)))])
    let parse xml =
      Some
        {
          timestamp =
            (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse);
          sample_count =
            (Util.option_bind (Xml.member "SampleCount" xml) Double.parse);
          average =
            (Util.option_bind (Xml.member "Average" xml) Double.parse);
          sum = (Util.option_bind (Xml.member "Sum" xml) Double.parse);
          minimum =
            (Util.option_bind (Xml.member "Minimum" xml) Double.parse);
          maximum =
            (Util.option_bind (Xml.member "Maximum" xml) Double.parse);
          unit =
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse);
          extended_statistics =
            (Util.option_bind (Xml.member "ExtendedStatistics" xml)
               DatapointValueMap.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.timestamp
                     (fun f ->
                        Ezxmlm.make_tag "Timestamp" ([], (DateTime.to_xml f)))])
                 @
                 [Util.option_map v.sample_count
                    (fun f ->
                       Ezxmlm.make_tag "SampleCount" ([], (Double.to_xml f)))])
                @
                [Util.option_map v.average
                   (fun f ->
                      Ezxmlm.make_tag "Average" ([], (Double.to_xml f)))])
               @
               [Util.option_map v.sum
                  (fun f -> Ezxmlm.make_tag "Sum" ([], (Double.to_xml f)))])
              @
              [Util.option_map v.minimum
                 (fun f -> Ezxmlm.make_tag "Minimum" ([], (Double.to_xml f)))])
             @
             [Util.option_map v.maximum
                (fun f -> Ezxmlm.make_tag "Maximum" ([], (Double.to_xml f)))])
            @
            [Util.option_map v.unit
               (fun f -> Ezxmlm.make_tag "Unit" ([], (StandardUnit.to_xml f)))])
           @
           [Util.option_map v.extended_statistics
              (fun f ->
                 Ezxmlm.make_tag "ExtendedStatistics"
                   ([], (DatapointValueMap.to_xml f)))])
  end[@@ocaml.doc
       "<p>Encapsulates the statistical data that CloudWatch computes from metric data.</p>"]
module AlarmHistoryItems =
  struct
    type t = AlarmHistoryItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AlarmHistoryItem.to_query v
    let to_headers v = Headers.to_headers_list AlarmHistoryItem.to_headers v
    let to_json v = `List (List.map AlarmHistoryItem.to_json v)
    let parse xml =
      Util.option_all
        (List.map AlarmHistoryItem.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AlarmHistoryItem.to_xml x)))
        v
  end
module BatchFailures =
  struct
    type t = PartialFailure.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PartialFailure.to_query v
    let to_headers v = Headers.to_headers_list PartialFailure.to_headers v
    let to_json v = `List (List.map PartialFailure.to_json v)
    let parse xml =
      Util.option_all
        (List.map PartialFailure.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (PartialFailure.to_xml x))) v
  end
module DimensionFilters =
  struct
    type t = DimensionFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DimensionFilter.to_query v
    let to_headers v = Headers.to_headers_list DimensionFilter.to_headers v
    let to_json v = `List (List.map DimensionFilter.to_json v)
    let parse xml =
      Util.option_all
        (List.map DimensionFilter.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DimensionFilter.to_xml x)))
        v
  end
module TagList =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end
module InsightRuleNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module InsightRuleMetricList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module AlarmNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module TagKeyList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ScanBy =
  struct
    type t =
      | TimestampDescending 
      | TimestampAscending 
    let str_to_t =
      [("TimestampAscending", TimestampAscending);
      ("TimestampDescending", TimestampDescending)]
    let t_to_str =
      [(TimestampAscending, "TimestampAscending");
      (TimestampDescending, "TimestampDescending")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module InsightRuleContributorKeyLabels =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module InsightRuleContributors =
  struct
    type t = InsightRuleContributor.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InsightRuleContributor.to_query v
    let to_headers v =
      Headers.to_headers_list InsightRuleContributor.to_headers v
    let to_json v = `List (List.map InsightRuleContributor.to_json v)
    let parse xml =
      Util.option_all
        (List.map InsightRuleContributor.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (InsightRuleContributor.to_xml x)))
        v
  end
module InsightRuleMetricDatapoints =
  struct
    type t = InsightRuleMetricDatapoint.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list InsightRuleMetricDatapoint.to_query v
    let to_headers v =
      Headers.to_headers_list InsightRuleMetricDatapoint.to_headers v
    let to_json v = `List (List.map InsightRuleMetricDatapoint.to_json v)
    let parse xml =
      Util.option_all
        (List.map InsightRuleMetricDatapoint.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (InsightRuleMetricDatapoint.to_xml x))) v
  end
module AnomalyDetectors =
  struct
    type t = AnomalyDetector.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AnomalyDetector.to_query v
    let to_headers v = Headers.to_headers_list AnomalyDetector.to_headers v
    let to_json v = `List (List.map AnomalyDetector.to_json v)
    let parse xml =
      Util.option_all
        (List.map AnomalyDetector.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AnomalyDetector.to_xml x)))
        v
  end
module MetricAlarms =
  struct
    type t = MetricAlarm.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricAlarm.to_query v
    let to_headers v = Headers.to_headers_list MetricAlarm.to_headers v
    let to_json v = `List (List.map MetricAlarm.to_json v)
    let parse xml =
      Util.option_all (List.map MetricAlarm.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetricAlarm.to_xml x))) v
  end
module MetricDataResults =
  struct
    type t = MetricDataResult.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricDataResult.to_query v
    let to_headers v = Headers.to_headers_list MetricDataResult.to_headers v
    let to_json v = `List (List.map MetricDataResult.to_json v)
    let parse xml =
      Util.option_all
        (List.map MetricDataResult.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetricDataResult.to_xml x)))
        v
  end
module DashboardEntries =
  struct
    type t = DashboardEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DashboardEntry.to_query v
    let to_headers v = Headers.to_headers_list DashboardEntry.to_headers v
    let to_json v = `List (List.map DashboardEntry.to_json v)
    let parse xml =
      Util.option_all
        (List.map DashboardEntry.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DashboardEntry.to_xml x))) v
  end
module DashboardValidationMessages =
  struct
    type t = DashboardValidationMessage.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list DashboardValidationMessage.to_query v
    let to_headers v =
      Headers.to_headers_list DashboardValidationMessage.to_headers v
    let to_json v = `List (List.map DashboardValidationMessage.to_json v)
    let parse xml =
      Util.option_all
        (List.map DashboardValidationMessage.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (DashboardValidationMessage.to_xml x))) v
  end
module Metrics =
  struct
    type t = Metric.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Metric.to_query v
    let to_headers v = Headers.to_headers_list Metric.to_headers v
    let to_json v = `List (List.map Metric.to_json v)
    let parse xml =
      Util.option_all (List.map Metric.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Metric.to_xml x))) v
  end
module InsightRules =
  struct
    type t = InsightRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InsightRule.to_query v
    let to_headers v = Headers.to_headers_list InsightRule.to_headers v
    let to_json v = `List (List.map InsightRule.to_json v)
    let parse xml =
      Util.option_all (List.map InsightRule.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (InsightRule.to_xml x))) v
  end
module ExtendedStatistics =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Statistics =
  struct
    type t = Statistic.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Statistic.to_query v
    let to_headers v = Headers.to_headers_list Statistic.to_headers v
    let to_json v = `List (List.map Statistic.to_json v)
    let parse xml =
      Util.option_all (List.map Statistic.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Statistic.to_xml x)))
        v
  end
module MetricData =
  struct
    type t = MetricDatum.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MetricDatum.to_query v
    let to_headers v = Headers.to_headers_list MetricDatum.to_headers v
    let to_json v = `List (List.map MetricDatum.to_json v)
    let parse xml =
      Util.option_all (List.map MetricDatum.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetricDatum.to_xml x))) v
  end
module DashboardNames =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Datapoints =
  struct
    type t = Datapoint.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Datapoint.to_query v
    let to_headers v = Headers.to_headers_list Datapoint.to_headers v
    let to_json v = `List (List.map Datapoint.to_json v)
    let parse xml =
      Util.option_all (List.map Datapoint.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Datapoint.to_xml x)))
        v
  end
module DescribeAlarmHistoryOutput =
  struct
    type t =
      {
      alarm_history_items: AlarmHistoryItems.t
        [@ocaml.doc "<p>The alarm histories, in JSON format.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token that marks the start of the next batch of returned results.</p>"]}
    let make ?(alarm_history_items= [])  ?next_token  () =
      { alarm_history_items; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("alarm_history_items",
               (AlarmHistoryItems.to_json v.alarm_history_items))])
    let parse xml =
      Some
        {
          alarm_history_items =
            (Util.of_option []
               (Util.option_bind (Xml.member "AlarmHistoryItems" xml)
                  AlarmHistoryItems.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AlarmHistoryItems"
                       ([], (AlarmHistoryItems.to_xml [x]))))
               v.alarm_history_items))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DisableInsightRulesOutput =
  struct
    type t =
      {
      failures: BatchFailures.t
        [@ocaml.doc
          "<p>An array listing the rules that could not be disabled. You cannot disable built-in rules.</p>"]}
    let make ?(failures= [])  () = { failures }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failures", (BatchFailures.to_json v.failures))])
    let parse xml =
      Some
        {
          failures =
            (Util.of_option []
               (Util.option_bind (Xml.member "Failures" xml)
                  BatchFailures.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Failures"
                      ([], (BatchFailures.to_xml [x])))) v.failures))
  end
module GetDashboardOutput =
  struct
    type t =
      {
      dashboard_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the dashboard.</p>"];
      dashboard_body: String.t option
        [@ocaml.doc
          "<p>The detailed information about the dashboard, including what widgets are included and their location on the dashboard. For more information about the <code>DashboardBody</code> syntax, see <a>CloudWatch-Dashboard-Body-Structure</a>. </p>"];
      dashboard_name: String.t option
        [@ocaml.doc "<p>The name of the dashboard.</p>"]}
    let make ?dashboard_arn  ?dashboard_body  ?dashboard_name  () =
      { dashboard_arn; dashboard_body; dashboard_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dashboard_name
              (fun f -> ("dashboard_name", (String.to_json f)));
           Util.option_map v.dashboard_body
             (fun f -> ("dashboard_body", (String.to_json f)));
           Util.option_map v.dashboard_arn
             (fun f -> ("dashboard_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          dashboard_arn =
            (Util.option_bind (Xml.member "DashboardArn" xml) String.parse);
          dashboard_body =
            (Util.option_bind (Xml.member "DashboardBody" xml) String.parse);
          dashboard_name =
            (Util.option_bind (Xml.member "DashboardName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.dashboard_arn
                (fun f ->
                   Ezxmlm.make_tag "DashboardArn" ([], (String.to_xml f)))])
            @
            [Util.option_map v.dashboard_body
               (fun f ->
                  Ezxmlm.make_tag "DashboardBody" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dashboard_name
              (fun f ->
                 Ezxmlm.make_tag "DashboardName" ([], (String.to_xml f)))])
  end
module UntagResourceOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module EnableInsightRulesOutput =
  struct
    type t =
      {
      failures: BatchFailures.t
        [@ocaml.doc
          "<p>An array listing the rules that could not be enabled. You cannot disable or enable built-in rules.</p>"]}
    let make ?(failures= [])  () = { failures }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failures", (BatchFailures.to_json v.failures))])
    let parse xml =
      Some
        {
          failures =
            (Util.of_option []
               (Util.option_bind (Xml.member "Failures" xml)
                  BatchFailures.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Failures"
                      ([], (BatchFailures.to_xml [x])))) v.failures))
  end
module GetMetricWidgetImageOutput =
  struct
    type t =
      {
      metric_widget_image: Blob.t option
        [@ocaml.doc
          "<p>The image of the graph, in the output format specified.</p>"]}
    let make ?metric_widget_image  () = { metric_widget_image }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metric_widget_image
              (fun f -> ("metric_widget_image", (Blob.to_json f)))])
    let parse xml =
      Some
        {
          metric_widget_image =
            (Util.option_bind (Xml.member "MetricWidgetImage" xml) Blob.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.metric_widget_image
              (fun f ->
                 Ezxmlm.make_tag "MetricWidgetImage" ([], (Blob.to_xml f)))])
  end
module GetInsightRuleReportOutput =
  struct
    type t =
      {
      key_labels: InsightRuleContributorKeyLabels.t
        [@ocaml.doc
          "<p>An array of the strings used as the keys for this rule. The keys are the dimensions used to classify contributors. If the rule contains more than one key, then each unique combination of values for the keys is counted as a unique contributor.</p>"];
      aggregation_statistic: String.t option
        [@ocaml.doc
          "<p>Specifies whether this rule aggregates contributor data by COUNT or SUM.</p>"];
      aggregate_value: Double.t option
        [@ocaml.doc
          "<p>The sum of the values from all individual contributors that match the rule.</p>"];
      approximate_unique_count: Long.t option
        [@ocaml.doc
          "<p>An approximate count of the unique contributors found by this rule in this time period.</p>"];
      contributors: InsightRuleContributors.t
        [@ocaml.doc
          "<p>An array of the unique contributors found by this rule in this time period. If the rule contains multiple keys, each combination of values for the keys counts as a unique contributor.</p>"];
      metric_datapoints: InsightRuleMetricDatapoints.t
        [@ocaml.doc
          "<p>A time series of metric data points that matches the time period in the rule request.</p>"]}
    let make ?(key_labels= [])  ?aggregation_statistic  ?aggregate_value 
      ?approximate_unique_count  ?(contributors= [])  ?(metric_datapoints=
      [])  () =
      {
        key_labels;
        aggregation_statistic;
        aggregate_value;
        approximate_unique_count;
        contributors;
        metric_datapoints
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("metric_datapoints",
                (InsightRuleMetricDatapoints.to_json v.metric_datapoints));
           Some
             ("contributors",
               (InsightRuleContributors.to_json v.contributors));
           Util.option_map v.approximate_unique_count
             (fun f -> ("approximate_unique_count", (Long.to_json f)));
           Util.option_map v.aggregate_value
             (fun f -> ("aggregate_value", (Double.to_json f)));
           Util.option_map v.aggregation_statistic
             (fun f -> ("aggregation_statistic", (String.to_json f)));
           Some
             ("key_labels",
               (InsightRuleContributorKeyLabels.to_json v.key_labels))])
    let parse xml =
      Some
        {
          key_labels =
            (Util.of_option []
               (Util.option_bind (Xml.member "KeyLabels" xml)
                  InsightRuleContributorKeyLabels.parse));
          aggregation_statistic =
            (Util.option_bind (Xml.member "AggregationStatistic" xml)
               String.parse);
          aggregate_value =
            (Util.option_bind (Xml.member "AggregateValue" xml) Double.parse);
          approximate_unique_count =
            (Util.option_bind (Xml.member "ApproximateUniqueCount" xml)
               Long.parse);
          contributors =
            (Util.of_option []
               (Util.option_bind (Xml.member "Contributors" xml)
                  InsightRuleContributors.parse));
          metric_datapoints =
            (Util.of_option []
               (Util.option_bind (Xml.member "MetricDatapoints" xml)
                  InsightRuleMetricDatapoints.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "KeyLabels"
                           ([], (InsightRuleContributorKeyLabels.to_xml [x]))))
                   v.key_labels))
               @
               [Util.option_map v.aggregation_statistic
                  (fun f ->
                     Ezxmlm.make_tag "AggregationStatistic"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.aggregate_value
                 (fun f ->
                    Ezxmlm.make_tag "AggregateValue" ([], (Double.to_xml f)))])
             @
             [Util.option_map v.approximate_unique_count
                (fun f ->
                   Ezxmlm.make_tag "ApproximateUniqueCount"
                     ([], (Long.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Contributors"
                       ([], (InsightRuleContributors.to_xml [x]))))
               v.contributors))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "MetricDatapoints"
                      ([], (InsightRuleMetricDatapoints.to_xml [x]))))
              v.metric_datapoints))
  end
module DescribeAnomalyDetectorsOutput =
  struct
    type t =
      {
      anomaly_detectors: AnomalyDetectors.t
        [@ocaml.doc
          "<p>The list of anomaly detection models returned by the operation.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A token that you can use in a subsequent operation to retrieve the next set of results.</p>"]}
    let make ?(anomaly_detectors= [])  ?next_token  () =
      { anomaly_detectors; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("anomaly_detectors",
               (AnomalyDetectors.to_json v.anomaly_detectors))])
    let parse xml =
      Some
        {
          anomaly_detectors =
            (Util.of_option []
               (Util.option_bind (Xml.member "AnomalyDetectors" xml)
                  AnomalyDetectors.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AnomalyDetectors"
                       ([], (AnomalyDetectors.to_xml [x]))))
               v.anomaly_detectors))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module PutAnomalyDetectorOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DeleteDashboardsOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DescribeAlarmsOutput =
  struct
    type t =
      {
      metric_alarms: MetricAlarms.t
        [@ocaml.doc "<p>The information for the specified alarms.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token that marks the start of the next batch of returned results.</p>"]}
    let make ?(metric_alarms= [])  ?next_token  () =
      { metric_alarms; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("metric_alarms", (MetricAlarms.to_json v.metric_alarms))])
    let parse xml =
      Some
        {
          metric_alarms =
            (Util.of_option []
               (Util.option_bind (Xml.member "MetricAlarms" xml)
                  MetricAlarms.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "MetricAlarms"
                       ([], (MetricAlarms.to_xml [x])))) v.metric_alarms))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module GetMetricDataOutput =
  struct
    type t =
      {
      metric_data_results: MetricDataResults.t
        [@ocaml.doc
          "<p>The metrics that are returned, including the metric name, namespace, and dimensions.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A token that marks the next batch of returned results.</p>"];
      messages: MetricDataResultMessages.t
        [@ocaml.doc
          "<p>Contains a message about this <code>GetMetricData</code> operation, if the operation results in such a message. An example of a message that may be returned is <code>Maximum number of allowed metrics exceeded</code>. If there is a message, as much of the operation as possible is still executed.</p> <p>A message appears here only if it is related to the global <code>GetMetricData</code> operation. Any message about a specific metric returned by the operation appears in the <code>MetricDataResult</code> object returned for that metric.</p>"]}
    let make ?(metric_data_results= [])  ?next_token  ?(messages= [])  () =
      { metric_data_results; next_token; messages }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("messages", (MetricDataResultMessages.to_json v.messages));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("metric_data_results",
               (MetricDataResults.to_json v.metric_data_results))])
    let parse xml =
      Some
        {
          metric_data_results =
            (Util.of_option []
               (Util.option_bind (Xml.member "MetricDataResults" xml)
                  MetricDataResults.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          messages =
            (Util.of_option []
               (Util.option_bind (Xml.member "Messages" xml)
                  MetricDataResultMessages.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "MetricDataResults"
                        ([], (MetricDataResults.to_xml [x]))))
                v.metric_data_results))
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Messages"
                      ([], (MetricDataResultMessages.to_xml [x]))))
              v.messages))
  end
module ListDashboardsOutput =
  struct
    type t =
      {
      dashboard_entries: DashboardEntries.t
        [@ocaml.doc "<p>The list of matching dashboards.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token that marks the start of the next batch of returned results.</p>"]}
    let make ?(dashboard_entries= [])  ?next_token  () =
      { dashboard_entries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("dashboard_entries",
               (DashboardEntries.to_json v.dashboard_entries))])
    let parse xml =
      Some
        {
          dashboard_entries =
            (Util.of_option []
               (Util.option_bind (Xml.member "DashboardEntries" xml)
                  DashboardEntries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DashboardEntries"
                       ([], (DashboardEntries.to_xml [x]))))
               v.dashboard_entries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module PutDashboardOutput =
  struct
    type t =
      {
      dashboard_validation_messages: DashboardValidationMessages.t
        [@ocaml.doc
          "<p>If the input for <code>PutDashboard</code> was correct and the dashboard was successfully created or modified, this result is empty.</p> <p>If this result includes only warning messages, then the input was valid enough for the dashboard to be created or modified, but some elements of the dashboard may not render.</p> <p>If this result includes error messages, the input was not valid and the operation failed.</p>"]}
    let make ?(dashboard_validation_messages= [])  () =
      { dashboard_validation_messages }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("dashboard_validation_messages",
                (DashboardValidationMessages.to_json
                   v.dashboard_validation_messages))])
    let parse xml =
      Some
        {
          dashboard_validation_messages =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "DashboardValidationMessages" xml)
                  DashboardValidationMessages.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DashboardValidationMessages"
                      ([], (DashboardValidationMessages.to_xml [x]))))
              v.dashboard_validation_messages))
  end
module ListMetricsOutput =
  struct
    type t =
      {
      metrics: Metrics.t [@ocaml.doc "<p>The metrics.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token that marks the start of the next batch of returned results.</p>"]}
    let make ?(metrics= [])  ?next_token  () = { metrics; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("metrics", (Metrics.to_json v.metrics))])
    let parse xml =
      Some
        {
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml) Metrics.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Metrics" ([], (Metrics.to_xml [x]))))
               v.metrics))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module TagResourceOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DeleteInsightRulesOutput =
  struct
    type t =
      {
      failures: BatchFailures.t
        [@ocaml.doc
          "<p>An array listing the rules that could not be deleted. You cannot delete built-in rules.</p>"]}
    let make ?(failures= [])  () = { failures }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failures", (BatchFailures.to_json v.failures))])
    let parse xml =
      Some
        {
          failures =
            (Util.of_option []
               (Util.option_bind (Xml.member "Failures" xml)
                  BatchFailures.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Failures"
                      ([], (BatchFailures.to_xml [x])))) v.failures))
  end
module PutInsightRuleOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DeleteAnomalyDetectorOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DescribeInsightRulesOutput =
  struct
    type t =
      {
      next_token: String.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"];
      insight_rules: InsightRules.t
        [@ocaml.doc "<p>The rules returned by the operation.</p>"]}
    let make ?next_token  ?(insight_rules= [])  () =
      { next_token; insight_rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("insight_rules", (InsightRules.to_json v.insight_rules));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          insight_rules =
            (Util.of_option []
               (Util.option_bind (Xml.member "InsightRules" xml)
                  InsightRules.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "InsightRules"
                      ([], (InsightRules.to_xml [x])))) v.insight_rules))
  end
module DescribeAlarmsForMetricOutput =
  struct
    type t =
      {
      metric_alarms: MetricAlarms.t
        [@ocaml.doc
          "<p>The information for each alarm with the specified metric.</p>"]}
    let make ?(metric_alarms= [])  () = { metric_alarms }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("metric_alarms", (MetricAlarms.to_json v.metric_alarms))])
    let parse xml =
      Some
        {
          metric_alarms =
            (Util.of_option []
               (Util.option_bind (Xml.member "MetricAlarms" xml)
                  MetricAlarms.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "MetricAlarms"
                      ([], (MetricAlarms.to_xml [x])))) v.metric_alarms))
  end
module ListTagsForResourceOutput =
  struct
    type t =
      {
      tags: TagList.t
        [@ocaml.doc
          "<p>The list of tag keys and values associated with the resource you specified.</p>"]}
    let make ?(tags= [])  () = { tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("tags", (TagList.to_json v.tags))])
    let parse xml =
      Some
        {
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end
module GetMetricStatisticsOutput =
  struct
    type t =
      {
      label: String.t option
        [@ocaml.doc "<p>A label for the specified metric.</p>"];
      datapoints: Datapoints.t
        [@ocaml.doc "<p>The data points for the specified metric.</p>"]}
    let make ?label  ?(datapoints= [])  () = { label; datapoints }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("datapoints", (Datapoints.to_json v.datapoints));
           Util.option_map v.label (fun f -> ("label", (String.to_json f)))])
    let parse xml =
      Some
        {
          label = (Util.option_bind (Xml.member "Label" xml) String.parse);
          datapoints =
            (Util.of_option []
               (Util.option_bind (Xml.member "Datapoints" xml)
                  Datapoints.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.label
               (fun f -> Ezxmlm.make_tag "Label" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Datapoints"
                      ([], (Datapoints.to_xml [x])))) v.datapoints))
  end