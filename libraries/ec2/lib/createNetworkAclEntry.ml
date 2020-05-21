open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateNetworkAclEntryRequest =
  struct
    type t =
      {
      cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv4 network range to allow or deny, in CIDR notation (for example <code>172.16.0.0/24</code>).</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      egress: Boolean.t
        [@ocaml.doc
          "<p>Indicates whether this is an egress rule (rule is applied to traffic leaving the subnet).</p>"];
      icmp_type_code: IcmpTypeCode.t option
        [@ocaml.doc
          "<p>ICMP protocol: The ICMP or ICMPv6 type and code. Required if specifying protocol 1 (ICMP) or protocol 58 (ICMPv6) with an IPv6 CIDR block.</p>"];
      ipv6_cidr_block: String.t option
        [@ocaml.doc
          "<p>The IPv6 network range to allow or deny, in CIDR notation (for example <code>2001:db8:1234:1a00::/64</code>).</p>"];
      network_acl_id: String.t
        [@ocaml.doc "<p>The ID of the network ACL.</p>"];
      port_range: PortRange.t option
        [@ocaml.doc
          "<p>TCP or UDP protocols: The range of ports the rule applies to. Required if specifying protocol 6 (TCP) or 17 (UDP).</p>"];
      protocol: String.t
        [@ocaml.doc
          "<p>The protocol number. A value of \"-1\" means all protocols. If you specify \"-1\" or a protocol number other than \"6\" (TCP), \"17\" (UDP), or \"1\" (ICMP), traffic on all ports is allowed, regardless of any ports or ICMP types or codes that you specify. If you specify protocol \"58\" (ICMPv6) and specify an IPv4 CIDR block, traffic for all ICMP types and codes allowed, regardless of any that you specify. If you specify protocol \"58\" (ICMPv6) and specify an IPv6 CIDR block, you must specify an ICMP type and code.</p>"];
      rule_action: RuleAction.t
        [@ocaml.doc
          "<p>Indicates whether to allow or deny the traffic that matches the rule.</p>"];
      rule_number: Integer.t
        [@ocaml.doc
          "<p>The rule number for the entry (for example, 100). ACL entries are processed in ascending order by rule number.</p> <p>Constraints: Positive integer from 1 to 32766. The range 32767 to 65535 is reserved for internal use.</p>"]}
    let make ?cidr_block  ?dry_run  ~egress  ?icmp_type_code 
      ?ipv6_cidr_block  ~network_acl_id  ?port_range  ~protocol  ~rule_action
       ~rule_number  () =
      {
        cidr_block;
        dry_run;
        egress;
        icmp_type_code;
        ipv6_cidr_block;
        network_acl_id;
        port_range;
        protocol;
        rule_action;
        rule_number
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair ("RuleNumber", (Integer.to_query v.rule_number)));
           Some
             (Query.Pair ("RuleAction", (RuleAction.to_query v.rule_action)));
           Some (Query.Pair ("Protocol", (String.to_query v.protocol)));
           Util.option_map v.port_range
             (fun f -> Query.Pair ("PortRange", (PortRange.to_query f)));
           Some
             (Query.Pair ("NetworkAclId", (String.to_query v.network_acl_id)));
           Util.option_map v.ipv6_cidr_block
             (fun f -> Query.Pair ("Ipv6CidrBlock", (String.to_query f)));
           Util.option_map v.icmp_type_code
             (fun f -> Query.Pair ("Icmp", (IcmpTypeCode.to_query f)));
           Some (Query.Pair ("Egress", (Boolean.to_query v.egress)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.cidr_block
             (fun f -> Query.Pair ("CidrBlock", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rule_number", (Integer.to_json v.rule_number));
           Some ("rule_action", (RuleAction.to_json v.rule_action));
           Some ("protocol", (String.to_json v.protocol));
           Util.option_map v.port_range
             (fun f -> ("port_range", (PortRange.to_json f)));
           Some ("network_acl_id", (String.to_json v.network_acl_id));
           Util.option_map v.ipv6_cidr_block
             (fun f -> ("ipv6_cidr_block", (String.to_json f)));
           Util.option_map v.icmp_type_code
             (fun f -> ("icmp_type_code", (IcmpTypeCode.to_json f)));
           Some ("egress", (Boolean.to_json v.egress));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.cidr_block
             (fun f -> ("cidr_block", (String.to_json f)))])
    let parse xml =
      Some
        {
          cidr_block =
            (Util.option_bind (Xml.member "cidrBlock" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          egress =
            (Xml.required "egress"
               (Util.option_bind (Xml.member "egress" xml) Boolean.parse));
          icmp_type_code =
            (Util.option_bind (Xml.member "Icmp" xml) IcmpTypeCode.parse);
          ipv6_cidr_block =
            (Util.option_bind (Xml.member "ipv6CidrBlock" xml) String.parse);
          network_acl_id =
            (Xml.required "networkAclId"
               (Util.option_bind (Xml.member "networkAclId" xml) String.parse));
          port_range =
            (Util.option_bind (Xml.member "portRange" xml) PortRange.parse);
          protocol =
            (Xml.required "protocol"
               (Util.option_bind (Xml.member "protocol" xml) String.parse));
          rule_action =
            (Xml.required "ruleAction"
               (Util.option_bind (Xml.member "ruleAction" xml)
                  RuleAction.parse));
          rule_number =
            (Xml.required "ruleNumber"
               (Util.option_bind (Xml.member "ruleNumber" xml) Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.cidr_block
                       (fun f ->
                          Ezxmlm.make_tag "cidrBlock" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.dry_run
                      (fun f ->
                         Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "egress"
                        ([], (Boolean.to_xml v.egress)))])
                 @
                 [Util.option_map v.icmp_type_code
                    (fun f ->
                       Ezxmlm.make_tag "Icmp" ([], (IcmpTypeCode.to_xml f)))])
                @
                [Util.option_map v.ipv6_cidr_block
                   (fun f ->
                      Ezxmlm.make_tag "ipv6CidrBlock" ([], (String.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "networkAclId"
                     ([], (String.to_xml v.network_acl_id)))])
              @
              [Util.option_map v.port_range
                 (fun f ->
                    Ezxmlm.make_tag "portRange" ([], (PortRange.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "protocol" ([], (String.to_xml v.protocol)))])
            @
            [Some
               (Ezxmlm.make_tag "ruleAction"
                  ([], (RuleAction.to_xml v.rule_action)))])
           @
           [Some
              (Ezxmlm.make_tag "ruleNumber"
                 ([], (Integer.to_xml v.rule_number)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CreateNetworkAclEntryRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["CreateNetworkAclEntry"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateNetworkAclEntryRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateNetworkAclEntryRequest.to_headers req)), "")
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