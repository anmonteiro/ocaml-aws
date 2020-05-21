open Aws
open Aws.BaseTypes
module PolicyDescriptorType =
  struct
    type t =
      {
      arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM managed policy to use as a session policy for the role. For more information about ARNs, see <a href=\"https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html\">Amazon Resource Names (ARNs) and AWS Service Namespaces</a> in the <i>AWS General Reference</i>.</p>"]}
    [@@ocaml.doc
      "<p>A reference to the IAM managed policy that is passed as a session policy for a role session or a federated user session.</p>"]
    let make ?arn  () = { arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.arn (fun f -> ("arn", (String.to_json f)))])
    let parse xml =
      Some { arn = (Util.option_bind (Xml.member "arn" xml) String.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.arn
              (fun f -> Ezxmlm.make_tag "arn" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A reference to the IAM managed policy that is passed as a session policy for a role session or a federated user session.</p>"]
module Tag =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>The key for a session tag.</p> <p>You can pass up to 50 session tags. The plain text session tag keys can\226\128\153t exceed 128 characters. For these and additional limits, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p>"];
      value: String.t
        [@ocaml.doc
          "<p>The value for a session tag.</p> <p>You can pass up to 50 session tags. The plain text session tag values can\226\128\153t exceed 256 characters. For these and additional limits, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-limits.html#reference_iam-limits-entity-length\">IAM and STS Character Limits</a> in the <i>IAM User Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>You can pass custom key-value pair attributes when you assume a role or federate a user. These are called session tags. You can then use the session tags to control access to resources. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\">Tagging AWS STS Sessions</a> in the <i>IAM User Guide</i>.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key))])
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>You can pass custom key-value pair attributes when you assume a role or federate a user. These are called session tags. You can then use the session tags to control access to resources. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\">Tagging AWS STS Sessions</a> in the <i>IAM User Guide</i>.</p>"]
module Credentials =
  struct
    type t =
      {
      access_key_id: String.t
        [@ocaml.doc
          "<p>The access key ID that identifies the temporary security credentials.</p>"];
      secret_access_key: String.t
        [@ocaml.doc
          "<p>The secret access key that can be used to sign requests.</p>"];
      session_token: String.t
        [@ocaml.doc
          "<p>The token that users must pass to the service API to use the temporary credentials.</p>"];
      expiration: DateTime.t
        [@ocaml.doc
          "<p>The date on which the current credentials expire.</p>"]}
    [@@ocaml.doc "<p>AWS credentials for API authentication.</p>"]
    let make ~access_key_id  ~secret_access_key  ~session_token  ~expiration 
      () = { access_key_id; secret_access_key; session_token; expiration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("expiration", (DateTime.to_json v.expiration));
           Some ("session_token", (String.to_json v.session_token));
           Some ("secret_access_key", (String.to_json v.secret_access_key));
           Some ("access_key_id", (String.to_json v.access_key_id))])
    let parse xml =
      Some
        {
          access_key_id =
            (Xml.required "AccessKeyId"
               (Util.option_bind (Xml.member "AccessKeyId" xml) String.parse));
          secret_access_key =
            (Xml.required "SecretAccessKey"
               (Util.option_bind (Xml.member "SecretAccessKey" xml)
                  String.parse));
          session_token =
            (Xml.required "SessionToken"
               (Util.option_bind (Xml.member "SessionToken" xml) String.parse));
          expiration =
            (Xml.required "Expiration"
               (Util.option_bind (Xml.member "Expiration" xml) DateTime.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "AccessKeyId"
                    ([], (String.to_xml v.access_key_id)))])
             @
             [Some
                (Ezxmlm.make_tag "SecretAccessKey"
                   ([], (String.to_xml v.secret_access_key)))])
            @
            [Some
               (Ezxmlm.make_tag "SessionToken"
                  ([], (String.to_xml v.session_token)))])
           @
           [Some
              (Ezxmlm.make_tag "Expiration"
                 ([], (DateTime.to_xml v.expiration)))])
  end[@@ocaml.doc "<p>AWS credentials for API authentication.</p>"]
