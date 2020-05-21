open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpcPeeringConnectionOptionsRequest =
  struct
    type t =
      {
      accepter_peering_connection_options:
        PeeringConnectionOptionsRequest.t option
        [@ocaml.doc
          "<p>The VPC peering connection options for the accepter VPC.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      requester_peering_connection_options:
        PeeringConnectionOptionsRequest.t option
        [@ocaml.doc
          "<p>The VPC peering connection options for the requester VPC.</p>"];
      vpc_peering_connection_id: String.t
        [@ocaml.doc "<p>The ID of the VPC peering connection.</p>"]}
    let make ?accepter_peering_connection_options  ?dry_run 
      ?requester_peering_connection_options  ~vpc_peering_connection_id  () =
      {
        accepter_peering_connection_options;
        dry_run;
        requester_peering_connection_options;
        vpc_peering_connection_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("VpcPeeringConnectionId",
                   (String.to_query v.vpc_peering_connection_id)));
           Util.option_map v.requester_peering_connection_options
             (fun f ->
                Query.Pair
                  ("RequesterPeeringConnectionOptions",
                    (PeeringConnectionOptionsRequest.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.accepter_peering_connection_options
             (fun f ->
                Query.Pair
                  ("AccepterPeeringConnectionOptions",
                    (PeeringConnectionOptionsRequest.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("vpc_peering_connection_id",
                (String.to_json v.vpc_peering_connection_id));
           Util.option_map v.requester_peering_connection_options
             (fun f ->
                ("requester_peering_connection_options",
                  (PeeringConnectionOptionsRequest.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.accepter_peering_connection_options
             (fun f ->
                ("accepter_peering_connection_options",
                  (PeeringConnectionOptionsRequest.to_json f)))])
    let parse xml =
      Some
        {
          accepter_peering_connection_options =
            (Util.option_bind
               (Xml.member "AccepterPeeringConnectionOptions" xml)
               PeeringConnectionOptionsRequest.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          requester_peering_connection_options =
            (Util.option_bind
               (Xml.member "RequesterPeeringConnectionOptions" xml)
               PeeringConnectionOptionsRequest.parse);
          vpc_peering_connection_id =
            (Xml.required "VpcPeeringConnectionId"
               (Util.option_bind (Xml.member "VpcPeeringConnectionId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.accepter_peering_connection_options
                 (fun f ->
                    Ezxmlm.make_tag "AccepterPeeringConnectionOptions"
                      ([], (PeeringConnectionOptionsRequest.to_xml f)))])
             @
             [Util.option_map v.dry_run
                (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.requester_peering_connection_options
               (fun f ->
                  Ezxmlm.make_tag "RequesterPeeringConnectionOptions"
                    ([], (PeeringConnectionOptionsRequest.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "VpcPeeringConnectionId"
                 ([], (String.to_xml v.vpc_peering_connection_id)))])
  end
module ModifyVpcPeeringConnectionOptionsResult =
  ModifyVpcPeeringConnectionOptionsResult
type input = ModifyVpcPeeringConnectionOptionsRequest.t
type output = ModifyVpcPeeringConnectionOptionsResult.t
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
         ("Action", ["ModifyVpcPeeringConnectionOptions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyVpcPeeringConnectionOptionsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyVpcPeeringConnectionOptionsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ModifyVpcPeeringConnectionOptionsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyVpcPeeringConnectionOptionsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyVpcPeeringConnectionOptionsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVpcPeeringConnectionOptionsResult - missing field in body or children: "
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