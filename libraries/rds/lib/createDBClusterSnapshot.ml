open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBClusterSnapshotMessage =
  struct
    type t =
      {
      d_b_cluster_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the DB cluster snapshot. This parameter is stored as a lowercase string.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul> <p>Example: <code>my-cluster1-snapshot1</code> </p>"];
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the DB cluster to create a snapshot for. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBCluster.</p> </li> </ul> <p>Example: <code>my-cluster1</code> </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The tags to be assigned to the DB cluster snapshot.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_snapshot_identifier  ~d_b_cluster_identifier 
      ?(tags= [])  () =
      { d_b_cluster_snapshot_identifier; d_b_cluster_identifier; tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier));
           Some
             ("d_b_cluster_snapshot_identifier",
               (String.to_json v.d_b_cluster_snapshot_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot_identifier =
            (Xml.required "DBClusterSnapshotIdentifier"
               (Util.option_bind
                  (Xml.member "DBClusterSnapshotIdentifier" xml) String.parse));
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBClusterSnapshotIdentifier"
                   ([], (String.to_xml v.d_b_cluster_snapshot_identifier)))])
            @
            [Some
               (Ezxmlm.make_tag "DBClusterIdentifier"
                  ([], (String.to_xml v.d_b_cluster_identifier)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end[@@ocaml.doc "<p/>"]
module CreateDBClusterSnapshotResult = CreateDBClusterSnapshotResult
type input = CreateDBClusterSnapshotMessage.t
type output = CreateDBClusterSnapshotResult.t
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
         ("Action", ["CreateDBClusterSnapshot"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBClusterSnapshotMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateDBClusterSnapshotMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "CreateDBClusterSnapshotResponse" (snd xml))
        (Xml.member "CreateDBClusterSnapshotResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateDBClusterSnapshotResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateDBClusterSnapshotResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBClusterSnapshotResult - missing field in body or children: "
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