(** "<p>Describes the specified attribute of the specified AMI. You can specify only one attribute at a time.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeImageAttributeRequest :
sig
  type t =
    {
    attribute: ImageAttributeName.t ;
    image_id: String.t ;
    dry_run: Boolean.t option }[@@ocaml.doc
                                 "<p>Contains the parameters for DescribeImageAttribute.</p>"]
  val make :
    attribute:ImageAttributeName.t ->
      image_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ImageAttribute = ImageAttribute
type input = DescribeImageAttributeRequest.t
type output = ImageAttribute.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error