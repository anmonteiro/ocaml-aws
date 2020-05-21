open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateVpcEndpointServiceConfigurationRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      acceptance_required: Boolean.t option
        [@ocaml.doc
          "<p>Indicate whether requests from service consumers to create an endpoint to your service must be accepted. To accept a request, use <a>AcceptVpcEndpointConnections</a>.</p>"];
      network_load_balancer_arns: ValueStringList.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of one or more Network Load Balancers for your service.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p>"]}
    let make ?dry_run  ?acceptance_required  ~network_load_balancer_arns 
      ?client_token  () =
      {
        dry_run;
        acceptance_required;
        network_load_balancer_arns;
        client_token
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Some
             (Query.Pair
                ("NetworkLoadBalancerArn",
                  (ValueStringList.to_query v.network_load_balancer_arns)));
           Util.option_map v.acceptance_required
             (fun f ->
                Query.Pair ("AcceptanceRequired", (Boolean.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Some
             ("network_load_balancer_arns",
               (ValueStringList.to_json v.network_load_balancer_arns));
           Util.option_map v.acceptance_required
             (fun f -> ("acceptance_required", (Boolean.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          acceptance_required =
            (Util.option_bind (Xml.member "AcceptanceRequired" xml)
               Boolean.parse);
          network_load_balancer_arns =
            (Xml.required "NetworkLoadBalancerArn"
               (Util.option_bind (Xml.member "NetworkLoadBalancerArn" xml)
                  ValueStringList.parse));
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.dry_run
                 (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.acceptance_required
                (fun f ->
                   Ezxmlm.make_tag "AcceptanceRequired"
                     ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "NetworkLoadBalancerArn"
                       ([], (ValueStringList.to_xml [x]))))
               v.network_load_balancer_arns))
           @
           [Util.option_map v.client_token
              (fun f -> Ezxmlm.make_tag "ClientToken" ([], (String.to_xml f)))])
  end
module CreateVpcEndpointServiceConfigurationResult =
  CreateVpcEndpointServiceConfigurationResult
type input = CreateVpcEndpointServiceConfigurationRequest.t
type output = CreateVpcEndpointServiceConfigurationResult.t
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
         ("Action", ["CreateVpcEndpointServiceConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (CreateVpcEndpointServiceConfigurationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (CreateVpcEndpointServiceConfigurationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "CreateVpcEndpointServiceConfigurationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             CreateVpcEndpointServiceConfigurationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateVpcEndpointServiceConfigurationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateVpcEndpointServiceConfigurationResult - missing field in body or children: "
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