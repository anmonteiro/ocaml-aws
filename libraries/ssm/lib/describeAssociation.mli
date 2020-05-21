(** "<p>Describes the association for the specified target or instance. If you created the association by using the <code>Targets</code> parameter, then you must retrieve the association by using the association ID. If you created the association by specifying an instance ID and a Systems Manager document, then you retrieve the association by specifying the document name and the instance ID. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeAssociationRequest :
sig
  type t =
    {
    name: String.t option ;
    instance_id: String.t option ;
    association_id: String.t option ;
    association_version: String.t option }
  val make :
    ?name:String.t ->
      ?instance_id:String.t ->
        ?association_id:String.t ->
          ?association_version:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module DescribeAssociationResult = DescribeAssociationResult
type input = DescribeAssociationRequest.t
type output = DescribeAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error