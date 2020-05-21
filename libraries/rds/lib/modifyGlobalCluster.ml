open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyGlobalClusterMessage =
  struct
    type t =
      {
      global_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> The DB cluster identifier for the global cluster being modified. This parameter isn't case-sensitive. </p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing global database cluster.</p> </li> </ul>"];
      new_global_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> The new cluster identifier for the global database cluster when modifying a global database cluster. This value is stored as a lowercase string. </p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens</p> </li> <li> <p>The first character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <p>Example: <code>my-cluster2</code> </p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p> Indicates if the global database cluster has deletion protection enabled. The global database cluster can't be deleted when deletion protection is enabled. </p>"]}
    let make ?global_cluster_identifier  ?new_global_cluster_identifier 
      ?deletion_protection  () =
      {
        global_cluster_identifier;
        new_global_cluster_identifier;
        deletion_protection
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.deletion_protection
              (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.new_global_cluster_identifier
             (fun f -> ("new_global_cluster_identifier", (String.to_json f)));
           Util.option_map v.global_cluster_identifier
             (fun f -> ("global_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster_identifier =
            (Util.option_bind (Xml.member "GlobalClusterIdentifier" xml)
               String.parse);
          new_global_cluster_identifier =
            (Util.option_bind (Xml.member "NewGlobalClusterIdentifier" xml)
               String.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.global_cluster_identifier
                (fun f ->
                   Ezxmlm.make_tag "GlobalClusterIdentifier"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.new_global_cluster_identifier
               (fun f ->
                  Ezxmlm.make_tag "NewGlobalClusterIdentifier"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.deletion_protection
              (fun f ->
                 Ezxmlm.make_tag "DeletionProtection"
                   ([], (Boolean.to_xml f)))])
  end
module ModifyGlobalClusterResult = ModifyGlobalClusterResult
type input = ModifyGlobalClusterMessage.t
type output = ModifyGlobalClusterResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyGlobalCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyGlobalClusterMessage.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyGlobalClusterMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyGlobalClusterResponse" (snd xml))
        (Xml.member "ModifyGlobalClusterResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyGlobalClusterResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyGlobalClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyGlobalClusterResult - missing field in body or children: "
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