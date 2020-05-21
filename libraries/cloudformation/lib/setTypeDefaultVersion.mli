(** "<p>Specify the default version of a type. The default version of a type will be used in CloudFormation operations.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SetTypeDefaultVersionInput :
sig
  type t =
    {
    arn: String.t option ;
    type_: RegistryType.t option ;
    type_name: String.t option ;
    version_id: String.t option }
  val make :
    ?arn:String.t ->
      ?type_:RegistryType.t ->
        ?type_name:String.t -> ?version_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = SetTypeDefaultVersionInput.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error