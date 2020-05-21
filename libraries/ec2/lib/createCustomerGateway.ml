open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCustomerGatewayRequest =
  struct
    type t =
      {
      bgp_asn: Integer.t
        [@ocaml.doc
          "<p>For devices that support BGP, the customer gateway's BGP ASN.</p> <p>Default: 65000</p>"];
      public_ip: String.t option
        [@ocaml.doc
          "<p>The Internet-routable IP address for the customer gateway's outside interface. The address must be static.</p>"];
      certificate_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the customer gateway certificate.</p>"];
      type_: GatewayType.t
        [@ocaml.doc
          "<p>The type of VPN connection that this customer gateway supports (<code>ipsec.1</code>).</p>"];
      device_name: String.t option
        [@ocaml.doc
          "<p>A name for the customer gateway device.</p> <p>Length Constraints: Up to 255 characters.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for CreateCustomerGateway.</p>"]
    let make ~bgp_asn  ?public_ip  ?certificate_arn  ~type_  ?device_name 
      ?dry_run  () =
      { bgp_asn; public_ip; certificate_arn; type_; device_name; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.device_name
             (fun f -> Query.Pair ("DeviceName", (String.to_query f)));
           Some (Query.Pair ("Type", (GatewayType.to_query v.type_)));
           Util.option_map v.certificate_arn
             (fun f -> Query.Pair ("CertificateArn", (String.to_query f)));
           Util.option_map v.public_ip
             (fun f -> Query.Pair ("IpAddress", (String.to_query f)));
           Some (Query.Pair ("BgpAsn", (Integer.to_query v.bgp_asn)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.device_name
             (fun f -> ("device_name", (String.to_json f)));
           Some ("type_", (GatewayType.to_json v.type_));
           Util.option_map v.certificate_arn
             (fun f -> ("certificate_arn", (String.to_json f)));
           Util.option_map v.public_ip
             (fun f -> ("public_ip", (String.to_json f)));
           Some ("bgp_asn", (Integer.to_json v.bgp_asn))])
    let parse xml =
      Some
        {
          bgp_asn =
            (Xml.required "BgpAsn"
               (Util.option_bind (Xml.member "BgpAsn" xml) Integer.parse));
          public_ip =
            (Util.option_bind (Xml.member "IpAddress" xml) String.parse);
          certificate_arn =
            (Util.option_bind (Xml.member "CertificateArn" xml) String.parse);
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) GatewayType.parse));
          device_name =
            (Util.option_bind (Xml.member "DeviceName" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "BgpAsn" ([], (Integer.to_xml v.bgp_asn)))])
               @
               [Util.option_map v.public_ip
                  (fun f ->
                     Ezxmlm.make_tag "IpAddress" ([], (String.to_xml f)))])
              @
              [Util.option_map v.certificate_arn
                 (fun f ->
                    Ezxmlm.make_tag "CertificateArn" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "Type" ([], (GatewayType.to_xml v.type_)))])
            @
            [Util.option_map v.device_name
               (fun f -> Ezxmlm.make_tag "DeviceName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for CreateCustomerGateway.</p>"]
module CreateCustomerGatewayResult = CreateCustomerGatewayResult
type input = CreateCustomerGatewayRequest.t
type output = CreateCustomerGatewayResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateCustomerGateway"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateCustomerGatewayRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateCustomerGatewayRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateCustomerGatewayResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateCustomerGatewayResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCustomerGatewayResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCustomerGatewayResult - missing field in body or children: "
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