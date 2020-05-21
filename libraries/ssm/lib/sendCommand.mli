(** "<p>Runs commands on one or more managed instances.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SendCommandRequest :
sig
  type t =
    {
    instance_ids: InstanceIdList.t ;
    targets: Targets.t ;
    document_name: String.t ;
    document_version: String.t option ;
    document_hash: String.t option ;
    document_hash_type: DocumentHashType.t option ;
    timeout_seconds: Integer.t option ;
    comment: String.t option ;
    parameters: Parameters.t option ;
    output_s3_region: String.t option ;
    output_s3_bucket_name: String.t option ;
    output_s3_key_prefix: String.t option ;
    max_concurrency: String.t option ;
    max_errors: String.t option ;
    service_role_arn: String.t option ;
    notification_config: NotificationConfig.t option ;
    cloud_watch_output_config: CloudWatchOutputConfig.t option }
  val make :
    ?instance_ids:InstanceIdList.t ->
      ?targets:Targets.t ->
        document_name:String.t ->
          ?document_version:String.t ->
            ?document_hash:String.t ->
              ?document_hash_type:DocumentHashType.t ->
                ?timeout_seconds:Integer.t ->
                  ?comment:String.t ->
                    ?parameters:Parameters.t ->
                      ?output_s3_region:String.t ->
                        ?output_s3_bucket_name:String.t ->
                          ?output_s3_key_prefix:String.t ->
                            ?max_concurrency:String.t ->
                              ?max_errors:String.t ->
                                ?service_role_arn:String.t ->
                                  ?notification_config:NotificationConfig.t
                                    ->
                                    ?cloud_watch_output_config:CloudWatchOutputConfig.t
                                      -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module SendCommandResult = SendCommandResult
type input = SendCommandRequest.t
type output = SendCommandResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error