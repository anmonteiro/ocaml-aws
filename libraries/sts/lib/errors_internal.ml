type t =
  | AuthFailure 
  | Blocked 
  | DryRunOperation 
  | ExpiredTokenException
  [@ocaml.doc
    "<p>The web identity token that was passed is expired or is not valid. Get a new identity token from the identity provider and then retry the request.</p>"]
  | IDPCommunicationError
  [@ocaml.doc
    "<p>The request could not be fulfilled because the identity provider (IDP) that was asked to verify the incoming identity token could not be reached. This is often a transient error caused by network conditions. Retry the request a limited number of times so that you don't exceed the request rate. If the error persists, the identity provider might be down or not responding.</p>"]
  | IDPRejectedClaim
  [@ocaml.doc
    "<p>The identity provider (IdP) reported that authentication failed. This might be because the claim is invalid.</p> <p>If this error is returned for the <code>AssumeRoleWithWebIdentity</code> operation, it can also mean that the claim has expired or has been explicitly revoked. </p>"]
  | IdempotentParameterMismatch 
  | IncompleteSignature 
  | InternalFailure 
  | InvalidAction 
  | InvalidAuthorizationMessageException
  [@ocaml.doc
    "<p>The error returned if the message passed to <code>DecodeAuthorizationMessage</code> was invalid. This can happen if the token contains invalid characters, such as linebreaks. </p>"]
  | InvalidClientTokenId 
  | InvalidIdentityToken
  [@ocaml.doc
    "<p>The web identity token that was passed could not be validated by AWS. Get a new identity token from the identity provider and then retry the request.</p>"]
  | InvalidParameter 
  | InvalidParameterCombination 
  | InvalidParameterValue 
  | InvalidQueryParameter 
  | MalformedPolicyDocument
  [@ocaml.doc
    "<p>The request was rejected because the policy document was malformed. The error message describes the specific error.</p>"]
  | MalformedQueryString 
  | MissingAction 
  | MissingAuthenticationToken 
  | MissingParameter 
  | OptInRequired 
  | PackedPolicyTooLarge
  [@ocaml.doc
    "<p>The request was rejected because the total packed size of the session policies and session tags combined was too large. An AWS conversion compresses the session policy document, session policy ARNs, and session tags into a packed binary format that has a separate limit. The error message indicates by percentage how close the policies and tags are to the upper size limit. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_session-tags.html\">Passing Session Tags in STS</a> in the <i>IAM User Guide</i>.</p> <p>You could receive this error even though you meet other defined session policy and session tag limits. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html\">IAM and STS Entity Character Limits</a> in the <i>IAM User Guide</i>.</p>"]
  | PendingVerification 
  | RegionDisabledException
  [@ocaml.doc
    "<p>STS is not activated in the requested region for the account that is being asked to generate credentials. The account administrator must use the IAM console to activate STS in that region. For more information, see <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_enable-regions.html\">Activating and Deactivating AWS STS in an AWS Region</a> in the <i>IAM User Guide</i>.</p>"]
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
  | AuthFailure -> None
  | Blocked -> None
  | DryRunOperation -> None
  | ExpiredTokenException -> Some 400
  | IDPCommunicationError -> Some 400
  | IDPRejectedClaim -> Some 403
  | IdempotentParameterMismatch -> None
  | IncompleteSignature -> Some 400
  | InternalFailure -> Some 500
  | InvalidAction -> Some 400
  | InvalidAuthorizationMessageException -> Some 400
  | InvalidClientTokenId -> Some 403
  | InvalidIdentityToken -> Some 400
  | InvalidParameter -> None
  | InvalidParameterCombination -> Some 400
  | InvalidParameterValue -> Some 400
  | InvalidQueryParameter -> Some 400
  | MalformedPolicyDocument -> Some 400
  | MalformedQueryString -> Some 404
  | MissingAction -> Some 400
  | MissingAuthenticationToken -> Some 403
  | MissingParameter -> Some 400
  | OptInRequired -> Some 403
  | PackedPolicyTooLarge -> Some 400
  | PendingVerification -> None
  | RegionDisabledException -> Some 403
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
  | AuthFailure -> "AuthFailure"
  | Blocked -> "Blocked"
  | DryRunOperation -> "DryRunOperation"
  | ExpiredTokenException -> "ExpiredTokenException"
  | IDPCommunicationError -> "IDPCommunicationError"
  | IDPRejectedClaim -> "IDPRejectedClaim"
  | IdempotentParameterMismatch -> "IdempotentParameterMismatch"
  | IncompleteSignature -> "IncompleteSignature"
  | InternalFailure -> "InternalFailure"
  | InvalidAction -> "InvalidAction"
  | InvalidAuthorizationMessageException ->
      "InvalidAuthorizationMessageException"
  | InvalidClientTokenId -> "InvalidClientTokenId"
  | InvalidIdentityToken -> "InvalidIdentityToken"
  | InvalidParameter -> "InvalidParameter"
  | InvalidParameterCombination -> "InvalidParameterCombination"
  | InvalidParameterValue -> "InvalidParameterValue"
  | InvalidQueryParameter -> "InvalidQueryParameter"
  | MalformedPolicyDocument -> "MalformedPolicyDocument"
  | MalformedQueryString -> "MalformedQueryString"
  | MissingAction -> "MissingAction"
  | MissingAuthenticationToken -> "MissingAuthenticationToken"
  | MissingParameter -> "MissingParameter"
  | OptInRequired -> "OptInRequired"
  | PackedPolicyTooLarge -> "PackedPolicyTooLarge"
  | PendingVerification -> "PendingVerification"
  | RegionDisabledException -> "RegionDisabledException"
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
  | "AuthFailure" -> Some AuthFailure
  | "Blocked" -> Some Blocked
  | "DryRunOperation" -> Some DryRunOperation
  | "ExpiredTokenException" -> Some ExpiredTokenException
  | "IDPCommunicationError" -> Some IDPCommunicationError
  | "IDPRejectedClaim" -> Some IDPRejectedClaim
  | "IdempotentParameterMismatch" -> Some IdempotentParameterMismatch
  | "IncompleteSignature" -> Some IncompleteSignature
  | "InternalFailure" -> Some InternalFailure
  | "InvalidAction" -> Some InvalidAction
  | "InvalidAuthorizationMessageException" ->
      Some InvalidAuthorizationMessageException
  | "InvalidClientTokenId" -> Some InvalidClientTokenId
  | "InvalidIdentityToken" -> Some InvalidIdentityToken
  | "InvalidParameter" -> Some InvalidParameter
  | "InvalidParameterCombination" -> Some InvalidParameterCombination
  | "InvalidParameterValue" -> Some InvalidParameterValue
  | "InvalidQueryParameter" -> Some InvalidQueryParameter
  | "MalformedPolicyDocument" -> Some MalformedPolicyDocument
  | "MalformedQueryString" -> Some MalformedQueryString
  | "MissingAction" -> Some MissingAction
  | "MissingAuthenticationToken" -> Some MissingAuthenticationToken
  | "MissingParameter" -> Some MissingParameter
  | "OptInRequired" -> Some OptInRequired
  | "PackedPolicyTooLarge" -> Some PackedPolicyTooLarge
  | "PendingVerification" -> Some PendingVerification
  | "RegionDisabledException" -> Some RegionDisabledException
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