open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteClientVpnRouteRequest =
  struct
    type t =
      {
      client_vpn_endpoint_id: String.t
        [@ocaml.doc
          "<p>The ID of the Client VPN endpoint from which the route is to be deleted.</p>"];
      target_vpc_subnet_id: String.t option
        [@ocaml.doc "<p>The ID of the target subnet used by the route.</p>"];
      destination_cidr_block: String.t
        [@ocaml.doc
          "<p>The IPv4 address range, in CIDR notation, of the route to be deleted.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~client_vpn_endpoint_id  ?target_vpc_subnet_id 
      ~destination_cidr_block  ?dry_run  () =
      {
        client_vpn_endpoint_id;
        target_vpc_subnet_id;
        destination_cidr_block;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("DestinationCidrBlock",
                  (String.to_query v.destination_cidr_block)));
           Util.option_map v.target_vpc_subnet_id
             (fun f -> Query.Pair ("TargetVpcSubnetId", (String.to_query f)));
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
           Some
             ("destination_cidr_block",
               (String.to_json v.destination_cidr_block));
           Util.option_map v.target_vpc_subnet_id
             (fun f -> ("target_vpc_subnet_id", (String.to_json f)));
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
          target_vpc_subnet_id =
            (Util.option_bind (Xml.member "TargetVpcSubnetId" xml)
               String.parse);
          destination_cidr_block =
            (Xml.required "DestinationCidrBlock"
               (Util.option_bind (Xml.member "DestinationCidrBlock" xml)
                  String.parse));
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
             [Util.option_map v.target_vpc_subnet_id
                (fun f ->
                   Ezxmlm.make_tag "TargetVpcSubnetId"
                     ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "DestinationCidrBlock"
                  ([], (String.to_xml v.destination_cidr_block)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module DeleteClientVpnRouteResult = DeleteClientVpnRouteResult
type input = DeleteClientVpnRouteRequest.t
type output = DeleteClientVpnRouteResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DeleteClientVpnRoute"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteClientVpnRouteRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteClientVpnRouteRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DeleteClientVpnRouteResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DeleteClientVpnRouteResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteClientVpnRouteResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteClientVpnRouteResult - missing field in body or children: "
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