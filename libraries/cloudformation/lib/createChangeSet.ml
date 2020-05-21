open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateChangeSetInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name or the unique ID of the stack for which you are creating a change set. AWS CloudFormation generates the change set by comparing this stack's information with the information that you submit, such as a modified template or different parameter input values.</p>"];
      template_body: String.t option
        [@ocaml.doc
          "<p>A structure that contains the body of the revised template, with a minimum length of 1 byte and a maximum length of 51,200 bytes. AWS CloudFormation generates the change set by comparing this template with the template of the stack that you specified.</p> <p>Conditional: You must specify only <code>TemplateBody</code> or <code>TemplateURL</code>.</p>"];
      template_u_r_l: String.t option
        [@ocaml.doc
          "<p>The location of the file that contains the revised template. The URL must point to a template (max size: 460,800 bytes) that is located in an S3 bucket. AWS CloudFormation generates the change set by comparing this template with the stack that you specified.</p> <p>Conditional: You must specify only <code>TemplateBody</code> or <code>TemplateURL</code>.</p>"];
      use_previous_template: Boolean.t option
        [@ocaml.doc
          "<p>Whether to reuse the template that is associated with the stack to create the change set.</p>"];
      parameters: Parameters.t
        [@ocaml.doc
          "<p>A list of <code>Parameter</code> structures that specify input parameters for the change set. For more information, see the <a>Parameter</a> data type.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>In some cases, you must explicitly acknowledge that your stack template contains certain capabilities in order for AWS CloudFormation to create the stack.</p> <ul> <li> <p> <code>CAPABILITY_IAM</code> and <code>CAPABILITY_NAMED_IAM</code> </p> <p>Some stack templates might include resources that can affect permissions in your AWS account; for example, by creating new AWS Identity and Access Management (IAM) users. For those stacks, you must explicitly acknowledge this by specifying one of these capabilities.</p> <p>The following IAM resources require you to specify either the <code>CAPABILITY_IAM</code> or <code>CAPABILITY_NAMED_IAM</code> capability.</p> <ul> <li> <p>If you have IAM resources, you can specify either capability. </p> </li> <li> <p>If you have IAM resources with custom names, you <i>must</i> specify <code>CAPABILITY_NAMED_IAM</code>. </p> </li> <li> <p>If you don't specify either of these capabilities, AWS CloudFormation returns an <code>InsufficientCapabilities</code> error.</p> </li> </ul> <p>If your stack template contains these resources, we recommend that you review all permissions associated with them and edit their permissions if necessary.</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html\"> AWS::IAM::AccessKey</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html\"> AWS::IAM::Group</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html\"> AWS::IAM::InstanceProfile</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-policy.html\"> AWS::IAM::Policy</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html\"> AWS::IAM::Role</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-user.html\"> AWS::IAM::User</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-addusertogroup.html\"> AWS::IAM::UserToGroupAddition</a> </p> </li> </ul> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates</a>.</p> </li> <li> <p> <code>CAPABILITY_AUTO_EXPAND</code> </p> <p>Some template contain macros. Macros perform custom processing on templates; this can include simple actions like find-and-replace operations, all the way to extensive transformations of entire templates. Because of this, users typically create a change set from the processed template, so that they can review the changes resulting from the macros before actually creating the stack. If your stack template contains one or more macros, and you choose to create a stack directly from the processed template, without first reviewing the resulting changes in a change set, you must acknowledge this capability. This includes the <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/create-reusable-transform-function-snippets-and-add-to-your-template-with-aws-include-transform.html\">AWS::Include</a> and <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html\">AWS::Serverless</a> transforms, which are macros hosted by AWS CloudFormation.</p> <note> <p>This capacity does not apply to creating change sets, and specifying it when creating change sets has no effect.</p> <p>Also, change sets do not currently support nested stacks. If you want to create a stack from a stack template that contains macros <i>and</i> nested stacks, you must create or update the stack directly from the template using the <a>CreateStack</a> or <a>UpdateStack</a> action, and specifying this capability.</p> </note> <p>For more information on macros, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html\">Using AWS CloudFormation Macros to Perform Custom Processing on Templates</a>.</p> </li> </ul>"];
      resource_types: ResourceTypes.t
        [@ocaml.doc
          "<p>The template resource types that you have permissions to work with if you execute this change set, such as <code>AWS::EC2::Instance</code>, <code>AWS::EC2::*</code>, or <code>Custom::MyCustomInstance</code>.</p> <p>If the list of resource types doesn't include a resource type that you're updating, the stack update fails. By default, AWS CloudFormation grants permissions to all resource types. AWS Identity and Access Management (IAM) uses this parameter for condition keys in IAM policies for AWS CloudFormation. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html\">Controlling Access with AWS Identity and Access Management</a> in the AWS CloudFormation User Guide.</p>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that AWS CloudFormation assumes when executing the change set. AWS CloudFormation uses the role's credentials to make calls on your behalf. AWS CloudFormation uses this role for all future operations on the stack. As long as users have permission to operate on the stack, AWS CloudFormation uses this role even if the users don't have permission to pass it. Ensure that the role grants least privilege.</p> <p>If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials.</p>"];
      rollback_configuration: RollbackConfiguration.t option
        [@ocaml.doc
          "<p>The rollback triggers for AWS CloudFormation to monitor during stack creation and updating operations, and for the specified monitoring period afterwards.</p>"];
      notification_a_r_ns: NotificationARNs.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of Amazon Simple Notification Service (Amazon SNS) topics that AWS CloudFormation associates with the stack. To remove all associated notification topics, specify an empty list.</p>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>Key-value pairs to associate with this stack. AWS CloudFormation also propagates these tags to resources in the stack. You can specify a maximum of 50 tags.</p>"];
      change_set_name: String.t
        [@ocaml.doc
          "<p>The name of the change set. The name must be unique among all change sets that are associated with the specified stack.</p> <p>A change set name can contain only alphanumeric, case sensitive characters and hyphens. It must start with an alphabetic character and cannot exceed 128 characters.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>A unique identifier for this <code>CreateChangeSet</code> request. Specify this token if you plan to retry requests so that AWS CloudFormation knows that you're not attempting to create another change set with the same name. You might retry <code>CreateChangeSet</code> requests to ensure that AWS CloudFormation successfully received them.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description to help you identify this change set.</p>"];
      change_set_type: ChangeSetType.t option
        [@ocaml.doc
          "<p>The type of change set operation. To create a change set for a new stack, specify <code>CREATE</code>. To create a change set for an existing stack, specify <code>UPDATE</code>. To create a change set for an import operation, specify <code>IMPORT</code>.</p> <p>If you create a change set for a new stack, AWS Cloudformation creates a stack with a unique stack ID, but no template or resources. The stack will be in the <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-describing-stacks.html#d0e11995\"> <code>REVIEW_IN_PROGRESS</code> </a> state until you execute the change set.</p> <p>By default, AWS CloudFormation specifies <code>UPDATE</code>. You can't use the <code>UPDATE</code> type to create a change set for a new stack or the <code>CREATE</code> type to create a change set for an existing stack.</p>"];
      resources_to_import: ResourcesToImport.t
        [@ocaml.doc "<p>The resources to import into your stack.</p>"]}
    [@@ocaml.doc "<p>The input for the <a>CreateChangeSet</a> action.</p>"]
    let make ~stack_name  ?template_body  ?template_u_r_l 
      ?use_previous_template  ?(parameters= [])  ?(capabilities= []) 
      ?(resource_types= [])  ?role_a_r_n  ?rollback_configuration 
      ?(notification_a_r_ns= [])  ?(tags= [])  ~change_set_name 
      ?client_token  ?description  ?change_set_type  ?(resources_to_import=
      [])  () =
      {
        stack_name;
        template_body;
        template_u_r_l;
        use_previous_template;
        parameters;
        capabilities;
        resource_types;
        role_a_r_n;
        rollback_configuration;
        notification_a_r_ns;
        tags;
        change_set_name;
        client_token;
        description;
        change_set_type;
        resources_to_import
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resources_to_import",
                (ResourcesToImport.to_json v.resources_to_import));
           Util.option_map v.change_set_type
             (fun f -> ("change_set_type", (ChangeSetType.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Some ("change_set_name", (String.to_json v.change_set_name));
           Some ("tags", (Tags.to_json v.tags));
           Some
             ("notification_a_r_ns",
               (NotificationARNs.to_json v.notification_a_r_ns));
           Util.option_map v.rollback_configuration
             (fun f ->
                ("rollback_configuration", (RollbackConfiguration.to_json f)));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Some ("resource_types", (ResourceTypes.to_json v.resource_types));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Some ("parameters", (Parameters.to_json v.parameters));
           Util.option_map v.use_previous_template
             (fun f -> ("use_previous_template", (Boolean.to_json f)));
           Util.option_map v.template_u_r_l
             (fun f -> ("template_u_r_l", (String.to_json f)));
           Util.option_map v.template_body
             (fun f -> ("template_body", (String.to_json f)));
           Some ("stack_name", (String.to_json v.stack_name))])
    let parse xml =
      Some
        {
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
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
          resource_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResourceTypes" xml)
                  ResourceTypes.parse));
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse);
          rollback_configuration =
            (Util.option_bind (Xml.member "RollbackConfiguration" xml)
               RollbackConfiguration.parse);
          notification_a_r_ns =
            (Util.of_option []
               (Util.option_bind (Xml.member "NotificationARNs" xml)
                  NotificationARNs.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          change_set_name =
            (Xml.required "ChangeSetName"
               (Util.option_bind (Xml.member "ChangeSetName" xml)
                  String.parse));
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          change_set_type =
            (Util.option_bind (Xml.member "ChangeSetType" xml)
               ChangeSetType.parse);
          resources_to_import =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResourcesToImport" xml)
                  ResourcesToImport.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((([] @
                          [Some
                             (Ezxmlm.make_tag "StackName"
                                ([], (String.to_xml v.stack_name)))])
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
                                ([], (Capabilities.to_xml [x]))))
                        v.capabilities))
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "ResourceTypes"
                               ([], (ResourceTypes.to_xml [x]))))
                       v.resource_types))
                   @
                   [Util.option_map v.role_a_r_n
                      (fun f ->
                         Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.rollback_configuration
                     (fun f ->
                        Ezxmlm.make_tag "RollbackConfiguration"
                          ([], (RollbackConfiguration.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "NotificationARNs"
                            ([], (NotificationARNs.to_xml [x]))))
                    v.notification_a_r_ns))
                @
                (List.map
                   (fun x ->
                      Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
                   v.tags))
               @
               [Some
                  (Ezxmlm.make_tag "ChangeSetName"
                     ([], (String.to_xml v.change_set_name)))])
              @
              [Util.option_map v.client_token
                 (fun f ->
                    Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.change_set_type
               (fun f ->
                  Ezxmlm.make_tag "ChangeSetType"
                    ([], (ChangeSetType.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ResourcesToImport"
                      ([], (ResourcesToImport.to_xml [x]))))
              v.resources_to_import))
  end[@@ocaml.doc "<p>The input for the <a>CreateChangeSet</a> action.</p>"]
module CreateChangeSetOutput = CreateChangeSetOutput
type input = CreateChangeSetInput.t
type output = CreateChangeSetOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["CreateChangeSet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateChangeSetInput.to_query req))))) in
  (`POST, uri, (Headers.render (CreateChangeSetInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateChangeSetResponse" (snd xml))
        (Xml.member "CreateChangeSetResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateChangeSetOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateChangeSetOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateChangeSetOutput - missing field in body or children: "
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