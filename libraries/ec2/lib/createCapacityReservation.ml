open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateCapacityReservationRequest =
  struct
    type t =
      {
      client_token: String.t option
        [@ocaml.doc
          "<p>Unique, case-sensitive identifier that you provide to ensure the idempotency of the request. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html\">How to Ensure Idempotency</a>.</p> <p>Constraint: Maximum 64 ASCII characters.</p>"];
      instance_type: String.t
        [@ocaml.doc
          "<p>The instance type for which to reserve capacity. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      instance_platform: CapacityReservationInstancePlatform.t
        [@ocaml.doc
          "<p>The type of operating system for which to reserve capacity.</p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone in which to create the Capacity Reservation.</p>"];
      availability_zone_id: String.t option
        [@ocaml.doc
          "<p>The ID of the Availability Zone in which to create the Capacity Reservation.</p>"];
      tenancy: CapacityReservationTenancy.t option
        [@ocaml.doc
          "<p>Indicates the tenancy of the Capacity Reservation. A Capacity Reservation can have one of the following tenancy settings:</p> <ul> <li> <p> <code>default</code> - The Capacity Reservation is created on hardware that is shared with other AWS accounts.</p> </li> <li> <p> <code>dedicated</code> - The Capacity Reservation is created on single-tenant hardware that is dedicated to a single AWS account.</p> </li> </ul>"];
      instance_count: Integer.t
        [@ocaml.doc
          "<p>The number of instances for which to reserve capacity.</p>"];
      ebs_optimized: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the Capacity Reservation supports EBS-optimized instances. This optimization provides dedicated throughput to Amazon EBS and an optimized configuration stack to provide optimal I/O performance. This optimization isn't available with all instance types. Additional usage charges apply when using an EBS- optimized instance.</p>"];
      ephemeral_storage: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the Capacity Reservation supports instances with temporary, block-level storage.</p>"];
      end_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time at which the Capacity Reservation expires. When a Capacity Reservation expires, the reserved capacity is released and you can no longer launch instances into it. The Capacity Reservation's state changes to <code>expired</code> when it reaches its end date and time.</p> <p>You must provide an <code>EndDate</code> value if <code>EndDateType</code> is <code>limited</code>. Omit <code>EndDate</code> if <code>EndDateType</code> is <code>unlimited</code>.</p> <p>If the <code>EndDateType</code> is <code>limited</code>, the Capacity Reservation is cancelled within an hour from the specified time. For example, if you specify 5/31/2019, 13:30:55, the Capacity Reservation is guaranteed to end between 13:30:55 and 14:30:55 on 5/31/2019.</p>"];
      end_date_type: EndDateType.t option
        [@ocaml.doc
          "<p>Indicates the way in which the Capacity Reservation ends. A Capacity Reservation can have one of the following end types:</p> <ul> <li> <p> <code>unlimited</code> - The Capacity Reservation remains active until you explicitly cancel it. Do not provide an <code>EndDate</code> if the <code>EndDateType</code> is <code>unlimited</code>.</p> </li> <li> <p> <code>limited</code> - The Capacity Reservation expires automatically at a specified date and time. You must provide an <code>EndDate</code> value if the <code>EndDateType</code> value is <code>limited</code>.</p> </li> </ul>"];
      instance_match_criteria: InstanceMatchCriteria.t option
        [@ocaml.doc
          "<p>Indicates the type of instance launches that the Capacity Reservation accepts. The options include:</p> <ul> <li> <p> <code>open</code> - The Capacity Reservation automatically matches all instances that have matching attributes (instance type, platform, and Availability Zone). Instances that have matching attributes run in the Capacity Reservation automatically without specifying any additional parameters.</p> </li> <li> <p> <code>targeted</code> - The Capacity Reservation only accepts instances that have matching attributes (instance type, platform, and Availability Zone), and explicitly target the Capacity Reservation. This ensures that only permitted instances can use the reserved capacity. </p> </li> </ul> <p>Default: <code>open</code> </p>"];
      tag_specifications: TagSpecificationList.t
        [@ocaml.doc
          "<p>The tags to apply to the Capacity Reservation during launch.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?client_token  ~instance_type  ~instance_platform 
      ?availability_zone  ?availability_zone_id  ?tenancy  ~instance_count 
      ?ebs_optimized  ?ephemeral_storage  ?end_date  ?end_date_type 
      ?instance_match_criteria  ?(tag_specifications= [])  ?dry_run  () =
      {
        client_token;
        instance_type;
        instance_platform;
        availability_zone;
        availability_zone_id;
        tenancy;
        instance_count;
        ebs_optimized;
        ephemeral_storage;
        end_date;
        end_date_type;
        instance_match_criteria;
        tag_specifications;
        dry_run
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("TagSpecifications",
                  (TagSpecificationList.to_query v.tag_specifications)));
           Util.option_map v.instance_match_criteria
             (fun f ->
                Query.Pair
                  ("InstanceMatchCriteria",
                    (InstanceMatchCriteria.to_query f)));
           Util.option_map v.end_date_type
             (fun f -> Query.Pair ("EndDateType", (EndDateType.to_query f)));
           Util.option_map v.end_date
             (fun f -> Query.Pair ("EndDate", (DateTime.to_query f)));
           Util.option_map v.ephemeral_storage
             (fun f -> Query.Pair ("EphemeralStorage", (Boolean.to_query f)));
           Util.option_map v.ebs_optimized
             (fun f -> Query.Pair ("EbsOptimized", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("InstanceCount", (Integer.to_query v.instance_count)));
           Util.option_map v.tenancy
             (fun f ->
                Query.Pair
                  ("Tenancy", (CapacityReservationTenancy.to_query f)));
           Util.option_map v.availability_zone_id
             (fun f -> Query.Pair ("AvailabilityZoneId", (String.to_query f)));
           Util.option_map v.availability_zone
             (fun f -> Query.Pair ("AvailabilityZone", (String.to_query f)));
           Some
             (Query.Pair
                ("InstancePlatform",
                  (CapacityReservationInstancePlatform.to_query
                     v.instance_platform)));
           Some
             (Query.Pair ("InstanceType", (String.to_query v.instance_type)));
           Util.option_map v.client_token
             (fun f -> Query.Pair ("ClientToken", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("tag_specifications",
               (TagSpecificationList.to_json v.tag_specifications));
           Util.option_map v.instance_match_criteria
             (fun f ->
                ("instance_match_criteria",
                  (InstanceMatchCriteria.to_json f)));
           Util.option_map v.end_date_type
             (fun f -> ("end_date_type", (EndDateType.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (DateTime.to_json f)));
           Util.option_map v.ephemeral_storage
             (fun f -> ("ephemeral_storage", (Boolean.to_json f)));
           Util.option_map v.ebs_optimized
             (fun f -> ("ebs_optimized", (Boolean.to_json f)));
           Some ("instance_count", (Integer.to_json v.instance_count));
           Util.option_map v.tenancy
             (fun f -> ("tenancy", (CapacityReservationTenancy.to_json f)));
           Util.option_map v.availability_zone_id
             (fun f -> ("availability_zone_id", (String.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Some
             ("instance_platform",
               (CapacityReservationInstancePlatform.to_json
                  v.instance_platform));
           Some ("instance_type", (String.to_json v.instance_type));
           Util.option_map v.client_token
             (fun f -> ("client_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          client_token =
            (Util.option_bind (Xml.member "ClientToken" xml) String.parse);
          instance_type =
            (Xml.required "InstanceType"
               (Util.option_bind (Xml.member "InstanceType" xml) String.parse));
          instance_platform =
            (Xml.required "InstancePlatform"
               (Util.option_bind (Xml.member "InstancePlatform" xml)
                  CapacityReservationInstancePlatform.parse));
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          availability_zone_id =
            (Util.option_bind (Xml.member "AvailabilityZoneId" xml)
               String.parse);
          tenancy =
            (Util.option_bind (Xml.member "Tenancy" xml)
               CapacityReservationTenancy.parse);
          instance_count =
            (Xml.required "InstanceCount"
               (Util.option_bind (Xml.member "InstanceCount" xml)
                  Integer.parse));
          ebs_optimized =
            (Util.option_bind (Xml.member "EbsOptimized" xml) Boolean.parse);
          ephemeral_storage =
            (Util.option_bind (Xml.member "EphemeralStorage" xml)
               Boolean.parse);
          end_date =
            (Util.option_bind (Xml.member "EndDate" xml) DateTime.parse);
          end_date_type =
            (Util.option_bind (Xml.member "EndDateType" xml)
               EndDateType.parse);
          instance_match_criteria =
            (Util.option_bind (Xml.member "InstanceMatchCriteria" xml)
               InstanceMatchCriteria.parse);
          tag_specifications =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagSpecifications" xml)
                  TagSpecificationList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((([] @
                        [Util.option_map v.client_token
                           (fun f ->
                              Ezxmlm.make_tag "ClientToken"
                                ([], (String.to_xml f)))])
                       @
                       [Some
                          (Ezxmlm.make_tag "InstanceType"
                             ([], (String.to_xml v.instance_type)))])
                      @
                      [Some
                         (Ezxmlm.make_tag "InstancePlatform"
                            ([],
                              (CapacityReservationInstancePlatform.to_xml
                                 v.instance_platform)))])
                     @
                     [Util.option_map v.availability_zone
                        (fun f ->
                           Ezxmlm.make_tag "AvailabilityZone"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.availability_zone_id
                       (fun f ->
                          Ezxmlm.make_tag "AvailabilityZoneId"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.tenancy
                      (fun f ->
                         Ezxmlm.make_tag "Tenancy"
                           ([], (CapacityReservationTenancy.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "InstanceCount"
                        ([], (Integer.to_xml v.instance_count)))])
                 @
                 [Util.option_map v.ebs_optimized
                    (fun f ->
                       Ezxmlm.make_tag "EbsOptimized"
                         ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.ephemeral_storage
                   (fun f ->
                      Ezxmlm.make_tag "EphemeralStorage"
                        ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.end_date
                  (fun f ->
                     Ezxmlm.make_tag "EndDate" ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.end_date_type
                 (fun f ->
                    Ezxmlm.make_tag "EndDateType"
                      ([], (EndDateType.to_xml f)))])
             @
             [Util.option_map v.instance_match_criteria
                (fun f ->
                   Ezxmlm.make_tag "InstanceMatchCriteria"
                     ([], (InstanceMatchCriteria.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TagSpecifications"
                       ([], (TagSpecificationList.to_xml [x]))))
               v.tag_specifications))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module CreateCapacityReservationResult = CreateCapacityReservationResult
type input = CreateCapacityReservationRequest.t
type output = CreateCapacityReservationResult.t
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
         ("Action", ["CreateCapacityReservation"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CreateCapacityReservationRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (CreateCapacityReservationRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CreateCapacityReservationResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp CreateCapacityReservationResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed CreateCapacityReservationResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CreateCapacityReservationResult - missing field in body or children: "
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