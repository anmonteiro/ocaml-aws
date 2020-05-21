(** "<p>Creates a placement group in which to launch instances. The strategy of the placement group determines how the instances are organized within the group. </p> <p>A <code>cluster</code> placement group is a logical grouping of instances within a single Availability Zone that benefit from low network latency, high network throughput. A <code>spread</code> placement group places instances on distinct hardware. A <code>partition</code> placement group places groups of instances in different partitions, where instances in one partition do not share the same hardware with instances in another partition.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html\">Placement Groups</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreatePlacementGroupRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    group_name: String.t option ;
    strategy: PlacementStrategy.t option ;
    partition_count: Integer.t option }
  val make :
    ?dry_run:Boolean.t ->
      ?group_name:String.t ->
        ?strategy:PlacementStrategy.t ->
          ?partition_count:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = CreatePlacementGroupRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error