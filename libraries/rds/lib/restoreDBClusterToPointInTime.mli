(** "<p>Restores a DB cluster to an arbitrary point in time. Users can restore to any point in time before <code>LatestRestorableTime</code> for up to <code>BackupRetentionPeriod</code> days. The target DB cluster is created from the source DB cluster with the same configuration as the original DB cluster, except that the new DB cluster is created with the default DB security group. </p> <note> <p>This action only restores the DB cluster, not the DB instances for that DB cluster. You must invoke the <code>CreateDBInstance</code> action to create DB instances for the restored DB cluster, specifying the identifier of the restored DB cluster in <code>DBClusterIdentifier</code>. You can create DB instances only after the <code>RestoreDBClusterToPointInTime</code> action has completed and the DB cluster is available.</p> </note> <p>For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RestoreDBClusterToPointInTimeMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t ;
    restore_type: String.t option ;
    source_d_b_cluster_identifier: String.t ;
    restore_to_time: DateTime.t option ;
    use_latest_restorable_time: Boolean.t option ;
    port: Integer.t option ;
    d_b_subnet_group_name: String.t option ;
    option_group_name: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    tags: TagList.t ;
    kms_key_id: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    backtrack_window: Long.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    d_b_cluster_parameter_group_name: String.t option ;
    deletion_protection: Boolean.t option ;
    copy_tags_to_snapshot: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_identifier:String.t ->
      ?restore_type:String.t ->
        source_d_b_cluster_identifier:String.t ->
          ?restore_to_time:DateTime.t ->
            ?use_latest_restorable_time:Boolean.t ->
              ?port:Integer.t ->
                ?d_b_subnet_group_name:String.t ->
                  ?option_group_name:String.t ->
                    ?vpc_security_group_ids:VpcSecurityGroupIdList.t ->
                      ?tags:TagList.t ->
                        ?kms_key_id:String.t ->
                          ?enable_i_a_m_database_authentication:Boolean.t ->
                            ?backtrack_window:Long.t ->
                              ?enable_cloudwatch_logs_exports:LogTypeList.t
                                ->
                                ?d_b_cluster_parameter_group_name:String.t ->
                                  ?deletion_protection:Boolean.t ->
                                    ?copy_tags_to_snapshot:Boolean.t ->
                                      unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RestoreDBClusterToPointInTimeResult =
RestoreDBClusterToPointInTimeResult
type input = RestoreDBClusterToPointInTimeMessage.t
type output = RestoreDBClusterToPointInTimeResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error