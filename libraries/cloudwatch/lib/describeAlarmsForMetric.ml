open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAlarmsForMetricInput =
  struct
    type t =
      {
      metric_name: String.t [@ocaml.doc "<p>The name of the metric.</p>"];
      namespace: String.t [@ocaml.doc "<p>The namespace of the metric.</p>"];
      statistic: Statistic.t option
        [@ocaml.doc
          "<p>The statistic for the metric, other than percentiles. For percentile statistics, use <code>ExtendedStatistics</code>.</p>"];
      extended_statistic: String.t option
        [@ocaml.doc
          "<p>The percentile statistic for the metric. Specify a value between p0.0 and p100.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>The dimensions associated with the metric. If the metric has any associated dimensions, you must specify them in order for the call to succeed.</p>"];
      period: Integer.t option
        [@ocaml.doc
          "<p>The period, in seconds, over which the statistic is applied.</p>"];
      unit: StandardUnit.t option
        [@ocaml.doc "<p>The unit for the metric.</p>"]}
    let make ~metric_name  ~namespace  ?statistic  ?extended_statistic 
      ?(dimensions= [])  ?period  ?unit  () =
      {
        metric_name;
        namespace;
        statistic;
        extended_statistic;
        dimensions;
        period;
        unit
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.unit
              (fun f -> ("unit", (StandardUnit.to_json f)));
           Util.option_map v.period
             (fun f -> ("period", (Integer.to_json f)));
           Some ("dimensions", (Dimensions.to_json v.dimensions));
           Util.option_map v.extended_statistic
             (fun f -> ("extended_statistic", (String.to_json f)));
           Util.option_map v.statistic
             (fun f -> ("statistic", (Statistic.to_json f)));
           Some ("namespace", (String.to_json v.namespace));
           Some ("metric_name", (String.to_json v.metric_name))])
    let parse xml =
      Some
        {
          metric_name =
            (Xml.required "MetricName"
               (Util.option_bind (Xml.member "MetricName" xml) String.parse));
          namespace =
            (Xml.required "Namespace"
               (Util.option_bind (Xml.member "Namespace" xml) String.parse));
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
            (Util.option_bind (Xml.member "Unit" xml) StandardUnit.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "MetricName"
                       ([], (String.to_xml v.metric_name)))])
                @
                [Some
                   (Ezxmlm.make_tag "Namespace"
                      ([], (String.to_xml v.namespace)))])
               @
               [Util.option_map v.statistic
                  (fun f ->
                     Ezxmlm.make_tag "Statistic" ([], (Statistic.to_xml f)))])
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
               (fun f -> Ezxmlm.make_tag "Period" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.unit
              (fun f -> Ezxmlm.make_tag "Unit" ([], (StandardUnit.to_xml f)))])
  end
module DescribeAlarmsForMetricOutput = DescribeAlarmsForMetricOutput
type input = DescribeAlarmsForMetricInput.t
type output = DescribeAlarmsForMetricOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]);
         ("Action", ["DescribeAlarmsForMetric"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeAlarmsForMetricInput.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeAlarmsForMetricInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeAlarmsForMetricResponse" (snd xml))
        (Xml.member "DescribeAlarmsForMetricResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeAlarmsForMetricOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeAlarmsForMetricOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeAlarmsForMetricOutput - missing field in body or children: "
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