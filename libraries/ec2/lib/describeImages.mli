(** "<p>Describes the specified images (AMIs, AKIs, and ARIs) available to you or all of the images available to you.</p> <p>The images available to you include public images, private images that you own, and private images owned by other AWS accounts for which you have explicit launch permissions.</p> <p>Recently deregistered images appear in the returned results for a short interval and then return empty results. After all instances that reference a deregistered AMI are terminated, specifying the ID of the image results in an error indicating that the AMI ID cannot be found.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeImagesRequest :
sig
  type t =
    {
    executable_users: ExecutableByStringList.t ;
    filters: FilterList.t ;
    image_ids: ImageIdStringList.t ;
    owners: OwnerStringList.t ;
    dry_run: Boolean.t option }
  val make :
    ?executable_users:ExecutableByStringList.t ->
      ?filters:FilterList.t ->
        ?image_ids:ImageIdStringList.t ->
          ?owners:OwnerStringList.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeImagesResult = DescribeImagesResult
type input = DescribeImagesRequest.t
type output = DescribeImagesResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error