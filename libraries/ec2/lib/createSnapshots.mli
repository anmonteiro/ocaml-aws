(** "<p>Creates crash-consistent snapshots of multiple EBS volumes and stores the data in S3. Volumes are chosen by specifying an instance. Any attached volumes will produce one snapshot each that is crash-consistent across the instance. Boot volumes can be excluded by changing the parameters. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateSnapshotsRequest :
sig
  type t =
    {
    description: String.t option ;
    instance_specification: InstanceSpecification.t ;
    tag_specifications: TagSpecificationList.t ;
    dry_run: Boolean.t option ;
    copy_tags_from_source: CopyTagsFromSource.t option }
  val make :
    ?description:String.t ->
      instance_specification:InstanceSpecification.t ->
        ?tag_specifications:TagSpecificationList.t ->
          ?dry_run:Boolean.t ->
            ?copy_tags_from_source:CopyTagsFromSource.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateSnapshotsResult = CreateSnapshotsResult
type input = CreateSnapshotsRequest.t
type output = CreateSnapshotsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error