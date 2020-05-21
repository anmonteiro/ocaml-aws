open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module IncreaseReplicaCountMessage =
  struct
    type t =
      {
      replication_group_id: String.t
        [@ocaml.doc
          "<p>The id of the replication group to which you want to add replica nodes.</p>"];
      new_replica_count: Integer.t option
        [@ocaml.doc
          "<p>The number of read replica nodes you want at the completion of this operation. For Redis (cluster mode disabled) replication groups, this is the number of replica nodes in the replication group. For Redis (cluster mode enabled) replication groups, this is the number of replica nodes in each of the replication group's node groups.</p>"];
      replica_configuration: ReplicaConfigurationList.t
        [@ocaml.doc
          "<p>A list of <code>ConfigureShard</code> objects that can be used to configure each shard in a Redis (cluster mode enabled) replication group. The <code>ConfigureShard</code> has three members: <code>NewReplicaCount</code>, <code>NodeGroupId</code>, and <code>PreferredAvailabilityZones</code>.</p>"];
      apply_immediately: Boolean.t
        [@ocaml.doc
          "<p>If <code>True</code>, the number of replica nodes is increased immediately. <code>ApplyImmediately=False</code> is not currently supported.</p>"]}
    let make ~replication_group_id  ?new_replica_count 
      ?(replica_configuration= [])  ~apply_immediately  () =
      {
        replication_group_id;
        new_replica_count;
        replica_configuration;
        apply_immediately
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("apply_immediately", (Boolean.to_json v.apply_immediately));
           Some
             ("replica_configuration",
               (ReplicaConfigurationList.to_json v.replica_configuration));
           Util.option_map v.new_replica_count
             (fun f -> ("new_replica_count", (Integer.to_json f)));
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
          new_replica_count =
            (Util.option_bind (Xml.member "NewReplicaCount" xml)
               Integer.parse);
          replica_configuration =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReplicaConfiguration" xml)
                  ReplicaConfigurationList.parse));
          apply_immediately =
            (Xml.required "ApplyImmediately"
               (Util.option_bind (Xml.member "ApplyImmediately" xml)
                  Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "ReplicationGroupId"
                    ([], (String.to_xml v.replication_group_id)))])
             @
             [Util.option_map v.new_replica_count
                (fun f ->
                   Ezxmlm.make_tag "NewReplicaCount" ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ReplicaConfiguration"
                       ([], (ReplicaConfigurationList.to_xml [x]))))
               v.replica_configuration))
           @
           [Some
              (Ezxmlm.make_tag "ApplyImmediately"
                 ([], (Boolean.to_xml v.apply_immediately)))])
  end
module IncreaseReplicaCountResult = IncreaseReplicaCountResult
type input = IncreaseReplicaCountMessage.t
type output = IncreaseReplicaCountResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["IncreaseReplicaCount"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (IncreaseReplicaCountMessage.to_query req))))) in
  (`POST, uri, (Headers.render (IncreaseReplicaCountMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "IncreaseReplicaCountResponse" (snd xml))
        (Xml.member "IncreaseReplicaCountResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp IncreaseReplicaCountResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed IncreaseReplicaCountResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing IncreaseReplicaCountResult - missing field in body or children: "
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