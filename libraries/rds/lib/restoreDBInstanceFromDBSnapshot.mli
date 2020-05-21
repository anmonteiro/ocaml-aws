(** "<p>Creates a new DB instance from a DB snapshot. The target database is created from the source database restore point with the most of original configuration with the default security group and the default DB parameter group. By default, the new DB instance is created as a single-AZ deployment except when the instance is a SQL Server instance that has an option group that is associated with mirroring; in this case, the instance becomes a mirrored AZ deployment and not a single-AZ deployment.</p> <p>If your intent is to replace your original DB instance with the new, restored DB instance, then rename your original DB instance before you call the RestoreDBInstanceFromDBSnapshot action. RDS doesn't allow two DB instances with the same name. Once you have renamed your original DB instance with a different identifier, then you can pass the original name of the DB instance as the DBInstanceIdentifier in the call to the RestoreDBInstanceFromDBSnapshot action. The result is that you will replace the original DB instance with the DB instance created from the snapshot.</p> <p>If you are restoring from a shared manual DB snapshot, the <code>DBSnapshotIdentifier</code> must be the ARN of the shared DB snapshot.</p> <note> <p>This command doesn't apply to Aurora MySQL and Aurora PostgreSQL. For Aurora, use <code>RestoreDBClusterFromSnapshot</code>.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RestoreDBInstanceFromDBSnapshotMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    d_b_snapshot_identifier: String.t ;
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
    tags: TagList.t ;
    storage_type: String.t option ;
    tde_credential_arn: String.t option ;
    tde_credential_password: String.t option ;
    vpc_security_group_ids: VpcSecurityGroupIdList.t ;
    domain: String.t option ;
    copy_tags_to_snapshot: Boolean.t option ;
    domain_i_a_m_role_name: String.t option ;
    enable_i_a_m_database_authentication: Boolean.t option ;
    enable_cloudwatch_logs_exports: LogTypeList.t ;
    processor_features: ProcessorFeatureList.t ;
    use_default_processor_features: Boolean.t option ;
    d_b_parameter_group_name: String.t option ;
    deletion_protection: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_instance_identifier:String.t ->
      d_b_snapshot_identifier:String.t ->
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
                                ?tags:TagList.t ->
                                  ?storage_type:String.t ->
                                    ?tde_credential_arn:String.t ->
                                      ?tde_credential_password:String.t ->
                                        ?vpc_security_group_ids:VpcSecurityGroupIdList.t
                                          ->
                                          ?domain:String.t ->
                                            ?copy_tags_to_snapshot:Boolean.t
                                              ->
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
                                                            -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RestoreDBInstanceFromDBSnapshotResult =
RestoreDBInstanceFromDBSnapshotResult
type input = RestoreDBInstanceFromDBSnapshotMessage.t
type output = RestoreDBInstanceFromDBSnapshotResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error