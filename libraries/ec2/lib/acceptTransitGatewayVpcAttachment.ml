open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AcceptTransitGatewayVpcAttachmentRequest =
  struct
    type t =
      {
      transit_gateway_attachment_id: String.t
        [@ocaml.doc "<p>The ID of the attachment.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~transit_gateway_attachment_id  ?dry_run  () =
      { transit_gateway_attachment_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TransitGatewayAttachmentId",
                  (String.to_query v.transit_gateway_attachment_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("transit_gateway_attachment_id",
               (String.to_json v.transit_gateway_attachment_id))])
    let parse xml =
      Some
        {
          transit_gateway_attachment_id =
            (Xml.required "TransitGatewayAttachmentId"
               (Util.option_bind
                  (Xml.member "TransitGatewayAttachmentId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "TransitGatewayAttachmentId"
                  ([], (String.to_xml v.transit_gateway_attachment_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module AcceptTransitGatewayVpcAttachmentResult =
  AcceptTransitGatewayVpcAttachmentResult
type input = AcceptTransitGatewayVpcAttachmentRequest.t
type output = AcceptTransitGatewayVpcAttachmentResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]);
         ("Action", ["AcceptTransitGatewayVpcAttachment"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (AcceptTransitGatewayVpcAttachmentRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AcceptTransitGatewayVpcAttachmentRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "AcceptTransitGatewayVpcAttachmentResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             AcceptTransitGatewayVpcAttachmentResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AcceptTransitGatewayVpcAttachmentResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AcceptTransitGatewayVpcAttachmentResult - missing field in body or children: "
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