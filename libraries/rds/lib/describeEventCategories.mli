(** "<p>Displays a list of categories for all event source types, or, if specified, for a specified source type. You can see a list of the event categories and source types in the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html\"> Events</a> topic in the <i>Amazon RDS User Guide.</i> </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeEventCategoriesMessage :
sig
  type t = {
    source_type: String.t option ;
    filters: FilterList.t }[@@ocaml.doc "<p/>"]
  val make : ?source_type:String.t -> ?filters:FilterList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module EventCategoriesMessage = EventCategoriesMessage
type input = DescribeEventCategoriesMessage.t
type output = EventCategoriesMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error