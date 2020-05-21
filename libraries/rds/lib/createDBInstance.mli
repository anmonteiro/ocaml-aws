(** "<p>Creates a new DB instance.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBInstanceMessage :
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
    character_set_name: String.t option ;
    publicly_accessible: Boolean.t option ;
    tags: TagList.t ;
    d_b_cluster_identifier: String.t option ;
    storage_type: String.t option ;
    tde_credential_arn: String.t option ;
    tde_credential_password: String.t option ;
    storage_encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    domain: String.t option ;
    copy_tags_to_snapshot: Boolean.t option ;
    monitoring_interval: Integer.t option ;
    monitoring_role_arn: String.t option ;
    domain_i_a_m_role_name: String.t option ;
    promotion_tier: Integer.t option ;
    timezone: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    enable_performance_insights: Boolean.t option ;
    performance_insights_k_m_s_key_id: String.t option ;
    performance_insights_retention_period: Integer.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    processor_features: ProcessorFeatureList.t ;
    deletion_protection: Boolean.t option ;
    max_allocated_storage: Integer.t option }[@@ocaml.doc "<p/>"]
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
                                                ?character_set_name:String.t
                                                  ->
                                                  ?publicly_accessible:Boolean.t
                                                    ->
                                                    ?tags:TagList.t ->
                                                      ?d_b_cluster_identifier:String.t
                                                        ->
                                                        ?storage_type:String.t
                                                          ->
                                                          ?tde_credential_arn:String.t
                                                            ->
                                                            ?tde_credential_password:String.t
                                                              ->
                                                              ?storage_encrypted:Boolean.t
                                                                ->
                                                                ?kms_key_id:String.t
                                                                  ->
                                                                  ?domain:String.t
                                                                    ->
                                                                    ?copy_tags_to_snapshot:Boolean.t
                                                                    ->
                                                                    ?monitoring_interval:Integer.t
                                                                    ->
                                                                    ?monitoring_role_arn:String.t
                                                                    ->
                                                                    ?domain_i_a_m_role_name:String.t
                                                                    ->
                                                                    ?promotion_tier:Integer.t
                                                                    ->
                                                                    ?timezone:String.t
                                                                    ->
                                                                    ?enable_i_a_m_database_authentication:Boolean.t
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
                                                                    ?deletion_protection:Boolean.t
                                                                    ->
                                                                    ?max_allocated_storage:Integer.t
                                                                    ->
                                                                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBInstanceResult = CreateDBInstanceResult
type input = CreateDBInstanceMessage.t
type output = CreateDBInstanceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error