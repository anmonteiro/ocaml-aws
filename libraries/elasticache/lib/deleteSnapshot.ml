open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteSnapshotMessage =
  struct
    type t =
      {
      snapshot_name: String.t
        [@ocaml.doc "<p>The name of the snapshot to be deleted.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>DeleteSnapshot</code> operation.</p>"]
    let make ~snapshot_name  () = { snapshot_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("snapshot_name", (String.to_json v.snapshot_name))])
    let parse xml =
      Some
        {
          snapshot_name =
            (Xml.required "SnapshotName"
               (Util.option_bind (Xml.member "SnapshotName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "SnapshotName"
                 ([], (String.to_xml v.snapshot_name)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>DeleteSnapshot</code> operation.</p>"]
module DeleteSnapshotResult = DeleteSnapshotResult
type input = DeleteSnapshotMessage.t
type output = DeleteSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DeleteSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteSnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteSnapshotResponse" (snd xml))
        (Xml.member "DeleteSnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteSnapshotResult - missing field in body or children: "
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