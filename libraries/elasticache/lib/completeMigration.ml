open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CompleteMigrationMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The ID of the replication group to which data is being migrated.</p>"];
      force: Boolean.t option
        [@ocaml.doc
          "<p>Forces the migration to stop without ensuring that data is in sync. It is recommended to use this option only to abort the migration and not recommended when application wants to continue migration to ElastiCache.</p>"]}
    let make ~replication_group_id  ?force  () =
      { replication_group_id; force }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.force (fun f -> ("force", (Boolean.to_json f)));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          force = (Util.option_bind (Xml.member "Force" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ReplicationGroupId"
                  ([], (String.to_xml v.replication_group_id)))])
           @
           [Util.option_map v.force
              (fun f -> Ezxmlm.make_tag "Force" ([], (Boolean.to_xml f)))])
  end
module CompleteMigrationResponse = CompleteMigrationResponse
type input = CompleteMigrationMessage.t
type output = CompleteMigrationResponse.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["CompleteMigration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CompleteMigrationMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CompleteMigrationMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CompleteMigrationResponse" (snd xml))
        (Xml.member "CompleteMigrationResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CompleteMigrationResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CompleteMigrationResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CompleteMigrationResponse - missing field in body or children: "
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