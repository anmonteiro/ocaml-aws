open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module AssociateSubnetCidrBlockRequest =
  struct
    type t =
      {
      ipv6_cidr_block: String.t
        [@ocaml.doc
          "<p>The IPv6 CIDR block for your subnet. The subnet must have a /64 prefix length.</p>"];
      subnet_id: String.t [@ocaml.doc "<p>The ID of your subnet.</p>"]}
    let make ~ipv6_cidr_block  ~subnet_id  () =
      { ipv6_cidr_block; subnet_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("SubnetId", (String.to_query v.subnet_id)));
           Some
             (Query.Pair
                ("Ipv6CidrBlock", (String.to_query v.ipv6_cidr_block)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_id", (String.to_json v.subnet_id));
           Some ("ipv6_cidr_block", (String.to_json v.ipv6_cidr_block))])
    let parse xml =
      Some
        {
          ipv6_cidr_block =
            (Xml.required "ipv6CidrBlock"
               (Util.option_bind (Xml.member "ipv6CidrBlock" xml)
                  String.parse));
          subnet_id =
            (Xml.required "subnetId"
               (Util.option_bind (Xml.member "subnetId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "ipv6CidrBlock"
                  ([], (String.to_xml v.ipv6_cidr_block)))])
           @
           [Some
              (Ezxmlm.make_tag "subnetId" ([], (String.to_xml v.subnet_id)))])
  end
module AssociateSubnetCidrBlockResult = AssociateSubnetCidrBlockResult
type input = AssociateSubnetCidrBlockRequest.t
type output = AssociateSubnetCidrBlockResult.t
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
         ("Action", ["AssociateSubnetCidrBlock"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (AssociateSubnetCidrBlockRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (AssociateSubnetCidrBlockRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "AssociateSubnetCidrBlockResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp AssociateSubnetCidrBlockResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed AssociateSubnetCidrBlockResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing AssociateSubnetCidrBlockResult - missing field in body or children: "
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