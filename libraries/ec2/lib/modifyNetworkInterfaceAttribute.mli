(** "<p>Modifies the specified network interface attribute. You can specify only one attribute at a time. You can use this action to attach and detach security groups from an existing EC2 instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyNetworkInterfaceAttributeRequest :
sig
  type t =
    {
    attachment: NetworkInterfaceAttachmentChanges.t option ;
    description: AttributeValue.t option ;
    dry_run: Boolean.t option ;
    groups: SecurityGroupIdStringList.t ;
    network_interface_id: String.t ;
    source_dest_check: AttributeBooleanValue.t option }[@@ocaml.doc
                                                         "<p>Contains the parameters for ModifyNetworkInterfaceAttribute.</p>"]
  val make :
    ?attachment:NetworkInterfaceAttachmentChanges.t ->
      ?description:AttributeValue.t ->
        ?dry_run:Boolean.t ->
          ?groups:SecurityGroupIdStringList.t ->
            network_interface_id:String.t ->
              ?source_dest_check:AttributeBooleanValue.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = ModifyNetworkInterfaceAttributeRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error