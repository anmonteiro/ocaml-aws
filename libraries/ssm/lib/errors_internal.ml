type t =
  | AlreadyExistsException
  [@ocaml.doc
    "<p>Error returned if an attempt is made to register a patch group with a patch baseline that is already registered with a different patch baseline.</p>"]
  | AssociatedInstances
  [@ocaml.doc
    "<p>You must disassociate a document from all instances before you can delete it.</p>"]
  | AssociationAlreadyExists
  [@ocaml.doc "<p>The specified association already exists.</p>"]
  | AssociationDoesNotExist
  [@ocaml.doc "<p>The specified association does not exist.</p>"]
  | AssociationExecutionDoesNotExist
  [@ocaml.doc
    "<p>The specified execution ID does not exist. Verify the ID number and try again.</p>"]
  | AssociationLimitExceeded
  [@ocaml.doc "<p>You can have at most 2,000 active associations.</p>"]
  | AssociationVersionLimitExceeded
  [@ocaml.doc
    "<p>You have reached the maximum number versions allowed for an association. Each association has a limit of 1,000 versions. </p>"]
  | AuthFailure 
  | AutomationDefinitionNotFoundException
  [@ocaml.doc
    "<p>An Automation document with the specified name could not be found.</p>"]
  | AutomationDefinitionVersionNotFoundException
  [@ocaml.doc
    "<p>An Automation document with the specified name and version could not be found.</p>"]
  | AutomationExecutionLimitExceededException
  [@ocaml.doc
    "<p>The number of simultaneously running Automation executions exceeded the allowable limit.</p>"]
  | AutomationExecutionNotFoundException
  [@ocaml.doc
    "<p>There is no automation execution information for the requested automation execution ID.</p>"]
  | AutomationStepNotFoundException
  [@ocaml.doc
    "<p>The specified step name and execution ID don't exist. Verify the information and try again.</p>"]
  | Blocked 
  | ComplianceTypeCountLimitExceededException
  [@ocaml.doc
    "<p>You specified too many custom compliance types. You can specify a maximum of 10 different types. </p>"]
  | CustomSchemaCountLimitExceededException
  [@ocaml.doc
    "<p>You have exceeded the limit for custom schemas. Delete one or more custom schemas and try again.</p>"]
  | DocumentAlreadyExists
  [@ocaml.doc "<p>The specified document already exists.</p>"]
  | DocumentLimitExceeded
  [@ocaml.doc
    "<p>You can have at most 500 active Systems Manager documents.</p>"]
  | DocumentPermissionLimit
  [@ocaml.doc
    "<p>The document cannot be shared with more AWS user accounts. You can share a document with a maximum of 20 accounts. You can publicly share up to five documents. If you need to increase this limit, contact AWS Support.</p>"]
  | DocumentVersionLimitExceeded
  [@ocaml.doc
    "<p>The document has too many versions. Delete one or more document versions and try again.</p>"]
  | DoesNotExistException
  [@ocaml.doc
    "<p>Error returned when the ID specified for a resource, such as a maintenance window or Patch baseline, doesn't exist.</p> <p>For information about resource quotas in Systems Manager, see <a href=\"http://docs.aws.amazon.com/general/latest/gr/ssm.html#limits_ssm\">Systems Manager Service Quotas</a> in the <i>AWS General Reference</i>.</p>"]
  | DryRunOperation 
  | DuplicateDocumentContent
  [@ocaml.doc
    "<p>The content of the association document matches another document. Change the content of the document and try again.</p>"]
  | DuplicateDocumentVersionName
  [@ocaml.doc
    "<p>The version name has already been used in this document. Specify a different version name, and then try again.</p>"]
  | DuplicateInstanceId
  [@ocaml.doc
    "<p>You cannot specify an instance ID in more than one association.</p>"]
  | FeatureNotAvailableException
  [@ocaml.doc
    "<p>You attempted to register a LAMBDA or STEP_FUNCTIONS task in a region where the corresponding service is not available. </p>"]
  | HierarchyLevelLimitExceededException
  [@ocaml.doc
    "<p>A hierarchy can have a maximum of 15 levels. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-parameter-name-constraints.html\">Requirements and Constraints for Parameter Names</a> in the <i>AWS Systems Manager User Guide</i>. </p>"]
  | HierarchyTypeMismatchException
  [@ocaml.doc
    "<p>Parameter Store does not support changing a parameter type in a hierarchy. For example, you can't change a parameter from a String type to a SecureString type. You must create a new, unique parameter.</p>"]
  | IdempotentParameterMismatch
  [@ocaml.doc
    "<p>Error returned when an idempotent operation is retried and the parameters don't match the original call to the API with the same idempotency token. </p>"]
  | IncompatiblePolicyException
  [@ocaml.doc
    "<p>There is a conflict in the policies specified for this parameter. You can't, for example, specify two Expiration policies for a parameter. Review your policies, and try again.</p>"]
  | IncompleteSignature 
  | InternalFailure 
  | InternalServerError
  [@ocaml.doc "<p>An error occurred on the server side.</p>"]
  | InvalidAction 
  | InvalidActivation
  [@ocaml.doc
    "<p>The activation is not valid. The activation might have been deleted, or the ActivationId and the ActivationCode do not match.</p>"]
  | InvalidActivationId
  [@ocaml.doc
    "<p>The activation ID is not valid. Verify the you entered the correct ActivationId or ActivationCode and try again.</p>"]
  | InvalidAggregatorException
  [@ocaml.doc
    "<p>The specified aggregator is not valid for inventory groups. Verify that the aggregator uses a valid inventory type such as <code>AWS:Application</code> or <code>AWS:InstanceInformation</code>.</p>"]
  | InvalidAllowedPatternException
  [@ocaml.doc
    "<p>The request does not meet the regular expression requirement.</p>"]
  | InvalidAssociation
  [@ocaml.doc "<p>The association is not valid or does not exist. </p>"]
  | InvalidAssociationVersion
  [@ocaml.doc
    "<p>The version you specified is not valid. Use ListAssociationVersions to view all versions of an association according to the association ID. Or, use the <code>$LATEST</code> parameter to view the latest version of the association.</p>"]
  | InvalidAutomationExecutionParametersException
  [@ocaml.doc
    "<p>The supplied parameters for invoking the specified Automation document are incorrect. For example, they may not match the set of parameters permitted for the specified Automation document.</p>"]
  | InvalidAutomationSignalException
  [@ocaml.doc
    "<p>The signal is not valid for the current Automation execution.</p>"]
  | InvalidAutomationStatusUpdateException
  [@ocaml.doc "<p>The specified update status operation is not valid.</p>"]
  | InvalidClientTokenId 
  | InvalidCommandId 
  | InvalidDeleteInventoryParametersException
  [@ocaml.doc
    "<p>One or more of the parameters specified for the delete operation is not valid. Verify all parameters and try again.</p>"]
  | InvalidDeletionIdException
  [@ocaml.doc
    "<p>The ID specified for the delete operation does not exist or is not valid. Verify the ID and try again.</p>"]
  | InvalidDocument
  [@ocaml.doc "<p>The specified document does not exist.</p>"]
  | InvalidDocumentContent
  [@ocaml.doc "<p>The content for the document is not valid.</p>"]
  | InvalidDocumentOperation
  [@ocaml.doc
    "<p>You attempted to delete a document while it is still shared. You must stop sharing the document before you can delete it.</p>"]
  | InvalidDocumentSchemaVersion
  [@ocaml.doc "<p>The version of the document schema is not supported.</p>"]
  | InvalidDocumentType
  [@ocaml.doc
    "<p>The document type is not valid. Valid document types are described in the <code>DocumentType</code> property.</p>"]
  | InvalidDocumentVersion
  [@ocaml.doc "<p>The document version is not valid or does not exist.</p>"]
  | InvalidFilter
  [@ocaml.doc
    "<p>The filter name is not valid. Verify the you entered the correct name and try again.</p>"]
  | InvalidFilterKey [@ocaml.doc "<p>The specified key is not valid.</p>"]
  | InvalidFilterOption
  [@ocaml.doc
    "<p>The specified filter option is not valid. Valid options are Equals and BeginsWith. For Path filter, valid options are Recursive and OneLevel.</p>"]
  | InvalidFilterValue
  [@ocaml.doc
    "<p>The filter value is not valid. Verify the value and try again.</p>"]
  | InvalidInstanceId
  [@ocaml.doc
    "<p>The following problems can cause this exception:</p> <p>You do not have permission to access the instance.</p> <p>SSM Agent is not running. Verify that SSM Agent is running.</p> <p>SSM Agent is not registered with the SSM endpoint. Try reinstalling SSM Agent.</p> <p>The instance is not in valid state. Valid states are: Running, Pending, Stopped, Stopping. Invalid states are: Shutting-down and Terminated.</p>"]
  | InvalidInstanceInformationFilterValue
  [@ocaml.doc "<p>The specified filter value is not valid.</p>"]
  | InvalidInventoryGroupException
  [@ocaml.doc "<p>The specified inventory group is not valid.</p>"]
  | InvalidInventoryItemContextException
  [@ocaml.doc
    "<p>You specified invalid keys or values in the <code>Context</code> attribute for <code>InventoryItem</code>. Verify the keys and values, and try again.</p>"]
  | InvalidInventoryRequestException
  [@ocaml.doc "<p>The request is not valid.</p>"]
  | InvalidItemContentException
  [@ocaml.doc "<p>One or more content items is not valid.</p>"]
  | InvalidKeyId [@ocaml.doc "<p>The query key ID is not valid.</p>"]
  | InvalidNextToken [@ocaml.doc "<p>The specified token is not valid.</p>"]
  | InvalidNotificationConfig
  [@ocaml.doc
    "<p>One or more configuration items is not valid. Verify that a valid Amazon Resource Name (ARN) was provided for an Amazon SNS topic.</p>"]
  | InvalidOptionException
  [@ocaml.doc
    "<p>The delete inventory option specified is not valid. Verify the option and try again.</p>"]
  | InvalidOutputFolder [@ocaml.doc "<p>The S3 bucket does not exist.</p>"]
  | InvalidOutputLocation
  [@ocaml.doc "<p>The output location is not valid or does not exist.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterValue 
  | InvalidParameters
  [@ocaml.doc
    "<p>You must specify values for all required parameters in the Systems Manager document. You can only supply values to parameters defined in the Systems Manager document.</p>"]
  | InvalidPermissionType
  [@ocaml.doc
    "<p>The permission type is not supported. <i>Share</i> is the only supported permission type.</p>"]
  | InvalidPluginName [@ocaml.doc "<p>The plugin name is not valid.</p>"]
  | InvalidPolicyAttributeException
  [@ocaml.doc "<p>A policy attribute or its value is invalid. </p>"]
  | InvalidPolicyTypeException
  [@ocaml.doc
    "<p>The policy type is not supported. Parameter Store supports the following policy types: Expiration, ExpirationNotification, and NoChangeNotification.</p>"]
  | InvalidQueryParameter 
  | InvalidResourceId
  [@ocaml.doc
    "<p>The resource ID is not valid. Verify that you entered the correct ID and try again.</p>"]
  | InvalidResourceType
  [@ocaml.doc
    "<p>The resource type is not valid. For example, if you are attempting to tag an instance, the instance must be a registered, managed instance.</p>"]
  | InvalidResultAttributeException
  [@ocaml.doc
    "<p>The specified inventory item result attribute is not valid.</p>"]
  | InvalidRole
  [@ocaml.doc
    "<p>The role name can't contain invalid characters. Also verify that you specified an IAM role for notifications that includes the required trust policy. For information about configuring the IAM role for Run Command notifications, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/rc-sns-notifications.html\">Configuring Amazon SNS Notifications for Run Command</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]
  | InvalidSchedule
  [@ocaml.doc
    "<p>The schedule is invalid. Verify your cron or rate expression and try again.</p>"]
  | InvalidTarget
  [@ocaml.doc
    "<p>The target is not valid or does not exist. It might not be configured for EC2 Systems Manager or you might not have permission to perform the operation.</p>"]
  | InvalidTypeNameException
  [@ocaml.doc "<p>The parameter type name is not valid.</p>"]
  | InvalidUpdate [@ocaml.doc "<p>The update is not valid.</p>"]
  | InvocationDoesNotExist
  [@ocaml.doc
    "<p>The command ID and instance ID you specified did not match any invocations. Verify the command ID and the instance ID and try again. </p>"]
  | ItemContentMismatchException
  [@ocaml.doc "<p>The inventory item has invalid content. </p>"]
  | ItemSizeLimitExceededException
  [@ocaml.doc "<p>The inventory item size has exceeded the size limit.</p>"]
  | MalformedQueryString 
  | MaxDocumentSizeExceeded
  [@ocaml.doc "<p>The size limit of a document is 64 KB.</p>"]
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | OpsItemAlreadyExistsException
  [@ocaml.doc "<p>The OpsItem already exists.</p>"]
  | OpsItemInvalidParameterException
  [@ocaml.doc
    "<p>A specified parameter argument isn't valid. Verify the available arguments and try again.</p>"]
  | OpsItemLimitExceededException
  [@ocaml.doc
    "<p>The request caused OpsItems to exceed one or more quotas. For information about OpsItem quotas, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-learn-more.html#OpsCenter-learn-more-limits\">What are the resource limits for OpsCenter?</a>.</p>"]
  | OpsItemNotFoundException
  [@ocaml.doc
    "<p>The specified OpsItem ID doesn't exist. Verify the ID and try again.</p>"]
  | OptInRequired 
  | ParameterAlreadyExists
  [@ocaml.doc
    "<p>The parameter already exists. You can't create duplicate parameters.</p>"]
  | ParameterLimitExceeded
  [@ocaml.doc
    "<p>You have exceeded the number of parameters for this AWS account. Delete one or more parameters and try again.</p>"]
  | ParameterMaxVersionLimitExceeded
  [@ocaml.doc
    "<p>The parameter exceeded the maximum number of allowed versions.</p>"]
  | ParameterNotFound
  [@ocaml.doc
    "<p>The parameter could not be found. Verify the name and try again.</p>"]
  | ParameterPatternMismatchException
  [@ocaml.doc "<p>The parameter name is not valid.</p>"]
  | ParameterVersionLabelLimitExceeded
  [@ocaml.doc "<p>A parameter version can have a maximum of ten labels.</p>"]
  | ParameterVersionNotFound
  [@ocaml.doc
    "<p>The specified parameter version was not found. Verify the parameter name and version, and try again.</p>"]
  | PendingVerification 
  | PoliciesLimitExceededException
  [@ocaml.doc
    "<p>You specified more than the maximum number of allowed policies for the parameter. The maximum is 10.</p>"]
  | RequestExpired 
  | RequestLimitExceeded 
  | ResourceDataSyncAlreadyExistsException
  [@ocaml.doc
    "<p>A sync configuration with the same name already exists.</p>"]
  | ResourceDataSyncConflictException
  [@ocaml.doc
    "<p>Another <code>UpdateResourceDataSync</code> request is being processed. Wait a few minutes and try again.</p>"]
  | ResourceDataSyncCountExceededException
  [@ocaml.doc
    "<p>You have exceeded the allowed maximum sync configurations.</p>"]
  | ResourceDataSyncInvalidConfigurationException
  [@ocaml.doc "<p>The specified sync configuration is invalid.</p>"]
  | ResourceDataSyncNotFoundException
  [@ocaml.doc "<p>The specified sync name was not found.</p>"]
  | ResourceInUseException
  [@ocaml.doc
    "<p>Error returned if an attempt is made to delete a patch baseline that is registered for a patch group.</p>"]
  | ResourceLimitExceededException
  [@ocaml.doc
    "<p>Error returned when the caller has exceeded the default resource quotas. For example, too many maintenance windows or patch baselines have been created.</p> <p>For information about resource quotas in Systems Manager, see <a href=\"http://docs.aws.amazon.com/general/latest/gr/ssm.html#limits_ssm\">Systems Manager Service Quotas</a> in the <i>AWS General Reference</i>.</p>"]
  | ServiceSettingNotFound
  [@ocaml.doc
    "<p>The specified service setting was not found. Either the service name or the setting has not been provisioned by the AWS service team.</p>"]
  | ServiceUnavailable 
  | StatusUnchanged
  [@ocaml.doc "<p>The updated status is the same as the current status.</p>"]
  | SubTypeCountLimitExceededException
  [@ocaml.doc
    "<p>The sub-type count exceeded the limit for the inventory type.</p>"]
  | TargetInUseException
  [@ocaml.doc
    "<p>You specified the <code>Safe</code> option for the DeregisterTargetFromMaintenanceWindow operation, but the target is still referenced in a task.</p>"]
  | TargetNotConnected
  [@ocaml.doc
    "<p>The specified target instance for the session is not fully configured for use with Session Manager. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-getting-started.html\">Getting Started with Session Manager</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]
  | Throttling 
  | TooManyTagsError
  [@ocaml.doc
    "<p>The <code>Targets</code> parameter includes too many tags. Remove one or more tags and try the command again.</p>"]
  | TooManyUpdates
  [@ocaml.doc
    "<p>There are concurrent updates for a resource that supports one update at a time.</p>"]
  | TotalSizeLimitExceededException
  [@ocaml.doc
    "<p>The size of inventory data has exceeded the total size limit for the resource.</p>"]
  | UnauthorizedOperation 
  | UnknownParameter 
  | UnsupportedCalendarException
  [@ocaml.doc
    "<p>The calendar entry contained in the specified Systems Manager document is not supported.</p>"]
  | UnsupportedFeatureRequiredException
  [@ocaml.doc
    "<p>Microsoft application patching is only available on EC2 instances and Advanced Instances. To patch Microsoft applications on on-premises servers and VMs, you must enable Advanced Instances. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-managedinstances-advanced.html\">Using the Advanced-Instances Tier</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]
  | UnsupportedInventoryItemContextException
  [@ocaml.doc
    "<p>The <code>Context</code> attribute that you specified for the <code>InventoryItem</code> is not allowed for this inventory type. You can only use the <code>Context</code> attribute with inventory types like <code>AWS:ComplianceItem</code>.</p>"]
  | UnsupportedInventorySchemaVersionException
  [@ocaml.doc
    "<p>Inventory item type schema version has to match supported versions in the service. Check output of GetInventorySchema to see the available schema version for each type.</p>"]
  | UnsupportedOperatingSystem
  [@ocaml.doc
    "<p>The operating systems you specified is not supported, or the operation is not supported for the operating system. Valid operating systems include: Windows, AmazonLinux, RedhatEnterpriseLinux, and Ubuntu.</p>"]
  | UnsupportedParameterType
  [@ocaml.doc "<p>The parameter type is not supported.</p>"]
  | UnsupportedPlatformType
  [@ocaml.doc
    "<p>The document does not support the platform type of the given instance ID(s). For example, you sent an document for a Windows instance to a Linux instance.</p>"]
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
  | AlreadyExistsException -> None
  | AssociatedInstances -> None
  | AssociationAlreadyExists -> None
  | AssociationDoesNotExist -> None
  | AssociationExecutionDoesNotExist -> None
  | AssociationLimitExceeded -> None
  | AssociationVersionLimitExceeded -> None
  | AuthFailure -> None
  | AutomationDefinitionNotFoundException -> None
  | AutomationDefinitionVersionNotFoundException -> None
  | AutomationExecutionLimitExceededException -> None
  | AutomationExecutionNotFoundException -> None
  | AutomationStepNotFoundException -> None
  | Blocked -> None
  | ComplianceTypeCountLimitExceededException -> None
  | CustomSchemaCountLimitExceededException -> None
  | DocumentAlreadyExists -> None
  | DocumentLimitExceeded -> None
  | DocumentPermissionLimit -> None
  | DocumentVersionLimitExceeded -> None
  | DoesNotExistException -> None
  | DryRunOperation -> None
  | DuplicateDocumentContent -> None
  | DuplicateDocumentVersionName -> None
  | DuplicateInstanceId -> None
  | FeatureNotAvailableException -> None
  | HierarchyLevelLimitExceededException -> None
  | HierarchyTypeMismatchException -> None
  | IdempotentParameterMismatch -> None
  | IncompatiblePolicyException -> None
  | IncompleteSignature -> Some 400
  | InternalFailure -> Some 500
  | InternalServerError -> None
  | InvalidAction -> Some 400
  | InvalidActivation -> None
  | InvalidActivationId -> None
  | InvalidAggregatorException -> None
  | InvalidAllowedPatternException -> None
  | InvalidAssociation -> None
  | InvalidAssociationVersion -> None
  | InvalidAutomationExecutionParametersException -> None
  | InvalidAutomationSignalException -> None
  | InvalidAutomationStatusUpdateException -> None
  | InvalidClientTokenId -> Some 403
  | InvalidCommandId -> None
  | InvalidDeleteInventoryParametersException -> None
  | InvalidDeletionIdException -> None
  | InvalidDocument -> None
  | InvalidDocumentContent -> None
  | InvalidDocumentOperation -> None
  | InvalidDocumentSchemaVersion -> None
  | InvalidDocumentType -> None
  | InvalidDocumentVersion -> None
  | InvalidFilter -> None
  | InvalidFilterKey -> None
  | InvalidFilterOption -> None
  | InvalidFilterValue -> None
  | InvalidInstanceId -> None
  | InvalidInstanceInformationFilterValue -> None
  | InvalidInventoryGroupException -> None
  | InvalidInventoryItemContextException -> None
  | InvalidInventoryRequestException -> None
  | InvalidItemContentException -> None
  | InvalidKeyId -> None
  | InvalidNextToken -> None
  | InvalidNotificationConfig -> None
  | InvalidOptionException -> None
  | InvalidOutputFolder -> None
  | InvalidOutputLocation -> None
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidParameters -> None
  | InvalidPermissionType -> None
  | InvalidPluginName -> None
  | InvalidPolicyAttributeException -> None
  | InvalidPolicyTypeException -> None
  | InvalidQueryParameter -> Some 400
  | InvalidResourceId -> None
  | InvalidResourceType -> None
  | InvalidResultAttributeException -> None
  | InvalidRole -> None
  | InvalidSchedule -> None
  | InvalidTarget -> None
  | InvalidTypeNameException -> None
  | InvalidUpdate -> None
  | InvocationDoesNotExist -> None
  | ItemContentMismatchException -> None
  | ItemSizeLimitExceededException -> None
  | MalformedQueryString -> Some 404
  | MaxDocumentSizeExceeded -> None
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | OpsItemAlreadyExistsException -> None
  | OpsItemInvalidParameterException -> None
  | OpsItemLimitExceededException -> None
  | OpsItemNotFoundException -> None
  | OptInRequired -> Some 403
  | ParameterAlreadyExists -> None
  | ParameterLimitExceeded -> None
  | ParameterMaxVersionLimitExceeded -> None
  | ParameterNotFound -> None
  | ParameterPatternMismatchException -> None
  | ParameterVersionLabelLimitExceeded -> None
  | ParameterVersionNotFound -> None
  | PendingVerification -> None
  | PoliciesLimitExceededException -> None
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ResourceDataSyncAlreadyExistsException -> None
  | ResourceDataSyncConflictException -> None
  | ResourceDataSyncCountExceededException -> None
  | ResourceDataSyncInvalidConfigurationException -> None
  | ResourceDataSyncNotFoundException -> None
  | ResourceInUseException -> None
  | ResourceLimitExceededException -> None
  | ServiceSettingNotFound -> None
  | ServiceUnavailable -> Some 503
  | StatusUnchanged -> None
  | SubTypeCountLimitExceededException -> None
  | TargetInUseException -> None
  | TargetNotConnected -> None
  | Throttling -> Some 400
  | TooManyTagsError -> None
  | TooManyUpdates -> None
  | TotalSizeLimitExceededException -> None
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedCalendarException -> None
  | UnsupportedFeatureRequiredException -> None
  | UnsupportedInventoryItemContextException -> None
  | UnsupportedInventorySchemaVersionException -> None
  | UnsupportedOperatingSystem -> None
  | UnsupportedParameterType -> None
  | UnsupportedPlatformType -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AlreadyExistsException -> "AlreadyExistsException"
  | AssociatedInstances -> "AssociatedInstances"
  | AssociationAlreadyExists -> "AssociationAlreadyExists"
  | AssociationDoesNotExist -> "AssociationDoesNotExist"
  | AssociationExecutionDoesNotExist -> "AssociationExecutionDoesNotExist"
  | AssociationLimitExceeded -> "AssociationLimitExceeded"
  | AssociationVersionLimitExceeded -> "AssociationVersionLimitExceeded"
  | AuthFailure -> "AuthFailure"
  | AutomationDefinitionNotFoundException ->
      "AutomationDefinitionNotFoundException"
  | AutomationDefinitionVersionNotFoundException ->
      "AutomationDefinitionVersionNotFoundException"
  | AutomationExecutionLimitExceededException ->
      "AutomationExecutionLimitExceededException"
  | AutomationExecutionNotFoundException ->
      "AutomationExecutionNotFoundException"
  | AutomationStepNotFoundException -> "AutomationStepNotFoundException"
  | Blocked -> "Blocked"
  | ComplianceTypeCountLimitExceededException ->
      "ComplianceTypeCountLimitExceededException"
  | CustomSchemaCountLimitExceededException ->
      "CustomSchemaCountLimitExceededException"
  | DocumentAlreadyExists -> "DocumentAlreadyExists"
  | DocumentLimitExceeded -> "DocumentLimitExceeded"
  | DocumentPermissionLimit -> "DocumentPermissionLimit"
  | DocumentVersionLimitExceeded -> "DocumentVersionLimitExceeded"
  | DoesNotExistException -> "DoesNotExistException"
  | DryRunOperation -> "DryRunOperation"
  | DuplicateDocumentContent -> "DuplicateDocumentContent"
  | DuplicateDocumentVersionName -> "DuplicateDocumentVersionName"
  | DuplicateInstanceId -> "DuplicateInstanceId"
  | FeatureNotAvailableException -> "FeatureNotAvailableException"
  | HierarchyLevelLimitExceededException ->
      "HierarchyLevelLimitExceededException"
  | HierarchyTypeMismatchException -> "HierarchyTypeMismatchException"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompatiblePolicyException -> "IncompatiblePolicyException"
  | IncompleteSignature -> "IncompleteSignature"
  | InternalFailure -> "InternalFailure"
  | InternalServerError -> "InternalServerError"
  | InvalidAction -> "InvalidAction"
  | InvalidActivation -> "InvalidActivation"
  | InvalidActivationId -> "InvalidActivationId"
  | InvalidAggregatorException -> "InvalidAggregatorException"
  | InvalidAllowedPatternException -> "InvalidAllowedPatternException"
  | InvalidAssociation -> "InvalidAssociation"
  | InvalidAssociationVersion -> "InvalidAssociationVersion"
  | InvalidAutomationExecutionParametersException ->
      "InvalidAutomationExecutionParametersException"
  | InvalidAutomationSignalException -> "InvalidAutomationSignalException"
  | InvalidAutomationStatusUpdateException ->
      "InvalidAutomationStatusUpdateException"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidCommandId -> "InvalidCommandId"
  | InvalidDeleteInventoryParametersException ->
      "InvalidDeleteInventoryParametersException"
  | InvalidDeletionIdException -> "InvalidDeletionIdException"
  | InvalidDocument -> "InvalidDocument"
  | InvalidDocumentContent -> "InvalidDocumentContent"
  | InvalidDocumentOperation -> "InvalidDocumentOperation"
  | InvalidDocumentSchemaVersion -> "InvalidDocumentSchemaVersion"
  | InvalidDocumentType -> "InvalidDocumentType"
  | InvalidDocumentVersion -> "InvalidDocumentVersion"
  | InvalidFilter -> "InvalidFilter"
  | InvalidFilterKey -> "InvalidFilterKey"
  | InvalidFilterOption -> "InvalidFilterOption"
  | InvalidFilterValue -> "InvalidFilterValue"
  | InvalidInstanceId -> "InvalidInstanceId"
  | InvalidInstanceInformationFilterValue ->
      "InvalidInstanceInformationFilterValue"
  | InvalidInventoryGroupException -> "InvalidInventoryGroupException"
  | InvalidInventoryItemContextException ->
      "InvalidInventoryItemContextException"
  | InvalidInventoryRequestException -> "InvalidInventoryRequestException"
  | InvalidItemContentException -> "InvalidItemContentException"
  | InvalidKeyId -> "InvalidKeyId"
  | InvalidNextToken -> "InvalidNextToken"
  | InvalidNotificationConfig -> "InvalidNotificationConfig"
  | InvalidOptionException -> "InvalidOptionException"
  | InvalidOutputFolder -> "InvalidOutputFolder"
  | InvalidOutputLocation -> "InvalidOutputLocation"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidParameters -> "InvalidParameters"
  | InvalidPermissionType -> "InvalidPermissionType"
  | InvalidPluginName -> "InvalidPluginName"
  | InvalidPolicyAttributeException -> "InvalidPolicyAttributeException"
  | InvalidPolicyTypeException -> "InvalidPolicyTypeException"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | InvalidResourceId -> "InvalidResourceId"
  | InvalidResourceType -> "InvalidResourceType"
  | InvalidResultAttributeException -> "InvalidResultAttributeException"
  | InvalidRole -> "InvalidRole"
  | InvalidSchedule -> "InvalidSchedule"
  | InvalidTarget -> "InvalidTarget"
  | InvalidTypeNameException -> "InvalidTypeNameException"
  | InvalidUpdate -> "InvalidUpdate"
  | InvocationDoesNotExist -> "InvocationDoesNotExist"
  | ItemContentMismatchException -> "ItemContentMismatchException"
  | ItemSizeLimitExceededException -> "ItemSizeLimitExceededException"
  | MalformedQueryString -> "MalformedQueryString"
  | MaxDocumentSizeExceeded -> "MaxDocumentSizeExceeded"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | OpsItemAlreadyExistsException -> "OpsItemAlreadyExistsException"
  | OpsItemInvalidParameterException -> "OpsItemInvalidParameterException"
  | OpsItemLimitExceededException -> "OpsItemLimitExceededException"
  | OpsItemNotFoundException -> "OpsItemNotFoundException"
  | OptInRequired -> "OptInRequired"
  | ParameterAlreadyExists -> "ParameterAlreadyExists"
  | ParameterLimitExceeded -> "ParameterLimitExceeded"
  | ParameterMaxVersionLimitExceeded -> "ParameterMaxVersionLimitExceeded"
  | ParameterNotFound -> "ParameterNotFound"
  | ParameterPatternMismatchException -> "ParameterPatternMismatchException"
  | ParameterVersionLabelLimitExceeded ->
      "ParameterVersionLabelLimitExceeded"
  | ParameterVersionNotFound -> "ParameterVersionNotFound"
  | PendingVerification -> "PendingVerification"
  | PoliciesLimitExceededException -> "PoliciesLimitExceededException"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ResourceDataSyncAlreadyExistsException ->
      "ResourceDataSyncAlreadyExistsException"
  | ResourceDataSyncConflictException -> "ResourceDataSyncConflictException"
  | ResourceDataSyncCountExceededException ->
      "ResourceDataSyncCountExceededException"
  | ResourceDataSyncInvalidConfigurationException ->
      "ResourceDataSyncInvalidConfigurationException"
  | ResourceDataSyncNotFoundException -> "ResourceDataSyncNotFoundException"
  | ResourceInUseException -> "ResourceInUseException"
  | ResourceLimitExceededException -> "ResourceLimitExceededException"
  | ServiceSettingNotFound -> "ServiceSettingNotFound"
  | ServiceUnavailable -> "ServiceUnavailable"
  | StatusUnchanged -> "StatusUnchanged"
  | SubTypeCountLimitExceededException ->
      "SubTypeCountLimitExceededException"
  | TargetInUseException -> "TargetInUseException"
  | TargetNotConnected -> "TargetNotConnected"
  | Throttling -> "Throttling"
  | TooManyTagsError -> "TooManyTagsError"
  | TooManyUpdates -> "TooManyUpdates"
  | TotalSizeLimitExceededException -> "TotalSizeLimitExceededException"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedCalendarException -> "UnsupportedCalendarException"
  | UnsupportedFeatureRequiredException ->
      "UnsupportedFeatureRequiredException"
  | UnsupportedInventoryItemContextException ->
      "UnsupportedInventoryItemContextException"
  | UnsupportedInventorySchemaVersionException ->
      "UnsupportedInventorySchemaVersionException"
  | UnsupportedOperatingSystem -> "UnsupportedOperatingSystem"
  | UnsupportedParameterType -> "UnsupportedParameterType"
  | UnsupportedPlatformType -> "UnsupportedPlatformType"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AlreadyExistsException" -> Some AlreadyExistsException
  | "AssociatedInstances" -> Some AssociatedInstances
  | "AssociationAlreadyExists" -> Some AssociationAlreadyExists
  | "AssociationDoesNotExist" -> Some AssociationDoesNotExist
  | "AssociationExecutionDoesNotExist" ->
      Some AssociationExecutionDoesNotExist
  | "AssociationLimitExceeded" -> Some AssociationLimitExceeded
  | "AssociationVersionLimitExceeded" -> Some AssociationVersionLimitExceeded
  | "AuthFailure" -> Some AuthFailure
  | "AutomationDefinitionNotFoundException" ->
      Some AutomationDefinitionNotFoundException
  | "AutomationDefinitionVersionNotFoundException" ->
      Some AutomationDefinitionVersionNotFoundException
  | "AutomationExecutionLimitExceededException" ->
      Some AutomationExecutionLimitExceededException
  | "AutomationExecutionNotFoundException" ->
      Some AutomationExecutionNotFoundException
  | "AutomationStepNotFoundException" -> Some AutomationStepNotFoundException
  | "Blocked" -> Some Blocked
  | "ComplianceTypeCountLimitExceededException" ->
      Some ComplianceTypeCountLimitExceededException
  | "CustomSchemaCountLimitExceededException" ->
      Some CustomSchemaCountLimitExceededException
  | "DocumentAlreadyExists" -> Some DocumentAlreadyExists
  | "DocumentLimitExceeded" -> Some DocumentLimitExceeded
  | "DocumentPermissionLimit" -> Some DocumentPermissionLimit
  | "DocumentVersionLimitExceeded" -> Some DocumentVersionLimitExceeded
  | "DoesNotExistException" -> Some DoesNotExistException
  | "DryRunOperation" -> Some DryRunOperation
  | "DuplicateDocumentContent" -> Some DuplicateDocumentContent
  | "DuplicateDocumentVersionName" -> Some DuplicateDocumentVersionName
  | "DuplicateInstanceId" -> Some DuplicateInstanceId
  | "FeatureNotAvailableException" -> Some FeatureNotAvailableException
  | "HierarchyLevelLimitExceededException" ->
      Some HierarchyLevelLimitExceededException
  | "HierarchyTypeMismatchException" -> Some HierarchyTypeMismatchException
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompatiblePolicyException" -> Some IncompatiblePolicyException
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InternalFailure" -> Some InternalFailure
  | "InternalServerError" -> Some InternalServerError
  | "InvalidAction" -> Some InvalidAction
  | "InvalidActivation" -> Some InvalidActivation
  | "InvalidActivationId" -> Some InvalidActivationId
  | "InvalidAggregatorException" -> Some InvalidAggregatorException
  | "InvalidAllowedPatternException" -> Some InvalidAllowedPatternException
  | "InvalidAssociation" -> Some InvalidAssociation
  | "InvalidAssociationVersion" -> Some InvalidAssociationVersion
  | "InvalidAutomationExecutionParametersException" ->
      Some InvalidAutomationExecutionParametersException
  | "InvalidAutomationSignalException" ->
      Some InvalidAutomationSignalException
  | "InvalidAutomationStatusUpdateException" ->
      Some InvalidAutomationStatusUpdateException
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidCommandId" -> Some InvalidCommandId
  | "InvalidDeleteInventoryParametersException" ->
      Some InvalidDeleteInventoryParametersException
  | "InvalidDeletionIdException" -> Some InvalidDeletionIdException
  | "InvalidDocument" -> Some InvalidDocument
  | "InvalidDocumentContent" -> Some InvalidDocumentContent
  | "InvalidDocumentOperation" -> Some InvalidDocumentOperation
  | "InvalidDocumentSchemaVersion" -> Some InvalidDocumentSchemaVersion
  | "InvalidDocumentType" -> Some InvalidDocumentType
  | "InvalidDocumentVersion" -> Some InvalidDocumentVersion
  | "InvalidFilter" -> Some InvalidFilter
  | "InvalidFilterKey" -> Some InvalidFilterKey
  | "InvalidFilterOption" -> Some InvalidFilterOption
  | "InvalidFilterValue" -> Some InvalidFilterValue
  | "InvalidInstanceId" -> Some InvalidInstanceId
  | "InvalidInstanceInformationFilterValue" ->
      Some InvalidInstanceInformationFilterValue
  | "InvalidInventoryGroupException" -> Some InvalidInventoryGroupException
  | "InvalidInventoryItemContextException" ->
      Some InvalidInventoryItemContextException
  | "InvalidInventoryRequestException" ->
      Some InvalidInventoryRequestException
  | "InvalidItemContentException" -> Some InvalidItemContentException
  | "InvalidKeyId" -> Some InvalidKeyId
  | "InvalidNextToken" -> Some InvalidNextToken
  | "InvalidNotificationConfig" -> Some InvalidNotificationConfig
  | "InvalidOptionException" -> Some InvalidOptionException
  | "InvalidOutputFolder" -> Some InvalidOutputFolder
  | "InvalidOutputLocation" -> Some InvalidOutputLocation
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidParameters" -> Some InvalidParameters
  | "InvalidPermissionType" -> Some InvalidPermissionType
  | "InvalidPluginName" -> Some InvalidPluginName
  | "InvalidPolicyAttributeException" -> Some InvalidPolicyAttributeException
  | "InvalidPolicyTypeException" -> Some InvalidPolicyTypeException
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "InvalidResourceId" -> Some InvalidResourceId
  | "InvalidResourceType" -> Some InvalidResourceType
  | "InvalidResultAttributeException" -> Some InvalidResultAttributeException
  | "InvalidRole" -> Some InvalidRole
  | "InvalidSchedule" -> Some InvalidSchedule
  | "InvalidTarget" -> Some InvalidTarget
  | "InvalidTypeNameException" -> Some InvalidTypeNameException
  | "InvalidUpdate" -> Some InvalidUpdate
  | "InvocationDoesNotExist" -> Some InvocationDoesNotExist
  | "ItemContentMismatchException" -> Some ItemContentMismatchException
  | "ItemSizeLimitExceededException" -> Some ItemSizeLimitExceededException
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MaxDocumentSizeExceeded" -> Some MaxDocumentSizeExceeded
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "OpsItemAlreadyExistsException" -> Some OpsItemAlreadyExistsException
  | "OpsItemInvalidParameterException" ->
      Some OpsItemInvalidParameterException
  | "OpsItemLimitExceededException" -> Some OpsItemLimitExceededException
  | "OpsItemNotFoundException" -> Some OpsItemNotFoundException
  | "OptInRequired" -> Some OptInRequired
  | "ParameterAlreadyExists" -> Some ParameterAlreadyExists
  | "ParameterLimitExceeded" -> Some ParameterLimitExceeded
  | "ParameterMaxVersionLimitExceeded" ->
      Some ParameterMaxVersionLimitExceeded
  | "ParameterNotFound" -> Some ParameterNotFound
  | "ParameterPatternMismatchException" ->
      Some ParameterPatternMismatchException
  | "ParameterVersionLabelLimitExceeded" ->
      Some ParameterVersionLabelLimitExceeded
  | "ParameterVersionNotFound" -> Some ParameterVersionNotFound
  | "PendingVerification" -> Some PendingVerification
  | "PoliciesLimitExceededException" -> Some PoliciesLimitExceededException
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ResourceDataSyncAlreadyExistsException" ->
      Some ResourceDataSyncAlreadyExistsException
  | "ResourceDataSyncConflictException" ->
      Some ResourceDataSyncConflictException
  | "ResourceDataSyncCountExceededException" ->
      Some ResourceDataSyncCountExceededException
  | "ResourceDataSyncInvalidConfigurationException" ->
      Some ResourceDataSyncInvalidConfigurationException
  | "ResourceDataSyncNotFoundException" ->
      Some ResourceDataSyncNotFoundException
  | "ResourceInUseException" -> Some ResourceInUseException
  | "ResourceLimitExceededException" -> Some ResourceLimitExceededException
  | "ServiceSettingNotFound" -> Some ServiceSettingNotFound
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "StatusUnchanged" -> Some StatusUnchanged
  | "SubTypeCountLimitExceededException" ->
      Some SubTypeCountLimitExceededException
  | "TargetInUseException" -> Some TargetInUseException
  | "TargetNotConnected" -> Some TargetNotConnected
  | "Throttling" -> Some Throttling
  | "TooManyTagsError" -> Some TooManyTagsError
  | "TooManyUpdates" -> Some TooManyUpdates
  | "TotalSizeLimitExceededException" -> Some TotalSizeLimitExceededException
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedCalendarException" -> Some UnsupportedCalendarException
  | "UnsupportedFeatureRequiredException" ->
      Some UnsupportedFeatureRequiredException
  | "UnsupportedInventoryItemContextException" ->
      Some UnsupportedInventoryItemContextException
  | "UnsupportedInventorySchemaVersionException" ->
      Some UnsupportedInventorySchemaVersionException
  | "UnsupportedOperatingSystem" -> Some UnsupportedOperatingSystem
  | "UnsupportedParameterType" -> Some UnsupportedParameterType
  | "UnsupportedPlatformType" -> Some UnsupportedPlatformType
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None