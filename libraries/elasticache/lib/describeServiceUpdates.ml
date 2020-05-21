open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeServiceUpdatesMessage =
  struct
    type t =
      {
      service_update_name: String.t option
        [@ocaml.doc "<p>The unique ID of the service update</p>"];
      service_update_status: ServiceUpdateStatusList.t
        [@ocaml.doc "<p>The status of the service update</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
    let make ?service_update_name  ?(service_update_status= [])  ?max_records
       ?marker  () =
      { service_update_name; service_update_status; max_records; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some
             ("service_update_status",
               (ServiceUpdateStatusList.to_json v.service_update_status));
           Util.option_map v.service_update_name
             (fun f -> ("service_update_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          service_update_name =
            (Util.option_bind (Xml.member "ServiceUpdateName" xml)
               String.parse);
          service_update_status =
            (Util.of_option []
               (Util.option_bind (Xml.member "ServiceUpdateStatus" xml)
                  ServiceUpdateStatusList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.service_update_name
                 (fun f ->
                    Ezxmlm.make_tag "ServiceUpdateName"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ServiceUpdateStatus"
                        ([], (ServiceUpdateStatusList.to_xml [x]))))
                v.service_update_status))
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end
module ServiceUpdatesMessage = ServiceUpdatesMessage
type input = DescribeServiceUpdatesMessage.t
type output = ServiceUpdatesMessage.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]);
         ("Action", ["DescribeServiceUpdates"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeServiceUpdatesMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeServiceUpdatesMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeServiceUpdatesResponse" (snd xml))
        (Xml.member "DescribeServiceUpdatesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ServiceUpdatesMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ServiceUpdatesMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ServiceUpdatesMessage - missing field in body or children: "
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