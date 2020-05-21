(** "<p>Updates the settings that specify delivery of log files. Changes to a trail do not require stopping the CloudTrail service. Use this action to designate an existing bucket for log delivery. If the existing bucket has previously been a target for CloudTrail log files, an IAM policy exists for the bucket. <code>UpdateTrail</code> must be called from the region in which the trail was created; otherwise, an <code>InvalidHomeRegionException</code> is thrown.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module UpdateTrailRequest :
sig
  type t =
    {
    name: String.t ;
    s3_bucket_name: String.t option ;
    s3_key_prefix: String.t option ;
    sns_topic_name: String.t option ;
    include_global_service_events: Boolean.t option ;
    is_multi_region_trail: Boolean.t option ;
    enable_log_file_validation: Boolean.t option ;
    cloud_watch_logs_log_group_arn: String.t option ;
    cloud_watch_logs_role_arn: String.t option ;
    kms_key_id: String.t option ;
    is_organization_trail: Boolean.t option }[@@ocaml.doc
                                               "<p>Specifies settings to update for the trail.</p>"]
  val make :
    name:String.t ->
      ?s3_bucket_name:String.t ->
        ?s3_key_prefix:String.t ->
          ?sns_topic_name:String.t ->
            ?include_global_service_events:Boolean.t ->
              ?is_multi_region_trail:Boolean.t ->
                ?enable_log_file_validation:Boolean.t ->
                  ?cloud_watch_logs_log_group_arn:String.t ->
                    ?cloud_watch_logs_role_arn:String.t ->
                      ?kms_key_id:String.t ->
                        ?is_organization_trail:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module UpdateTrailResponse = UpdateTrailResponse
type input = UpdateTrailRequest.t
type output = UpdateTrailResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error