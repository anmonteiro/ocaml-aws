open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateSecurityGroupRuleDescriptionsIngressRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      group_id: String.t option
        [@ocaml.doc
          "<p>The ID of the security group. You must specify either the security group ID or the security group name in the request. For security groups in a nondefault VPC, you must specify the security group ID.</p>"];
      group_name: String.t option
        [@ocaml.doc
          "<p>[EC2-Classic, default VPC] The name of the security group. You must specify either the security group ID or the security group name in the request.</p>"];
      ip_permissions: IpPermissionList.t
        [@ocaml.doc
          "<p>The IP permissions for the security group rule. </p>"]}
    let make ?dry_run  ?group_id  ?group_name  ~ip_permissions  () =
      { dry_run; group_id; group_name; ip_permissions }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("IpPermissions",
                   (IpPermissionList.to_query v.ip_permissions)));
           Util.option_map v.group_name
             (fun f -> Query.Pair ("GroupName", (String.to_query f)));
           Util.option_map v.group_id
             (fun f -> Query.Pair ("GroupId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("ip_permissions", (IpPermissionList.to_json v.ip_permissions));
           Util.option_map v.group_name
             (fun f -> ("group_name", (String.to_json f)));
           Util.option_map v.group_id
             (fun f -> ("group_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          group_id =
            (Util.option_bind (Xml.member "GroupId" xml) String.parse);
          group_name =
            (Util.option_bind (Xml.member "GroupName" xml) String.parse);
          ip_permissions =
            (Xml.required "IpPermissions"
               (Util.option_bind (Xml.member "IpPermissions" xml)
                  IpPermissionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.group_id
                (fun f -> Ezxmlm.make_tag "GroupId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.group_name
               (fun f -> Ezxmlm.make_tag "GroupName" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "IpPermissions"
                      ([], (IpPermissionList.to_xml [x])))) v.ip_permissions))
  end
module UpdateSecurityGroupRuleDescriptionsIngressResult =
  UpdateSecurityGroupRuleDescriptionsIngressResult
type input = UpdateSecurityGroupRuleDescriptionsIngressRequest.t
type output = UpdateSecurityGroupRuleDescriptionsIngressResult.t
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
         ("Action", ["UpdateSecurityGroupRuleDescriptionsIngress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (UpdateSecurityGroupRuleDescriptionsIngressRequest.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (UpdateSecurityGroupRuleDescriptionsIngressRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "UpdateSecurityGroupRuleDescriptionsIngressResponse"
        (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             UpdateSecurityGroupRuleDescriptionsIngressResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed UpdateSecurityGroupRuleDescriptionsIngressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing UpdateSecurityGroupRuleDescriptionsIngressResult - missing field in body or children: "
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