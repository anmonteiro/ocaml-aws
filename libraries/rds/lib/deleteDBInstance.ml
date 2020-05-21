open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDBInstanceMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier for the DB instance to be deleted. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must match the name of an existing DB instance.</p> </li> </ul>"];
      skip_final_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to skip the creation of a final DB snapshot before the DB instance is deleted. If skip is specified, no DB snapshot is created. If skip isn't specified, a DB snapshot is created before the DB instance is deleted. By default, skip isn't specified, and the DB snapshot is created.</p> <p>Note that when a DB instance is in a failure state and has a status of 'failed', 'incompatible-restore', or 'incompatible-network', it can only be deleted when skip is specified.</p> <p>Specify skip when deleting a Read Replica.</p> <note> <p>The FinalDBSnapshotIdentifier parameter must be specified if skip isn't specified.</p> </note>"];
      final_d_b_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p> The <code>DBSnapshotIdentifier</code> of the new <code>DBSnapshot</code> created when the <code>SkipFinalSnapshot</code> parameter is disabled. </p> <note> <p>Specifying this parameter and also specifying to skip final DB snapshot creation in SkipFinalShapshot results in an error.</p> </note> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters or numbers.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> <li> <p>Can't be specified when deleting a Read Replica.</p> </li> </ul>"];
      delete_automated_backups: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to remove automated backups immediately after the DB instance is deleted. This parameter isn't case-sensitive. The default is to remove automated backups immediately after the DB instance is deleted.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_instance_identifier  ?skip_final_snapshot 
      ?final_d_b_snapshot_identifier  ?delete_automated_backups  () =
      {
        d_b_instance_identifier;
        skip_final_snapshot;
        final_d_b_snapshot_identifier;
        delete_automated_backups
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.delete_automated_backups
              (fun f -> ("delete_automated_backups", (Boolean.to_json f)));
           Util.option_map v.final_d_b_snapshot_identifier
             (fun f -> ("final_d_b_snapshot_identifier", (String.to_json f)));
           Util.option_map v.skip_final_snapshot
             (fun f -> ("skip_final_snapshot", (Boolean.to_json f)));
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
          skip_final_snapshot =
            (Util.option_bind (Xml.member "SkipFinalSnapshot" xml)
               Boolean.parse);
          final_d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "FinalDBSnapshotIdentifier" xml)
               String.parse);
          delete_automated_backups =
            (Util.option_bind (Xml.member "DeleteAutomatedBackups" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBInstanceIdentifier"
                    ([], (String.to_xml v.d_b_instance_identifier)))])
             @
             [Util.option_map v.skip_final_snapshot
                (fun f ->
                   Ezxmlm.make_tag "SkipFinalSnapshot"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.final_d_b_snapshot_identifier
               (fun f ->
                  Ezxmlm.make_tag "FinalDBSnapshotIdentifier"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.delete_automated_backups
              (fun f ->
                 Ezxmlm.make_tag "DeleteAutomatedBackups"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module DeleteDBInstanceResult = DeleteDBInstanceResult
type input = DeleteDBInstanceMessage.t
type output = DeleteDBInstanceResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DeleteDBInstance"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteDBInstanceMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteDBInstanceMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteDBInstanceResponse" (snd xml))
        (Xml.member "DeleteDBInstanceResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteDBInstanceResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteDBInstanceResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteDBInstanceResult - missing field in body or children: "
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