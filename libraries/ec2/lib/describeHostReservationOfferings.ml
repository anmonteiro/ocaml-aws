open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeHostReservationOfferingsRequest =
  struct
    type t =
      {
      filter: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>instance-family</code> - The instance family of the offering (for example, <code>m4</code>).</p> </li> <li> <p> <code>payment-option</code> - The payment option (<code>NoUpfront</code> | <code>PartialUpfront</code> | <code>AllUpfront</code>).</p> </li> </ul>"];
      max_duration: Integer.t option
        [@ocaml.doc
          "<p>This is the maximum duration of the reservation to purchase, specified in seconds. Reservations are available in one-year and three-year terms. The number of seconds specified must be the number of seconds in a year (365x24x60x60) times one of the supported durations (1 or 3). For example, specify 94608000 for three years.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results can be seen by sending another request with the returned <code>nextToken</code> value. This value can be between 5 and 500. If <code>maxResults</code> is given a larger value than 500, you receive an error.</p>"];
      min_duration: Integer.t option
        [@ocaml.doc
          "<p>This is the minimum duration of the reservation you'd like to purchase, specified in seconds. Reservations are available in one-year and three-year terms. The number of seconds specified must be the number of seconds in a year (365x24x60x60) times one of the supported durations (1 or 3). For example, specify 31536000 for one year.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use to retrieve the next page of results.</p>"];
      offering_id: String.t option
        [@ocaml.doc "<p>The ID of the reservation offering.</p>"]}
    let make ?(filter= [])  ?max_duration  ?max_results  ?min_duration 
      ?next_token  ?offering_id  () =
      {
        filter;
        max_duration;
        max_results;
        min_duration;
        next_token;
        offering_id
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.offering_id
              (fun f -> Query.Pair ("OfferingId", (String.to_query f)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.min_duration
             (fun f -> Query.Pair ("MinDuration", (Integer.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Util.option_map v.max_duration
             (fun f -> Query.Pair ("MaxDuration", (Integer.to_query f)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filter)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.offering_id
              (fun f -> ("offering_id", (String.to_json f)));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.min_duration
             (fun f -> ("min_duration", (Integer.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.max_duration
             (fun f -> ("max_duration", (Integer.to_json f)));
           Some ("filter", (FilterList.to_json v.filter))])
    let parse xml =
      Some
        {
          filter =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          max_duration =
            (Util.option_bind (Xml.member "MaxDuration" xml) Integer.parse);
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          min_duration =
            (Util.option_bind (Xml.member "MinDuration" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          offering_id =
            (Util.option_bind (Xml.member "OfferingId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "Filter"
                           ([], (FilterList.to_xml [x])))) v.filter))
               @
               [Util.option_map v.max_duration
                  (fun f ->
                     Ezxmlm.make_tag "MaxDuration" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.max_results
                 (fun f ->
                    Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.min_duration
                (fun f ->
                   Ezxmlm.make_tag "MinDuration" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Util.option_map v.offering_id
              (fun f -> Ezxmlm.make_tag "OfferingId" ([], (String.to_xml f)))])
  end
module DescribeHostReservationOfferingsResult =
  DescribeHostReservationOfferingsResult
type input = DescribeHostReservationOfferingsRequest.t
type output = DescribeHostReservationOfferingsResult.t
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
         ("Action", ["DescribeHostReservationOfferings"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeHostReservationOfferingsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeHostReservationOfferingsRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeHostReservationOfferingsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeHostReservationOfferingsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeHostReservationOfferingsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeHostReservationOfferingsResult - missing field in body or children: "
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