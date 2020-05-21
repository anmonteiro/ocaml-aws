(** "<p>Looks up <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html#cloudtrail-concepts-management-events\">management events</a> or <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-concepts.html#cloudtrail-concepts-insights-events\">CloudTrail Insights events</a> that are captured by CloudTrail. You can look up events that occurred in a region within the last 90 days. Lookup supports the following attributes for management events:</p> <ul> <li> <p>AWS access key</p> </li> <li> <p>Event ID</p> </li> <li> <p>Event name</p> </li> <li> <p>Event source</p> </li> <li> <p>Read only</p> </li> <li> <p>Resource name</p> </li> <li> <p>Resource type</p> </li> <li> <p>User name</p> </li> </ul> <p>Lookup supports the following attributes for Insights events:</p> <ul> <li> <p>Event ID</p> </li> <li> <p>Event name</p> </li> <li> <p>Event source</p> </li> </ul> <p>All attributes are optional. The default number of results returned is 50, with a maximum of 50 possible. The response includes a token that you can use to get the next page of results.</p> <important> <p>The rate of lookup requests is limited to two per second per account. If this limit is exceeded, a throttling error occurs.</p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module LookupEventsRequest :
sig
  type t =
    {
    lookup_attributes: LookupAttributesList.t ;
    start_time: DateTime.t option ;
    end_time: DateTime.t option ;
    event_category: EventCategory.t option ;
    max_results: Integer.t option ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>Contains a request for LookupEvents.</p>"]
  val make :
    ?lookup_attributes:LookupAttributesList.t ->
      ?start_time:DateTime.t ->
        ?end_time:DateTime.t ->
          ?event_category:EventCategory.t ->
            ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module LookupEventsResponse = LookupEventsResponse
type input = LookupEventsRequest.t
type output = LookupEventsResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error