(** "<p>Lists tags for one health check or hosted zone. </p> <p>For information about using tags for cost allocation, see <a href=\"https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html\">Using Cost Allocation Tags</a> in the <i>AWS Billing and Cost Management User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTagsForResourceRequest :
sig
  type t = {
    resource_type: TagResourceType.t ;
    resource_id: String.t }[@@ocaml.doc
                             "<p>A complex type containing information about a request for a list of the tags that are associated with an individual resource.</p>"]
  val make :
    resource_type:TagResourceType.t -> resource_id:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ListTagsForResourceResponse = ListTagsForResourceResponse
type input = ListTagsForResourceRequest.t
type output = ListTagsForResourceResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error