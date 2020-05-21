open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateNatGatewayRequest =
  struct
    type t =
      {
      allocation_id: String.t
        [@ocaml.doc
          "<p>The allocation ID of an Elastic IP address to associate with the NAT gateway. If the Elastic IP address is associated with another resource, you must first disassociate it.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p> <p>Constraint: Maximum 64 ASCII characters.</p>"];
      subnet_id: String.t
        [@ocaml.doc "<p>The subnet in which to create the NAT gateway.</p>"]}
    let make ~allocation_id  ?client_token  ~subnet_id  () =
      { allocation_id; client_token; subnet_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("SubnetId", (String.to_query v.subnet_id)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Some
             (Query.Pair ("AllocationId", (String.to_query v.allocation_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("subnet_id", (String.to_json v.subnet_id));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Some ("allocation_id", (String.to_json v.allocation_id))])
    let parse xml =
      Some
        {
          allocation_id =
            (Xml.required "AllocationId"
               (Util.option_bind (Xml.member "AllocationId" xml) String.parse));
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          subnet_id =
            (Xml.required "SubnetId"
               (Util.option_bind (Xml.member "SubnetId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "AllocationId"
                   ([], (String.to_xml v.allocation_id)))])
            @
            [Util.option_map v.client_token
               (fun f ->
                  Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "SubnetId" ([], (String.to_xml v.subnet_id)))])
  end
module CreateNatGatewayResult = CreateNatGatewayResult
type input = CreateNatGatewayRequest.t
type output = CreateNatGatewayResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CreateNatGateway"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateNatGatewayRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateNatGatewayRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateNatGatewayResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateNatGatewayResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateNatGatewayResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateNatGatewayResult - missing field in body or children: "
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