(** "<p>Creates a default subnet with a size <code>/20</code> IPv4 CIDR block in the specified Availability Zone in your default VPC. You can have only one default subnet per Availability Zone. For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html#create-default-subnet\">Creating a Default Subnet</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDefaultSubnetRequest :
sig
  type t = {
    availability_zone: String.t ;
    dry_run: Boolean.t option }
  val make : availability_zone:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDefaultSubnetResult = CreateDefaultSubnetResult
type input = CreateDefaultSubnetRequest.t
type output = CreateDefaultSubnetResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error