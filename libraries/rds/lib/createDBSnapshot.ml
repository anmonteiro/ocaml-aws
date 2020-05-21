open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBSnapshotMessage =
  struct
    type t =
      {
      d_b_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the DB snapshot.</p> <p>Constraints:</p> <ul> <li> <p>Can't be null, empty, or blank</p> </li> <li> <p>Must contain from 1 to 255 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-snapshot-id</code> </p>"];
      d_b_instance_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the DB instance that you want to create the snapshot of.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBInstance.</p> </li> </ul>"];
      tags: TagList.t }[@@ocaml.doc "<p/>"]
    let make ~d_b_snapshot_identifier  ~d_b_instance_identifier  ?(tags= []) 
      () = { d_b_snapshot_identifier; d_b_instance_identifier; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("d_b_instance_identifier",
               (String.to_json v.d_b_instance_identifier));
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
          d_b_instance_identifier =
            (Xml.required "DBInstanceIdentifier"
               (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
                  String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBSnapshotIdentifier"
                   ([], (String.to_xml v.d_b_snapshot_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "DBInstanceIdentifier"
                  ([], (String.to_xml v.d_b_instance_identifier)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CreateDBSnapshotResult = CreateDBSnapshotResult
type input = CreateDBSnapshotMessage.t
type output = CreateDBSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateDBSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBSnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateDBSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateDBSnapshotResponse" (snd xml))
        (Xml.member "CreateDBSnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateDBSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateDBSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBSnapshotResult - missing field in body or children: "
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