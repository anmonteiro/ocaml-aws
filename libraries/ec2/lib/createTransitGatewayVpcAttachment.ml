open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTransitGatewayVpcAttachmentRequest =
  struct
    type t =
      {
      transit_gateway_id: String.t
        [@ocaml.doc "<p>The ID of the transit gateway.</p>"];
      vpc_id: String.t [@ocaml.doc "<p>The ID of the VPC.</p>"];
      subnet_ids: ValueStringList.t
        [@ocaml.doc
          "<p>The IDs of one or more subnets. You can specify only one subnet per Availability Zone. You must specify at least one subnet, but we recommend that you specify two subnets for better availability. The transit gateway uses one IP address from each specified subnet.</p>"];
      options: CreateTransitGatewayVpcAttachmentRequestOptions.t option
        [@ocaml.doc "<p>The VPC attachment options.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc "<p>The tags to apply to the VPC attachment.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~transit_gateway_id  ~vpc_id  ~subnet_ids  ?options 
      ?(tag_specifications= [])  ?dry_run  () =
      {
        transit_gateway_id;
        vpc_id;
        subnet_ids;
        options;
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
                ("TagSpecifications",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.options
             (fun f ->
                Query.Pair
                  ("Options",
                    (CreateTransitGatewayVpcAttachmentRequestOptions.to_query
                       f)));
           Some
             (Query.Pair
                ("SubnetIds", (ValueStringList.to_query v.subnet_ids)));
           Some (Query.Pair ("VpcId", (String.to_query v.vpc_id)));
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
           Util.option_map v.options
             (fun f ->
                ("options",
                  (CreateTransitGatewayVpcAttachmentRequestOptions.to_json f)));
           Some ("subnet_ids", (ValueStringList.to_json v.subnet_ids));
           Some ("vpc_id", (String.to_json v.vpc_id));
           Some ("transit_gateway_id", (String.to_json v.transit_gateway_id))])
    let parse xml =
      Some
        {
          transit_gateway_id =
            (Xml.required "TransitGatewayId"
               (Util.option_bind (Xml.member "TransitGatewayId" xml)
                  String.parse));
          vpc_id =
            (Xml.required "VpcId"
               (Util.option_bind (Xml.member "VpcId" xml) String.parse));
          subnet_ids =
            (Xml.required "SubnetIds"
               (Util.option_bind (Xml.member "SubnetIds" xml)
                  ValueStringList.parse));
          options =
            (Util.option_bind (Xml.member "Options" xml)
               CreateTransitGatewayVpcAttachmentRequestOptions.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecifications" xml)
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
               [Some (Ezxmlm.make_tag "VpcId" ([], (String.to_xml v.vpc_id)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "SubnetIds"
                         ([], (ValueStringList.to_xml [x])))) v.subnet_ids))
             @
             [Util.option_map v.options
                (fun f ->
                   Ezxmlm.make_tag "Options"
                     ([],
                       (CreateTransitGatewayVpcAttachmentRequestOptions.to_xml
                          f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TagSpecifications"
                       ([], (TagSpecificationList.to_xml [x]))))
               v.tag_specifications))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module CreateTransitGatewayVpcAttachmentResult =
  CreateTransitGatewayVpcAttachmentResult
type input = CreateTransitGatewayVpcAttachmentRequest.t
type output = CreateTransitGatewayVpcAttachmentResult.t
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
         ("Action", ["CreateTransitGatewayVpcAttachment"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateTransitGatewayVpcAttachmentRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateTransitGatewayVpcAttachmentRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "CreateTransitGatewayVpcAttachmentResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             CreateTransitGatewayVpcAttachmentResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTransitGatewayVpcAttachmentResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTransitGatewayVpcAttachmentResult - missing field in body or children: "
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