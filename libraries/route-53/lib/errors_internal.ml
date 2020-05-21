type t =
  | AuthFailure 
  | Blocked 
  | ConcurrentModification
  [@ocaml.doc
    "<p>Another user submitted a request to create, update, or delete the object at the same time that you did. Retry the request. </p>"]
  | ConflictingDomainExists
  [@ocaml.doc
    "<p>The cause of this error depends on whether you're trying to create a public or a private hosted zone:</p> <ul> <li> <p> <b>Public hosted zone:</b> Two hosted zones that have the same name or that have a parent/child relationship (example.com and test.example.com) can't have any common name servers. You tried to create a hosted zone that has the same name as an existing hosted zone or that's the parent or child of an existing hosted zone, and you specified a delegation set that shares one or more name servers with the existing hosted zone. For more information, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateReusableDelegationSet.html\">CreateReusableDelegationSet</a>.</p> </li> <li> <p> <b>Private hosted zone:</b> You specified an Amazon VPC that you're already using for another hosted zone, and the domain that you specified for one of the hosted zones is a subdomain of the domain that you specified for the other hosted zone. For example, you can't use the same Amazon VPC for the hosted zones for example.com and test.example.com.</p> </li> </ul>"]
  | ConflictingTypes
  [@ocaml.doc
    "<p>You tried to update a traffic policy instance by using a traffic policy version that has a different DNS type than the current type for the instance. You specified the type in the JSON document in the <code>CreateTrafficPolicy</code> or <code>CreateTrafficPolicyVersion</code>request. </p>"]
  | DelegationSetAlreadyCreated
  [@ocaml.doc
    "<p>A delegation set with the same owner and caller reference combination has already been created.</p>"]
  | DelegationSetAlreadyReusable
  [@ocaml.doc
    "<p>The specified delegation set has already been marked as reusable.</p>"]
  | DelegationSetInUse
  [@ocaml.doc
    "<p>The specified delegation contains associated hosted zones which must be deleted before the reusable delegation set can be deleted.</p>"]
  | DelegationSetNotAvailable
  [@ocaml.doc
    "<p>You can create a hosted zone that has the same name as an existing hosted zone (example.com is common), but there is a limit to the number of hosted zones that have the same name. If you get this error, Amazon Route 53 has reached that limit. If you own the domain name and Route 53 generates this error, contact Customer Support.</p>"]
  | DelegationSetNotReusable
  [@ocaml.doc
    "<p>A reusable delegation set with the specified ID does not exist.</p>"]
  | DryRunOperation 
  | HealthCheckAlreadyExists
  [@ocaml.doc
    "<p> The health check you're attempting to create already exists. Amazon Route 53 returns this error when you submit a request that has the following values:</p> <ul> <li> <p>The same value for <code>CallerReference</code> as an existing health check, and one or more values that differ from the existing health check that has the same caller reference.</p> </li> <li> <p>The same value for <code>CallerReference</code> as a health check that you created and later deleted, regardless of the other settings in the request.</p> </li> </ul>"]
  | HealthCheckInUse [@ocaml.doc "<p>This error code is not in use.</p>"]
  | HealthCheckVersionMismatch
  [@ocaml.doc
    "<p>The value of <code>HealthCheckVersion</code> in the request doesn't match the value of <code>HealthCheckVersion</code> in the health check.</p>"]
  | HostedZoneAlreadyExists
  [@ocaml.doc
    "<p>The hosted zone you're trying to create already exists. Amazon Route 53 returns this error when a hosted zone has already been created with the specified <code>CallerReference</code>.</p>"]
  | HostedZoneNotEmpty
  [@ocaml.doc
    "<p>The hosted zone contains resource records that are not SOA or NS records.</p>"]
  | HostedZoneNotFound
  [@ocaml.doc "<p>The specified HostedZone can't be found.</p>"]
  | HostedZoneNotPrivate
  [@ocaml.doc
    "<p>The specified hosted zone is a public hosted zone, not a private hosted zone.</p>"]
  | IdempotentParameterMismatch 
  | IncompatibleVersion
  [@ocaml.doc
    "<p>The resource you're trying to access is unsupported on this Amazon Route 53 endpoint.</p>"]
  | IncompleteSignature 
  | InsufficientCloudWatchLogsResourcePolicy
  [@ocaml.doc
    "<p>Amazon Route 53 doesn't have the permissions required to create log streams and send query logs to log streams. Possible causes include the following:</p> <ul> <li> <p>There is no resource policy that specifies the log group ARN in the value for <code>Resource</code>.</p> </li> <li> <p>The resource policy that includes the log group ARN in the value for <code>Resource</code> doesn't have the necessary permissions.</p> </li> <li> <p>The resource policy hasn't finished propagating yet.</p> </li> </ul>"]
  | InternalFailure 
  | InvalidAction 
  | InvalidArgument [@ocaml.doc "<p>Parameter name is invalid.</p>"]
  | InvalidChangeBatch
  [@ocaml.doc
    "<p>This exception contains a list of messages that might contain one or more error messages. Each error message indicates one error in the change batch.</p>"]
  | InvalidClientTokenId 
  | InvalidDomainName
  [@ocaml.doc "<p>The specified domain name is not valid.</p>"]
  | InvalidInput [@ocaml.doc "<p>The input is not valid.</p>"]
  | InvalidPaginationToken
  [@ocaml.doc
    "<p>The value that you specified to get the second or subsequent page of results is invalid.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterValue 
  | InvalidQueryParameter 
  | InvalidTrafficPolicyDocument
  [@ocaml.doc
    "<p>The format of the traffic policy document that you specified in the <code>Document</code> element is invalid.</p>"]
  | InvalidVPCId
  [@ocaml.doc
    "<p>The VPC ID that you specified either isn't a valid ID or the current account is not authorized to access this VPC.</p>"]
  | LastVPCAssociation
  [@ocaml.doc
    "<p>The VPC that you're trying to disassociate from the private hosted zone is the last VPC that is associated with the hosted zone. Amazon Route 53 doesn't support disassociating the last VPC from a hosted zone.</p>"]
  | LimitsExceeded
  [@ocaml.doc
    "<p>This operation can't be completed either because the current account has reached the limit on reusable delegation sets that it can create or because you've reached the limit on the number of Amazon VPCs that you can associate with a private hosted zone. To get the current limit on the number of reusable delegation sets, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetAccountLimit.html\">GetAccountLimit</a>. To get the current limit on the number of Amazon VPCs that you can associate with a private hosted zone, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetHostedZoneLimit.html\">GetHostedZoneLimit</a>. To request a higher limit, <a href=\"http://aws.amazon.com/route53-request\">create a case</a> with the AWS Support Center.</p>"]
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | NoSuchChange
  [@ocaml.doc "<p>A change with the specified change ID does not exist.</p>"]
  | NoSuchCloudWatchLogsLogGroup
  [@ocaml.doc
    "<p>There is no CloudWatch Logs log group with the specified ARN.</p>"]
  | NoSuchDelegationSet
  [@ocaml.doc
    "<p>A reusable delegation set with the specified ID does not exist.</p>"]
  | NoSuchGeoLocation
  [@ocaml.doc
    "<p>Amazon Route 53 doesn't support the specified geographic location.</p>"]
  | NoSuchHealthCheck
  [@ocaml.doc "<p>No health check exists with the specified ID.</p>"]
  | NoSuchHostedZone
  [@ocaml.doc "<p>No hosted zone exists with the ID that you specified.</p>"]
  | NoSuchQueryLoggingConfig
  [@ocaml.doc
    "<p>There is no DNS query logging configuration with the specified ID.</p>"]
  | NoSuchTrafficPolicy
  [@ocaml.doc "<p>No traffic policy exists with the specified ID.</p>"]
  | NoSuchTrafficPolicyInstance
  [@ocaml.doc
    "<p>No traffic policy instance exists with the specified ID.</p>"]
  | NotAuthorizedException
  [@ocaml.doc
    "<p>Associating the specified VPC with the specified hosted zone has not been authorized.</p>"]
  | OptInRequired 
  | PendingVerification 
  | PriorRequestNotComplete
  [@ocaml.doc
    "<p>If Amazon Route 53 can't process a request before the next request arrives, it will reject subsequent requests for the same hosted zone and return an <code>HTTP 400 error</code> (<code>Bad request</code>). If Route 53 returns this error repeatedly for the same request, we recommend that you wait, in intervals of increasing duration, before you try the request again.</p>"]
  | PublicZoneVPCAssociation
  [@ocaml.doc
    "<p>You're trying to associate a VPC with a public hosted zone. Amazon Route 53 doesn't support associating a VPC with a public hosted zone.</p>"]
  | QueryLoggingConfigAlreadyExists
  [@ocaml.doc
    "<p>You can create only one query logging configuration for a hosted zone, and a query logging configuration already exists for this hosted zone.</p>"]
  | RequestExpired 
  | RequestLimitExceeded 
  | ServiceUnavailable 
  | Throttling 
  | ThrottlingException
  [@ocaml.doc
    "<p>The limit on the number of requests per second was exceeded.</p>"]
  | TooManyHealthChecks
  [@ocaml.doc
    "<p>This health check can't be created because the current account has reached the limit on the number of active health checks.</p> <p>For information about default limits, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html\">Limits</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>For information about how to get the current limit for an account, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetAccountLimit.html\">GetAccountLimit</a>. To request a higher limit, <a href=\"http://aws.amazon.com/route53-request\">create a case</a> with the AWS Support Center.</p> <p>You have reached the maximum number of active health checks for an AWS account. To request a higher limit, <a href=\"http://aws.amazon.com/route53-request\">create a case</a> with the AWS Support Center.</p>"]
  | TooManyHostedZones
  [@ocaml.doc
    "<p>This operation can't be completed either because the current account has reached the limit on the number of hosted zones or because you've reached the limit on the number of hosted zones that can be associated with a reusable delegation set.</p> <p>For information about default limits, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html\">Limits</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>To get the current limit on hosted zones that can be created by an account, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetAccountLimit.html\">GetAccountLimit</a>.</p> <p>To get the current limit on hosted zones that can be associated with a reusable delegation set, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetReusableDelegationSetLimit.html\">GetReusableDelegationSetLimit</a>.</p> <p>To request a higher limit, <a href=\"http://aws.amazon.com/route53-request\">create a case</a> with the AWS Support Center.</p>"]
  | TooManyTrafficPolicies
  [@ocaml.doc
    "<p>This traffic policy can't be created because the current account has reached the limit on the number of traffic policies.</p> <p>For information about default limits, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html\">Limits</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>To get the current limit for an account, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetAccountLimit.html\">GetAccountLimit</a>. </p> <p>To request a higher limit, <a href=\"http://aws.amazon.com/route53-request\">create a case</a> with the AWS Support Center.</p>"]
  | TooManyTrafficPolicyInstances
  [@ocaml.doc
    "<p>This traffic policy instance can't be created because the current account has reached the limit on the number of traffic policy instances.</p> <p>For information about default limits, see <a href=\"https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html\">Limits</a> in the <i>Amazon Route 53 Developer Guide</i>.</p> <p>For information about how to get the current limit for an account, see <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetAccountLimit.html\">GetAccountLimit</a>.</p> <p>To request a higher limit, <a href=\"http://aws.amazon.com/route53-request\">create a case</a> with the AWS Support Center.</p>"]
  | TooManyTrafficPolicyVersionsForCurrentPolicy
  [@ocaml.doc
    "<p>This traffic policy version can't be created because you've reached the limit of 1000 on the number of versions that you can create for the current traffic policy.</p> <p>To create more traffic policy versions, you can use <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_GetTrafficPolicy.html\">GetTrafficPolicy</a> to get the traffic policy document for a specified traffic policy version, and then use <a href=\"https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateTrafficPolicy.html\">CreateTrafficPolicy</a> to create a new traffic policy using the traffic policy document.</p>"]
  | TooManyVPCAssociationAuthorizations
  [@ocaml.doc
    "<p>You've created the maximum number of authorizations that can be created for the specified hosted zone. To authorize another VPC to be associated with the hosted zone, submit a <code>DeleteVPCAssociationAuthorization</code> request to remove an existing authorization. To get a list of existing authorizations, submit a <code>ListVPCAssociationAuthorizations</code> request.</p>"]
  | TrafficPolicyAlreadyExists
  [@ocaml.doc
    "<p>A traffic policy that has the same value for <code>Name</code> already exists.</p>"]
  | TrafficPolicyInUse
  [@ocaml.doc
    "<p>One or more traffic policy instances were created by using the specified traffic policy.</p>"]
  | TrafficPolicyInstanceAlreadyExists
  [@ocaml.doc
    "<p>There is already a traffic policy instance with the specified ID.</p>"]
  | UnauthorizedOperation 
  | UnknownParameter 
  | UnsupportedProtocol 
  | VPCAssociationAuthorizationNotFound
  [@ocaml.doc
    "<p>The VPC that you specified is not authorized to be associated with the hosted zone.</p>"]
  | VPCAssociationNotFound
  [@ocaml.doc
    "<p>The specified VPC and hosted zone are not currently associated.</p>"]
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
  | Blocked -> None
  | ConcurrentModification -> Some 400
  | ConflictingDomainExists -> None
  | ConflictingTypes -> Some 400
  | DelegationSetAlreadyCreated -> None
  | DelegationSetAlreadyReusable -> None
  | DelegationSetInUse -> None
  | DelegationSetNotAvailable -> None
  | DelegationSetNotReusable -> None
  | DryRunOperation -> None
  | HealthCheckAlreadyExists -> Some 409
  | HealthCheckInUse -> Some 400
  | HealthCheckVersionMismatch -> Some 409
  | HostedZoneAlreadyExists -> Some 409
  | HostedZoneNotEmpty -> Some 400
  | HostedZoneNotFound -> None
  | HostedZoneNotPrivate -> None
  | IdempotentParameterMismatch -> None
  | IncompatibleVersion -> Some 400
  | IncompleteSignature -> Some 400
  | InsufficientCloudWatchLogsResourcePolicy -> Some 400
  | InternalFailure -> Some 500
  | InvalidAction -> Some 400
  | InvalidArgument -> None
  | InvalidChangeBatch -> None
  | InvalidClientTokenId -> Some 403
  | InvalidDomainName -> Some 400
  | InvalidInput -> Some 400
  | InvalidPaginationToken -> Some 400
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | InvalidTrafficPolicyDocument -> Some 400
  | InvalidVPCId -> Some 400
  | LastVPCAssociation -> Some 400
  | LimitsExceeded -> None
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | NoSuchChange -> Some 404
  | NoSuchCloudWatchLogsLogGroup -> Some 404
  | NoSuchDelegationSet -> None
  | NoSuchGeoLocation -> Some 404
  | NoSuchHealthCheck -> Some 404
  | NoSuchHostedZone -> Some 404
  | NoSuchQueryLoggingConfig -> Some 404
  | NoSuchTrafficPolicy -> Some 404
  | NoSuchTrafficPolicyInstance -> Some 404
  | NotAuthorizedException -> Some 401
  | OptInRequired -> Some 403
  | PendingVerification -> None
  | PriorRequestNotComplete -> Some 400
  | PublicZoneVPCAssociation -> Some 400
  | QueryLoggingConfigAlreadyExists -> Some 409
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ServiceUnavailable -> Some 503
  | Throttling -> Some 400
  | ThrottlingException -> Some 400
  | TooManyHealthChecks -> None
  | TooManyHostedZones -> Some 400
  | TooManyTrafficPolicies -> Some 400
  | TooManyTrafficPolicyInstances -> Some 400
  | TooManyTrafficPolicyVersionsForCurrentPolicy -> Some 400
  | TooManyVPCAssociationAuthorizations -> Some 400
  | TrafficPolicyAlreadyExists -> Some 409
  | TrafficPolicyInUse -> Some 400
  | TrafficPolicyInstanceAlreadyExists -> Some 409
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedProtocol -> None
  | VPCAssociationAuthorizationNotFound -> Some 404
  | VPCAssociationNotFound -> Some 404
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AuthFailure -> "AuthFailure"
  | Blocked -> "Blocked"
  | ConcurrentModification -> "ConcurrentModification"
  | ConflictingDomainExists -> "ConflictingDomainExists"
  | ConflictingTypes -> "ConflictingTypes"
  | DelegationSetAlreadyCreated -> "DelegationSetAlreadyCreated"
  | DelegationSetAlreadyReusable -> "DelegationSetAlreadyReusable"
  | DelegationSetInUse -> "DelegationSetInUse"
  | DelegationSetNotAvailable -> "DelegationSetNotAvailable"
  | DelegationSetNotReusable -> "DelegationSetNotReusable"
  | DryRunOperation -> "DryRunOperation"
  | HealthCheckAlreadyExists -> "HealthCheckAlreadyExists"
  | HealthCheckInUse -> "HealthCheckInUse"
  | HealthCheckVersionMismatch -> "HealthCheckVersionMismatch"
  | HostedZoneAlreadyExists -> "HostedZoneAlreadyExists"
  | HostedZoneNotEmpty -> "HostedZoneNotEmpty"
  | HostedZoneNotFound -> "HostedZoneNotFound"
  | HostedZoneNotPrivate -> "HostedZoneNotPrivate"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompatibleVersion -> "IncompatibleVersion"
  | IncompleteSignature -> "IncompleteSignature"
  | InsufficientCloudWatchLogsResourcePolicy ->
      "InsufficientCloudWatchLogsResourcePolicy"
  | InternalFailure -> "InternalFailure"
  | InvalidAction -> "InvalidAction"
  | InvalidArgument -> "InvalidArgument"
  | InvalidChangeBatch -> "InvalidChangeBatch"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidDomainName -> "InvalidDomainName"
  | InvalidInput -> "InvalidInput"
  | InvalidPaginationToken -> "InvalidPaginationToken"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | InvalidTrafficPolicyDocument -> "InvalidTrafficPolicyDocument"
  | InvalidVPCId -> "InvalidVPCId"
  | LastVPCAssociation -> "LastVPCAssociation"
  | LimitsExceeded -> "LimitsExceeded"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | NoSuchChange -> "NoSuchChange"
  | NoSuchCloudWatchLogsLogGroup -> "NoSuchCloudWatchLogsLogGroup"
  | NoSuchDelegationSet -> "NoSuchDelegationSet"
  | NoSuchGeoLocation -> "NoSuchGeoLocation"
  | NoSuchHealthCheck -> "NoSuchHealthCheck"
  | NoSuchHostedZone -> "NoSuchHostedZone"
  | NoSuchQueryLoggingConfig -> "NoSuchQueryLoggingConfig"
  | NoSuchTrafficPolicy -> "NoSuchTrafficPolicy"
  | NoSuchTrafficPolicyInstance -> "NoSuchTrafficPolicyInstance"
  | NotAuthorizedException -> "NotAuthorizedException"
  | OptInRequired -> "OptInRequired"
  | PendingVerification -> "PendingVerification"
  | PriorRequestNotComplete -> "PriorRequestNotComplete"
  | PublicZoneVPCAssociation -> "PublicZoneVPCAssociation"
  | QueryLoggingConfigAlreadyExists -> "QueryLoggingConfigAlreadyExists"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ServiceUnavailable -> "ServiceUnavailable"
  | Throttling -> "Throttling"
  | ThrottlingException -> "ThrottlingException"
  | TooManyHealthChecks -> "TooManyHealthChecks"
  | TooManyHostedZones -> "TooManyHostedZones"
  | TooManyTrafficPolicies -> "TooManyTrafficPolicies"
  | TooManyTrafficPolicyInstances -> "TooManyTrafficPolicyInstances"
  | TooManyTrafficPolicyVersionsForCurrentPolicy ->
      "TooManyTrafficPolicyVersionsForCurrentPolicy"
  | TooManyVPCAssociationAuthorizations ->
      "TooManyVPCAssociationAuthorizations"
  | TrafficPolicyAlreadyExists -> "TrafficPolicyAlreadyExists"
  | TrafficPolicyInUse -> "TrafficPolicyInUse"
  | TrafficPolicyInstanceAlreadyExists ->
      "TrafficPolicyInstanceAlreadyExists"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | VPCAssociationAuthorizationNotFound ->
      "VPCAssociationAuthorizationNotFound"
  | VPCAssociationNotFound -> "VPCAssociationNotFound"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AuthFailure" -> Some AuthFailure
  | "Blocked" -> Some Blocked
  | "ConcurrentModification" -> Some ConcurrentModification
  | "ConflictingDomainExists" -> Some ConflictingDomainExists
  | "ConflictingTypes" -> Some ConflictingTypes
  | "DelegationSetAlreadyCreated" -> Some DelegationSetAlreadyCreated
  | "DelegationSetAlreadyReusable" -> Some DelegationSetAlreadyReusable
  | "DelegationSetInUse" -> Some DelegationSetInUse
  | "DelegationSetNotAvailable" -> Some DelegationSetNotAvailable
  | "DelegationSetNotReusable" -> Some DelegationSetNotReusable
  | "DryRunOperation" -> Some DryRunOperation
  | "HealthCheckAlreadyExists" -> Some HealthCheckAlreadyExists
  | "HealthCheckInUse" -> Some HealthCheckInUse
  | "HealthCheckVersionMismatch" -> Some HealthCheckVersionMismatch
  | "HostedZoneAlreadyExists" -> Some HostedZoneAlreadyExists
  | "HostedZoneNotEmpty" -> Some HostedZoneNotEmpty
  | "HostedZoneNotFound" -> Some HostedZoneNotFound
  | "HostedZoneNotPrivate" -> Some HostedZoneNotPrivate
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompatibleVersion" -> Some IncompatibleVersion
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InsufficientCloudWatchLogsResourcePolicy" ->
      Some InsufficientCloudWatchLogsResourcePolicy
  | "InternalFailure" -> Some InternalFailure
  | "InvalidAction" -> Some InvalidAction
  | "InvalidArgument" -> Some InvalidArgument
  | "InvalidChangeBatch" -> Some InvalidChangeBatch
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidDomainName" -> Some InvalidDomainName
  | "InvalidInput" -> Some InvalidInput
  | "InvalidPaginationToken" -> Some InvalidPaginationToken
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "InvalidTrafficPolicyDocument" -> Some InvalidTrafficPolicyDocument
  | "InvalidVPCId" -> Some InvalidVPCId
  | "LastVPCAssociation" -> Some LastVPCAssociation
  | "LimitsExceeded" -> Some LimitsExceeded
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "NoSuchChange" -> Some NoSuchChange
  | "NoSuchCloudWatchLogsLogGroup" -> Some NoSuchCloudWatchLogsLogGroup
  | "NoSuchDelegationSet" -> Some NoSuchDelegationSet
  | "NoSuchGeoLocation" -> Some NoSuchGeoLocation
  | "NoSuchHealthCheck" -> Some NoSuchHealthCheck
  | "NoSuchHostedZone" -> Some NoSuchHostedZone
  | "NoSuchQueryLoggingConfig" -> Some NoSuchQueryLoggingConfig
  | "NoSuchTrafficPolicy" -> Some NoSuchTrafficPolicy
  | "NoSuchTrafficPolicyInstance" -> Some NoSuchTrafficPolicyInstance
  | "NotAuthorizedException" -> Some NotAuthorizedException
  | "OptInRequired" -> Some OptInRequired
  | "PendingVerification" -> Some PendingVerification
  | "PriorRequestNotComplete" -> Some PriorRequestNotComplete
  | "PublicZoneVPCAssociation" -> Some PublicZoneVPCAssociation
  | "QueryLoggingConfigAlreadyExists" -> Some QueryLoggingConfigAlreadyExists
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "Throttling" -> Some Throttling
  | "ThrottlingException" -> Some ThrottlingException
  | "TooManyHealthChecks" -> Some TooManyHealthChecks
  | "TooManyHostedZones" -> Some TooManyHostedZones
  | "TooManyTrafficPolicies" -> Some TooManyTrafficPolicies
  | "TooManyTrafficPolicyInstances" -> Some TooManyTrafficPolicyInstances
  | "TooManyTrafficPolicyVersionsForCurrentPolicy" ->
      Some TooManyTrafficPolicyVersionsForCurrentPolicy
  | "TooManyVPCAssociationAuthorizations" ->
      Some TooManyVPCAssociationAuthorizations
  | "TrafficPolicyAlreadyExists" -> Some TrafficPolicyAlreadyExists
  | "TrafficPolicyInUse" -> Some TrafficPolicyInUse
  | "TrafficPolicyInstanceAlreadyExists" ->
      Some TrafficPolicyInstanceAlreadyExists
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "VPCAssociationAuthorizationNotFound" ->
      Some VPCAssociationAuthorizationNotFound
  | "VPCAssociationNotFound" -> Some VPCAssociationNotFound
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None