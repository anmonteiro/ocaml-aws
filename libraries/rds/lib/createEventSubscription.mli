(** "<p>Creates an RDS event notification subscription. This action requires a topic ARN (Amazon Resource Name) created by either the RDS console, the SNS console, or the SNS API. To obtain an ARN with SNS, you must create a topic in Amazon SNS and subscribe to the topic. The ARN is displayed in the SNS console.</p> <p>You can specify the type of source (SourceType) you want to be notified of, provide a list of RDS sources (SourceIds) that triggers the events, and provide a list of event categories (EventCategories) for events you want to be notified of. For example, you can specify SourceType = db-instance, SourceIds = mydbinstance1, mydbinstance2 and EventCategories = Availability, Backup.</p> <p>If you specify both the SourceType and SourceIds, such as SourceType = db-instance and SourceIdentifier = myDBInstance1, you are notified of all the db-instance events for the specified source. If you specify a SourceType but do not specify a SourceIdentifier, you receive notice of the events for that source type for all your RDS sources. If you do not specify either the SourceType nor the SourceIdentifier, you are notified of events generated from all RDS sources belonging to your customer account.</p> <note> <p>RDS event notification is only available for unencrypted SNS topics. If you specify an encrypted SNS topic, event notifications aren't sent for the topic.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateEventSubscriptionMessage :
sig
  type t =
    {
    subscription_name: String.t ;
    sns_topic_arn: String.t ;
    source_type: String.t option ;
    event_categories: EventCategoriesList.t ;
    source_ids: SourceIdsList.t ;
    enabled: Boolean.t option ;
    tags: TagList.t }[@@ocaml.doc "<p/>"]
  val make :
    subscription_name:String.t ->
      sns_topic_arn:String.t ->
        ?source_type:String.t ->
          ?event_categories:EventCategoriesList.t ->
            ?source_ids:SourceIdsList.t ->
              ?enabled:Boolean.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateEventSubscriptionResult = CreateEventSubscriptionResult
type input = CreateEventSubscriptionMessage.t
type output = CreateEventSubscriptionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error