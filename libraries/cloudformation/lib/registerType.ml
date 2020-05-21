open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RegisterTypeInput =
  struct
    type t =
      {
      type_: RegistryType.t option
        [@ocaml.doc
          "<p>The kind of type.</p> <p>Currently, the only valid value is <code>RESOURCE</code>.</p>"];
      type_name: String.t
        [@ocaml.doc
          "<p>The name of the type being registered.</p> <p>We recommend that type names adhere to the following pattern: <i>company_or_organization</i>::<i>service</i>::<i>type</i>.</p> <note> <p>The following organization namespaces are reserved and cannot be used in your resource type names:</p> <ul> <li> <p> <code>Alexa</code> </p> </li> <li> <p> <code>AMZN</code> </p> </li> <li> <p> <code>Amazon</code> </p> </li> <li> <p> <code>AWS</code> </p> </li> <li> <p> <code>Custom</code> </p> </li> <li> <p> <code>Dev</code> </p> </li> </ul> </note>"];
      schema_handler_package: String.t
        [@ocaml.doc
          "<p>A url to the S3 bucket containing the schema handler package that contains the schema, event handlers, and associated files for the type you want to register.</p> <p>For information on generating a schema handler package for the type you want to register, see <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-cli-submit.html\">submit</a> in the <i>CloudFormation CLI User Guide</i>.</p>"];
      logging_config: LoggingConfig.t option
        [@ocaml.doc
          "<p>Specifies logging configuration information for a type.</p>"];
      execution_role_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM execution role to use to register the type. If your resource type calls AWS APIs in any of its handlers, you must create an <i> <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html\">IAM execution role</a> </i> that includes the necessary permissions to call those AWS APIs, and provision that execution role in your account. CloudFormation then assumes that execution role to provide your resource type with the appropriate credentials.</p>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>A unique identifier that acts as an idempotency key for this registration request. Specifying a client request token prevents CloudFormation from generating more than one version of a type from the same registeration request, even if the request is submitted multiple times. </p>"]}
    let make ?type_  ~type_name  ~schema_handler_package  ?logging_config 
      ?execution_role_arn  ?client_request_token  () =
      {
        type_;
        type_name;
        schema_handler_package;
        logging_config;
        execution_role_arn;
        client_request_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Util.option_map v.execution_role_arn
             (fun f -> ("execution_role_arn", (String.to_json f)));
           Util.option_map v.logging_config
             (fun f -> ("logging_config", (LoggingConfig.to_json f)));
           Some
             ("schema_handler_package",
               (String.to_json v.schema_handler_package));
           Some ("type_name", (String.to_json v.type_name));
           Util.option_map v.type_
             (fun f -> ("type_", (RegistryType.to_json f)))])
    let parse xml =
      Some
        {
          type_ =
            (Util.option_bind (Xml.member "Type" xml) RegistryType.parse);
          type_name =
            (Xml.required "TypeName"
               (Util.option_bind (Xml.member "TypeName" xml) String.parse));
          schema_handler_package =
            (Xml.required "SchemaHandlerPackage"
               (Util.option_bind (Xml.member "SchemaHandlerPackage" xml)
                  String.parse));
          logging_config =
            (Util.option_bind (Xml.member "LoggingConfig" xml)
               LoggingConfig.parse);
          execution_role_arn =
            (Util.option_bind (Xml.member "ExecutionRoleArn" xml)
               String.parse);
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.type_
                   (fun f ->
                      Ezxmlm.make_tag "Type" ([], (RegistryType.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "TypeName"
                     ([], (String.to_xml v.type_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "SchemaHandlerPackage"
                    ([], (String.to_xml v.schema_handler_package)))])
             @
             [Util.option_map v.logging_config
                (fun f ->
                   Ezxmlm.make_tag "LoggingConfig"
                     ([], (LoggingConfig.to_xml f)))])
            @
            [Util.option_map v.execution_role_arn
               (fun f ->
                  Ezxmlm.make_tag "ExecutionRoleArn" ([], (String.to_xml f)))])
           @
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end
module RegisterTypeOutput = RegisterTypeOutput
type input = RegisterTypeInput.t
type output = RegisterTypeOutput.t
type error = Errors_internal.t
let streaming = false
let service = "cloudformation"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-05-15"]); ("Action", ["RegisterType"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RegisterTypeInput.to_query req))))) in
  (`POST, uri, (Headers.render (RegisterTypeInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "RegisterTypeResponse" (snd xml))
        (Xml.member "RegisterTypeResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp RegisterTypeOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed RegisterTypeOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RegisterTypeOutput - missing field in body or children: "
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