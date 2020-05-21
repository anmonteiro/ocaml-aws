open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RequestSpotInstancesRequest =
  struct
    type t =
      {
      availability_zone_group: String.t option
        [@ocaml.doc
          "<p>The user-specified name for a logical grouping of requests.</p> <p>When you specify an Availability Zone group in a Spot Instance request, all Spot Instances in the request are launched in the same Availability Zone. Instance proximity is maintained with this parameter, but the choice of Availability Zone is not. The group applies only to requests for Spot Instances of the same instance type. Any additional Spot Instance requests that are specified with the same Availability Zone group name are launched in that same Availability Zone, as long as at least one instance from the group is still active.</p> <p>If there is no active instance running in the Availability Zone group that you specify for a new Spot Instance request (all instances are terminated, the request is expired, or the maximum price you specified falls below current Spot price), then Amazon EC2 launches the instance in any Availability Zone where the constraint can be met. Consequently, the subsequent set of Spot Instances could be placed in a different zone from the original request, even if you specified the same Availability Zone group.</p> <p>Default: Instances are launched in any available Availability Zone.</p>"];
      block_duration_minutes: Integer.t option
        [@ocaml.doc
          "<p>The required duration for the Spot Instances (also known as Spot blocks), in minutes. This value must be a multiple of 60 (60, 120, 180, 240, 300, or 360).</p> <p>The duration period starts as soon as your Spot Instance receives its instance ID. At the end of the duration period, Amazon EC2 marks the Spot Instance for termination and provides a Spot Instance termination notice, which gives the instance a two-minute warning before it terminates.</p> <p>You can't specify an Availability Zone group or a launch group if you specify a duration.</p>"];
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_count: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of Spot Instances to launch.</p> <p>Default: 1</p>"];
      launch_group: String.t option
        [@ocaml.doc
          "<p>The instance launch group. Launch groups are Spot Instances that launch together and terminate together.</p> <p>Default: Instances are launched and terminated individually</p>"];
      launch_specification: RequestSpotLaunchSpecification.t option
        [@ocaml.doc "<p>The launch specification.</p>"];
      spot_price: String.t option
        [@ocaml.doc
          "<p>The maximum price per hour that you are willing to pay for a Spot Instance. The default is the On-Demand price.</p>"];
      type_: SpotInstanceType.t option
        [@ocaml.doc
          "<p>The Spot Instance request type.</p> <p>Default: <code>one-time</code> </p>"];
      valid_from: DateTime.t option
        [@ocaml.doc
          "<p>The start date of the request. If this is a one-time request, the request becomes active at this date and time and remains active until all instances launch, the request expires, or the request is canceled. If the request is persistent, the request becomes active at this date and time and remains active until it expires or is canceled.</p> <p>The specified start date and time cannot be equal to the current date and time. You must specify a start date and time that occurs after the current date and time.</p>"];
      valid_until: DateTime.t option
        [@ocaml.doc
          "<p>The end date of the request. If this is a one-time request, the request remains active until all instances launch, the request is canceled, or this date is reached. If the request is persistent, it remains active until it is canceled or this date is reached. The default end date is 7 days from the current date.</p>"];
      instance_interruption_behavior: InstanceInterruptionBehavior.t option
        [@ocaml.doc
          "<p>The behavior when a Spot Instance is interrupted. The default is <code>terminate</code>.</p>"]}
    [@@ocaml.doc "<p>Contains the parameters for RequestSpotInstances.</p>"]
    let make ?availability_zone_group  ?block_duration_minutes  ?client_token
       ?dry_run  ?instance_count  ?launch_group  ?launch_specification 
      ?spot_price  ?type_  ?valid_from  ?valid_until 
      ?instance_interruption_behavior  () =
      {
        availability_zone_group;
        block_duration_minutes;
        client_token;
        dry_run;
        instance_count;
        launch_group;
        launch_specification;
        spot_price;
        type_;
        valid_from;
        valid_until;
        instance_interruption_behavior
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.instance_interruption_behavior
              (fun f ->
                 Query.Pair
                   ("InstanceInterruptionBehavior",
                     (InstanceInterruptionBehavior.to_query f)));
           Util.option_map v.valid_until
             (fun f -> Query.Pair ("ValidUntil", (DateTime.to_query f)));
           Util.option_map v.valid_from
             (fun f -> Query.Pair ("ValidFrom", (DateTime.to_query f)));
           Util.option_map v.type_
             (fun f -> Query.Pair ("Type", (SpotInstanceType.to_query f)));
           Util.option_map v.spot_price
             (fun f -> Query.Pair ("SpotPrice", (String.to_query f)));
           Util.option_map v.launch_specification
             (fun f ->
                Query.Pair
                  ("LaunchSpecification",
                    (RequestSpotLaunchSpecification.to_query f)));
           Util.option_map v.launch_group
             (fun f -> Query.Pair ("LaunchGroup", (String.to_query f)));
           Util.option_map v.instance_count
             (fun f -> Query.Pair ("InstanceCount", (Integer.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)));
           Util.option_map v.block_duration_minutes
             (fun f ->
                Query.Pair ("BlockDurationMinutes", (Integer.to_query f)));
           Util.option_map v.availability_zone_group
             (fun f ->
                Query.Pair ("AvailabilityZoneGroup", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instance_interruption_behavior
              (fun f ->
                 ("instance_interruption_behavior",
                   (InstanceInterruptionBehavior.to_json f)));
           Util.option_map v.valid_until
             (fun f -> ("valid_until", (DateTime.to_json f)));
           Util.option_map v.valid_from
             (fun f -> ("valid_from", (DateTime.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (SpotInstanceType.to_json f)));
           Util.option_map v.spot_price
             (fun f -> ("spot_price", (String.to_json f)));
           Util.option_map v.launch_specification
             (fun f ->
                ("launch_specification",
                  (RequestSpotLaunchSpecification.to_json f)));
           Util.option_map v.launch_group
             (fun f -> ("launch_group", (String.to_json f)));
           Util.option_map v.instance_count
             (fun f -> ("instance_count", (Integer.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.block_duration_minutes
             (fun f -> ("block_duration_minutes", (Integer.to_json f)));
           Util.option_map v.availability_zone_group
             (fun f -> ("availability_zone_group", (String.to_json f)))])
    let parse xml =
      Some
        {
          availability_zone_group =
            (Util.option_bind (Xml.member "availabilityZoneGroup" xml)
               String.parse);
          block_duration_minutes =
            (Util.option_bind (Xml.member "blockDurationMinutes" xml)
               Integer.parse);
          client_token =
            (Util.option_bind (Xml.member "clientToken" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          instance_count =
            (Util.option_bind (Xml.member "instanceCount" xml) Integer.parse);
          launch_group =
            (Util.option_bind (Xml.member "launchGroup" xml) String.parse);
          launch_specification =
            (Util.option_bind (Xml.member "LaunchSpecification" xml)
               RequestSpotLaunchSpecification.parse);
          spot_price =
            (Util.option_bind (Xml.member "spotPrice" xml) String.parse);
          type_ =
            (Util.option_bind (Xml.member "type" xml) SpotInstanceType.parse);
          valid_from =
            (Util.option_bind (Xml.member "validFrom" xml) DateTime.parse);
          valid_until =
            (Util.option_bind (Xml.member "validUntil" xml) DateTime.parse);
          instance_interruption_behavior =
            (Util.option_bind (Xml.member "InstanceInterruptionBehavior" xml)
               InstanceInterruptionBehavior.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.availability_zone_group
                         (fun f ->
                            Ezxmlm.make_tag "availabilityZoneGroup"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.block_duration_minutes
                        (fun f ->
                           Ezxmlm.make_tag "blockDurationMinutes"
                             ([], (Integer.to_xml f)))])
                    @
                    [Util.option_map v.client_token
                       (fun f ->
                          Ezxmlm.make_tag "clientToken"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.dry_run
                      (fun f ->
                         Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.instance_count
                     (fun f ->
                        Ezxmlm.make_tag "instanceCount"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.launch_group
                    (fun f ->
                       Ezxmlm.make_tag "launchGroup" ([], (String.to_xml f)))])
                @
                [Util.option_map v.launch_specification
                   (fun f ->
                      Ezxmlm.make_tag "LaunchSpecification"
                        ([], (RequestSpotLaunchSpecification.to_xml f)))])
               @
               [Util.option_map v.spot_price
                  (fun f ->
                     Ezxmlm.make_tag "spotPrice" ([], (String.to_xml f)))])
              @
              [Util.option_map v.type_
                 (fun f ->
                    Ezxmlm.make_tag "type" ([], (SpotInstanceType.to_xml f)))])
             @
             [Util.option_map v.valid_from
                (fun f ->
                   Ezxmlm.make_tag "validFrom" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.valid_until
               (fun f ->
                  Ezxmlm.make_tag "validUntil" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.instance_interruption_behavior
              (fun f ->
                 Ezxmlm.make_tag "InstanceInterruptionBehavior"
                   ([], (InstanceInterruptionBehavior.to_xml f)))])
  end[@@ocaml.doc "<p>Contains the parameters for RequestSpotInstances.</p>"]
module RequestSpotInstancesResult = RequestSpotInstancesResult
type input = RequestSpotInstancesRequest.t
type output = RequestSpotInstancesResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["RequestSpotInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (RequestSpotInstancesRequest.to_query req))))) in
  (`POST, uri, (Headers.render (RequestSpotInstancesRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "RequestSpotInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RequestSpotInstancesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RequestSpotInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RequestSpotInstancesResult - missing field in body or children: "
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