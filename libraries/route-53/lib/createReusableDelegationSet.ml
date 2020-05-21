open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateReusableDelegationSetRequest =
  struct
    type t =
      {
      caller_reference: String.t
        [@ocaml.doc
          "<p>A unique string that identifies the request, and that allows you to retry failed <code>CreateReusableDelegationSet</code> requests without the risk of executing the operation twice. You must use a unique <code>CallerReference</code> string every time you submit a <code>CreateReusableDelegationSet</code> request. <code>CallerReference</code> can be any unique string, for example a date/time stamp.</p>"];
      hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>If you want to mark the delegation set for an existing hosted zone as reusable, the ID for that hosted zone.</p>"]}
    let make ~caller_reference  ?hosted_zone_id  () =
      { caller_reference; hosted_zone_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.hosted_zone_id
              (fun f -> ("hosted_zone_id", (String.to_json f)));
           Some ("caller_reference", (String.to_json v.caller_reference))])
    let parse xml =
      Some
        {
          caller_reference =
            (Xml.required "CallerReference"
               (Util.option_bind (Xml.member "CallerReference" xml)
                  String.parse));
          hosted_zone_id =
            (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "CallerReference"
                  ([], (String.to_xml v.caller_reference)))])
           @
           [Util.option_map v.hosted_zone_id
              (fun f ->
                 Ezxmlm.make_tag "HostedZoneId" ([], (String.to_xml f)))])
  end
module CreateReusableDelegationSetResponse =
  CreateReusableDelegationSetResponse
type input = CreateReusableDelegationSetRequest.t
type output = CreateReusableDelegationSetResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            "/2013-04-01/delegationset"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (CreateReusableDelegationSetRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CreateReusableDelegationSetRequest.to_headers req)), "")
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
               "Could not find well formed CreateReusableDelegationSetResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateReusableDelegationSetResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateReusableDelegationSetResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateReusableDelegationSetResponse - missing field in body or children: "
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