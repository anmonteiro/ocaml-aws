open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetInsightRuleReportInput =
  struct
    type t =
      {
      rule_name: String.t
        [@ocaml.doc
          "<p>The name of the rule that you want to see data from.</p>"];
      start_time: DateTime.t
        [@ocaml.doc
          "<p>The start time of the data to use in the report. When used in a raw HTTP Query API, it is formatted as <code>yyyy-MM-dd'T'HH:mm:ss</code>. For example, <code>2019-07-01T23:59:59</code>.</p>"];
      end_time: DateTime.t
        [@ocaml.doc
          "<p>The end time of the data to use in the report. When used in a raw HTTP Query API, it is formatted as <code>yyyy-MM-dd'T'HH:mm:ss</code>. For example, <code>2019-07-01T23:59:59</code>.</p>"];
      period: Integer.t
        [@ocaml.doc
          "<p>The period, in seconds, to use for the statistics in the <code>InsightRuleMetricDatapoint</code> results.</p>"];
      max_contributor_count: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of contributors to include in the report. The range is 1 to 100. If you omit this, the default of 10 is used.</p>"];
      metrics: InsightRuleMetricList.t
        [@ocaml.doc
          "<p>Specifies which metrics to use for aggregation of contributor values for the report. You can specify one or more of the following metrics:</p> <ul> <li> <p> <code>UniqueContributors</code> -- the number of unique contributors for each data point.</p> </li> <li> <p> <code>MaxContributorValue</code> -- the value of the top contributor for each data point. The identity of the contributor may change for each data point in the graph.</p> <p>If this rule aggregates by COUNT, the top contributor for each data point is the contributor with the most occurrences in that period. If the rule aggregates by SUM, the top contributor is the contributor with the highest sum in the log field specified by the rule's <code>Value</code>, during that period.</p> </li> <li> <p> <code>SampleCount</code> -- the number of data points matched by the rule.</p> </li> <li> <p> <code>Sum</code> -- the sum of the values from all contributors during the time period represented by that data point.</p> </li> <li> <p> <code>Minimum</code> -- the minimum value from a single observation during the time period represented by that data point.</p> </li> <li> <p> <code>Maximum</code> -- the maximum value from a single observation during the time period represented by that data point.</p> </li> <li> <p> <code>Average</code> -- the average value from all contributors during the time period represented by that data point.</p> </li> </ul>"];
      order_by: String.t option
        [@ocaml.doc
          "<p>Determines what statistic to use to rank the contributors. Valid values are SUM and MAXIMUM.</p>"]}
    let make ~rule_name  ~start_time  ~end_time  ~period 
      ?max_contributor_count  ?(metrics= [])  ?order_by  () =
      {
        rule_name;
        start_time;
        end_time;
        period;
        max_contributor_count;
        metrics;
        order_by
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.order_by
              (fun f -> ("order_by", (String.to_json f)));
           Some ("metrics", (InsightRuleMetricList.to_json v.metrics));
           Util.option_map v.max_contributor_count
             (fun f -> ("max_contributor_count", (Integer.to_json f)));
           Some ("period", (Integer.to_json v.period));
           Some ("end_time", (DateTime.to_json v.end_time));
           Some ("start_time", (DateTime.to_json v.start_time));
           Some ("rule_name", (String.to_json v.rule_name))])
    let parse xml =
      Some
        {
          rule_name =
            (Xml.required "RuleName"
               (Util.option_bind (Xml.member "RuleName" xml) String.parse));
          start_time =
            (Xml.required "StartTime"
               (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse));
          end_time =
            (Xml.required "EndTime"
               (Util.option_bind (Xml.member "EndTime" xml) DateTime.parse));
          period =
            (Xml.required "Period"
               (Util.option_bind (Xml.member "Period" xml) Integer.parse));
          max_contributor_count =
            (Util.option_bind (Xml.member "MaxContributorCount" xml)
               Integer.parse);
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml)
                  InsightRuleMetricList.parse));
          order_by =
            (Util.option_bind (Xml.member "OrderBy" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "RuleName"
                       ([], (String.to_xml v.rule_name)))])
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
             [Util.option_map v.max_contributor_count
                (fun f ->
                   Ezxmlm.make_tag "MaxContributorCount"
                     ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Metrics"
                       ([], (InsightRuleMetricList.to_xml [x])))) v.metrics))
           @
           [Util.option_map v.order_by
              (fun f -> Ezxmlm.make_tag "OrderBy" ([], (String.to_xml f)))])
  end
module GetInsightRuleReportOutput = GetInsightRuleReportOutput
type input = GetInsightRuleReportInput.t
type output = GetInsightRuleReportOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["GetInsightRuleReport"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetInsightRuleReportInput.to_query req))))) in
  (`POST, uri, (Headers.render (GetInsightRuleReportInput.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetInsightRuleReportResponse" (snd xml))
        (Xml.member "GetInsightRuleReportResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp GetInsightRuleReportOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetInsightRuleReportOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetInsightRuleReportOutput - missing field in body or children: "
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