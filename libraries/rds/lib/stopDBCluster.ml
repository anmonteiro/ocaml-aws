open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StopDBClusterMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The DB cluster identifier of the Amazon Aurora DB cluster to be stopped. This parameter is stored as a lowercase string.</p>"]}
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
  end
module StopDBClusterResult = StopDBClusterResult
type input = StopDBClusterMessage.t
type output = StopDBClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["StopDBCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StopDBClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (StopDBClusterMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "StopDBClusterResponse" (snd xml))
        (Xml.member "StopDBClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp StopDBClusterResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed StopDBClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StopDBClusterResult - missing field in body or children: "
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