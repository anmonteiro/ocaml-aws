open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpcRequest =
  struct
    type t =
      {
      cidr_block: String.t
        [@ocaml.doc
          "<p>The IPv4 network range for the VPC, in CIDR notation. For example, <code>10.0.0.0/16</code>.</p>"];
      amazon_provided_ipv6_cidr_block: Boolean.t option
        [@ocaml.doc
          "<p>Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_tenancy: Tenancy.t option
        [@ocaml.doc
          "<p>The tenancy options for instances launched into the VPC. For <code>default</code>, instances are launched with shared tenancy by default. You can launch instances with any tenancy into a shared tenancy VPC. For <code>dedicated</code>, instances are launched as dedicated tenancy instances by default. You can only launch instances with a tenancy of <code>dedicated</code> or <code>host</code> into a dedicated tenancy VPC. </p> <p> <b>Important:</b> The <code>host</code> value cannot be used with this parameter. Use the <code>default</code> or <code>dedicated</code> values only.</p> <p>Default: <code>default</code> </p>"];
      ipv6_cidr_block_network_border_group: String.t option
        [@ocaml.doc
          "<p>The name of the location from which we advertise the IPV6 CIDR block. Use this parameter to limit the address to this location.</p> <p> You must set <code>AmazonProvidedIpv6CidrBlock</code> to <code>true</code> to use this parameter.</p>"]}
    let make ~cidr_block  ?amazon_provided_ipv6_cidr_block  ?dry_run 
      ?instance_tenancy  ?ipv6_cidr_block_network_border_group  () =
      {
        cidr_block;
        amazon_provided_ipv6_cidr_block;
        dry_run;
        instance_tenancy;
        ipv6_cidr_block_network_border_group
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.ipv6_cidr_block_network_border_group
              (fun f ->
                 Query.Pair
                   ("Ipv6CidrBlockNetworkBorderGroup", (String.to_query f)));
           Util.option_map v.instance_tenancy
             (fun f -> Query.Pair ("InstanceTenancy", (Tenancy.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.amazon_provided_ipv6_cidr_block
             (fun f ->
                Query.Pair
                  ("AmazonProvidedIpv6CidrBlock", (Boolean.to_query f)));
           Some (Query.Pair ("CidrBlock", (String.to_query v.cidr_block)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.ipv6_cidr_block_network_border_group
              (fun f ->
                 ("ipv6_cidr_block_network_border_group", (String.to_json f)));
           Util.option_map v.instance_tenancy
             (fun f -> ("instance_tenancy", (Tenancy.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.amazon_provided_ipv6_cidr_block
             (fun f ->
                ("amazon_provided_ipv6_cidr_block", (Boolean.to_json f)));
           Some ("cidr_block", (String.to_json v.cidr_block))])
    let parse xml =
      Some
        {
          cidr_block =
            (Xml.required "CidrBlock"
               (Util.option_bind (Xml.member "CidrBlock" xml) String.parse));
          amazon_provided_ipv6_cidr_block =
            (Util.option_bind (Xml.member "amazonProvidedIpv6CidrBlock" xml)
               Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          instance_tenancy =
            (Util.option_bind (Xml.member "instanceTenancy" xml)
               Tenancy.parse);
          ipv6_cidr_block_network_border_group =
            (Util.option_bind
               (Xml.member "Ipv6CidrBlockNetworkBorderGroup" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "CidrBlock"
                     ([], (String.to_xml v.cidr_block)))])
              @
              [Util.option_map v.amazon_provided_ipv6_cidr_block
                 (fun f ->
                    Ezxmlm.make_tag "amazonProvidedIpv6CidrBlock"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.instance_tenancy
               (fun f ->
                  Ezxmlm.make_tag "instanceTenancy" ([], (Tenancy.to_xml f)))])
           @
           [Util.option_map v.ipv6_cidr_block_network_border_group
              (fun f ->
                 Ezxmlm.make_tag "Ipv6CidrBlockNetworkBorderGroup"
                   ([], (String.to_xml f)))])
  end
module CreateVpcResult = CreateVpcResult
type input = CreateVpcRequest.t
type output = CreateVpcResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["CreateVpc"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateVpcRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateVpcRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateVpcResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateVpcResult.parse)
          (BadResponse
             { body; message = "Could not find well formed CreateVpcResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateVpcResult - missing field in body or children: "
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