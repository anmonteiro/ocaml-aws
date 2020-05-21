open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetHostedZoneLimitRequest =
  struct
    type t =
      {
      type_: HostedZoneLimitType.t
        [@ocaml.doc
          "<p>The limit that you want to get. Valid values include the following:</p> <ul> <li> <p> <b>MAX_RRSETS_BY_ZONE</b>: The maximum number of records that you can create in the specified hosted zone.</p> </li> <li> <p> <b>MAX_VPCS_ASSOCIATED_BY_ZONE</b>: The maximum number of Amazon VPCs that you can associate with the specified private hosted zone.</p> </li> </ul>"];
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that you want to get a limit for.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
    let make ~type_  ~hosted_zone_id  () = { type_; hosted_zone_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("hosted_zone_id", (String.to_json v.hosted_zone_id));
           Some ("type_", (HostedZoneLimitType.to_json v.type_))])
    let parse xml =
      Some
        {
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  HostedZoneLimitType.parse));
          hosted_zone_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Type"
                  ([], (HostedZoneLimitType.to_xml v.type_)))])
           @
           [Some
              (Ezxmlm.make_tag "Id" ([], (String.to_xml v.hosted_zone_id)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
module GetHostedZoneLimitResponse = GetHostedZoneLimitResponse
type input = GetHostedZoneLimitRequest.t
type output = GetHostedZoneLimitResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/2013-04-01/hostedzonelimit/" ^
                 req.GetHostedZoneLimitRequest.hosted_zone_id)
                ^ "/")
               ^
               (HostedZoneLimitType.to_string
                  req.GetHostedZoneLimitRequest.type_))))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetHostedZoneLimitRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetHostedZoneLimitRequest.to_headers req)),
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
            (Failure "Could not find well formed GetHostedZoneLimitResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp GetHostedZoneLimitResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetHostedZoneLimitResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetHostedZoneLimitResponse - missing field in body or children: "
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