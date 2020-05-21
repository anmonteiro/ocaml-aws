open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RevokeSecurityGroupIngressRequest =
  struct
    type t =
      {
      cidr_ip: String.t option
        [@ocaml.doc
          "<p>The CIDR IP address range. You can't specify this parameter when specifying a source security group.</p>"];
      from_port: Integer.t option
        [@ocaml.doc
          "<p>The start of port range for the TCP and UDP protocols, or an ICMP type number. For the ICMP type number, use <code>-1</code> to specify all ICMP types.</p>"];
      group_id: String.t option
        [@ocaml.doc
          "<p>The ID of the security group. You must specify either the security group ID or the security group name in the request. For security groups in a nondefault VPC, you must specify the security group ID.</p>"];
      group_name: String.t option
        [@ocaml.doc
          "<p>[EC2-Classic, default VPC] The name of the security group. You must specify either the security group ID or the security group name in the request.</p>"];
      ip_permissions: IpPermissionList.t
        [@ocaml.doc
          "<p>The sets of IP permissions. You can't specify a source security group and a CIDR IP address range in the same set of permissions.</p>"];
      ip_protocol: String.t option
        [@ocaml.doc
          "<p>The IP protocol name (<code>tcp</code>, <code>udp</code>, <code>icmp</code>) or number (see <a href=\"http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml\">Protocol Numbers</a>). Use <code>-1</code> to specify all.</p>"];
      source_security_group_name: String.t option
        [@ocaml.doc
          "<p>[EC2-Classic, default VPC] The name of the source security group. You can't specify this parameter in combination with the following parameters: the CIDR IP address range, the start of the port range, the IP protocol, and the end of the port range. For EC2-VPC, the source security group must be in the same VPC. To revoke a specific rule for an IP protocol and port range, use a set of IP permissions instead.</p>"];
      source_security_group_owner_id: String.t option
        [@ocaml.doc
          "<p>[EC2-Classic] The AWS account ID of the source security group, if the source security group is in a different account. You can't specify this parameter in combination with the following parameters: the CIDR IP address range, the IP protocol, the start of the port range, and the end of the port range. To revoke a specific rule for an IP protocol and port range, use a set of IP permissions instead.</p>"];
      to_port: Integer.t option
        [@ocaml.doc
          "<p>The end of port range for the TCP and UDP protocols, or an ICMP code number. For the ICMP code number, use <code>-1</code> to specify all ICMP codes for the ICMP type.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?cidr_ip  ?from_port  ?group_id  ?group_name  ?(ip_permissions=
      [])  ?ip_protocol  ?source_security_group_name 
      ?source_security_group_owner_id  ?to_port  ?dry_run  () =
      {
        cidr_ip;
        from_port;
        group_id;
        group_name;
        ip_permissions;
        ip_protocol;
        source_security_group_name;
        source_security_group_owner_id;
        to_port;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.to_port
             (fun f -> Query.Pair ("ToPort", (Integer.to_query f)));
           Util.option_map v.source_security_group_owner_id
             (fun f ->
                Query.Pair
                  ("SourceSecurityGroupOwnerId", (String.to_query f)));
           Util.option_map v.source_security_group_name
             (fun f ->
                Query.Pair ("SourceSecurityGroupName", (String.to_query f)));
           Util.option_map v.ip_protocol
             (fun f -> Query.Pair ("IpProtocol", (String.to_query f)));
           Some
             (Query.Pair
                ("IpPermissions",
                  (IpPermissionList.to_query v.ip_permissions)));
           Util.option_map v.group_name
             (fun f -> Query.Pair ("GroupName", (String.to_query f)));
           Util.option_map v.group_id
             (fun f -> Query.Pair ("GroupId", (String.to_query f)));
           Util.option_map v.from_port
             (fun f -> Query.Pair ("FromPort", (Integer.to_query f)));
           Util.option_map v.cidr_ip
             (fun f -> Query.Pair ("CidrIp", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.to_port
             (fun f -> ("to_port", (Integer.to_json f)));
           Util.option_map v.source_security_group_owner_id
             (fun f -> ("source_security_group_owner_id", (String.to_json f)));
           Util.option_map v.source_security_group_name
             (fun f -> ("source_security_group_name", (String.to_json f)));
           Util.option_map v.ip_protocol
             (fun f -> ("ip_protocol", (String.to_json f)));
           Some
             ("ip_permissions", (IpPermissionList.to_json v.ip_permissions));
           Util.option_map v.group_name
             (fun f -> ("group_name", (String.to_json f)));
           Util.option_map v.group_id
             (fun f -> ("group_id", (String.to_json f)));
           Util.option_map v.from_port
             (fun f -> ("from_port", (Integer.to_json f)));
           Util.option_map v.cidr_ip
             (fun f -> ("cidr_ip", (String.to_json f)))])
    let parse xml =
      Some
        {
          cidr_ip = (Util.option_bind (Xml.member "CidrIp" xml) String.parse);
          from_port =
            (Util.option_bind (Xml.member "FromPort" xml) Integer.parse);
          group_id =
            (Util.option_bind (Xml.member "GroupId" xml) String.parse);
          group_name =
            (Util.option_bind (Xml.member "GroupName" xml) String.parse);
          ip_permissions =
            (Util.of_option []
               (Util.option_bind (Xml.member "IpPermissions" xml)
                  IpPermissionList.parse));
          ip_protocol =
            (Util.option_bind (Xml.member "IpProtocol" xml) String.parse);
          source_security_group_name =
            (Util.option_bind (Xml.member "SourceSecurityGroupName" xml)
               String.parse);
          source_security_group_owner_id =
            (Util.option_bind (Xml.member "SourceSecurityGroupOwnerId" xml)
               String.parse);
          to_port =
            (Util.option_bind (Xml.member "ToPort" xml) Integer.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.cidr_ip
                       (fun f ->
                          Ezxmlm.make_tag "CidrIp" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.from_port
                      (fun f ->
                         Ezxmlm.make_tag "FromPort" ([], (Integer.to_xml f)))])
                  @
                  [Util.option_map v.group_id
                     (fun f ->
                        Ezxmlm.make_tag "GroupId" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.group_name
                    (fun f ->
                       Ezxmlm.make_tag "GroupName" ([], (String.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "IpPermissions"
                           ([], (IpPermissionList.to_xml [x]))))
                   v.ip_permissions))
               @
               [Util.option_map v.ip_protocol
                  (fun f ->
                     Ezxmlm.make_tag "IpProtocol" ([], (String.to_xml f)))])
              @
              [Util.option_map v.source_security_group_name
                 (fun f ->
                    Ezxmlm.make_tag "SourceSecurityGroupName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.source_security_group_owner_id
                (fun f ->
                   Ezxmlm.make_tag "SourceSecurityGroupOwnerId"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.to_port
               (fun f -> Ezxmlm.make_tag "ToPort" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = RevokeSecurityGroupIngressRequest.t
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
         ("Action", ["RevokeSecurityGroupIngress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RevokeSecurityGroupIngressRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (RevokeSecurityGroupIngressRequest.to_headers req)), "")
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