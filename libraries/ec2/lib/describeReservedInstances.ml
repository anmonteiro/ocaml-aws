open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReservedInstancesRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>availability-zone</code> - The Availability Zone where the Reserved Instance can be used.</p> </li> <li> <p> <code>duration</code> - The duration of the Reserved Instance (one year or three years), in seconds (<code>31536000</code> | <code>94608000</code>).</p> </li> <li> <p> <code>end</code> - The time when the Reserved Instance expires (for example, 2015-08-07T11:54:42.000Z).</p> </li> <li> <p> <code>fixed-price</code> - The purchase price of the Reserved Instance (for example, 9800.0).</p> </li> <li> <p> <code>instance-type</code> - The instance type that is covered by the reservation.</p> </li> <li> <p> <code>scope</code> - The scope of the Reserved Instance (<code>Region</code> or <code>Availability Zone</code>).</p> </li> <li> <p> <code>product-description</code> - The Reserved Instance product platform description. Instances that include <code>(Amazon VPC)</code> in the product platform description will only be displayed to EC2-Classic account holders and are for use with Amazon VPC (<code>Linux/UNIX</code> | <code>Linux/UNIX (Amazon VPC)</code> | <code>SUSE Linux</code> | <code>SUSE Linux (Amazon VPC)</code> | <code>Red Hat Enterprise Linux</code> | <code>Red Hat Enterprise Linux (Amazon VPC)</code> | <code>Windows</code> | <code>Windows (Amazon VPC)</code> | <code>Windows with SQL Server Standard</code> | <code>Windows with SQL Server Standard (Amazon VPC)</code> | <code>Windows with SQL Server Web</code> | <code>Windows with SQL Server Web (Amazon VPC)</code> | <code>Windows with SQL Server Enterprise</code> | <code>Windows with SQL Server Enterprise (Amazon VPC)</code>).</p> </li> <li> <p> <code>reserved-instances-id</code> - The ID of the Reserved Instance.</p> </li> <li> <p> <code>start</code> - The time at which the Reserved Instance purchase request was placed (for example, 2014-08-07T11:54:42.000Z).</p> </li> <li> <p> <code>state</code> - The state of the Reserved Instance (<code>payment-pending</code> | <code>active</code> | <code>payment-failed</code> | <code>retired</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> <li> <p> <code>usage-price</code> - The usage price of the Reserved Instance, per hour (for example, 0.84).</p> </li> </ul>"];
      offering_class: OfferingClassType.t option
        [@ocaml.doc
          "<p>Describes whether the Reserved Instance is Standard or Convertible.</p>"];
      reserved_instances_ids: ReservedInstancesIdStringList.t
        [@ocaml.doc
          "<p>One or more Reserved Instance IDs.</p> <p>Default: Describes all your Reserved Instances, or only those otherwise specified.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      offering_type: OfferingTypeValues.t option
        [@ocaml.doc
          "<p>The Reserved Instance offering type. If you are using tools that predate the 2011-11-01 API version, you only have access to the <code>Medium Utilization</code> Reserved Instance offering type.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeReservedInstances.</p>"]
    let make ?(filters= [])  ?offering_class  ?(reserved_instances_ids= []) 
      ?dry_run  ?offering_type  () =
      {
        filters;
        offering_class;
        reserved_instances_ids;
        dry_run;
        offering_type
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.offering_type
              (fun f ->
                 Query.Pair ("OfferingType", (OfferingTypeValues.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("ReservedInstancesId",
                  (ReservedInstancesIdStringList.to_query
                     v.reserved_instances_ids)));
           Util.option_map v.offering_class
             (fun f ->
                Query.Pair ("OfferingClass", (OfferingClassType.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.offering_type
              (fun f -> ("offering_type", (OfferingTypeValues.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some
             ("reserved_instances_ids",
               (ReservedInstancesIdStringList.to_json
                  v.reserved_instances_ids));
           Util.option_map v.offering_class
             (fun f -> ("offering_class", (OfferingClassType.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          offering_class =
            (Util.option_bind (Xml.member "OfferingClass" xml)
               OfferingClassType.parse);
          reserved_instances_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReservedInstancesId" xml)
                  ReservedInstancesIdStringList.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          offering_type =
            (Util.option_bind (Xml.member "offeringType" xml)
               OfferingTypeValues.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Filter"
                          ([], (FilterList.to_xml [x])))) v.filters))
              @
              [Util.option_map v.offering_class
                 (fun f ->
                    Ezxmlm.make_tag "OfferingClass"
                      ([], (OfferingClassType.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ReservedInstancesId"
                        ([], (ReservedInstancesIdStringList.to_xml [x]))))
                v.reserved_instances_ids))
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.offering_type
              (fun f ->
                 Ezxmlm.make_tag "offeringType"
                   ([], (OfferingTypeValues.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeReservedInstances.</p>"]
module DescribeReservedInstancesResult = DescribeReservedInstancesResult
type input = DescribeReservedInstancesRequest.t
type output = DescribeReservedInstancesResult.t
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
         ("Action", ["DescribeReservedInstances"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeReservedInstancesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeReservedInstancesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeReservedInstancesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeReservedInstancesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeReservedInstancesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeReservedInstancesResult - missing field in body or children: "
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