(** "<p>Creates a new DB cluster from a DB snapshot or DB cluster snapshot.</p> <p>If a DB snapshot is specified, the target DB cluster is created from the source DB snapshot with a default configuration and default security group.</p> <p>If a DB cluster snapshot is specified, the target DB cluster is created from the source DB cluster restore point with the same configuration as the original source DB cluster. If you don't specify a security group, the new DB cluster is associated with the default security group.</p> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RestoreDBClusterFromSnapshotMessage :
sig
  type t =
    {
    availability_zones: AvailabilityZones.t ;
    d_b_cluster_identifier: String.t ;
    snapshot_identifier: String.t ;
    engine: String.t ;
    engine_version: String.t option ;
    port: Integer.t option ;
    d_b_subnet_group_name: String.t option ;
    database_name: String.t option ;
    option_group_name: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    tags: TagList.t ;
    kms_key_id: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    backtrack_window: Long.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    engine_mode: String.t option ;
    scaling_configuration: ScalingConfiguration.t option ;
    d_b_cluster_parameter_group_name: String.t option ;
    deletion_protection: Boolean.t option ;
    copy_tags_to_snapshot: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    ?availability_zones:AvailabilityZones.t ->
      d_b_cluster_identifier:String.t ->
        snapshot_identifier:String.t ->
          engine:String.t ->
            ?engine_version:String.t ->
              ?port:Integer.t ->
                ?d_b_subnet_group_name:String.t ->
                  ?database_name:String.t ->
                    ?option_group_name:String.t ->
                      ?vpc_security_group_ids:VpcSecurityGroupIdList.t ->
                        ?tags:TagList.t ->
                          ?kms_key_id:String.t ->
                            ?enable_i_a_m_database_authentication:Boolean.t
                              ->
                              ?backtrack_window:Long.t ->
                                ?enable_cloudwatch_logs_exports:LogTypeList.t
                                  ->
                                  ?engine_mode:String.t ->
                                    ?scaling_configuration:ScalingConfiguration.t
                                      ->
                                      ?d_b_cluster_parameter_group_name:String.t
                                        ->
                                        ?deletion_protection:Boolean.t ->
                                          ?copy_tags_to_snapshot:Boolean.t ->
                                            unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RestoreDBClusterFromSnapshotResult =
RestoreDBClusterFromSnapshotResult
type input = RestoreDBClusterFromSnapshotMessage.t
type output = RestoreDBClusterFromSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error