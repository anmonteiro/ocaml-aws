(** "<p>Creates a new DB instance that acts as a Read Replica for an existing source DB instance. You can create a Read Replica for a DB instance running MySQL, MariaDB, Oracle, or PostgreSQL. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ReadRepl.html\">Working with Read Replicas</a> in the <i>Amazon RDS User Guide</i>. </p> <p>Amazon Aurora doesn't support this action. You must call the <code>CreateDBInstance</code> action to create a DB instance for an Aurora DB cluster. </p> <p>All Read Replica DB instances are created with backups disabled. All other DB instance attributes (including DB security groups and DB parameter groups) are inherited from the source DB instance, except as specified following. </p> <important> <p>Your source DB instance must have backup retention enabled. </p> </important>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBInstanceReadReplicaMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    source_d_b_instance_identifier: String.t ;
    d_b_instance_class: String.t option ;
    availability_zone: String.t option ;
    port: Integer.t option ;
    multi_a_z: Boolean.t option ;
    auto_minor_version_upgrade: Boolean.t option ;
    iops: Integer.t option ;
    option_group_name: String.t option ;
    d_b_parameter_group_name: String.t option ;
    publicly_accessible: Boolean.t option ;
    tags: TagList.t ;
    d_b_subnet_group_name: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    storage_type: String.t option ;
    copy_tags_to_snapshot: Boolean.t option ;
    monitoring_interval: Integer.t option ;
    monitoring_role_arn: String.t option ;
    kms_key_id: String.t option ;
    pre_signed_url: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    enable_performance_insights: Boolean.t option ;
    performance_insights_k_m_s_key_id: String.t option ;
    performance_insights_retention_period: Integer.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    processor_features: ProcessorFeatureList.t ;
    use_default_processor_features: Boolean.t option ;
    deletion_protection: Boolean.t option ;
    domain: String.t option ;
    domain_i_a_m_role_name: String.t option }
  val make :
    d_b_instance_identifier:String.t ->
      source_d_b_instance_identifier:String.t ->
        ?d_b_instance_class:String.t ->
          ?availability_zone:String.t ->
            ?port:Integer.t ->
              ?multi_a_z:Boolean.t ->
                ?auto_minor_version_upgrade:Boolean.t ->
                  ?iops:Integer.t ->
                    ?option_group_name:String.t ->
                      ?d_b_parameter_group_name:String.t ->
                        ?publicly_accessible:Boolean.t ->
                          ?tags:TagList.t ->
                            ?d_b_subnet_group_name:String.t ->
                              ?vpc_security_group_ids:VpcSecurityGroupIdList.t
                                ->
                                ?storage_type:String.t ->
                                  ?copy_tags_to_snapshot:Boolean.t ->
                                    ?monitoring_interval:Integer.t ->
                                      ?monitoring_role_arn:String.t ->
                                        ?kms_key_id:String.t ->
                                          ?pre_signed_url:String.t ->
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
                                                        ?use_default_processor_features:Boolean.t
                                                          ->
                                                          ?deletion_protection:Boolean.t
                                                            ->
                                                            ?domain:String.t
                                                              ->
                                                              ?domain_i_a_m_role_name:String.t
                                                                -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBInstanceReadReplicaResult = CreateDBInstanceReadReplicaResult
type input = CreateDBInstanceReadReplicaMessage.t
type output = CreateDBInstanceReadReplicaResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error