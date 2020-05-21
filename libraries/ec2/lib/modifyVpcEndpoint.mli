(** "<p>Modifies attributes of a specified VPC endpoint. The attributes that you can modify depend on the type of VPC endpoint (interface or gateway). For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html\">VPC Endpoints</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcEndpointRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    vpc_endpoint_id: String.t ;
    reset_policy: Boolean.t option ;
    policy_document: String.t option ;
    add_route_table_ids: ValueStringList.t ;
    remove_route_table_ids: ValueStringList.t ;
    add_subnet_ids: ValueStringList.t ;
    remove_subnet_ids: ValueStringList.t ;
    add_security_group_ids: ValueStringList.t ;
    remove_security_group_ids: ValueStringList.t ;
    private_dns_enabled: Boolean.t option }[@@ocaml.doc
                                             "<p>Contains the parameters for ModifyVpcEndpoint.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      vpc_endpoint_id:String.t ->
        ?reset_policy:Boolean.t ->
          ?policy_document:String.t ->
            ?add_route_table_ids:ValueStringList.t ->
              ?remove_route_table_ids:ValueStringList.t ->
                ?add_subnet_ids:ValueStringList.t ->
                  ?remove_subnet_ids:ValueStringList.t ->
                    ?add_security_group_ids:ValueStringList.t ->
                      ?remove_security_group_ids:ValueStringList.t ->
                        ?private_dns_enabled:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpcEndpointResult = ModifyVpcEndpointResult
type input = ModifyVpcEndpointRequest.t
type output = ModifyVpcEndpointResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error