open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDBSnapshotMessage =
  struct
    type t =
      {
      d_b_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The DB snapshot identifier.</p> <p>Constraints: Must be the name of an existing DB snapshot in the <code>available</code> state.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_snapshot_identifier  () = { d_b_snapshot_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_snapshot_identifier",
                (String.to_json v.d_b_snapshot_identifier))])
    let parse xml =
      Some
        {
          d_b_snapshot_identifier =
            (Xml.required "DBSnapshotIdentifier"
               (Util.option_bind (Xml.member "DBSnapshotIdentifier" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DBSnapshotIdentifier"
                 ([], (String.to_xml v.d_b_snapshot_identifier)))])
  end[@@ocaml.doc "<p/>"]
module DeleteDBSnapshotResult = DeleteDBSnapshotResult
type input = DeleteDBSnapshotMessage.t
type output = DeleteDBSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DeleteDBSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteDBSnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteDBSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteDBSnapshotResponse" (snd xml))
        (Xml.member "DeleteDBSnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteDBSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteDBSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteDBSnapshotResult - missing field in body or children: "
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