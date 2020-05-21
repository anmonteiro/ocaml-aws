open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssumeRoleRequest =
  struct
    type t =
      {
      role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the role to assume.</p>"];
      role_session_name: String.t
        [@ocaml.doc
          "<p>An identifier for the assumed role session.</p> <p>Use the role session name to uniquely identify a session when the same role is assumed by different principals or for different reasons. In cross-account scenarios, the role session name is visible to, and can be logged by the account that owns the role. The role session name is also used in the ARN of the assumed role principal. This means that subsequent cross-account API requests that use the temporary security credentials will expose the role session name to the external account in their AWS CloudTrail logs.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>"];
      policy_arns: PolicyDescriptorListType.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of the IAM managed policies that you want to use as managed session policies. The policies must exist in the same account as the role.</p> <p>This parameter is optional. You can provide up to 10 managed policy ARNs. However, the plain text that you use for both inline and managed session policies can't exceed 2,048 characters. For more information about ARNs, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a> in the AWS General Reference.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent AWS API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\">Session Policies</a> in the <i>IAM User Guide</i>.</p>"];
      policy: String.t option
        [@ocaml.doc
          "<p>An IAM policy in JSON format that you want to use as an inline session policy.</p> <p>This parameter is optional. Passing policies to this operation returns new temporary credentials. The resulting session's permissions are the intersection of the role's identity-based policy and the session policies. You can use the role's temporary credentials in subsequent AWS API calls to access resources in the account that owns the role. You cannot use session policies to grant more permissions than those allowed by the identity-based policy of the role that is being assumed. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#policies_session\">Session Policies</a> in the <i>IAM User Guide</i>.</p> <p>The plain text that you use for both inline and managed session policies can't exceed 2,048 characters. The JSON policy characters can be any ASCII character from the space character to the end of the valid character list (\\u0020 through \\u00FF). It can also include the tab (\\u0009), linefeed (\\u000A), and carriage return (\\u000D) characters.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note>"];
      duration_seconds: Integer.t option
        [@ocaml.doc
          "<p>The duration, in seconds, of the role session. The value can range from 900 seconds (15 minutes) up to the maximum session duration setting for the role. This setting can have a value from 1 hour to 12 hours. If you specify a value higher than this setting, the operation fails. For example, if you specify a session duration of 12 hours, but your administrator set the maximum session duration to 6 hours, your operation fails. To learn how to view the maximum value for your role, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html#id_roles_use_view-role-max-session\">View the Maximum Session Duration Setting for a Role</a> in the <i>IAM User Guide</i>.</p> <p>By default, the value is set to <code>3600</code> seconds. </p> <note> <p>The <code>DurationSeconds</code> parameter is separate from the duration of a console session that you might request using the returned credentials. The request to the federation endpoint for a console sign-in token takes a <code>SessionDuration</code> parameter that specifies the maximum length of the console session. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-custom-url.html\">Creating a URL that Enables Federated Users to Access the AWS Management Console</a> in the <i>IAM User Guide</i>.</p> </note>"];
      tags: TagListType.t
        [@ocaml.doc
          "<p>A list of session tags that you want to pass. Each session tag consists of a key name and an associated value. For more information about session tags, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\">Tagging AWS STS Sessions</a> in the <i>IAM User Guide</i>.</p> <p>This parameter is optional. You can pass up to 50 session tags. The plain text session tag keys can\226\128\153t exceed 128 characters, and the values can\226\128\153t exceed 256 characters. For these and additional limits, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p> <note> <p>An AWS conversion compresses the passed session policies and session tags into a packed binary format that has a separate limit. Your request can fail for this limit even if your plain text meets the other requirements. The <code>PackedPolicySize</code> response element indicates by percentage how close the policies and tags for your request are to the upper size limit. </p> </note> <p>You can pass a session tag with the same key as a tag that is already attached to the role. When you do, session tags override a role tag with the same key. </p> <p>Tag key\226\128\147value pairs are not case sensitive, but case is preserved. This means that you cannot have separate <code>Department</code> and <code>department</code> tag keys. Assume that the role has the <code>Department</code>=<code>Marketing</code> tag and you pass the <code>department</code>=<code>engineering</code> session tag. <code>Department</code> and <code>department</code> are not saved as separate tags, and the session tag passed in the request takes precedence over the role tag.</p> <p>Additionally, if you used temporary credentials to perform this operation, the new session inherits any transitive session tags from the calling session. If you pass a session tag with the same key as an inherited tag, the operation fails. To view the inherited tags for a session, see the AWS CloudTrail logs. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/session-tags.html#id_session-tags_ctlogs\">Viewing Session Tags in CloudTrail</a> in the <i>IAM User Guide</i>.</p>"];
      transitive_tag_keys: TagKeyListType.t
        [@ocaml.doc
          "<p>A list of keys for session tags that you want to set as transitive. If you set a tag key as transitive, the corresponding key and value passes to subsequent sessions in a role chain. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html#id_session-tags_role-chaining\">Chaining Roles with Session Tags</a> in the <i>IAM User Guide</i>.</p> <p>This parameter is optional. When you set session tags as transitive, the session policy and session tags packed binary limit is not affected.</p> <p>If you choose not to specify a transitive tag key, then no tags are passed from this session to any subsequent sessions.</p>"];
      external_id: String.t option
        [@ocaml.doc
          "<p>A unique identifier that might be required when you assume a role in another account. If the administrator of the account to which the role belongs provided you with an external ID, then provide that value in the <code>ExternalId</code> parameter. This value can be any string, such as a passphrase or account number. A cross-account role is usually set up to trust everyone in an account. Therefore, the administrator of the trusting account might send an external ID to the administrator of the trusted account. That way, only someone with the ID can assume the role, rather than everyone in the account. For more information about the external ID, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-user_externalid.html\">How to Use an External ID When Granting Access to Your AWS Resources to a Third Party</a> in the <i>IAM User Guide</i>.</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@:/-</p>"];
      serial_number: String.t option
        [@ocaml.doc
          "<p>The identification number of the MFA device that is associated with the user who is making the <code>AssumeRole</code> call. Specify this value if the trust policy of the role being assumed includes a condition that requires MFA authentication. The value is either the serial number for a hardware device (such as <code>GAHT12345678</code>) or an Amazon Resource Name (ARN) for a virtual device (such as <code>arn:aws:iam::123456789012:mfa/user</code>).</p> <p>The regex used to validate this parameter is a string of characters consisting of upper- and lower-case alphanumeric characters with no spaces. You can also include underscores or any of the following characters: =,.@-</p>"];
      token_code: String.t option
        [@ocaml.doc
          "<p>The value provided by the MFA device, if the trust policy of the role being assumed requires MFA (that is, if the policy includes a condition that tests for MFA). If the role being assumed requires MFA and if the <code>TokenCode</code> value is missing or expired, the <code>AssumeRole</code> call returns an \"access denied\" error.</p> <p>The format for this parameter, as described by its regex pattern, is a sequence of six numeric digits.</p>"]}
    let make ~role_arn  ~role_session_name  ?(policy_arns= [])  ?policy 
      ?duration_seconds  ?(tags= [])  ?(transitive_tag_keys= []) 
      ?external_id  ?serial_number  ?token_code  () =
      {
        role_arn;
        role_session_name;
        policy_arns;
        policy;
        duration_seconds;
        tags;
        transitive_tag_keys;
        external_id;
        serial_number;
        token_code
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.token_code
              (fun f -> ("token_code", (String.to_json f)));
           Util.option_map v.serial_number
             (fun f -> ("serial_number", (String.to_json f)));
           Util.option_map v.external_id
             (fun f -> ("external_id", (String.to_json f)));
           Some
             ("transitive_tag_keys",
               (TagKeyListType.to_json v.transitive_tag_keys));
           Some ("tags", (TagListType.to_json v.tags));
           Util.option_map v.duration_seconds
             (fun f -> ("duration_seconds", (Integer.to_json f)));
           Util.option_map v.policy (fun f -> ("policy", (String.to_json f)));
           Some
             ("policy_arns",
               (PolicyDescriptorListType.to_json v.policy_arns));
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
          policy_arns =
            (Util.of_option []
               (Util.option_bind (Xml.member "PolicyArns" xml)
                  PolicyDescriptorListType.parse));
          policy = (Util.option_bind (Xml.member "Policy" xml) String.parse);
          duration_seconds =
            (Util.option_bind (Xml.member "DurationSeconds" xml)
               Integer.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagListType.parse));
          transitive_tag_keys =
            (Util.of_option []
               (Util.option_bind (Xml.member "TransitiveTagKeys" xml)
                  TagKeyListType.parse));
          external_id =
            (Util.option_bind (Xml.member "ExternalId" xml) String.parse);
          serial_number =
            (Util.option_bind (Xml.member "SerialNumber" xml) String.parse);
          token_code =
            (Util.option_bind (Xml.member "TokenCode" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "RoleArn"
                          ([], (String.to_xml v.role_arn)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "RoleSessionName"
                         ([], (String.to_xml v.role_session_name)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "PolicyArns"
                             ([], (PolicyDescriptorListType.to_xml [x]))))
                     v.policy_arns))
                 @
                 [Util.option_map v.policy
                    (fun f ->
                       Ezxmlm.make_tag "Policy" ([], (String.to_xml f)))])
                @
                [Util.option_map v.duration_seconds
                   (fun f ->
                      Ezxmlm.make_tag "DurationSeconds"
                        ([], (Integer.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Tags" ([], (TagListType.to_xml [x]))))
                  v.tags))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "TransitiveTagKeys"
                         ([], (TagKeyListType.to_xml [x]))))
                 v.transitive_tag_keys))
             @
             [Util.option_map v.external_id
                (fun f ->
                   Ezxmlm.make_tag "ExternalId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.serial_number
               (fun f ->
                  Ezxmlm.make_tag "SerialNumber" ([], (String.to_xml f)))])
           @
           [Util.option_map v.token_code
              (fun f -> Ezxmlm.make_tag "TokenCode" ([], (String.to_xml f)))])
  end
module AssumeRoleResponse = AssumeRoleResponse
type input = AssumeRoleRequest.t
type output = AssumeRoleResponse.t
type error = Errors_internal.t
let streaming = false
let service = "sts"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2011-06-15"]); ("Action", ["AssumeRole"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssumeRoleRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AssumeRoleRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "AssumeRoleResponse" (snd xml))
        (Xml.member "AssumeRoleResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp AssumeRoleResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed AssumeRoleResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssumeRoleResponse - missing field in body or children: "
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