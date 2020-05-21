open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBSnapshotMessage =
  struct
    type t =
      {
      d_b_snapshot_identifier: String.t
        [@ocaml.doc "<p>The identifier of the DB snapshot to modify.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The engine version to upgrade the DB snapshot to. </p> <p>The following are the database engines and engine versions that are available when you upgrade a DB snapshot. </p> <p> <b>MySQL</b> </p> <ul> <li> <p> <code>5.5.46</code> (supported for 5.1 DB snapshots)</p> </li> </ul> <p> <b>Oracle</b> </p> <ul> <li> <p> <code>12.1.0.2.v8</code> (supported for 12.1.0.1 DB snapshots)</p> </li> <li> <p> <code>11.2.0.4.v12</code> (supported for 11.2.0.2 DB snapshots)</p> </li> <li> <p> <code>11.2.0.4.v11</code> (supported for 11.2.0.3 DB snapshots)</p> </li> </ul> <p> <b>PostgreSQL</b> </p> <p>For the list of engine versions that are available for upgrading a DB snapshot, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.PostgreSQL.html#USER_UpgradeDBInstance.PostgreSQL.MajorVersion\"> Upgrading the PostgreSQL DB Engine for Amazon RDS</a>. </p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The option group to identify with the upgraded DB snapshot. </p> <p>You can specify this parameter when you upgrade an Oracle DB snapshot. The same option group considerations apply when upgrading a DB snapshot as when upgrading a DB instance. For more information, see <a href=\"http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_UpgradeDBInstance.Oracle.html#USER_UpgradeDBInstance.Oracle.OGPG.OG\">Option Group Considerations</a> in the <i>Amazon RDS User Guide.</i> </p>"]}
    let make ~d_b_snapshot_identifier  ?engine_version  ?option_group_name 
      () = { d_b_snapshot_identifier; engine_version; option_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.option_group_name
              (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Some
             ("d_b_snapshot_identifier",
               (String.to_json v.d_b_snapshot_identifier))])
    let parse xml =
      Some
        {
          d_b_snapshot_identifier =
            (Xml.required "DBSnapshotIdentifier"
               (Util.option_bind (Xml.member "DBSnapshotIdentifier" xml)
                  String.parse));
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBSnapshotIdentifier"
                   ([], (String.to_xml v.d_b_snapshot_identifier)))])
            @
            [Util.option_map v.engine_version
               (fun f ->
                  Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
           @
           [Util.option_map v.option_group_name
              (fun f ->
                 Ezxmlm.make_tag "OptionGroupName" ([], (String.to_xml f)))])
  end
module ModifyDBSnapshotResult = ModifyDBSnapshotResult
type input = ModifyDBSnapshotMessage.t
type output = ModifyDBSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyDBSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBSnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyDBSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyDBSnapshotResponse" (snd xml))
        (Xml.member "ModifyDBSnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyDBSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyDBSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBSnapshotResult - missing field in body or children: "
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