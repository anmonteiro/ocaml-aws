(** "<p>Allocates a Dedicated Host to your account. At a minimum, specify the supported instance type or instance family, the Availability Zone in which to allocate the host, and the number of hosts to allocate.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AllocateHostsRequest :
sig
  type t =
    {
    auto_placement: AutoPlacement.t option ;
    availability_zone: String.t ;
    client_token: String.t option ;
    instance_type: String.t option ;
    instance_family: String.t option ;
    quantity: Integer.t ;
    tag_specifications: TagSpecificationList.t ;
    host_recovery: HostRecovery.t option }
  val make :
    ?auto_placement:AutoPlacement.t ->
      availability_zone:String.t ->
        ?client_token:String.t ->
          ?instance_type:String.t ->
            ?instance_family:String.t ->
              quantity:Integer.t ->
                ?tag_specifications:TagSpecificationList.t ->
                  ?host_recovery:HostRecovery.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AllocateHostsResult = AllocateHostsResult
type input = AllocateHostsRequest.t
type output = AllocateHostsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error