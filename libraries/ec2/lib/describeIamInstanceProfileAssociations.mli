(** "<p>Describes your IAM instance profile associations.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeIamInstanceProfileAssociationsRequest :
sig
  type t =
    {
    association_ids: AssociationIdList.t ;
    filters: FilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?association_ids:AssociationIdList.t ->
      ?filters:FilterList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeIamInstanceProfileAssociationsResult =
DescribeIamInstanceProfileAssociationsResult
type input = DescribeIamInstanceProfileAssociationsRequest.t
type output = DescribeIamInstanceProfileAssociationsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error