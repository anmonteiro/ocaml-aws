open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeSpotPriceHistoryRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>availability-zone</code> - The Availability Zone for which prices should be returned.</p> </li> <li> <p> <code>instance-type</code> - The type of instance (for example, <code>m3.medium</code>).</p> </li> <li> <p> <code>product-description</code> - The product description for the Spot price (<code>Linux/UNIX</code> | <code>SUSE Linux</code> | <code>Windows</code> | <code>Linux/UNIX (Amazon VPC)</code> | <code>SUSE Linux (Amazon VPC)</code> | <code>Windows (Amazon VPC)</code>).</p> </li> <li> <p> <code>spot-price</code> - The Spot price. The value must match exactly (or use wildcards; greater than or less than comparison is not supported).</p> </li> <li> <p> <code>timestamp</code> - The time stamp of the Spot price history, in UTC format (for example, <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z). You can use wildcards (* and ?). Greater than or less than comparison is not supported.</p> </li> </ul>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>Filters the results by the specified Availability Zone.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time, up to the current date, from which to stop retrieving the price history data, in UTC format (for example, <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z).</p>"];
      instance_types: InstanceTypeList.t
        [@ocaml.doc
          "<p>Filters the results by the specified instance types.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. Specify a value between 1 and 1000. The default value is 1000. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next set of results.</p>"];
      product_descriptions: ProductDescriptionList.t
        [@ocaml.doc
          "<p>Filters the results by the specified basic product descriptions.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time, up to the past 90 days, from which to start retrieving the price history data, in UTC format (for example, <i>YYYY</i>-<i>MM</i>-<i>DD</i>T<i>HH</i>:<i>MM</i>:<i>SS</i>Z).</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeSpotPriceHistory.</p>"]
    let make ?(filters= [])  ?availability_zone  ?dry_run  ?end_time 
      ?(instance_types= [])  ?max_results  ?next_token 
      ?(product_descriptions= [])  ?start_time  () =
      {
        filters;
        availability_zone;
        dry_run;
        end_time;
        instance_types;
        max_results;
        next_token;
        product_descriptions;
        start_time
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.start_time
              (fun f -> Query.Pair ("StartTime", (DateTime.to_query f)));
           Some
             (Query.Pair
                ("ProductDescription",
                  (ProductDescriptionList.to_query v.product_descriptions)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some
             (Query.Pair
                ("InstanceType",
                  (InstanceTypeList.to_query v.instance_types)));
           Util.option_map v.end_time
             (fun f -> Query.Pair ("EndTime", (DateTime.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.availability_zone
             (fun f -> Query.Pair ("AvailabilityZone", (String.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.start_time
              (fun f -> ("start_time", (DateTime.to_json f)));
           Some
             ("product_descriptions",
               (ProductDescriptionList.to_json v.product_descriptions));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some
             ("instance_types", (InstanceTypeList.to_json v.instance_types));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          availability_zone =
            (Util.option_bind (Xml.member "availabilityZone" xml)
               String.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          end_time =
            (Util.option_bind (Xml.member "endTime" xml) DateTime.parse);
          instance_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstanceType" xml)
                  InstanceTypeList.parse));
          max_results =
            (Util.option_bind (Xml.member "maxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "nextToken" xml) String.parse);
          product_descriptions =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProductDescription" xml)
                  ProductDescriptionList.parse));
          start_time =
            (Util.option_bind (Xml.member "startTime" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "Filter"
                              ([], (FilterList.to_xml [x])))) v.filters))
                  @
                  [Util.option_map v.availability_zone
                     (fun f ->
                        Ezxmlm.make_tag "availabilityZone"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.dry_run
                    (fun f ->
                       Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.end_time
                   (fun f ->
                      Ezxmlm.make_tag "endTime" ([], (DateTime.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "InstanceType"
                          ([], (InstanceTypeList.to_xml [x]))))
                  v.instance_types))
              @
              [Util.option_map v.max_results
                 (fun f ->
                    Ezxmlm.make_tag "maxResults" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.next_token
                (fun f -> Ezxmlm.make_tag "nextToken" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ProductDescription"
                       ([], (ProductDescriptionList.to_xml [x]))))
               v.product_descriptions))
           @
           [Util.option_map v.start_time
              (fun f -> Ezxmlm.make_tag "startTime" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeSpotPriceHistory.</p>"]
module DescribeSpotPriceHistoryResult = DescribeSpotPriceHistoryResult
type input = DescribeSpotPriceHistoryRequest.t
type output = DescribeSpotPriceHistoryResult.t
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
         ("Action", ["DescribeSpotPriceHistory"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeSpotPriceHistoryRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeSpotPriceHistoryRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeSpotPriceHistoryResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeSpotPriceHistoryResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeSpotPriceHistoryResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeSpotPriceHistoryResult - missing field in body or children: "
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