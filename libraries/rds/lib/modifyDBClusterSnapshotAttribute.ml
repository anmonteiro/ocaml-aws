open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBClusterSnapshotAttributeMessage =
  struct
    type t =
      {
      d_b_cluster_snapshot_identifier: String.t
        [@ocaml.doc
          "<p>The identifier for the DB cluster snapshot to modify the attributes for.</p>"];
      attribute_name: String.t
        [@ocaml.doc
          "<p>The name of the DB cluster snapshot attribute to modify.</p> <p>To manage authorization for other AWS accounts to copy or restore a manual DB cluster snapshot, set this value to <code>restore</code>.</p>"];
      values_to_add: AttributeValueList.t
        [@ocaml.doc
          "<p>A list of DB cluster snapshot attributes to add to the attribute specified by <code>AttributeName</code>.</p> <p>To authorize other AWS accounts to copy or restore a manual DB cluster snapshot, set this list to include one or more AWS account IDs, or <code>all</code> to make the manual DB cluster snapshot restorable by any AWS account. Do not add the <code>all</code> value for any manual DB cluster snapshots that contain private information that you don't want available to all AWS accounts.</p>"];
      values_to_remove: AttributeValueList.t
        [@ocaml.doc
          "<p>A list of DB cluster snapshot attributes to remove from the attribute specified by <code>AttributeName</code>.</p> <p>To remove authorization for other AWS accounts to copy or restore a manual DB cluster snapshot, set this list to include one or more AWS account identifiers, or <code>all</code> to remove authorization for any AWS account to copy or restore the DB cluster snapshot. If you specify <code>all</code>, an AWS account whose account ID is explicitly added to the <code>restore</code> attribute can still copy or restore a manual DB cluster snapshot.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_snapshot_identifier  ~attribute_name 
      ?(values_to_add= [])  ?(values_to_remove= [])  () =
      {
        d_b_cluster_snapshot_identifier;
        attribute_name;
        values_to_add;
        values_to_remove
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("values_to_remove",
                (AttributeValueList.to_json v.values_to_remove));
           Some
             ("values_to_add", (AttributeValueList.to_json v.values_to_add));
           Some ("attribute_name", (String.to_json v.attribute_name));
           Some
             ("d_b_cluster_snapshot_identifier",
               (String.to_json v.d_b_cluster_snapshot_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot_identifier =
            (Xml.required "DBClusterSnapshotIdentifier"
               (Util.option_bind
                  (Xml.member "DBClusterSnapshotIdentifier" xml) String.parse));
          attribute_name =
            (Xml.required "AttributeName"
               (Util.option_bind (Xml.member "AttributeName" xml)
                  String.parse));
          values_to_add =
            (Util.of_option []
               (Util.option_bind (Xml.member "ValuesToAdd" xml)
                  AttributeValueList.parse));
          values_to_remove =
            (Util.of_option []
               (Util.option_bind (Xml.member "ValuesToRemove" xml)
                  AttributeValueList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "DBClusterSnapshotIdentifier"
                    ([], (String.to_xml v.d_b_cluster_snapshot_identifier)))])
             @
             [Some
                (Ezxmlm.make_tag "AttributeName"
                   ([], (String.to_xml v.attribute_name)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ValuesToAdd"
                       ([], (AttributeValueList.to_xml [x]))))
               v.values_to_add))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ValuesToRemove"
                      ([], (AttributeValueList.to_xml [x]))))
              v.values_to_remove))
  end[@@ocaml.doc "<p/>"]
module ModifyDBClusterSnapshotAttributeResult =
  ModifyDBClusterSnapshotAttributeResult
type input = ModifyDBClusterSnapshotAttributeMessage.t
type output = ModifyDBClusterSnapshotAttributeResult.t
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
         ("Action", ["ModifyDBClusterSnapshotAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyDBClusterSnapshotAttributeMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyDBClusterSnapshotAttributeMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyDBClusterSnapshotAttributeResponse" (snd xml))
        (Xml.member "ModifyDBClusterSnapshotAttributeResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyDBClusterSnapshotAttributeResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyDBClusterSnapshotAttributeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBClusterSnapshotAttributeResult - missing field in body or children: "
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