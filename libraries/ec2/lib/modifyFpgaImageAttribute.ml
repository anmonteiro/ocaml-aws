open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyFpgaImageAttributeRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      fpga_image_id: String.t [@ocaml.doc "<p>The ID of the AFI.</p>"];
      attribute: FpgaImageAttributeName.t option
        [@ocaml.doc "<p>The name of the attribute.</p>"];
      operation_type: OperationType.t option
        [@ocaml.doc "<p>The operation type.</p>"];
      user_ids: UserIdStringList.t
        [@ocaml.doc
          "<p>The AWS account IDs. This parameter is valid only when modifying the <code>loadPermission</code> attribute.</p>"];
      user_groups: UserGroupStringList.t
        [@ocaml.doc
          "<p>The user groups. This parameter is valid only when modifying the <code>loadPermission</code> attribute.</p>"];
      product_codes: ProductCodeStringList.t
        [@ocaml.doc
          "<p>The product codes. After you add a product code to an AFI, it can't be removed. This parameter is valid only when modifying the <code>productCodes</code> attribute.</p>"];
      load_permission: LoadPermissionModifications.t option
        [@ocaml.doc "<p>The load permission for the AFI.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description for the AFI.</p>"];
      name: String.t option [@ocaml.doc "<p>A name for the AFI.</p>"]}
    let make ?dry_run  ~fpga_image_id  ?attribute  ?operation_type 
      ?(user_ids= [])  ?(user_groups= [])  ?(product_codes= []) 
      ?load_permission  ?description  ?name  () =
      {
        dry_run;
        fpga_image_id;
        attribute;
        operation_type;
        user_ids;
        user_groups;
        product_codes;
        load_permission;
        description;
        name
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.name
              (fun f -> Query.Pair ("Name", (String.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.load_permission
             (fun f ->
                Query.Pair
                  ("LoadPermission",
                    (LoadPermissionModifications.to_query f)));
           Some
             (Query.Pair
                ("ProductCode",
                  (ProductCodeStringList.to_query v.product_codes)));
           Some
             (Query.Pair
                ("UserGroup", (UserGroupStringList.to_query v.user_groups)));
           Some
             (Query.Pair ("UserId", (UserIdStringList.to_query v.user_ids)));
           Util.option_map v.operation_type
             (fun f ->
                Query.Pair ("OperationType", (OperationType.to_query f)));
           Util.option_map v.attribute
             (fun f ->
                Query.Pair ("Attribute", (FpgaImageAttributeName.to_query f)));
           Some
             (Query.Pair ("FpgaImageId", (String.to_query v.fpga_image_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.load_permission
             (fun f ->
                ("load_permission", (LoadPermissionModifications.to_json f)));
           Some
             ("product_codes",
               (ProductCodeStringList.to_json v.product_codes));
           Some ("user_groups", (UserGroupStringList.to_json v.user_groups));
           Some ("user_ids", (UserIdStringList.to_json v.user_ids));
           Util.option_map v.operation_type
             (fun f -> ("operation_type", (OperationType.to_json f)));
           Util.option_map v.attribute
             (fun f -> ("attribute", (FpgaImageAttributeName.to_json f)));
           Some ("fpga_image_id", (String.to_json v.fpga_image_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          fpga_image_id =
            (Xml.required "FpgaImageId"
               (Util.option_bind (Xml.member "FpgaImageId" xml) String.parse));
          attribute =
            (Util.option_bind (Xml.member "Attribute" xml)
               FpgaImageAttributeName.parse);
          operation_type =
            (Util.option_bind (Xml.member "OperationType" xml)
               OperationType.parse);
          user_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserId" xml)
                  UserIdStringList.parse));
          user_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserGroup" xml)
                  UserGroupStringList.parse));
          product_codes =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProductCode" xml)
                  ProductCodeStringList.parse));
          load_permission =
            (Util.option_bind (Xml.member "LoadPermission" xml)
               LoadPermissionModifications.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          name = (Util.option_bind (Xml.member "Name" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.dry_run
                       (fun f ->
                          Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "FpgaImageId"
                         ([], (String.to_xml v.fpga_image_id)))])
                  @
                  [Util.option_map v.attribute
                     (fun f ->
                        Ezxmlm.make_tag "Attribute"
                          ([], (FpgaImageAttributeName.to_xml f)))])
                 @
                 [Util.option_map v.operation_type
                    (fun f ->
                       Ezxmlm.make_tag "OperationType"
                         ([], (OperationType.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "UserId"
                           ([], (UserIdStringList.to_xml [x])))) v.user_ids))
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
                      (Ezxmlm.make_tag "ProductCode"
                         ([], (ProductCodeStringList.to_xml [x]))))
                 v.product_codes))
             @
             [Util.option_map v.load_permission
                (fun f ->
                   Ezxmlm.make_tag "LoadPermission"
                     ([], (LoadPermissionModifications.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           [Util.option_map v.name
              (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
  end
module ModifyFpgaImageAttributeResult = ModifyFpgaImageAttributeResult
type input = ModifyFpgaImageAttributeRequest.t
type output = ModifyFpgaImageAttributeResult.t
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
         ("Action", ["ModifyFpgaImageAttribute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyFpgaImageAttributeRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyFpgaImageAttributeRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyFpgaImageAttributeResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyFpgaImageAttributeResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyFpgaImageAttributeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyFpgaImageAttributeResult - missing field in body or children: "
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