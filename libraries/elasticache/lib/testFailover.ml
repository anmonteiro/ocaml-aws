open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module TestFailoverMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The name of the replication group (console: cluster) whose automatic failover is being tested by this operation.</p>"];
      node_group_id: String.t
        [@ocaml.doc
          "<p>The name of the node group (called shard in the console) in this replication group on which automatic failover is to be tested. You may test automatic failover on up to 5 node groups in any rolling 24-hour period.</p>"]}
    let make ~replication_group_id  ~node_group_id  () =
      { replication_group_id; node_group_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("node_group_id", (String.to_json v.node_group_id));
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
          node_group_id =
            (Xml.required "NodeGroupId"
               (Util.option_bind (Xml.member "NodeGroupId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ReplicationGroupId"
                  ([], (String.to_xml v.replication_group_id)))])
           @
           [Some
              (Ezxmlm.make_tag "NodeGroupId"
                 ([], (String.to_xml v.node_group_id)))])
  end
module TestFailoverResult = TestFailoverResult
type input = TestFailoverMessage.t
type output = TestFailoverResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["TestFailover"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (TestFailoverMessage.to_query req))))) in
  (`POST, uri, (Headers.render (TestFailoverMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "TestFailoverResponse" (snd xml))
        (Xml.member "TestFailoverResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp TestFailoverResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed TestFailoverResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing TestFailoverResult - missing field in body or children: "
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