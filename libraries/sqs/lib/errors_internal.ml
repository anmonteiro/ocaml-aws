type t =
  | AWS_SimpleQueueService_BatchEntryIdsNotDistinct
  [@ocaml.doc
    "<p>Two or more batch entries in the request have the same <code>Id</code>.</p>"]
  | AWS_SimpleQueueService_BatchRequestTooLong
  [@ocaml.doc
    "<p>The length of all the messages put together is more than the limit.</p>"]
  | AWS_SimpleQueueService_EmptyBatchRequest
  [@ocaml.doc "<p>The batch request doesn't contain any entries.</p>"]
  | AWS_SimpleQueueService_InvalidBatchEntryId
  [@ocaml.doc
    "<p>The <code>Id</code> of a batch entry in a batch request doesn't abide by the specification.</p>"]
  | AWS_SimpleQueueService_MessageNotInflight
  [@ocaml.doc "<p>The specified message isn't in flight.</p>"]
  | AWS_SimpleQueueService_NonExistentQueue
  [@ocaml.doc "<p>The specified queue doesn't exist.</p>"]
  | AWS_SimpleQueueService_PurgeQueueInProgress
  [@ocaml.doc
    "<p>Indicates that the specified queue previously received a <code>PurgeQueue</code> request within the last 60 seconds (the time it can take to delete the messages in the queue).</p>"]
  | AWS_SimpleQueueService_QueueDeletedRecently
  [@ocaml.doc
    "<p>You must wait 60 seconds after deleting a queue before you can create another queue with the same name.</p>"]
  | AWS_SimpleQueueService_TooManyEntriesInBatchRequest
  [@ocaml.doc
    "<p>The batch request contains more entries than permissible.</p>"]
  | AWS_SimpleQueueService_UnsupportedOperation
  [@ocaml.doc "<p>Error code 400. Unsupported operation.</p>"]
  | AuthFailure 
  | Blocked 
  | DryRunOperation 
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InternalFailure 
  | InvalidAction 
  | InvalidAttributeName
  [@ocaml.doc "<p>The specified attribute doesn't exist.</p>"]
  | InvalidClientTokenId 
  | InvalidIdFormat
  [@ocaml.doc
    "<p>The specified receipt handle isn't valid for the current version.</p>"]
  | InvalidMessageContents
  [@ocaml.doc
    "<p>The message contains characters outside the allowed set.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterValue 
  | InvalidQueryParameter 
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | OptInRequired 
  | OverLimit
  [@ocaml.doc
    "<p>The specified action violates a limit. For example, <code>ReceiveMessage</code> returns this error if the maximum number of inflight messages is reached and <code>AddPermission</code> returns this error if the maximum number of permissions for the queue is reached.</p>"]
  | PendingVerification 
  | QueueAlreadyExists
  [@ocaml.doc
    "<p>A queue with this name already exists. Amazon SQS returns this error only if the request includes attributes whose values differ from those of the existing queue.</p>"]
  | ReceiptHandleIsInvalid
  [@ocaml.doc "<p>The specified receipt handle isn't valid.</p>"]
  | RequestExpired 
  | RequestLimitExceeded 
  | ServiceUnavailable 
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
  | AWS_SimpleQueueService_BatchEntryIdsNotDistinct -> Some 400
  | AWS_SimpleQueueService_BatchRequestTooLong -> Some 400
  | AWS_SimpleQueueService_EmptyBatchRequest -> Some 400
  | AWS_SimpleQueueService_InvalidBatchEntryId -> Some 400
  | AWS_SimpleQueueService_MessageNotInflight -> Some 400
  | AWS_SimpleQueueService_NonExistentQueue -> Some 400
  | AWS_SimpleQueueService_PurgeQueueInProgress -> Some 403
  | AWS_SimpleQueueService_QueueDeletedRecently -> Some 400
  | AWS_SimpleQueueService_TooManyEntriesInBatchRequest -> Some 400
  | AWS_SimpleQueueService_UnsupportedOperation -> Some 400
  | AuthFailure -> None
  | Blocked -> None
  | DryRunOperation -> None
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InternalFailure -> Some 500
  | InvalidAction -> Some 400
  | InvalidAttributeName -> None
  | InvalidClientTokenId -> Some 403
  | InvalidIdFormat -> None
  | InvalidMessageContents -> None
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | OptInRequired -> Some 403
  | OverLimit -> Some 403
  | PendingVerification -> None
  | QueueAlreadyExists -> Some 400
  | ReceiptHandleIsInvalid -> None
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ServiceUnavailable -> Some 503
  | Throttling -> Some 400
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AWS_SimpleQueueService_BatchEntryIdsNotDistinct ->
      "AWS.SimpleQueueService.BatchEntryIdsNotDistinct"
  | AWS_SimpleQueueService_BatchRequestTooLong ->
      "AWS.SimpleQueueService.BatchRequestTooLong"
  | AWS_SimpleQueueService_EmptyBatchRequest ->
      "AWS.SimpleQueueService.EmptyBatchRequest"
  | AWS_SimpleQueueService_InvalidBatchEntryId ->
      "AWS.SimpleQueueService.InvalidBatchEntryId"
  | AWS_SimpleQueueService_MessageNotInflight ->
      "AWS.SimpleQueueService.MessageNotInflight"
  | AWS_SimpleQueueService_NonExistentQueue ->
      "AWS.SimpleQueueService.NonExistentQueue"
  | AWS_SimpleQueueService_PurgeQueueInProgress ->
      "AWS.SimpleQueueService.PurgeQueueInProgress"
  | AWS_SimpleQueueService_QueueDeletedRecently ->
      "AWS.SimpleQueueService.QueueDeletedRecently"
  | AWS_SimpleQueueService_TooManyEntriesInBatchRequest ->
      "AWS.SimpleQueueService.TooManyEntriesInBatchRequest"
  | AWS_SimpleQueueService_UnsupportedOperation ->
      "AWS.SimpleQueueService.UnsupportedOperation"
  | AuthFailure -> "AuthFailure"
  | Blocked -> "Blocked"
  | DryRunOperation -> "DryRunOperation"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InternalFailure -> "InternalFailure"
  | InvalidAction -> "InvalidAction"
  | InvalidAttributeName -> "InvalidAttributeName"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidIdFormat -> "InvalidIdFormat"
  | InvalidMessageContents -> "InvalidMessageContents"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | OptInRequired -> "OptInRequired"
  | OverLimit -> "OverLimit"
  | PendingVerification -> "PendingVerification"
  | QueueAlreadyExists -> "QueueAlreadyExists"
  | ReceiptHandleIsInvalid -> "ReceiptHandleIsInvalid"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ServiceUnavailable -> "ServiceUnavailable"
  | Throttling -> "Throttling"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AWS.SimpleQueueService.BatchEntryIdsNotDistinct" ->
      Some AWS_SimpleQueueService_BatchEntryIdsNotDistinct
  | "AWS.SimpleQueueService.BatchRequestTooLong" ->
      Some AWS_SimpleQueueService_BatchRequestTooLong
  | "AWS.SimpleQueueService.EmptyBatchRequest" ->
      Some AWS_SimpleQueueService_EmptyBatchRequest
  | "AWS.SimpleQueueService.InvalidBatchEntryId" ->
      Some AWS_SimpleQueueService_InvalidBatchEntryId
  | "AWS.SimpleQueueService.MessageNotInflight" ->
      Some AWS_SimpleQueueService_MessageNotInflight
  | "AWS.SimpleQueueService.NonExistentQueue" ->
      Some AWS_SimpleQueueService_NonExistentQueue
  | "AWS.SimpleQueueService.PurgeQueueInProgress" ->
      Some AWS_SimpleQueueService_PurgeQueueInProgress
  | "AWS.SimpleQueueService.QueueDeletedRecently" ->
      Some AWS_SimpleQueueService_QueueDeletedRecently
  | "AWS.SimpleQueueService.TooManyEntriesInBatchRequest" ->
      Some AWS_SimpleQueueService_TooManyEntriesInBatchRequest
  | "AWS.SimpleQueueService.UnsupportedOperation" ->
      Some AWS_SimpleQueueService_UnsupportedOperation
  | "AuthFailure" -> Some AuthFailure
  | "Blocked" -> Some Blocked
  | "DryRunOperation" -> Some DryRunOperation
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InternalFailure" -> Some InternalFailure
  | "InvalidAction" -> Some InvalidAction
  | "InvalidAttributeName" -> Some InvalidAttributeName
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidIdFormat" -> Some InvalidIdFormat
  | "InvalidMessageContents" -> Some InvalidMessageContents
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "OptInRequired" -> Some OptInRequired
  | "OverLimit" -> Some OverLimit
  | "PendingVerification" -> Some PendingVerification
  | "QueueAlreadyExists" -> Some QueueAlreadyExists
  | "ReceiptHandleIsInvalid" -> Some ReceiptHandleIsInvalid
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "Throttling" -> Some Throttling
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None