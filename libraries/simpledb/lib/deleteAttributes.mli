(** "<p> Deletes one or more attributes associated with an item. If all attributes of the item are deleted, the item is deleted. </p> <p> <code>DeleteAttributes</code> is an idempotent operation; running it multiple times on the same item or attribute does not result in an error response. </p> <p> Because Amazon SimpleDB makes multiple copies of item data and uses an eventual consistency update model, performing a <a>GetAttributes</a> or <a>Select</a> operation (read) immediately after a <code>DeleteAttributes</code> or <a>PutAttributes</a> operation (write) might not return updated item data. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteAttributesRequest :
sig
  type t =
    {
    domain_name: String.t ;
    item_name: String.t ;
    attributes: AttributeList.t ;
    expected: UpdateCondition.t option }
  val make :
    domain_name:String.t ->
      item_name:String.t ->
        ?attributes:AttributeList.t ->
          ?expected:UpdateCondition.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteAttributesRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error