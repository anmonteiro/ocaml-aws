open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module TestDNSAnswerRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you want Amazon Route 53 to simulate a query for.</p>"];
      record_name: String.t
        [@ocaml.doc
          "<p>The name of the resource record set that you want Amazon Route 53 to simulate a query for.</p>"];
      record_type: RRType.t
        [@ocaml.doc "<p>The type of the resource record set.</p>"];
      resolver_i_p: String.t option
        [@ocaml.doc
          "<p>If you want to simulate a request from a specific DNS resolver, specify the IP address for that resolver. If you omit this value, <code>TestDnsAnswer</code> uses the IP address of a DNS resolver in the AWS US East (N. Virginia) Region (<code>us-east-1</code>).</p>"];
      e_d_n_s0_client_subnet_i_p: String.t option
        [@ocaml.doc
          "<p>If the resolver that you specified for resolverip supports EDNS0, specify the IPv4 or IPv6 address of a client in the applicable location, for example, <code>192.0.2.44</code> or <code>2001:db8:85a3::8a2e:370:7334</code>.</p>"];
      e_d_n_s0_client_subnet_mask: String.t option
        [@ocaml.doc
          "<p>If you specify an IP address for <code>edns0clientsubnetip</code>, you can optionally specify the number of bits of the IP address that you want the checking tool to include in the DNS query. For example, if you specify <code>192.0.2.44</code> for <code>edns0clientsubnetip</code> and <code>24</code> for <code>edns0clientsubnetmask</code>, the checking tool will simulate a request from 192.0.2.0/24. The default value is 24 bits for IPv4 addresses and 64 bits for IPv6 addresses.</p> <p>The range of valid values depends on whether <code>edns0clientsubnetip</code> is an IPv4 or an IPv6 address:</p> <ul> <li> <p> <b>IPv4</b>: Specify a value between 0 and 32</p> </li> <li> <p> <b>IPv6</b>: Specify a value between 0 and 128</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Gets the value that Amazon Route 53 returns in response to a DNS request for a specified record name and type. You can optionally specify the IP address of a DNS resolver, an EDNS0 client subnet IP address, and a subnet mask. </p>"]
    let make ~hosted_zone_id  ~record_name  ~record_type  ?resolver_i_p 
      ?e_d_n_s0_client_subnet_i_p  ?e_d_n_s0_client_subnet_mask  () =
      {
        hosted_zone_id;
        record_name;
        record_type;
        resolver_i_p;
        e_d_n_s0_client_subnet_i_p;
        e_d_n_s0_client_subnet_mask
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.e_d_n_s0_client_subnet_mask
              (fun f ->
                 Query.Pair ("edns0clientsubnetmask", (String.to_query f)));
           Util.option_map v.e_d_n_s0_client_subnet_i_p
             (fun f ->
                Query.Pair ("edns0clientsubnetip", (String.to_query f)));
           Util.option_map v.resolver_i_p
             (fun f -> Query.Pair ("resolverip", (String.to_query f)));
           Some (Query.Pair ("recordtype", (RRType.to_query v.record_type)));
           Some (Query.Pair ("recordname", (String.to_query v.record_name)));
           Some
             (Query.Pair ("hostedzoneid", (String.to_query v.hosted_zone_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.e_d_n_s0_client_subnet_mask
              (fun f -> ("e_d_n_s0_client_subnet_mask", (String.to_json f)));
           Util.option_map v.e_d_n_s0_client_subnet_i_p
             (fun f -> ("e_d_n_s0_client_subnet_i_p", (String.to_json f)));
           Util.option_map v.resolver_i_p
             (fun f -> ("resolver_i_p", (String.to_json f)));
           Some ("record_type", (RRType.to_json v.record_type));
           Some ("record_name", (String.to_json v.record_name));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "hostedzoneid"
               (Util.option_bind (Xml.member "hostedzoneid" xml) String.parse));
          record_name =
            (Xml.required "recordname"
               (Util.option_bind (Xml.member "recordname" xml) String.parse));
          record_type =
            (Xml.required "recordtype"
               (Util.option_bind (Xml.member "recordtype" xml) RRType.parse));
          resolver_i_p =
            (Util.option_bind (Xml.member "resolverip" xml) String.parse);
          e_d_n_s0_client_subnet_i_p =
            (Util.option_bind (Xml.member "edns0clientsubnetip" xml)
               String.parse);
          e_d_n_s0_client_subnet_mask =
            (Util.option_bind (Xml.member "edns0clientsubnetmask" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "hostedzoneid"
                      ([], (String.to_xml v.hosted_zone_id)))])
               @
               [Some
                  (Ezxmlm.make_tag "recordname"
                     ([], (String.to_xml v.record_name)))])
              @
              [Some
                 (Ezxmlm.make_tag "recordtype"
                    ([], (RRType.to_xml v.record_type)))])
             @
             [Util.option_map v.resolver_i_p
                (fun f ->
                   Ezxmlm.make_tag "resolverip" ([], (String.to_xml f)))])
            @
            [Util.option_map v.e_d_n_s0_client_subnet_i_p
               (fun f ->
                  Ezxmlm.make_tag "edns0clientsubnetip"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.e_d_n_s0_client_subnet_mask
              (fun f ->
                 Ezxmlm.make_tag "edns0clientsubnetmask"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Gets the value that Amazon Route 53 returns in response to a DNS request for a specified record name and type. You can optionally specify the IP address of a DNS resolver, an EDNS0 client subnet IP address, and a subnet mask. </p>"]
module TestDNSAnswerResponse = TestDNSAnswerResponse
type input = TestDNSAnswerRequest.t
type output = TestDNSAnswerResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/testdnsanswer"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (TestDNSAnswerRequest.to_query req)))) in
  (`GET, uri, (Headers.render (TestDNSAnswerRequest.to_headers req)), "")
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
          raise (Failure "Could not find well formed TestDNSAnswerResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp TestDNSAnswerResponse.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed TestDNSAnswerResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing TestDNSAnswerResponse - missing field in body or children: "
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