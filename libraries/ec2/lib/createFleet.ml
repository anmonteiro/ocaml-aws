open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateFleetRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">Ensuring Idempotency</a>.</p>"];
      spot_options: SpotOptionsRequest.t option
        [@ocaml.doc
          "<p>Describes the configuration of Spot Instances in an EC2 Fleet.</p>"];
      on_demand_options: OnDemandOptionsRequest.t option
        [@ocaml.doc
          "<p>Describes the configuration of On-Demand Instances in an EC2 Fleet.</p>"];
      excess_capacity_termination_policy:
        FleetExcessCapacityTerminationPolicy.t option
        [@ocaml.doc
          "<p>Indicates whether running instances should be terminated if the total target capacity of the EC2 Fleet is decreased below the current size of the EC2 Fleet.</p>"];
      launch_template_configs: FleetLaunchTemplateConfigListRequest.t
        [@ocaml.doc "<p>The configuration for the EC2 Fleet.</p>"];
      target_capacity_specification: TargetCapacitySpecificationRequest.t
        [@ocaml.doc "<p>The number of units to request.</p>"];
      terminate_instances_with_expiration: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether running instances should be terminated when the EC2 Fleet expires.</p>"];
      type_: FleetType.t option
        [@ocaml.doc
          "<p>The type of the request. By default, the EC2 Fleet places an asynchronous request for your desired capacity, and maintains it by replenishing interrupted Spot Instances (<code>maintain</code>). A value of <code>instant</code> places a synchronous one-time request, and returns errors for any instances that could not be launched. A value of <code>request</code> places an asynchronous one-time request without maintaining capacity or submitting requests in alternative capacity pools if capacity is unavailable. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-configuration-strategies.html#ec2-fleet-request-type\">EC2 Fleet Request Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      valid_from: DateTime.t option
        [@ocaml.doc
          "<p>The start date and time of the request, in UTC format (for example, <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z). The default is to start fulfilling the request immediately.</p>"];
      valid_until: DateTime.t option
        [@ocaml.doc
          "<p>The end date and time of the request, in UTC format (for example, <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z). At this point, no new EC2 Fleet requests are placed or able to fulfill the request. If no value is specified, the request remains until you cancel it.</p>"];
      replace_unhealthy_instances: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether EC2 Fleet should replace unhealthy instances.</p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The key-value pair for tagging the EC2 Fleet request on creation. The value for <code>ResourceType</code> must be <code>fleet</code>, otherwise the fleet request fails. To tag instances at launch, specify the tags in the <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html#create-launch-template\">launch template</a>. For information about tagging after launch, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#tag-resources\">Tagging Your Resources</a>. </p>"]}
    let make ?dry_run  ?client_token  ?spot_options  ?on_demand_options 
      ?excess_capacity_termination_policy  ~launch_template_configs 
      ~target_capacity_specification  ?terminate_instances_with_expiration 
      ?type_  ?valid_from  ?valid_until  ?replace_unhealthy_instances 
      ?(tag_specifications= [])  () =
      {
        dry_run;
        client_token;
        spot_options;
        on_demand_options;
        excess_capacity_termination_policy;
        launch_template_configs;
        target_capacity_specification;
        terminate_instances_with_expiration;
        type_;
        valid_from;
        valid_until;
        replace_unhealthy_instances;
        tag_specifications
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("TagSpecification",
                   (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.replace_unhealthy_instances
             (fun f ->
                Query.Pair
                  ("ReplaceUnhealthyInstances", (Boolean.to_query f)));
           Util.option_map v.valid_until
             (fun f -> Query.Pair ("ValidUntil", (DateTime.to_query f)));
           Util.option_map v.valid_from
             (fun f -> Query.Pair ("ValidFrom", (DateTime.to_query f)));
           Util.option_map v.type_
             (fun f -> Query.Pair ("Type", (FleetType.to_query f)));
           Util.option_map v.terminate_instances_with_expiration
             (fun f ->
                Query.Pair
                  ("TerminateInstancesWithExpiration", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TargetCapacitySpecification",
                  (TargetCapacitySpecificationRequest.to_query
                     v.target_capacity_specification)));
           Some
             (Query.Pair
                ("LaunchTemplateConfigs",
                  (FleetLaunchTemplateConfigListRequest.to_query
                     v.launch_template_configs)));
           Util.option_map v.excess_capacity_termination_policy
             (fun f ->
                Query.Pair
                  ("ExcessCapacityTerminationPolicy",
                    (FleetExcessCapacityTerminationPolicy.to_query f)));
           Util.option_map v.on_demand_options
             (fun f ->
                Query.Pair
                  ("OnDemandOptions", (OnDemandOptionsRequest.to_query f)));
           Util.option_map v.spot_options
             (fun f ->
                Query.Pair ("SpotOptions", (SpotOptionsRequest.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("tag_specifications",
                (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.replace_unhealthy_instances
             (fun f -> ("replace_unhealthy_instances", (Boolean.to_json f)));
           Util.option_map v.valid_until
             (fun f -> ("valid_until", (DateTime.to_json f)));
           Util.option_map v.valid_from
             (fun f -> ("valid_from", (DateTime.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (FleetType.to_json f)));
           Util.option_map v.terminate_instances_with_expiration
             (fun f ->
                ("terminate_instances_with_expiration", (Boolean.to_json f)));
           Some
             ("target_capacity_specification",
               (TargetCapacitySpecificationRequest.to_json
                  v.target_capacity_specification));
           Some
             ("launch_template_configs",
               (FleetLaunchTemplateConfigListRequest.to_json
                  v.launch_template_configs));
           Util.option_map v.excess_capacity_termination_policy
             (fun f ->
                ("excess_capacity_termination_policy",
                  (FleetExcessCapacityTerminationPolicy.to_json f)));
           Util.option_map v.on_demand_options
             (fun f ->
                ("on_demand_options", (OnDemandOptionsRequest.to_json f)));
           Util.option_map v.spot_options
             (fun f -> ("spot_options", (SpotOptionsRequest.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          spot_options =
            (Util.option_bind (Xml.member "SpotOptions" xml)
               SpotOptionsRequest.parse);
          on_demand_options =
            (Util.option_bind (Xml.member "OnDemandOptions" xml)
               OnDemandOptionsRequest.parse);
          excess_capacity_termination_policy =
            (Util.option_bind
               (Xml.member "ExcessCapacityTerminationPolicy" xml)
               FleetExcessCapacityTerminationPolicy.parse);
          launch_template_configs =
            (Xml.required "LaunchTemplateConfigs"
               (Util.option_bind (Xml.member "LaunchTemplateConfigs" xml)
                  FleetLaunchTemplateConfigListRequest.parse));
          target_capacity_specification =
            (Xml.required "TargetCapacitySpecification"
               (Util.option_bind
                  (Xml.member "TargetCapacitySpecification" xml)
                  TargetCapacitySpecificationRequest.parse));
          terminate_instances_with_expiration =
            (Util.option_bind
               (Xml.member "TerminateInstancesWithExpiration" xml)
               Boolean.parse);
          type_ = (Util.option_bind (Xml.member "Type" xml) FleetType.parse);
          valid_from =
            (Util.option_bind (Xml.member "ValidFrom" xml) DateTime.parse);
          valid_until =
            (Util.option_bind (Xml.member "ValidUntil" xml) DateTime.parse);
          replace_unhealthy_instances =
            (Util.option_bind (Xml.member "ReplaceUnhealthyInstances" xml)
               Boolean.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecification" xml)
                  TagSpecificationList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Util.option_map v.dry_run
                          (fun f ->
                             Ezxmlm.make_tag "DryRun"
                               ([], (Boolean.to_xml f)))])
                      @
                      [Util.option_map v.client_token
                         (fun f ->
                            Ezxmlm.make_tag "ClientToken"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.spot_options
                        (fun f ->
                           Ezxmlm.make_tag "SpotOptions"
                             ([], (SpotOptionsRequest.to_xml f)))])
                    @
                    [Util.option_map v.on_demand_options
                       (fun f ->
                          Ezxmlm.make_tag "OnDemandOptions"
                            ([], (OnDemandOptionsRequest.to_xml f)))])
                   @
                   [Util.option_map v.excess_capacity_termination_policy
                      (fun f ->
                         Ezxmlm.make_tag "ExcessCapacityTerminationPolicy"
                           ([],
                             (FleetExcessCapacityTerminationPolicy.to_xml f)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "LaunchTemplateConfigs"
                             ([],
                               (FleetLaunchTemplateConfigListRequest.to_xml
                                  [x])))) v.launch_template_configs))
                 @
                 [Some
                    (Ezxmlm.make_tag "TargetCapacitySpecification"
                       ([],
                         (TargetCapacitySpecificationRequest.to_xml
                            v.target_capacity_specification)))])
                @
                [Util.option_map v.terminate_instances_with_expiration
                   (fun f ->
                      Ezxmlm.make_tag "TerminateInstancesWithExpiration"
                        ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.type_
                  (fun f -> Ezxmlm.make_tag "Type" ([], (FleetType.to_xml f)))])
              @
              [Util.option_map v.valid_from
                 (fun f ->
                    Ezxmlm.make_tag "ValidFrom" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.valid_until
                (fun f ->
                   Ezxmlm.make_tag "ValidUntil" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.replace_unhealthy_instances
               (fun f ->
                  Ezxmlm.make_tag "ReplaceUnhealthyInstances"
                    ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "TagSpecification"
                      ([], (TagSpecificationList.to_xml [x]))))
              v.tag_specifications))
  end
module CreateFleetResult = CreateFleetResult
type input = CreateFleetRequest.t
type output = CreateFleetResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2016-11-15"]); ("Action", ["CreateFleet"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateFleetRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CreateFleetRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateFleetResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CreateFleetResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CreateFleetResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateFleetResult - missing field in body or children: "
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