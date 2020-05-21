(** "<p>Creates a data feed for Spot Instances, enabling you to view Spot Instance usage logs. You can create one data feed per AWS account. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-data-feeds.html\">Spot Instance Data Feed</a> in the <i>Amazon EC2 User Guide for Linux Instances</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateSpotDatafeedSubscriptionRequest :
sig
  type t =
    {
    bucket: String.t ;
    dry_run: Boolean.t option ;
    prefix: String.t option }[@@ocaml.doc
                               "<p>Contains the parameters for CreateSpotDatafeedSubscription.</p>"]
  val make :
    bucket:String.t -> ?dry_run:Boolean.t -> ?prefix:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateSpotDatafeedSubscriptionResult =
CreateSpotDatafeedSubscriptionResult
type input = CreateSpotDatafeedSubscriptionRequest.t
type output = CreateSpotDatafeedSubscriptionResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error