(** "<p>Describes the specified bundle tasks or all of your bundle tasks.</p> <note> <p>Completed bundle tasks are listed for only a limited time. If your bundle task is no longer in the list, you can still register an AMI from it. Just use <code>RegisterImage</code> with the Amazon S3 bucket name and image manifest name you provided to the bundle task.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeBundleTasksRequest :
sig
  type t =
    {
    bundle_ids: BundleIdStringList.t ;
    filters: FilterList.t ;
    dry_run: Boolean.t option }
  val make :
    ?bundle_ids:BundleIdStringList.t ->
      ?filters:FilterList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeBundleTasksResult = DescribeBundleTasksResult
type input = DescribeBundleTasksRequest.t
type output = DescribeBundleTasksResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error