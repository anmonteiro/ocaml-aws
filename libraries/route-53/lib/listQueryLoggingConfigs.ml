open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListQueryLoggingConfigsRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>(Optional) If you want to list the query logging configuration that is associated with a hosted zone, specify the ID in <code>HostedZoneId</code>. </p> <p>If you don't specify a hosted zone ID, <code>ListQueryLoggingConfigs</code> returns all of the configurations that are associated with the current AWS account.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>(Optional) If the current AWS account has more than <code>MaxResults</code> query logging configurations, use <code>NextToken</code> to get the second and subsequent pages of results.</p> <p>For the first <code>ListQueryLoggingConfigs</code> request, omit this value.</p> <p>For the second and subsequent requests, get the value of <code>NextToken</code> from the previous response and specify that value for <code>NextToken</code> in the request.</p>"];
      max_results: String.t option
        [@ocaml.doc
          "<p>(Optional) The maximum number of query logging configurations that you want Amazon Route 53 to return in response to the current request. If the current AWS account has more than <code>MaxResults</code> configurations, use the value of <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_ListQueryLoggingConfigs.html#API_ListQueryLoggingConfigs_RequestSyntax\">NextToken</a> in the response to get the next page of results.</p> <p>If you don't specify a value for <code>MaxResults</code>, Route 53 returns up to 100 configurations.</p>"]}
    let make ?hosted_zone_id  ?next_token  ?max_results  () =
      { hosted_zone_id; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("maxresults", (String.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("nexttoken", (String.to_query f)));
           Util.option_map v.hosted_zone_id
             (fun f -> Query.Pair ("hostedzoneid", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (String.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.hosted_zone_id
             (fun f -> ("hosted_zone_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Util.option_bind (Xml.member "hostedzoneid" xml) String.parse);
          next_token =
            (Util.option_bind (Xml.member "nexttoken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "maxresults" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.hosted_zone_id
                (fun f ->
                   Ezxmlm.make_tag "hostedzoneid" ([], (String.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "nexttoken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "maxresults" ([], (String.to_xml f)))])
  end
module ListQueryLoggingConfigsResponse = ListQueryLoggingConfigsResponse
type input = ListQueryLoggingConfigsRequest.t
type output = ListQueryLoggingConfigsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/queryloggingconfig"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ListQueryLoggingConfigsRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (ListQueryLoggingConfigsRequest.to_headers req)), "")
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
               "Could not find well formed ListQueryLoggingConfigsResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ListQueryLoggingConfigsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListQueryLoggingConfigsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListQueryLoggingConfigsResponse - missing field in body or children: "
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