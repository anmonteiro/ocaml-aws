open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetAccountLimitRequest =
  struct
    type t =
      {
      type_: AccountLimitType.t
        [@ocaml.doc
          "<p>The limit that you want to get. Valid values include the following:</p> <ul> <li> <p> <b>MAX_HEALTH_CHECKS_BY_OWNER</b>: The maximum number of health checks that you can create using the current account.</p> </li> <li> <p> <b>MAX_HOSTED_ZONES_BY_OWNER</b>: The maximum number of hosted zones that you can create using the current account.</p> </li> <li> <p> <b>MAX_REUSABLE_DELEGATION_SETS_BY_OWNER</b>: The maximum number of reusable delegation sets that you can create using the current account.</p> </li> <li> <p> <b>MAX_TRAFFIC_POLICIES_BY_OWNER</b>: The maximum number of traffic policies that you can create using the current account.</p> </li> <li> <p> <b>MAX_TRAFFIC_POLICY_INSTANCES_BY_OWNER</b>: The maximum number of traffic policy instances that you can create using the current account. (Traffic policy instances are referred to as traffic flow policy records in the Amazon Route 53 console.)</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
    let make ~type_  () = { type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("type_", (AccountLimitType.to_json v.type_))])
    let parse xml =
      Some
        {
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  AccountLimitType.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Type" ([], (AccountLimitType.to_xml v.type_)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
module GetAccountLimitResponse = GetAccountLimitResponse
type input = GetAccountLimitRequest.t
type output = GetAccountLimitResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/accountlimit/" ^
               (AccountLimitType.to_string req.GetAccountLimitRequest.type_))))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetAccountLimitRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetAccountLimitRequest.to_headers req)), "")
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
            (Failure "Could not find well formed GetAccountLimitResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetAccountLimitResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetAccountLimitResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetAccountLimitResponse - missing field in body or children: "
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