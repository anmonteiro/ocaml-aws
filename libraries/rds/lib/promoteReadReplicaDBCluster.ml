open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PromoteReadReplicaDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the DB cluster Read Replica to promote. This parameter isn't case-sensitive. </p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBCluster Read Replica.</p> </li> </ul> <p>Example: <code>my-cluster-replica1</code> </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_identifier  () = { d_b_cluster_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_identifier",
                (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DBClusterIdentifier"
                 ([], (String.to_xml v.d_b_cluster_identifier)))])
  end[@@ocaml.doc "<p/>"]
module PromoteReadReplicaDBClusterResult = PromoteReadReplicaDBClusterResult
type input = PromoteReadReplicaDBClusterMessage.t
type output = PromoteReadReplicaDBClusterResult.t
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
         ("Action", ["PromoteReadReplicaDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (PromoteReadReplicaDBClusterMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (PromoteReadReplicaDBClusterMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "PromoteReadReplicaDBClusterResponse" (snd xml))
        (Xml.member "PromoteReadReplicaDBClusterResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp PromoteReadReplicaDBClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed PromoteReadReplicaDBClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing PromoteReadReplicaDBClusterResult - missing field in body or children: "
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