open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpnGatewayRequest =
  struct
    type t =
      {
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone for the virtual private gateway.</p>"];
      type_: GatewayType.t
        [@ocaml.doc
          "<p>The type of VPN connection this virtual private gateway supports.</p>"];
      amazon_side_asn: Long.t option
        [@ocaml.doc
          "<p>A private Autonomous System Number (ASN) for the Amazon side of a BGP session. If you're using a 16-bit ASN, it must be in the 64512 to 65534 range. If you're using a 32-bit ASN, it must be in the 4200000000 to 4294967294 range.</p> <p>Default: 64512</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for CreateVpnGateway.</p>"]
    let make ?availability_zone  ~type_  ?amazon_side_asn  ?dry_run  () =
      { availability_zone; type_; amazon_side_asn; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.amazon_side_asn
             (fun f -> Query.Pair ("AmazonSideAsn", (Long.to_query f)));
           Some (Query.Pair ("Type", (GatewayType.to_query v.type_)));
           Util.option_map v.availability_zone
             (fun f -> Query.Pair ("AvailabilityZone", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.amazon_side_asn
             (fun f -> ("amazon_side_asn", (Long.to_json f)));
           Some ("type_", (GatewayType.to_json v.type_));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)))])
    let parse xml =
      Some
        {
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) GatewayType.parse));
          amazon_side_asn =
            (Util.option_bind (Xml.member "AmazonSideAsn" xml) Long.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.availability_zone
                 (fun f ->
                    Ezxmlm.make_tag "AvailabilityZone"
                      ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "Type" ([], (GatewayType.to_xml v.type_)))])
            @
            [Util.option_map v.amazon_side_asn
               (fun f ->
                  Ezxmlm.make_tag "AmazonSideAsn" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for CreateVpnGateway.</p>"]
module CreateVpnGatewayResult = CreateVpnGatewayResult
type input = CreateVpnGatewayRequest.t
type output = CreateVpnGatewayResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateVpnGateway"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateVpnGatewayRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateVpnGatewayRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateVpnGatewayResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateVpnGatewayResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateVpnGatewayResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateVpnGatewayResult - missing field in body or children: "
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