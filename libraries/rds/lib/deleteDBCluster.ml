open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The DB cluster identifier for the DB cluster to be deleted. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must match an existing DBClusterIdentifier.</p> </li> </ul>"];
      skip_final_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to skip the creation of a final DB cluster snapshot before the DB cluster is deleted. If skip is specified, no DB cluster snapshot is created. If skip isn't specified, a DB cluster snapshot is created before the DB cluster is deleted. By default, skip isn't specified, and the DB cluster snapshot is created. By default, this parameter is disabled.</p> <note> <p>You must specify a <code>FinalDBSnapshotIdentifier</code> parameter if <code>SkipFinalSnapshot</code> is disabled.</p> </note>"];
      final_d_b_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p> The DB cluster snapshot identifier of the new DB cluster snapshot created when <code>SkipFinalSnapshot</code> is disabled. </p> <note> <p> Specifying this parameter and also skipping the creation of a final DB cluster snapshot with the <code>SkipFinalShapshot</code> parameter results in an error.</p> </note> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_identifier  ?skip_final_snapshot 
      ?final_d_b_snapshot_identifier  () =
      {
        d_b_cluster_identifier;
        skip_final_snapshot;
        final_d_b_snapshot_identifier
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.final_d_b_snapshot_identifier
              (fun f -> ("final_d_b_snapshot_identifier", (String.to_json f)));
           Util.option_map v.skip_final_snapshot
             (fun f -> ("skip_final_snapshot", (Boolean.to_json f)));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          skip_final_snapshot =
            (Util.option_bind (Xml.member "SkipFinalSnapshot" xml)
               Boolean.parse);
          final_d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "FinalDBSnapshotIdentifier" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBClusterIdentifier"
                   ([], (String.to_xml v.d_b_cluster_identifier)))])
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
  end[@@ocaml.doc "<p/>"]
module DeleteDBClusterResult = DeleteDBClusterResult
type input = DeleteDBClusterMessage.t
type output = DeleteDBClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DeleteDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteDBClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteDBClusterMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteDBClusterResponse" (snd xml))
        (Xml.member "DeleteDBClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteDBClusterResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteDBClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteDBClusterResult - missing field in body or children: "
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