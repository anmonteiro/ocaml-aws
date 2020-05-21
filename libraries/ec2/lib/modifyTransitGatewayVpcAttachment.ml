open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyTransitGatewayVpcAttachmentRequest =
  struct
    type t =
      {
      transit_gateway_attachment_id: String.t
        [@ocaml.doc "<p>The ID of the attachment.</p>"];
      add_subnet_ids: ValueStringList.t
        [@ocaml.doc
          "<p>The IDs of one or more subnets to add. You can specify at most one subnet per Availability Zone.</p>"];
      remove_subnet_ids: ValueStringList.t
        [@ocaml.doc "<p>The IDs of one or more subnets to remove.</p>"];
      options: ModifyTransitGatewayVpcAttachmentRequestOptions.t option
        [@ocaml.doc
          "<p>The new VPC attachment options.</p> <note> <p>You cannot modify the IPv6 options.</p> </note>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~transit_gateway_attachment_id  ?(add_subnet_ids= []) 
      ?(remove_subnet_ids= [])  ?options  ?dry_run  () =
      {
        transit_gateway_attachment_id;
        add_subnet_ids;
        remove_subnet_ids;
        options;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.options
             (fun f ->
                Query.Pair
                  ("Options",
                    (ModifyTransitGatewayVpcAttachmentRequestOptions.to_query
                       f)));
           Some
             (Query.Pair
                ("RemoveSubnetIds",
                  (ValueStringList.to_query v.remove_subnet_ids)));
           Some
             (Query.Pair
                ("AddSubnetIds", (ValueStringList.to_query v.add_subnet_ids)));
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
           Util.option_map v.options
             (fun f ->
                ("options",
                  (ModifyTransitGatewayVpcAttachmentRequestOptions.to_json f)));
           Some
             ("remove_subnet_ids",
               (ValueStringList.to_json v.remove_subnet_ids));
           Some
             ("add_subnet_ids", (ValueStringList.to_json v.add_subnet_ids));
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
          add_subnet_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddSubnetIds" xml)
                  ValueStringList.parse));
          remove_subnet_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "RemoveSubnetIds" xml)
                  ValueStringList.parse));
          options =
            (Util.option_bind (Xml.member "Options" xml)
               ModifyTransitGatewayVpcAttachmentRequestOptions.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "TransitGatewayAttachmentId"
                     ([], (String.to_xml v.transit_gateway_attachment_id)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "AddSubnetIds"
                         ([], (ValueStringList.to_xml [x]))))
                 v.add_subnet_ids))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "RemoveSubnetIds"
                        ([], (ValueStringList.to_xml [x]))))
                v.remove_subnet_ids))
            @
            [Util.option_map v.options
               (fun f ->
                  Ezxmlm.make_tag "Options"
                    ([],
                      (ModifyTransitGatewayVpcAttachmentRequestOptions.to_xml
                         f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module ModifyTransitGatewayVpcAttachmentResult =
  ModifyTransitGatewayVpcAttachmentResult
type input = ModifyTransitGatewayVpcAttachmentRequest.t
type output = ModifyTransitGatewayVpcAttachmentResult.t
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
         ("Action", ["ModifyTransitGatewayVpcAttachment"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyTransitGatewayVpcAttachmentRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyTransitGatewayVpcAttachmentRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ModifyTransitGatewayVpcAttachmentResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyTransitGatewayVpcAttachmentResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyTransitGatewayVpcAttachmentResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyTransitGatewayVpcAttachmentResult - missing field in body or children: "
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