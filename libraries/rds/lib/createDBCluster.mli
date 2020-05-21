(** "<p>Creates a new Amazon Aurora DB cluster.</p> <p>You can use the <code>ReplicationSourceIdentifier</code> parameter to create the DB cluster as a Read Replica of another DB cluster or Amazon RDS MySQL DB instance. For cross-region replication where the DB cluster identified by <code>ReplicationSourceIdentifier</code> is encrypted, you must also specify the <code>PreSignedUrl</code> parameter.</p> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateDBClusterMessage :
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
    master_username: String.t option ;
    master_user_password: String.t option ;
    option_group_name: String.t option ;
    preferred_backup_window: String.t option ;
    preferred_maintenance_window: String.t option ;
    replication_source_identifier: String.t option ;
    tags: TagList.t ;
    storage_encrypted: Boolean.t option ;
    kms_key_id: String.t option ;
    pre_signed_url: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    backtrack_window: Long.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    engine_mode: String.t option ;
    scaling_configuration: ScalingConfiguration.t option ;
    deletion_protection: Boolean.t option ;
    global_cluster_identifier: String.t option ;
    enable_http_endpoint: Boolean.t option ;
    copy_tags_to_snapshot: Boolean.t option }[@@ocaml.doc "<p/>"]
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
                          ?master_username:String.t ->
                            ?master_user_password:String.t ->
                              ?option_group_name:String.t ->
                                ?preferred_backup_window:String.t ->
                                  ?preferred_maintenance_window:String.t ->
                                    ?replication_source_identifier:String.t
                                      ->
                                      ?tags:TagList.t ->
                                        ?storage_encrypted:Boolean.t ->
                                          ?kms_key_id:String.t ->
                                            ?pre_signed_url:String.t ->
                                              ?enable_i_a_m_database_authentication:Boolean.t
                                                ->
                                                ?backtrack_window:Long.t ->
                                                  ?enable_cloudwatch_logs_exports:LogTypeList.t
                                                    ->
                                                    ?engine_mode:String.t ->
                                                      ?scaling_configuration:ScalingConfiguration.t
                                                        ->
                                                        ?deletion_protection:Boolean.t
                                                          ->
                                                          ?global_cluster_identifier:String.t
                                                            ->
                                                            ?enable_http_endpoint:Boolean.t
                                                              ->
                                                              ?copy_tags_to_snapshot:Boolean.t
                                                                -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module CreateDBClusterResult = CreateDBClusterResult
type input = CreateDBClusterMessage.t
type output = CreateDBClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error