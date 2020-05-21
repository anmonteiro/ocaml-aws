(** "<p>Lists all cost allocation tags currently on the named resource. A <code>cost allocation tag</code> is a key-value pair where the key is case-sensitive and the value is optional. You can use cost allocation tags to categorize and track your AWS costs.</p> <p>If the cluster is not in the <i>available</i> state, <code>ListTagsForResource</code> returns an error.</p> <p>You can have a maximum of 50 cost allocation tags on an ElastiCache resource. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Tagging.html\">Monitoring Costs with Tags</a>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListTagsForResourceMessage :
sig
  type t = {
    resource_name: String.t }[@@ocaml.doc
                               "<p>The input parameters for the <code>ListTagsForResource</code> operation.</p>"]
  val make : resource_name:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module TagListMessage = TagListMessage
type input = ListTagsForResourceMessage.t
type output = TagListMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error