(** "<p>Modifies an existing RDS event notification subscription. Note that you can't modify the source identifiers using this call; to change source identifiers for a subscription, use the <code>AddSourceIdentifierToSubscription</code> and <code>RemoveSourceIdentifierFromSubscription</code> calls.</p> <p>You can see a list of the event categories for a given SourceType in the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html\">Events</a> topic in the <i>Amazon RDS User Guide</i> or by using the <b>DescribeEventCategories</b> action.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyEventSubscriptionMessage :
sig
  type t =
    {
    subscription_name: String.t ;
    sns_topic_arn: String.t option ;
    source_type: String.t option ;
    event_categories: EventCategoriesList.t ;
    enabled: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    subscription_name:String.t ->
      ?sns_topic_arn:String.t ->
        ?source_type:String.t ->
          ?event_categories:EventCategoriesList.t ->
            ?enabled:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyEventSubscriptionResult = ModifyEventSubscriptionResult
type input = ModifyEventSubscriptionMessage.t
type output = ModifyEventSubscriptionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error