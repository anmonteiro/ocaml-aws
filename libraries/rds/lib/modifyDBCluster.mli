(** "<p>Modify a setting for an Amazon Aurora DB cluster. You can change one or more database configuration parameters by specifying these parameters and the new values in the request. For more information on Amazon Aurora, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html\"> What Is Amazon Aurora?</a> in the <i>Amazon Aurora User Guide.</i> </p> <note> <p>This action only applies to Aurora DB clusters.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ModifyDBClusterMessage :
sig
  type t =
    {
    d_b_cluster_identifier: String.t ;
    new_d_b_cluster_identifier: String.t option ;
    apply_immediately: Boolean.t option ;
    backup_retention_period: Integer.t option ;
    d_b_cluster_parameter_group_name: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    port: Integer.t option ;
    master_user_password: String.t option ;
    option_group_name: String.t option ;
    preferred_backup_window: String.t option ;
    preferred_maintenance_window: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    backtrack_window: Long.t option ;
    cloudwatch_logs_export_configuration:
      CloudwatchLogsExportConfiguration.t option ;
    engine_version: String.t option ;
    allow_major_version_upgrade: Boolean.t option ;
    d_b_instance_parameter_group_name: String.t option ;
    scaling_configuration: ScalingConfiguration.t option ;
    deletion_protection: Boolean.t option ;
    enable_http_endpoint: Boolean.t option ;
    copy_tags_to_snapshot: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_cluster_identifier:String.t ->
      ?new_d_b_cluster_identifier:String.t ->
        ?apply_immediately:Boolean.t ->
          ?backup_retention_period:Integer.t ->
            ?d_b_cluster_parameter_group_name:String.t ->
              ?vpc_security_group_ids:VpcSecurityGroupIdList.t ->
                ?port:Integer.t ->
                  ?master_user_password:String.t ->
                    ?option_group_name:String.t ->
                      ?preferred_backup_window:String.t ->
                        ?preferred_maintenance_window:String.t ->
                          ?enable_i_a_m_database_authentication:Boolean.t ->
                            ?backtrack_window:Long.t ->
                              ?cloudwatch_logs_export_configuration:CloudwatchLogsExportConfiguration.t
                                ->
                                ?engine_version:String.t ->
                                  ?allow_major_version_upgrade:Boolean.t ->
                                    ?d_b_instance_parameter_group_name:String.t
                                      ->
                                      ?scaling_configuration:ScalingConfiguration.t
                                        ->
                                        ?deletion_protection:Boolean.t ->
                                          ?enable_http_endpoint:Boolean.t ->
                                            ?copy_tags_to_snapshot:Boolean.t
                                              -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ModifyDBClusterResult = ModifyDBClusterResult
type input = ModifyDBClusterMessage.t
type output = ModifyDBClusterResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error