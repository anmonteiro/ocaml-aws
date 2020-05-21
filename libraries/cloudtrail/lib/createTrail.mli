(** "<p>Creates a trail that specifies the settings for delivery of log data to an Amazon S3 bucket. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateTrailRequest :
sig
  type t =
    {
    name: String.t ;
    s3_bucket_name: String.t ;
    s3_key_prefix: String.t option ;
    sns_topic_name: String.t option ;
    include_global_service_events: Boolean.t option ;
    is_multi_region_trail: Boolean.t option ;
    enable_log_file_validation: Boolean.t option ;
    cloud_watch_logs_log_group_arn: String.t option ;
    cloud_watch_logs_role_arn: String.t option ;
    kms_key_id: String.t option ;
    is_organization_trail: Boolean.t option ;
    tags_list: TagsList.t }[@@ocaml.doc
                             "<p>Specifies the settings for each trail.</p>"]
  val make :
    name:String.t ->
      s3_bucket_name:String.t ->
        ?s3_key_prefix:String.t ->
          ?sns_topic_name:String.t ->
            ?include_global_service_events:Boolean.t ->
              ?is_multi_region_trail:Boolean.t ->
                ?enable_log_file_validation:Boolean.t ->
                  ?cloud_watch_logs_log_group_arn:String.t ->
                    ?cloud_watch_logs_role_arn:String.t ->
                      ?kms_key_id:String.t ->
                        ?is_organization_trail:Boolean.t ->
                          ?tags_list:TagsList.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module CreateTrailResponse = CreateTrailResponse
type input = CreateTrailRequest.t
type output = CreateTrailResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error