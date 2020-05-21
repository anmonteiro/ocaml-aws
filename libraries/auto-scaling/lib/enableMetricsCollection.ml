open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module EnableMetricsCollectionQuery =
  struct
    type t =
      {
      auto_scaling_group_name: String.t
        [@ocaml.doc "<p>The name of the Auto Scaling group.</p>"];
      metrics: Metrics.t
        [@ocaml.doc
          "<p>One or more of the following metrics. If you omit this parameter, all metrics are enabled.</p> <ul> <li> <p> <code>GroupMinSize</code> </p> </li> <li> <p> <code>GroupMaxSize</code> </p> </li> <li> <p> <code>GroupDesiredCapacity</code> </p> </li> <li> <p> <code>GroupInServiceInstances</code> </p> </li> <li> <p> <code>GroupPendingInstances</code> </p> </li> <li> <p> <code>GroupStandbyInstances</code> </p> </li> <li> <p> <code>GroupTerminatingInstances</code> </p> </li> <li> <p> <code>GroupTotalInstances</code> </p> </li> </ul>"];
      granularity: String.t
        [@ocaml.doc
          "<p>The granularity to associate with the metrics to collect. The only valid value is <code>1Minute</code>.</p>"]}
    let make ~auto_scaling_group_name  ?(metrics= [])  ~granularity  () =
      { auto_scaling_group_name; metrics; granularity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("granularity", (String.to_json v.granularity));
           Some ("metrics", (Metrics.to_json v.metrics));
           Some
             ("auto_scaling_group_name",
               (String.to_json v.auto_scaling_group_name))])
    let parse xml =
      Some
        {
          auto_scaling_group_name =
            (Xml.required "AutoScalingGroupName"
               (Util.option_bind (Xml.member "AutoScalingGroupName" xml)
                  String.parse));
          metrics =
            (Util.of_option []
               (Util.option_bind (Xml.member "Metrics" xml) Metrics.parse));
          granularity =
            (Xml.required "Granularity"
               (Util.option_bind (Xml.member "Granularity" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AutoScalingGroupName"
                   ([], (String.to_xml v.auto_scaling_group_name)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Metrics" ([], (Metrics.to_xml [x]))))
               v.metrics))
           @
           [Some
              (Ezxmlm.make_tag "Granularity"
                 ([], (String.to_xml v.granularity)))])
  end
module Output = Aws.BaseTypes.Unit
type input = EnableMetricsCollectionQuery.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-01-01"]);
         ("Action", ["EnableMetricsCollection"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (EnableMetricsCollectionQuery.to_query req))))) in
  (`POST, uri,
    (Headers.render (EnableMetricsCollectionQuery.to_headers req)), "")
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