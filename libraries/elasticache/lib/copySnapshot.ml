open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CopySnapshotMessage =
  struct
    type t =
      {
      source_snapshot_name: String.t
        [@ocaml.doc
          "<p>The name of an existing snapshot from which to make a copy.</p>"];
      target_snapshot_name: String.t
        [@ocaml.doc
          "<p>A name for the snapshot copy. ElastiCache does not permit overwriting a snapshot, therefore this name must be unique within its context - ElastiCache or an Amazon S3 bucket if exporting.</p>"];
      target_bucket: String.t option
        [@ocaml.doc
          "<p>The Amazon S3 bucket to which the snapshot is exported. This parameter is used only when exporting a snapshot for external access.</p> <p>When using this parameter to export a snapshot, be sure Amazon ElastiCache has the needed permissions to this S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/backups-exporting.html#backups-exporting-grant-access\">Step 2: Grant ElastiCache Access to Your Amazon S3 Bucket</a> in the <i>Amazon ElastiCache User Guide</i>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Snapshots.Exporting.html\">Exporting a Snapshot</a> in the <i>Amazon ElastiCache User Guide</i>.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the KMS key used to encrypt the target snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>CopySnapshotMessage</code> operation.</p>"]
    let make ~source_snapshot_name  ~target_snapshot_name  ?target_bucket 
      ?kms_key_id  () =
      { source_snapshot_name; target_snapshot_name; target_bucket; kms_key_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.kms_key_id
              (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.target_bucket
             (fun f -> ("target_bucket", (String.to_json f)));
           Some
             ("target_snapshot_name",
               (String.to_json v.target_snapshot_name));
           Some
             ("source_snapshot_name",
               (String.to_json v.source_snapshot_name))])
    let parse xml =
      Some
        {
          source_snapshot_name =
            (Xml.required "SourceSnapshotName"
               (Util.option_bind (Xml.member "SourceSnapshotName" xml)
                  String.parse));
          target_snapshot_name =
            (Xml.required "TargetSnapshotName"
               (Util.option_bind (Xml.member "TargetSnapshotName" xml)
                  String.parse));
          target_bucket =
            (Util.option_bind (Xml.member "TargetBucket" xml) String.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "SourceSnapshotName"
                    ([], (String.to_xml v.source_snapshot_name)))])
             @
             [Some
                (Ezxmlm.make_tag "TargetSnapshotName"
                   ([], (String.to_xml v.target_snapshot_name)))])
            @
            [Util.option_map v.target_bucket
               (fun f ->
                  Ezxmlm.make_tag "TargetBucket" ([], (String.to_xml f)))])
           @
           [Util.option_map v.kms_key_id
              (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>CopySnapshotMessage</code> operation.</p>"]
module CopySnapshotResult = CopySnapshotResult
type input = CopySnapshotMessage.t
type output = CopySnapshotResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["CopySnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CopySnapshotMessage.to_query req))))) in
  (`POST, uri, (Headers.render (CopySnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CopySnapshotResponse" (snd xml))
        (Xml.member "CopySnapshotResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CopySnapshotResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CopySnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CopySnapshotResult - missing field in body or children: "
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