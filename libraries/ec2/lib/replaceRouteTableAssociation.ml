open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReplaceRouteTableAssociationRequest =
  struct
    type t =
      {
      association_id: String.t [@ocaml.doc "<p>The association ID.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      route_table_id: String.t
        [@ocaml.doc
          "<p>The ID of the new route table to associate with the subnet.</p>"]}
    let make ~association_id  ?dry_run  ~route_table_id  () =
      { association_id; dry_run; route_table_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("RouteTableId", (String.to_query v.route_table_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("AssociationId", (String.to_query v.association_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("route_table_id", (String.to_json v.route_table_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("association_id", (String.to_json v.association_id))])
    let parse xml =
      Some
        {
          association_id =
            (Xml.required "associationId"
               (Util.option_bind (Xml.member "associationId" xml)
                  String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          route_table_id =
            (Xml.required "routeTableId"
               (Util.option_bind (Xml.member "routeTableId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "associationId"
                   ([], (String.to_xml v.association_id)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "routeTableId"
                 ([], (String.to_xml v.route_table_id)))])
  end
module ReplaceRouteTableAssociationResult =
  ReplaceRouteTableAssociationResult
type input = ReplaceRouteTableAssociationRequest.t
type output = ReplaceRouteTableAssociationResult.t
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
         ("Action", ["ReplaceRouteTableAssociation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ReplaceRouteTableAssociationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ReplaceRouteTableAssociationRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ReplaceRouteTableAssociationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ReplaceRouteTableAssociationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ReplaceRouteTableAssociationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReplaceRouteTableAssociationResult - missing field in body or children: "
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