open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpcPeeringConnectionRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      peer_owner_id: String.t option
        [@ocaml.doc
          "<p>The AWS account ID of the owner of the accepter VPC.</p> <p>Default: Your AWS account ID</p>"];
      peer_vpc_id: String.t option
        [@ocaml.doc
          "<p>The ID of the VPC with which you are creating the VPC peering connection. You must specify this parameter in the request.</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>The ID of the requester VPC. You must specify this parameter in the request.</p>"];
      peer_region: String.t option
        [@ocaml.doc
          "<p>The Region code for the accepter VPC, if the accepter VPC is located in a Region other than the Region in which you make the request.</p> <p>Default: The Region in which you make the request.</p>"]}
    let make ?dry_run  ?peer_owner_id  ?peer_vpc_id  ?vpc_id  ?peer_region 
      () = { dry_run; peer_owner_id; peer_vpc_id; vpc_id; peer_region }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.peer_region
              (fun f -> Query.Pair ("PeerRegion", (String.to_query f)));
           Util.option_map v.vpc_id
             (fun f -> Query.Pair ("VpcId", (String.to_query f)));
           Util.option_map v.peer_vpc_id
             (fun f -> Query.Pair ("PeerVpcId", (String.to_query f)));
           Util.option_map v.peer_owner_id
             (fun f -> Query.Pair ("PeerOwnerId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.peer_region
              (fun f -> ("peer_region", (String.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.peer_vpc_id
             (fun f -> ("peer_vpc_id", (String.to_json f)));
           Util.option_map v.peer_owner_id
             (fun f -> ("peer_owner_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          peer_owner_id =
            (Util.option_bind (Xml.member "peerOwnerId" xml) String.parse);
          peer_vpc_id =
            (Util.option_bind (Xml.member "peerVpcId" xml) String.parse);
          vpc_id = (Util.option_bind (Xml.member "vpcId" xml) String.parse);
          peer_region =
            (Util.option_bind (Xml.member "PeerRegion" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.peer_owner_id
                 (fun f ->
                    Ezxmlm.make_tag "peerOwnerId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.peer_vpc_id
                (fun f -> Ezxmlm.make_tag "peerVpcId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.vpc_id
               (fun f -> Ezxmlm.make_tag "vpcId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.peer_region
              (fun f -> Ezxmlm.make_tag "PeerRegion" ([], (String.to_xml f)))])
  end
module CreateVpcPeeringConnectionResult = CreateVpcPeeringConnectionResult
type input = CreateVpcPeeringConnectionRequest.t
type output = CreateVpcPeeringConnectionResult.t
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
         ("Action", ["CreateVpcPeeringConnection"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateVpcPeeringConnectionRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateVpcPeeringConnectionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateVpcPeeringConnectionResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateVpcPeeringConnectionResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateVpcPeeringConnectionResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateVpcPeeringConnectionResult - missing field in body or children: "
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