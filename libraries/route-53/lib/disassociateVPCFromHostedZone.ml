open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DisassociateVPCFromHostedZoneRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the private hosted zone that you want to disassociate a VPC from.</p>"];
      v_p_c: VPC.t
        [@ocaml.doc
          "<p>A complex type that contains information about the VPC that you're disassociating from the specified hosted zone.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p> <i>Optional:</i> A comment about the disassociation request.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains information about the VPC that you want to disassociate from a specified private hosted zone.</p>"]
    let make ~hosted_zone_id  ~v_p_c  ?comment  () =
      { hosted_zone_id; v_p_c; comment }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.comment
              (fun f -> ("comment", (String.to_json f)));
           Some ("v_p_c", (VPC.to_json v.v_p_c));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          v_p_c =
            (Xml.required "VPC"
               (Util.option_bind (Xml.member "VPC" xml) VPC.parse));
          comment =
            (Util.option_bind (Xml.member "Comment" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "Id" ([], (String.to_xml v.hosted_zone_id)))])
            @ [Some (Ezxmlm.make_tag "VPC" ([], (VPC.to_xml v.v_p_c)))])
           @
           [Util.option_map v.comment
              (fun f -> Ezxmlm.make_tag "Comment" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A complex type that contains information about the VPC that you want to disassociate from a specified private hosted zone.</p>"]
module DisassociateVPCFromHostedZoneResponse =
  DisassociateVPCFromHostedZoneResponse
type input = DisassociateVPCFromHostedZoneRequest.t
type output = DisassociateVPCFromHostedZoneResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/2013-04-01/hostedzone/" ^
                req.DisassociateVPCFromHostedZoneRequest.hosted_zone_id)
               ^ "/disassociatevpc")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (DisassociateVPCFromHostedZoneRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DisassociateVPCFromHostedZoneRequest.to_headers req)),
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
               "Could not find well formed DisassociateVPCFromHostedZoneResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DisassociateVPCFromHostedZoneResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DisassociateVPCFromHostedZoneResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DisassociateVPCFromHostedZoneResponse - missing field in body or children: "
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