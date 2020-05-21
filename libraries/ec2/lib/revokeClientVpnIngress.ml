open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RevokeClientVpnIngressRequest =
  struct
    type t =
      {
      client_vpn_endpoint_id: String.t
        [@ocaml.doc
          "<p>The ID of the Client VPN endpoint with which the authorization rule is associated.</p>"];
      target_network_cidr: String.t
        [@ocaml.doc
          "<p>The IPv4 address range, in CIDR notation, of the network for which access is being removed.</p>"];
      access_group_id: String.t option
        [@ocaml.doc
          "<p>The ID of the Active Directory group for which to revoke access. </p>"];
      revoke_all_groups: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether access should be revoked for all clients.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~client_vpn_endpoint_id  ~target_network_cidr  ?access_group_id 
      ?revoke_all_groups  ?dry_run  () =
      {
        client_vpn_endpoint_id;
        target_network_cidr;
        access_group_id;
        revoke_all_groups;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.revoke_all_groups
             (fun f -> Query.Pair ("RevokeAllGroups", (Boolean.to_query f)));
           Util.option_map v.access_group_id
             (fun f -> Query.Pair ("AccessGroupId", (String.to_query f)));
           Some
             (Query.Pair
                ("TargetNetworkCidr",
                  (String.to_query v.target_network_cidr)));
           Some
             (Query.Pair
                ("ClientVpnEndpointId",
                  (String.to_query v.client_vpn_endpoint_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.revoke_all_groups
             (fun f -> ("revoke_all_groups", (Boolean.to_json f)));
           Util.option_map v.access_group_id
             (fun f -> ("access_group_id", (String.to_json f)));
           Some
             ("target_network_cidr", (String.to_json v.target_network_cidr));
           Some
             ("client_vpn_endpoint_id",
               (String.to_json v.client_vpn_endpoint_id))])
    let parse xml =
      Some
        {
          client_vpn_endpoint_id =
            (Xml.required "ClientVpnEndpointId"
               (Util.option_bind (Xml.member "ClientVpnEndpointId" xml)
                  String.parse));
          target_network_cidr =
            (Xml.required "TargetNetworkCidr"
               (Util.option_bind (Xml.member "TargetNetworkCidr" xml)
                  String.parse));
          access_group_id =
            (Util.option_bind (Xml.member "AccessGroupId" xml) String.parse);
          revoke_all_groups =
            (Util.option_bind (Xml.member "RevokeAllGroups" xml)
               Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "ClientVpnEndpointId"
                     ([], (String.to_xml v.client_vpn_endpoint_id)))])
              @
              [Some
                 (Ezxmlm.make_tag "TargetNetworkCidr"
                    ([], (String.to_xml v.target_network_cidr)))])
             @
             [Util.option_map v.access_group_id
                (fun f ->
                   Ezxmlm.make_tag "AccessGroupId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.revoke_all_groups
               (fun f ->
                  Ezxmlm.make_tag "RevokeAllGroups" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module RevokeClientVpnIngressResult = RevokeClientVpnIngressResult
type input = RevokeClientVpnIngressRequest.t
type output = RevokeClientVpnIngressResult.t
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
         ("Action", ["RevokeClientVpnIngress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RevokeClientVpnIngressRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (RevokeClientVpnIngressRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "RevokeClientVpnIngressResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RevokeClientVpnIngressResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RevokeClientVpnIngressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RevokeClientVpnIngressResult - missing field in body or children: "
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