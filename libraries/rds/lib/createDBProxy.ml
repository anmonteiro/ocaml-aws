open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateDBProxyRequest =
  struct
    type t =
      {
      d_b_proxy_name: String.t
        [@ocaml.doc
          "<p>The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens.</p>"];
      engine_family: EngineFamily.t
        [@ocaml.doc
          "<p>The kinds of databases that the proxy can connect to. This value determines which database network protocol the proxy recognizes when it interprets network traffic to and from the database. Currently, this value is always <code>MYSQL</code>. The engine family applies to both RDS MySQL and Aurora MySQL.</p>"];
      auth: UserAuthConfigList.t
        [@ocaml.doc
          "<p>The authorization mechanism that the proxy uses.</p>"];
      role_arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access secrets in AWS Secrets Manager.</p>"];
      vpc_subnet_ids: StringList.t
        [@ocaml.doc
          "<p>One or more VPC subnet IDs to associate with the new proxy.</p>"];
      vpc_security_group_ids: StringList.t
        [@ocaml.doc
          "<p>One or more VPC security group IDs to associate with the new proxy.</p>"];
      require_t_l_s: Boolean.t option
        [@ocaml.doc
          "<p>A Boolean parameter that specifies whether Transport Layer Security (TLS) encryption is required for connections to the proxy. By enabling this setting, you can enforce encrypted TLS connections to the proxy.</p>"];
      idle_client_timeout: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds that a connection to the proxy can be inactive before the proxy disconnects it. You can set this value higher or lower than the connection timeout limit for the associated database.</p>"];
      debug_logging: Boolean.t option
        [@ocaml.doc
          "<p>Whether the proxy includes detailed information about SQL statements in its logs. This information helps you to debug issues involving SQL behavior or the performance and scalability of the proxy connections. The debug information includes the text of SQL statements that you submit through the proxy. Thus, only enable this setting when needed for debugging, and only when you have security measures in place to safeguard any sensitive information that appears in the logs.</p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>An optional set of key-value pairs to associate arbitrary data of your choosing with the proxy.</p>"]}
    let make ~d_b_proxy_name  ~engine_family  ~auth  ~role_arn 
      ~vpc_subnet_ids  ?(vpc_security_group_ids= [])  ?require_t_l_s 
      ?idle_client_timeout  ?debug_logging  ?(tags= [])  () =
      {
        d_b_proxy_name;
        engine_family;
        auth;
        role_arn;
        vpc_subnet_ids;
        vpc_security_group_ids;
        require_t_l_s;
        idle_client_timeout;
        debug_logging;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.debug_logging
             (fun f -> ("debug_logging", (Boolean.to_json f)));
           Util.option_map v.idle_client_timeout
             (fun f -> ("idle_client_timeout", (Integer.to_json f)));
           Util.option_map v.require_t_l_s
             (fun f -> ("require_t_l_s", (Boolean.to_json f)));
           Some
             ("vpc_security_group_ids",
               (StringList.to_json v.vpc_security_group_ids));
           Some ("vpc_subnet_ids", (StringList.to_json v.vpc_subnet_ids));
           Some ("role_arn", (String.to_json v.role_arn));
           Some ("auth", (UserAuthConfigList.to_json v.auth));
           Some ("engine_family", (EngineFamily.to_json v.engine_family));
           Some ("d_b_proxy_name", (String.to_json v.d_b_proxy_name))])
    let parse xml =
      Some
        {
          d_b_proxy_name =
            (Xml.required "DBProxyName"
               (Util.option_bind (Xml.member "DBProxyName" xml) String.parse));
          engine_family =
            (Xml.required "EngineFamily"
               (Util.option_bind (Xml.member "EngineFamily" xml)
                  EngineFamily.parse));
          auth =
            (Xml.required "Auth"
               (Util.option_bind (Xml.member "Auth" xml)
                  UserAuthConfigList.parse));
          role_arn =
            (Xml.required "RoleArn"
               (Util.option_bind (Xml.member "RoleArn" xml) String.parse));
          vpc_subnet_ids =
            (Xml.required "VpcSubnetIds"
               (Util.option_bind (Xml.member "VpcSubnetIds" xml)
                  StringList.parse));
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  StringList.parse));
          require_t_l_s =
            (Util.option_bind (Xml.member "RequireTLS" xml) Boolean.parse);
          idle_client_timeout =
            (Util.option_bind (Xml.member "IdleClientTimeout" xml)
               Integer.parse);
          debug_logging =
            (Util.option_bind (Xml.member "DebugLogging" xml) Boolean.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "DBProxyName"
                          ([], (String.to_xml v.d_b_proxy_name)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "EngineFamily"
                         ([], (EngineFamily.to_xml v.engine_family)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "Auth"
                             ([], (UserAuthConfigList.to_xml [x])))) v.auth))
                 @
                 [Some
                    (Ezxmlm.make_tag "RoleArn"
                       ([], (String.to_xml v.role_arn)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "VpcSubnetIds"
                           ([], (StringList.to_xml [x])))) v.vpc_subnet_ids))
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "VpcSecurityGroupIds"
                          ([], (StringList.to_xml [x]))))
                  v.vpc_security_group_ids))
              @
              [Util.option_map v.require_t_l_s
                 (fun f ->
                    Ezxmlm.make_tag "RequireTLS" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.idle_client_timeout
                (fun f ->
                   Ezxmlm.make_tag "IdleClientTimeout"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.debug_logging
               (fun f ->
                  Ezxmlm.make_tag "DebugLogging" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
              v.tags))
  end
module CreateDBProxyResponse = CreateDBProxyResponse
type input = CreateDBProxyRequest.t
type output = CreateDBProxyResponse.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["CreateDBProxy"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateDBProxyRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateDBProxyRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "CreateDBProxyResponse" (snd xml))
        (Xml.member "CreateDBProxyResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateDBProxyResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateDBProxyResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateDBProxyResponse - missing field in body or children: "
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