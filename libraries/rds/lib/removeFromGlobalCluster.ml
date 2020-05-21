open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RemoveFromGlobalClusterMessage =
  struct
    type t =
      {
      global_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> The cluster identifier to detach from the Aurora global database cluster. </p>"];
      db_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> The Amazon Resource Name (ARN) identifying the cluster that was detached from the Aurora global database cluster. </p>"]}
    let make ?global_cluster_identifier  ?db_cluster_identifier  () =
      { global_cluster_identifier; db_cluster_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.db_cluster_identifier
              (fun f -> ("db_cluster_identifier", (String.to_json f)));
           Util.option_map v.global_cluster_identifier
             (fun f -> ("global_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster_identifier =
            (Util.option_bind (Xml.member "GlobalClusterIdentifier" xml)
               String.parse);
          db_cluster_identifier =
            (Util.option_bind (Xml.member "DbClusterIdentifier" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.global_cluster_identifier
               (fun f ->
                  Ezxmlm.make_tag "GlobalClusterIdentifier"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.db_cluster_identifier
              (fun f ->
                 Ezxmlm.make_tag "DbClusterIdentifier"
                   ([], (String.to_xml f)))])
  end
module RemoveFromGlobalClusterResult = RemoveFromGlobalClusterResult
type input = RemoveFromGlobalClusterMessage.t
type output = RemoveFromGlobalClusterResult.t
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
         ("Action", ["RemoveFromGlobalCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RemoveFromGlobalClusterMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RemoveFromGlobalClusterMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RemoveFromGlobalClusterResponse" (snd xml))
        (Xml.member "RemoveFromGlobalClusterResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RemoveFromGlobalClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RemoveFromGlobalClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RemoveFromGlobalClusterResult - missing field in body or children: "
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