module FederatedUser =
  struct
    type t =
      {
      federated_user_id: String.t
        [@ocaml.doc
          "<p>The string that identifies the federated user associated with the credentials, similar to the unique ID of an IAM user.</p>"];
      arn: String.t
        [@ocaml.doc
          "<p>The ARN that specifies the federated user that is associated with the credentials. For more information about ARNs and how to use them in policies, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html\">IAM Identifiers</a> in the <i>IAM User Guide</i>. </p>"]}
    [@@ocaml.doc
      "<p>Identifiers for the federated user that is associated with the credentials.</p>"]
    let make ~federated_user_id  ~arn  () = { federated_user_id; arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("arn", (String.to_json v.arn));
           Some ("federated_user_id", (String.to_json v.federated_user_id))])
    let parse xml =
      Some
        {
          federated_user_id =
            (Xml.required "FederatedUserId"
               (Util.option_bind (Xml.member "FederatedUserId" xml)
                  String.parse));
          arn =
            (Xml.required "Arn"
               (Util.option_bind (Xml.member "Arn" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "FederatedUserId"
                  ([], (String.to_xml v.federated_user_id)))])
           @ [Some (Ezxmlm.make_tag "Arn" ([], (String.to_xml v.arn)))])
  end[@@ocaml.doc
       "<p>Identifiers for the federated user that is associated with the credentials.</p>"]
