open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RevokeCacheSecurityGroupIngressMessage =
  struct
    type t =
      {
      cache_security_group_name: String.t
        [@ocaml.doc
          "<p>The name of the cache security group to revoke ingress from.</p>"];
      e_c2_security_group_name: String.t
        [@ocaml.doc
          "<p>The name of the Amazon EC2 security group to revoke access from.</p>"];
      e_c2_security_group_owner_id: String.t
        [@ocaml.doc
          "<p>The AWS account number of the Amazon EC2 security group owner. Note that this is not the same thing as an AWS access key ID - you must provide a valid AWS account number for this parameter.</p>"]}
    [@@ocaml.doc
      "<p>Represents the input of a <code>RevokeCacheSecurityGroupIngress</code> operation.</p>"]
    let make ~cache_security_group_name  ~e_c2_security_group_name 
      ~e_c2_security_group_owner_id  () =
      {
        cache_security_group_name;
        e_c2_security_group_name;
        e_c2_security_group_owner_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("e_c2_security_group_owner_id",
                (String.to_json v.e_c2_security_group_owner_id));
           Some
             ("e_c2_security_group_name",
               (String.to_json v.e_c2_security_group_name));
           Some
             ("cache_security_group_name",
               (String.to_json v.cache_security_group_name))])
    let parse xml =
      Some
        {
          cache_security_group_name =
            (Xml.required "CacheSecurityGroupName"
               (Util.option_bind (Xml.member "CacheSecurityGroupName" xml)
                  String.parse));
          e_c2_security_group_name =
            (Xml.required "EC2SecurityGroupName"
               (Util.option_bind (Xml.member "EC2SecurityGroupName" xml)
                  String.parse));
          e_c2_security_group_owner_id =
            (Xml.required "EC2SecurityGroupOwnerId"
               (Util.option_bind (Xml.member "EC2SecurityGroupOwnerId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "CacheSecurityGroupName"
                   ([], (String.to_xml v.cache_security_group_name)))])
            @
            [Some
               (Ezxmlm.make_tag "EC2SecurityGroupName"
                  ([], (String.to_xml v.e_c2_security_group_name)))])
           @
           [Some
              (Ezxmlm.make_tag "EC2SecurityGroupOwnerId"
                 ([], (String.to_xml v.e_c2_security_group_owner_id)))])
  end[@@ocaml.doc
       "<p>Represents the input of a <code>RevokeCacheSecurityGroupIngress</code> operation.</p>"]
module RevokeCacheSecurityGroupIngressResult =
  RevokeCacheSecurityGroupIngressResult
type input = RevokeCacheSecurityGroupIngressMessage.t
type output = RevokeCacheSecurityGroupIngressResult.t
type error = Errors_internal.t
let streaming = false
let service = "elasticache"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2015-02-02"]);
         ("Action", ["RevokeCacheSecurityGroupIngress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (RevokeCacheSecurityGroupIngressMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RevokeCacheSecurityGroupIngressMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RevokeCacheSecurityGroupIngressResponse" (snd xml))
        (Xml.member "RevokeCacheSecurityGroupIngressResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RevokeCacheSecurityGroupIngressResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RevokeCacheSecurityGroupIngressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RevokeCacheSecurityGroupIngressResult - missing field in body or children: "
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