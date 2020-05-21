open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssumeRoleWithWebIdentityRequest =
  struct
    type t =
      {
      role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the role that the caller is assuming.</p>"];
      role_session_name: String.t
        [@ocaml.doc
          "<p>An identifier for the assumed role session. Typically, you pass the name or identifier that is associated with the user who is using your application. That way, the temporary security credentials that your application will use are associated with that user. This session name is included as part of the ARN and assumed role ID in the <code>AssumedRoleUser</code> response element.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>"];
      web_identity_token: String.t
        [@ocaml.doc
          "<p>The OAuth 2.0 access token or OpenID Connect ID token that is provided by the identity provider. Your application must get this token by authenticating the user who is using your application with a web identity provider before the application makes an <code>AssumeRoleWithWebIdentity</code> call. </p>"];
      provider_id: String.t option
        [@ocaml.doc
          "<p>The fully qualified host component of the domain name of the identity provider.</p> <p>Specify this value only for OAuth 2.0 access tokens. Currently <code>www.amazon.com</code> and <code>graph.facebook.com</code> are the only supported identity providers for OAuth 2.0 access tokens. Do not include URL schemes and port numbers.</p> <p>Do not specify this value for OpenID Connect ID tokens.</p>"];
      policy_arns: PolicyDescriptorListType.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role.</p> <p>This parameter is optional. You can provide up to 10 managed policy ARNs. However, the plain text that you use for both inline and managed session policies can't exceed 2,048 characters. For more information about ARNs, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a> in the AWS General Reference.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent AWS API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\">Session Policies</a> in the <i>IAM User Guide</i>.</p>"];
      policy: String.t option
        [@ocaml.doc
          "<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>This parameter is optional. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent AWS API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>The plain text that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\u0020 through \\u00FF). It can also include the tab (\\u0009), linefeed (\\u000A), and carriage return (\\u000D) characters.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>"];
      duration_seconds: Integer.t option
        [@ocaml.doc
          "<p>The duration, in seconds, of the role session. The value can range from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. If you specify a value higher than this setting, the operation fails. For example, if you specify a session duration of 12 hours, but your administrator set the maximum session duration to 6 hours, your operation fails. To learn how to view the maximum value for your role, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>.</p> <p>By default, the value is set to <code>3600</code> seconds. </p> <note> <p>The <code>DurationSeconds</code> parameter is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\">Creating a URL that Enables Federated Users to Access the AWS Management Console</a> in the <i>IAM User Guide</i>.</p> </note>"]}
    let make ~role_arn  ~role_session_name  ~web_identity_token  ?provider_id
       ?(policy_arns= [])  ?policy  ?duration_seconds  () =
      {
        role_arn;
        role_session_name;
        web_identity_token;
        provider_id;
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
           Util.option_map v.provider_id
             (fun f -> ("provider_id", (String.to_json f)));
           Some ("web_identity_token", (String.to_json v.web_identity_token));
           Some ("role_session_name", (String.to_json v.role_session_name));
           Some ("role_arn", (String.to_json v.role_arn))])
    let parse xml =
      Some
        {
          role_arn =
            (Xml.required "RoleArn"
               (Util.option_bind (Xml.member "RoleArn" xml) String.parse));
          role_session_name =
            (Xml.required "RoleSessionName"
               (Util.option_bind (Xml.member "RoleSessionName" xml)
                  String.parse));
          web_identity_token =
            (Xml.required "WebIdentityToken"
               (Util.option_bind (Xml.member "WebIdentityToken" xml)
                  String.parse));
          provider_id =
            (Util.option_bind (Xml.member "ProviderId" xml) String.parse);
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
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "RoleArn"
                       ([], (String.to_xml v.role_arn)))])
                @
                [Some
                   (Ezxmlm.make_tag "RoleSessionName"
                      ([], (String.to_xml v.role_session_name)))])
               @
               [Some
                  (Ezxmlm.make_tag "WebIdentityToken"
                     ([], (String.to_xml v.web_identity_token)))])
              @
              [Util.option_map v.provider_id
                 (fun f ->
                    Ezxmlm.make_tag "ProviderId" ([], (String.to_xml f)))])
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
module AssumeRoleWithWebIdentityResponse = AssumeRoleWithWebIdentityResponse
type input = AssumeRoleWithWebIdentityRequest.t
type output = AssumeRoleWithWebIdentityResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2011-06-15"]);
         ("Action", ["AssumeRoleWithWebIdentity"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssumeRoleWithWebIdentityRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AssumeRoleWithWebIdentityRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "AssumeRoleWithWebIdentityResponse" (snd xml))
        (Xml.member "AssumeRoleWithWebIdentityResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AssumeRoleWithWebIdentityResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssumeRoleWithWebIdentityResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssumeRoleWithWebIdentityResponse - missing field in body or children: "
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