open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReservedDBInstancesOfferingsMessage =
  struct
    type t =
      {
      reserved_d_b_instances_offering_id: String.t option
        [@ocaml.doc
          "<p>The offering identifier filter value. Specify this parameter to show only the available offering that matches the specified reservation identifier.</p> <p>Example: <code>438012d3-4052-4cc7-b2e3-8d3372e0e706</code> </p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The DB instance class filter value. Specify this parameter to show only the available offerings matching the specified DB instance class.</p>"];
      duration: String.t option
        [@ocaml.doc
          "<p>Duration filter value, specified in years or seconds. Specify this parameter to show only reservations for this duration.</p> <p>Valid Values: <code>1 | 3 | 31536000 | 94608000</code> </p>"];
      product_description: String.t option
        [@ocaml.doc
          "<p>Product description filter value. Specify this parameter to show only the available offerings that contain the specified product description.</p> <note> <p>The results show offerings that partially match the filter value.</p> </note>"];
      offering_type: String.t option
        [@ocaml.doc
          "<p>The offering type filter value. Specify this parameter to show only the available offerings matching the specified offering type.</p> <p>Valid Values: <code>\"Partial Upfront\" | \"All Upfront\" | \"No Upfront\" </code> </p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to show only those reservations that support Multi-AZ.</p>"];
      filters: FilterList.t
        [@ocaml.doc "<p>This parameter isn't currently supported.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p> The maximum number of records to include in the response. If more than the <code>MaxRecords</code> value is available, a pagination token called a marker is included in the response so you can retrieve the remaining results. </p> <p>Default: 100</p> <p>Constraints: Minimum 20, maximum 100.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?reserved_d_b_instances_offering_id  ?d_b_instance_class 
      ?duration  ?product_description  ?offering_type  ?multi_a_z  ?(filters=
      [])  ?max_records  ?marker  () =
      {
        reserved_d_b_instances_offering_id;
        d_b_instance_class;
        duration;
        product_description;
        offering_type;
        multi_a_z;
        filters;
        max_records;
        marker
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (String.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.reserved_d_b_instances_offering_id
             (fun f ->
                ("reserved_d_b_instances_offering_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          reserved_d_b_instances_offering_id =
            (Util.option_bind
               (Xml.member "ReservedDBInstancesOfferingId" xml) String.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) String.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filters" xml) FilterList.parse));
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.reserved_d_b_instances_offering_id
                      (fun f ->
                         Ezxmlm.make_tag "ReservedDBInstancesOfferingId"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.d_b_instance_class
                     (fun f ->
                        Ezxmlm.make_tag "DBInstanceClass"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.duration
                    (fun f ->
                       Ezxmlm.make_tag "Duration" ([], (String.to_xml f)))])
                @
                [Util.option_map v.product_description
                   (fun f ->
                      Ezxmlm.make_tag "ProductDescription"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.offering_type
                  (fun f ->
                     Ezxmlm.make_tag "OfferingType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.multi_a_z
                 (fun f -> Ezxmlm.make_tag "MultiAZ" ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filters" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module ReservedDBInstancesOfferingMessage =
  ReservedDBInstancesOfferingMessage
type input = DescribeReservedDBInstancesOfferingsMessage.t
type output = ReservedDBInstancesOfferingMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["DescribeReservedDBInstancesOfferings"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeReservedDBInstancesOfferingsMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeReservedDBInstancesOfferingsMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DescribeReservedDBInstancesOfferingsResponse" (snd xml))
        (Xml.member "DescribeReservedDBInstancesOfferingsResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp ReservedDBInstancesOfferingMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed ReservedDBInstancesOfferingMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReservedDBInstancesOfferingMessage - missing field in body or children: "
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