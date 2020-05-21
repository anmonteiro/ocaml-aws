open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBProxyRequest =
  struct
    type t =
      {
      d_b_proxy_name: String.t
        [@ocaml.doc
          "<p>The identifier for the <code>DBProxy</code> to modify.</p>"];
      new_d_b_proxy_name: String.t option
        [@ocaml.doc
          "<p>The new identifier for the <code>DBProxy</code>. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens.</p>"];
      auth: UserAuthConfigList.t
        [@ocaml.doc
          "<p>The new authentication settings for the <code>DBProxy</code>.</p>"];
      require_t_l_s: Boolean.t option
        [@ocaml.doc
          "<p>Whether Transport Layer Security (TLS) encryption is required for connections to the proxy. By enabling this setting, you can enforce encrypted TLS connections to the proxy, even if the associated database doesn't use TLS.</p>"];
      idle_client_timeout: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds that a connection to the proxy can be inactive before the proxy disconnects it. You can set this value higher or lower than the connection timeout limit for the associated database.</p>"];
      debug_logging: Boolean.t option
        [@ocaml.doc
          "<p>Whether the proxy includes detailed information about SQL statements in its logs. This information helps you to debug issues involving SQL behavior or the performance and scalability of the proxy connections. The debug information includes the text of SQL statements that you submit through the proxy. Thus, only enable this setting when needed for debugging, and only when you have security measures in place to safeguard any sensitive information that appears in the logs.</p>"];
      role_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access secrets in AWS Secrets Manager.</p>"];
      security_groups: StringList.t
        [@ocaml.doc
          "<p>The new list of security groups for the <code>DBProxy</code>.</p>"]}
    let make ~d_b_proxy_name  ?new_d_b_proxy_name  ?(auth= []) 
      ?require_t_l_s  ?idle_client_timeout  ?debug_logging  ?role_arn 
      ?(security_groups= [])  () =
      {
        d_b_proxy_name;
        new_d_b_proxy_name;
        auth;
        require_t_l_s;
        idle_client_timeout;
        debug_logging;
        role_arn;
        security_groups
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("security_groups", (StringList.to_json v.security_groups));
           Util.option_map v.role_arn
             (fun f -> ("role_arn", (String.to_json f)));
           Util.option_map v.debug_logging
             (fun f -> ("debug_logging", (Boolean.to_json f)));
           Util.option_map v.idle_client_timeout
             (fun f -> ("idle_client_timeout", (Integer.to_json f)));
           Util.option_map v.require_t_l_s
             (fun f -> ("require_t_l_s", (Boolean.to_json f)));
           Some ("auth", (UserAuthConfigList.to_json v.auth));
           Util.option_map v.new_d_b_proxy_name
             (fun f -> ("new_d_b_proxy_name", (String.to_json f)));
           Some ("d_b_proxy_name", (String.to_json v.d_b_proxy_name))])
    let parse xml =
      Some
        {
          d_b_proxy_name =
            (Xml.required "DBProxyName"
               (Util.option_bind (Xml.member "DBProxyName" xml) String.parse));
          new_d_b_proxy_name =
            (Util.option_bind (Xml.member "NewDBProxyName" xml) String.parse);
          auth =
            (Util.of_option []
               (Util.option_bind (Xml.member "Auth" xml)
                  UserAuthConfigList.parse));
          require_t_l_s =
            (Util.option_bind (Xml.member "RequireTLS" xml) Boolean.parse);
          idle_client_timeout =
            (Util.option_bind (Xml.member "IdleClientTimeout" xml)
               Integer.parse);
          debug_logging =
            (Util.option_bind (Xml.member "DebugLogging" xml) Boolean.parse);
          role_arn =
            (Util.option_bind (Xml.member "RoleArn" xml) String.parse);
          security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "SecurityGroups" xml)
                  StringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "DBProxyName"
                        ([], (String.to_xml v.d_b_proxy_name)))])
                 @
                 [Util.option_map v.new_d_b_proxy_name
                    (fun f ->
                       Ezxmlm.make_tag "NewDBProxyName"
                         ([], (String.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "Auth"
                           ([], (UserAuthConfigList.to_xml [x])))) v.auth))
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
            [Util.option_map v.role_arn
               (fun f -> Ezxmlm.make_tag "RoleArn" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SecurityGroups"
                      ([], (StringList.to_xml [x])))) v.security_groups))
  end
module ModifyDBProxyResponse = ModifyDBProxyResponse
type input = ModifyDBProxyRequest.t
type output = ModifyDBProxyResponse.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ModifyDBProxy"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBProxyRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyDBProxyRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ModifyDBProxyResponse" (snd xml))
        (Xml.member "ModifyDBProxyResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyDBProxyResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ModifyDBProxyResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBProxyResponse - missing field in body or children: "
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