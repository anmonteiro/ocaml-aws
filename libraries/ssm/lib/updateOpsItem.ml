open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateOpsItemRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p>Update the information about the OpsItem. Provide enough information so that users reading this OpsItem for the first time understand the issue. </p>"];
      operational_data: OpsItemOperationalData.t option
        [@ocaml.doc
          "<p>Add new keys or edit existing key-value pairs of the OperationalData map in the OpsItem object.</p> <p>Operational data is custom data that provides useful reference details about the OpsItem. For example, you can specify log files, error strings, license keys, troubleshooting tips, or other relevant data. You enter operational data as key-value pairs. The key has a maximum length of 128 characters. The value has a maximum size of 20 KB.</p> <important> <p>Operational data keys <i>can't</i> begin with the following: amazon, aws, amzn, ssm, /amazon, /aws, /amzn, /ssm.</p> </important> <p>You can choose to make the data searchable by other users in the account or you can restrict search access. Searchable data means that all users with access to the OpsItem Overview page (as provided by the <a>DescribeOpsItems</a> API action) can view and search on the specified data. Operational data that is not searchable is only viewable by users who have access to the OpsItem (as provided by the <a>GetOpsItem</a> API action).</p> <p>Use the <code>/aws/resources</code> key in OperationalData to specify a related resource in the request. Use the <code>/aws/automations</code> key in OperationalData to associate an Automation runbook with the OpsItem. To view AWS CLI example commands that use these keys, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-creating-OpsItems.html#OpsCenter-manually-create-OpsItems\">Creating OpsItems Manually</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      operational_data_to_delete: OpsItemOpsDataKeysList.t
        [@ocaml.doc
          "<p>Keys that you want to remove from the OperationalData map.</p>"];
      notifications: OpsItemNotifications.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an SNS topic where notifications are sent when this OpsItem is edited or changed.</p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The importance of this OpsItem in relation to other OpsItems in the system.</p>"];
      related_ops_items: RelatedOpsItems.t
        [@ocaml.doc
          "<p>One or more OpsItems that share something in common with the current OpsItems. For example, related OpsItems can include OpsItems with similar error messages, impacted resources, or statuses for the impacted resource.</p>"];
      status: OpsItemStatus.t option
        [@ocaml.doc
          "<p>The OpsItem status. Status can be <code>Open</code>, <code>In Progress</code>, or <code>Resolved</code>. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-working-with-OpsItems-editing-details.html\">Editing OpsItem Details</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      ops_item_id: String.t [@ocaml.doc "<p>The ID of the OpsItem.</p>"];
      title: String.t option
        [@ocaml.doc
          "<p>A short heading that describes the nature of the OpsItem and the impacted resource.</p>"];
      category: String.t option
        [@ocaml.doc "<p>Specify a new category for an OpsItem.</p>"];
      severity: String.t option
        [@ocaml.doc "<p>Specify a new severity for an OpsItem.</p>"]}
    let make ?description  ?operational_data  ?(operational_data_to_delete=
      [])  ?(notifications= [])  ?priority  ?(related_ops_items= [])  ?status
       ~ops_item_id  ?title  ?category  ?severity  () =
      {
        description;
        operational_data;
        operational_data_to_delete;
        notifications;
        priority;
        related_ops_items;
        status;
        ops_item_id;
        title;
        category;
        severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.severity
              (fun f -> ("severity", (String.to_json f)));
           Util.option_map v.category
             (fun f -> ("category", (String.to_json f)));
           Util.option_map v.title (fun f -> ("title", (String.to_json f)));
           Some ("ops_item_id", (String.to_json v.ops_item_id));
           Util.option_map v.status
             (fun f -> ("status", (OpsItemStatus.to_json f)));
           Some
             ("related_ops_items",
               (RelatedOpsItems.to_json v.related_ops_items));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Some
             ("notifications",
               (OpsItemNotifications.to_json v.notifications));
           Some
             ("operational_data_to_delete",
               (OpsItemOpsDataKeysList.to_json v.operational_data_to_delete));
           Util.option_map v.operational_data
             (fun f ->
                ("operational_data", (OpsItemOperationalData.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let of_json j =
      {
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        operational_data =
          (Util.option_map (Json.lookup j "operational_data")
             OpsItemOperationalData.of_json);
        operational_data_to_delete =
          (OpsItemOpsDataKeysList.of_json
             (Util.of_option_exn (Json.lookup j "operational_data_to_delete")));
        notifications =
          (OpsItemNotifications.of_json
             (Util.of_option_exn (Json.lookup j "notifications")));
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        related_ops_items =
          (RelatedOpsItems.of_json
             (Util.of_option_exn (Json.lookup j "related_ops_items")));
        status =
          (Util.option_map (Json.lookup j "status") OpsItemStatus.of_json);
        ops_item_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "ops_item_id")));
        title = (Util.option_map (Json.lookup j "title") String.of_json);
        category =
          (Util.option_map (Json.lookup j "category") String.of_json);
        severity =
          (Util.option_map (Json.lookup j "severity") String.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = UpdateOpsItemRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (UpdateOpsItemRequest.to_query req)))) in
  (`POST, uri, (Headers.render (UpdateOpsItemRequest.to_headers req)), "")
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