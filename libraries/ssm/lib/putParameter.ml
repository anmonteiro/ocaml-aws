open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutParameterRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The fully qualified name of the parameter that you want to add to the system. The fully qualified name includes the complete hierarchy of the parameter path and name. For example: <code>/Dev/DBServer/MySQL/db-string13</code> </p> <p>Naming Constraints:</p> <ul> <li> <p>Parameter names are case sensitive.</p> </li> <li> <p>A parameter name must be unique within an AWS Region</p> </li> <li> <p>A parameter name can't be prefixed with \"aws\" or \"ssm\" (case-insensitive).</p> </li> <li> <p>Parameter names can include only the following symbols and letters: <code>a-zA-Z0-9_.-/</code> </p> </li> <li> <p>A parameter name can't include spaces.</p> </li> <li> <p>Parameter hierarchies are limited to a maximum depth of fifteen levels.</p> </li> </ul> <p>For additional information about valid values for parameter names, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-parameter-name-constraints.html\">Requirements and Constraints for Parameter Names</a> in the <i>AWS Systems Manager User Guide</i>.</p> <note> <p>The maximum length constraint listed below includes capacity for additional system attributes that are not part of the name. The maximum length for the fully qualified parameter name is 1011 characters, including the full length of the parameter ARN. For example, the following fully qualified parameter name is 65 characters, not 20 characters:</p> <p> <code>arn:aws:ssm:us-east-2:111122223333:parameter/ExampleParameterName</code> </p> </note>"];
      description: String.t option
        [@ocaml.doc
          "<p>Information about the parameter that you want to add to the system. Optional but recommended.</p> <important> <p>Do not enter personally identifiable information in this field.</p> </important>"];
      value: String.t
        [@ocaml.doc
          "<p>The parameter value that you want to add to the system. Standard parameters have a value limit of 4 KB. Advanced parameters have a value limit of 8 KB.</p>"];
      type_: ParameterType.t
        [@ocaml.doc
          "<p>The type of parameter that you want to add to the system.</p> <p>Items in a <code>StringList</code> must be separated by a comma (,). You can't use other punctuation or special character to escape items in the list. If you have a parameter value that requires a comma, then use the <code>String</code> data type.</p> <note> <p> <code>SecureString</code> is not currently supported for AWS CloudFormation templates or in the China Regions.</p> </note>"];
      key_id: String.t option
        [@ocaml.doc
          "<p>The KMS Key ID that you want to use to encrypt a parameter. Either the default AWS Key Management Service (AWS KMS) key automatically assigned to your AWS account or a custom key. Required for parameters that use the <code>SecureString</code> data type.</p> <p>If you don't specify a key ID, the system uses the default key associated with your AWS account.</p> <ul> <li> <p>To use your default AWS KMS key, choose the <code>SecureString</code> data type, and do <i>not</i> specify the <code>Key ID</code> when you create the parameter. The system automatically populates <code>Key ID</code> with your default KMS key.</p> </li> <li> <p>To use a custom KMS key, choose the <code>SecureString</code> data type with the <code>Key ID</code> parameter.</p> </li> </ul>"];
      overwrite: Boolean.t option
        [@ocaml.doc
          "<p>Overwrite an existing parameter. If not specified, will default to \"false\".</p>"];
      allowed_pattern: String.t option
        [@ocaml.doc
          "<p>A regular expression used to validate the parameter value. For example, for String types with values restricted to numbers, you can specify the following: AllowedPattern=^\\d+$ </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>Optional metadata that you assign to a resource. Tags enable you to categorize a resource in different ways, such as by purpose, owner, or environment. For example, you might want to tag a Systems Manager parameter to identify the type of resource to which it applies, the environment, or the type of configuration data referenced by the parameter. In this case, you could specify the following key name/value pairs:</p> <ul> <li> <p> <code>Key=Resource,Value=S3bucket</code> </p> </li> <li> <p> <code>Key=OS,Value=Windows</code> </p> </li> <li> <p> <code>Key=ParameterType,Value=LicenseKey</code> </p> </li> </ul> <note> <p>To add tags to an existing Systems Manager parameter, use the <a>AddTagsToResource</a> action.</p> </note>"];
      tier: ParameterTier.t option
        [@ocaml.doc
          "<p>The parameter tier to assign to a parameter.</p> <p>Parameter Store offers a standard tier and an advanced tier for parameters. Standard parameters have a content size limit of 4 KB and can't be configured to use parameter policies. You can create a maximum of 10,000 standard parameters for each Region in an AWS account. Standard parameters are offered at no additional cost. </p> <p>Advanced parameters have a content size limit of 8 KB and can be configured to use parameter policies. You can create a maximum of 100,000 advanced parameters for each Region in an AWS account. Advanced parameters incur a charge. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html\">About Advanced Parameters</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>You can change a standard parameter to an advanced parameter any time. But you can't revert an advanced parameter to a standard parameter. Reverting an advanced parameter to a standard parameter would result in data loss because the system would truncate the size of the parameter from 8 KB to 4 KB. Reverting would also remove any policies attached to the parameter. Lastly, advanced parameters use a different form of encryption than standard parameters. </p> <p>If you no longer need an advanced parameter, or if you no longer want to incur charges for an advanced parameter, you must delete it and recreate it as a new standard parameter. </p> <p> <b>Using the Default Tier Configuration</b> </p> <p>In <code>PutParameter</code> requests, you can specify the tier to create the parameter in. Whenever you specify a tier in the request, Parameter Store creates or updates the parameter according to that request. However, if you do not specify a tier in a request, Parameter Store assigns the tier based on the current Parameter Store default tier configuration.</p> <p>The default tier when you begin using Parameter Store is the standard-parameter tier. If you use the advanced-parameter tier, you can specify one of the following as the default:</p> <ul> <li> <p> <b>Advanced</b>: With this option, Parameter Store evaluates all requests as advanced parameters. </p> </li> <li> <p> <b>Intelligent-Tiering</b>: With this option, Parameter Store evaluates each request to determine if the parameter is standard or advanced. </p> <p>If the request doesn't include any options that require an advanced parameter, the parameter is created in the standard-parameter tier. If one or more options requiring an advanced parameter are included in the request, Parameter Store create a parameter in the advanced-parameter tier.</p> <p>This approach helps control your parameter-related costs by always creating standard parameters unless an advanced parameter is necessary. </p> </li> </ul> <p>Options that require an advanced parameter include the following:</p> <ul> <li> <p>The content size of the parameter is more than 4 KB.</p> </li> <li> <p>The parameter uses a parameter policy.</p> </li> <li> <p>More than 10,000 parameters already exist in your AWS account in the current Region.</p> </li> </ul> <p>For more information about configuring the default tier option, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/ps-default-tier.html\">Specifying a Default Parameter Tier</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      policies: String.t option
        [@ocaml.doc
          "<p>One or more policies to apply to a parameter. This action takes a JSON array. Parameter Store supports the following policy types:</p> <p>Expiration: This policy deletes the parameter after it expires. When you create the policy, you specify the expiration date. You can update the expiration date and time by updating the policy. Updating the <i>parameter</i> does not affect the expiration date and time. When the expiration time is reached, Parameter Store deletes the parameter.</p> <p>ExpirationNotification: This policy triggers an event in Amazon CloudWatch Events that notifies you about the expiration. By using this policy, you can receive notification before or after the expiration time is reached, in units of days or hours.</p> <p>NoChangeNotification: This policy triggers a CloudWatch event if a parameter has not been modified for a specified period of time. This policy type is useful when, for example, a secret needs to be changed within a period of time, but it has not been changed.</p> <p>All existing policies are preserved until you send new policies or an empty policy. For more information about parameter policies, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-su-policies.html\">Working with Parameter Policies</a>. </p>"]}
    let make ~name  ?description  ~value  ~type_  ?key_id  ?overwrite 
      ?allowed_pattern  ?(tags= [])  ?tier  ?policies  () =
      {
        name;
        description;
        value;
        type_;
        key_id;
        overwrite;
        allowed_pattern;
        tags;
        tier;
        policies
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.policies
              (fun f -> ("policies", (String.to_json f)));
           Util.option_map v.tier
             (fun f -> ("tier", (ParameterTier.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.allowed_pattern
             (fun f -> ("allowed_pattern", (String.to_json f)));
           Util.option_map v.overwrite
             (fun f -> ("overwrite", (Boolean.to_json f)));
           Util.option_map v.key_id (fun f -> ("key_id", (String.to_json f)));
           Some ("type_", (ParameterType.to_json v.type_));
           Some ("value", (String.to_json v.value));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")));
        type_ =
          (ParameterType.of_json (Util.of_option_exn (Json.lookup j "type_")));
        key_id = (Util.option_map (Json.lookup j "key_id") String.of_json);
        overwrite =
          (Util.option_map (Json.lookup j "overwrite") Boolean.of_json);
        allowed_pattern =
          (Util.option_map (Json.lookup j "allowed_pattern") String.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")));
        tier = (Util.option_map (Json.lookup j "tier") ParameterTier.of_json);
        policies =
          (Util.option_map (Json.lookup j "policies") String.of_json)
      }
  end
module PutParameterResult = PutParameterResult
type input = PutParameterRequest.t
type output = PutParameterResult.t
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (PutParameterRequest.to_query req)))) in
  (`POST, uri, (Headers.render (PutParameterRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (PutParameterResult.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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