open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutMetricDataInput =
  struct
    type t =
      {
      namespace: String.t
        [@ocaml.doc
          "<p>The namespace for the metric data.</p> <p>To avoid conflicts with AWS service namespaces, you should not specify a namespace that begins with <code>AWS/</code> </p>"];
      metric_data: MetricData.t
        [@ocaml.doc
          "<p>The data for the metric. The array can include no more than 20 metrics per call.</p>"]}
    let make ~namespace  ~metric_data  () = { namespace; metric_data }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("metric_data", (MetricData.to_json v.metric_data));
           Some ("namespace", (String.to_json v.namespace))])
    let parse xml =
      Some
        {
          namespace =
            (Xml.required "Namespace"
               (Util.option_bind (Xml.member "Namespace" xml) String.parse));
          metric_data =
            (Xml.required "MetricData"
               (Util.option_bind (Xml.member "MetricData" xml)
                  MetricData.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Namespace" ([], (String.to_xml v.namespace)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "MetricData"
                      ([], (MetricData.to_xml [x])))) v.metric_data))
  end
module Output = Aws.BaseTypes.Unit
type input = PutMetricDataInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["PutMetricData"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutMetricDataInput.to_query req))))) in
  (`POST, uri, (Headers.render (PutMetricDataInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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