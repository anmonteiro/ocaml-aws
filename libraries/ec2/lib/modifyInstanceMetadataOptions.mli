(** "<p>Modify the instance metadata parameters on a running or stopped instance. When you modify the parameters on a stopped instance, they are applied when the instance is started. When you modify the parameters on a running instance, the API responds with a state of \226\128\156pending\226\128\157. After the parameter modifications are successfully applied to the instance, the state of the modifications changes from \226\128\156pending\226\128\157 to \226\128\156applied\226\128\157 in subsequent describe-instances API calls. For more information, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html\">Instance Metadata and User Data</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyInstanceMetadataOptionsRequest :
sig
  type t =
    {
    instance_id: String.t ;
    http_tokens: HttpTokensState.t option ;
    http_put_response_hop_limit: Integer.t option ;
    http_endpoint: InstanceMetadataEndpointState.t option ;
    dry_run: Boolean.t option }
  val make :
    instance_id:String.t ->
      ?http_tokens:HttpTokensState.t ->
        ?http_put_response_hop_limit:Integer.t ->
          ?http_endpoint:InstanceMetadataEndpointState.t ->
            ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyInstanceMetadataOptionsResult =
ModifyInstanceMetadataOptionsResult
type input = ModifyInstanceMetadataOptionsRequest.t
type output = ModifyInstanceMetadataOptionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error