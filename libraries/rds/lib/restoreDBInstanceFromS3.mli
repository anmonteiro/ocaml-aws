(** "<p>Amazon Relational Database Service (Amazon RDS) supports importing MySQL databases by using backup files. You can create a backup of your on-premises database, store it on Amazon Simple Storage Service (Amazon S3), and then restore the backup file onto a new Amazon RDS DB instance running MySQL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/MySQL.Procedural.Importing.html\">Importing Data into an Amazon RDS MySQL DB Instance</a> in the <i>Amazon RDS User Guide.</i> </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RestoreDBInstanceFromS3Message :
sig
  type t =
    {
    d_b_name: String.t option ;
    d_b_instance_identifier: String.t ;
    allocated_storage: Integer.t option ;
    d_b_instance_class: String.t ;
    engine: String.t ;
    master_username: String.t option ;
    master_user_password: String.t option ;
    d_b_security_groups: DBSecurityGroupNameList.t ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    availability_zone: String.t option ;
    d_b_subnet_group_name: String.t option ;
    preferred_maintenance_window: String.t option ;
    d_b_parameter_group_name: String.t option ;
    backup_retention_period: Integer.t option ;
    preferred_backup_window: String.t option ;
    port: Integer.t option ;
    multi_a_z: Boolean.t option ;
    engine_version: String.t option ;
    auto_minor_version_upgrade: Boolean.t option ;
    license_model: String.t option ;
    iops: Integer.t option ;
    option_group_name: String.t option ;
    publicly_accessible: Boolean.t option ;
    tags: TagList.t ;
    storage_type: String.t option ;
    storage_encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    copy_tags_to_snapshot: Boolean.t option ;
    monitoring_interval: Integer.t option ;
    monitoring_role_arn: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    source_engine: String.t ;
    source_engine_version: String.t ;
    s3_bucket_name: String.t ;
    s3_prefix: String.t option ;
    s3_ingestion_role_arn: String.t ;
    enable_performance_insights: Boolean.t option ;
    performance_insights_k_m_s_key_id: String.t option ;
    performance_insights_retention_period: Integer.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    processor_features: ProcessorFeatureList.t ;
    use_default_processor_features: Boolean.t option ;
    deletion_protection: Boolean.t option }
  val make :
    ?d_b_name:String.t ->
      d_b_instance_identifier:String.t ->
        ?allocated_storage:Integer.t ->
          d_b_instance_class:String.t ->
            engine:String.t ->
              ?master_username:String.t ->
                ?master_user_password:String.t ->
                  ?d_b_security_groups:DBSecurityGroupNameList.t ->
                    ?vpc_security_group_ids:VpcSecurityGroupIdList.t ->
                      ?availability_zone:String.t ->
                        ?d_b_subnet_group_name:String.t ->
                          ?preferred_maintenance_window:String.t ->
                            ?d_b_parameter_group_name:String.t ->
                              ?backup_retention_period:Integer.t ->
                                ?preferred_backup_window:String.t ->
                                  ?port:Integer.t ->
                                    ?multi_a_z:Boolean.t ->
                                      ?engine_version:String.t ->
                                        ?auto_minor_version_upgrade:Boolean.t
                                          ->
                                          ?license_model:String.t ->
                                            ?iops:Integer.t ->
                                              ?option_group_name:String.t ->
                                                ?publicly_accessible:Boolean.t
                                                  ->
                                                  ?tags:TagList.t ->
                                                    ?storage_type:String.t ->
                                                      ?storage_encrypted:Boolean.t
                                                        ->
                                                        ?kms_key_id:String.t
                                                          ->
                                                          ?copy_tags_to_snapshot:Boolean.t
                                                            ->
                                                            ?monitoring_interval:Integer.t
                                                              ->
                                                              ?monitoring_role_arn:String.t
                                                                ->
                                                                ?enable_i_a_m_database_authentication:Boolean.t
                                                                  ->
                                                                  source_engine:String.t
                                                                    ->
                                                                    source_engine_version:String.t
                                                                    ->
                                                                    s3_bucket_name:String.t
                                                                    ->
                                                                    ?s3_prefix:String.t
                                                                    ->
                                                                    s3_ingestion_role_arn:String.t
                                                                    ->
                                                                    ?enable_performance_insights:Boolean.t
                                                                    ->
                                                                    ?performance_insights_k_m_s_key_id:String.t
                                                                    ->
                                                                    ?performance_insights_retention_period:Integer.t
                                                                    ->
                                                                    ?enable_cloudwatch_logs_exports:LogTypeList.t
                                                                    ->
                                                                    ?processor_features:ProcessorFeatureList.t
                                                                    ->
                                                                    ?use_default_processor_features:Boolean.t
                                                                    ->
                                                                    ?deletion_protection:Boolean.t
                                                                    ->
                                                                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RestoreDBInstanceFromS3Result = RestoreDBInstanceFromS3Result
type input = RestoreDBInstanceFromS3Message.t
type output = RestoreDBInstanceFromS3Result.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error