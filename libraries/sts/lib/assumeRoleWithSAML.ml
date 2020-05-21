open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssumeRoleWithSAMLRequest =
  struct
    type t =
      {
      role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the role that the caller is assuming.</p>"];
      principal_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the SAML provider in IAM that describes the IdP.</p>"];
      s_a_m_l_assertion: String.t
        [@ocaml.doc
          "<p>The base-64 encoded SAML authentication response provided by the IdP.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/create-role-saml-IdP-tasks.html\">Configuring a Relying Party and Adding Claims</a> in the <i>IAM User Guide</i>. </p>"];
      policy_arns: PolicyDescriptorListType.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role.</p> <p>This parameter is optional. You can provide up to 10 managed policy ARNs. However, the plain text that you use for both inline and managed session policies can't exceed 2,048 characters. For more information about ARNs, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a> in the AWS General Reference.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent AWS API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\">Session Policies</a> in the <i>IAM User Guide</i>.</p>"];
      policy: String.t option
        [@ocaml.doc
          "<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>This parameter is optional. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent AWS API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\">Session Policies</a> in the <i>IAM User Guide</i>. </p> <p>The plain text that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\u0020 through \\u00FF). It can also include the tab (\\u0009), linefeed (\\u000A), and carriage return (\\u000D) characters.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>"];
      duration_seconds: Integer.t option
        [@ocaml.doc
          "<p>The duration, in seconds, of the role session. Your role session lasts for the duration that you specify for the <code>DurationSeconds</code> parameter, or until the time specified in the SAML authentication response's <code>SessionNotOnOrAfter</code> value, whichever is shorter. You can provide a <code>DurationSeconds</code> value from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. If you specify a value higher than this setting, the operation fails. For example, if you specify a session duration of 12 hours, but your administrator set the maximum session duration to 6 hours, your operation fails. To learn how to view the maximum value for your role, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>.</p> <p>By default, the value is set to <code>3600</code> seconds. </p> <note> <p>The <code>DurationSeconds</code> parameter is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\">Creating a URL that Enables Federated Users to Access the AWS Management Console</a> in the <i>IAM User Guide</i>.</p> </note>"]}
    let make ~role_arn  ~principal_arn  ~s_a_m_l_assertion  ?(policy_arns=
      [])  ?policy  ?duration_seconds  () =
      {
        role_arn;
        principal_arn;
        s_a_m_l_assertion;
        policy_arns;
        policy;
        duration_seconds
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.duration_seconds
              (fun f -> ("duration_seconds", (Integer.to_json f)));
           Util.option_map v.policy (fun f -> ("policy", (String.to_json f)));
           Some
             ("policy_arns",
               (PolicyDescriptorListType.to_json v.policy_arns));
           Some ("s_a_m_l_assertion", (String.to_json v.s_a_m_l_assertion));
           Some ("principal_arn", (String.to_json v.principal_arn));
           Some ("role_arn", (String.to_json v.role_arn))])
    let parse xml =
      Some
        {
          role_arn =
            (Xml.required "RoleArn"
               (Util.option_bind (Xml.member "RoleArn" xml) String.parse));
          principal_arn =
            (Xml.required "PrincipalArn"
               (Util.option_bind (Xml.member "PrincipalArn" xml) String.parse));
          s_a_m_l_assertion =
            (Xml.required "SAMLAssertion"
               (Util.option_bind (Xml.member "SAMLAssertion" xml)
                  String.parse));
          policy_arns =
            (Util.of_option []
               (Util.option_bind (Xml.member "PolicyArns" xml)
                  PolicyDescriptorListType.parse));
          policy = (Util.option_bind (Xml.member "Policy" xml) String.parse);
          duration_seconds =
            (Util.option_bind (Xml.member "DurationSeconds" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "RoleArn"
                      ([], (String.to_xml v.role_arn)))])
               @
               [Some
                  (Ezxmlm.make_tag "PrincipalArn"
                     ([], (String.to_xml v.principal_arn)))])
              @
              [Some
                 (Ezxmlm.make_tag "SAMLAssertion"
                    ([], (String.to_xml v.s_a_m_l_assertion)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "PolicyArns"
                        ([], (PolicyDescriptorListType.to_xml [x]))))
                v.policy_arns))
            @
            [Util.option_map v.policy
               (fun f -> Ezxmlm.make_tag "Policy" ([], (String.to_xml f)))])
           @
           [Util.option_map v.duration_seconds
              (fun f ->
                 Ezxmlm.make_tag "DurationSeconds" ([], (Integer.to_xml f)))])
  end
module AssumeRoleWithSAMLResponse = AssumeRoleWithSAMLResponse
type input = AssumeRoleWithSAMLRequest.t
type output = AssumeRoleWithSAMLResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-06-15"]); ("Action", ["AssumeRoleWithSAML"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssumeRoleWithSAMLRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AssumeRoleWithSAMLRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "AssumeRoleWithSAMLResponse" (snd xml))
        (Xml.member "AssumeRoleWithSAMLResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AssumeRoleWithSAMLResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssumeRoleWithSAMLResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssumeRoleWithSAMLResponse - missing field in body or children: "
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