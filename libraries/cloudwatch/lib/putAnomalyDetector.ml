open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutAnomalyDetectorInput =
  struct
    type t =
      {
      namespace: String.t
        [@ocaml.doc
          "<p>The namespace of the metric to create the anomaly detection model for.</p>"];
      metric_name: String.t
        [@ocaml.doc
          "<p>The name of the metric to create the anomaly detection model for.</p>"];
      dimensions: Dimensions.t
        [@ocaml.doc
          "<p>The metric dimensions to create the anomaly detection model for.</p>"];
      stat: String.t
        [@ocaml.doc
          "<p>The statistic to use for the metric and the anomaly detection model.</p>"];
      configuration: AnomalyDetectorConfiguration.t option
        [@ocaml.doc
          "<p>The configuration specifies details about how the anomaly detection model is to be trained, including time ranges to exclude when training and updating the model. You can specify as many as 10 time ranges.</p> <p>The configuration can also include the time zone to use for the metric.</p> <p>You can in</p>"]}
    let make ~namespace  ~metric_name  ?(dimensions= [])  ~stat 
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
           Some ("stat", (String.to_json v.stat));
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
          stat =
            (Xml.required "Stat"
               (Util.option_bind (Xml.member "Stat" xml) String.parse));
          configuration =
            (Util.option_bind (Xml.member "Configuration" xml)
               AnomalyDetectorConfiguration.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
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
            @ [Some (Ezxmlm.make_tag "Stat" ([], (String.to_xml v.stat)))])
           @
           [Util.option_map v.configuration
              (fun f ->
                 Ezxmlm.make_tag "Configuration"
                   ([], (AnomalyDetectorConfiguration.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = PutAnomalyDetectorInput.t
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
         [("Version", ["2010-08-01"]); ("Action", ["PutAnomalyDetector"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PutAnomalyDetectorInput.to_query req))))) in
  (`POST, uri, (Headers.render (PutAnomalyDetectorInput.to_headers req)), "")
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