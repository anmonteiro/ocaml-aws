open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeCertificatesMessage =
  struct
    type t =
      {
      certificate_identifier: String.t option
        [@ocaml.doc
          "<p>The user-supplied certificate identifier. If this parameter is specified, information for only the identified certificate is returned. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must match an existing CertificateIdentifier.</p> </li> </ul>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeCertificates</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?certificate_identifier  ?(filters= [])  ?max_records  ?marker 
      () = { certificate_identifier; filters; max_records; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.certificate_identifier
             (fun f -> ("certificate_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          certificate_identifier =
            (Util.option_bind (Xml.member "CertificateIdentifier" xml)
               String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.certificate_identifier
                 (fun f ->
                    Ezxmlm.make_tag "CertificateIdentifier"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filters" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module CertificateMessage = CertificateMessage
type input = DescribeCertificatesMessage.t
type output = CertificateMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DescribeCertificates"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeCertificatesMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeCertificatesMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeCertificatesResponse" (snd xml))
        (Xml.member "DescribeCertificatesResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CertificateMessage.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CertificateMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CertificateMessage - missing field in body or children: "
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