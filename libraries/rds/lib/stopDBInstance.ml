open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StopDBInstanceMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc "<p> The user-supplied instance identifier. </p>"];
      d_b_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p> The user-supplied instance identifier of the DB Snapshot created immediately before the DB instance is stopped. </p>"]}
    let make ~d_b_instance_identifier  ?d_b_snapshot_identifier  () =
      { d_b_instance_identifier; d_b_snapshot_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot_identifier
              (fun f -> ("d_b_snapshot_identifier", (String.to_json f)));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "DBSnapshotIdentifier" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DBInstanceIdentifier"
                  ([], (String.to_xml v.d_b_instance_identifier)))])
           @
           [Util.option_map v.d_b_snapshot_identifier
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshotIdentifier"
                   ([], (String.to_xml f)))])
  end
module StopDBInstanceResult = StopDBInstanceResult
type input = StopDBInstanceMessage.t
type output = StopDBInstanceResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["StopDBInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StopDBInstanceMessage.to_query req))))) in
  (`POST, uri, (Headers.render (StopDBInstanceMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "StopDBInstanceResponse" (snd xml))
        (Xml.member "StopDBInstanceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp StopDBInstanceResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed StopDBInstanceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StopDBInstanceResult - missing field in body or children: "
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