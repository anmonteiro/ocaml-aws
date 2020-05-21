open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PromoteReadReplicaMessage =
  struct
    type t =
      {
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The DB instance identifier. This value is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing Read Replica DB instance.</p> </li> </ul> <p>Example: <code>mydbinstance</code> </p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The number of days for which automated backups are retained. Setting this parameter to a positive number enables backups. Setting this parameter to 0 disables automated backups.</p> <p>Default: 1</p> <p>Constraints:</p> <ul> <li> <p>Must be a value from 0 to 35.</p> </li> <li> <p>Can't be set to 0 if the DB instance is a source to Read Replicas.</p> </li> </ul>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p> The daily time range during which automated backups are created if automated backups are enabled, using the <code>BackupRetentionPeriod</code> parameter. </p> <p> The default is a 30-minute window selected at random from an 8-hour block of time for each AWS Region. To see the time blocks available, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/AdjustingTheMaintenanceWindow.html\"> Adjusting the Preferred Maintenance Window</a> in the <i>Amazon RDS User Guide.</i> </p> <p>Constraints:</p> <ul> <li> <p>Must be in the format <code>hh24:mi-hh24:mi</code>.</p> </li> <li> <p>Must be in Universal Coordinated Time (UTC).</p> </li> <li> <p>Must not conflict with the preferred maintenance window.</p> </li> <li> <p>Must be at least 30 minutes.</p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_instance_identifier  ?backup_retention_period 
      ?preferred_backup_window  () =
      {
        d_b_instance_identifier;
        backup_retention_period;
        preferred_backup_window
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.preferred_backup_window
              (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
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
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          preferred_backup_window =
            (Util.option_bind (Xml.member "PreferredBackupWindow" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBInstanceIdentifier"
                   ([], (String.to_xml v.d_b_instance_identifier)))])
            @
            [Util.option_map v.backup_retention_period
               (fun f ->
                  Ezxmlm.make_tag "BackupRetentionPeriod"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.preferred_backup_window
              (fun f ->
                 Ezxmlm.make_tag "PreferredBackupWindow"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module PromoteReadReplicaResult = PromoteReadReplicaResult
type input = PromoteReadReplicaMessage.t
type output = PromoteReadReplicaResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["PromoteReadReplica"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (PromoteReadReplicaMessage.to_query req))))) in
  (`POST, uri, (Headers.render (PromoteReadReplicaMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "PromoteReadReplicaResponse" (snd xml))
        (Xml.member "PromoteReadReplicaResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp PromoteReadReplicaResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PromoteReadReplicaResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PromoteReadReplicaResult - missing field in body or children: "
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