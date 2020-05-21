open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTransitGatewayRequest =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc "<p>A description of the transit gateway.</p>"];
      options: TransitGatewayRequestOptions.t option
        [@ocaml.doc "<p>The transit gateway options.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc "<p>The tags to apply to the transit gateway.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?description  ?options  ?(tag_specifications= [])  ?dry_run  ()
      = { description; options; tag_specifications; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.options
             (fun f ->
                Query.Pair
                  ("Options", (TransitGatewayRequestOptions.to_query f)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)))])
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
             (fun f -> ("options", (TransitGatewayRequestOptions.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          options =
            (Util.option_bind (Xml.member "Options" xml)
               TransitGatewayRequestOptions.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
             @
             [Util.option_map v.options
                (fun f ->
                   Ezxmlm.make_tag "Options"
                     ([], (TransitGatewayRequestOptions.to_xml f)))])
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
module CreateTransitGatewayResult = CreateTransitGatewayResult
type input = CreateTransitGatewayRequest.t
type output = CreateTransitGatewayResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateTransitGateway"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateTransitGatewayRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateTransitGatewayRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateTransitGatewayResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTransitGatewayResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTransitGatewayResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTransitGatewayResult - missing field in body or children: "
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