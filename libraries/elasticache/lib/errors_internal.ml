type t =
  | APICallRateForCustomerExceeded
  [@ocaml.doc
    "<p>The customer has exceeded the allowed rate of API calls.</p>"]
  | AuthFailure 
  | AuthorizationAlreadyExists
  [@ocaml.doc
    "<p>The specified Amazon EC2 security group is already authorized for the specified cache security group.</p>"]
  | AuthorizationNotFound
  [@ocaml.doc
    "<p>The specified Amazon EC2 security group is not authorized for the specified cache security group.</p>"]
  | Blocked 
  | CacheClusterAlreadyExists
  [@ocaml.doc "<p>You already have a cluster with the given identifier.</p>"]
  | CacheClusterNotFound
  [@ocaml.doc
    "<p>The requested cluster ID does not refer to an existing cluster.</p>"]
  | CacheParameterGroupAlreadyExists
  [@ocaml.doc
    "<p>A cache parameter group with the requested name already exists.</p>"]
  | CacheParameterGroupNotFound
  [@ocaml.doc
    "<p>The requested cache parameter group name does not refer to an existing cache parameter group.</p>"]
  | CacheParameterGroupQuotaExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the maximum number of cache security groups.</p>"]
  | CacheSecurityGroupAlreadyExists
  [@ocaml.doc
    "<p>A cache security group with the specified name already exists.</p>"]
  | CacheSecurityGroupNotFound
  [@ocaml.doc
    "<p>The requested cache security group name does not refer to an existing cache security group.</p>"]
  | CacheSubnetGroupAlreadyExists
  [@ocaml.doc
    "<p>The requested cache subnet group name is already in use by an existing cache subnet group.</p>"]
  | CacheSubnetGroupInUse
  [@ocaml.doc "<p>The requested cache subnet group is currently in use.</p>"]
  | CacheSubnetGroupNotFoundFault
  [@ocaml.doc
    "<p>The requested cache subnet group name does not refer to an existing cache subnet group.</p>"]
  | CacheSubnetGroupQuotaExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the allowed number of cache subnet groups.</p>"]
  | CacheSubnetQuotaExceededFault
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the allowed number of subnets in a cache subnet group.</p>"]
  | ClusterQuotaForCustomerExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the allowed number of clusters per customer.</p>"]
  | DryRunOperation 
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InsufficientCacheClusterCapacity
  [@ocaml.doc
    "<p>The requested cache node type is not available in the specified Availability Zone. For more information, see <a href=\"http://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/ErrorMessages.html#ErrorMessages.INSUFFICIENT_CACHE_CLUSTER_CAPACITY\">InsufficientCacheClusterCapacity</a> in the ElastiCache User Guide.</p>"]
  | InternalFailure 
  | InvalidARN
  [@ocaml.doc
    "<p>The requested Amazon Resource Name (ARN) does not refer to an existing resource.</p>"]
  | InvalidAction 
  | InvalidCacheClusterState
  [@ocaml.doc
    "<p>The requested cluster is not in the <code>available</code> state.</p>"]
  | InvalidCacheParameterGroupState
  [@ocaml.doc
    "<p>The current state of the cache parameter group does not allow the requested operation to occur.</p>"]
  | InvalidCacheSecurityGroupState
  [@ocaml.doc
    "<p>The current state of the cache security group does not allow deletion.</p>"]
  | InvalidClientTokenId 
  | InvalidKMSKeyFault
  [@ocaml.doc "<p>The KMS key supplied is not valid.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination
  [@ocaml.doc "<p>Two or more incompatible parameters were specified.</p>"]
  | InvalidParameterValue
  [@ocaml.doc "<p>The value for a parameter is invalid.</p>"]
  | InvalidQueryParameter 
  | InvalidReplicationGroupState
  [@ocaml.doc
    "<p>The requested replication group is not in the <code>available</code> state.</p>"]
  | InvalidSnapshotState
  [@ocaml.doc
    "<p>The current state of the snapshot does not allow the requested operation to occur.</p>"]
  | InvalidSubnet
  [@ocaml.doc "<p>An invalid subnet identifier was specified.</p>"]
  | InvalidVPCNetworkStateFault
  [@ocaml.doc "<p>The VPC network is in an invalid state.</p>"]
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | NoOperationFault
  [@ocaml.doc
    "<p>The operation was not performed because no changes were required.</p>"]
  | NodeGroupNotFoundFault
  [@ocaml.doc
    "<p>The node group specified by the <code>NodeGroupId</code> parameter could not be found. Please verify that the node group exists and that you spelled the <code>NodeGroupId</code> value correctly.</p>"]
  | NodeGroupsPerReplicationGroupQuotaExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the maximum allowed number of node groups (shards) in a single replication group. The default maximum is 90</p>"]
  | NodeQuotaForClusterExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the allowed number of cache nodes in a single cluster.</p>"]
  | NodeQuotaForCustomerExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the allowed number of cache nodes per customer.</p>"]
  | OptInRequired 
  | PendingVerification 
  | QuotaExceeded_CacheSecurityGroup
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the allowed number of cache security groups.</p>"]
  | ReplicationGroupAlreadyExists
  [@ocaml.doc "<p>The specified replication group already exists.</p>"]
  | ReplicationGroupAlreadyUnderMigrationFault
  [@ocaml.doc "<p>The targeted replication group is not available. </p>"]
  | ReplicationGroupNotFoundFault
  [@ocaml.doc "<p>The specified replication group does not exist.</p>"]
  | ReplicationGroupNotUnderMigrationFault
  [@ocaml.doc
    "<p>The designated replication group is not available for data migration.</p>"]
  | RequestExpired 
  | RequestLimitExceeded 
  | ReservedCacheNodeAlreadyExists
  [@ocaml.doc
    "<p>You already have a reservation with the given identifier.</p>"]
  | ReservedCacheNodeNotFound
  [@ocaml.doc "<p>The requested reserved cache node was not found.</p>"]
  | ReservedCacheNodeQuotaExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the user's cache node quota.</p>"]
  | ReservedCacheNodesOfferingNotFound
  [@ocaml.doc "<p>The requested cache node offering does not exist.</p>"]
  | ServiceLinkedRoleNotFoundFault
  [@ocaml.doc
    "<p>The specified service linked role (SLR) was not found.</p>"]
  | ServiceUnavailable 
  | ServiceUpdateNotFoundFault
  [@ocaml.doc "<p>The service update doesn't exist</p>"]
  | SnapshotAlreadyExistsFault
  [@ocaml.doc "<p>You already have a snapshot with the given name.</p>"]
  | SnapshotFeatureNotSupportedFault
  [@ocaml.doc
    "<p>You attempted one of the following operations:</p> <ul> <li> <p>Creating a snapshot of a Redis cluster running on a <code>cache.t1.micro</code> cache node.</p> </li> <li> <p>Creating a snapshot of a cluster that is running Memcached rather than Redis.</p> </li> </ul> <p>Neither of these are supported by ElastiCache.</p>"]
  | SnapshotNotFoundFault
  [@ocaml.doc
    "<p>The requested snapshot name does not refer to an existing snapshot.</p>"]
  | SnapshotQuotaExceededFault
  [@ocaml.doc
    "<p>The request cannot be processed because it would exceed the maximum number of snapshots.</p>"]
  | SubnetInUse
  [@ocaml.doc
    "<p>The requested subnet is being used by another cache subnet group.</p>"]
  | TagNotFound
  [@ocaml.doc "<p>The requested tag was not found on this resource.</p>"]
  | TagQuotaPerResourceExceeded
  [@ocaml.doc
    "<p>The request cannot be processed because it would cause the resource to have more than the allowed number of tags. The maximum number of tags permitted on a resource is 50.</p>"]
  | TestFailoverNotAvailableFault
  [@ocaml.doc
    "<p>The <code>TestFailover</code> action is not available.</p>"]
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
  | APICallRateForCustomerExceeded -> Some 400
  | AuthFailure -> None
  | AuthorizationAlreadyExists -> Some 400
  | AuthorizationNotFound -> Some 404
  | Blocked -> None
  | CacheClusterAlreadyExists -> Some 400
  | CacheClusterNotFound -> Some 404
  | CacheParameterGroupAlreadyExists -> Some 400
  | CacheParameterGroupNotFound -> Some 404
  | CacheParameterGroupQuotaExceeded -> Some 400
  | CacheSecurityGroupAlreadyExists -> Some 400
  | CacheSecurityGroupNotFound -> Some 404
  | CacheSubnetGroupAlreadyExists -> Some 400
  | CacheSubnetGroupInUse -> Some 400
  | CacheSubnetGroupNotFoundFault -> Some 400
  | CacheSubnetGroupQuotaExceeded -> Some 400
  | CacheSubnetQuotaExceededFault -> Some 400
  | ClusterQuotaForCustomerExceeded -> Some 400
  | DryRunOperation -> None
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InsufficientCacheClusterCapacity -> Some 400
  | InternalFailure -> Some 500
  | InvalidARN -> Some 400
  | InvalidAction -> Some 400
  | InvalidCacheClusterState -> Some 400
  | InvalidCacheParameterGroupState -> Some 400
  | InvalidCacheSecurityGroupState -> Some 400
  | InvalidClientTokenId -> Some 403
  | InvalidKMSKeyFault -> Some 400
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | InvalidReplicationGroupState -> Some 400
  | InvalidSnapshotState -> Some 400
  | InvalidSubnet -> Some 400
  | InvalidVPCNetworkStateFault -> Some 400
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | NoOperationFault -> Some 400
  | NodeGroupNotFoundFault -> Some 404
  | NodeGroupsPerReplicationGroupQuotaExceeded -> Some 400
  | NodeQuotaForClusterExceeded -> Some 400
  | NodeQuotaForCustomerExceeded -> Some 400
  | OptInRequired -> Some 403
  | PendingVerification -> None
  | QuotaExceeded_CacheSecurityGroup -> Some 400
  | ReplicationGroupAlreadyExists -> Some 400
  | ReplicationGroupAlreadyUnderMigrationFault -> Some 400
  | ReplicationGroupNotFoundFault -> Some 404
  | ReplicationGroupNotUnderMigrationFault -> Some 400
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ReservedCacheNodeAlreadyExists -> Some 404
  | ReservedCacheNodeNotFound -> Some 404
  | ReservedCacheNodeQuotaExceeded -> Some 400
  | ReservedCacheNodesOfferingNotFound -> Some 404
  | ServiceLinkedRoleNotFoundFault -> Some 400
  | ServiceUnavailable -> Some 503
  | ServiceUpdateNotFoundFault -> Some 404
  | SnapshotAlreadyExistsFault -> Some 400
  | SnapshotFeatureNotSupportedFault -> Some 400
  | SnapshotNotFoundFault -> Some 404
  | SnapshotQuotaExceededFault -> Some 400
  | SubnetInUse -> Some 400
  | TagNotFound -> Some 404
  | TagQuotaPerResourceExceeded -> Some 400
  | TestFailoverNotAvailableFault -> Some 400
  | Throttling -> Some 400
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | APICallRateForCustomerExceeded -> "APICallRateForCustomerExceeded"
  | AuthFailure -> "AuthFailure"
  | AuthorizationAlreadyExists -> "AuthorizationAlreadyExists"
  | AuthorizationNotFound -> "AuthorizationNotFound"
  | Blocked -> "Blocked"
  | CacheClusterAlreadyExists -> "CacheClusterAlreadyExists"
  | CacheClusterNotFound -> "CacheClusterNotFound"
  | CacheParameterGroupAlreadyExists -> "CacheParameterGroupAlreadyExists"
  | CacheParameterGroupNotFound -> "CacheParameterGroupNotFound"
  | CacheParameterGroupQuotaExceeded -> "CacheParameterGroupQuotaExceeded"
  | CacheSecurityGroupAlreadyExists -> "CacheSecurityGroupAlreadyExists"
  | CacheSecurityGroupNotFound -> "CacheSecurityGroupNotFound"
  | CacheSubnetGroupAlreadyExists -> "CacheSubnetGroupAlreadyExists"
  | CacheSubnetGroupInUse -> "CacheSubnetGroupInUse"
  | CacheSubnetGroupNotFoundFault -> "CacheSubnetGroupNotFoundFault"
  | CacheSubnetGroupQuotaExceeded -> "CacheSubnetGroupQuotaExceeded"
  | CacheSubnetQuotaExceededFault -> "CacheSubnetQuotaExceededFault"
  | ClusterQuotaForCustomerExceeded -> "ClusterQuotaForCustomerExceeded"
  | DryRunOperation -> "DryRunOperation"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InsufficientCacheClusterCapacity -> "InsufficientCacheClusterCapacity"
  | InternalFailure -> "InternalFailure"
  | InvalidARN -> "InvalidARN"
  | InvalidAction -> "InvalidAction"
  | InvalidCacheClusterState -> "InvalidCacheClusterState"
  | InvalidCacheParameterGroupState -> "InvalidCacheParameterGroupState"
  | InvalidCacheSecurityGroupState -> "InvalidCacheSecurityGroupState"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidKMSKeyFault -> "InvalidKMSKeyFault"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | InvalidReplicationGroupState -> "InvalidReplicationGroupState"
  | InvalidSnapshotState -> "InvalidSnapshotState"
  | InvalidSubnet -> "InvalidSubnet"
  | InvalidVPCNetworkStateFault -> "InvalidVPCNetworkStateFault"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | NoOperationFault -> "NoOperationFault"
  | NodeGroupNotFoundFault -> "NodeGroupNotFoundFault"
  | NodeGroupsPerReplicationGroupQuotaExceeded ->
      "NodeGroupsPerReplicationGroupQuotaExceeded"
  | NodeQuotaForClusterExceeded -> "NodeQuotaForClusterExceeded"
  | NodeQuotaForCustomerExceeded -> "NodeQuotaForCustomerExceeded"
  | OptInRequired -> "OptInRequired"
  | PendingVerification -> "PendingVerification"
  | QuotaExceeded_CacheSecurityGroup -> "QuotaExceeded.CacheSecurityGroup"
  | ReplicationGroupAlreadyExists -> "ReplicationGroupAlreadyExists"
  | ReplicationGroupAlreadyUnderMigrationFault ->
      "ReplicationGroupAlreadyUnderMigrationFault"
  | ReplicationGroupNotFoundFault -> "ReplicationGroupNotFoundFault"
  | ReplicationGroupNotUnderMigrationFault ->
      "ReplicationGroupNotUnderMigrationFault"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ReservedCacheNodeAlreadyExists -> "ReservedCacheNodeAlreadyExists"
  | ReservedCacheNodeNotFound -> "ReservedCacheNodeNotFound"
  | ReservedCacheNodeQuotaExceeded -> "ReservedCacheNodeQuotaExceeded"
  | ReservedCacheNodesOfferingNotFound ->
      "ReservedCacheNodesOfferingNotFound"
  | ServiceLinkedRoleNotFoundFault -> "ServiceLinkedRoleNotFoundFault"
  | ServiceUnavailable -> "ServiceUnavailable"
  | ServiceUpdateNotFoundFault -> "ServiceUpdateNotFoundFault"
  | SnapshotAlreadyExistsFault -> "SnapshotAlreadyExistsFault"
  | SnapshotFeatureNotSupportedFault -> "SnapshotFeatureNotSupportedFault"
  | SnapshotNotFoundFault -> "SnapshotNotFoundFault"
  | SnapshotQuotaExceededFault -> "SnapshotQuotaExceededFault"
  | SubnetInUse -> "SubnetInUse"
  | TagNotFound -> "TagNotFound"
  | TagQuotaPerResourceExceeded -> "TagQuotaPerResourceExceeded"
  | TestFailoverNotAvailableFault -> "TestFailoverNotAvailableFault"
  | Throttling -> "Throttling"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "APICallRateForCustomerExceeded" -> Some APICallRateForCustomerExceeded
  | "AuthFailure" -> Some AuthFailure
  | "AuthorizationAlreadyExists" -> Some AuthorizationAlreadyExists
  | "AuthorizationNotFound" -> Some AuthorizationNotFound
  | "Blocked" -> Some Blocked
  | "CacheClusterAlreadyExists" -> Some CacheClusterAlreadyExists
  | "CacheClusterNotFound" -> Some CacheClusterNotFound
  | "CacheParameterGroupAlreadyExists" ->
      Some CacheParameterGroupAlreadyExists
  | "CacheParameterGroupNotFound" -> Some CacheParameterGroupNotFound
  | "CacheParameterGroupQuotaExceeded" ->
      Some CacheParameterGroupQuotaExceeded
  | "CacheSecurityGroupAlreadyExists" -> Some CacheSecurityGroupAlreadyExists
  | "CacheSecurityGroupNotFound" -> Some CacheSecurityGroupNotFound
  | "CacheSubnetGroupAlreadyExists" -> Some CacheSubnetGroupAlreadyExists
  | "CacheSubnetGroupInUse" -> Some CacheSubnetGroupInUse
  | "CacheSubnetGroupNotFoundFault" -> Some CacheSubnetGroupNotFoundFault
  | "CacheSubnetGroupQuotaExceeded" -> Some CacheSubnetGroupQuotaExceeded
  | "CacheSubnetQuotaExceededFault" -> Some CacheSubnetQuotaExceededFault
  | "ClusterQuotaForCustomerExceeded" -> Some ClusterQuotaForCustomerExceeded
  | "DryRunOperation" -> Some DryRunOperation
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InsufficientCacheClusterCapacity" ->
      Some InsufficientCacheClusterCapacity
  | "InternalFailure" -> Some InternalFailure
  | "InvalidARN" -> Some InvalidARN
  | "InvalidAction" -> Some InvalidAction
  | "InvalidCacheClusterState" -> Some InvalidCacheClusterState
  | "InvalidCacheParameterGroupState" -> Some InvalidCacheParameterGroupState
  | "InvalidCacheSecurityGroupState" -> Some InvalidCacheSecurityGroupState
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidKMSKeyFault" -> Some InvalidKMSKeyFault
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "InvalidReplicationGroupState" -> Some InvalidReplicationGroupState
  | "InvalidSnapshotState" -> Some InvalidSnapshotState
  | "InvalidSubnet" -> Some InvalidSubnet
  | "InvalidVPCNetworkStateFault" -> Some InvalidVPCNetworkStateFault
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "NoOperationFault" -> Some NoOperationFault
  | "NodeGroupNotFoundFault" -> Some NodeGroupNotFoundFault
  | "NodeGroupsPerReplicationGroupQuotaExceeded" ->
      Some NodeGroupsPerReplicationGroupQuotaExceeded
  | "NodeQuotaForClusterExceeded" -> Some NodeQuotaForClusterExceeded
  | "NodeQuotaForCustomerExceeded" -> Some NodeQuotaForCustomerExceeded
  | "OptInRequired" -> Some OptInRequired
  | "PendingVerification" -> Some PendingVerification
  | "QuotaExceeded.CacheSecurityGroup" ->
      Some QuotaExceeded_CacheSecurityGroup
  | "ReplicationGroupAlreadyExists" -> Some ReplicationGroupAlreadyExists
  | "ReplicationGroupAlreadyUnderMigrationFault" ->
      Some ReplicationGroupAlreadyUnderMigrationFault
  | "ReplicationGroupNotFoundFault" -> Some ReplicationGroupNotFoundFault
  | "ReplicationGroupNotUnderMigrationFault" ->
      Some ReplicationGroupNotUnderMigrationFault
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ReservedCacheNodeAlreadyExists" -> Some ReservedCacheNodeAlreadyExists
  | "ReservedCacheNodeNotFound" -> Some ReservedCacheNodeNotFound
  | "ReservedCacheNodeQuotaExceeded" -> Some ReservedCacheNodeQuotaExceeded
  | "ReservedCacheNodesOfferingNotFound" ->
      Some ReservedCacheNodesOfferingNotFound
  | "ServiceLinkedRoleNotFoundFault" -> Some ServiceLinkedRoleNotFoundFault
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "ServiceUpdateNotFoundFault" -> Some ServiceUpdateNotFoundFault
  | "SnapshotAlreadyExistsFault" -> Some SnapshotAlreadyExistsFault
  | "SnapshotFeatureNotSupportedFault" ->
      Some SnapshotFeatureNotSupportedFault
  | "SnapshotNotFoundFault" -> Some SnapshotNotFoundFault
  | "SnapshotQuotaExceededFault" -> Some SnapshotQuotaExceededFault
  | "SubnetInUse" -> Some SubnetInUse
  | "TagNotFound" -> Some TagNotFound
  | "TagQuotaPerResourceExceeded" -> Some TagQuotaPerResourceExceeded
  | "TestFailoverNotAvailableFault" -> Some TestFailoverNotAvailableFault
  | "Throttling" -> Some Throttling
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None