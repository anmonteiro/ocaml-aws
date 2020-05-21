open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifySnapshotAttributeRequest =
  struct
    type t =
      {
      attribute: SnapshotAttributeName.t option
        [@ocaml.doc
          "<p>The snapshot attribute to modify. Only volume creation permissions can be modified.</p>"];
      create_volume_permission: CreateVolumePermissionModifications.t option
        [@ocaml.doc
          "<p>A JSON representation of the snapshot attribute modification.</p>"];
      group_names: GroupNameStringList.t
        [@ocaml.doc "<p>The group to modify for the snapshot.</p>"];
      operation_type: OperationType.t option
        [@ocaml.doc
          "<p>The type of operation to perform to the attribute.</p>"];
      snapshot_id: String.t [@ocaml.doc "<p>The ID of the snapshot.</p>"];
      user_ids: UserIdStringList.t
        [@ocaml.doc "<p>The account ID to modify for the snapshot.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?attribute  ?create_volume_permission  ?(group_names= []) 
      ?operation_type  ~snapshot_id  ?(user_ids= [])  ?dry_run  () =
      {
        attribute;
        create_volume_permission;
        group_names;
        operation_type;
        snapshot_id;
        user_ids;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair ("UserId", (UserIdStringList.to_query v.user_ids)));
           Some (Query.Pair ("SnapshotId", (String.to_query v.snapshot_id)));
           Util.option_map v.operation_type
             (fun f ->
                Query.Pair ("OperationType", (OperationType.to_query f)));
           Some
             (Query.Pair
                ("UserGroup", (GroupNameStringList.to_query v.group_names)));
           Util.option_map v.create_volume_permission
             (fun f ->
                Query.Pair
                  ("CreateVolumePermission",
                    (CreateVolumePermissionModifications.to_query f)));
           Util.option_map v.attribute
             (fun f ->
                Query.Pair ("Attribute", (SnapshotAttributeName.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("user_ids", (UserIdStringList.to_json v.user_ids));
           Some ("snapshot_id", (String.to_json v.snapshot_id));
           Util.option_map v.operation_type
             (fun f -> ("operation_type", (OperationType.to_json f)));
           Some ("group_names", (GroupNameStringList.to_json v.group_names));
           Util.option_map v.create_volume_permission
             (fun f ->
                ("create_volume_permission",
                  (CreateVolumePermissionModifications.to_json f)));
           Util.option_map v.attribute
             (fun f -> ("attribute", (SnapshotAttributeName.to_json f)))])
    let parse xml =
      Some
        {
          attribute =
            (Util.option_bind (Xml.member "Attribute" xml)
               SnapshotAttributeName.parse);
          create_volume_permission =
            (Util.option_bind (Xml.member "CreateVolumePermission" xml)
               CreateVolumePermissionModifications.parse);
          group_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserGroup" xml)
                  GroupNameStringList.parse));
          operation_type =
            (Util.option_bind (Xml.member "OperationType" xml)
               OperationType.parse);
          snapshot_id =
            (Xml.required "SnapshotId"
               (Util.option_bind (Xml.member "SnapshotId" xml) String.parse));
          user_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserId" xml)
                  UserIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.attribute
                    (fun f ->
                       Ezxmlm.make_tag "Attribute"
                         ([], (SnapshotAttributeName.to_xml f)))])
                @
                [Util.option_map v.create_volume_permission
                   (fun f ->
                      Ezxmlm.make_tag "CreateVolumePermission"
                        ([], (CreateVolumePermissionModifications.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "UserGroup"
                          ([], (GroupNameStringList.to_xml [x]))))
                  v.group_names))
              @
              [Util.option_map v.operation_type
                 (fun f ->
                    Ezxmlm.make_tag "OperationType"
                      ([], (OperationType.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "SnapshotId"
                   ([], (String.to_xml v.snapshot_id)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "UserId"
                       ([], (UserIdStringList.to_xml [x])))) v.user_ids))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ModifySnapshotAttributeRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifySnapshotAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifySnapshotAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifySnapshotAttributeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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