(** "<p>Add a parameter to the system.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutParameterRequest :
sig
  type t =
    {
    name: String.t ;
    description: String.t option ;
    value: String.t ;
    type_: ParameterType.t ;
    key_id: String.t option ;
    overwrite: Boolean.t option ;
    allowed_pattern: String.t option ;
    tags: TagList.t ;
    tier: ParameterTier.t option ;
    policies: String.t option }
  val make :
    name:String.t ->
      ?description:String.t ->
        value:String.t ->
          type_:ParameterType.t ->
            ?key_id:String.t ->
              ?overwrite:Boolean.t ->
                ?allowed_pattern:String.t ->
                  ?tags:TagList.t ->
                    ?tier:ParameterTier.t -> ?policies:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module PutParameterResult = PutParameterResult
type input = PutParameterRequest.t
type output = PutParameterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error