open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateGlobalClusterMessage =
  struct
    type t =
      {
      global_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The cluster identifier of the new global database cluster.</p>"];
      source_d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> The Amazon Resource Name (ARN) to use as the primary cluster of the global database. This parameter is optional. </p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>Provides the name of the database engine to be used for this DB cluster.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The engine version of the Aurora global database.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p> The deletion protection setting for the new global database. The global database can't be deleted when deletion protection is enabled. </p>"];
      database_name: String.t option
        [@ocaml.doc
          "<p> The name for your database of up to 64 alpha-numeric characters. If you do not provide a name, Amazon Aurora will not create a database in the global database cluster you are creating. </p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p> The storage encryption setting for the new global database cluster. </p>"]}
    let make ?global_cluster_identifier  ?source_d_b_cluster_identifier 
      ?engine  ?engine_version  ?deletion_protection  ?database_name 
      ?storage_encrypted  () =
      {
        global_cluster_identifier;
        source_d_b_cluster_identifier;
        engine;
        engine_version;
        deletion_protection;
        database_name;
        storage_encrypted
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.storage_encrypted
              (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.database_name
             (fun f -> ("database_name", (String.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.source_d_b_cluster_identifier
             (fun f -> ("source_d_b_cluster_identifier", (String.to_json f)));
           Util.option_map v.global_cluster_identifier
             (fun f -> ("global_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster_identifier =
            (Util.option_bind (Xml.member "GlobalClusterIdentifier" xml)
               String.parse);
          source_d_b_cluster_identifier =
            (Util.option_bind (Xml.member "SourceDBClusterIdentifier" xml)
               String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          database_name =
            (Util.option_bind (Xml.member "DatabaseName" xml) String.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.global_cluster_identifier
                    (fun f ->
                       Ezxmlm.make_tag "GlobalClusterIdentifier"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.source_d_b_cluster_identifier
                   (fun f ->
                      Ezxmlm.make_tag "SourceDBClusterIdentifier"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.engine
                  (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
              @
              [Util.option_map v.engine_version
                 (fun f ->
                    Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
             @
             [Util.option_map v.deletion_protection
                (fun f ->
                   Ezxmlm.make_tag "DeletionProtection"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.database_name
               (fun f ->
                  Ezxmlm.make_tag "DatabaseName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.storage_encrypted
              (fun f ->
                 Ezxmlm.make_tag "StorageEncrypted" ([], (Boolean.to_xml f)))])
  end
module CreateGlobalClusterResult = CreateGlobalClusterResult
type input = CreateGlobalClusterMessage.t
type output = CreateGlobalClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateGlobalCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateGlobalClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateGlobalClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateGlobalClusterResponse" (snd xml))
        (Xml.member "CreateGlobalClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateGlobalClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateGlobalClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateGlobalClusterResult - missing field in body or children: "
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