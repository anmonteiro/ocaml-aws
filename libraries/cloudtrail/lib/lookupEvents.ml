open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module LookupEventsRequest =
  struct
    type t =
      {
      lookup_attributes: LookupAttributesList.t
        [@ocaml.doc
          "<p>Contains a list of lookup attributes. Currently the list can contain only one item.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies that only events that occur after or at the specified time are returned. If the specified start time is after the specified end time, an error is returned.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies that only events that occur before or at the specified time are returned. If the specified end time is before the specified start time, an error is returned.</p>"];
      event_category: EventCategory.t option
        [@ocaml.doc
          "<p>Specifies the event category. If you do not specify an event category, events of the category are not returned in the response. For example, if you do not specify <code>insight</code> as the value of <code>EventCategory</code>, no Insights events are returned.</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The number of events to return. Possible values are 1 through 50. The default is 50.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use to get the next page of results after a previous API call. This token must be passed in with the same parameters that were specified in the the original call. For example, if the original call specified an AttributeKey of 'Username' with a value of 'root', the call with NextToken should include those same parameters.</p>"]}
    [@@ocaml.doc "<p>Contains a request for LookupEvents.</p>"]
    let make ?(lookup_attributes= [])  ?start_time  ?end_time 
      ?event_category  ?max_results  ?next_token  () =
      {
        lookup_attributes;
        start_time;
        end_time;
        event_category;
        max_results;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Util.option_map v.event_category
             (fun f -> ("event_category", (EventCategory.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Some
             ("lookup_attributes",
               (LookupAttributesList.to_json v.lookup_attributes))])
    let of_json j =
      {
        lookup_attributes =
          (LookupAttributesList.of_json
             (Util.of_option_exn (Json.lookup j "lookup_attributes")));
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        event_category =
          (Util.option_map (Json.lookup j "event_category")
             EventCategory.of_json);
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end[@@ocaml.doc "<p>Contains a request for LookupEvents.</p>"]
module LookupEventsResponse = LookupEventsResponse
type input = LookupEventsRequest.t
type output = LookupEventsResponse.t
type error = Errors_internal.t
let streaming = false
let service = "cloudtrail"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (LookupEventsRequest.to_query req)))) in
  (`POST, uri, (Headers.render (LookupEventsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (LookupEventsResponse.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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