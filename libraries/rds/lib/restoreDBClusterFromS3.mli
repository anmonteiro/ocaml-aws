(** "<p>Creates an Amazon Aurora DB cluster from data stored in an Amazon S3 bucket. Amazon RDS must be authorized to access the Amazon S3 bucket and the data must be created using the Percona XtraBackup utility as described in <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Migrating.html\"> Migrating Data to an Amazon Aurora MySQL DB Cluster</a> in the <i>Amazon Aurora User Guide</i>.</p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RestoreDBClusterFromS3Message :
sig
  type t =
    {
    availability_zones: AvailabilityZones.t ;
    backup_retention_period: Integer.t option ;
    character_set_name: String.t option ;
    database_name: String.t option ;
    d_b_cluster_identifier: String.t ;
    d_b_cluster_parameter_group_name: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    d_b_subnet_group_name: String.t option ;
    engine: String.t ;
    engine_version: String.t option ;
    port: Integer.t option ;
    master_username: String.t ;
    master_user_password: String.t ;
    option_group_name: String.t option ;
    preferred_backup_window: String.t option ;
    preferred_maintenance_window: String.t option ;
    tags: TagList.t ;
    storage_encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    source_engine: String.t ;
    source_engine_version: String.t ;
    s3_bucket_name: String.t ;
    s3_prefix: String.t option ;
    s3_ingestion_role_arn: String.t ;
    backtrack_window: Long.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    deletion_protection: Boolean.t option ;
    copy_tags_to_snapshot: Boolean.t option }
  val make :
    ?availability_zones:AvailabilityZones.t ->
      ?backup_retention_period:Integer.t ->
        ?character_set_name:String.t ->
          ?database_name:String.t ->
            d_b_cluster_identifier:String.t ->
              ?d_b_cluster_parameter_group_name:String.t ->
                ?vpc_security_group_ids:VpcSecurityGroupIdList.t ->
                  ?d_b_subnet_group_name:String.t ->
                    engine:String.t ->
                      ?engine_version:String.t ->
                        ?port:Integer.t ->
                          master_username:String.t ->
                            master_user_password:String.t ->
                              ?option_group_name:String.t ->
                                ?preferred_backup_window:String.t ->
                                  ?preferred_maintenance_window:String.t ->
                                    ?tags:TagList.t ->
                                      ?storage_encrypted:Boolean.t ->
                                        ?kms_key_id:String.t ->
                                          ?enable_i_a_m_database_authentication:Boolean.t
                                            ->
                                            source_engine:String.t ->
                                              source_engine_version:String.t
                                                ->
                                                s3_bucket_name:String.t ->
                                                  ?s3_prefix:String.t ->
                                                    s3_ingestion_role_arn:String.t
                                                      ->
                                                      ?backtrack_window:Long.t
                                                        ->
                                                        ?enable_cloudwatch_logs_exports:LogTypeList.t
                                                          ->
                                                          ?deletion_protection:Boolean.t
                                                            ->
                                                            ?copy_tags_to_snapshot:Boolean.t
                                                              -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RestoreDBClusterFromS3Result = RestoreDBClusterFromS3Result
type input = RestoreDBClusterFromS3Message.t
type output = RestoreDBClusterFromS3Result.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error