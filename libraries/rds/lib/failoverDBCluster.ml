open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module FailoverDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>A DB cluster identifier to force a failover for. This parameter isn't case-sensitive.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBCluster.</p> </li> </ul>"];
      target_d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>The name of the instance to promote to the primary instance.</p> <p>You must specify the instance identifier for an Aurora Replica in the DB cluster. For example, <code>mydbcluster-replica1</code>.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_identifier  ?target_d_b_instance_identifier  () =
      { d_b_cluster_identifier; target_d_b_instance_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.target_d_b_instance_identifier
              (fun f ->
                 ("target_d_b_instance_identifier", (String.to_json f)));
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
          target_d_b_instance_identifier =
            (Util.option_bind (Xml.member "TargetDBInstanceIdentifier" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DBClusterIdentifier"
                  ([], (String.to_xml v.d_b_cluster_identifier)))])
           @
           [Util.option_map v.target_d_b_instance_identifier
              (fun f ->
                 Ezxmlm.make_tag "TargetDBInstanceIdentifier"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module FailoverDBClusterResult = FailoverDBClusterResult
type input = FailoverDBClusterMessage.t
type output = FailoverDBClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["FailoverDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (FailoverDBClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (FailoverDBClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "FailoverDBClusterResponse" (snd xml))
        (Xml.member "FailoverDBClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp FailoverDBClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed FailoverDBClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing FailoverDBClusterResult - missing field in body or children: "
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