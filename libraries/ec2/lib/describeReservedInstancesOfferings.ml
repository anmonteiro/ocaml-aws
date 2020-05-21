open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReservedInstancesOfferingsRequest =
  struct
    type t =
      {
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone in which the Reserved Instance can be used.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>availability-zone</code> - The Availability Zone where the Reserved Instance can be used.</p> </li> <li> <p> <code>duration</code> - The duration of the Reserved Instance (for example, one year or three years), in seconds (<code>31536000</code> | <code>94608000</code>).</p> </li> <li> <p> <code>fixed-price</code> - The purchase price of the Reserved Instance (for example, 9800.0).</p> </li> <li> <p> <code>instance-type</code> - The instance type that is covered by the reservation.</p> </li> <li> <p> <code>marketplace</code> - Set to <code>true</code> to show only Reserved Instance Marketplace offerings. When this filter is not used, which is the default behavior, all offerings from both AWS and the Reserved Instance Marketplace are listed.</p> </li> <li> <p> <code>product-description</code> - The Reserved Instance product platform description. Instances that include <code>(Amazon VPC)</code> in the product platform description will only be displayed to EC2-Classic account holders and are for use with Amazon VPC. (<code>Linux/UNIX</code> | <code>Linux/UNIX (Amazon VPC)</code> | <code>SUSE Linux</code> | <code>SUSE Linux (Amazon VPC)</code> | <code>Red Hat Enterprise Linux</code> | <code>Red Hat Enterprise Linux (Amazon VPC)</code> | <code>Windows</code> | <code>Windows (Amazon VPC)</code> | <code>Windows with SQL Server Standard</code> | <code>Windows with SQL Server Standard (Amazon VPC)</code> | <code>Windows with SQL Server Web</code> | <code> Windows with SQL Server Web (Amazon VPC)</code> | <code>Windows with SQL Server Enterprise</code> | <code>Windows with SQL Server Enterprise (Amazon VPC)</code>) </p> </li> <li> <p> <code>reserved-instances-offering-id</code> - The Reserved Instances offering ID.</p> </li> <li> <p> <code>scope</code> - The scope of the Reserved Instance (<code>Availability Zone</code> or <code>Region</code>).</p> </li> <li> <p> <code>usage-price</code> - The usage price of the Reserved Instance, per hour (for example, 0.84).</p> </li> </ul>"];
      include_marketplace: Boolean.t option
        [@ocaml.doc
          "<p>Include Reserved Instance Marketplace offerings in the response.</p>"];
      instance_type: InstanceType.t option
        [@ocaml.doc
          "<p>The instance type that the reservation will cover (for example, <code>m1.small</code>). For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html\">Instance Types</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>"];
      max_duration: Long.t option
        [@ocaml.doc
          "<p>The maximum duration (in seconds) to filter when searching for offerings.</p> <p>Default: 94608000 (3 years)</p>"];
      max_instance_count: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of instances to filter when searching for offerings.</p> <p>Default: 20</p>"];
      min_duration: Long.t option
        [@ocaml.doc
          "<p>The minimum duration (in seconds) to filter when searching for offerings.</p> <p>Default: 2592000 (1 month)</p>"];
      offering_class: OfferingClassType.t option
        [@ocaml.doc
          "<p>The offering class of the Reserved Instance. Can be <code>standard</code> or <code>convertible</code>.</p>"];
      product_description: RIProductDescription.t option
        [@ocaml.doc
          "<p>The Reserved Instance product platform description. Instances that include <code>(Amazon VPC)</code> in the description are for use with Amazon VPC.</p>"];
      reserved_instances_offering_ids:
        ReservedInstancesOfferingIdStringList.t
        [@ocaml.doc "<p>One or more Reserved Instances offering IDs.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      instance_tenancy: Tenancy.t option
        [@ocaml.doc
          "<p>The tenancy of the instances covered by the reservation. A Reserved Instance with a tenancy of <code>dedicated</code> is applied to instances that run in a VPC on single-tenant hardware (i.e., Dedicated Instances).</p> <p> <b>Important:</b> The <code>host</code> value cannot be used with this parameter. Use the <code>default</code> or <code>dedicated</code> values only.</p> <p>Default: <code>default</code> </p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results of the initial request can be seen by sending another request with the returned <code>NextToken</code> value. The maximum is 100.</p> <p>Default: 100</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"];
      offering_type: OfferingTypeValues.t option
        [@ocaml.doc
          "<p>The Reserved Instance offering type. If you are using tools that predate the 2011-11-01 API version, you only have access to the <code>Medium Utilization</code> Reserved Instance offering type. </p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeReservedInstancesOfferings.</p>"]
    let make ?availability_zone  ?(filters= [])  ?include_marketplace 
      ?instance_type  ?max_duration  ?max_instance_count  ?min_duration 
      ?offering_class  ?product_description 
      ?(reserved_instances_offering_ids= [])  ?dry_run  ?instance_tenancy 
      ?max_results  ?next_token  ?offering_type  () =
      {
        availability_zone;
        filters;
        include_marketplace;
        instance_type;
        max_duration;
        max_instance_count;
        min_duration;
        offering_class;
        product_description;
        reserved_instances_offering_ids;
        dry_run;
        instance_tenancy;
        max_results;
        next_token;
        offering_type
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.offering_type
              (fun f ->
                 Query.Pair ("OfferingType", (OfferingTypeValues.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.instance_tenancy
             (fun f -> Query.Pair ("InstanceTenancy", (Tenancy.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("ReservedInstancesOfferingId",
                  (ReservedInstancesOfferingIdStringList.to_query
                     v.reserved_instances_offering_ids)));
           Util.option_map v.product_description
             (fun f ->
                Query.Pair
                  ("ProductDescription", (RIProductDescription.to_query f)));
           Util.option_map v.offering_class
             (fun f ->
                Query.Pair ("OfferingClass", (OfferingClassType.to_query f)));
           Util.option_map v.min_duration
             (fun f -> Query.Pair ("MinDuration", (Long.to_query f)));
           Util.option_map v.max_instance_count
             (fun f -> Query.Pair ("MaxInstanceCount", (Integer.to_query f)));
           Util.option_map v.max_duration
             (fun f -> Query.Pair ("MaxDuration", (Long.to_query f)));
           Util.option_map v.instance_type
             (fun f -> Query.Pair ("InstanceType", (InstanceType.to_query f)));
           Util.option_map v.include_marketplace
             (fun f ->
                Query.Pair ("IncludeMarketplace", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.availability_zone
             (fun f -> Query.Pair ("AvailabilityZone", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.offering_type
              (fun f -> ("offering_type", (OfferingTypeValues.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.instance_tenancy
             (fun f -> ("instance_tenancy", (Tenancy.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("reserved_instances_offering_ids",
               (ReservedInstancesOfferingIdStringList.to_json
                  v.reserved_instances_offering_ids));
           Util.option_map v.product_description
             (fun f ->
                ("product_description", (RIProductDescription.to_json f)));
           Util.option_map v.offering_class
             (fun f -> ("offering_class", (OfferingClassType.to_json f)));
           Util.option_map v.min_duration
             (fun f -> ("min_duration", (Long.to_json f)));
           Util.option_map v.max_instance_count
             (fun f -> ("max_instance_count", (Integer.to_json f)));
           Util.option_map v.max_duration
             (fun f -> ("max_duration", (Long.to_json f)));
           Util.option_map v.instance_type
             (fun f -> ("instance_type", (InstanceType.to_json f)));
           Util.option_map v.include_marketplace
             (fun f -> ("include_marketplace", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)))])
    let parse xml =
      Some
        {
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          include_marketplace =
            (Util.option_bind (Xml.member "IncludeMarketplace" xml)
               Boolean.parse);
          instance_type =
            (Util.option_bind (Xml.member "InstanceType" xml)
               InstanceType.parse);
          max_duration =
            (Util.option_bind (Xml.member "MaxDuration" xml) Long.parse);
          max_instance_count =
            (Util.option_bind (Xml.member "MaxInstanceCount" xml)
               Integer.parse);
          min_duration =
            (Util.option_bind (Xml.member "MinDuration" xml) Long.parse);
          offering_class =
            (Util.option_bind (Xml.member "OfferingClass" xml)
               OfferingClassType.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               RIProductDescription.parse);
          reserved_instances_offering_ids =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ReservedInstancesOfferingId" xml)
                  ReservedInstancesOfferingIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          instance_tenancy =
            (Util.option_bind (Xml.member "instanceTenancy" xml)
               Tenancy.parse);
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse);
          offering_type =
            (Util.option_bind (Xml.member "offeringType" xml)
               OfferingTypeValues.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((([] @
                         [Util.option_map v.availability_zone
                            (fun f ->
                               Ezxmlm.make_tag "AvailabilityZone"
                                 ([], (String.to_xml f)))])
                        @
                        (List.map
                           (fun x ->
                              Some
                                (Ezxmlm.make_tag "Filter"
                                   ([], (FilterList.to_xml [x])))) v.filters))
                       @
                       [Util.option_map v.include_marketplace
                          (fun f ->
                             Ezxmlm.make_tag "IncludeMarketplace"
                               ([], (Boolean.to_xml f)))])
                      @
                      [Util.option_map v.instance_type
                         (fun f ->
                            Ezxmlm.make_tag "InstanceType"
                              ([], (InstanceType.to_xml f)))])
                     @
                     [Util.option_map v.max_duration
                        (fun f ->
                           Ezxmlm.make_tag "MaxDuration"
                             ([], (Long.to_xml f)))])
                    @
                    [Util.option_map v.max_instance_count
                       (fun f ->
                          Ezxmlm.make_tag "MaxInstanceCount"
                            ([], (Integer.to_xml f)))])
                   @
                   [Util.option_map v.min_duration
                      (fun f ->
                         Ezxmlm.make_tag "MinDuration" ([], (Long.to_xml f)))])
                  @
                  [Util.option_map v.offering_class
                     (fun f ->
                        Ezxmlm.make_tag "OfferingClass"
                          ([], (OfferingClassType.to_xml f)))])
                 @
                 [Util.option_map v.product_description
                    (fun f ->
                       Ezxmlm.make_tag "ProductDescription"
                         ([], (RIProductDescription.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "ReservedInstancesOfferingId"
                           ([],
                             (ReservedInstancesOfferingIdStringList.to_xml
                                [x])))) v.reserved_instances_offering_ids))
               @
               [Util.option_map v.dry_run
                  (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.instance_tenancy
                 (fun f ->
                    Ezxmlm.make_tag "instanceTenancy"
                      ([], (Tenancy.to_xml f)))])
             @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.offering_type
              (fun f ->
                 Ezxmlm.make_tag "offeringType"
                   ([], (OfferingTypeValues.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeReservedInstancesOfferings.</p>"]
module DescribeReservedInstancesOfferingsResult =
  DescribeReservedInstancesOfferingsResult
type input = DescribeReservedInstancesOfferingsRequest.t
type output = DescribeReservedInstancesOfferingsResult.t
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
         ("Action", ["DescribeReservedInstancesOfferings"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeReservedInstancesOfferingsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeReservedInstancesOfferingsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeReservedInstancesOfferingsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeReservedInstancesOfferingsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeReservedInstancesOfferingsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeReservedInstancesOfferingsResult - missing field in body or children: "
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