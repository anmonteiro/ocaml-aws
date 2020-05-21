open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteGlobalClusterMessage =
  struct
    type t =
      {
      global_cluster_identifier: String.t
        [@ocaml.doc
          "<p> The cluster identifier of the global database cluster being deleted. </p>"]}
    let make ~global_cluster_identifier  () = { global_cluster_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("global_cluster_identifier",
                (String.to_json v.global_cluster_identifier))])
    let parse xml =
      Some
        {
          global_cluster_identifier =
            (Xml.required "GlobalClusterIdentifier"
               (Util.option_bind (Xml.member "GlobalClusterIdentifier" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "GlobalClusterIdentifier"
                 ([], (String.to_xml v.global_cluster_identifier)))])
  end
module DeleteGlobalClusterResult = DeleteGlobalClusterResult
type input = DeleteGlobalClusterMessage.t
type output = DeleteGlobalClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DeleteGlobalCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteGlobalClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteGlobalClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteGlobalClusterResponse" (snd xml))
        (Xml.member "DeleteGlobalClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteGlobalClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteGlobalClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteGlobalClusterResult - missing field in body or children: "
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