(** "<p>Describes the modifications made to your Reserved Instances. If no parameter is specified, information about all your Reserved Instances modification requests is returned. If a modification ID is specified, only information about the specific modification is returned.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html\">Modifying Reserved Instances</a> in the Amazon Elastic Compute Cloud User Guide.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeReservedInstancesModificationsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    reserved_instances_modification_ids:
      ReservedInstancesModificationIdStringList.t ;
    next_token: String.t option }[@@ocaml.doc
                                   "<p>Contains the parameters for DescribeReservedInstancesModifications.</p>"]
  val make :
    ?filters:FilterList.t ->
      ?reserved_instances_modification_ids:ReservedInstancesModificationIdStringList.t
        -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeReservedInstancesModificationsResult =
DescribeReservedInstancesModificationsResult
type input = DescribeReservedInstancesModificationsRequest.t
type output = DescribeReservedInstancesModificationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error