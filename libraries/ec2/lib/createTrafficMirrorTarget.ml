open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateTrafficMirrorTargetRequest =
  struct
    type t =
      {
      network_interface_id: String.t option
        [@ocaml.doc
          "<p>The network interface ID that is associated with the target.</p>"];
      network_load_balancer_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Network Load Balancer that is associated with the target.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the Traffic Mirror target.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to assign to the Traffic Mirror target.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"]}
    let make ?network_interface_id  ?network_load_balancer_arn  ?description 
      ?(tag_specifications= [])  ?dry_run  ?client_token  () =
      {
        network_interface_id;
        network_load_balancer_arn;
        description;
        tag_specifications;
        dry_run;
        client_token
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TagSpecification",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.description
             (fun f -> Query.Pair ("Description", (String.to_query f)));
           Util.option_map v.network_load_balancer_arn
             (fun f ->
                Query.Pair ("NetworkLoadBalancerArn", (String.to_query f)));
           Util.option_map v.network_interface_id
             (fun f -> Query.Pair ("NetworkInterfaceId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.network_load_balancer_arn
             (fun f -> ("network_load_balancer_arn", (String.to_json f)));
           Util.option_map v.network_interface_id
             (fun f -> ("network_interface_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          network_interface_id =
            (Util.option_bind (Xml.member "NetworkInterfaceId" xml)
               String.parse);
          network_load_balancer_arn =
            (Util.option_bind (Xml.member "NetworkLoadBalancerArn" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.network_interface_id
                   (fun f ->
                      Ezxmlm.make_tag "NetworkInterfaceId"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.network_load_balancer_arn
                  (fun f ->
                     Ezxmlm.make_tag "NetworkLoadBalancerArn"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
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
           @
           [Util.option_map v.client_token
              (fun f -> Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
  end
module CreateTrafficMirrorTargetResult = CreateTrafficMirrorTargetResult
type input = CreateTrafficMirrorTargetRequest.t
type output = CreateTrafficMirrorTargetResult.t
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
         ("Action", ["CreateTrafficMirrorTarget"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateTrafficMirrorTargetRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateTrafficMirrorTargetRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateTrafficMirrorTargetResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateTrafficMirrorTargetResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateTrafficMirrorTargetResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateTrafficMirrorTargetResult - missing field in body or children: "
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