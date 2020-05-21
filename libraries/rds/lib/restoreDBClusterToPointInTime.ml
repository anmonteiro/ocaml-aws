open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RestoreDBClusterToPointInTimeMessage =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The name of the new DB cluster to be created.</p> <p>Constraints:</p> <ul> <li> <p>Must contain from 1 to 63 letters, numbers, or hyphens</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul>"];
      restore_type: String.t option
        [@ocaml.doc
          "<p>The type of restore to be performed. You can specify one of the following values:</p> <ul> <li> <p> <code>full-copy</code> - The new DB cluster is restored as a full copy of the source DB cluster.</p> </li> <li> <p> <code>copy-on-write</code> - The new DB cluster is restored as a clone of the source DB cluster.</p> </li> </ul> <p>Constraints: You can't specify <code>copy-on-write</code> if the engine version of the source DB cluster is earlier than 1.11.</p> <p>If you don't specify a <code>RestoreType</code> value, then the new DB cluster is restored as a full copy of the source DB cluster.</p>"];
      source_d_b_cluster_identifier: String.t
        [@ocaml.doc
          "<p>The identifier of the source DB cluster from which to restore.</p> <p>Constraints:</p> <ul> <li> <p>Must match the identifier of an existing DBCluster.</p> </li> </ul>"];
      restore_to_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time to restore the DB cluster to.</p> <p>Valid Values: Value must be a time in Universal Coordinated Time (UTC) format</p> <p>Constraints:</p> <ul> <li> <p>Must be before the latest restorable time for the DB instance</p> </li> <li> <p>Must be specified if <code>UseLatestRestorableTime</code> parameter isn't provided</p> </li> <li> <p>Can't be specified if the <code>UseLatestRestorableTime</code> parameter is enabled</p> </li> <li> <p>Can't be specified if the <code>RestoreType</code> parameter is <code>copy-on-write</code> </p> </li> </ul> <p>Example: <code>2015-03-07T23:45:00Z</code> </p>"];
      use_latest_restorable_time: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to restore the DB cluster to the latest restorable backup time. By default, the DB cluster isn't restored to the latest restorable backup time. </p> <p>Constraints: Can't be specified if <code>RestoreToTime</code> parameter is provided.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number on which the new DB cluster accepts connections.</p> <p>Constraints: A value from <code>1150-65535</code>. </p> <p>Default: The default port for the engine.</p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc
          "<p>The DB subnet group name to use for the new DB cluster.</p> <p>Constraints: If supplied, must match the name of an existing DBSubnetGroup.</p> <p>Example: <code>mySubnetgroup</code> </p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the option group for the new DB cluster.</p>"];
      vpc_security_group_ids: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of VPC security groups that the new DB cluster belongs to.</p>"];
      tags: TagList.t ;
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier to use when restoring an encrypted DB cluster from an encrypted DB cluster.</p> <p>The KMS key identifier is the Amazon Resource Name (ARN) for the KMS encryption key. If you are restoring a DB cluster with the same AWS account that owns the KMS encryption key used to encrypt the new DB cluster, then you can use the KMS key alias instead of the ARN for the KMS encryption key.</p> <p>You can restore to a new DB cluster and encrypt the new DB cluster with a KMS key that is different than the KMS key used to encrypt the source DB cluster. The new DB cluster is encrypted with the KMS key identified by the <code>KmsKeyId</code> parameter.</p> <p>If you don't specify a value for the <code>KmsKeyId</code> parameter, then the following occurs:</p> <ul> <li> <p>If the DB cluster is encrypted, then the restored DB cluster is encrypted using the KMS key that was used to encrypt the source DB cluster.</p> </li> <li> <p>If the DB cluster isn't encrypted, then the restored DB cluster isn't encrypted.</p> </li> </ul> <p>If <code>DBClusterIdentifier</code> refers to a DB cluster that isn't encrypted, then the restore request is rejected.</p>"];
      enable_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to enable mapping of AWS Identity and Access Management (IAM) accounts to database accounts. By default, mapping is disabled.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.IAMDBAuth.html\"> IAM Database Authentication</a> in the <i>Amazon Aurora User Guide.</i> </p>"];
      backtrack_window: Long.t option
        [@ocaml.doc
          "<p>The target backtrack window, in seconds. To disable backtracking, set this value to 0.</p> <p>Default: 0</p> <p>Constraints:</p> <ul> <li> <p>If specified, this value must be set to a number from 0 to 259,200 (72 hours).</p> </li> </ul>"];
      enable_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>The list of logs that the restored DB cluster is to export to CloudWatch Logs. The values in the list depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB cluster parameter group to associate with this DB cluster. If this argument is omitted, the default DB cluster parameter group for the specified engine is used.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing DB cluster parameter group.</p> </li> <li> <p>Must be 1 to 255 letters, numbers, or hyphens.</p> </li> <li> <p>First character must be a letter.</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens.</p> </li> </ul>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. By default, deletion protection is disabled. </p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to copy all tags from the restored DB cluster to snapshots of the restored DB cluster. The default is not to copy them.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_cluster_identifier  ?restore_type 
      ~source_d_b_cluster_identifier  ?restore_to_time 
      ?use_latest_restorable_time  ?port  ?d_b_subnet_group_name 
      ?option_group_name  ?(vpc_security_group_ids= [])  ?(tags= []) 
      ?kms_key_id  ?enable_i_a_m_database_authentication  ?backtrack_window 
      ?(enable_cloudwatch_logs_exports= []) 
      ?d_b_cluster_parameter_group_name  ?deletion_protection 
      ?copy_tags_to_snapshot  () =
      {
        d_b_cluster_identifier;
        restore_type;
        source_d_b_cluster_identifier;
        restore_to_time;
        use_latest_restorable_time;
        port;
        d_b_subnet_group_name;
        option_group_name;
        vpc_security_group_ids;
        tags;
        kms_key_id;
        enable_i_a_m_database_authentication;
        backtrack_window;
        enable_cloudwatch_logs_exports;
        d_b_cluster_parameter_group_name;
        deletion_protection;
        copy_tags_to_snapshot
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.copy_tags_to_snapshot
              (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.d_b_cluster_parameter_group_name
             (fun f ->
                ("d_b_cluster_parameter_group_name", (String.to_json f)));
           Some
             ("enable_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enable_cloudwatch_logs_exports));
           Util.option_map v.backtrack_window
             (fun f -> ("backtrack_window", (Long.to_json f)));
           Util.option_map v.enable_i_a_m_database_authentication
             (fun f ->
                ("enable_i_a_m_database_authentication", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Some ("tags", (TagList.to_json v.tags));
           Some
             ("vpc_security_group_ids",
               (VpcSecurityGroupIdList.to_json v.vpc_security_group_ids));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.use_latest_restorable_time
             (fun f -> ("use_latest_restorable_time", (Boolean.to_json f)));
           Util.option_map v.restore_to_time
             (fun f -> ("restore_to_time", (DateTime.to_json f)));
           Some
             ("source_d_b_cluster_identifier",
               (String.to_json v.source_d_b_cluster_identifier));
           Util.option_map v.restore_type
             (fun f -> ("restore_type", (String.to_json f)));
           Some
             ("d_b_cluster_identifier",
               (String.to_json v.d_b_cluster_identifier))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Xml.required "DBClusterIdentifier"
               (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
                  String.parse));
          restore_type =
            (Util.option_bind (Xml.member "RestoreType" xml) String.parse);
          source_d_b_cluster_identifier =
            (Xml.required "SourceDBClusterIdentifier"
               (Util.option_bind (Xml.member "SourceDBClusterIdentifier" xml)
                  String.parse));
          restore_to_time =
            (Util.option_bind (Xml.member "RestoreToTime" xml) DateTime.parse);
          use_latest_restorable_time =
            (Util.option_bind (Xml.member "UseLatestRestorableTime" xml)
               Boolean.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  VpcSecurityGroupIdList.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) TagList.parse));
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          enable_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "EnableIAMDatabaseAuthentication" xml)
               Boolean.parse);
          backtrack_window =
            (Util.option_bind (Xml.member "BacktrackWindow" xml) Long.parse);
          enable_cloudwatch_logs_exports =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "EnableCloudwatchLogsExports" xml)
                  LogTypeList.parse));
          d_b_cluster_parameter_group_name =
            (Util.option_bind (Xml.member "DBClusterParameterGroupName" xml)
               String.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Some
                              (Ezxmlm.make_tag "DBClusterIdentifier"
                                 ([],
                                   (String.to_xml v.d_b_cluster_identifier)))])
                          @
                          [Util.option_map v.restore_type
                             (fun f ->
                                Ezxmlm.make_tag "RestoreType"
                                  ([], (String.to_xml f)))])
                         @
                         [Some
                            (Ezxmlm.make_tag "SourceDBClusterIdentifier"
                               ([],
                                 (String.to_xml
                                    v.source_d_b_cluster_identifier)))])
                        @
                        [Util.option_map v.restore_to_time
                           (fun f ->
                              Ezxmlm.make_tag "RestoreToTime"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.use_latest_restorable_time
                          (fun f ->
                             Ezxmlm.make_tag "UseLatestRestorableTime"
                               ([], (Boolean.to_xml f)))])
                      @
                      [Util.option_map v.port
                         (fun f ->
                            Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
                     @
                     [Util.option_map v.d_b_subnet_group_name
                        (fun f ->
                           Ezxmlm.make_tag "DBSubnetGroupName"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.option_group_name
                       (fun f ->
                          Ezxmlm.make_tag "OptionGroupName"
                            ([], (String.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "VpcSecurityGroupIds"
                              ([], (VpcSecurityGroupIdList.to_xml [x]))))
                      v.vpc_security_group_ids))
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "Tags" ([], (TagList.to_xml [x]))))
                     v.tags))
                 @
                 [Util.option_map v.kms_key_id
                    (fun f ->
                       Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.enable_i_a_m_database_authentication
                   (fun f ->
                      Ezxmlm.make_tag "EnableIAMDatabaseAuthentication"
                        ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.backtrack_window
                  (fun f ->
                     Ezxmlm.make_tag "BacktrackWindow" ([], (Long.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "EnableCloudwatchLogsExports"
                         ([], (LogTypeList.to_xml [x]))))
                 v.enable_cloudwatch_logs_exports))
             @
             [Util.option_map v.d_b_cluster_parameter_group_name
                (fun f ->
                   Ezxmlm.make_tag "DBClusterParameterGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.deletion_protection
               (fun f ->
                  Ezxmlm.make_tag "DeletionProtection"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.copy_tags_to_snapshot
              (fun f ->
                 Ezxmlm.make_tag "CopyTagsToSnapshot"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module RestoreDBClusterToPointInTimeResult =
  RestoreDBClusterToPointInTimeResult
type input = RestoreDBClusterToPointInTimeMessage.t
type output = RestoreDBClusterToPointInTimeResult.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["RestoreDBClusterToPointInTime"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render
                  (RestoreDBClusterToPointInTimeMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (RestoreDBClusterToPointInTimeMessage.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "RestoreDBClusterToPointInTimeResponse" (snd xml))
        (Xml.member "RestoreDBClusterToPointInTimeResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp RestoreDBClusterToPointInTimeResult.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed RestoreDBClusterToPointInTimeResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing RestoreDBClusterToPointInTimeResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None