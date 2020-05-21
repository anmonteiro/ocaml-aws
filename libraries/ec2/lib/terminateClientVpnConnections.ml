open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module TerminateClientVpnConnectionsRequest =
  struct
    type t =
      {
      client_vpn_endpoint_id: String.t
        [@ocaml.doc
          "<p>The ID of the Client VPN endpoint to which the client is connected.</p>"];
      connection_id: String.t option
        [@ocaml.doc
          "<p>The ID of the client connection to be terminated.</p>"];
      username: String.t option
        [@ocaml.doc
          "<p>The name of the user who initiated the connection. Use this option to terminate all active connections for the specified user. This option can only be used if the user has established up to five connections.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~client_vpn_endpoint_id  ?connection_id  ?username  ?dry_run  ()
      = { client_vpn_endpoint_id; connection_id; username; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.username
             (fun f -> Query.Pair ("Username", (String.to_query f)));
           Util.option_map v.connection_id
             (fun f -> Query.Pair ("ConnectionId", (String.to_query f)));
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
           Util.option_map v.username
             (fun f -> ("username", (String.to_json f)));
           Util.option_map v.connection_id
             (fun f -> ("connection_id", (String.to_json f)));
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
          connection_id =
            (Util.option_bind (Xml.member "ConnectionId" xml) String.parse);
          username =
            (Util.option_bind (Xml.member "Username" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "ClientVpnEndpointId"
                    ([], (String.to_xml v.client_vpn_endpoint_id)))])
             @
             [Util.option_map v.connection_id
                (fun f ->
                   Ezxmlm.make_tag "ConnectionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.username
               (fun f -> Ezxmlm.make_tag "Username" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module TerminateClientVpnConnectionsResult =
  TerminateClientVpnConnectionsResult
type input = TerminateClientVpnConnectionsRequest.t
type output = TerminateClientVpnConnectionsResult.t
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
         ("Action", ["TerminateClientVpnConnections"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (TerminateClientVpnConnectionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (TerminateClientVpnConnectionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "TerminateClientVpnConnectionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp TerminateClientVpnConnectionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed TerminateClientVpnConnectionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing TerminateClientVpnConnectionsResult - missing field in body or children: "
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