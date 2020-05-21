open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBProxyTargetGroupRequest =
  struct
    type t =
      {
      target_group_name: String.t
        [@ocaml.doc
          "<p>The name of the new target group to assign to the proxy.</p>"];
      d_b_proxy_name: String.t
        [@ocaml.doc
          "<p>The name of the new proxy to which to assign the target group.</p>"];
      connection_pool_config: ConnectionPoolConfiguration.t option
        [@ocaml.doc
          "<p>The settings that determine the size and behavior of the connection pool for the target group.</p>"];
      new_name: String.t option
        [@ocaml.doc
          "<p>The new name for the modified <code>DBProxyTarget</code>. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens.</p>"]}
    let make ~target_group_name  ~d_b_proxy_name  ?connection_pool_config 
      ?new_name  () =
      { target_group_name; d_b_proxy_name; connection_pool_config; new_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.new_name
              (fun f -> ("new_name", (String.to_json f)));
           Util.option_map v.connection_pool_config
             (fun f ->
                ("connection_pool_config",
                  (ConnectionPoolConfiguration.to_json f)));
           Some ("d_b_proxy_name", (String.to_json v.d_b_proxy_name));
           Some ("target_group_name", (String.to_json v.target_group_name))])
    let parse xml =
      Some
        {
          target_group_name =
            (Xml.required "TargetGroupName"
               (Util.option_bind (Xml.member "TargetGroupName" xml)
                  String.parse));
          d_b_proxy_name =
            (Xml.required "DBProxyName"
               (Util.option_bind (Xml.member "DBProxyName" xml) String.parse));
          connection_pool_config =
            (Util.option_bind (Xml.member "ConnectionPoolConfig" xml)
               ConnectionPoolConfiguration.parse);
          new_name =
            (Util.option_bind (Xml.member "NewName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "TargetGroupName"
                    ([], (String.to_xml v.target_group_name)))])
             @
             [Some
                (Ezxmlm.make_tag "DBProxyName"
                   ([], (String.to_xml v.d_b_proxy_name)))])
            @
            [Util.option_map v.connection_pool_config
               (fun f ->
                  Ezxmlm.make_tag "ConnectionPoolConfig"
                    ([], (ConnectionPoolConfiguration.to_xml f)))])
           @
           [Util.option_map v.new_name
              (fun f -> Ezxmlm.make_tag "NewName" ([], (String.to_xml f)))])
  end
module ModifyDBProxyTargetGroupResponse = ModifyDBProxyTargetGroupResponse
type input = ModifyDBProxyTargetGroupRequest.t
type output = ModifyDBProxyTargetGroupResponse.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["ModifyDBProxyTargetGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBProxyTargetGroupRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyDBProxyTargetGroupRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyDBProxyTargetGroupResponse" (snd xml))
        (Xml.member "ModifyDBProxyTargetGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ModifyDBProxyTargetGroupResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyDBProxyTargetGroupResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyDBProxyTargetGroupResponse - missing field in body or children: "
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