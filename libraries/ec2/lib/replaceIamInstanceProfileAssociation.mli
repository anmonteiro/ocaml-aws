(** "<p>Replaces an IAM instance profile for the specified running instance. You can use this action to change the IAM instance profile that's associated with an instance without having to disassociate the existing IAM instance profile first.</p> <p>Use <a>DescribeIamInstanceProfileAssociations</a> to get the association ID.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ReplaceIamInstanceProfileAssociationRequest :
sig
  type t =
    {
    iam_instance_profile: IamInstanceProfileSpecification.t ;
    association_id: String.t }
  val make :
    iam_instance_profile:IamInstanceProfileSpecification.t ->
      association_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ReplaceIamInstanceProfileAssociationResult =
ReplaceIamInstanceProfileAssociationResult
type input = ReplaceIamInstanceProfileAssociationRequest.t
type output = ReplaceIamInstanceProfileAssociationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error