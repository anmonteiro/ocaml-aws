open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AuthorizeClientVpnIngressRequest =
  struct
    type t =
      {
      client_vpn_endpoint_id: String.t
        [@ocaml.doc "<p>The ID of the Client VPN endpoint.</p>"];
      target_network_cidr: String.t
        [@ocaml.doc
          "<p>The IPv4 address range, in CIDR notation, of the network for which access is being authorized.</p>"];
      access_group_id: String.t option
        [@ocaml.doc
          "<p>The ID of the Active Directory group to grant access.</p>"];
      authorize_all_groups: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether to grant access to all clients. Use <code>true</code> to grant all clients who successfully establish a VPN connection access to the network.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A brief description of the authorization rule.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~client_vpn_endpoint_id  ~target_network_cidr  ?access_group_id 
      ?authorize_all_groups  ?description  ?client_token  ?dry_run  () =
      {
        client_vpn_endpoint_id;
        target_network_cidr;
        access_group_id;
        authorize_all_groups;
        description;
        client_token;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.authorize_all_groups
             (fun f ->
                Query.Pair ("AuthorizeAllGroups", (Boolean.to_query f)));
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
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.authorize_all_groups
             (fun f -> ("authorize_all_groups", (Boolean.to_json f)));
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
          authorize_all_groups =
            (Util.option_bind (Xml.member "AuthorizeAllGroups" xml)
               Boolean.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
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
              [Util.option_map v.authorize_all_groups
                 (fun f ->
                    Ezxmlm.make_tag "AuthorizeAllGroups"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module AuthorizeClientVpnIngressResult = AuthorizeClientVpnIngressResult
type input = AuthorizeClientVpnIngressRequest.t
type output = AuthorizeClientVpnIngressResult.t
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
         ("Action", ["AuthorizeClientVpnIngress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AuthorizeClientVpnIngressRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AuthorizeClientVpnIngressRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AuthorizeClientVpnIngressResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AuthorizeClientVpnIngressResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AuthorizeClientVpnIngressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AuthorizeClientVpnIngressResult - missing field in body or children: "
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