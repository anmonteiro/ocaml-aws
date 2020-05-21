(** "<p> Returns all of the attributes associated with the specified item. Optionally, the attributes returned can be limited to one or more attributes by specifying an attribute name parameter. </p> <p> If the item does not exist on the replica that was accessed for this operation, an empty set is returned. The system does not return an error as it cannot guarantee the item does not exist on other replicas. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetAttributesRequest :
sig
  type t =
    {
    domain_name: String.t ;
    item_name: String.t ;
    attribute_names: AttributeNameList.t ;
    consistent_read: Boolean.t option }
  val make :
    domain_name:String.t ->
      item_name:String.t ->
        ?attribute_names:AttributeNameList.t ->
          ?consistent_read:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetAttributesResult = GetAttributesResult
type input = GetAttributesRequest.t
type output = GetAttributesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error