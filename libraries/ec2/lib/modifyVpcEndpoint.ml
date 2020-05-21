open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpcEndpointRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      vpc_endpoint_id: String.t [@ocaml.doc "<p>The ID of the endpoint.</p>"];
      reset_policy: Boolean.t option
        [@ocaml.doc
          "<p>(Gateway endpoint) Specify <code>true</code> to reset the policy document to the default policy. The default policy allows full access to the service.</p>"];
      policy_document: String.t option
        [@ocaml.doc
          "<p>A policy to attach to the endpoint that controls access to the service. The policy must be in valid JSON format.</p>"];
      add_route_table_ids: ValueStringList.t
        [@ocaml.doc
          "<p>(Gateway endpoint) One or more route tables IDs to associate with the endpoint.</p>"];
      remove_route_table_ids: ValueStringList.t
        [@ocaml.doc
          "<p>(Gateway endpoint) One or more route table IDs to disassociate from the endpoint.</p>"];
      add_subnet_ids: ValueStringList.t
        [@ocaml.doc
          "<p>(Interface endpoint) One or more subnet IDs in which to serve the endpoint.</p>"];
      remove_subnet_ids: ValueStringList.t
        [@ocaml.doc
          "<p>(Interface endpoint) One or more subnets IDs in which to remove the endpoint.</p>"];
      add_security_group_ids: ValueStringList.t
        [@ocaml.doc
          "<p>(Interface endpoint) One or more security group IDs to associate with the network interface.</p>"];
      remove_security_group_ids: ValueStringList.t
        [@ocaml.doc
          "<p>(Interface endpoint) One or more security group IDs to disassociate from the network interface.</p>"];
      private_dns_enabled: Boolean.t option
        [@ocaml.doc
          "<p>(Interface endpoint) Indicate whether a private hosted zone is associated with the VPC.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for ModifyVpcEndpoint.</p>"]
    let make ?dry_run  ~vpc_endpoint_id  ?reset_policy  ?policy_document 
      ?(add_route_table_ids= [])  ?(remove_route_table_ids= []) 
      ?(add_subnet_ids= [])  ?(remove_subnet_ids= []) 
      ?(add_security_group_ids= [])  ?(remove_security_group_ids= []) 
      ?private_dns_enabled  () =
      {
        dry_run;
        vpc_endpoint_id;
        reset_policy;
        policy_document;
        add_route_table_ids;
        remove_route_table_ids;
        add_subnet_ids;
        remove_subnet_ids;
        add_security_group_ids;
        remove_security_group_ids;
        private_dns_enabled
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.private_dns_enabled
              (fun f ->
                 Query.Pair ("PrivateDnsEnabled", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("RemoveSecurityGroupId",
                  (ValueStringList.to_query v.remove_security_group_ids)));
           Some
             (Query.Pair
                ("AddSecurityGroupId",
                  (ValueStringList.to_query v.add_security_group_ids)));
           Some
             (Query.Pair
                ("RemoveSubnetId",
                  (ValueStringList.to_query v.remove_subnet_ids)));
           Some
             (Query.Pair
                ("AddSubnetId", (ValueStringList.to_query v.add_subnet_ids)));
           Some
             (Query.Pair
                ("RemoveRouteTableId",
                  (ValueStringList.to_query v.remove_route_table_ids)));
           Some
             (Query.Pair
                ("AddRouteTableId",
                  (ValueStringList.to_query v.add_route_table_ids)));
           Util.option_map v.policy_document
             (fun f -> Query.Pair ("PolicyDocument", (String.to_query f)));
           Util.option_map v.reset_policy
             (fun f -> Query.Pair ("ResetPolicy", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("VpcEndpointId", (String.to_query v.vpc_endpoint_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.private_dns_enabled
              (fun f -> ("private_dns_enabled", (Boolean.to_json f)));
           Some
             ("remove_security_group_ids",
               (ValueStringList.to_json v.remove_security_group_ids));
           Some
             ("add_security_group_ids",
               (ValueStringList.to_json v.add_security_group_ids));
           Some
             ("remove_subnet_ids",
               (ValueStringList.to_json v.remove_subnet_ids));
           Some
             ("add_subnet_ids", (ValueStringList.to_json v.add_subnet_ids));
           Some
             ("remove_route_table_ids",
               (ValueStringList.to_json v.remove_route_table_ids));
           Some
             ("add_route_table_ids",
               (ValueStringList.to_json v.add_route_table_ids));
           Util.option_map v.policy_document
             (fun f -> ("policy_document", (String.to_json f)));
           Util.option_map v.reset_policy
             (fun f -> ("reset_policy", (Boolean.to_json f)));
           Some ("vpc_endpoint_id", (String.to_json v.vpc_endpoint_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          vpc_endpoint_id =
            (Xml.required "VpcEndpointId"
               (Util.option_bind (Xml.member "VpcEndpointId" xml)
                  String.parse));
          reset_policy =
            (Util.option_bind (Xml.member "ResetPolicy" xml) Boolean.parse);
          policy_document =
            (Util.option_bind (Xml.member "PolicyDocument" xml) String.parse);
          add_route_table_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddRouteTableId" xml)
                  ValueStringList.parse));
          remove_route_table_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveRouteTableId" xml)
                  ValueStringList.parse));
          add_subnet_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddSubnetId" xml)
                  ValueStringList.parse));
          remove_subnet_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveSubnetId" xml)
                  ValueStringList.parse));
          add_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddSecurityGroupId" xml)
                  ValueStringList.parse));
          remove_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveSecurityGroupId" xml)
                  ValueStringList.parse));
          private_dns_enabled =
            (Util.option_bind (Xml.member "PrivateDnsEnabled" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.dry_run
                        (fun f ->
                           Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "VpcEndpointId"
                          ([], (String.to_xml v.vpc_endpoint_id)))])
                   @
                   [Util.option_map v.reset_policy
                      (fun f ->
                         Ezxmlm.make_tag "ResetPolicy"
                           ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.policy_document
                     (fun f ->
                        Ezxmlm.make_tag "PolicyDocument"
                          ([], (String.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "AddRouteTableId"
                            ([], (ValueStringList.to_xml [x]))))
                    v.add_route_table_ids))
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "RemoveRouteTableId"
                           ([], (ValueStringList.to_xml [x]))))
                   v.remove_route_table_ids))
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "AddSubnetId"
                          ([], (ValueStringList.to_xml [x]))))
                  v.add_subnet_ids))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "RemoveSubnetId"
                         ([], (ValueStringList.to_xml [x]))))
                 v.remove_subnet_ids))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AddSecurityGroupId"
                        ([], (ValueStringList.to_xml [x]))))
                v.add_security_group_ids))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RemoveSecurityGroupId"
                       ([], (ValueStringList.to_xml [x]))))
               v.remove_security_group_ids))
           @
           [Util.option_map v.private_dns_enabled
              (fun f ->
                 Ezxmlm.make_tag "PrivateDnsEnabled" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for ModifyVpcEndpoint.</p>"]
module ModifyVpcEndpointResult = ModifyVpcEndpointResult
type input = ModifyVpcEndpointRequest.t
type output = ModifyVpcEndpointResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ModifyVpcEndpoint"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyVpcEndpointRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ModifyVpcEndpointRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ModifyVpcEndpointResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ModifyVpcEndpointResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyVpcEndpointResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVpcEndpointResult - missing field in body or children: "
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