open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyIdentityIdFormatRequest =
  struct
    type t =
      {
      principal_arn: String.t
        [@ocaml.doc
          "<p>The ARN of the principal, which can be an IAM user, IAM role, or the root user. Specify <code>all</code> to modify the ID format for all IAM users, IAM roles, and the root user of the account.</p>"];
      resource: String.t
        [@ocaml.doc
          "<p>The type of resource: <code>bundle</code> | <code>conversion-task</code> | <code>customer-gateway</code> | <code>dhcp-options</code> | <code>elastic-ip-allocation</code> | <code>elastic-ip-association</code> | <code>export-task</code> | <code>flow-log</code> | <code>image</code> | <code>import-task</code> | <code>internet-gateway</code> | <code>network-acl</code> | <code>network-acl-association</code> | <code>network-interface</code> | <code>network-interface-attachment</code> | <code>prefix-list</code> | <code>route-table</code> | <code>route-table-association</code> | <code>security-group</code> | <code>subnet</code> | <code>subnet-cidr-block-association</code> | <code>vpc</code> | <code>vpc-cidr-block-association</code> | <code>vpc-endpoint</code> | <code>vpc-peering-connection</code> | <code>vpn-connection</code> | <code>vpn-gateway</code>.</p> <p>Alternatively, use the <code>all-current</code> option to include all resource types that are currently within their opt-in period for longer IDs.</p>"];
      use_long_ids: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether the resource should use longer IDs (17-character IDs)</p>"]}
    let make ~principal_arn  ~resource  ~use_long_ids  () =
      { principal_arn; resource; use_long_ids }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair ("UseLongIds", (Boolean.to_query v.use_long_ids)));
           Some (Query.Pair ("Resource", (String.to_query v.resource)));
           Some
             (Query.Pair ("PrincipalArn", (String.to_query v.principal_arn)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("use_long_ids", (Boolean.to_json v.use_long_ids));
           Some ("resource", (String.to_json v.resource));
           Some ("principal_arn", (String.to_json v.principal_arn))])
    let parse xml =
      Some
        {
          principal_arn =
            (Xml.required "principalArn"
               (Util.option_bind (Xml.member "principalArn" xml) String.parse));
          resource =
            (Xml.required "resource"
               (Util.option_bind (Xml.member "resource" xml) String.parse));
          use_long_ids =
            (Xml.required "useLongIds"
               (Util.option_bind (Xml.member "useLongIds" xml) Boolean.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "principalArn"
                   ([], (String.to_xml v.principal_arn)))])
            @
            [Some
               (Ezxmlm.make_tag "resource" ([], (String.to_xml v.resource)))])
           @
           [Some
              (Ezxmlm.make_tag "useLongIds"
                 ([], (Boolean.to_xml v.use_long_ids)))])
  end
module Output = Aws.BaseTypes.Unit
type input = ModifyIdentityIdFormatRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["ModifyIdentityIdFormat"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyIdentityIdFormatRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyIdentityIdFormatRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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