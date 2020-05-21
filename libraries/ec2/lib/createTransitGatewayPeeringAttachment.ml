open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTransitGatewayPeeringAttachmentRequest =
  struct
    type t =
      {
      transit_gateway_id: String.t
        [@ocaml.doc "<p>The ID of the transit gateway.</p>"];
      peer_transit_gateway_id: String.t
        [@ocaml.doc
          "<p>The ID of the peer transit gateway with which to create the peering attachment.</p>"];
      peer_account_id: String.t
        [@ocaml.doc
          "<p>The AWS account ID of the owner of the peer transit gateway.</p>"];
      peer_region: String.t
        [@ocaml.doc
          "<p>The Region where the peer transit gateway is located.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the transit gateway peering attachment.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~transit_gateway_id  ~peer_transit_gateway_id  ~peer_account_id 
      ~peer_region  ?(tag_specifications= [])  ?dry_run  () =
      {
        transit_gateway_id;
        peer_transit_gateway_id;
        peer_account_id;
        peer_region;
        tag_specifications;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Some (Query.Pair ("PeerRegion", (String.to_query v.peer_region)));
           Some
             (Query.Pair
                ("PeerAccountId", (String.to_query v.peer_account_id)));
           Some
             (Query.Pair
                ("PeerTransitGatewayId",
                  (String.to_query v.peer_transit_gateway_id)));
           Some
             (Query.Pair
                ("TransitGatewayId", (String.to_query v.transit_gateway_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Some ("peer_region", (String.to_json v.peer_region));
           Some ("peer_account_id", (String.to_json v.peer_account_id));
           Some
             ("peer_transit_gateway_id",
               (String.to_json v.peer_transit_gateway_id));
           Some ("transit_gateway_id", (String.to_json v.transit_gateway_id))])
    let parse xml =
      Some
        {
          transit_gateway_id =
            (Xml.required "TransitGatewayId"
               (Util.option_bind (Xml.member "TransitGatewayId" xml)
                  String.parse));
          peer_transit_gateway_id =
            (Xml.required "PeerTransitGatewayId"
               (Util.option_bind (Xml.member "PeerTransitGatewayId" xml)
                  String.parse));
          peer_account_id =
            (Xml.required "PeerAccountId"
               (Util.option_bind (Xml.member "PeerAccountId" xml)
                  String.parse));
          peer_region =
            (Xml.required "PeerRegion"
               (Util.option_bind (Xml.member "PeerRegion" xml) String.parse));
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "TransitGatewayId"
                      ([], (String.to_xml v.transit_gateway_id)))])
               @
               [Some
                  (Ezxmlm.make_tag "PeerTransitGatewayId"
                     ([], (String.to_xml v.peer_transit_gateway_id)))])
              @
              [Some
                 (Ezxmlm.make_tag "PeerAccountId"
                    ([], (String.to_xml v.peer_account_id)))])
             @
             [Some
                (Ezxmlm.make_tag "PeerRegion"
                   ([], (String.to_xml v.peer_region)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TagSpecification"
                       ([], (TagSpecificationList.to_xml [x]))))
               v.tag_specifications))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module CreateTransitGatewayPeeringAttachmentResult =
  CreateTransitGatewayPeeringAttachmentResult
type input = CreateTransitGatewayPeeringAttachmentRequest.t
type output = CreateTransitGatewayPeeringAttachmentResult.t
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
         ("Action", ["CreateTransitGatewayPeeringAttachment"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateTransitGatewayPeeringAttachmentRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (CreateTransitGatewayPeeringAttachmentRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "CreateTransitGatewayPeeringAttachmentResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             CreateTransitGatewayPeeringAttachmentResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTransitGatewayPeeringAttachmentResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTransitGatewayPeeringAttachmentResult - missing field in body or children: "
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