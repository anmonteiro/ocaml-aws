open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateLocalGatewayRouteTableVpcAssociationRequest =
  struct
    type t =
      {
      local_gateway_route_table_id: String.t
        [@ocaml.doc "<p>The ID of the local gateway route table.</p>"];
      vpc_id: String.t [@ocaml.doc "<p>The ID of the VPC.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ~local_gateway_route_table_id  ~vpc_id  ?dry_run  () =
      { local_gateway_route_table_id; vpc_id; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("VpcId", (String.to_query v.vpc_id)));
           Some
             (Query.Pair
                ("LocalGatewayRouteTableId",
                  (String.to_query v.local_gateway_route_table_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("vpc_id", (String.to_json v.vpc_id));
           Some
             ("local_gateway_route_table_id",
               (String.to_json v.local_gateway_route_table_id))])
    let parse xml =
      Some
        {
          local_gateway_route_table_id =
            (Xml.required "LocalGatewayRouteTableId"
               (Util.option_bind (Xml.member "LocalGatewayRouteTableId" xml)
                  String.parse));
          vpc_id =
            (Xml.required "VpcId"
               (Util.option_bind (Xml.member "VpcId" xml) String.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "LocalGatewayRouteTableId"
                   ([], (String.to_xml v.local_gateway_route_table_id)))])
            @ [Some (Ezxmlm.make_tag "VpcId" ([], (String.to_xml v.vpc_id)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module CreateLocalGatewayRouteTableVpcAssociationResult =
  CreateLocalGatewayRouteTableVpcAssociationResult
type input = CreateLocalGatewayRouteTableVpcAssociationRequest.t
type output = CreateLocalGatewayRouteTableVpcAssociationResult.t
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
         ("Action", ["CreateLocalGatewayRouteTableVpcAssociation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateLocalGatewayRouteTableVpcAssociationRequest.to_query
                     req))))) in
  (`POST, uri,
    (Headers.render
       (CreateLocalGatewayRouteTableVpcAssociationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "CreateLocalGatewayRouteTableVpcAssociationResponse"
        (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             CreateLocalGatewayRouteTableVpcAssociationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateLocalGatewayRouteTableVpcAssociationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateLocalGatewayRouteTableVpcAssociationResult - missing field in body or children: "
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