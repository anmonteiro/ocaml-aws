open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AllocateAddressRequest =
  struct
    type t =
      {
      domain: DomainType.t option
        [@ocaml.doc
          "<p>Set to <code>vpc</code> to allocate the address for use with instances in a VPC.</p> <p>Default: The address is for use with instances in EC2-Classic.</p>"];
      address: String.t option
        [@ocaml.doc
          "<p>[EC2-VPC] The Elastic IP address to recover or an IPv4 address from an address pool.</p>"];
      public_ipv4_pool: String.t option
        [@ocaml.doc
          "<p>The ID of an address pool that you own. Use this parameter to let Amazon EC2 select an address from the address pool. To specify a specific address from the address pool, use the <code>Address</code> parameter instead.</p>"];
      network_border_group: String.t option
        [@ocaml.doc
          "<p>The location from which the IP address is advertised. Use this parameter to limit the address to this location.</p> <p>Use <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeVpcs.html\">DescribeVpcs</a> to view the network border groups.</p> <note> <p>You cannot use a network border group with EC2 Classic. If you attempt this operation on EC2 classic, you will receive an <code>InvalidParameterCombination</code> error. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/errors-overview.html\">Error Codes</a>.</p> </note>"];
      customer_owned_ipv4_pool: String.t option
        [@ocaml.doc
          "<p>The ID of a customer-owned address pool. Use this parameter to let Amazon EC2 select an address from the address pool. Alternatively, specify a specific address from the address pool.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?domain  ?address  ?public_ipv4_pool  ?network_border_group 
      ?customer_owned_ipv4_pool  ?dry_run  () =
      {
        domain;
        address;
        public_ipv4_pool;
        network_border_group;
        customer_owned_ipv4_pool;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.customer_owned_ipv4_pool
             (fun f ->
                Query.Pair ("CustomerOwnedIpv4Pool", (String.to_query f)));
           Util.option_map v.network_border_group
             (fun f -> Query.Pair ("NetworkBorderGroup", (String.to_query f)));
           Util.option_map v.public_ipv4_pool
             (fun f -> Query.Pair ("PublicIpv4Pool", (String.to_query f)));
           Util.option_map v.address
             (fun f -> Query.Pair ("Address", (String.to_query f)));
           Util.option_map v.domain
             (fun f -> Query.Pair ("Domain", (DomainType.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.customer_owned_ipv4_pool
             (fun f -> ("customer_owned_ipv4_pool", (String.to_json f)));
           Util.option_map v.network_border_group
             (fun f -> ("network_border_group", (String.to_json f)));
           Util.option_map v.public_ipv4_pool
             (fun f -> ("public_ipv4_pool", (String.to_json f)));
           Util.option_map v.address
             (fun f -> ("address", (String.to_json f)));
           Util.option_map v.domain
             (fun f -> ("domain", (DomainType.to_json f)))])
    let parse xml =
      Some
        {
          domain =
            (Util.option_bind (Xml.member "Domain" xml) DomainType.parse);
          address =
            (Util.option_bind (Xml.member "Address" xml) String.parse);
          public_ipv4_pool =
            (Util.option_bind (Xml.member "PublicIpv4Pool" xml) String.parse);
          network_border_group =
            (Util.option_bind (Xml.member "NetworkBorderGroup" xml)
               String.parse);
          customer_owned_ipv4_pool =
            (Util.option_bind (Xml.member "CustomerOwnedIpv4Pool" xml)
               String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.domain
                   (fun f ->
                      Ezxmlm.make_tag "Domain" ([], (DomainType.to_xml f)))])
               @
               [Util.option_map v.address
                  (fun f -> Ezxmlm.make_tag "Address" ([], (String.to_xml f)))])
              @
              [Util.option_map v.public_ipv4_pool
                 (fun f ->
                    Ezxmlm.make_tag "PublicIpv4Pool" ([], (String.to_xml f)))])
             @
             [Util.option_map v.network_border_group
                (fun f ->
                   Ezxmlm.make_tag "NetworkBorderGroup"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.customer_owned_ipv4_pool
               (fun f ->
                  Ezxmlm.make_tag "CustomerOwnedIpv4Pool"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module AllocateAddressResult = AllocateAddressResult
type input = AllocateAddressRequest.t
type output = AllocateAddressResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["AllocateAddress"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AllocateAddressRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AllocateAddressRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AllocateAddressResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp AllocateAddressResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed AllocateAddressResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AllocateAddressResult - missing field in body or children: "
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