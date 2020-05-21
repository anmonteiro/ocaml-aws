open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDBInstanceAutomatedBackupMessage =
  struct
    type t =
      {
      dbi_resource_id: String.t
        [@ocaml.doc
          "<p>The identifier for the source DB instance, which can't be changed and which is unique to an AWS Region.</p>"]}
    [@@ocaml.doc
      "<p>Parameter input for the <code>DeleteDBInstanceAutomatedBackup</code> operation. </p>"]
    let make ~dbi_resource_id  () = { dbi_resource_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("dbi_resource_id", (String.to_json v.dbi_resource_id))])
    let parse xml =
      Some
        {
          dbi_resource_id =
            (Xml.required "DbiResourceId"
               (Util.option_bind (Xml.member "DbiResourceId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DbiResourceId"
                 ([], (String.to_xml v.dbi_resource_id)))])
  end[@@ocaml.doc
       "<p>Parameter input for the <code>DeleteDBInstanceAutomatedBackup</code> operation. </p>"]
module DeleteDBInstanceAutomatedBackupResult =
  DeleteDBInstanceAutomatedBackupResult
type input = DeleteDBInstanceAutomatedBackupMessage.t
type output = DeleteDBInstanceAutomatedBackupResult.t
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
         ("Action", ["DeleteDBInstanceAutomatedBackup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DeleteDBInstanceAutomatedBackupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteDBInstanceAutomatedBackupMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DeleteDBInstanceAutomatedBackupResponse" (snd xml))
        (Xml.member "DeleteDBInstanceAutomatedBackupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteDBInstanceAutomatedBackupResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteDBInstanceAutomatedBackupResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteDBInstanceAutomatedBackupResult - missing field in body or children: "
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