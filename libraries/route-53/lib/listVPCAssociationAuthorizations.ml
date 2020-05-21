open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListVPCAssociationAuthorizationsRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone for which you want a list of VPCs that can be associated with the hosted zone.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p> <i>Optional</i>: If a response includes a <code>NextToken</code> element, there are more VPCs that can be associated with the specified hosted zone. To get the next page of results, submit another request, and include the value of <code>NextToken</code> from the response in the <code>nexttoken</code> parameter in another <code>ListVPCAssociationAuthorizations</code> request.</p>"];
      max_results: String.t option
        [@ocaml.doc
          "<p> <i>Optional</i>: An integer that specifies the maximum number of VPCs that you want Amazon Route 53 to return. If you don't specify a value for <code>MaxResults</code>, Route 53 returns up to 50 VPCs per page.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about that can be associated with your hosted zone.</p>"]
    let make ~hosted_zone_id  ?next_token  ?max_results  () =
      { hosted_zone_id; next_token; max_results }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> Query.Pair ("maxresults", (String.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("nexttoken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_results
              (fun f -> ("max_results", (String.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          next_token =
            (Util.option_bind (Xml.member "nexttoken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "maxresults" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "Id" ([], (String.to_xml v.hosted_zone_id)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "nexttoken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.max_results
              (fun f -> Ezxmlm.make_tag "maxresults" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about that can be associated with your hosted zone.</p>"]
module ListVPCAssociationAuthorizationsResponse =
  ListVPCAssociationAuthorizationsResponse
type input = ListVPCAssociationAuthorizationsRequest.t
type output = ListVPCAssociationAuthorizationsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/2013-04-01/hostedzone/" ^
                req.ListVPCAssociationAuthorizationsRequest.hosted_zone_id)
               ^ "/authorizevpcassociation")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render
               (ListVPCAssociationAuthorizationsRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (ListVPCAssociationAuthorizationsRequest.to_headers req)),
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
               "Could not find well formed ListVPCAssociationAuthorizationsResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ListVPCAssociationAuthorizationsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ListVPCAssociationAuthorizationsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListVPCAssociationAuthorizationsResponse - missing field in body or children: "
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