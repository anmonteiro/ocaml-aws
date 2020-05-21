open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeCapacityReservationsRequest =
  struct
    type t =
      {
      capacity_reservation_ids: CapacityReservationIdSet.t
        [@ocaml.doc "<p>The ID of the Capacity Reservation.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token to retrieve the next page of results.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results can be seen by sending another request with the returned nextToken value.</p>"];
      filters: FilterList.t [@ocaml.doc "<p>One or more filters.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"]}
    let make ?(capacity_reservation_ids= [])  ?next_token  ?max_results 
      ?(filters= [])  ?dry_run  () =
      { capacity_reservation_ids; next_token; max_results; filters; dry_run }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Some
             (Query.Pair
                ("CapacityReservationId",
                  (CapacityReservationIdSet.to_query
                     v.capacity_reservation_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dry_run
              (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Some
             ("capacity_reservation_ids",
               (CapacityReservationIdSet.to_json v.capacity_reservation_ids))])
    let parse xml =
      Some
        {
          capacity_reservation_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "CapacityReservationId" xml)
                  CapacityReservationIdSet.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "CapacityReservationId"
                          ([], (CapacityReservationIdSet.to_xml [x]))))
                  v.capacity_reservation_ids))
              @
              [Util.option_map v.next_token
                 (fun f ->
                    Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_results
                (fun f ->
                   Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
               v.filters))
           @
           [Util.option_map v.dry_run
              (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
  end
module DescribeCapacityReservationsResult =
  DescribeCapacityReservationsResult
type input = DescribeCapacityReservationsRequest.t
type output = DescribeCapacityReservationsResult.t
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
         ("Action", ["DescribeCapacityReservations"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeCapacityReservationsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeCapacityReservationsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeCapacityReservationsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeCapacityReservationsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeCapacityReservationsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeCapacityReservationsResult - missing field in body or children: "
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