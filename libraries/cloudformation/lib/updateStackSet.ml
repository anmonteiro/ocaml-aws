open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateStackSetInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name or unique ID of the stack set that you want to update.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A brief description of updates that you are making.</p>"];
      template_body: String.t option
        [@ocaml.doc
          "<p>The structure that contains the template body, with a minimum length of 1 byte and a maximum length of 51,200 bytes. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must specify only one of the following parameters: <code>TemplateBody</code> or <code>TemplateURL</code>\226\128\148or set <code>UsePreviousTemplate</code> to true.</p>"];
      template_u_r_l: String.t option
        [@ocaml.doc
          "<p>The location of the file that contains the template body. The URL must point to a template (maximum size: 460,800 bytes) that is located in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must specify only one of the following parameters: <code>TemplateBody</code> or <code>TemplateURL</code>\226\128\148or set <code>UsePreviousTemplate</code> to true. </p>"];
      use_previous_template: Boolean.t option
        [@ocaml.doc
          "<p>Use the existing template that's associated with the stack set that you're updating.</p> <p>Conditional: You must specify only one of the following parameters: <code>TemplateBody</code> or <code>TemplateURL</code>\226\128\148or set <code>UsePreviousTemplate</code> to true. </p>"];
      parameters: Parameters.t
        [@ocaml.doc
          "<p>A list of input parameters for the stack set template. </p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>In some cases, you must explicitly acknowledge that your stack template contains certain capabilities in order for AWS CloudFormation to update the stack set and its associated stack instances.</p> <ul> <li> <p> <code>CAPABILITY_IAM</code> and <code>CAPABILITY_NAMED_IAM</code> </p> <p>Some stack templates might include resources that can affect permissions in your AWS account; for example, by creating new AWS Identity and Access Management (IAM) users. For those stacks sets, you must explicitly acknowledge this by specifying one of these capabilities.</p> <p>The following IAM resources require you to specify either the <code>CAPABILITY_IAM</code> or <code>CAPABILITY_NAMED_IAM</code> capability.</p> <ul> <li> <p>If you have IAM resources, you can specify either capability. </p> </li> <li> <p>If you have IAM resources with custom names, you <i>must</i> specify <code>CAPABILITY_NAMED_IAM</code>. </p> </li> <li> <p>If you don't specify either of these capabilities, AWS CloudFormation returns an <code>InsufficientCapabilities</code> error.</p> </li> </ul> <p>If your stack template contains these resources, we recommend that you review all permissions associated with them and edit their permissions if necessary.</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html\"> AWS::IAM::AccessKey</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html\"> AWS::IAM::Group</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html\"> AWS::IAM::InstanceProfile</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-policy.html\"> AWS::IAM::Policy</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html\"> AWS::IAM::Role</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-user.html\"> AWS::IAM::User</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-addusertogroup.html\"> AWS::IAM::UserToGroupAddition</a> </p> </li> </ul> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates</a>.</p> </li> <li> <p> <code>CAPABILITY_AUTO_EXPAND</code> </p> <p>Some templates contain macros. If your stack template contains one or more macros, and you choose to update a stack directly from the processed template, without first reviewing the resulting changes in a change set, you must acknowledge this capability. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html\">Using AWS CloudFormation Macros to Perform Custom Processing on Templates</a>.</p> <important> <p>Stack sets do not currently support macros in stack templates. (This includes the <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/create-reusable-transform-function-snippets-and-add-to-your-template-with-aws-include-transform.html\">AWS::Include</a> and <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html\">AWS::Serverless</a> transforms, which are macros hosted by AWS CloudFormation.) Even if you specify this capability, if you include a macro in your template the stack set operation will fail.</p> </important> </li> </ul>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>The key-value pairs to associate with this stack set and the stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the stacks. You can specify a maximum number of 50 tags.</p> <p>If you specify tags for this parameter, those tags replace any list of tags that are currently associated with this stack set. This means:</p> <ul> <li> <p>If you don't specify this parameter, AWS CloudFormation doesn't modify the stack's tags. </p> </li> <li> <p>If you specify <i>any</i> tags using this parameter, you must specify <i>all</i> the tags that you want associated with this stack set, even tags you've specifed before (for example, when creating the stack set or during a previous update of the stack set.). Any tags that you don't include in the updated list of tags are removed from the stack set, and therefore from the stacks and resources as well. </p> </li> <li> <p>If you specify an empty value, AWS CloudFormation removes all currently associated tags.</p> </li> </ul> <p>If you specify new tags as part of an <code>UpdateStackSet</code> action, AWS CloudFormation checks to see if you have the required IAM permission to tag resources. If you omit tags that are currently associated with the stack set from the list of tags you specify, AWS CloudFormation assumes that you want to remove those tags from the stack set, and checks to see if you have permission to untag resources. If you don't have the necessary permission(s), the entire <code>UpdateStackSet</code> action fails with an <code>access denied</code> error, and the stack set is not updated.</p>"];
      operation_preferences: StackSetOperationPreferences.t option
        [@ocaml.doc
          "<p>Preferences for how AWS CloudFormation performs this stack set operation.</p>"];
      administration_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Number (ARN) of the IAM role to use to update this stack set.</p> <p>Specify an IAM role only if you are using customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html\">Granting Permissions for Stack Set Operations</a> in the <i>AWS CloudFormation User Guide</i>.</p> <p>If you specified a customized administrator role when you created the stack set, you must specify a customized administrator role, even if it is the same customized administrator role used with this stack set previously.</p>"];
      execution_role_name: String.t option
        [@ocaml.doc
          "<p>The name of the IAM execution role to use to update the stack set. If you do not specify an execution role, AWS CloudFormation uses the <code>AWSCloudFormationStackSetExecutionRole</code> role for the stack set operation.</p> <p>Specify an IAM role only if you are using customized execution roles to control which stack resources users and groups can include in their stack sets. </p> <p> If you specify a customized execution role, AWS CloudFormation uses that role to update the stack. If you do not specify a customized execution role, AWS CloudFormation performs the update using the role previously associated with the stack set, so long as you have permissions to perform operations on the stack set.</p>"];
      operation_id: String.t option
        [@ocaml.doc
          "<p>The unique ID for this stack set operation. </p> <p>The operation ID also functions as an idempotency token, to ensure that AWS CloudFormation performs the stack set operation only once, even if you retry the request multiple times. You might retry stack set operation requests to ensure that AWS CloudFormation successfully received them.</p> <p>If you don't specify an operation ID, AWS CloudFormation generates one automatically.</p> <p>Repeating this stack set operation with a new operation ID retries all stack instances whose status is <code>OUTDATED</code>. </p>"];
      accounts: AccountList.t
        [@ocaml.doc
          "<p>The accounts in which to update associated stack instances. If you specify accounts, you must also specify the regions in which to update stack set instances.</p> <p>To update <i>all</i> the stack instances associated with this stack set, do not specify the <code>Accounts</code> or <code>Regions</code> properties.</p> <p>If the stack set update includes changes to the template (that is, if the <code>TemplateBody</code> or <code>TemplateURL</code> properties are specified), or the <code>Parameters</code> property, AWS CloudFormation marks all stack instances with a status of <code>OUTDATED</code> prior to updating the stack instances in the specified accounts and regions. If the stack set update does not include changes to the template or parameters, AWS CloudFormation updates the stack instances in the specified accounts and regions, while leaving all other stack instances with their existing stack instance status. </p>"];
      regions: RegionList.t
        [@ocaml.doc
          "<p>The regions in which to update associated stack instances. If you specify regions, you must also specify accounts in which to update stack set instances.</p> <p>To update <i>all</i> the stack instances associated with this stack set, do not specify the <code>Accounts</code> or <code>Regions</code> properties.</p> <p>If the stack set update includes changes to the template (that is, if the <code>TemplateBody</code> or <code>TemplateURL</code> properties are specified), or the <code>Parameters</code> property, AWS CloudFormation marks all stack instances with a status of <code>OUTDATED</code> prior to updating the stack instances in the specified accounts and regions. If the stack set update does not include changes to the template or parameters, AWS CloudFormation updates the stack instances in the specified accounts and regions, while leaving all other stack instances with their existing stack instance status. </p>"]}
    let make ~stack_set_name  ?description  ?template_body  ?template_u_r_l 
      ?use_previous_template  ?(parameters= [])  ?(capabilities= [])  ?(tags=
      [])  ?operation_preferences  ?administration_role_a_r_n 
      ?execution_role_name  ?operation_id  ?(accounts= [])  ?(regions= []) 
      () =
      {
        stack_set_name;
        description;
        template_body;
        template_u_r_l;
        use_previous_template;
        parameters;
        capabilities;
        tags;
        operation_preferences;
        administration_role_a_r_n;
        execution_role_name;
        operation_id;
        accounts;
        regions
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("regions", (RegionList.to_json v.regions));
           Some ("accounts", (AccountList.to_json v.accounts));
           Util.option_map v.operation_id
             (fun f -> ("operation_id", (String.to_json f)));
           Util.option_map v.execution_role_name
             (fun f -> ("execution_role_name", (String.to_json f)));
           Util.option_map v.administration_role_a_r_n
             (fun f -> ("administration_role_a_r_n", (String.to_json f)));
           Util.option_map v.operation_preferences
             (fun f ->
                ("operation_preferences",
                  (StackSetOperationPreferences.to_json f)));
           Some ("tags", (Tags.to_json v.tags));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Some ("parameters", (Parameters.to_json v.parameters));
           Util.option_map v.use_previous_template
             (fun f -> ("use_previous_template", (Boolean.to_json f)));
           Util.option_map v.template_u_r_l
             (fun f -> ("template_u_r_l", (String.to_json f)));
           Util.option_map v.template_body
             (fun f -> ("template_body", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("stack_set_name", (String.to_json v.stack_set_name))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Xml.required "StackSetName"
               (Util.option_bind (Xml.member "StackSetName" xml) String.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          template_body =
            (Util.option_bind (Xml.member "TemplateBody" xml) String.parse);
          template_u_r_l =
            (Util.option_bind (Xml.member "TemplateURL" xml) String.parse);
          use_previous_template =
            (Util.option_bind (Xml.member "UsePreviousTemplate" xml)
               Boolean.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  Parameters.parse));
          capabilities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Capabilities" xml)
                  Capabilities.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          operation_preferences =
            (Util.option_bind (Xml.member "OperationPreferences" xml)
               StackSetOperationPreferences.parse);
          administration_role_a_r_n =
            (Util.option_bind (Xml.member "AdministrationRoleARN" xml)
               String.parse);
          execution_role_name =
            (Util.option_bind (Xml.member "ExecutionRoleName" xml)
               String.parse);
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse);
          accounts =
            (Util.of_option []
               (Util.option_bind (Xml.member "Accounts" xml)
                  AccountList.parse));
          regions =
            (Util.of_option []
               (Util.option_bind (Xml.member "Regions" xml) RegionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((([] @
                        [Some
                           (Ezxmlm.make_tag "StackSetName"
                              ([], (String.to_xml v.stack_set_name)))])
                       @
                       [Util.option_map v.description
                          (fun f ->
                             Ezxmlm.make_tag "Description"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.template_body
                         (fun f ->
                            Ezxmlm.make_tag "TemplateBody"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.template_u_r_l
                        (fun f ->
                           Ezxmlm.make_tag "TemplateURL"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.use_previous_template
                       (fun f ->
                          Ezxmlm.make_tag "UsePreviousTemplate"
                            ([], (Boolean.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "Parameters"
                              ([], (Parameters.to_xml [x])))) v.parameters))
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "Capabilities"
                             ([], (Capabilities.to_xml [x])))) v.capabilities))
                 @
                 (List.map
                    (fun x ->
                       Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
                    v.tags))
                @
                [Util.option_map v.operation_preferences
                   (fun f ->
                      Ezxmlm.make_tag "OperationPreferences"
                        ([], (StackSetOperationPreferences.to_xml f)))])
               @
               [Util.option_map v.administration_role_a_r_n
                  (fun f ->
                     Ezxmlm.make_tag "AdministrationRoleARN"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.execution_role_name
                 (fun f ->
                    Ezxmlm.make_tag "ExecutionRoleName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.operation_id
                (fun f ->
                   Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Accounts"
                       ([], (AccountList.to_xml [x])))) v.accounts))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Regions" ([], (RegionList.to_xml [x]))))
              v.regions))
  end
module UpdateStackSetOutput = UpdateStackSetOutput
type input = UpdateStackSetInput.t
type output = UpdateStackSetOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["UpdateStackSet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UpdateStackSetInput.to_query req))))) in
  (`POST, uri, (Headers.render (UpdateStackSetInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "UpdateStackSetResponse" (snd xml))
        (Xml.member "UpdateStackSetResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp UpdateStackSetOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed UpdateStackSetOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateStackSetOutput - missing field in body or children: "
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