open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetReusableDelegationSetLimitRequest =
  struct
    type t =
      {
      type_: ReusableDelegationSetLimitType.t
        [@ocaml.doc
          "<p>Specify <code>MAX_ZONES_BY_REUSABLE_DELEGATION_SET</code> to get the maximum number of hosted zones that you can associate with the specified reusable delegation set.</p>"];
      delegation_set_id: String.t
        [@ocaml.doc
          "<p>The ID of the delegation set that you want to get the limit for.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
    let make ~type_  ~delegation_set_id  () = { type_; delegation_set_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("delegation_set_id", (String.to_json v.delegation_set_id));
           Some ("type_", (ReusableDelegationSetLimitType.to_json v.type_))])
    let parse xml =
      Some
        {
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml)
                  ReusableDelegationSetLimitType.parse));
          delegation_set_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Type"
                  ([], (ReusableDelegationSetLimitType.to_xml v.type_)))])
           @
           [Some
              (Ezxmlm.make_tag "Id" ([], (String.to_xml v.delegation_set_id)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the request to create a hosted zone.</p>"]
module GetReusableDelegationSetLimitResponse =
  GetReusableDelegationSetLimitResponse
type input = GetReusableDelegationSetLimitRequest.t
type output = GetReusableDelegationSetLimitResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/2013-04-01/reusabledelegationsetlimit/" ^
                 req.GetReusableDelegationSetLimitRequest.delegation_set_id)
                ^ "/")
               ^
               (ReusableDelegationSetLimitType.to_string
                  req.GetReusableDelegationSetLimitRequest.type_))))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetReusableDelegationSetLimitRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (GetReusableDelegationSetLimitRequest.to_headers req)),
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
               "Could not find well formed GetReusableDelegationSetLimitResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp GetReusableDelegationSetLimitResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetReusableDelegationSetLimitResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetReusableDelegationSetLimitResponse - missing field in body or children: "
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