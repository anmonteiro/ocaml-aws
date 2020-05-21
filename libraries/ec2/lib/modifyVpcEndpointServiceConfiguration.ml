open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyVpcEndpointServiceConfigurationRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      service_id: String.t [@ocaml.doc "<p>The ID of the service.</p>"];
      acceptance_required: Boolean.t option
        [@ocaml.doc
          "<p>Indicate whether requests to create an endpoint to your service must be accepted.</p>"];
      add_network_load_balancer_arns: ValueStringList.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of Network Load Balancers to add to your service configuration.</p>"];
      remove_network_load_balancer_arns: ValueStringList.t
        [@ocaml.doc
          "<p>The Amazon Resource Names (ARNs) of Network Load Balancers to remove from your service configuration.</p>"]}
    let make ?dry_run  ~service_id  ?acceptance_required 
      ?(add_network_load_balancer_arns= []) 
      ?(remove_network_load_balancer_arns= [])  () =
      {
        dry_run;
        service_id;
        acceptance_required;
        add_network_load_balancer_arns;
        remove_network_load_balancer_arns
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("RemoveNetworkLoadBalancerArn",
                   (ValueStringList.to_query
                      v.remove_network_load_balancer_arns)));
           Some
             (Query.Pair
                ("AddNetworkLoadBalancerArn",
                  (ValueStringList.to_query v.add_network_load_balancer_arns)));
           Util.option_map v.acceptance_required
             (fun f ->
                Query.Pair ("AcceptanceRequired", (Boolean.to_query f)));
           Some (Query.Pair ("ServiceId", (String.to_query v.service_id)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("remove_network_load_balancer_arns",
                (ValueStringList.to_json v.remove_network_load_balancer_arns));
           Some
             ("add_network_load_balancer_arns",
               (ValueStringList.to_json v.add_network_load_balancer_arns));
           Util.option_map v.acceptance_required
             (fun f -> ("acceptance_required", (Boolean.to_json f)));
           Some ("service_id", (String.to_json v.service_id));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          service_id =
            (Xml.required "ServiceId"
               (Util.option_bind (Xml.member "ServiceId" xml) String.parse));
          acceptance_required =
            (Util.option_bind (Xml.member "AcceptanceRequired" xml)
               Boolean.parse);
          add_network_load_balancer_arns =
            (Util.of_option []
               (Util.option_bind (Xml.member "AddNetworkLoadBalancerArn" xml)
                  ValueStringList.parse));
          remove_network_load_balancer_arns =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "RemoveNetworkLoadBalancerArn" xml)
                  ValueStringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "ServiceId"
                    ([], (String.to_xml v.service_id)))])
             @
             [Util.option_map v.acceptance_required
                (fun f ->
                   Ezxmlm.make_tag "AcceptanceRequired"
                     ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AddNetworkLoadBalancerArn"
                       ([], (ValueStringList.to_xml [x]))))
               v.add_network_load_balancer_arns))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RemoveNetworkLoadBalancerArn"
                      ([], (ValueStringList.to_xml [x]))))
              v.remove_network_load_balancer_arns))
  end
module ModifyVpcEndpointServiceConfigurationResult =
  ModifyVpcEndpointServiceConfigurationResult
type input = ModifyVpcEndpointServiceConfigurationRequest.t
type output = ModifyVpcEndpointServiceConfigurationResult.t
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
         ("Action", ["ModifyVpcEndpointServiceConfiguration"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (ModifyVpcEndpointServiceConfigurationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (ModifyVpcEndpointServiceConfigurationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "ModifyVpcEndpointServiceConfigurationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             ModifyVpcEndpointServiceConfigurationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ModifyVpcEndpointServiceConfigurationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ModifyVpcEndpointServiceConfigurationResult - missing field in body or children: "
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