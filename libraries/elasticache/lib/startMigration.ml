open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StartMigrationMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The ID of the replication group to which data should be migrated.</p>"];
      customer_node_endpoint_list: CustomerNodeEndpointList.t
        [@ocaml.doc
          "<p>List of endpoints from which data should be migrated. For Redis (cluster mode disabled), list should have only one element.</p>"]}
    let make ~replication_group_id  ~customer_node_endpoint_list  () =
      { replication_group_id; customer_node_endpoint_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("customer_node_endpoint_list",
                (CustomerNodeEndpointList.to_json
                   v.customer_node_endpoint_list));
           Some
             ("replication_group_id",
               (String.to_json v.replication_group_id))])
    let parse xml =
      Some
        {
          replication_group_id =
            (Xml.required "ReplicationGroupId"
               (Util.option_bind (Xml.member "ReplicationGroupId" xml)
                  String.parse));
          customer_node_endpoint_list =
            (Xml.required "CustomerNodeEndpointList"
               (Util.option_bind (Xml.member "CustomerNodeEndpointList" xml)
                  CustomerNodeEndpointList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ReplicationGroupId"
                  ([], (String.to_xml v.replication_group_id)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CustomerNodeEndpointList"
                      ([], (CustomerNodeEndpointList.to_xml [x]))))
              v.customer_node_endpoint_list))
  end
module StartMigrationResponse = StartMigrationResponse
type input = StartMigrationMessage.t
type output = StartMigrationResponse.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["StartMigration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (StartMigrationMessage.to_query req))))) in
  (`POST, uri, (Headers.render (StartMigrationMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "StartMigrationResponse" (snd xml))
        (Xml.member "StartMigrationResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp StartMigrationResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed StartMigrationResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing StartMigrationResponse - missing field in body or children: "
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