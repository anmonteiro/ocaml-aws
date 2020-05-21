open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateStackInput =
  struct
    type t =
      {
      stack_name: String.t
        [@ocaml.doc
          "<p>The name or unique stack ID of the stack to update.</p>"];
      template_body: String.t option
        [@ocaml.doc
          "<p>Structure containing the template body with a minimum length of 1 byte and a maximum length of 51,200 bytes. (For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.)</p> <p>Conditional: You must specify only one of the following parameters: <code>TemplateBody</code>, <code>TemplateURL</code>, or set the <code>UsePreviousTemplate</code> to <code>true</code>.</p>"];
      template_u_r_l: String.t option
        [@ocaml.doc
          "<p>Location of file containing the template body. The URL must point to a template that is located in an Amazon S3 bucket. For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must specify only one of the following parameters: <code>TemplateBody</code>, <code>TemplateURL</code>, or set the <code>UsePreviousTemplate</code> to <code>true</code>.</p>"];
      use_previous_template: Boolean.t option
        [@ocaml.doc
          "<p>Reuse the existing template that is associated with the stack that you are updating.</p> <p>Conditional: You must specify only one of the following parameters: <code>TemplateBody</code>, <code>TemplateURL</code>, or set the <code>UsePreviousTemplate</code> to <code>true</code>.</p>"];
      stack_policy_during_update_body: String.t option
        [@ocaml.doc
          "<p>Structure containing the temporary overriding stack policy body. You can specify either the <code>StackPolicyDuringUpdateBody</code> or the <code>StackPolicyDuringUpdateURL</code> parameter, but not both.</p> <p>If you want to update protected resources, specify a temporary overriding stack policy during this update. If you do not specify a stack policy, the current policy that is associated with the stack will be used.</p>"];
      stack_policy_during_update_u_r_l: String.t option
        [@ocaml.doc
          "<p>Location of a file containing the temporary overriding stack policy. The URL must point to a policy (max size: 16KB) located in an S3 bucket in the same region as the stack. You can specify either the <code>StackPolicyDuringUpdateBody</code> or the <code>StackPolicyDuringUpdateURL</code> parameter, but not both.</p> <p>If you want to update protected resources, specify a temporary overriding stack policy during this update. If you do not specify a stack policy, the current policy that is associated with the stack will be used.</p>"];
      parameters: Parameters.t
        [@ocaml.doc
          "<p>A list of <code>Parameter</code> structures that specify input parameters for the stack. For more information, see the <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_Parameter.html\">Parameter</a> data type.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>In some cases, you must explicitly acknowledge that your stack template contains certain capabilities in order for AWS CloudFormation to update the stack.</p> <ul> <li> <p> <code>CAPABILITY_IAM</code> and <code>CAPABILITY_NAMED_IAM</code> </p> <p>Some stack templates might include resources that can affect permissions in your AWS account; for example, by creating new AWS Identity and Access Management (IAM) users. For those stacks, you must explicitly acknowledge this by specifying one of these capabilities.</p> <p>The following IAM resources require you to specify either the <code>CAPABILITY_IAM</code> or <code>CAPABILITY_NAMED_IAM</code> capability.</p> <ul> <li> <p>If you have IAM resources, you can specify either capability. </p> </li> <li> <p>If you have IAM resources with custom names, you <i>must</i> specify <code>CAPABILITY_NAMED_IAM</code>. </p> </li> <li> <p>If you don't specify either of these capabilities, AWS CloudFormation returns an <code>InsufficientCapabilities</code> error.</p> </li> </ul> <p>If your stack template contains these resources, we recommend that you review all permissions associated with them and edit their permissions if necessary.</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html\"> AWS::IAM::AccessKey</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html\"> AWS::IAM::Group</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html\"> AWS::IAM::InstanceProfile</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-policy.html\"> AWS::IAM::Policy</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html\"> AWS::IAM::Role</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-user.html\"> AWS::IAM::User</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-addusertogroup.html\"> AWS::IAM::UserToGroupAddition</a> </p> </li> </ul> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates</a>.</p> </li> <li> <p> <code>CAPABILITY_AUTO_EXPAND</code> </p> <p>Some template contain macros. Macros perform custom processing on templates; this can include simple actions like find-and-replace operations, all the way to extensive transformations of entire templates. Because of this, users typically create a change set from the processed template, so that they can review the changes resulting from the macros before actually updating the stack. If your stack template contains one or more macros, and you choose to update a stack directly from the processed template, without first reviewing the resulting changes in a change set, you must acknowledge this capability. This includes the <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/create-reusable-transform-function-snippets-and-add-to-your-template-with-aws-include-transform.html\">AWS::Include</a> and <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html\">AWS::Serverless</a> transforms, which are macros hosted by AWS CloudFormation.</p> <p>Change sets do not currently support nested stacks. If you want to update a stack from a stack template that contains macros <i>and</i> nested stacks, you must update the stack directly from the template using this capability.</p> <important> <p>You should only update stacks directly from a stack template that contains macros if you know what processing the macro performs.</p> <p>Each macro relies on an underlying Lambda service function for processing stack templates. Be aware that the Lambda function owner can update the function operation without AWS CloudFormation being notified.</p> </important> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html\">Using AWS CloudFormation Macros to Perform Custom Processing on Templates</a>.</p> </li> </ul>"];
      resource_types: ResourceTypes.t
        [@ocaml.doc
          "<p>The template resource types that you have permissions to work with for this update stack action, such as <code>AWS::EC2::Instance</code>, <code>AWS::EC2::*</code>, or <code>Custom::MyCustomInstance</code>.</p> <p>If the list of resource types doesn't include a resource that you're updating, the stack update fails. By default, AWS CloudFormation grants permissions to all resource types. AWS Identity and Access Management (IAM) uses this parameter for AWS CloudFormation-specific condition keys in IAM policies. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html\">Controlling Access with AWS Identity and Access Management</a>.</p>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that AWS CloudFormation assumes to update the stack. AWS CloudFormation uses the role's credentials to make calls on your behalf. AWS CloudFormation always uses this role for all future operations on the stack. As long as users have permission to operate on the stack, AWS CloudFormation uses this role even if the users don't have permission to pass it. Ensure that the role grants least privilege.</p> <p>If you don't specify a value, AWS CloudFormation uses the role that was previously associated with the stack. If no role is available, AWS CloudFormation uses a temporary session that is generated from your user credentials.</p>"];
      rollback_configuration: RollbackConfiguration.t option
        [@ocaml.doc
          "<p>The rollback triggers for AWS CloudFormation to monitor during stack creation and updating operations, and for the specified monitoring period afterwards.</p>"];
      stack_policy_body: String.t option
        [@ocaml.doc
          "<p>Structure containing a new stack policy body. You can specify either the <code>StackPolicyBody</code> or the <code>StackPolicyURL</code> parameter, but not both.</p> <p>You might update the stack policy, for example, in order to protect a new resource that you created during a stack update. If you do not specify a stack policy, the current policy that is associated with the stack is unchanged.</p>"];
      stack_policy_u_r_l: String.t option
        [@ocaml.doc
          "<p>Location of a file containing the updated stack policy. The URL must point to a policy (max size: 16KB) located in an S3 bucket in the same region as the stack. You can specify either the <code>StackPolicyBody</code> or the <code>StackPolicyURL</code> parameter, but not both.</p> <p>You might update the stack policy, for example, in order to protect a new resource that you created during a stack update. If you do not specify a stack policy, the current policy that is associated with the stack is unchanged.</p>"];
      notification_a_r_ns: NotificationARNs.t
        [@ocaml.doc
          "<p>Amazon Simple Notification Service topic Amazon Resource Names (ARNs) that AWS CloudFormation associates with the stack. Specify an empty list to remove all notification topics.</p>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>Key-value pairs to associate with this stack. AWS CloudFormation also propagates these tags to supported resources in the stack. You can specify a maximum number of 50 tags.</p> <p>If you don't specify this parameter, AWS CloudFormation doesn't modify the stack's tags. If you specify an empty value, AWS CloudFormation removes all associated tags.</p>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>A unique identifier for this <code>UpdateStack</code> request. Specify this token if you plan to retry requests so that AWS CloudFormation knows that you're not attempting to update a stack with the same name. You might retry <code>UpdateStack</code> requests to ensure that AWS CloudFormation successfully received them.</p> <p>All events triggered by a given stack operation are assigned the same client request token, which you can use to track operations. For example, if you execute a <code>CreateStack</code> operation with the token <code>token1</code>, then all the <code>StackEvents</code> generated by that operation will have <code>ClientRequestToken</code> set as <code>token1</code>.</p> <p>In the console, stack operations display the client request token on the Events tab. Stack operations that are initiated from the console use the token format <i>Console-StackOperation-ID</i>, which helps you easily identify the stack operation . For example, if you create a stack using the console, each stack event would be assigned the same token in the following format: <code>Console-CreateStack-7f59c3cf-00d2-40c7-b2ff-e75db0987002</code>. </p>"]}
    [@@ocaml.doc "<p>The input for an <a>UpdateStack</a> action.</p>"]
    let make ~stack_name  ?template_body  ?template_u_r_l 
      ?use_previous_template  ?stack_policy_during_update_body 
      ?stack_policy_during_update_u_r_l  ?(parameters= [])  ?(capabilities=
      [])  ?(resource_types= [])  ?role_a_r_n  ?rollback_configuration 
      ?stack_policy_body  ?stack_policy_u_r_l  ?(notification_a_r_ns= []) 
      ?(tags= [])  ?client_request_token  () =
      {
        stack_name;
        template_body;
        template_u_r_l;
        use_previous_template;
        stack_policy_during_update_body;
        stack_policy_during_update_u_r_l;
        parameters;
        capabilities;
        resource_types;
        role_a_r_n;
        rollback_configuration;
        stack_policy_body;
        stack_policy_u_r_l;
        notification_a_r_ns;
        tags;
        client_request_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Some ("tags", (Tags.to_json v.tags));
           Some
             ("notification_a_r_ns",
               (NotificationARNs.to_json v.notification_a_r_ns));
           Util.option_map v.stack_policy_u_r_l
             (fun f -> ("stack_policy_u_r_l", (String.to_json f)));
           Util.option_map v.stack_policy_body
             (fun f -> ("stack_policy_body", (String.to_json f)));
           Util.option_map v.rollback_configuration
             (fun f ->
                ("rollback_configuration", (RollbackConfiguration.to_json f)));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Some ("resource_types", (ResourceTypes.to_json v.resource_types));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Some ("parameters", (Parameters.to_json v.parameters));
           Util.option_map v.stack_policy_during_update_u_r_l
             (fun f ->
                ("stack_policy_during_update_u_r_l", (String.to_json f)));
           Util.option_map v.stack_policy_during_update_body
             (fun f ->
                ("stack_policy_during_update_body", (String.to_json f)));
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
          stack_policy_during_update_body =
            (Util.option_bind (Xml.member "StackPolicyDuringUpdateBody" xml)
               String.parse);
          stack_policy_during_update_u_r_l =
            (Util.option_bind (Xml.member "StackPolicyDuringUpdateURL" xml)
               String.parse);
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
          stack_policy_body =
            (Util.option_bind (Xml.member "StackPolicyBody" xml) String.parse);
          stack_policy_u_r_l =
            (Util.option_bind (Xml.member "StackPolicyURL" xml) String.parse);
          notification_a_r_ns =
            (Util.of_option []
               (Util.option_bind (Xml.member "NotificationARNs" xml)
                  NotificationARNs.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
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
                      [Util.option_map v.stack_policy_during_update_body
                         (fun f ->
                            Ezxmlm.make_tag "StackPolicyDuringUpdateBody"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.stack_policy_during_update_u_r_l
                        (fun f ->
                           Ezxmlm.make_tag "StackPolicyDuringUpdateURL"
                             ([], (String.to_xml f)))])
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
               [Util.option_map v.stack_policy_body
                  (fun f ->
                     Ezxmlm.make_tag "StackPolicyBody"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.stack_policy_u_r_l
                 (fun f ->
                    Ezxmlm.make_tag "StackPolicyURL" ([], (String.to_xml f)))])
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
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The input for an <a>UpdateStack</a> action.</p>"]
module UpdateStackOutput = UpdateStackOutput
type input = UpdateStackInput.t
type output = UpdateStackOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2010-05-15"]); ("Action", ["UpdateStack"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (UpdateStackInput.to_query req))))) in
  (`POST, uri, (Headers.render (UpdateStackInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "UpdateStackResponse" (snd xml))
        (Xml.member "UpdateStackResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp UpdateStackOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed UpdateStackOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateStackOutput - missing field in body or children: "
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