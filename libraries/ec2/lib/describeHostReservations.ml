open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeHostReservationsRequest =
  struct
    type t =
      {
      filter: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>instance-family</code> - The instance family (for example, <code>m4</code>).</p> </li> <li> <p> <code>payment-option</code> - The payment option (<code>NoUpfront</code> | <code>PartialUpfront</code> | <code>AllUpfront</code>).</p> </li> <li> <p> <code>state</code> - The state of the reservation (<code>payment-pending</code> | <code>payment-failed</code> | <code>active</code> | <code>retired</code>).</p> </li> <li> <p> <code>tag</code>:&lt;key&gt; - The key/value combination of a tag assigned to the resource. Use the tag key in the filter name and the tag value as the filter value. For example, to find all resources that have a tag with the key <code>Owner</code> and the value <code>TeamA</code>, specify <code>tag:Owner</code> for the filter name and <code>TeamA</code> for the filter value.</p> </li> <li> <p> <code>tag-key</code> - The key of a tag assigned to the resource. Use this filter to find all resources assigned a tag with a specific key, regardless of the tag value.</p> </li> </ul>"];
      host_reservation_id_set: HostReservationIdSet.t
        [@ocaml.doc "<p>The host reservation IDs.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return for the request in a single page. The remaining results can be seen by sending another request with the returned <code>nextToken</code> value. This value can be between 5 and 500. If <code>maxResults</code> is given a larger value than 500, you receive an error.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use to retrieve the next page of results.</p>"]}
    let make ?(filter= [])  ?(host_reservation_id_set= [])  ?max_results 
      ?next_token  () =
      { filter; host_reservation_id_set; max_results; next_token }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some
             (Query.Pair
                ("HostReservationIdSet",
                  (HostReservationIdSet.to_query v.host_reservation_id_set)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filter)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some
             ("host_reservation_id_set",
               (HostReservationIdSet.to_json v.host_reservation_id_set));
           Some ("filter", (FilterList.to_json v.filter))])
    let parse xml =
      Some
        {
          filter =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          host_reservation_id_set =
            (Util.of_option []
               (Util.option_bind (Xml.member "HostReservationIdSet" xml)
                  HostReservationIdSet.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Filter" ([], (FilterList.to_xml [x]))))
                 v.filter))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "HostReservationIdSet"
                        ([], (HostReservationIdSet.to_xml [x]))))
                v.host_reservation_id_set))
            @
            [Util.option_map v.max_results
               (fun f ->
                  Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeHostReservationsResult = DescribeHostReservationsResult
type input = DescribeHostReservationsRequest.t
type output = DescribeHostReservationsResult.t
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
         ("Action", ["DescribeHostReservations"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeHostReservationsRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render (DescribeHostReservationsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DescribeHostReservationsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DescribeHostReservationsResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeHostReservationsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeHostReservationsResult - missing field in body or children: "
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