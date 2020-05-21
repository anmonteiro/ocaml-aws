open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeDBInstanceAutomatedBackupsMessage =
  struct
    type t =
      {
      dbi_resource_id: String.t option
        [@ocaml.doc
          "<p>The resource ID of the DB instance that is the source of the automated backup. This parameter isn't case-sensitive. </p>"];
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>(Optional) The user-supplied instance identifier. If this parameter is specified, it must match the identifier of an existing DB instance. It returns information from the specific DB instance' automated backup. This parameter isn't case-sensitive. </p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>A filter that specifies which resources to return based on status.</p> <p>Supported filters are the following:</p> <ul> <li> <p> <code>status</code> </p> <ul> <li> <p> <code>active</code> - automated backups for current instances</p> </li> <li> <p> <code>retained</code> - automated backups for deleted instances</p> </li> <li> <p> <code>creating</code> - automated backups that are waiting for the first automated snapshot to be available</p> </li> </ul> </li> <li> <p> <code>db-instance-id</code> - Accepts DB instance identifiers and Amazon Resource Names (ARNs) for DB instances. The results list includes only information about the DB instance automated backupss identified by these ARNs.</p> </li> <li> <p> <code>dbi-resource-id</code> - Accepts DB instance resource identifiers and DB Amazon Resource Names (ARNs) for DB instances. The results list includes only information about the DB instance resources identified by these ARNs.</p> </li> </ul> <p>Returns all resources by default. The status for each resource is specified in the response.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a pagination token called a marker is included in the response so that you can retrieve the remaining results.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>The pagination token provided in the previous request. If this parameter is specified the response includes only records beyond the marker, up to <code>MaxRecords</code>.</p>"]}
    [@@ocaml.doc
      "<p>Parameter input for DescribeDBInstanceAutomatedBackups. </p>"]
    let make ?dbi_resource_id  ?d_b_instance_identifier  ?(filters= []) 
      ?max_records  ?marker  () =
      {
        dbi_resource_id;
        d_b_instance_identifier;
        filters;
        max_records;
        marker
      }
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
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)));
           Util.option_map v.dbi_resource_id
             (fun f -> ("dbi_resource_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          dbi_resource_id =
            (Util.option_bind (Xml.member "DbiResourceId" xml) String.parse);
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
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
        ((((([] @
               [Util.option_map v.dbi_resource_id
                  (fun f ->
                     Ezxmlm.make_tag "DbiResourceId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.d_b_instance_identifier
                 (fun f ->
                    Ezxmlm.make_tag "DBInstanceIdentifier"
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
  end[@@ocaml.doc
       "<p>Parameter input for DescribeDBInstanceAutomatedBackups. </p>"]
module DBInstanceAutomatedBackupMessage = DBInstanceAutomatedBackupMessage
type input = DescribeDBInstanceAutomatedBackupsMessage.t
type output = DBInstanceAutomatedBackupMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["DescribeDBInstanceAutomatedBackups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeDBInstanceAutomatedBackupsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeDBInstanceAutomatedBackupsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeDBInstanceAutomatedBackupsResponse" (snd xml))
        (Xml.member "DescribeDBInstanceAutomatedBackupsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DBInstanceAutomatedBackupMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DBInstanceAutomatedBackupMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBInstanceAutomatedBackupMessage - missing field in body or children: "
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