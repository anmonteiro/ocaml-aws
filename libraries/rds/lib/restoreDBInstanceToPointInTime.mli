(** "<p>Restores a DB instance to an arbitrary point in time. You can restore to any point in time before the time identified by the LatestRestorableTime property. You can restore to a point up to the number of days specified by the BackupRetentionPeriod property.</p> <p>The target database is created with most of the original configuration, but in a system-selected Availability Zone, with the default security group, the default subnet group, and the default DB parameter group. By default, the new DB instance is created as a single-AZ deployment except when the instance is a SQL Server instance that has an option group that is associated with mirroring; in this case, the instance becomes a mirrored deployment and not a single-AZ deployment.</p> <note> <p>This command doesn't apply to Aurora MySQL and Aurora PostgreSQL. For Aurora, use <code>RestoreDBClusterToPointInTime</code>.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RestoreDBInstanceToPointInTimeMessage :
sig
  type t =
    {
    source_d_b_instance_identifier: String.t option ;
    target_d_b_instance_identifier: String.t ;
    restore_time: DateTime.t option ;
    use_latest_restorable_time: Boolean.t option ;
    d_b_instance_class: String.t option ;
    port: Integer.t option ;
    availability_zone: String.t option ;
    d_b_subnet_group_name: String.t option ;
    multi_a_z: Boolean.t option ;
    publicly_accessible: Boolean.t option ;
    auto_minor_version_upgrade: Boolean.t option ;
    license_model: String.t option ;
    d_b_name: String.t option ;
    engine: String.t option ;
    iops: Integer.t option ;
    option_group_name: String.t option ;
    copy_tags_to_snapshot: Boolean.t option ;
    tags: TagList.t ;
    storage_type: String.t option ;
    tde_credential_arn: String.t option ;
    tde_credential_password: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    domain: String.t option ;
    domain_i_a_m_role_name: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    processor_features: ProcessorFeatureList.t ;
    use_default_processor_features: Boolean.t option ;
    d_b_parameter_group_name: String.t option ;
    deletion_protection: Boolean.t option ;
    source_dbi_resource_id: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?source_d_b_instance_identifier:String.t ->
      target_d_b_instance_identifier:String.t ->
        ?restore_time:DateTime.t ->
          ?use_latest_restorable_time:Boolean.t ->
            ?d_b_instance_class:String.t ->
              ?port:Integer.t ->
                ?availability_zone:String.t ->
                  ?d_b_subnet_group_name:String.t ->
                    ?multi_a_z:Boolean.t ->
                      ?publicly_accessible:Boolean.t ->
                        ?auto_minor_version_upgrade:Boolean.t ->
                          ?license_model:String.t ->
                            ?d_b_name:String.t ->
                              ?engine:String.t ->
                                ?iops:Integer.t ->
                                  ?option_group_name:String.t ->
                                    ?copy_tags_to_snapshot:Boolean.t ->
                                      ?tags:TagList.t ->
                                        ?storage_type:String.t ->
                                          ?tde_credential_arn:String.t ->
                                            ?tde_credential_password:String.t
                                              ->
                                              ?vpc_security_group_ids:VpcSecurityGroupIdList.t
                                                ->
                                                ?domain:String.t ->
                                                  ?domain_i_a_m_role_name:String.t
                                                    ->
                                                    ?enable_i_a_m_database_authentication:Boolean.t
                                                      ->
                                                      ?enable_cloudwatch_logs_exports:LogTypeList.t
                                                        ->
                                                        ?processor_features:ProcessorFeatureList.t
                                                          ->
                                                          ?use_default_processor_features:Boolean.t
                                                            ->
                                                            ?d_b_parameter_group_name:String.t
                                                              ->
                                                              ?deletion_protection:Boolean.t
                                                                ->
                                                                ?source_dbi_resource_id:String.t
                                                                  ->
                                                                  unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RestoreDBInstanceToPointInTimeResult =
RestoreDBInstanceToPointInTimeResult
type input = RestoreDBInstanceToPointInTimeMessage.t
type output = RestoreDBInstanceToPointInTimeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error