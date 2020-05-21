(** "<p>Modifies the Availability Zone, instance count, instance type, or network platform (EC2-Classic or EC2-VPC) of your Reserved Instances. The Reserved Instances to be modified must be identical, except for Availability Zone, network platform, and instance type.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html\">Modifying Reserved Instances</a> in the Amazon Elastic Compute Cloud User Guide.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyReservedInstancesRequest :
sig
  type t =
    {
    reserved_instances_ids: ReservedInstancesIdStringList.t ;
    client_token: String.t option ;
    target_configurations: ReservedInstancesConfigurationList.t }[@@ocaml.doc
                                                                   "<p>Contains the parameters for ModifyReservedInstances.</p>"]
  val make :
    reserved_instances_ids:ReservedInstancesIdStringList.t ->
      ?client_token:String.t ->
        target_configurations:ReservedInstancesConfigurationList.t ->
          unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyReservedInstancesResult = ModifyReservedInstancesResult
type input = ModifyReservedInstancesRequest.t
type output = ModifyReservedInstancesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error