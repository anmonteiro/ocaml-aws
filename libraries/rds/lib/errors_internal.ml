type t =
  | AuthFailure 
  | AuthorizationAlreadyExists
  [@ocaml.doc
    "<p>The specified CIDR IP range or Amazon EC2 security group is already authorized for the specified DB security group.</p>"]
  | AuthorizationNotFound
  [@ocaml.doc
    "<p>The specified CIDR IP range or Amazon EC2 security group might not be authorized for the specified DB security group.</p> <p>Or, RDS might not be authorized to perform necessary actions using IAM on your behalf.</p>"]
  | AuthorizationQuotaExceeded
  [@ocaml.doc
    "<p>The DB security group authorization quota has been reached.</p>"]
  | BackupPolicyNotFoundFault 
  | Blocked 
  | CertificateNotFound
  [@ocaml.doc
    "<p> <code>CertificateIdentifier</code> doesn't refer to an existing certificate. </p>"]
  | CustomAvailabilityZoneAlreadyExists
  [@ocaml.doc
    "<p> <code>CustomAvailabilityZoneName</code> is already used by an existing custom Availability Zone.</p>"]
  | CustomAvailabilityZoneNotFound
  [@ocaml.doc
    "<p> <code>CustomAvailabilityZoneId</code> doesn't refer to an existing custom Availability Zone identifier.</p>"]
  | CustomAvailabilityZoneQuotaExceeded
  [@ocaml.doc
    "<p>You have exceeded the maximum number of custom Availability Zones.</p>"]
  | DBClusterAlreadyExistsFault
  [@ocaml.doc
    "<p>The user already has a DB cluster with the given identifier.</p>"]
  | DBClusterBacktrackNotFoundFault
  [@ocaml.doc
    "<p> <code>BacktrackIdentifier</code> doesn't refer to an existing backtrack. </p>"]
  | DBClusterEndpointAlreadyExistsFault
  [@ocaml.doc
    "<p>The specified custom endpoint can't be created because it already exists.</p>"]
  | DBClusterEndpointNotFoundFault
  [@ocaml.doc "<p>The specified custom endpoint doesn't exist.</p>"]
  | DBClusterEndpointQuotaExceededFault
  [@ocaml.doc
    "<p>The cluster already has the maximum number of custom endpoints.</p>"]
  | DBClusterNotFoundFault
  [@ocaml.doc
    "<p> <code>DBClusterIdentifier</code> doesn't refer to an existing DB cluster. </p>"]
  | DBClusterParameterGroupNotFound
  [@ocaml.doc
    "<p> <code>DBClusterParameterGroupName</code> doesn't refer to an existing DB cluster parameter group. </p>"]
  | DBClusterQuotaExceededFault
  [@ocaml.doc
    "<p>The user attempted to create a new DB cluster and the user has already reached the maximum allowed DB cluster quota.</p>"]
  | DBClusterRoleAlreadyExists
  [@ocaml.doc
    "<p>The specified IAM role Amazon Resource Name (ARN) is already associated with the specified DB cluster.</p>"]
  | DBClusterRoleNotFound
  [@ocaml.doc
    "<p>The specified IAM role Amazon Resource Name (ARN) isn't associated with the specified DB cluster.</p>"]
  | DBClusterRoleQuotaExceeded
  [@ocaml.doc
    "<p>You have exceeded the maximum number of IAM roles that can be associated with the specified DB cluster.</p>"]
  | DBClusterSnapshotAlreadyExistsFault
  [@ocaml.doc
    "<p>The user already has a DB cluster snapshot with the given identifier.</p>"]
  | DBClusterSnapshotNotFoundFault
  [@ocaml.doc
    "<p> <code>DBClusterSnapshotIdentifier</code> doesn't refer to an existing DB cluster snapshot. </p>"]
  | DBInstanceAlreadyExists
  [@ocaml.doc
    "<p>The user already has a DB instance with the given identifier.</p>"]
  | DBInstanceAutomatedBackupNotFound
  [@ocaml.doc "<p>No automated backup for this DB instance was found.</p>"]
  | DBInstanceAutomatedBackupQuotaExceeded
  [@ocaml.doc
    "<p>The quota for retained automated backups was exceeded. This prevents you from retaining any additional automated backups. The retained automated backups quota is the same as your DB Instance quota.</p>"]
  | DBInstanceNotFound
  [@ocaml.doc
    "<p> <code>DBInstanceIdentifier</code> doesn't refer to an existing DB instance. </p>"]
  | DBInstanceRoleAlreadyExists
  [@ocaml.doc
    "<p>The specified <code>RoleArn</code> or <code>FeatureName</code> value is already associated with the DB instance.</p>"]
  | DBInstanceRoleNotFound
  [@ocaml.doc
    "<p>The specified <code>RoleArn</code> value doesn't match the specified feature for the DB instance.</p>"]
  | DBInstanceRoleQuotaExceeded
  [@ocaml.doc
    "<p>You can't associate any more AWS Identity and Access Management (IAM) roles with the DB instance because the quota has been reached.</p>"]
  | DBLogFileNotFoundFault
  [@ocaml.doc
    "<p> <code>LogFileName</code> doesn't refer to an existing DB log file.</p>"]
  | DBParameterGroupAlreadyExists
  [@ocaml.doc "<p>A DB parameter group with the same name exists.</p>"]
  | DBParameterGroupNotFound
  [@ocaml.doc
    "<p> <code>DBParameterGroupName</code> doesn't refer to an existing DB parameter group. </p>"]
  | DBParameterGroupQuotaExceeded
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed number of DB parameter groups.</p>"]
  | DBProxyAlreadyExistsFault
  [@ocaml.doc
    "<p>The specified proxy name must be unique for all proxies owned by your AWS account in the specified AWS Region.</p>"]
  | DBProxyNotFoundFault
  [@ocaml.doc
    "<p>The specified proxy name doesn't correspond to a proxy owned by your AWS accoutn in the specified AWS Region.</p>"]
  | DBProxyQuotaExceededFault
  [@ocaml.doc
    "<p>Your AWS account already has the maximum number of proxies in the specified AWS Region.</p>"]
  | DBProxyTargetAlreadyRegisteredFault
  [@ocaml.doc
    "<p>The proxy is already associated with the specified RDS DB instance or Aurora DB cluster.</p>"]
  | DBProxyTargetGroupNotFoundFault
  [@ocaml.doc
    "<p>The specified target group isn't available for a proxy owned by your AWS account in the specified AWS Region.</p>"]
  | DBProxyTargetNotFoundFault
  [@ocaml.doc
    "<p>The specified RDS DB instance or Aurora DB cluster isn't available for a proxy owned by your AWS account in the specified AWS Region.</p>"]
  | DBSecurityGroupAlreadyExists
  [@ocaml.doc
    "<p> A DB security group with the name specified in <code>DBSecurityGroupName</code> already exists. </p>"]
  | DBSecurityGroupNotFound
  [@ocaml.doc
    "<p> <code>DBSecurityGroupName</code> doesn't refer to an existing DB security group. </p>"]
  | DBSecurityGroupNotSupported
  [@ocaml.doc "<p>A DB security group isn't allowed for this action.</p>"]
  | DBSnapshotAlreadyExists
  [@ocaml.doc
    "<p> <code>DBSnapshotIdentifier</code> is already used by an existing snapshot. </p>"]
  | DBSnapshotNotFound
  [@ocaml.doc
    "<p> <code>DBSnapshotIdentifier</code> doesn't refer to an existing DB snapshot. </p>"]
  | DBSubnetGroupAlreadyExists
  [@ocaml.doc
    "<p> <code>DBSubnetGroupName</code> is already used by an existing DB subnet group. </p>"]
  | DBSubnetGroupDoesNotCoverEnoughAZs
  [@ocaml.doc
    "<p>Subnets in the DB subnet group should cover at least two Availability Zones unless there is only one Availability Zone.</p>"]
  | DBSubnetGroupNotAllowedFault
  [@ocaml.doc
    "<p>The DBSubnetGroup shouldn't be specified while creating read replicas that lie in the same region as the source instance.</p>"]
  | DBSubnetGroupNotFoundFault
  [@ocaml.doc
    "<p> <code>DBSubnetGroupName</code> doesn't refer to an existing DB subnet group. </p>"]
  | DBSubnetGroupQuotaExceeded
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed number of DB subnet groups.</p>"]
  | DBSubnetQuotaExceededFault
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed number of subnets in a DB subnet groups.</p>"]
  | DBUpgradeDependencyFailure
  [@ocaml.doc
    "<p>The DB upgrade failed because a resource the DB depends on can't be modified.</p>"]
  | DomainNotFoundFault
  [@ocaml.doc
    "<p> <code>Domain</code> doesn't refer to an existing Active Directory domain. </p>"]
  | DryRunOperation 
  | EventSubscriptionQuotaExceeded
  [@ocaml.doc
    "<p>You have reached the maximum number of event subscriptions.</p>"]
  | GlobalClusterAlreadyExistsFault [@ocaml.doc "<p/>"]
  | GlobalClusterNotFoundFault [@ocaml.doc "<p/>"]
  | GlobalClusterQuotaExceededFault [@ocaml.doc "<p/>"]
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InstallationMediaAlreadyExists
  [@ocaml.doc
    "<p>The specified installation medium has already been imported.</p>"]
  | InstallationMediaNotFound
  [@ocaml.doc
    "<p> <code>InstallationMediaID</code> doesn't refer to an existing installation medium.</p>"]
  | InstanceQuotaExceeded
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed number of DB instances.</p>"]
  | InsufficientDBClusterCapacityFault
  [@ocaml.doc
    "<p>The DB cluster doesn't have enough capacity for the current operation.</p>"]
  | InsufficientDBInstanceCapacity
  [@ocaml.doc
    "<p>The specified DB instance class isn't available in the specified Availability Zone.</p>"]
  | InsufficientStorageClusterCapacity
  [@ocaml.doc
    "<p>There is insufficient storage available for the current action. You might be able to resolve this error by updating your subnet group to use different Availability Zones that have more storage available.</p>"]
  | InternalFailure 
  | InvalidAction 
  | InvalidClientTokenId 
  | InvalidDBClusterCapacityFault
  [@ocaml.doc
    "<p> <code>Capacity</code> isn't a valid Aurora Serverless DB cluster capacity. Valid capacity values are <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>128</code>, and <code>256</code>.</p>"]
  | InvalidDBClusterEndpointStateFault
  [@ocaml.doc
    "<p>The requested operation can't be performed on the endpoint while the endpoint is in this state.</p>"]
  | InvalidDBClusterSnapshotStateFault
  [@ocaml.doc
    "<p>The supplied value isn't a valid DB cluster snapshot state.</p>"]
  | InvalidDBClusterStateFault
  [@ocaml.doc
    "<p>The requested operation can't be performed while the cluster is in this state.</p>"]
  | InvalidDBInstanceAutomatedBackupState
  [@ocaml.doc
    "<p>The automated backup is in an invalid state. For example, this automated backup is associated with an active instance. </p>"]
  | InvalidDBInstanceState
  [@ocaml.doc "<p>The DB instance isn't in a valid state.</p>"]
  | InvalidDBParameterGroupState
  [@ocaml.doc
    "<p>The DB parameter group is in use or is in an invalid state. If you are attempting to delete the parameter group, you can't delete it when the parameter group is in this state.</p>"]
  | InvalidDBProxyStateFault
  [@ocaml.doc
    "<p>The requested operation can't be performed while the proxy is in this state.</p>"]
  | InvalidDBSecurityGroupState
  [@ocaml.doc
    "<p>The state of the DB security group doesn't allow deletion.</p>"]
  | InvalidDBSnapshotState
  [@ocaml.doc "<p>The state of the DB snapshot doesn't allow deletion.</p>"]
  | InvalidDBSubnetGroupFault
  [@ocaml.doc
    "<p>The DBSubnetGroup doesn't belong to the same VPC as that of an existing cross-region read replica of the same source instance.</p>"]
  | InvalidDBSubnetGroupStateFault
  [@ocaml.doc
    "<p>The DB subnet group cannot be deleted because it's in use.</p>"]
  | InvalidDBSubnetStateFault
  [@ocaml.doc "<p> The DB subnet isn't in the <i>available</i> state. </p>"]
  | InvalidEventSubscriptionState
  [@ocaml.doc
    "<p>This error can occur if someone else is modifying a subscription. You should retry the action.</p>"]
  | InvalidGlobalClusterStateFault [@ocaml.doc "<p/>"]
  | InvalidOptionGroupStateFault
  [@ocaml.doc
    "<p> The option group isn't in the <i>available</i> state. </p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterValue 
  | InvalidQueryParameter 
  | InvalidRestoreFault
  [@ocaml.doc
    "<p>Cannot restore from VPC backup to non-VPC DB instance.</p>"]
  | InvalidS3BucketFault
  [@ocaml.doc
    "<p>The specified Amazon S3 bucket name can't be found or Amazon RDS isn't authorized to access the specified Amazon S3 bucket. Verify the <b>SourceS3BucketName</b> and <b>S3IngestionRoleArn</b> values and try again.</p>"]
  | InvalidSubnet
  [@ocaml.doc
    "<p>The requested subnet is invalid, or multiple subnets were requested that are not all in a common VPC.</p>"]
  | InvalidVPCNetworkStateFault
  [@ocaml.doc
    "<p>The DB subnet group doesn't cover all Availability Zones after it's created because of users' change.</p>"]
  | KMSKeyNotAccessibleFault
  [@ocaml.doc "<p>An error occurred accessing an AWS KMS key.</p>"]
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | OptInRequired 
  | OptionGroupAlreadyExistsFault
  [@ocaml.doc
    "<p>The option group you are trying to create already exists.</p>"]
  | OptionGroupNotFoundFault
  [@ocaml.doc "<p>The specified option group could not be found.</p>"]
  | OptionGroupQuotaExceededFault
  [@ocaml.doc
    "<p>The quota of 20 option groups was exceeded for this AWS account.</p>"]
  | PendingVerification 
  | PointInTimeRestoreNotEnabled
  [@ocaml.doc
    "<p> <code>SourceDBInstanceIdentifier</code> refers to a DB instance with <code>BackupRetentionPeriod</code> equal to 0. </p>"]
  | ProvisionedIopsNotAvailableInAZFault
  [@ocaml.doc
    "<p>Provisioned IOPS not available in the specified Availability Zone.</p>"]
  | QuotaExceeded_DBSecurityGroup
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed number of DB security groups.</p>"]
  | RequestExpired 
  | RequestLimitExceeded 
  | ReservedDBInstanceAlreadyExists
  [@ocaml.doc
    "<p>User already has a reservation with the given identifier.</p>"]
  | ReservedDBInstanceNotFound
  [@ocaml.doc "<p>The specified reserved DB Instance not found.</p>"]
  | ReservedDBInstanceQuotaExceeded
  [@ocaml.doc "<p>Request would exceed the user's DB Instance quota.</p>"]
  | ReservedDBInstancesOfferingNotFound
  [@ocaml.doc "<p>Specified offering does not exist.</p>"]
  | ResourceNotFoundFault
  [@ocaml.doc "<p>The specified resource ID was not found.</p>"]
  | SNSInvalidTopic
  [@ocaml.doc
    "<p>SNS has responded that there is a problem with the SND topic specified.</p>"]
  | SNSNoAuthorization
  [@ocaml.doc
    "<p>You do not have permission to publish to the SNS topic ARN.</p>"]
  | SNSTopicArnNotFound
  [@ocaml.doc "<p>The SNS topic ARN does not exist.</p>"]
  | ServiceUnavailable 
  | SharedSnapshotQuotaExceeded
  [@ocaml.doc
    "<p>You have exceeded the maximum number of accounts that you can share a manual DB snapshot with.</p>"]
  | SnapshotQuotaExceeded
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed number of DB snapshots.</p>"]
  | SourceNotFound
  [@ocaml.doc "<p>The requested source could not be found.</p>"]
  | StorageQuotaExceeded
  [@ocaml.doc
    "<p>The request would result in the user exceeding the allowed amount of storage available across all DB instances.</p>"]
  | StorageTypeNotSupported
  [@ocaml.doc
    "<p>Storage of the <code>StorageType</code> specified can't be associated with the DB instance. </p>"]
  | SubnetAlreadyInUse
  [@ocaml.doc
    "<p>The DB subnet is already in use in the Availability Zone.</p>"]
  | SubscriptionAlreadyExist
  [@ocaml.doc "<p>The supplied subscription name already exists.</p>"]
  | SubscriptionCategoryNotFound
  [@ocaml.doc "<p>The supplied category does not exist.</p>"]
  | SubscriptionNotFound
  [@ocaml.doc "<p>The subscription name does not exist.</p>"]
  | Throttling 
  | UnauthorizedOperation 
  | UnknownParameter 
  | UnsupportedProtocol 
  | ValidationError 
  | Uninhabited 
let common =
  [UnsupportedProtocol;
  UnknownParameter;
  UnauthorizedOperation;
  RequestLimitExceeded;
  PendingVerification;
  InvalidParameter;
  IdempotentParameterMismatch;
  DryRunOperation;
  Blocked;
  AuthFailure;
  ValidationError;
  Throttling;
  ServiceUnavailable;
  RequestExpired;
  OptInRequired;
  MissingParameter;
  MissingAuthenticationToken;
  MissingAction;
  MalformedQueryString;
  InvalidQueryParameter;
  InvalidParameterValue;
  InvalidParameterCombination;
  InvalidClientTokenId;
  InvalidAction;
  InternalFailure;
  IncompleteSignature]
let to_http_code e =
  match e with
  | AuthFailure -> None
  | AuthorizationAlreadyExists -> Some 400
  | AuthorizationNotFound -> Some 404
  | AuthorizationQuotaExceeded -> Some 400
  | BackupPolicyNotFoundFault -> Some 404
  | Blocked -> None
  | CertificateNotFound -> Some 404
  | CustomAvailabilityZoneAlreadyExists -> Some 400
  | CustomAvailabilityZoneNotFound -> Some 404
  | CustomAvailabilityZoneQuotaExceeded -> Some 400
  | DBClusterAlreadyExistsFault -> Some 400
  | DBClusterBacktrackNotFoundFault -> Some 404
  | DBClusterEndpointAlreadyExistsFault -> Some 400
  | DBClusterEndpointNotFoundFault -> Some 400
  | DBClusterEndpointQuotaExceededFault -> Some 403
  | DBClusterNotFoundFault -> Some 404
  | DBClusterParameterGroupNotFound -> Some 404
  | DBClusterQuotaExceededFault -> Some 403
  | DBClusterRoleAlreadyExists -> Some 400
  | DBClusterRoleNotFound -> Some 404
  | DBClusterRoleQuotaExceeded -> Some 400
  | DBClusterSnapshotAlreadyExistsFault -> Some 400
  | DBClusterSnapshotNotFoundFault -> Some 404
  | DBInstanceAlreadyExists -> Some 400
  | DBInstanceAutomatedBackupNotFound -> Some 404
  | DBInstanceAutomatedBackupQuotaExceeded -> Some 400
  | DBInstanceNotFound -> Some 404
  | DBInstanceRoleAlreadyExists -> Some 400
  | DBInstanceRoleNotFound -> Some 404
  | DBInstanceRoleQuotaExceeded -> Some 400
  | DBLogFileNotFoundFault -> Some 404
  | DBParameterGroupAlreadyExists -> Some 400
  | DBParameterGroupNotFound -> Some 404
  | DBParameterGroupQuotaExceeded -> Some 400
  | DBProxyAlreadyExistsFault -> Some 400
  | DBProxyNotFoundFault -> Some 404
  | DBProxyQuotaExceededFault -> Some 400
  | DBProxyTargetAlreadyRegisteredFault -> Some 400
  | DBProxyTargetGroupNotFoundFault -> Some 404
  | DBProxyTargetNotFoundFault -> Some 404
  | DBSecurityGroupAlreadyExists -> Some 400
  | DBSecurityGroupNotFound -> Some 404
  | DBSecurityGroupNotSupported -> Some 400
  | DBSnapshotAlreadyExists -> Some 400
  | DBSnapshotNotFound -> Some 404
  | DBSubnetGroupAlreadyExists -> Some 400
  | DBSubnetGroupDoesNotCoverEnoughAZs -> Some 400
  | DBSubnetGroupNotAllowedFault -> Some 400
  | DBSubnetGroupNotFoundFault -> Some 404
  | DBSubnetGroupQuotaExceeded -> Some 400
  | DBSubnetQuotaExceededFault -> Some 400
  | DBUpgradeDependencyFailure -> Some 400
  | DomainNotFoundFault -> Some 404
  | DryRunOperation -> None
  | EventSubscriptionQuotaExceeded -> Some 400
  | GlobalClusterAlreadyExistsFault -> Some 400
  | GlobalClusterNotFoundFault -> Some 404
  | GlobalClusterQuotaExceededFault -> Some 400
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InstallationMediaAlreadyExists -> Some 400
  | InstallationMediaNotFound -> Some 404
  | InstanceQuotaExceeded -> Some 400
  | InsufficientDBClusterCapacityFault -> Some 403
  | InsufficientDBInstanceCapacity -> Some 400
  | InsufficientStorageClusterCapacity -> Some 400
  | InternalFailure -> Some 500
  | InvalidAction -> Some 400
  | InvalidClientTokenId -> Some 403
  | InvalidDBClusterCapacityFault -> Some 400
  | InvalidDBClusterEndpointStateFault -> Some 400
  | InvalidDBClusterSnapshotStateFault -> Some 400
  | InvalidDBClusterStateFault -> Some 400
  | InvalidDBInstanceAutomatedBackupState -> Some 400
  | InvalidDBInstanceState -> Some 400
  | InvalidDBParameterGroupState -> Some 400
  | InvalidDBProxyStateFault -> Some 400
  | InvalidDBSecurityGroupState -> Some 400
  | InvalidDBSnapshotState -> Some 400
  | InvalidDBSubnetGroupFault -> Some 400
  | InvalidDBSubnetGroupStateFault -> Some 400
  | InvalidDBSubnetStateFault -> Some 400
  | InvalidEventSubscriptionState -> Some 400
  | InvalidGlobalClusterStateFault -> Some 400
  | InvalidOptionGroupStateFault -> Some 400
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | InvalidRestoreFault -> Some 400
  | InvalidS3BucketFault -> Some 400
  | InvalidSubnet -> Some 400
  | InvalidVPCNetworkStateFault -> Some 400
  | KMSKeyNotAccessibleFault -> Some 400
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | OptInRequired -> Some 403
  | OptionGroupAlreadyExistsFault -> Some 400
  | OptionGroupNotFoundFault -> Some 404
  | OptionGroupQuotaExceededFault -> Some 400
  | PendingVerification -> None
  | PointInTimeRestoreNotEnabled -> Some 400
  | ProvisionedIopsNotAvailableInAZFault -> Some 400
  | QuotaExceeded_DBSecurityGroup -> Some 400
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ReservedDBInstanceAlreadyExists -> Some 404
  | ReservedDBInstanceNotFound -> Some 404
  | ReservedDBInstanceQuotaExceeded -> Some 400
  | ReservedDBInstancesOfferingNotFound -> Some 404
  | ResourceNotFoundFault -> Some 404
  | SNSInvalidTopic -> Some 400
  | SNSNoAuthorization -> Some 400
  | SNSTopicArnNotFound -> Some 404
  | ServiceUnavailable -> Some 503
  | SharedSnapshotQuotaExceeded -> Some 400
  | SnapshotQuotaExceeded -> Some 400
  | SourceNotFound -> Some 404
  | StorageQuotaExceeded -> Some 400
  | StorageTypeNotSupported -> Some 400
  | SubnetAlreadyInUse -> Some 400
  | SubscriptionAlreadyExist -> Some 400
  | SubscriptionCategoryNotFound -> Some 404
  | SubscriptionNotFound -> Some 404
  | Throttling -> Some 400
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AuthFailure -> "AuthFailure"
  | AuthorizationAlreadyExists -> "AuthorizationAlreadyExists"
  | AuthorizationNotFound -> "AuthorizationNotFound"
  | AuthorizationQuotaExceeded -> "AuthorizationQuotaExceeded"
  | BackupPolicyNotFoundFault -> "BackupPolicyNotFoundFault"
  | Blocked -> "Blocked"
  | CertificateNotFound -> "CertificateNotFound"
  | CustomAvailabilityZoneAlreadyExists ->
      "CustomAvailabilityZoneAlreadyExists"
  | CustomAvailabilityZoneNotFound -> "CustomAvailabilityZoneNotFound"
  | CustomAvailabilityZoneQuotaExceeded ->
      "CustomAvailabilityZoneQuotaExceeded"
  | DBClusterAlreadyExistsFault -> "DBClusterAlreadyExistsFault"
  | DBClusterBacktrackNotFoundFault -> "DBClusterBacktrackNotFoundFault"
  | DBClusterEndpointAlreadyExistsFault ->
      "DBClusterEndpointAlreadyExistsFault"
  | DBClusterEndpointNotFoundFault -> "DBClusterEndpointNotFoundFault"
  | DBClusterEndpointQuotaExceededFault ->
      "DBClusterEndpointQuotaExceededFault"
  | DBClusterNotFoundFault -> "DBClusterNotFoundFault"
  | DBClusterParameterGroupNotFound -> "DBClusterParameterGroupNotFound"
  | DBClusterQuotaExceededFault -> "DBClusterQuotaExceededFault"
  | DBClusterRoleAlreadyExists -> "DBClusterRoleAlreadyExists"
  | DBClusterRoleNotFound -> "DBClusterRoleNotFound"
  | DBClusterRoleQuotaExceeded -> "DBClusterRoleQuotaExceeded"
  | DBClusterSnapshotAlreadyExistsFault ->
      "DBClusterSnapshotAlreadyExistsFault"
  | DBClusterSnapshotNotFoundFault -> "DBClusterSnapshotNotFoundFault"
  | DBInstanceAlreadyExists -> "DBInstanceAlreadyExists"
  | DBInstanceAutomatedBackupNotFound -> "DBInstanceAutomatedBackupNotFound"
  | DBInstanceAutomatedBackupQuotaExceeded ->
      "DBInstanceAutomatedBackupQuotaExceeded"
  | DBInstanceNotFound -> "DBInstanceNotFound"
  | DBInstanceRoleAlreadyExists -> "DBInstanceRoleAlreadyExists"
  | DBInstanceRoleNotFound -> "DBInstanceRoleNotFound"
  | DBInstanceRoleQuotaExceeded -> "DBInstanceRoleQuotaExceeded"
  | DBLogFileNotFoundFault -> "DBLogFileNotFoundFault"
  | DBParameterGroupAlreadyExists -> "DBParameterGroupAlreadyExists"
  | DBParameterGroupNotFound -> "DBParameterGroupNotFound"
  | DBParameterGroupQuotaExceeded -> "DBParameterGroupQuotaExceeded"
  | DBProxyAlreadyExistsFault -> "DBProxyAlreadyExistsFault"
  | DBProxyNotFoundFault -> "DBProxyNotFoundFault"
  | DBProxyQuotaExceededFault -> "DBProxyQuotaExceededFault"
  | DBProxyTargetAlreadyRegisteredFault ->
      "DBProxyTargetAlreadyRegisteredFault"
  | DBProxyTargetGroupNotFoundFault -> "DBProxyTargetGroupNotFoundFault"
  | DBProxyTargetNotFoundFault -> "DBProxyTargetNotFoundFault"
  | DBSecurityGroupAlreadyExists -> "DBSecurityGroupAlreadyExists"
  | DBSecurityGroupNotFound -> "DBSecurityGroupNotFound"
  | DBSecurityGroupNotSupported -> "DBSecurityGroupNotSupported"
  | DBSnapshotAlreadyExists -> "DBSnapshotAlreadyExists"
  | DBSnapshotNotFound -> "DBSnapshotNotFound"
  | DBSubnetGroupAlreadyExists -> "DBSubnetGroupAlreadyExists"
  | DBSubnetGroupDoesNotCoverEnoughAZs ->
      "DBSubnetGroupDoesNotCoverEnoughAZs"
  | DBSubnetGroupNotAllowedFault -> "DBSubnetGroupNotAllowedFault"
  | DBSubnetGroupNotFoundFault -> "DBSubnetGroupNotFoundFault"
  | DBSubnetGroupQuotaExceeded -> "DBSubnetGroupQuotaExceeded"
  | DBSubnetQuotaExceededFault -> "DBSubnetQuotaExceededFault"
  | DBUpgradeDependencyFailure -> "DBUpgradeDependencyFailure"
  | DomainNotFoundFault -> "DomainNotFoundFault"
  | DryRunOperation -> "DryRunOperation"
  | EventSubscriptionQuotaExceeded -> "EventSubscriptionQuotaExceeded"
  | GlobalClusterAlreadyExistsFault -> "GlobalClusterAlreadyExistsFault"
  | GlobalClusterNotFoundFault -> "GlobalClusterNotFoundFault"
  | GlobalClusterQuotaExceededFault -> "GlobalClusterQuotaExceededFault"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InstallationMediaAlreadyExists -> "InstallationMediaAlreadyExists"
  | InstallationMediaNotFound -> "InstallationMediaNotFound"
  | InstanceQuotaExceeded -> "InstanceQuotaExceeded"
  | InsufficientDBClusterCapacityFault ->
      "InsufficientDBClusterCapacityFault"
  | InsufficientDBInstanceCapacity -> "InsufficientDBInstanceCapacity"
  | InsufficientStorageClusterCapacity ->
      "InsufficientStorageClusterCapacity"
  | InternalFailure -> "InternalFailure"
  | InvalidAction -> "InvalidAction"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidDBClusterCapacityFault -> "InvalidDBClusterCapacityFault"
  | InvalidDBClusterEndpointStateFault ->
      "InvalidDBClusterEndpointStateFault"
  | InvalidDBClusterSnapshotStateFault ->
      "InvalidDBClusterSnapshotStateFault"
  | InvalidDBClusterStateFault -> "InvalidDBClusterStateFault"
  | InvalidDBInstanceAutomatedBackupState ->
      "InvalidDBInstanceAutomatedBackupState"
  | InvalidDBInstanceState -> "InvalidDBInstanceState"
  | InvalidDBParameterGroupState -> "InvalidDBParameterGroupState"
  | InvalidDBProxyStateFault -> "InvalidDBProxyStateFault"
  | InvalidDBSecurityGroupState -> "InvalidDBSecurityGroupState"
  | InvalidDBSnapshotState -> "InvalidDBSnapshotState"
  | InvalidDBSubnetGroupFault -> "InvalidDBSubnetGroupFault"
  | InvalidDBSubnetGroupStateFault -> "InvalidDBSubnetGroupStateFault"
  | InvalidDBSubnetStateFault -> "InvalidDBSubnetStateFault"
  | InvalidEventSubscriptionState -> "InvalidEventSubscriptionState"
  | InvalidGlobalClusterStateFault -> "InvalidGlobalClusterStateFault"
  | InvalidOptionGroupStateFault -> "InvalidOptionGroupStateFault"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | InvalidRestoreFault -> "InvalidRestoreFault"
  | InvalidS3BucketFault -> "InvalidS3BucketFault"
  | InvalidSubnet -> "InvalidSubnet"
  | InvalidVPCNetworkStateFault -> "InvalidVPCNetworkStateFault"
  | KMSKeyNotAccessibleFault -> "KMSKeyNotAccessibleFault"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | OptInRequired -> "OptInRequired"
  | OptionGroupAlreadyExistsFault -> "OptionGroupAlreadyExistsFault"
  | OptionGroupNotFoundFault -> "OptionGroupNotFoundFault"
  | OptionGroupQuotaExceededFault -> "OptionGroupQuotaExceededFault"
  | PendingVerification -> "PendingVerification"
  | PointInTimeRestoreNotEnabled -> "PointInTimeRestoreNotEnabled"
  | ProvisionedIopsNotAvailableInAZFault ->
      "ProvisionedIopsNotAvailableInAZFault"
  | QuotaExceeded_DBSecurityGroup -> "QuotaExceeded.DBSecurityGroup"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ReservedDBInstanceAlreadyExists -> "ReservedDBInstanceAlreadyExists"
  | ReservedDBInstanceNotFound -> "ReservedDBInstanceNotFound"
  | ReservedDBInstanceQuotaExceeded -> "ReservedDBInstanceQuotaExceeded"
  | ReservedDBInstancesOfferingNotFound ->
      "ReservedDBInstancesOfferingNotFound"
  | ResourceNotFoundFault -> "ResourceNotFoundFault"
  | SNSInvalidTopic -> "SNSInvalidTopic"
  | SNSNoAuthorization -> "SNSNoAuthorization"
  | SNSTopicArnNotFound -> "SNSTopicArnNotFound"
  | ServiceUnavailable -> "ServiceUnavailable"
  | SharedSnapshotQuotaExceeded -> "SharedSnapshotQuotaExceeded"
  | SnapshotQuotaExceeded -> "SnapshotQuotaExceeded"
  | SourceNotFound -> "SourceNotFound"
  | StorageQuotaExceeded -> "StorageQuotaExceeded"
  | StorageTypeNotSupported -> "StorageTypeNotSupported"
  | SubnetAlreadyInUse -> "SubnetAlreadyInUse"
  | SubscriptionAlreadyExist -> "SubscriptionAlreadyExist"
  | SubscriptionCategoryNotFound -> "SubscriptionCategoryNotFound"
  | SubscriptionNotFound -> "SubscriptionNotFound"
  | Throttling -> "Throttling"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AuthFailure" -> Some AuthFailure
  | "AuthorizationAlreadyExists" -> Some AuthorizationAlreadyExists
  | "AuthorizationNotFound" -> Some AuthorizationNotFound
  | "AuthorizationQuotaExceeded" -> Some AuthorizationQuotaExceeded
  | "BackupPolicyNotFoundFault" -> Some BackupPolicyNotFoundFault
  | "Blocked" -> Some Blocked
  | "CertificateNotFound" -> Some CertificateNotFound
  | "CustomAvailabilityZoneAlreadyExists" ->
      Some CustomAvailabilityZoneAlreadyExists
  | "CustomAvailabilityZoneNotFound" -> Some CustomAvailabilityZoneNotFound
  | "CustomAvailabilityZoneQuotaExceeded" ->
      Some CustomAvailabilityZoneQuotaExceeded
  | "DBClusterAlreadyExistsFault" -> Some DBClusterAlreadyExistsFault
  | "DBClusterBacktrackNotFoundFault" -> Some DBClusterBacktrackNotFoundFault
  | "DBClusterEndpointAlreadyExistsFault" ->
      Some DBClusterEndpointAlreadyExistsFault
  | "DBClusterEndpointNotFoundFault" -> Some DBClusterEndpointNotFoundFault
  | "DBClusterEndpointQuotaExceededFault" ->
      Some DBClusterEndpointQuotaExceededFault
  | "DBClusterNotFoundFault" -> Some DBClusterNotFoundFault
  | "DBClusterParameterGroupNotFound" -> Some DBClusterParameterGroupNotFound
  | "DBClusterQuotaExceededFault" -> Some DBClusterQuotaExceededFault
  | "DBClusterRoleAlreadyExists" -> Some DBClusterRoleAlreadyExists
  | "DBClusterRoleNotFound" -> Some DBClusterRoleNotFound
  | "DBClusterRoleQuotaExceeded" -> Some DBClusterRoleQuotaExceeded
  | "DBClusterSnapshotAlreadyExistsFault" ->
      Some DBClusterSnapshotAlreadyExistsFault
  | "DBClusterSnapshotNotFoundFault" -> Some DBClusterSnapshotNotFoundFault
  | "DBInstanceAlreadyExists" -> Some DBInstanceAlreadyExists
  | "DBInstanceAutomatedBackupNotFound" ->
      Some DBInstanceAutomatedBackupNotFound
  | "DBInstanceAutomatedBackupQuotaExceeded" ->
      Some DBInstanceAutomatedBackupQuotaExceeded
  | "DBInstanceNotFound" -> Some DBInstanceNotFound
  | "DBInstanceRoleAlreadyExists" -> Some DBInstanceRoleAlreadyExists
  | "DBInstanceRoleNotFound" -> Some DBInstanceRoleNotFound
  | "DBInstanceRoleQuotaExceeded" -> Some DBInstanceRoleQuotaExceeded
  | "DBLogFileNotFoundFault" -> Some DBLogFileNotFoundFault
  | "DBParameterGroupAlreadyExists" -> Some DBParameterGroupAlreadyExists
  | "DBParameterGroupNotFound" -> Some DBParameterGroupNotFound
  | "DBParameterGroupQuotaExceeded" -> Some DBParameterGroupQuotaExceeded
  | "DBProxyAlreadyExistsFault" -> Some DBProxyAlreadyExistsFault
  | "DBProxyNotFoundFault" -> Some DBProxyNotFoundFault
  | "DBProxyQuotaExceededFault" -> Some DBProxyQuotaExceededFault
  | "DBProxyTargetAlreadyRegisteredFault" ->
      Some DBProxyTargetAlreadyRegisteredFault
  | "DBProxyTargetGroupNotFoundFault" -> Some DBProxyTargetGroupNotFoundFault
  | "DBProxyTargetNotFoundFault" -> Some DBProxyTargetNotFoundFault
  | "DBSecurityGroupAlreadyExists" -> Some DBSecurityGroupAlreadyExists
  | "DBSecurityGroupNotFound" -> Some DBSecurityGroupNotFound
  | "DBSecurityGroupNotSupported" -> Some DBSecurityGroupNotSupported
  | "DBSnapshotAlreadyExists" -> Some DBSnapshotAlreadyExists
  | "DBSnapshotNotFound" -> Some DBSnapshotNotFound
  | "DBSubnetGroupAlreadyExists" -> Some DBSubnetGroupAlreadyExists
  | "DBSubnetGroupDoesNotCoverEnoughAZs" ->
      Some DBSubnetGroupDoesNotCoverEnoughAZs
  | "DBSubnetGroupNotAllowedFault" -> Some DBSubnetGroupNotAllowedFault
  | "DBSubnetGroupNotFoundFault" -> Some DBSubnetGroupNotFoundFault
  | "DBSubnetGroupQuotaExceeded" -> Some DBSubnetGroupQuotaExceeded
  | "DBSubnetQuotaExceededFault" -> Some DBSubnetQuotaExceededFault
  | "DBUpgradeDependencyFailure" -> Some DBUpgradeDependencyFailure
  | "DomainNotFoundFault" -> Some DomainNotFoundFault
  | "DryRunOperation" -> Some DryRunOperation
  | "EventSubscriptionQuotaExceeded" -> Some EventSubscriptionQuotaExceeded
  | "GlobalClusterAlreadyExistsFault" -> Some GlobalClusterAlreadyExistsFault
  | "GlobalClusterNotFoundFault" -> Some GlobalClusterNotFoundFault
  | "GlobalClusterQuotaExceededFault" -> Some GlobalClusterQuotaExceededFault
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InstallationMediaAlreadyExists" -> Some InstallationMediaAlreadyExists
  | "InstallationMediaNotFound" -> Some InstallationMediaNotFound
  | "InstanceQuotaExceeded" -> Some InstanceQuotaExceeded
  | "InsufficientDBClusterCapacityFault" ->
      Some InsufficientDBClusterCapacityFault
  | "InsufficientDBInstanceCapacity" -> Some InsufficientDBInstanceCapacity
  | "InsufficientStorageClusterCapacity" ->
      Some InsufficientStorageClusterCapacity
  | "InternalFailure" -> Some InternalFailure
  | "InvalidAction" -> Some InvalidAction
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidDBClusterCapacityFault" -> Some InvalidDBClusterCapacityFault
  | "InvalidDBClusterEndpointStateFault" ->
      Some InvalidDBClusterEndpointStateFault
  | "InvalidDBClusterSnapshotStateFault" ->
      Some InvalidDBClusterSnapshotStateFault
  | "InvalidDBClusterStateFault" -> Some InvalidDBClusterStateFault
  | "InvalidDBInstanceAutomatedBackupState" ->
      Some InvalidDBInstanceAutomatedBackupState
  | "InvalidDBInstanceState" -> Some InvalidDBInstanceState
  | "InvalidDBParameterGroupState" -> Some InvalidDBParameterGroupState
  | "InvalidDBProxyStateFault" -> Some InvalidDBProxyStateFault
  | "InvalidDBSecurityGroupState" -> Some InvalidDBSecurityGroupState
  | "InvalidDBSnapshotState" -> Some InvalidDBSnapshotState
  | "InvalidDBSubnetGroupFault" -> Some InvalidDBSubnetGroupFault
  | "InvalidDBSubnetGroupStateFault" -> Some InvalidDBSubnetGroupStateFault
  | "InvalidDBSubnetStateFault" -> Some InvalidDBSubnetStateFault
  | "InvalidEventSubscriptionState" -> Some InvalidEventSubscriptionState
  | "InvalidGlobalClusterStateFault" -> Some InvalidGlobalClusterStateFault
  | "InvalidOptionGroupStateFault" -> Some InvalidOptionGroupStateFault
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "InvalidRestoreFault" -> Some InvalidRestoreFault
  | "InvalidS3BucketFault" -> Some InvalidS3BucketFault
  | "InvalidSubnet" -> Some InvalidSubnet
  | "InvalidVPCNetworkStateFault" -> Some InvalidVPCNetworkStateFault
  | "KMSKeyNotAccessibleFault" -> Some KMSKeyNotAccessibleFault
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "OptInRequired" -> Some OptInRequired
  | "OptionGroupAlreadyExistsFault" -> Some OptionGroupAlreadyExistsFault
  | "OptionGroupNotFoundFault" -> Some OptionGroupNotFoundFault
  | "OptionGroupQuotaExceededFault" -> Some OptionGroupQuotaExceededFault
  | "PendingVerification" -> Some PendingVerification
  | "PointInTimeRestoreNotEnabled" -> Some PointInTimeRestoreNotEnabled
  | "ProvisionedIopsNotAvailableInAZFault" ->
      Some ProvisionedIopsNotAvailableInAZFault
  | "QuotaExceeded.DBSecurityGroup" -> Some QuotaExceeded_DBSecurityGroup
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ReservedDBInstanceAlreadyExists" -> Some ReservedDBInstanceAlreadyExists
  | "ReservedDBInstanceNotFound" -> Some ReservedDBInstanceNotFound
  | "ReservedDBInstanceQuotaExceeded" -> Some ReservedDBInstanceQuotaExceeded
  | "ReservedDBInstancesOfferingNotFound" ->
      Some ReservedDBInstancesOfferingNotFound
  | "ResourceNotFoundFault" -> Some ResourceNotFoundFault
  | "SNSInvalidTopic" -> Some SNSInvalidTopic
  | "SNSNoAuthorization" -> Some SNSNoAuthorization
  | "SNSTopicArnNotFound" -> Some SNSTopicArnNotFound
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "SharedSnapshotQuotaExceeded" -> Some SharedSnapshotQuotaExceeded
  | "SnapshotQuotaExceeded" -> Some SnapshotQuotaExceeded
  | "SourceNotFound" -> Some SourceNotFound
  | "StorageQuotaExceeded" -> Some StorageQuotaExceeded
  | "StorageTypeNotSupported" -> Some StorageTypeNotSupported
  | "SubnetAlreadyInUse" -> Some SubnetAlreadyInUse
  | "SubscriptionAlreadyExist" -> Some SubscriptionAlreadyExist
  | "SubscriptionCategoryNotFound" -> Some SubscriptionCategoryNotFound
  | "SubscriptionNotFound" -> Some SubscriptionNotFound
  | "Throttling" -> Some Throttling
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None