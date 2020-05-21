open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AuthorizeSecurityGroupEgressRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      group_id: String.t [@ocaml.doc "<p>The ID of the security group.</p>"];
      ip_permissions: IpPermissionList.t
        [@ocaml.doc
          "<p>The sets of IP permissions. You can't specify a destination security group and a CIDR IP address range in the same set of permissions.</p>"];
      cidr_ip: String.t option
        [@ocaml.doc
          "<p>Not supported. Use a set of IP permissions to specify the CIDR.</p>"];
      from_port: Integer.t option
        [@ocaml.doc
          "<p>Not supported. Use a set of IP permissions to specify the port.</p>"];
      ip_protocol: String.t option
        [@ocaml.doc
          "<p>Not supported. Use a set of IP permissions to specify the protocol name or number.</p>"];
      to_port: Integer.t option
        [@ocaml.doc
          "<p>Not supported. Use a set of IP permissions to specify the port.</p>"];
      source_security_group_name: String.t option
        [@ocaml.doc
          "<p>Not supported. Use a set of IP permissions to specify a destination security group.</p>"];
      source_security_group_owner_id: String.t option
        [@ocaml.doc
          "<p>Not supported. Use a set of IP permissions to specify a destination security group.</p>"]}
    let make ?dry_run  ~group_id  ?(ip_permissions= [])  ?cidr_ip  ?from_port
       ?ip_protocol  ?to_port  ?source_security_group_name 
      ?source_security_group_owner_id  () =
      {
        dry_run;
        group_id;
        ip_permissions;
        cidr_ip;
        from_port;
        ip_protocol;
        to_port;
        source_security_group_name;
        source_security_group_owner_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.source_security_group_owner_id
              (fun f ->
                 Query.Pair
                   ("SourceSecurityGroupOwnerId", (String.to_query f)));
           Util.option_map v.source_security_group_name
             (fun f ->
                Query.Pair ("SourceSecurityGroupName", (String.to_query f)));
           Util.option_map v.to_port
             (fun f -> Query.Pair ("ToPort", (Integer.to_query f)));
           Util.option_map v.ip_protocol
             (fun f -> Query.Pair ("IpProtocol", (String.to_query f)));
           Util.option_map v.from_port
             (fun f -> Query.Pair ("FromPort", (Integer.to_query f)));
           Util.option_map v.cidr_ip
             (fun f -> Query.Pair ("CidrIp", (String.to_query f)));
           Some
             (Query.Pair
                ("IpPermissions",
                  (IpPermissionList.to_query v.ip_permissions)));
           Some (Query.Pair ("GroupId", (String.to_query v.group_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.source_security_group_owner_id
              (fun f ->
                 ("source_security_group_owner_id", (String.to_json f)));
           Util.option_map v.source_security_group_name
             (fun f -> ("source_security_group_name", (String.to_json f)));
           Util.option_map v.to_port
             (fun f -> ("to_port", (Integer.to_json f)));
           Util.option_map v.ip_protocol
             (fun f -> ("ip_protocol", (String.to_json f)));
           Util.option_map v.from_port
             (fun f -> ("from_port", (Integer.to_json f)));
           Util.option_map v.cidr_ip
             (fun f -> ("cidr_ip", (String.to_json f)));
           Some
             ("ip_permissions", (IpPermissionList.to_json v.ip_permissions));
           Some ("group_id", (String.to_json v.group_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          group_id =
            (Xml.required "groupId"
               (Util.option_bind (Xml.member "groupId" xml) String.parse));
          ip_permissions =
            (Util.of_option []
               (Util.option_bind (Xml.member "ipPermissions" xml)
                  IpPermissionList.parse));
          cidr_ip = (Util.option_bind (Xml.member "cidrIp" xml) String.parse);
          from_port =
            (Util.option_bind (Xml.member "fromPort" xml) Integer.parse);
          ip_protocol =
            (Util.option_bind (Xml.member "ipProtocol" xml) String.parse);
          to_port =
            (Util.option_bind (Xml.member "toPort" xml) Integer.parse);
          source_security_group_name =
            (Util.option_bind (Xml.member "sourceSecurityGroupName" xml)
               String.parse);
          source_security_group_owner_id =
            (Util.option_bind (Xml.member "sourceSecurityGroupOwnerId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.dry_run
                      (fun f ->
                         Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "groupId"
                        ([], (String.to_xml v.group_id)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "ipPermissions"
                            ([], (IpPermissionList.to_xml [x]))))
                    v.ip_permissions))
                @
                [Util.option_map v.cidr_ip
                   (fun f -> Ezxmlm.make_tag "cidrIp" ([], (String.to_xml f)))])
               @
               [Util.option_map v.from_port
                  (fun f ->
                     Ezxmlm.make_tag "fromPort" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.ip_protocol
                 (fun f ->
                    Ezxmlm.make_tag "ipProtocol" ([], (String.to_xml f)))])
             @
             [Util.option_map v.to_port
                (fun f -> Ezxmlm.make_tag "toPort" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.source_security_group_name
               (fun f ->
                  Ezxmlm.make_tag "sourceSecurityGroupName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.source_security_group_owner_id
              (fun f ->
                 Ezxmlm.make_tag "sourceSecurityGroupOwnerId"
                   ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = AuthorizeSecurityGroupEgressRequest.t
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
         ("Action", ["AuthorizeSecurityGroupEgress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (AuthorizeSecurityGroupEgressRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AuthorizeSecurityGroupEgressRequest.to_headers req)),
    "")
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