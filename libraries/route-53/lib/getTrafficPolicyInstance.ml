open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetTrafficPolicyInstanceRequest =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy instance that you want to get information about.</p>"]}
    [@@ocaml.doc
      "<p>Gets information about a specified traffic policy instance.</p>"]
    let make ~id  () = { id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
  end[@@ocaml.doc
       "<p>Gets information about a specified traffic policy instance.</p>"]
module GetTrafficPolicyInstanceResponse = GetTrafficPolicyInstanceResponse
type input = GetTrafficPolicyInstanceRequest.t
type output = GetTrafficPolicyInstanceResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ("/2013-04-01/trafficpolicyinstance/" ^
               req.GetTrafficPolicyInstanceRequest.id)))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetTrafficPolicyInstanceRequest.to_query req)))) in
  (`GET, uri,
    (Headers.render (GetTrafficPolicyInstanceRequest.to_headers req)), "")
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
               "Could not find well formed GetTrafficPolicyInstanceResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp GetTrafficPolicyInstanceResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetTrafficPolicyInstanceResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetTrafficPolicyInstanceResponse - missing field in body or children: "
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