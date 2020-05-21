open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssociateRouteTableRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      route_table_id: String.t
        [@ocaml.doc "<p>The ID of the route table.</p>"];
      subnet_id: String.t option [@ocaml.doc "<p>The ID of the subnet.</p>"];
      gateway_id: String.t option
        [@ocaml.doc
          "<p>The ID of the internet gateway or virtual private gateway.</p>"]}
    let make ?dry_run  ~route_table_id  ?subnet_id  ?gateway_id  () =
      { dry_run; route_table_id; subnet_id; gateway_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.gateway_id
              (fun f -> Query.Pair ("GatewayId", (String.to_query f)));
           Util.option_map v.subnet_id
             (fun f -> Query.Pair ("SubnetId", (String.to_query f)));
           Some
             (Query.Pair ("RouteTableId", (String.to_query v.route_table_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.gateway_id
              (fun f -> ("gateway_id", (String.to_json f)));
           Util.option_map v.subnet_id
             (fun f -> ("subnet_id", (String.to_json f)));
           Some ("route_table_id", (String.to_json v.route_table_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          route_table_id =
            (Xml.required "routeTableId"
               (Util.option_bind (Xml.member "routeTableId" xml) String.parse));
          subnet_id =
            (Util.option_bind (Xml.member "subnetId" xml) String.parse);
          gateway_id =
            (Util.option_bind (Xml.member "GatewayId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "routeTableId"
                   ([], (String.to_xml v.route_table_id)))])
            @
            [Util.option_map v.subnet_id
               (fun f -> Ezxmlm.make_tag "subnetId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.gateway_id
              (fun f -> Ezxmlm.make_tag "GatewayId" ([], (String.to_xml f)))])
  end
module AssociateRouteTableResult = AssociateRouteTableResult
type input = AssociateRouteTableRequest.t
type output = AssociateRouteTableResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["AssociateRouteTable"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssociateRouteTableRequest.to_query req))))) in
  (`POST, uri, (Headers.render (AssociateRouteTableRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AssociateRouteTableResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp AssociateRouteTableResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssociateRouteTableResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssociateRouteTableResult - missing field in body or children: "
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