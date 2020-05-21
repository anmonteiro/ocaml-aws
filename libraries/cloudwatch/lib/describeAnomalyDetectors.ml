open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAnomalyDetectorsInput =
  struct
    type t =
      {
      next_token: String.t option
        [@ocaml.doc
          "<p>Use the token returned by the previous operation to request the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in one operation. The maximum value you can specify is 10.</p> <p>To retrieve the remaining results, make another call with the returned <code>NextToken</code> value. </p>"];
      namespace: String.t option
        [@ocaml.doc
          "<p>Limits the results to only the anomaly detection models that are associated with the specified namespace.</p>"];
      metric_name: String.t option
        [@ocaml.doc
          "<p>Limits the results to only the anomaly detection models that are associated with the specified metric name. If there are multiple metrics with this name in different namespaces that have anomaly detection models, they're all returned.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>Limits the results to only the anomaly detection models that are associated with the specified metric dimensions. If there are multiple metrics that have these dimensions and have anomaly detection models associated, they're all returned.</p>"]}
    let make ?next_token  ?max_results  ?namespace  ?metric_name 
      ?(dimensions= [])  () =
      { next_token; max_results; namespace; metric_name; dimensions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("dimensions", (Dimensions.to_json v.dimensions));
           Util.option_map v.metric_name
             (fun f -> ("metric_name", (String.to_json f)));
           Util.option_map v.namespace
             (fun f -> ("namespace", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
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
        ((((([] @
               [Util.option_map v.next_token
                  (fun f ->
                     Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
              @
              [Util.option_map v.max_results
                 (fun f ->
                    Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
             @
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
  end
module DescribeAnomalyDetectorsOutput = DescribeAnomalyDetectorsOutput
type input = DescribeAnomalyDetectorsInput.t
type output = DescribeAnomalyDetectorsOutput.t
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
         ("Action", ["DescribeAnomalyDetectors"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeAnomalyDetectorsInput.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeAnomalyDetectorsInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeAnomalyDetectorsResponse" (snd xml))
        (Xml.member "DescribeAnomalyDetectorsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeAnomalyDetectorsOutput.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeAnomalyDetectorsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeAnomalyDetectorsOutput - missing field in body or children: "
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