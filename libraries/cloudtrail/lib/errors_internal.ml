type t =
  | AuthFailure 
  | Blocked 
  | CloudTrailARNInvalidException
  [@ocaml.doc
    "<p>This exception is thrown when an operation is called with an invalid trail ARN. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"]
  | CloudTrailAccessNotEnabledException
  [@ocaml.doc
    "<p>This exception is thrown when trusted access has not been enabled between AWS CloudTrail and AWS Organizations. For more information, see <a href=\"https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html\">Enabling Trusted Access with Other AWS Services</a> and <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/creating-an-organizational-trail-prepare.html\">Prepare For Creating a Trail For Your Organization</a>. </p>"]
  | CloudWatchLogsDeliveryUnavailableException
  [@ocaml.doc
    "<p>Cannot set a CloudWatch Logs delivery for this region.</p>"]
  | DryRunOperation 
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InsightNotEnabledException
  [@ocaml.doc
    "<p>If you run <code>GetInsightSelectors</code> on a trail that does not have Insights events enabled, the operation throws the exception <code>InsightNotEnabledException</code>.</p>"]
  | InsufficientDependencyServiceAccessPermissionException
  [@ocaml.doc
    "<p>This exception is thrown when the IAM user or role that is used to create the organization trail is lacking one or more required permissions for creating an organization trail in a required service. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/creating-an-organizational-trail-prepare.html\">Prepare For Creating a Trail For Your Organization</a>.</p>"]
  | InsufficientEncryptionPolicyException
  [@ocaml.doc
    "<p>This exception is thrown when the policy on the S3 bucket or KMS key is not sufficient.</p>"]
  | InsufficientS3BucketPolicyException
  [@ocaml.doc
    "<p>This exception is thrown when the policy on the S3 bucket is not sufficient.</p>"]
  | InsufficientSnsTopicPolicyException
  [@ocaml.doc
    "<p>This exception is thrown when the policy on the SNS topic is not sufficient.</p>"]
  | InternalFailure 
  | InvalidAction 
  | InvalidClientTokenId 
  | InvalidCloudWatchLogsLogGroupArnException
  [@ocaml.doc
    "<p>This exception is thrown when the provided CloudWatch log group is not valid.</p>"]
  | InvalidCloudWatchLogsRoleArnException
  [@ocaml.doc
    "<p>This exception is thrown when the provided role is not valid.</p>"]
  | InvalidEventCategoryException
  [@ocaml.doc
    "<p>Occurs if an event category that is not valid is specified as a value of <code>EventCategory</code>.</p>"]
  | InvalidEventSelectorsException
  [@ocaml.doc
    "<p>This exception is thrown when the <code>PutEventSelectors</code> operation is called with a number of event selectors or data resources that is not valid. The combination of event selectors and data resources is not valid. A trail can have up to 5 event selectors. A trail is limited to 250 data resources. These data resources can be distributed across event selectors, but the overall total cannot exceed 250.</p> <p>You can:</p> <ul> <li> <p>Specify a valid number of event selectors (1 to 5) for a trail.</p> </li> <li> <p>Specify a valid number of data resources (1 to 250) for an event selector. The limit of number of resources on an individual event selector is configurable up to 250. However, this upper limit is allowed only if the total number of data resources does not exceed 250 across all event selectors for a trail.</p> </li> <li> <p>Specify a valid value for a parameter. For example, specifying the <code>ReadWriteType</code> parameter with a value of <code>read-only</code> is invalid.</p> </li> </ul>"]
  | InvalidHomeRegionException
  [@ocaml.doc
    "<p>This exception is thrown when an operation is called on a trail from a region other than the region in which the trail was created.</p>"]
  | InvalidInsightSelectorsException
  [@ocaml.doc
    "<p>The formatting or syntax of the <code>InsightSelectors</code> JSON statement in your <code>PutInsightSelectors</code> or <code>GetInsightSelectors</code> request is not valid, or the specified insight type in the <code>InsightSelectors</code> statement is not a valid insight type.</p>"]
  | InvalidKmsKeyIdException
  [@ocaml.doc
    "<p>This exception is thrown when the KMS key ARN is invalid.</p>"]
  | InvalidLookupAttributesException
  [@ocaml.doc "<p>Occurs when an invalid lookup attribute is specified.</p>"]
  | InvalidMaxResultsException
  [@ocaml.doc
    "<p>This exception is thrown if the limit specified is invalid.</p>"]
  | InvalidNextTokenException
  [@ocaml.doc
    "<p>Invalid token or token that was previously used in a request with different parameters. This exception is thrown if the token is invalid.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterCombinationException
  [@ocaml.doc
    "<p>This exception is thrown when the combination of parameters provided is not valid.</p>"]
  | InvalidParameterValue 
  | InvalidQueryParameter 
  | InvalidS3BucketNameException
  [@ocaml.doc
    "<p>This exception is thrown when the provided S3 bucket name is not valid.</p>"]
  | InvalidS3PrefixException
  [@ocaml.doc
    "<p>This exception is thrown when the provided S3 prefix is not valid.</p>"]
  | InvalidSnsTopicNameException
  [@ocaml.doc
    "<p>This exception is thrown when the provided SNS topic name is not valid.</p>"]
  | InvalidTagParameterException
  [@ocaml.doc
    "<p>This exception is thrown when the specified tag key or values are not valid. It can also occur if there are duplicate tags or too many tags on the resource.</p>"]
  | InvalidTimeRangeException
  [@ocaml.doc
    "<p>Occurs if the timestamp values are invalid. Either the start time occurs after the end time or the time range is outside the range of possible values.</p>"]
  | InvalidTokenException [@ocaml.doc "<p>Reserved for future use.</p>"]
  | InvalidTrailNameException
  [@ocaml.doc
    "<p>This exception is thrown when the provided trail name is not valid. Trail names must meet the following requirements:</p> <ul> <li> <p>Contain only ASCII letters (a-z, A-Z), numbers (0-9), periods (.), underscores (_), or dashes (-)</p> </li> <li> <p>Start with a letter or number, and end with a letter or number</p> </li> <li> <p>Be between 3 and 128 characters</p> </li> <li> <p>Have no adjacent periods, underscores or dashes. Names like <code>my-_namespace</code> and <code>my--namespace</code> are invalid.</p> </li> <li> <p>Not be in IP address format (for example, 192.168.5.4)</p> </li> </ul>"]
  | KmsException
  [@ocaml.doc
    "<p>This exception is thrown when there is an issue with the specified KMS key and the trail can\226\128\153t be updated.</p>"]
  | KmsKeyDisabledException
  [@ocaml.doc "<p>This exception is no longer in use.</p>"]
  | KmsKeyNotFoundException
  [@ocaml.doc
    "<p>This exception is thrown when the KMS key does not exist, or when the S3 bucket and the KMS key are not in the same region.</p>"]
  | MalformedQueryString 
  | MaximumNumberOfTrailsExceededException
  [@ocaml.doc
    "<p>This exception is thrown when the maximum number of trails is reached.</p>"]
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | NotOrganizationMasterAccountException
  [@ocaml.doc
    "<p>This exception is thrown when the AWS account making the request to create or update an organization trail is not the master account for an organization in AWS Organizations. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/creating-an-organizational-trail-prepare.html\">Prepare For Creating a Trail For Your Organization</a>.</p>"]
  | OperationNotPermittedException
  [@ocaml.doc
    "<p>This exception is thrown when the requested operation is not permitted.</p>"]
  | OptInRequired 
  | OrganizationNotInAllFeaturesModeException
  [@ocaml.doc
    "<p>This exception is thrown when AWS Organizations is not configured to support all features. All features must be enabled in AWS Organization to support creating an organization trail. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/creating-an-organizational-trail-prepare.html\">Prepare For Creating a Trail For Your Organization</a>.</p>"]
  | OrganizationsNotInUseException
  [@ocaml.doc
    "<p>This exception is thrown when the request is made from an AWS account that is not a member of an organization. To make this request, sign in using the credentials of an account that belongs to an organization.</p>"]
  | PendingVerification 
  | RequestExpired 
  | RequestLimitExceeded 
  | ResourceNotFoundException
  [@ocaml.doc
    "<p>This exception is thrown when the specified resource is not found.</p>"]
  | ResourceTypeNotSupportedException
  [@ocaml.doc
    "<p>This exception is thrown when the specified resource type is not supported by CloudTrail.</p>"]
  | S3BucketDoesNotExistException
  [@ocaml.doc
    "<p>This exception is thrown when the specified S3 bucket does not exist.</p>"]
  | ServiceUnavailable 
  | TagsLimitExceededException
  [@ocaml.doc
    "<p>The number of tags per trail has exceeded the permitted amount. Currently, the limit is 50.</p>"]
  | Throttling 
  | TrailAlreadyExistsException
  [@ocaml.doc
    "<p>This exception is thrown when the specified trail already exists.</p>"]
  | TrailNotFoundException
  [@ocaml.doc
    "<p>This exception is thrown when the trail with the given name is not found.</p>"]
  | TrailNotProvidedException
  [@ocaml.doc "<p>This exception is no longer in use.</p>"]
  | UnauthorizedOperation 
  | UnknownParameter 
  | UnsupportedOperationException
  [@ocaml.doc
    "<p>This exception is thrown when the requested operation is not supported.</p>"]
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
  | Blocked -> None
  | CloudTrailARNInvalidException -> None
  | CloudTrailAccessNotEnabledException -> None
  | CloudWatchLogsDeliveryUnavailableException -> None
  | DryRunOperation -> None
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InsightNotEnabledException -> None
  | InsufficientDependencyServiceAccessPermissionException -> None
  | InsufficientEncryptionPolicyException -> None
  | InsufficientS3BucketPolicyException -> None
  | InsufficientSnsTopicPolicyException -> None
  | InternalFailure -> Some 500
  | InvalidAction -> Some 400
  | InvalidClientTokenId -> Some 403
  | InvalidCloudWatchLogsLogGroupArnException -> None
  | InvalidCloudWatchLogsRoleArnException -> None
  | InvalidEventCategoryException -> None
  | InvalidEventSelectorsException -> None
  | InvalidHomeRegionException -> None
  | InvalidInsightSelectorsException -> None
  | InvalidKmsKeyIdException -> None
  | InvalidLookupAttributesException -> None
  | InvalidMaxResultsException -> None
  | InvalidNextTokenException -> None
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterCombinationException -> None
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | InvalidS3BucketNameException -> None
  | InvalidS3PrefixException -> None
  | InvalidSnsTopicNameException -> None
  | InvalidTagParameterException -> None
  | InvalidTimeRangeException -> None
  | InvalidTokenException -> None
  | InvalidTrailNameException -> None
  | KmsException -> None
  | KmsKeyDisabledException -> None
  | KmsKeyNotFoundException -> None
  | MalformedQueryString -> Some 404
  | MaximumNumberOfTrailsExceededException -> None
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | NotOrganizationMasterAccountException -> None
  | OperationNotPermittedException -> None
  | OptInRequired -> Some 403
  | OrganizationNotInAllFeaturesModeException -> None
  | OrganizationsNotInUseException -> None
  | PendingVerification -> None
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ResourceNotFoundException -> None
  | ResourceTypeNotSupportedException -> None
  | S3BucketDoesNotExistException -> None
  | ServiceUnavailable -> Some 503
  | TagsLimitExceededException -> None
  | Throttling -> Some 400
  | TrailAlreadyExistsException -> None
  | TrailNotFoundException -> None
  | TrailNotProvidedException -> None
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedOperationException -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AuthFailure -> "AuthFailure"
  | Blocked -> "Blocked"
  | CloudTrailARNInvalidException -> "CloudTrailARNInvalidException"
  | CloudTrailAccessNotEnabledException ->
      "CloudTrailAccessNotEnabledException"
  | CloudWatchLogsDeliveryUnavailableException ->
      "CloudWatchLogsDeliveryUnavailableException"
  | DryRunOperation -> "DryRunOperation"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InsightNotEnabledException -> "InsightNotEnabledException"
  | InsufficientDependencyServiceAccessPermissionException ->
      "InsufficientDependencyServiceAccessPermissionException"
  | InsufficientEncryptionPolicyException ->
      "InsufficientEncryptionPolicyException"
  | InsufficientS3BucketPolicyException ->
      "InsufficientS3BucketPolicyException"
  | InsufficientSnsTopicPolicyException ->
      "InsufficientSnsTopicPolicyException"
  | InternalFailure -> "InternalFailure"
  | InvalidAction -> "InvalidAction"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidCloudWatchLogsLogGroupArnException ->
      "InvalidCloudWatchLogsLogGroupArnException"
  | InvalidCloudWatchLogsRoleArnException ->
      "InvalidCloudWatchLogsRoleArnException"
  | InvalidEventCategoryException -> "InvalidEventCategoryException"
  | InvalidEventSelectorsException -> "InvalidEventSelectorsException"
  | InvalidHomeRegionException -> "InvalidHomeRegionException"
  | InvalidInsightSelectorsException -> "InvalidInsightSelectorsException"
  | InvalidKmsKeyIdException -> "InvalidKmsKeyIdException"
  | InvalidLookupAttributesException -> "InvalidLookupAttributesException"
  | InvalidMaxResultsException -> "InvalidMaxResultsException"
  | InvalidNextTokenException -> "InvalidNextTokenException"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterCombinationException ->
      "InvalidParameterCombinationException"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | InvalidS3BucketNameException -> "InvalidS3BucketNameException"
  | InvalidS3PrefixException -> "InvalidS3PrefixException"
  | InvalidSnsTopicNameException -> "InvalidSnsTopicNameException"
  | InvalidTagParameterException -> "InvalidTagParameterException"
  | InvalidTimeRangeException -> "InvalidTimeRangeException"
  | InvalidTokenException -> "InvalidTokenException"
  | InvalidTrailNameException -> "InvalidTrailNameException"
  | KmsException -> "KmsException"
  | KmsKeyDisabledException -> "KmsKeyDisabledException"
  | KmsKeyNotFoundException -> "KmsKeyNotFoundException"
  | MalformedQueryString -> "MalformedQueryString"
  | MaximumNumberOfTrailsExceededException ->
      "MaximumNumberOfTrailsExceededException"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | NotOrganizationMasterAccountException ->
      "NotOrganizationMasterAccountException"
  | OperationNotPermittedException -> "OperationNotPermittedException"
  | OptInRequired -> "OptInRequired"
  | OrganizationNotInAllFeaturesModeException ->
      "OrganizationNotInAllFeaturesModeException"
  | OrganizationsNotInUseException -> "OrganizationsNotInUseException"
  | PendingVerification -> "PendingVerification"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ResourceNotFoundException -> "ResourceNotFoundException"
  | ResourceTypeNotSupportedException -> "ResourceTypeNotSupportedException"
  | S3BucketDoesNotExistException -> "S3BucketDoesNotExistException"
  | ServiceUnavailable -> "ServiceUnavailable"
  | TagsLimitExceededException -> "TagsLimitExceededException"
  | Throttling -> "Throttling"
  | TrailAlreadyExistsException -> "TrailAlreadyExistsException"
  | TrailNotFoundException -> "TrailNotFoundException"
  | TrailNotProvidedException -> "TrailNotProvidedException"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedOperationException -> "UnsupportedOperationException"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AuthFailure" -> Some AuthFailure
  | "Blocked" -> Some Blocked
  | "CloudTrailARNInvalidException" -> Some CloudTrailARNInvalidException
  | "CloudTrailAccessNotEnabledException" ->
      Some CloudTrailAccessNotEnabledException
  | "CloudWatchLogsDeliveryUnavailableException" ->
      Some CloudWatchLogsDeliveryUnavailableException
  | "DryRunOperation" -> Some DryRunOperation
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InsightNotEnabledException" -> Some InsightNotEnabledException
  | "InsufficientDependencyServiceAccessPermissionException" ->
      Some InsufficientDependencyServiceAccessPermissionException
  | "InsufficientEncryptionPolicyException" ->
      Some InsufficientEncryptionPolicyException
  | "InsufficientS3BucketPolicyException" ->
      Some InsufficientS3BucketPolicyException
  | "InsufficientSnsTopicPolicyException" ->
      Some InsufficientSnsTopicPolicyException
  | "InternalFailure" -> Some InternalFailure
  | "InvalidAction" -> Some InvalidAction
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidCloudWatchLogsLogGroupArnException" ->
      Some InvalidCloudWatchLogsLogGroupArnException
  | "InvalidCloudWatchLogsRoleArnException" ->
      Some InvalidCloudWatchLogsRoleArnException
  | "InvalidEventCategoryException" -> Some InvalidEventCategoryException
  | "InvalidEventSelectorsException" -> Some InvalidEventSelectorsException
  | "InvalidHomeRegionException" -> Some InvalidHomeRegionException
  | "InvalidInsightSelectorsException" ->
      Some InvalidInsightSelectorsException
  | "InvalidKmsKeyIdException" -> Some InvalidKmsKeyIdException
  | "InvalidLookupAttributesException" ->
      Some InvalidLookupAttributesException
  | "InvalidMaxResultsException" -> Some InvalidMaxResultsException
  | "InvalidNextTokenException" -> Some InvalidNextTokenException
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterCombinationException" ->
      Some InvalidParameterCombinationException
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "InvalidS3BucketNameException" -> Some InvalidS3BucketNameException
  | "InvalidS3PrefixException" -> Some InvalidS3PrefixException
  | "InvalidSnsTopicNameException" -> Some InvalidSnsTopicNameException
  | "InvalidTagParameterException" -> Some InvalidTagParameterException
  | "InvalidTimeRangeException" -> Some InvalidTimeRangeException
  | "InvalidTokenException" -> Some InvalidTokenException
  | "InvalidTrailNameException" -> Some InvalidTrailNameException
  | "KmsException" -> Some KmsException
  | "KmsKeyDisabledException" -> Some KmsKeyDisabledException
  | "KmsKeyNotFoundException" -> Some KmsKeyNotFoundException
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MaximumNumberOfTrailsExceededException" ->
      Some MaximumNumberOfTrailsExceededException
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "NotOrganizationMasterAccountException" ->
      Some NotOrganizationMasterAccountException
  | "OperationNotPermittedException" -> Some OperationNotPermittedException
  | "OptInRequired" -> Some OptInRequired
  | "OrganizationNotInAllFeaturesModeException" ->
      Some OrganizationNotInAllFeaturesModeException
  | "OrganizationsNotInUseException" -> Some OrganizationsNotInUseException
  | "PendingVerification" -> Some PendingVerification
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ResourceNotFoundException" -> Some ResourceNotFoundException
  | "ResourceTypeNotSupportedException" ->
      Some ResourceTypeNotSupportedException
  | "S3BucketDoesNotExistException" -> Some S3BucketDoesNotExistException
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "TagsLimitExceededException" -> Some TagsLimitExceededException
  | "Throttling" -> Some Throttling
  | "TrailAlreadyExistsException" -> Some TrailAlreadyExistsException
  | "TrailNotFoundException" -> Some TrailNotFoundException
  | "TrailNotProvidedException" -> Some TrailNotProvidedException
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedOperationException" -> Some UnsupportedOperationException
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None