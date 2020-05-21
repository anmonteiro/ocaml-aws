open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListHostedZonesByNameRequest =
  struct
    type t =
      {
      d_n_s_name: String.t option
        [@ocaml.doc
          "<p>(Optional) For your first request to <code>ListHostedZonesByName</code>, include the <code>dnsname</code> parameter only if you want to specify the name of the first hosted zone in the response. If you don't include the <code>dnsname</code> parameter, Amazon Route 53 returns all of the hosted zones that were created by the current AWS account, in ASCII order. For subsequent requests, include both <code>dnsname</code> and <code>hostedzoneid</code> parameters. For <code>dnsname</code>, specify the value of <code>NextDNSName</code> from the previous response.</p>"];
      hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>(Optional) For your first request to <code>ListHostedZonesByName</code>, do not include the <code>hostedzoneid</code> parameter.</p> <p>If you have more hosted zones than the value of <code>maxitems</code>, <code>ListHostedZonesByName</code> returns only the first <code>maxitems</code> hosted zones. To get the next group of <code>maxitems</code> hosted zones, submit another request to <code>ListHostedZonesByName</code> and include both <code>dnsname</code> and <code>hostedzoneid</code> parameters. For the value of <code>hostedzoneid</code>, specify the value of the <code>NextHostedZoneId</code> element from the previous response.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>The maximum number of hosted zones to be included in the response body for this request. If you have more than <code>maxitems</code> hosted zones, then the value of the <code>IsTruncated</code> element in the response is true, and the values of <code>NextDNSName</code> and <code>NextHostedZoneId</code> specify the first hosted zone in the next group of <code>maxitems</code> hosted zones. </p>"]}
    [@@ocaml.doc
      "<p>Retrieves a list of the public and private hosted zones that are associated with the current AWS account in ASCII order by domain name. </p>"]
    let make ?d_n_s_name  ?hosted_zone_id  ?max_items  () =
      { d_n_s_name; hosted_zone_id; max_items }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.hosted_zone_id
             (fun f -> Query.Pair ("hostedzoneid", (String.to_query f)));
           Util.option_map v.d_n_s_name
             (fun f -> Query.Pair ("dnsname", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.hosted_zone_id
             (fun f -> ("hosted_zone_id", (String.to_json f)));
           Util.option_map v.d_n_s_name
             (fun f -> ("d_n_s_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_n_s_name =
            (Util.option_bind (Xml.member "dnsname" xml) String.parse);
          hosted_zone_id =
            (Util.option_bind (Xml.member "hostedzoneid" xml) String.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.d_n_s_name
                (fun f -> Ezxmlm.make_tag "dnsname" ([], (String.to_xml f)))])
            @
            [Util.option_map v.hosted_zone_id
               (fun f ->
                  Ezxmlm.make_tag "hostedzoneid" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Retrieves a list of the public and private hosted zones that are associated with the current AWS account in ASCII order by domain name. </p>"]
module ListHostedZonesByNameResponse = ListHostedZonesByNameResponse
type input = ListHostedZonesByNameRequest.t
type output = ListHostedZonesByNameResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/hostedzonesbyname"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListHostedZonesByNameRequest.to_query req)))) in
  (`GET, uri, (Headers.render (ListHostedZonesByNameRequest.to_headers req)),
    "")
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
            (Failure
               "Could not find well formed ListHostedZonesByNameResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListHostedZonesByNameResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListHostedZonesByNameResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListHostedZonesByNameResponse - missing field in body or children: "
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