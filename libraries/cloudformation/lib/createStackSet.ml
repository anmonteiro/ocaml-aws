open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateStackSetInput =
  struct
    type t =
      {
      stack_set_name: String.t
        [@ocaml.doc
          "<p>The name to associate with the stack set. The name must be unique in the region where you create your stack set.</p> <note> <p>A stack name can contain only alphanumeric characters (case-sensitive) and hyphens. It must start with an alphabetic character and can't be longer than 128 characters.</p> </note>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description of the stack set. You can use the description to identify the stack set's purpose or other important information.</p>"];
      template_body: String.t option
        [@ocaml.doc
          "<p>The structure that contains the template body, with a minimum length of 1 byte and a maximum length of 51,200 bytes. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must specify either the TemplateBody or the TemplateURL parameter, but not both.</p>"];
      template_u_r_l: String.t option
        [@ocaml.doc
          "<p>The location of the file that contains the template body. The URL must point to a template (maximum size: 460,800 bytes) that's located in an Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.</p> <p>Conditional: You must specify either the TemplateBody or the TemplateURL parameter, but not both.</p>"];
      parameters: Parameters.t
        [@ocaml.doc
          "<p>The input parameters for the stack set template. </p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>In some cases, you must explicitly acknowledge that your stack set template contains certain capabilities in order for AWS CloudFormation to create the stack set and related stack instances.</p> <ul> <li> <p> <code>CAPABILITY_IAM</code> and <code>CAPABILITY_NAMED_IAM</code> </p> <p>Some stack templates might include resources that can affect permissions in your AWS account; for example, by creating new AWS Identity and Access Management (IAM) users. For those stack sets, you must explicitly acknowledge this by specifying one of these capabilities.</p> <p>The following IAM resources require you to specify either the <code>CAPABILITY_IAM</code> or <code>CAPABILITY_NAMED_IAM</code> capability.</p> <ul> <li> <p>If you have IAM resources, you can specify either capability. </p> </li> <li> <p>If you have IAM resources with custom names, you <i>must</i> specify <code>CAPABILITY_NAMED_IAM</code>. </p> </li> <li> <p>If you don't specify either of these capabilities, AWS CloudFormation returns an <code>InsufficientCapabilities</code> error.</p> </li> </ul> <p>If your stack template contains these resources, we recommend that you review all permissions associated with them and edit their permissions if necessary.</p> <ul> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-accesskey.html\"> AWS::IAM::AccessKey</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-group.html\"> AWS::IAM::Group</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-instanceprofile.html\"> AWS::IAM::InstanceProfile</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-policy.html\"> AWS::IAM::Policy</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-iam-role.html\"> AWS::IAM::Role</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-user.html\"> AWS::IAM::User</a> </p> </li> <li> <p> <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-iam-addusertogroup.html\"> AWS::IAM::UserToGroupAddition</a> </p> </li> </ul> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates</a>.</p> </li> <li> <p> <code>CAPABILITY_AUTO_EXPAND</code> </p> <p>Some templates contain macros. If your stack template contains one or more macros, and you choose to create a stack directly from the processed template, without first reviewing the resulting changes in a change set, you must acknowledge this capability. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-macros.html\">Using AWS CloudFormation Macros to Perform Custom Processing on Templates</a>.</p> <note> <p>Stack sets do not currently support macros in stack templates. (This includes the <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/create-reusable-transform-function-snippets-and-add-to-your-template-with-aws-include-transform.html\">AWS::Include</a> and <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/transform-aws-serverless.html\">AWS::Serverless</a> transforms, which are macros hosted by AWS CloudFormation.) Even if you specify this capability, if you include a macro in your template the stack set operation will fail.</p> </note> </li> </ul>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>The key-value pairs to associate with this stack set and the stacks created from it. AWS CloudFormation also propagates these tags to supported resources that are created in the stacks. A maximum number of 50 tags can be specified.</p> <p>If you specify tags as part of a <code>CreateStackSet</code> action, AWS CloudFormation checks to see if you have the required IAM permission to tag resources. If you don't, the entire <code>CreateStackSet</code> action fails with an <code>access denied</code> error, and the stack set is not created.</p>"];
      administration_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Number (ARN) of the IAM role to use to create this stack set. </p> <p>Specify an IAM role only if you are using customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html\">Prerequisites: Granting Permissions for Stack Set Operations</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      execution_role_name: String.t option
        [@ocaml.doc
          "<p>The name of the IAM execution role to use to create the stack set. If you do not specify an execution role, AWS CloudFormation uses the <code>AWSCloudFormationStackSetExecutionRole</code> role for the stack set operation.</p> <p>Specify an IAM role only if you are using customized execution roles to control which stack resources users and groups can include in their stack sets. </p>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>A unique identifier for this <code>CreateStackSet</code> request. Specify this token if you plan to retry requests so that AWS CloudFormation knows that you're not attempting to create another stack set with the same name. You might retry <code>CreateStackSet</code> requests to ensure that AWS CloudFormation successfully received them.</p> <p>If you don't specify an operation ID, the SDK generates one automatically. </p>"]}
    let make ~stack_set_name  ?description  ?template_body  ?template_u_r_l 
      ?(parameters= [])  ?(capabilities= [])  ?(tags= []) 
      ?administration_role_a_r_n  ?execution_role_name  ?client_request_token
       () =
      {
        stack_set_name;
        description;
        template_body;
        template_u_r_l;
        parameters;
        capabilities;
        tags;
        administration_role_a_r_n;
        execution_role_name;
        client_request_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Util.option_map v.execution_role_name
             (fun f -> ("execution_role_name", (String.to_json f)));
           Util.option_map v.administration_role_a_r_n
             (fun f -> ("administration_role_a_r_n", (String.to_json f)));
           Some ("tags", (Tags.to_json v.tags));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Some ("parameters", (Parameters.to_json v.parameters));
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
          administration_role_a_r_n =
            (Util.option_bind (Xml.member "AdministrationRoleARN" xml)
               String.parse);
          execution_role_name =
            (Util.option_bind (Xml.member "ExecutionRoleName" xml)
               String.parse);
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
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
                       Ezxmlm.make_tag "TemplateURL" ([], (String.to_xml f)))])
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
             [Util.option_map v.administration_role_a_r_n
                (fun f ->
                   Ezxmlm.make_tag "AdministrationRoleARN"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.execution_role_name
               (fun f ->
                  Ezxmlm.make_tag "ExecutionRoleName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end
module CreateStackSetOutput = CreateStackSetOutput
type input = CreateStackSetInput.t
type output = CreateStackSetOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["CreateStackSet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateStackSetInput.to_query req))))) in
  (`POST, uri, (Headers.render (CreateStackSetInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateStackSetResponse" (snd xml))
        (Xml.member "CreateStackSetResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateStackSetOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateStackSetOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateStackSetOutput - missing field in body or children: "
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