(** "<p>Assigns or changes an Amazon Identity and Access Management (IAM) role for the managed instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateManagedInstanceRoleRequest :
sig
  type t = {
    instance_id: String.t ;
    iam_role: String.t }
  val make : instance_id:String.t -> iam_role:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = UpdateManagedInstanceRoleRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error