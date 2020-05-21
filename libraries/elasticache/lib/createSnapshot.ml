open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateSnapshotMessage =
  struct
    type t =
      {
      replication_group_id: String.t option
        [@ocaml.doc
          "<p>The identifier of an existing replication group. The snapshot is created from this replication group.</p>"];
      cache_cluster_id: String.t option
        [@ocaml.doc
          "<p>The identifier of an existing cluster. The snapshot is created from this cluster.</p>"];
      snapshot_name: String.t
        [@ocaml.doc "<p>A name for the snapshot being created.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the KMS key used to encrypt the snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>CreateSnapshot</code> operation.</p>"]
    let make ?replication_group_id  ?cache_cluster_id  ~snapshot_name 
      ?kms_key_id  () =
      { replication_group_id; cache_cluster_id; snapshot_name; kms_key_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.kms_key_id
              (fun f -> ("kms_key_id", (String.to_json f)));
           Some ("snapshot_name", (String.to_json v.snapshot_name));
           Util.option_map v.cache_cluster_id
             (fun f -> ("cache_cluster_id", (String.to_json f)));
           Util.option_map v.replication_group_id
             (fun f -> ("replication_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Util.option_bind (Xml.member "ReplicationGroupId" xml)
               String.parse);
          cache_cluster_id =
            (Util.option_bind (Xml.member "CacheClusterId" xml) String.parse);
          snapshot_name =
            (Xml.required "SnapshotName"
               (Util.option_bind (Xml.member "SnapshotName" xml) String.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.replication_group_id
                 (fun f ->
                    Ezxmlm.make_tag "ReplicationGroupId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.cache_cluster_id
                (fun f ->
                   Ezxmlm.make_tag "CacheClusterId" ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "SnapshotName"
                  ([], (String.to_xml v.snapshot_name)))])
           @
           [Util.option_map v.kms_key_id
              (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>CreateSnapshot</code> operation.</p>"]
module CreateSnapshotResult = CreateSnapshotResult
type input = CreateSnapshotMessage.t
type output = CreateSnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["CreateSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateSnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CreateSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateSnapshotResponse" (snd xml))
        (Xml.member "CreateSnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateSnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateSnapshotResult - missing field in body or children: "
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