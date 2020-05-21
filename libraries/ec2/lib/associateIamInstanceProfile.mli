(** "<p>Associates an IAM instance profile with a running or stopped instance. You cannot associate more than one IAM instance profile with an instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AssociateIamInstanceProfileRequest :
sig
  type t =
    {
    iam_instance_profile: IamInstanceProfileSpecification.t ;
    instance_id: String.t }
  val make :
    iam_instance_profile:IamInstanceProfileSpecification.t ->
      instance_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AssociateIamInstanceProfileResult = AssociateIamInstanceProfileResult
type input = AssociateIamInstanceProfileRequest.t
type output = AssociateIamInstanceProfileResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error