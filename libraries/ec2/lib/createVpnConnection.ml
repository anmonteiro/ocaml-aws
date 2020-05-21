open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpnConnectionRequest =
  struct
    type t =
      {
      customer_gateway_id: String.t
        [@ocaml.doc "<p>The ID of the customer gateway.</p>"];
      type_: String.t
        [@ocaml.doc
          "<p>The type of VPN connection (<code>ipsec.1</code>).</p>"];
      vpn_gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of the virtual private gateway. If you specify a virtual private gateway, you cannot specify a transit gateway.</p>"];
      transit_gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of the transit gateway. If you specify a transit gateway, you cannot specify a virtual private gateway.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      options: VpnConnectionOptionsSpecification.t option
        [@ocaml.doc "<p>The options for the VPN connection.</p>"]}[@@ocaml.doc
                                                                    "<p>Contains the parameters for CreateVpnConnection.</p>"]
    let make ~customer_gateway_id  ~type_  ?vpn_gateway_id 
      ?transit_gateway_id  ?dry_run  ?options  () =
      {
        customer_gateway_id;
        type_;
        vpn_gateway_id;
        transit_gateway_id;
        dry_run;
        options
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.options
              (fun f ->
                 Query.Pair
                   ("Options",
                     (VpnConnectionOptionsSpecification.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.transit_gateway_id
             (fun f -> Query.Pair ("TransitGatewayId", (String.to_query f)));
           Util.option_map v.vpn_gateway_id
             (fun f -> Query.Pair ("VpnGatewayId", (String.to_query f)));
           Some (Query.Pair ("Type", (String.to_query v.type_)));
           Some
             (Query.Pair
                ("CustomerGatewayId",
                  (String.to_query v.customer_gateway_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.options
              (fun f ->
                 ("options", (VpnConnectionOptionsSpecification.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.transit_gateway_id
             (fun f -> ("transit_gateway_id", (String.to_json f)));
           Util.option_map v.vpn_gateway_id
             (fun f -> ("vpn_gateway_id", (String.to_json f)));
           Some ("type_", (String.to_json v.type_));
           Some
             ("customer_gateway_id", (String.to_json v.customer_gateway_id))])
    let parse xml =
      Some
        {
          customer_gateway_id =
            (Xml.required "CustomerGatewayId"
               (Util.option_bind (Xml.member "CustomerGatewayId" xml)
                  String.parse));
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) String.parse));
          vpn_gateway_id =
            (Util.option_bind (Xml.member "VpnGatewayId" xml) String.parse);
          transit_gateway_id =
            (Util.option_bind (Xml.member "TransitGatewayId" xml)
               String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          options =
            (Util.option_bind (Xml.member "options" xml)
               VpnConnectionOptionsSpecification.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "CustomerGatewayId"
                      ([], (String.to_xml v.customer_gateway_id)))])
               @
               [Some (Ezxmlm.make_tag "Type" ([], (String.to_xml v.type_)))])
              @
              [Util.option_map v.vpn_gateway_id
                 (fun f ->
                    Ezxmlm.make_tag "VpnGatewayId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.transit_gateway_id
                (fun f ->
                   Ezxmlm.make_tag "TransitGatewayId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.options
              (fun f ->
                 Ezxmlm.make_tag "options"
                   ([], (VpnConnectionOptionsSpecification.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for CreateVpnConnection.</p>"]
module CreateVpnConnectionResult = CreateVpnConnectionResult
type input = CreateVpnConnectionRequest.t
type output = CreateVpnConnectionResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateVpnConnection"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateVpnConnectionRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateVpnConnectionRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateVpnConnectionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateVpnConnectionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateVpnConnectionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateVpnConnectionResult - missing field in body or children: "
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