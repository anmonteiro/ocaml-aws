(** "<p>Registers your on-premises server or virtual machine with Amazon EC2 so that you can manage these resources using Run Command. An on-premises server or virtual machine that has been registered with EC2 is called a managed instance. For more information about activations, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-managedinstances.html\">Setting Up AWS Systems Manager for Hybrid Environments</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateActivationRequest :
sig
  type t =
    {
    description: String.t option ;
    default_instance_name: String.t option ;
    iam_role: String.t ;
    registration_limit: Integer.t option ;
    expiration_date: DateTime.t option ;
    tags: TagList.t }
  val make :
    ?description:String.t ->
      ?default_instance_name:String.t ->
        iam_role:String.t ->
          ?registration_limit:Integer.t ->
            ?expiration_date:DateTime.t -> ?tags:TagList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module CreateActivationResult = CreateActivationResult
type input = CreateActivationRequest.t
type output = CreateActivationResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error