open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetTrafficPolicyRequest =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The ID of the traffic policy that you want to get information about.</p>"];
      version: Integer.t
        [@ocaml.doc
          "<p>The version number of the traffic policy that you want to get information about.</p>"]}
    [@@ocaml.doc
      "<p>Gets information about a specific traffic policy version.</p>"]
    let make ~id  ~version  () = { id; version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("version", (Integer.to_json v.version));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          version =
            (Xml.required "Version"
               (Util.option_bind (Xml.member "Version" xml) Integer.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
           [Some (Ezxmlm.make_tag "Version" ([], (Integer.to_xml v.version)))])
  end[@@ocaml.doc
       "<p>Gets information about a specific traffic policy version.</p>"]
module GetTrafficPolicyResponse = GetTrafficPolicyResponse
type input = GetTrafficPolicyRequest.t
type output = GetTrafficPolicyResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            ((("/2013-04-01/trafficpolicy/" ^ req.GetTrafficPolicyRequest.id)
                ^ "/")
               ^
               (Aws.BaseTypes.Integer.to_string
                  req.GetTrafficPolicyRequest.version))))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetTrafficPolicyRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetTrafficPolicyRequest.to_headers req)), "")
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
            (Failure "Could not find well formed GetTrafficPolicyResponse.") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetTrafficPolicyResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed GetTrafficPolicyResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetTrafficPolicyResponse - missing field in body or children: "
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