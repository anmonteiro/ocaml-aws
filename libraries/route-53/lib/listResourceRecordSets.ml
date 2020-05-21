open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListResourceRecordSetsRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that contains the resource record sets that you want to list.</p>"];
      start_record_name: String.t option
        [@ocaml.doc
          "<p>The first name in the lexicographic ordering of resource record sets that you want to list.</p>"];
      start_record_type: RRType.t option
        [@ocaml.doc
          "<p>The type of resource record set to begin the record listing from.</p> <p>Valid values for basic resource record sets: <code>A</code> | <code>AAAA</code> | <code>CAA</code> | <code>CNAME</code> | <code>MX</code> | <code>NAPTR</code> | <code>NS</code> | <code>PTR</code> | <code>SOA</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code> </p> <p>Values for weighted, latency, geolocation, and failover resource record sets: <code>A</code> | <code>AAAA</code> | <code>CAA</code> | <code>CNAME</code> | <code>MX</code> | <code>NAPTR</code> | <code>PTR</code> | <code>SPF</code> | <code>SRV</code> | <code>TXT</code> </p> <p>Values for alias resource record sets: </p> <ul> <li> <p> <b>API Gateway custom regional API or edge-optimized API</b>: A</p> </li> <li> <p> <b>CloudFront distribution</b>: A or AAAA</p> </li> <li> <p> <b>Elastic Beanstalk environment that has a regionalized subdomain</b>: A</p> </li> <li> <p> <b>Elastic Load Balancing load balancer</b>: A | AAAA</p> </li> <li> <p> <b>Amazon S3 bucket</b>: A</p> </li> <li> <p> <b>Amazon VPC interface VPC endpoint</b>: A</p> </li> <li> <p> <b>Another resource record set in this hosted zone:</b> The type of the resource record set that the alias references.</p> </li> </ul> <p>Constraint: Specifying <code>type</code> without specifying <code>name</code> returns an <code>InvalidInput</code> error.</p>"];
      start_record_identifier: String.t option
        [@ocaml.doc
          "<p> <i>Resource record sets that have a routing policy other than simple:</i> If results were truncated for a given DNS name and type, specify the value of <code>NextRecordIdentifier</code> from the previous response to get the next resource record set that has the current DNS name and type.</p>"];
      max_items: String.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of resource records sets to include in the response body for this request. If the response includes more than <code>maxitems</code> resource record sets, the value of the <code>IsTruncated</code> element in the response is <code>true</code>, and the values of the <code>NextRecordName</code> and <code>NextRecordType</code> elements in the response identify the first resource record set in the next group of <code>maxitems</code> resource record sets.</p>"]}
    [@@ocaml.doc
      "<p>A request for the resource record sets that are associated with a specified hosted zone.</p>"]
    let make ~hosted_zone_id  ?start_record_name  ?start_record_type 
      ?start_record_identifier  ?max_items  () =
      {
        hosted_zone_id;
        start_record_name;
        start_record_type;
        start_record_identifier;
        max_items
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> Query.Pair ("maxitems", (String.to_query f)));
           Util.option_map v.start_record_identifier
             (fun f -> Query.Pair ("identifier", (String.to_query f)));
           Util.option_map v.start_record_type
             (fun f -> Query.Pair ("type", (RRType.to_query f)));
           Util.option_map v.start_record_name
             (fun f -> Query.Pair ("name", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_items
              (fun f -> ("max_items", (String.to_json f)));
           Util.option_map v.start_record_identifier
             (fun f -> ("start_record_identifier", (String.to_json f)));
           Util.option_map v.start_record_type
             (fun f -> ("start_record_type", (RRType.to_json f)));
           Util.option_map v.start_record_name
             (fun f -> ("start_record_name", (String.to_json f)));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          start_record_name =
            (Util.option_bind (Xml.member "name" xml) String.parse);
          start_record_type =
            (Util.option_bind (Xml.member "type" xml) RRType.parse);
          start_record_identifier =
            (Util.option_bind (Xml.member "identifier" xml) String.parse);
          max_items =
            (Util.option_bind (Xml.member "maxitems" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Id"
                     ([], (String.to_xml v.hosted_zone_id)))])
              @
              [Util.option_map v.start_record_name
                 (fun f -> Ezxmlm.make_tag "name" ([], (String.to_xml f)))])
             @
             [Util.option_map v.start_record_type
                (fun f -> Ezxmlm.make_tag "type" ([], (RRType.to_xml f)))])
            @
            [Util.option_map v.start_record_identifier
               (fun f -> Ezxmlm.make_tag "identifier" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_items
              (fun f -> Ezxmlm.make_tag "maxitems" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A request for the resource record sets that are associated with a specified hosted zone.</p>"]
module ListResourceRecordSetsResponse = ListResourceRecordSetsResponse
type input = ListResourceRecordSetsRequest.t
type output = ListResourceRecordSetsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/2013-04-01/hostedzone/" ^
                req.ListResourceRecordSetsRequest.hosted_zone_id)
               ^ "/rrset")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListResourceRecordSetsRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (ListResourceRecordSetsRequest.to_headers req)), "")
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
               "Could not find well formed ListResourceRecordSetsResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListResourceRecordSetsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListResourceRecordSetsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListResourceRecordSetsResponse - missing field in body or children: "
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