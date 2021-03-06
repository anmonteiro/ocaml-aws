open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReplicationGroupsMessage =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>The identifier for the replication group to be described. This parameter is not case sensitive.</p> <p>If you do not specify this parameter, information about all replication groups is returned.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of records to include in the response. If more records exist than the specified <code>MaxRecords</code> value, a marker is included in the response so that the remaining results can be retrieved.</p> <p>Default: 100</p> <p>Constraints: minimum 20; maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional marker returned from a prior request. Use this marker for pagination of results from this operation. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DescribeReplicationGroups</code> operation.</p>"]
    let make ?replication_group_id  ?max_records  ?marker  () =
      { replication_group_id; max_records; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.replication_group_id
                (fun f ->
                   Ezxmlm.make_tag "ReplicationGroupId"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DescribeReplicationGroups</code> operation.</p>"]
module ReplicationGroupMessage = ReplicationGroupMessage
type input = DescribeReplicationGroupsMessage.t
type output = ReplicationGroupMessage.t
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
         ("Action", ["DescribeReplicationGroups"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeReplicationGroupsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeReplicationGroupsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeReplicationGroupsResponse" (snd xml))
        (Xml.member "DescribeReplicationGroupsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ReplicationGroupMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ReplicationGroupMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReplicationGroupMessage - missing field in body or children: "
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