open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeScheduledInstanceAvailabilityRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      filters: FilterList.t
        [@ocaml.doc
          "<p>The filters.</p> <ul> <li> <p> <code>availability-zone</code> - The Availability Zone (for example, <code>us-west-2a</code>).</p> </li> <li> <p> <code>instance-type</code> - The instance type (for example, <code>c4.large</code>).</p> </li> <li> <p> <code>network-platform</code> - The network platform (<code>EC2-Classic</code> or <code>EC2-VPC</code>).</p> </li> <li> <p> <code>platform</code> - The platform (<code>Linux/UNIX</code> or <code>Windows</code>).</p> </li> </ul>"];
      first_slot_start_time_range: SlotDateTimeRangeRequest.t
        [@ocaml.doc
          "<p>The time period for the first schedule to start.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of results to return in a single call. This value can be between 5 and 300. The default value is 300. To retrieve the remaining results, make another call with the returned <code>NextToken</code> value.</p>"];
      max_slot_duration_in_hours: Integer.t option
        [@ocaml.doc
          "<p>The maximum available duration, in hours. This value must be greater than <code>MinSlotDurationInHours</code> and less than 1,720.</p>"];
      min_slot_duration_in_hours: Integer.t option
        [@ocaml.doc
          "<p>The minimum available duration, in hours. The minimum required duration is 1,200 hours per year. For example, the minimum daily schedule is 4 hours, the minimum weekly schedule is 24 hours, and the minimum monthly schedule is 100 hours.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>The token for the next set of results.</p>"];
      recurrence: ScheduledInstanceRecurrenceRequest.t
        [@ocaml.doc "<p>The schedule recurrence.</p>"]}[@@ocaml.doc
                                                         "<p>Contains the parameters for DescribeScheduledInstanceAvailability.</p>"]
    let make ?dry_run  ?(filters= [])  ~first_slot_start_time_range 
      ?max_results  ?max_slot_duration_in_hours  ?min_slot_duration_in_hours 
      ?next_token  ~recurrence  () =
      {
        dry_run;
        filters;
        first_slot_start_time_range;
        max_results;
        max_slot_duration_in_hours;
        min_slot_duration_in_hours;
        next_token;
        recurrence
      }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("Recurrence",
                   (ScheduledInstanceRecurrenceRequest.to_query v.recurrence)));
           Util.option_map v.next_token
             (fun f -> Query.Pair ("NextToken", (String.to_query f)));
           Util.option_map v.min_slot_duration_in_hours
             (fun f ->
                Query.Pair ("MinSlotDurationInHours", (Integer.to_query f)));
           Util.option_map v.max_slot_duration_in_hours
             (fun f ->
                Query.Pair ("MaxSlotDurationInHours", (Integer.to_query f)));
           Util.option_map v.max_results
             (fun f -> Query.Pair ("MaxResults", (Integer.to_query f)));
           Some
             (Query.Pair
                ("FirstSlotStartTimeRange",
                  (SlotDateTimeRangeRequest.to_query
                     v.first_slot_start_time_range)));
           Some (Query.Pair ("Filter", (FilterList.to_query v.filters)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("recurrence",
                (ScheduledInstanceRecurrenceRequest.to_json v.recurrence));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.min_slot_duration_in_hours
             (fun f -> ("min_slot_duration_in_hours", (Integer.to_json f)));
           Util.option_map v.max_slot_duration_in_hours
             (fun f -> ("max_slot_duration_in_hours", (Integer.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some
             ("first_slot_start_time_range",
               (SlotDateTimeRangeRequest.to_json
                  v.first_slot_start_time_range));
           Some ("filters", (FilterList.to_json v.filters));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Filter" xml) FilterList.parse));
          first_slot_start_time_range =
            (Xml.required "FirstSlotStartTimeRange"
               (Util.option_bind (Xml.member "FirstSlotStartTimeRange" xml)
                  SlotDateTimeRangeRequest.parse));
          max_results =
            (Util.option_bind (Xml.member "MaxResults" xml) Integer.parse);
          max_slot_duration_in_hours =
            (Util.option_bind (Xml.member "MaxSlotDurationInHours" xml)
               Integer.parse);
          min_slot_duration_in_hours =
            (Util.option_bind (Xml.member "MinSlotDurationInHours" xml)
               Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse);
          recurrence =
            (Xml.required "Recurrence"
               (Util.option_bind (Xml.member "Recurrence" xml)
                  ScheduledInstanceRecurrenceRequest.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.dry_run
                     (fun f ->
                        Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "Filter"
                            ([], (FilterList.to_xml [x])))) v.filters))
                @
                [Some
                   (Ezxmlm.make_tag "FirstSlotStartTimeRange"
                      ([],
                        (SlotDateTimeRangeRequest.to_xml
                           v.first_slot_start_time_range)))])
               @
               [Util.option_map v.max_results
                  (fun f ->
                     Ezxmlm.make_tag "MaxResults" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.max_slot_duration_in_hours
                 (fun f ->
                    Ezxmlm.make_tag "MaxSlotDurationInHours"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.min_slot_duration_in_hours
                (fun f ->
                   Ezxmlm.make_tag "MinSlotDurationInHours"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.next_token
               (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "Recurrence"
                 ([],
                   (ScheduledInstanceRecurrenceRequest.to_xml v.recurrence)))])
  end[@@ocaml.doc
       "<p>Contains the parameters for DescribeScheduledInstanceAvailability.</p>"]
module DescribeScheduledInstanceAvailabilityResult =
  DescribeScheduledInstanceAvailabilityResult
type input = DescribeScheduledInstanceAvailabilityRequest.t
type output = DescribeScheduledInstanceAvailabilityResult.t
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
         ("Action", ["DescribeScheduledInstanceAvailability"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (DescribeScheduledInstanceAvailabilityRequest.to_query req))))) in
  (`POST, uri,
    (Headers.render
       (DescribeScheduledInstanceAvailabilityRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Xml.member "DescribeScheduledInstanceAvailabilityResponse" (snd xml) in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp
             DescribeScheduledInstanceAvailabilityResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DescribeScheduledInstanceAvailabilityResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeScheduledInstanceAvailabilityResult - missing field in body or children: "
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