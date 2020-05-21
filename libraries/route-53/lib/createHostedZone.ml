open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateHostedZoneRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the domain. Specify a fully qualified domain name, for example, <i>www.example.com</i>. The trailing dot is optional; Amazon Route 53 assumes that the domain name is fully qualified. This means that Route 53 treats <i>www.example.com</i> (without a trailing dot) and <i>www.example.com.</i> (with a trailing dot) as identical.</p> <p>If you're creating a public hosted zone, this is the name you have registered with your DNS registrar. If your domain name is registered with a registrar other than Route 53, change the name servers for your domain to the set of <code>NameServers</code> that <code>CreateHostedZone</code> returns in <code>DelegationSet</code>.</p>"];
      v_p_c: VPC.t option
        [@ocaml.doc
          "<p>(Private hosted zones only) A complex type that contains information about the Amazon VPC that you're associating with this hosted zone.</p> <p>You can specify only one Amazon VPC when you create a private hosted zone. To associate additional Amazon VPCs with the hosted zone, use <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_AssociateVPCWithHostedZone.html\">AssociateVPCWithHostedZone</a> after you create a hosted zone.</p>"];
      caller_reference: String.t
        [@ocaml.doc
          "<p>A unique string that identifies the request and that allows failed <code>CreateHostedZone</code> requests to be retried without the risk of executing the operation twice. You must use a unique <code>CallerReference</code> string every time you submit a <code>CreateHostedZone</code> request. <code>CallerReference</code> can be any unique string, for example, a date/time stamp.</p>"];
      hosted_zone_config: HostedZoneConfig.t option
        [@ocaml.doc
          "<p>(Optional) A complex type that contains the following optional values:</p> <ul> <li> <p>For public and private hosted zones, an optional comment</p> </li> <li> <p>For private hosted zones, an optional <code>PrivateZone</code> element</p> </li> </ul> <p>If you don't specify a comment or the <code>PrivateZone</code> element, omit <code>HostedZoneConfig</code> and the other elements.</p>"];
      delegation_set_id: String.t option
        [@ocaml.doc
          "<p>If you want to associate a reusable delegation set with this hosted zone, the ID that Amazon Route 53 assigned to the reusable delegation set when you created it. For more information about reusable delegation sets, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateReusableDelegationSet.html\">CreateReusableDelegationSet</a>.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the request to create a public or private hosted zone.</p>"]
    let make ~name  ?v_p_c  ~caller_reference  ?hosted_zone_config 
      ?delegation_set_id  () =
      { name; v_p_c; caller_reference; hosted_zone_config; delegation_set_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.delegation_set_id
              (fun f -> ("delegation_set_id", (String.to_json f)));
           Util.option_map v.hosted_zone_config
             (fun f -> ("hosted_zone_config", (HostedZoneConfig.to_json f)));
           Some ("caller_reference", (String.to_json v.caller_reference));
           Util.option_map v.v_p_c (fun f -> ("v_p_c", (VPC.to_json f)));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          v_p_c = (Util.option_bind (Xml.member "VPC" xml) VPC.parse);
          caller_reference =
            (Xml.required "CallerReference"
               (Util.option_bind (Xml.member "CallerReference" xml)
                  String.parse));
          hosted_zone_config =
            (Util.option_bind (Xml.member "HostedZoneConfig" xml)
               HostedZoneConfig.parse);
          delegation_set_id =
            (Util.option_bind (Xml.member "DelegationSetId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
              @
              [Util.option_map v.v_p_c
                 (fun f -> Ezxmlm.make_tag "VPC" ([], (VPC.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "CallerReference"
                   ([], (String.to_xml v.caller_reference)))])
            @
            [Util.option_map v.hosted_zone_config
               (fun f ->
                  Ezxmlm.make_tag "HostedZoneConfig"
                    ([], (HostedZoneConfig.to_xml f)))])
           @
           [Util.option_map v.delegation_set_id
              (fun f ->
                 Ezxmlm.make_tag "DelegationSetId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the request to create a public or private hosted zone.</p>"]
module CreateHostedZoneResponse = CreateHostedZoneResponse
type input = CreateHostedZoneRequest.t
type output = CreateHostedZoneResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/hostedzone"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateHostedZoneRequest.to_query req)))) in
  (`POST, uri, (Headers.render (CreateHostedZoneRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      match List.hd (snd xml) with
      | `El (_, xs) -> Some xs
      | _ ->
          raise
            (Failure "Could not find well formed CreateHostedZoneResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateHostedZoneResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateHostedZoneResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateHostedZoneResponse - missing field in body or children: "
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