open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteNatGatewayRequest =
  struct
    type t =
      {
      nat_gateway_id: String.t
        [@ocaml.doc "<p>The ID of the NAT gateway.</p>"]}
    let make ~nat_gateway_id  () = { nat_gateway_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("NatGatewayId", (String.to_query v.nat_gateway_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("nat_gateway_id", (String.to_json v.nat_gateway_id))])
    let parse xml =
      Some
        {
          nat_gateway_id =
            (Xml.required "NatGatewayId"
               (Util.option_bind (Xml.member "NatGatewayId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "NatGatewayId"
                 ([], (String.to_xml v.nat_gateway_id)))])
  end
module DeleteNatGatewayResult = DeleteNatGatewayResult
type input = DeleteNatGatewayRequest.t
type output = DeleteNatGatewayResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DeleteNatGateway"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteNatGatewayRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteNatGatewayRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DeleteNatGatewayResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteNatGatewayResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteNatGatewayResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteNatGatewayResult - missing field in body or children: "
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