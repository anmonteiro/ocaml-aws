type t =
  | AuthFailure 
  | Blocked 
  | ConcurrentModificationException
  [@ocaml.doc
    "<p>More than one process tried to modify a resource at the same time.</p>"]
  | DryRunOperation 
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InternalFailure 
  | InternalServiceError
  [@ocaml.doc
    "<p>Request processing has failed due to some unknown error, exception, or failure.</p>"]
  | InvalidAction 
  | InvalidClientTokenId 
  | InvalidFormat
  [@ocaml.doc "<p>Data was not syntactically valid JSON.</p>"]
  | InvalidNextToken
  [@ocaml.doc "<p>The next token specified is invalid.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination
  [@ocaml.doc
    "<p>Parameters were used together that cannot be used together.</p>"]
  | InvalidParameterInput
  [@ocaml.doc "<p>Some part of the dashboard data is invalid.</p>"]
  | InvalidParameterValue
  [@ocaml.doc
    "<p>The value of an input parameter is bad or out-of-range.</p>"]
  | InvalidQueryParameter 
  | LimitExceeded
  [@ocaml.doc
    "<p>The quota for alarms for this customer has already been reached.</p>"]
  | LimitExceededException
  [@ocaml.doc "<p>The operation exceeded one or more limits.</p>"]
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter
  [@ocaml.doc "<p>An input parameter that is required is missing.</p>"]
  | OptInRequired 
  | PendingVerification 
  | RequestExpired 
  | RequestLimitExceeded 
  | ResourceNotFound
  [@ocaml.doc "<p>The specified dashboard does not exist.</p>"]
  | ResourceNotFoundException
  [@ocaml.doc "<p>The named resource does not exist.</p>"]
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
  | AuthFailure -> None
  | Blocked -> None
  | ConcurrentModificationException -> Some 429
  | DryRunOperation -> None
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InternalFailure -> Some 500
  | InternalServiceError -> Some 500
  | InvalidAction -> Some 400
  | InvalidClientTokenId -> Some 403
  | InvalidFormat -> Some 400
  | InvalidNextToken -> Some 400
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterInput -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | LimitExceeded -> Some 400
  | LimitExceededException -> Some 400
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | OptInRequired -> Some 403
  | PendingVerification -> None
  | RequestExpired -> Some 400
  | RequestLimitExceeded -> None
  | ResourceNotFound -> Some 404
  | ResourceNotFoundException -> Some 404
  | ServiceUnavailable -> Some 503
  | Throttling -> Some 400
  | UnauthorizedOperation -> None
  | UnknownParameter -> None
  | UnsupportedProtocol -> None
  | ValidationError -> Some 400
  | Uninhabited -> None
let to_string e =
  match e with
  | AuthFailure -> "AuthFailure"
  | Blocked -> "Blocked"
  | ConcurrentModificationException -> "ConcurrentModificationException"
  | DryRunOperation -> "DryRunOperation"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InternalFailure -> "InternalFailure"
  | InternalServiceError -> "InternalServiceError"
  | InvalidAction -> "InvalidAction"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidFormat -> "InvalidFormat"
  | InvalidNextToken -> "InvalidNextToken"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterInput -> "InvalidParameterInput"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | LimitExceeded -> "LimitExceeded"
  | LimitExceededException -> "LimitExceededException"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | OptInRequired -> "OptInRequired"
  | PendingVerification -> "PendingVerification"
  | RequestExpired -> "RequestExpired"
  | RequestLimitExceeded -> "RequestLimitExceeded"
  | ResourceNotFound -> "ResourceNotFound"
  | ResourceNotFoundException -> "ResourceNotFoundException"
  | ServiceUnavailable -> "ServiceUnavailable"
  | Throttling -> "Throttling"
  | UnauthorizedOperation -> "UnauthorizedOperation"
  | UnknownParameter -> "UnknownParameter"
  | UnsupportedProtocol -> "UnsupportedProtocol"
  | ValidationError -> "ValidationError"
  | Uninhabited -> "Uninhabited"
let of_string e =
  match e with
  | "AuthFailure" -> Some AuthFailure
  | "Blocked" -> Some Blocked
  | "ConcurrentModificationException" -> Some ConcurrentModificationException
  | "DryRunOperation" -> Some DryRunOperation
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InternalFailure" -> Some InternalFailure
  | "InternalServiceError" -> Some InternalServiceError
  | "InvalidAction" -> Some InvalidAction
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidFormat" -> Some InvalidFormat
  | "InvalidNextToken" -> Some InvalidNextToken
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterInput" -> Some InvalidParameterInput
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "LimitExceeded" -> Some LimitExceeded
  | "LimitExceededException" -> Some LimitExceededException
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "OptInRequired" -> Some OptInRequired
  | "PendingVerification" -> Some PendingVerification
  | "RequestExpired" -> Some RequestExpired
  | "RequestLimitExceeded" -> Some RequestLimitExceeded
  | "ResourceNotFound" -> Some ResourceNotFound
  | "ResourceNotFoundException" -> Some ResourceNotFoundException
  | "ServiceUnavailable" -> Some ServiceUnavailable
  | "Throttling" -> Some Throttling
  | "UnauthorizedOperation" -> Some UnauthorizedOperation
  | "UnknownParameter" -> Some UnknownParameter
  | "UnsupportedProtocol" -> Some UnsupportedProtocol
  | "ValidationError" -> Some ValidationError
  | "Uninhabited" -> Some Uninhabited
  | _ -> None