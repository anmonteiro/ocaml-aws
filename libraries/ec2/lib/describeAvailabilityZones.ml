open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAvailabilityZonesRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>group-name</code> - For Availability Zones, use the Region name. For Local Zones, use the name of the group associated with the Local Zone (for example, <code>us-west-2-lax-1</code>).</p> </li> <li> <p> <code>message</code> - The Availability Zone or Local Zone message.</p> </li> <li> <p> <code>opt-in-status</code> - The opt in status (<code>opted-in</code>, and <code>not-opted-in</code> | <code>opt-in-not-required</code>).</p> </li> <li> <p> <code>region-name</code> - The name of the Region for the Availability Zone or Local Zone (for example, <code>us-east-1</code>).</p> </li> <li> <p> <code>state</code> - The state of the Availability Zone or Local Zone (<code>available</code> | <code>information</code> | <code>impaired</code> | <code>unavailable</code>).</p> </li> <li> <p> <code>zone-id</code> - The ID of the Availability Zone (for example, <code>use1-az1</code>) or the Local Zone (for example, use <code>usw2-lax1-az1</code>).</p> </li> <li> <p> <code>zone-name</code> - The name of the Availability Zone (for example, <code>us-east-1a</code>) or the Local Zone (for example, use <code>us-west-2-lax-1a</code>).</p> </li> </ul>"];
      zone_names: ZoneNameStringList.t
        [@ocaml.doc
          "<p>The names of the Availability Zones and Local Zones.</p>"];
      zone_ids: ZoneIdStringList.t
        [@ocaml.doc
          "<p>The IDs of the Availability Zones and Local Zones.</p>"];
      all_availability_zones: Boolean.t option
        [@ocaml.doc
          "<p>Include all Availability Zones and Local Zones regardless of your opt in status.</p> <p>If you do not use this parameter, the results include only the zones for the Regions where you have chosen the option to opt in.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(filters= [])  ?(zone_names= [])  ?(zone_ids= []) 
      ?all_availability_zones  ?dry_run  () =
      { filters; zone_names; zone_ids; all_availability_zones; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.all_availability_zones
             (fun f ->
                Query.Pair ("AllAvailabilityZones", (Boolean.to_query f)));
           Some
             (Query.Pair ("ZoneId", (ZoneIdStringList.to_query v.zone_ids)));
           Some
             (Query.Pair
                ("ZoneName", (ZoneNameStringList.to_query v.zone_names)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.all_availability_zones
             (fun f -> ("all_availability_zones", (Boolean.to_json f)));
           Some ("zone_ids", (ZoneIdStringList.to_json v.zone_ids));
           Some ("zone_names", (ZoneNameStringList.to_json v.zone_names));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          zone_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "ZoneName" xml)
                  ZoneNameStringList.parse));
          zone_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "ZoneId" xml)
                  ZoneIdStringList.parse));
          all_availability_zones =
            (Util.option_bind (Xml.member "AllAvailabilityZones" xml)
               Boolean.parse);
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse)
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
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "ZoneName"
                         ([], (ZoneNameStringList.to_xml [x])))) v.zone_names))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ZoneId"
                        ([], (ZoneIdStringList.to_xml [x])))) v.zone_ids))
            @
            [Util.option_map v.all_availability_zones
               (fun f ->
                  Ezxmlm.make_tag "AllAvailabilityZones"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeAvailabilityZonesResult = DescribeAvailabilityZonesResult
type input = DescribeAvailabilityZonesRequest.t
type output = DescribeAvailabilityZonesResult.t
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
         ("Action", ["DescribeAvailabilityZones"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeAvailabilityZonesRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeAvailabilityZonesRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeAvailabilityZonesResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeAvailabilityZonesResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeAvailabilityZonesResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeAvailabilityZonesResult - missing field in body or children: "
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