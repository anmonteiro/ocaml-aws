(** "<p>Deletes the specified ingress or egress entry (rule) from the specified network ACL.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DeleteNetworkAclEntryRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    egress: Boolean.t ;
    network_acl_id: String.t ;
    rule_number: Integer.t }
  val make :
    ?dry_run:Boolean.t ->
      egress:Boolean.t ->
        network_acl_id:String.t -> rule_number:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = DeleteNetworkAclEntryRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error