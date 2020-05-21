open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListMetricsInput =
  struct
    type t =
      {
      namespace: String.t option
        [@ocaml.doc "<p>The namespace to filter against.</p>"];
      metric_name: String.t option
        [@ocaml.doc "<p>The name of the metric to filter against.</p>"];
      dimensions: DimensionFilters.t
        [@ocaml.doc "<p>The dimensions to filter against.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token returned by a previous call to indicate that there is more data available.</p>"]}
    let make ?namespace  ?metric_name  ?(dimensions= [])  ?next_token  () =
      { namespace; metric_name; dimensions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("dimensions", (DimensionFilters.to_json v.dimensions));
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
                  DimensionFilters.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
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
                       ([], (DimensionFilters.to_xml [x])))) v.dimensions))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListMetricsOutput = ListMetricsOutput
type input = ListMetricsInput.t
type output = ListMetricsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-08-01"]); ("Action", ["ListMetrics"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListMetricsInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListMetricsInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListMetricsResponse" (snd xml))
        (Xml.member "ListMetricsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListMetricsOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListMetricsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListMetricsOutput - missing field in body or children: "
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