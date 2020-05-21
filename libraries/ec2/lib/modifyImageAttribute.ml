open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyImageAttributeRequest =
  struct
    type t =
      {
      attribute: String.t option
        [@ocaml.doc
          "<p>The name of the attribute to modify. The valid values are <code>description</code>, <code>launchPermission</code>, and <code>productCodes</code>.</p>"];
      description: AttributeValue.t option
        [@ocaml.doc "<p>A new description for the AMI.</p>"];
      image_id: String.t [@ocaml.doc "<p>The ID of the AMI.</p>"];
      launch_permission: LaunchPermissionModifications.t option
        [@ocaml.doc "<p>A new launch permission for the AMI.</p>"];
      operation_type: OperationType.t option
        [@ocaml.doc
          "<p>The operation type. This parameter can be used only when the <code>Attribute</code> parameter is <code>launchPermission</code>.</p>"];
      product_codes: ProductCodeStringList.t
        [@ocaml.doc
          "<p>The DevPay product codes. After you add a product code to an AMI, it can't be removed.</p>"];
      user_groups: UserGroupStringList.t
        [@ocaml.doc
          "<p>The user groups. This parameter can be used only when the <code>Attribute</code> parameter is <code>launchPermission</code>.</p>"];
      user_ids: UserIdStringList.t
        [@ocaml.doc
          "<p>The AWS account IDs. This parameter can be used only when the <code>Attribute</code> parameter is <code>launchPermission</code>.</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>The value of the attribute being modified. This parameter can be used only when the <code>Attribute</code> parameter is <code>description</code> or <code>productCodes</code>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for ModifyImageAttribute.</p>"]
    let make ?attribute  ?description  ~image_id  ?launch_permission 
      ?operation_type  ?(product_codes= [])  ?(user_groups= [])  ?(user_ids=
      [])  ?value  ?dry_run  () =
      {
        attribute;
        description;
        image_id;
        launch_permission;
        operation_type;
        product_codes;
        user_groups;
        user_ids;
        value;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.value
             (fun f -> Query.Pair ("Value", (String.to_query f)));
           Some
             (Query.Pair ("UserId", (UserIdStringList.to_query v.user_ids)));
           Some
             (Query.Pair
                ("UserGroup", (UserGroupStringList.to_query v.user_groups)));
           Some
             (Query.Pair
                ("ProductCode",
                  (ProductCodeStringList.to_query v.product_codes)));
           Util.option_map v.operation_type
             (fun f ->
                Query.Pair ("OperationType", (OperationType.to_query f)));
           Util.option_map v.launch_permission
             (fun f ->
                Query.Pair
                  ("LaunchPermission",
                    (LaunchPermissionModifications.to_query f)));
           Some (Query.Pair ("ImageId", (String.to_query v.image_id)));
           Util.option_map v.description
             (fun f ->
                Query.Pair ("Description", (AttributeValue.to_query f)));
           Util.option_map v.attribute
             (fun f -> Query.Pair ("Attribute", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Some ("user_ids", (UserIdStringList.to_json v.user_ids));
           Some ("user_groups", (UserGroupStringList.to_json v.user_groups));
           Some
             ("product_codes",
               (ProductCodeStringList.to_json v.product_codes));
           Util.option_map v.operation_type
             (fun f -> ("operation_type", (OperationType.to_json f)));
           Util.option_map v.launch_permission
             (fun f ->
                ("launch_permission",
                  (LaunchPermissionModifications.to_json f)));
           Some ("image_id", (String.to_json v.image_id));
           Util.option_map v.description
             (fun f -> ("description", (AttributeValue.to_json f)));
           Util.option_map v.attribute
             (fun f -> ("attribute", (String.to_json f)))])
    let parse xml =
      Some
        {
          attribute =
            (Util.option_bind (Xml.member "Attribute" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml)
               AttributeValue.parse);
          image_id =
            (Xml.required "ImageId"
               (Util.option_bind (Xml.member "ImageId" xml) String.parse));
          launch_permission =
            (Util.option_bind (Xml.member "LaunchPermission" xml)
               LaunchPermissionModifications.parse);
          operation_type =
            (Util.option_bind (Xml.member "OperationType" xml)
               OperationType.parse);
          product_codes =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProductCode" xml)
                  ProductCodeStringList.parse));
          user_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserGroup" xml)
                  UserGroupStringList.parse));
          user_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserId" xml)
                  UserIdStringList.parse));
          value = (Util.option_bind (Xml.member "Value" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.attribute
                       (fun f ->
                          Ezxmlm.make_tag "Attribute" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.description
                      (fun f ->
                         Ezxmlm.make_tag "Description"
                           ([], (AttributeValue.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "ImageId"
                        ([], (String.to_xml v.image_id)))])
                 @
                 [Util.option_map v.launch_permission
                    (fun f ->
                       Ezxmlm.make_tag "LaunchPermission"
                         ([], (LaunchPermissionModifications.to_xml f)))])
                @
                [Util.option_map v.operation_type
                   (fun f ->
                      Ezxmlm.make_tag "OperationType"
                        ([], (OperationType.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ProductCode"
                          ([], (ProductCodeStringList.to_xml [x]))))
                  v.product_codes))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "UserGroup"
                         ([], (UserGroupStringList.to_xml [x]))))
                 v.user_groups))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "UserId"
                        ([], (UserIdStringList.to_xml [x])))) v.user_ids))
            @
            [Util.option_map v.value
               (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for ModifyImageAttribute.</p>"]
module Output = Aws.BaseTypes.Unit
type input = ModifyImageAttributeRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["ModifyImageAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyImageAttributeRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyImageAttributeRequest.to_headers req)),
    "")
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