(** "<p>Modifies settings for a DB instance. You can change one or more database configuration parameters by specifying these parameters and the new values in the request. To learn what modifications you can make to your DB instance, call <code>DescribeValidDBInstanceModifications</code> before you call <code>ModifyDBInstance</code>. </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBInstanceMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    allocated_storage: Integer.t option ;
    d_b_instance_class: String.t option ;
    d_b_subnet_group_name: String.t option ;
    d_b_security_groups: DBSecurityGroupNameList.t ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    apply_immediately: Boolean.t option ;
    master_user_password: String.t option ;
    d_b_parameter_group_name: String.t option ;
    backup_retention_period: Integer.t option ;
    preferred_backup_window: String.t option ;
    preferred_maintenance_window: String.t option ;
    multi_a_z: Boolean.t option ;
    engine_version: String.t option ;
    allow_major_version_upgrade: Boolean.t option ;
    auto_minor_version_upgrade: Boolean.t option ;
    license_model: String.t option ;
    iops: Integer.t option ;
    option_group_name: String.t option ;
    new_d_b_instance_identifier: String.t option ;
    storage_type: String.t option ;
    tde_credential_arn: String.t option ;
    tde_credential_password: String.t option ;
    c_a_certificate_identifier: String.t option ;
    domain: String.t option ;
    copy_tags_to_snapshot: Boolean.t option ;
    monitoring_interval: Integer.t option ;
    d_b_port_number: Integer.t option ;
    publicly_accessible: Boolean.t option ;
    monitoring_role_arn: String.t option ;
    domain_i_a_m_role_name: String.t option ;
    promotion_tier: Integer.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    enable_performance_insights: Boolean.t option ;
    performance_insights_k_m_s_key_id: String.t option ;
    performance_insights_retention_period: Integer.t option ;
    cloudwatch_logs_export_configuration:
      CloudwatchLogsExportConfiguration.t option ;
    processor_features: ProcessorFeatureList.t ;
    use_default_processor_features: Boolean.t option ;
    deletion_protection: Boolean.t option ;
    max_allocated_storage: Integer.t option ;
    certificate_rotation_restart: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_instance_identifier:String.t ->
      ?allocated_storage:Integer.t ->
        ?d_b_instance_class:String.t ->
          ?d_b_subnet_group_name:String.t ->
            ?d_b_security_groups:DBSecurityGroupNameList.t ->
              ?vpc_security_group_ids:VpcSecurityGroupIdList.t ->
                ?apply_immediately:Boolean.t ->
                  ?master_user_password:String.t ->
                    ?d_b_parameter_group_name:String.t ->
                      ?backup_retention_period:Integer.t ->
                        ?preferred_backup_window:String.t ->
                          ?preferred_maintenance_window:String.t ->
                            ?multi_a_z:Boolean.t ->
                              ?engine_version:String.t ->
                                ?allow_major_version_upgrade:Boolean.t ->
                                  ?auto_minor_version_upgrade:Boolean.t ->
                                    ?license_model:String.t ->
                                      ?iops:Integer.t ->
                                        ?option_group_name:String.t ->
                                          ?new_d_b_instance_identifier:String.t
                                            ->
                                            ?storage_type:String.t ->
                                              ?tde_credential_arn:String.t ->
                                                ?tde_credential_password:String.t
                                                  ->
                                                  ?c_a_certificate_identifier:String.t
                                                    ->
                                                    ?domain:String.t ->
                                                      ?copy_tags_to_snapshot:Boolean.t
                                                        ->
                                                        ?monitoring_interval:Integer.t
                                                          ->
                                                          ?d_b_port_number:Integer.t
                                                            ->
                                                            ?publicly_accessible:Boolean.t
                                                              ->
                                                              ?monitoring_role_arn:String.t
                                                                ->
                                                                ?domain_i_a_m_role_name:String.t
                                                                  ->
                                                                  ?promotion_tier:Integer.t
                                                                    ->
                                                                    ?enable_i_a_m_database_authentication:Boolean.t
                                                                    ->
                                                                    ?enable_performance_insights:Boolean.t
                                                                    ->
                                                                    ?performance_insights_k_m_s_key_id:String.t
                                                                    ->
                                                                    ?performance_insights_retention_period:Integer.t
                                                                    ->
                                                                    ?cloudwatch_logs_export_configuration:CloudwatchLogsExportConfiguration.t
                                                                    ->
                                                                    ?processor_features:ProcessorFeatureList.t
                                                                    ->
                                                                    ?use_default_processor_features:Boolean.t
                                                                    ->
                                                                    ?deletion_protection:Boolean.t
                                                                    ->
                                                                    ?max_allocated_storage:Integer.t
                                                                    ->
                                                                    ?certificate_rotation_restart:Boolean.t
                                                                    ->
                                                                    unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBInstanceResult = ModifyDBInstanceResult
type input = ModifyDBInstanceMessage.t
type output = ModifyDBInstanceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error