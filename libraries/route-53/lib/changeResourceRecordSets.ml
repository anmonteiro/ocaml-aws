open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ChangeResourceRecordSetsRequest =
  struct
    type t =
      {
      hosted_zone_id: String.t
        [@ocaml.doc
          "<p>The ID of the hosted zone that contains the resource record sets that you want to change.</p>"];
      change_batch: ChangeBatch.t
        [@ocaml.doc
          "<p>A complex type that contains an optional comment and the <code>Changes</code> element.</p>"]}
    [@@ocaml.doc
      "<p>A complex type that contains change information for the resource record set.</p>"]
    let make ~hosted_zone_id  ~change_batch  () =
      { hosted_zone_id; change_batch }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("change_batch", (ChangeBatch.to_json v.change_batch));
           Some ("hosted_zone_id", (String.to_json v.hosted_zone_id))])
    let parse xml =
      Some
        {
          hosted_zone_id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          change_batch =
            (Xml.required "ChangeBatch"
               (Util.option_bind (Xml.member "ChangeBatch" xml)
                  ChangeBatch.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Id" ([], (String.to_xml v.hosted_zone_id)))])
           @
           [Some
              (Ezxmlm.make_tag "ChangeBatch"
                 ([], (ChangeBatch.to_xml v.change_batch)))])
  end[@@ocaml.doc
       "<p>A complex type that contains change information for the resource record set.</p>"]
module ChangeResourceRecordSetsResponse = ChangeResourceRecordSetsResponse
type input = ChangeResourceRecordSetsRequest.t
type output = ChangeResourceRecordSetsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "route53"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (("/2013-04-01/hostedzone/" ^
                req.ChangeResourceRecordSetsRequest.hosted_zone_id)
               ^ "/rrset/")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (ChangeResourceRecordSetsRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (ChangeResourceRecordSetsRequest.to_headers req)), "")
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
               "Could not find well formed ChangeResourceRecordSetsResponse.") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ChangeResourceRecordSetsResponse.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ChangeResourceRecordSetsResponse."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ChangeResourceRecordSetsResponse - missing field in body or children: "
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