module PolicyDescriptorListType =
  struct
    type t = PolicyDescriptorType.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PolicyDescriptorType.to_query v
    let to_headers v =
      Headers.to_headers_list PolicyDescriptorType.to_headers v
    let to_json v = `List (List.map PolicyDescriptorType.to_json v)
    let parse xml =
      Util.option_all
        (List.map PolicyDescriptorType.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (PolicyDescriptorType.to_xml x))) v
  end
module TagListType =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end
module AssumedRoleUser =
  struct
    type t =
      {
      assumed_role_id: String.t
        [@ocaml.doc
          "<p>A unique identifier that contains the role ID and the role session name of the role that is being assumed. The role ID is generated by AWS when the role is created.</p>"];
      arn: String.t
        [@ocaml.doc
          "<p>The ARN of the temporary security credentials that are returned from the <a>AssumeRole</a> action. For more information about ARNs and how to use them in policies, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html\">IAM Identifiers</a> in the <i>IAM User Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>The identifiers for the temporary security credentials that the operation returns.</p>"]
    let make ~assumed_role_id  ~arn  () = { assumed_role_id; arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("arn", (String.to_json v.arn));
           Some ("assumed_role_id", (String.to_json v.assumed_role_id))])
    let parse xml =
      Some
        {
          assumed_role_id =
            (Xml.required "AssumedRoleId"
               (Util.option_bind (Xml.member "AssumedRoleId" xml)
                  String.parse));
          arn =
            (Xml.required "Arn"
               (Util.option_bind (Xml.member "Arn" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "AssumedRoleId"
                  ([], (String.to_xml v.assumed_role_id)))])
           @ [Some (Ezxmlm.make_tag "Arn" ([], (String.to_xml v.arn)))])
  end[@@ocaml.doc
       "<p>The identifiers for the temporary security credentials that the operation returns.</p>"]
module TagKeyListType =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module GetFederationTokenResponse =
  struct
    type t =
      {
      credentials: Credentials.t option
        [@ocaml.doc
          "<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>"];
      federated_user: FederatedUser.t option
        [@ocaml.doc
          "<p>Identifiers for the federated user associated with the credentials (such as <code>arn:aws:sts::123456789012:federated-user/Bob</code> or <code>123456789012:Bob</code>). You can use the federated user's ARN in your resource-based policies, such as an Amazon S3 bucket policy. </p>"];
      packed_policy_size: Integer.t option
        [@ocaml.doc
          "<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>"]}
    [@@ocaml.doc
      "<p>Contains the response to a successful <a>GetFederationToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
    let make ?credentials  ?federated_user  ?packed_policy_size  () =
      { credentials; federated_user; packed_policy_size }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.packed_policy_size
              (fun f -> ("packed_policy_size", (Integer.to_json f)));
           Util.option_map v.federated_user
             (fun f -> ("federated_user", (FederatedUser.to_json f)));
           Util.option_map v.credentials
             (fun f -> ("credentials", (Credentials.to_json f)))])
    let parse xml =
      Some
        {
          credentials =
            (Util.option_bind (Xml.member "Credentials" xml)
               Credentials.parse);
          federated_user =
            (Util.option_bind (Xml.member "FederatedUser" xml)
               FederatedUser.parse);
          packed_policy_size =
            (Util.option_bind (Xml.member "PackedPolicySize" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.credentials
                (fun f ->
                   Ezxmlm.make_tag "Credentials" ([], (Credentials.to_xml f)))])
            @
            [Util.option_map v.federated_user
               (fun f ->
                  Ezxmlm.make_tag "FederatedUser"
                    ([], (FederatedUser.to_xml f)))])
           @
           [Util.option_map v.packed_policy_size
              (fun f ->
                 Ezxmlm.make_tag "PackedPolicySize" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the response to a successful <a>GetFederationToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
module AssumeRoleWithSAMLResponse =
  struct
    type t =
      {
      credentials: Credentials.t option
        [@ocaml.doc
          "<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>"];
      assumed_role_user: AssumedRoleUser.t option
        [@ocaml.doc
          "<p>The identifiers for the temporary security credentials that the operation returns.</p>"];
      packed_policy_size: Integer.t option
        [@ocaml.doc
          "<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>"];
      subject: String.t option
        [@ocaml.doc
          "<p>The value of the <code>NameID</code> element in the <code>Subject</code> element of the SAML assertion.</p>"];
      subject_type: String.t option
        [@ocaml.doc
          "<p> The format of the name ID, as defined by the <code>Format</code> attribute in the <code>NameID</code> element of the SAML assertion. Typical examples of the format are <code>transient</code> or <code>persistent</code>. </p> <p> If the format includes the prefix <code>urn:oasis:names:tc:SAML:2.0:nameid-format</code>, that prefix is removed. For example, <code>urn:oasis:names:tc:SAML:2.0:nameid-format:transient</code> is returned as <code>transient</code>. If the format includes any other prefix, the format is returned with no modifications.</p>"];
      issuer: String.t option
        [@ocaml.doc
          "<p>The value of the <code>Issuer</code> element of the SAML assertion.</p>"];
      audience: String.t option
        [@ocaml.doc
          "<p> The value of the <code>Recipient</code> attribute of the <code>SubjectConfirmationData</code> element of the SAML assertion. </p>"];
      name_qualifier: String.t option
        [@ocaml.doc
          "<p>A hash value based on the concatenation of the <code>Issuer</code> response value, the AWS account ID, and the friendly name (the last part of the ARN) of the SAML provider in IAM. The combination of <code>NameQualifier</code> and <code>Subject</code> can be used to uniquely identify a federated user. </p> <p>The following pseudocode shows how the hash value is calculated:</p> <p> <code>BASE64 ( SHA1 ( \"https://example.com/saml\" + \"123456789012\" + \"/MySAMLIdP\" ) )</code> </p>"]}
    [@@ocaml.doc
      "<p>Contains the response to a successful <a>AssumeRoleWithSAML</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
    let make ?credentials  ?assumed_role_user  ?packed_policy_size  ?subject 
      ?subject_type  ?issuer  ?audience  ?name_qualifier  () =
      {
        credentials;
        assumed_role_user;
        packed_policy_size;
        subject;
        subject_type;
        issuer;
        audience;
        name_qualifier
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name_qualifier
              (fun f -> ("name_qualifier", (String.to_json f)));
           Util.option_map v.audience
             (fun f -> ("audience", (String.to_json f)));
           Util.option_map v.issuer (fun f -> ("issuer", (String.to_json f)));
           Util.option_map v.subject_type
             (fun f -> ("subject_type", (String.to_json f)));
           Util.option_map v.subject
             (fun f -> ("subject", (String.to_json f)));
           Util.option_map v.packed_policy_size
             (fun f -> ("packed_policy_size", (Integer.to_json f)));
           Util.option_map v.assumed_role_user
             (fun f -> ("assumed_role_user", (AssumedRoleUser.to_json f)));
           Util.option_map v.credentials
             (fun f -> ("credentials", (Credentials.to_json f)))])
    let parse xml =
      Some
        {
          credentials =
            (Util.option_bind (Xml.member "Credentials" xml)
               Credentials.parse);
          assumed_role_user =
            (Util.option_bind (Xml.member "AssumedRoleUser" xml)
               AssumedRoleUser.parse);
          packed_policy_size =
            (Util.option_bind (Xml.member "PackedPolicySize" xml)
               Integer.parse);
          subject =
            (Util.option_bind (Xml.member "Subject" xml) String.parse);
          subject_type =
            (Util.option_bind (Xml.member "SubjectType" xml) String.parse);
          issuer = (Util.option_bind (Xml.member "Issuer" xml) String.parse);
          audience =
            (Util.option_bind (Xml.member "Audience" xml) String.parse);
          name_qualifier =
            (Util.option_bind (Xml.member "NameQualifier" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.credentials
                     (fun f ->
                        Ezxmlm.make_tag "Credentials"
                          ([], (Credentials.to_xml f)))])
                 @
                 [Util.option_map v.assumed_role_user
                    (fun f ->
                       Ezxmlm.make_tag "AssumedRoleUser"
                         ([], (AssumedRoleUser.to_xml f)))])
                @
                [Util.option_map v.packed_policy_size
                   (fun f ->
                      Ezxmlm.make_tag "PackedPolicySize"
                        ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.subject
                  (fun f -> Ezxmlm.make_tag "Subject" ([], (String.to_xml f)))])
              @
              [Util.option_map v.subject_type
                 (fun f ->
                    Ezxmlm.make_tag "SubjectType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.issuer
                (fun f -> Ezxmlm.make_tag "Issuer" ([], (String.to_xml f)))])
            @
            [Util.option_map v.audience
               (fun f -> Ezxmlm.make_tag "Audience" ([], (String.to_xml f)))])
           @
           [Util.option_map v.name_qualifier
              (fun f ->
                 Ezxmlm.make_tag "NameQualifier" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the response to a successful <a>AssumeRoleWithSAML</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
module GetCallerIdentityRequest =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DecodeAuthorizationMessageResponse =
  struct
    type t =
      {
      decoded_message: String.t option
        [@ocaml.doc
          "<p>An XML document that contains the decoded message.</p>"]}
    [@@ocaml.doc
      "<p>A document that contains additional information about the authorization status of a request from an encoded message that is returned in response to an AWS request.</p>"]
    let make ?decoded_message  () = { decoded_message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.decoded_message
              (fun f -> ("decoded_message", (String.to_json f)))])
    let parse xml =
      Some
        {
          decoded_message =
            (Util.option_bind (Xml.member "DecodedMessage" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.decoded_message
              (fun f ->
                 Ezxmlm.make_tag "DecodedMessage" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A document that contains additional information about the authorization status of a request from an encoded message that is returned in response to an AWS request.</p>"]
module AssumeRoleResponse =
  struct
    type t =
      {
      credentials: Credentials.t option
        [@ocaml.doc
          "<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>"];
      assumed_role_user: AssumedRoleUser.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers that you can use to refer to the resulting temporary security credentials. For example, you can reference these credentials as a principal in a resource-based policy by using the ARN or assumed role ID. The ARN and ID include the <code>RoleSessionName</code> that you specified when you called <code>AssumeRole</code>. </p>"];
      packed_policy_size: Integer.t option
        [@ocaml.doc
          "<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>"]}
    [@@ocaml.doc
      "<p>Contains the response to a successful <a>AssumeRole</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
    let make ?credentials  ?assumed_role_user  ?packed_policy_size  () =
      { credentials; assumed_role_user; packed_policy_size }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.packed_policy_size
              (fun f -> ("packed_policy_size", (Integer.to_json f)));
           Util.option_map v.assumed_role_user
             (fun f -> ("assumed_role_user", (AssumedRoleUser.to_json f)));
           Util.option_map v.credentials
             (fun f -> ("credentials", (Credentials.to_json f)))])
    let parse xml =
      Some
        {
          credentials =
            (Util.option_bind (Xml.member "Credentials" xml)
               Credentials.parse);
          assumed_role_user =
            (Util.option_bind (Xml.member "AssumedRoleUser" xml)
               AssumedRoleUser.parse);
          packed_policy_size =
            (Util.option_bind (Xml.member "PackedPolicySize" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.credentials
                (fun f ->
                   Ezxmlm.make_tag "Credentials" ([], (Credentials.to_xml f)))])
            @
            [Util.option_map v.assumed_role_user
               (fun f ->
                  Ezxmlm.make_tag "AssumedRoleUser"
                    ([], (AssumedRoleUser.to_xml f)))])
           @
           [Util.option_map v.packed_policy_size
              (fun f ->
                 Ezxmlm.make_tag "PackedPolicySize" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the response to a successful <a>AssumeRole</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
module GetAccessKeyInfoResponse =
  struct
    type t =
      {
      account: String.t option
        [@ocaml.doc "<p>The number used to identify the AWS account.</p>"]}
    let make ?account  () = { account }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.account
              (fun f -> ("account", (String.to_json f)))])
    let parse xml =
      Some
        {
          account =
            (Util.option_bind (Xml.member "Account" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.account
              (fun f -> Ezxmlm.make_tag "Account" ([], (String.to_xml f)))])
  end
module GetSessionTokenResponse =
  struct
    type t =
      {
      credentials: Credentials.t option
        [@ocaml.doc
          "<p>The temporary security credentials, which include an access key ID, a secret access key, and a security (or session) token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>"]}
    [@@ocaml.doc
      "<p>Contains the response to a successful <a>GetSessionToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
    let make ?credentials  () = { credentials }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.credentials
              (fun f -> ("credentials", (Credentials.to_json f)))])
    let parse xml =
      Some
        {
          credentials =
            (Util.option_bind (Xml.member "Credentials" xml)
               Credentials.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.credentials
              (fun f ->
                 Ezxmlm.make_tag "Credentials" ([], (Credentials.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the response to a successful <a>GetSessionToken</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
module AssumeRoleWithWebIdentityResponse =
  struct
    type t =
      {
      credentials: Credentials.t option
        [@ocaml.doc
          "<p>The temporary security credentials, which include an access key ID, a secret access key, and a security token.</p> <note> <p>The size of the security token that STS API operations return is not fixed. We strongly recommend that you make no assumptions about the maximum size.</p> </note>"];
      subject_from_web_identity_token: String.t option
        [@ocaml.doc
          "<p>The unique user identifier that is returned by the identity provider. This identifier is associated with the <code>WebIdentityToken</code> that was submitted with the <code>AssumeRoleWithWebIdentity</code> call. The identifier is typically unique to the user and the application that acquired the <code>WebIdentityToken</code> (pairwise identifier). For OpenID Connect ID tokens, this field contains the value returned by the identity provider as the token's <code>sub</code> (Subject) claim. </p>"];
      assumed_role_user: AssumedRoleUser.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) and the assumed role ID, which are identifiers that you can use to refer to the resulting temporary security credentials. For example, you can reference these credentials as a principal in a resource-based policy by using the ARN or assumed role ID. The ARN and ID include the <code>RoleSessionName</code> that you specified when you called <code>AssumeRole</code>. </p>"];
      packed_policy_size: Integer.t option
        [@ocaml.doc
          "<p>A percentage value that indicates the packed size of the session policies and session tags combined passed in the request. The request fails if the packed size is greater than 100 percent, which means the policies and tags exceeded the allowed space.</p>"];
      provider: String.t option
        [@ocaml.doc
          "<p> The issuing authority of the web identity token presented. For OpenID Connect ID tokens, this contains the value of the <code>iss</code> field. For OAuth 2.0 access tokens, this contains the value of the <code>ProviderId</code> parameter that was passed in the <code>AssumeRoleWithWebIdentity</code> request.</p>"];
      audience: String.t option
        [@ocaml.doc
          "<p>The intended audience (also known as client ID) of the web identity token. This is traditionally the client identifier issued to the application that requested the web identity token.</p>"]}
    [@@ocaml.doc
      "<p>Contains the response to a successful <a>AssumeRoleWithWebIdentity</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
    let make ?credentials  ?subject_from_web_identity_token 
      ?assumed_role_user  ?packed_policy_size  ?provider  ?audience  () =
      {
        credentials;
        subject_from_web_identity_token;
        assumed_role_user;
        packed_policy_size;
        provider;
        audience
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.audience
              (fun f -> ("audience", (String.to_json f)));
           Util.option_map v.provider
             (fun f -> ("provider", (String.to_json f)));
           Util.option_map v.packed_policy_size
             (fun f -> ("packed_policy_size", (Integer.to_json f)));
           Util.option_map v.assumed_role_user
             (fun f -> ("assumed_role_user", (AssumedRoleUser.to_json f)));
           Util.option_map v.subject_from_web_identity_token
             (fun f ->
                ("subject_from_web_identity_token", (String.to_json f)));
           Util.option_map v.credentials
             (fun f -> ("credentials", (Credentials.to_json f)))])
    let parse xml =
      Some
        {
          credentials =
            (Util.option_bind (Xml.member "Credentials" xml)
               Credentials.parse);
          subject_from_web_identity_token =
            (Util.option_bind (Xml.member "SubjectFromWebIdentityToken" xml)
               String.parse);
          assumed_role_user =
            (Util.option_bind (Xml.member "AssumedRoleUser" xml)
               AssumedRoleUser.parse);
          packed_policy_size =
            (Util.option_bind (Xml.member "PackedPolicySize" xml)
               Integer.parse);
          provider =
            (Util.option_bind (Xml.member "Provider" xml) String.parse);
          audience =
            (Util.option_bind (Xml.member "Audience" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.credentials
                   (fun f ->
                      Ezxmlm.make_tag "Credentials"
                        ([], (Credentials.to_xml f)))])
               @
               [Util.option_map v.subject_from_web_identity_token
                  (fun f ->
                     Ezxmlm.make_tag "SubjectFromWebIdentityToken"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.assumed_role_user
                 (fun f ->
                    Ezxmlm.make_tag "AssumedRoleUser"
                      ([], (AssumedRoleUser.to_xml f)))])
             @
             [Util.option_map v.packed_policy_size
                (fun f ->
                   Ezxmlm.make_tag "PackedPolicySize"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.provider
               (fun f -> Ezxmlm.make_tag "Provider" ([], (String.to_xml f)))])
           @
           [Util.option_map v.audience
              (fun f -> Ezxmlm.make_tag "Audience" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the response to a successful <a>AssumeRoleWithWebIdentity</a> request, including temporary AWS credentials that can be used to make AWS requests. </p>"]
module GetCallerIdentityResponse =
  struct
    type t =
      {
      user_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier of the calling entity. The exact value depends on the type of entity that is making the call. The values returned are those listed in the <b>aws:userid</b> column in the <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html#principaltable\">Principal table</a> found on the <b>Policy Variables</b> reference page in the <i>IAM User Guide</i>.</p>"];
      account: String.t option
        [@ocaml.doc
          "<p>The AWS account ID number of the account that owns or contains the calling entity.</p>"];
      arn: String.t option
        [@ocaml.doc "<p>The AWS ARN associated with the calling entity.</p>"]}
    [@@ocaml.doc
      "<p>Contains the response to a successful <a>GetCallerIdentity</a> request, including information about the entity making the request.</p>"]
    let make ?user_id  ?account  ?arn  () = { user_id; account; arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.arn (fun f -> ("arn", (String.to_json f)));
           Util.option_map v.account
             (fun f -> ("account", (String.to_json f)));
           Util.option_map v.user_id
             (fun f -> ("user_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          user_id = (Util.option_bind (Xml.member "UserId" xml) String.parse);
          account =
            (Util.option_bind (Xml.member "Account" xml) String.parse);
          arn = (Util.option_bind (Xml.member "Arn" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.user_id
                (fun f -> Ezxmlm.make_tag "UserId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.account
               (fun f -> Ezxmlm.make_tag "Account" ([], (String.to_xml f)))])
           @
           [Util.option_map v.arn
              (fun f -> Ezxmlm.make_tag "Arn" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the response to a successful <a>GetCallerIdentity</a> request, including information about the entity making the request.</p>"]