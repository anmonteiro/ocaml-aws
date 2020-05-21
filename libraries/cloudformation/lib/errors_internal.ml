type t =
  | AlreadyExistsException
  [@ocaml.doc "<p>The resource with the name requested already exists.</p>"]
  | AuthFailure 
  | Blocked 
  | CFNRegistryException
  [@ocaml.doc
    "<p>An error occurred during a CloudFormation registry operation.</p>"]
  | ChangeSetNotFound
  [@ocaml.doc
    "<p>The specified change set name or ID doesn't exit. To view valid change sets for a stack, use the <code>ListChangeSets</code> action.</p>"]
  | ConditionalCheckFailed
  [@ocaml.doc
    "<p>Error reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>. CloudFormation does not return this error to users.</p>"]
  | CreatedButModifiedException
  [@ocaml.doc "<p>The specified resource exists, but has been changed.</p>"]
  | DryRunOperation 
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InsufficientCapabilitiesException
  [@ocaml.doc
    "<p>The template contains resources with capabilities that weren't specified in the Capabilities parameter.</p>"]
  | InternalFailure 
  | InvalidAction 
  | InvalidChangeSetStatus
  [@ocaml.doc
    "<p>The specified change set can't be used to update the stack. For example, the change set status might be <code>CREATE_IN_PROGRESS</code>, or the stack status might be <code>UPDATE_IN_PROGRESS</code>.</p>"]
  | InvalidClientTokenId 
  | InvalidOperationException
  [@ocaml.doc "<p>The specified operation isn't valid.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterValue 
  | InvalidQueryParameter 
  | InvalidStateTransition
  [@ocaml.doc
    "<p>Error reserved for use by the <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html\">CloudFormation CLI</a>. CloudFormation does not return this error to users.</p>"]
  | LimitExceededException
  [@ocaml.doc
    "<p>The quota for the resource has already been reached.</p> <p>For information on resource and stack limitations, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html\">Limits</a> in the <i>AWS CloudFormation User Guide</i>.</p>"]
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | NameAlreadyExistsException
  [@ocaml.doc "<p>The specified name is already in use.</p>"]
  | OperationIdAlreadyExistsException
  [@ocaml.doc "<p>The specified operation ID already exists.</p>"]
  | OperationInProgressException
  [@ocaml.doc
    "<p>Another operation is currently in progress for this stack set. Only one operation can be performed for a stack set at a given time.</p>"]
  | OperationNotFoundException
  [@ocaml.doc
    "<p>The specified ID refers to an operation that doesn't exist.</p>"]
  | OptInRequired 
  | PendingVerification 
  | RequestExpired 
  | RequestLimitExceeded 
  | ServiceUnavailable 
  | StackInstanceNotFoundException
  [@ocaml.doc "<p>The specified stack instance doesn't exist.</p>"]
  | StackSetNotEmptyException
  [@ocaml.doc
    "<p>You can't yet delete this stack set, because it still contains one or more stack instances. Delete all stack instances from the stack set before deleting the stack set.</p>"]
  | StackSetNotFoundException
  [@ocaml.doc "<p>The specified stack set doesn't exist.</p>"]
  | StaleRequestException
  [@ocaml.doc
    "<p>Another operation has been performed on this stack set since the specified operation was performed. </p>"]
  | Throttling 
  | TokenAlreadyExistsException
  [@ocaml.doc "<p>A client request token already exists.</p>"]
  | TypeNotFoundException
  [@ocaml.doc
    "<p>The specified type does not exist in the CloudFormation registry.</p>"]
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
  | AlreadyExistsException -> Some 400
  | AuthFailure -> None
  | Blocked -> None
  | CFNRegistryException -> Some 400
  | ChangeSetNotFound -> Some 404
  | ConditionalCheckFailed -> Some 400
  | CreatedButModifiedException -> Some 409
  | DryRunOperation -> None
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InsufficientCapabilitiesException -> Some 400
  | InternalFailure -> Some 500
  | InvalidAction -> Some 400
  | InvalidChangeSetStatus -> Some 400
  | InvalidClientTokenId -> Some 403
  | InvalidOperationException -> Some 400
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | InvalidStateTransition -> Some 400
  | LimitExceededException -> Some 400
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | NameAlreadyExistsException -> Some 409
  | OperationIdAlreadyExistsException -> Some 409
  | OperationInProgressException -> Some 409
  | OperationNotFoundException -> Some 404
  | OptInRequired -> Some 403
  | PendingVerification -> None
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ServiceUnavailable -> Some 503
  | StackInstanceNotFoundException -> Some 404
  | StackSetNotEmptyException -> Some 409
  | StackSetNotFoundException -> Some 404
  | StaleRequestException -> Some 409
  | Throttling -> Some 400
  | TokenAlreadyExistsException -> Some 400
  | TypeNotFoundException -> Some 404
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AlreadyExistsException -> "AlreadyExistsException"
  | AuthFailure -> "AuthFailure"
  | Blocked -> "Blocked"
  | CFNRegistryException -> "CFNRegistryException"
  | ChangeSetNotFound -> "ChangeSetNotFound"
  | ConditionalCheckFailed -> "ConditionalCheckFailed"
  | CreatedButModifiedException -> "CreatedButModifiedException"
  | DryRunOperation -> "DryRunOperation"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InsufficientCapabilitiesException -> "InsufficientCapabilitiesException"
  | InternalFailure -> "InternalFailure"
  | InvalidAction -> "InvalidAction"
  | InvalidChangeSetStatus -> "InvalidChangeSetStatus"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidOperationException -> "InvalidOperationException"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | InvalidStateTransition -> "InvalidStateTransition"
  | LimitExceededException -> "LimitExceededException"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | NameAlreadyExistsException -> "NameAlreadyExistsException"
  | OperationIdAlreadyExistsException -> "OperationIdAlreadyExistsException"
  | OperationInProgressException -> "OperationInProgressException"
  | OperationNotFoundException -> "OperationNotFoundException"
  | OptInRequired -> "OptInRequired"
  | PendingVerification -> "PendingVerification"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ServiceUnavailable -> "ServiceUnavailable"
  | StackInstanceNotFoundException -> "StackInstanceNotFoundException"
  | StackSetNotEmptyException -> "StackSetNotEmptyException"
  | StackSetNotFoundException -> "StackSetNotFoundException"
  | StaleRequestException -> "StaleRequestException"
  | Throttling -> "Throttling"
  | TokenAlreadyExistsException -> "TokenAlreadyExistsException"
  | TypeNotFoundException -> "TypeNotFoundException"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AlreadyExistsException" -> Some AlreadyExistsException
  | "AuthFailure" -> Some AuthFailure
  | "Blocked" -> Some Blocked
  | "CFNRegistryException" -> Some CFNRegistryException
  | "ChangeSetNotFound" -> Some ChangeSetNotFound
  | "ConditionalCheckFailed" -> Some ConditionalCheckFailed
  | "CreatedButModifiedException" -> Some CreatedButModifiedException
  | "DryRunOperation" -> Some DryRunOperation
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InsufficientCapabilitiesException" ->
      Some InsufficientCapabilitiesException
  | "InternalFailure" -> Some InternalFailure
  | "InvalidAction" -> Some InvalidAction
  | "InvalidChangeSetStatus" -> Some InvalidChangeSetStatus
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidOperationException" -> Some InvalidOperationException
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "InvalidStateTransition" -> Some InvalidStateTransition
  | "LimitExceededException" -> Some LimitExceededException
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "NameAlreadyExistsException" -> Some NameAlreadyExistsException
  | "OperationIdAlreadyExistsException" ->
      Some OperationIdAlreadyExistsException
  | "OperationInProgressException" -> Some OperationInProgressException
  | "OperationNotFoundException" -> Some OperationNotFoundException
  | "OptInRequired" -> Some OptInRequired
  | "PendingVerification" -> Some PendingVerification
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "StackInstanceNotFoundException" -> Some StackInstanceNotFoundException
  | "StackSetNotEmptyException" -> Some StackSetNotEmptyException
  | "StackSetNotFoundException" -> Some StackSetNotFoundException
  | "StaleRequestException" -> Some StaleRequestException
  | "Throttling" -> Some Throttling
  | "TokenAlreadyExistsException" -> Some TokenAlreadyExistsException
  | "TypeNotFoundException" -> Some TypeNotFoundException
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None