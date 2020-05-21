(** "<p>Modify the auto-placement setting of a Dedicated Host. When auto-placement is enabled, any instances that you launch with a tenancy of <code>host</code> but without a specific host ID are placed onto any available Dedicated Host in your account that has auto-placement enabled. When auto-placement is disabled, you need to provide a host ID to have the instance launch onto a specific host. If no host ID is provided, the instance is launched onto a suitable host with auto-placement enabled.</p> <p>You can also use this API action to modify a Dedicated Host to support either multiple instance types in an instance family, or to support a specific instance type only.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyHostsRequest :
sig
  type t =
    {
    auto_placement: AutoPlacement.t option ;
    host_ids: RequestHostIdList.t ;
    host_recovery: HostRecovery.t option ;
    instance_type: String.t option ;
    instance_family: String.t option }
  val make :
    ?auto_placement:AutoPlacement.t ->
      host_ids:RequestHostIdList.t ->
        ?host_recovery:HostRecovery.t ->
          ?instance_type:String.t -> ?instance_family:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyHostsResult = ModifyHostsResult
type input = ModifyHostsRequest.t
type output = ModifyHostsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error