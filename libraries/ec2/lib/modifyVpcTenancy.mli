(** "<p>Modifies the instance tenancy attribute of the specified VPC. You can change the instance tenancy attribute of a VPC to <code>default</code> only. You cannot change the instance tenancy attribute to <code>dedicated</code>.</p> <p>After you modify the tenancy of the VPC, any new instances that you launch into the VPC have a tenancy of <code>default</code>, unless you specify otherwise during launch. The tenancy of any existing instances in the VPC is not affected.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-instance.html\">Dedicated Instances</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyVpcTenancyRequest :
sig
  type t =
    {
    vpc_id: String.t ;
    instance_tenancy: VpcTenancy.t ;
    dry_run: Boolean.t option }
  val make :
    vpc_id:String.t ->
      instance_tenancy:VpcTenancy.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyVpcTenancyResult = ModifyVpcTenancyResult
type input = ModifyVpcTenancyRequest.t
type output = ModifyVpcTenancyResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error