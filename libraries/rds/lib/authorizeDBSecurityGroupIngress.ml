open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AuthorizeDBSecurityGroupIngressMessage =
  struct
    type t =
      {
      d_b_security_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB security group to add authorization to.</p>"];
      c_i_d_r_i_p: String.t option
        [@ocaml.doc "<p>The IP range to authorize.</p>"];
      e_c2_security_group_name: String.t option
        [@ocaml.doc
          "<p> Name of the EC2 security group to authorize. For VPC DB security groups, <code>EC2SecurityGroupId</code> must be provided. Otherwise, <code>EC2SecurityGroupOwnerId</code> and either <code>EC2SecurityGroupName</code> or <code>EC2SecurityGroupId</code> must be provided. </p>"];
      e_c2_security_group_id: String.t option
        [@ocaml.doc
          "<p> Id of the EC2 security group to authorize. For VPC DB security groups, <code>EC2SecurityGroupId</code> must be provided. Otherwise, <code>EC2SecurityGroupOwnerId</code> and either <code>EC2SecurityGroupName</code> or <code>EC2SecurityGroupId</code> must be provided. </p>"];
      e_c2_security_group_owner_id: String.t option
        [@ocaml.doc
          "<p> AWS account number of the owner of the EC2 security group specified in the <code>EC2SecurityGroupName</code> parameter. The AWS access key ID isn't an acceptable value. For VPC DB security groups, <code>EC2SecurityGroupId</code> must be provided. Otherwise, <code>EC2SecurityGroupOwnerId</code> and either <code>EC2SecurityGroupName</code> or <code>EC2SecurityGroupId</code> must be provided. </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_security_group_name  ?c_i_d_r_i_p 
      ?e_c2_security_group_name  ?e_c2_security_group_id 
      ?e_c2_security_group_owner_id  () =
      {
        d_b_security_group_name;
        c_i_d_r_i_p;
        e_c2_security_group_name;
        e_c2_security_group_id;
        e_c2_security_group_owner_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f -> ("e_c2_security_group_owner_id", (String.to_json f)));
           Util.option_map v.e_c2_security_group_id
             (fun f -> ("e_c2_security_group_id", (String.to_json f)));
           Util.option_map v.e_c2_security_group_name
             (fun f -> ("e_c2_security_group_name", (String.to_json f)));
           Util.option_map v.c_i_d_r_i_p
             (fun f -> ("c_i_d_r_i_p", (String.to_json f)));
           Some
             ("d_b_security_group_name",
               (String.to_json v.d_b_security_group_name))])
    let parse xml =
      Some
        {
          d_b_security_group_name =
            (Xml.required "DBSecurityGroupName"
               (Util.option_bind (Xml.member "DBSecurityGroupName" xml)
                  String.parse));
          c_i_d_r_i_p =
            (Util.option_bind (Xml.member "CIDRIP" xml) String.parse);
          e_c2_security_group_name =
            (Util.option_bind (Xml.member "EC2SecurityGroupName" xml)
               String.parse);
          e_c2_security_group_id =
            (Util.option_bind (Xml.member "EC2SecurityGroupId" xml)
               String.parse);
          e_c2_security_group_owner_id =
            (Util.option_bind (Xml.member "EC2SecurityGroupOwnerId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "DBSecurityGroupName"
                     ([], (String.to_xml v.d_b_security_group_name)))])
              @
              [Util.option_map v.c_i_d_r_i_p
                 (fun f -> Ezxmlm.make_tag "CIDRIP" ([], (String.to_xml f)))])
             @
             [Util.option_map v.e_c2_security_group_name
                (fun f ->
                   Ezxmlm.make_tag "EC2SecurityGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.e_c2_security_group_id
               (fun f ->
                  Ezxmlm.make_tag "EC2SecurityGroupId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f ->
                 Ezxmlm.make_tag "EC2SecurityGroupOwnerId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module AuthorizeDBSecurityGroupIngressResult =
  AuthorizeDBSecurityGroupIngressResult
type input = AuthorizeDBSecurityGroupIngressMessage.t
type output = AuthorizeDBSecurityGroupIngressResult.t
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
         ("Action", ["AuthorizeDBSecurityGroupIngress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (AuthorizeDBSecurityGroupIngressMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (AuthorizeDBSecurityGroupIngressMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "AuthorizeDBSecurityGroupIngressResponse" (snd xml))
        (Xml.member "AuthorizeDBSecurityGroupIngressResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AuthorizeDBSecurityGroupIngressResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AuthorizeDBSecurityGroupIngressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AuthorizeDBSecurityGroupIngressResult - missing field in body or children: "
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