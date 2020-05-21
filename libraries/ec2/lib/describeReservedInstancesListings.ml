open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeReservedInstancesListingsRequest =
  struct
    type t =
      {
      filters: FilterList.t
        [@ocaml.doc
          "<p>One or more filters.</p> <ul> <li> <p> <code>reserved-instances-id</code> - The ID of the Reserved Instances.</p> </li> <li> <p> <code>reserved-instances-listing-id</code> - The ID of the Reserved Instances listing.</p> </li> <li> <p> <code>status</code> - The status of the Reserved Instance listing (<code>pending</code> | <code>active</code> | <code>cancelled</code> | <code>closed</code>).</p> </li> <li> <p> <code>status-message</code> - The reason for the status.</p> </li> </ul>"];
      reserved_instances_id: String.t option
        [@ocaml.doc "<p>One or more Reserved Instance IDs.</p>"];
      reserved_instances_listing_id: String.t option
        [@ocaml.doc "<p>One or more Reserved Instance listing IDs.</p>"]}
    [@@ocaml.doc
      "<p>Contains the parameters for DescribeReservedInstancesListings.</p>"]
    let make ?(filters= [])  ?reserved_instances_id 
      ?reserved_instances_listing_id  () =
      { filters; reserved_instances_id; reserved_instances_listing_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.reserved_instances_listing_id
              (fun f ->
                 Query.Pair
                   ("ReservedInstancesListingId", (String.to_query f)));
           Util.option_map v.reserved_instances_id
             (fun f ->
                Query.Pair ("ReservedInstancesId", (String.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reserved_instances_listing_id
              (fun f -> ("reserved_instances_listing_id", (String.to_json f)));
           Util.option_map v.reserved_instances_id
             (fun f -> ("reserved_instances_id", (String.to_json f)));
           Some ("filters", (FilterList.to_json v.filters))])
    let parse xml =
      Some
        {
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          reserved_instances_id =
            (Util.option_bind (Xml.member "reservedInstancesId" xml)
               String.parse);
          reserved_instances_listing_id =
            (Util.option_bind (Xml.member "reservedInstancesListingId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                v.filters))
            @
            [Util.option_map v.reserved_instances_id
               (fun f ->
                  Ezxmlm.make_tag "reservedInstancesId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.reserved_instances_listing_id
              (fun f ->
                 Ezxmlm.make_tag "reservedInstancesListingId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeReservedInstancesListings.</p>"]
module DescribeReservedInstancesListingsResult =
  DescribeReservedInstancesListingsResult
type input = DescribeReservedInstancesListingsRequest.t
type output = DescribeReservedInstancesListingsResult.t
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
         ("Action", ["DescribeReservedInstancesListings"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeReservedInstancesListingsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeReservedInstancesListingsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeReservedInstancesListingsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeReservedInstancesListingsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeReservedInstancesListingsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeReservedInstancesListingsResult - missing field in body or children: "
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