open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssociateVpcCidrBlockRequest =
  struct
    type t =
      {
      amazon_provided_ipv6_cidr_block: Boolean.t option
        [@ocaml.doc
          "<p>Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IPv6 addresses, or the size of the CIDR block.</p>"];
      cidr_block: String.t option
        [@ocaml.doc "<p>An IPv4 CIDR block to associate with the VPC.</p>"];
      vpc_id: String.t [@ocaml.doc "<p>The ID of the VPC.</p>"];
      ipv6_cidr_block_network_border_group: String.t option
        [@ocaml.doc
          "<p>The name of the location from which we advertise the IPV6 CIDR block. Use this parameter to limit the CiDR block to this location.</p> <p> You must set <code>AmazonProvidedIpv6CidrBlock</code> to <code>true</code> to use this parameter.</p> <p> You can have one IPv6 CIDR block association per network border group.</p>"]}
    let make ?amazon_provided_ipv6_cidr_block  ?cidr_block  ~vpc_id 
      ?ipv6_cidr_block_network_border_group  () =
      {
        amazon_provided_ipv6_cidr_block;
        cidr_block;
        vpc_id;
        ipv6_cidr_block_network_border_group
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.ipv6_cidr_block_network_border_group
              (fun f ->
                 Query.Pair
                   ("Ipv6CidrBlockNetworkBorderGroup", (String.to_query f)));
           Some (Query.Pair ("VpcId", (String.to_query v.vpc_id)));
           Util.option_map v.cidr_block
             (fun f -> Query.Pair ("CidrBlock", (String.to_query f)));
           Util.option_map v.amazon_provided_ipv6_cidr_block
             (fun f ->
                Query.Pair
                  ("AmazonProvidedIpv6CidrBlock", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.ipv6_cidr_block_network_border_group
              (fun f ->
                 ("ipv6_cidr_block_network_border_group", (String.to_json f)));
           Some ("vpc_id", (String.to_json v.vpc_id));
           Util.option_map v.cidr_block
             (fun f -> ("cidr_block", (String.to_json f)));
           Util.option_map v.amazon_provided_ipv6_cidr_block
             (fun f ->
                ("amazon_provided_ipv6_cidr_block", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          amazon_provided_ipv6_cidr_block =
            (Util.option_bind (Xml.member "amazonProvidedIpv6CidrBlock" xml)
               Boolean.parse);
          cidr_block =
            (Util.option_bind (Xml.member "CidrBlock" xml) String.parse);
          vpc_id =
            (Xml.required "vpcId"
               (Util.option_bind (Xml.member "vpcId" xml) String.parse));
          ipv6_cidr_block_network_border_group =
            (Util.option_bind
               (Xml.member "Ipv6CidrBlockNetworkBorderGroup" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.amazon_provided_ipv6_cidr_block
                 (fun f ->
                    Ezxmlm.make_tag "amazonProvidedIpv6CidrBlock"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.cidr_block
                (fun f -> Ezxmlm.make_tag "CidrBlock" ([], (String.to_xml f)))])
            @ [Some (Ezxmlm.make_tag "vpcId" ([], (String.to_xml v.vpc_id)))])
           @
           [Util.option_map v.ipv6_cidr_block_network_border_group
              (fun f ->
                 Ezxmlm.make_tag "Ipv6CidrBlockNetworkBorderGroup"
                   ([], (String.to_xml f)))])
  end
module AssociateVpcCidrBlockResult = AssociateVpcCidrBlockResult
type input = AssociateVpcCidrBlockRequest.t
type output = AssociateVpcCidrBlockResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["AssociateVpcCidrBlock"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssociateVpcCidrBlockRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AssociateVpcCidrBlockRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AssociateVpcCidrBlockResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AssociateVpcCidrBlockResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssociateVpcCidrBlockResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssociateVpcCidrBlockResult - missing field in body or children: "
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