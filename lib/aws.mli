(*----------------------------------------------------------------------------
    Copyright (c) 2016 Inhabited Type LLC.

    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    3. Neither the name of the author nor the names of his contributors
       may be used to endorse or promote products derived from this software
       without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE CONTRIBUTORS ``AS IS'' AND ANY EXPRESS
    OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE FOR
    ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
    DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
    OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
    HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
    STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
    ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.
  ----------------------------------------------------------------------------*)

(** This module contains code that is common across generated AWS
    libraries as well as pure code that is useful in writing runtime
    implementations for the AWS libraries. *)

(** This contains errors that are returned from AWS api calls. *)
module Error : sig

  (** An individual error returned from AWS. *)
  type 'a code =
    | Understood of 'a
    | Unknown of string

  (** Contents of a bad response error, containing the body of what
      could not be interpreted and a (potential) reason why. *)
  type bad_response = { body : string; message: string }

  (** An error_response is returned when an HTTP response returns with
      a non-2xx code. *)
  type 'a error_response =
    | BadResponse of bad_response
    (** A DadResponse is an error response that could not be parsed
        into AWS error data structures. *)
    | AwsError of ('a code * string) list
    (** An AwsError is a list of errors parsed out of XML returned in
        a non-2xx response. *)

  type 'a t =
    | TransportError of string
    (** TransportError indicate that an error occurred at the level of
        the HTTP request (and generally, nothing was returned). *)
    | HttpError of int * 'a error_response
    (** HttpError indicates that a response was recieved with an HTTP
        error code (non-2xx) *)

  (** Produces a string representation of an error, suitable for printing. *)
  val format : ('a -> string) -> 'a t -> string

  (** Given a string error response, produces (code,message) pairs. If the
      body can't be decoded, produces an `Error reason. This is used
      by runtime implementations in the case they get a non-success
      response code. *)
  val parse_aws_error : string -> [`Ok of (string * string) list | `Error of string ]
end


(** This contains the http-library agnostic representation of requests
    to be used by runtime implementations. *)
module Request : sig

  (** HTTP methods. This is (intentionally) compatible with
      Cohttp.Code.meth to make the cohttp-based runtime implementation
      easier. *)
  type meth =
    [ `DELETE
    | `GET
    | `HEAD
    | `OPTIONS
    | `CONNECT
    | `TRACE
    | `Other of string
    | `PATCH
    | `POST
    | `PUT ]

  (** Produces a string from the method. This is needed for AWS request signing. *)
  val string_of_meth : meth -> string

  (** HTTP headers. *)
  type headers = (string * string) list

  (** A request is a method, a uri, and a list of headers. *)
  type t = (meth * Uri.t * headers)

end

(** All AWS api operations should have type Call. Runtime
    implementation should take as input modules of type Call. *)
module type Call = sig

  (** The native OCaml datatype input to the Call. *)
  type input

  (** The native OCaml datatype that is produced as output to a
      successful Call. *)
  type output

  (** The native OCaml error type. This is shared between all calls
      for a single API. *)
  type error

  (** The AWS service, for example, 'ec2'. This is used for request
      signing, and to determine the endpoint to send the request. *)
  val service : string

  (** This function converts the native input into the HTTP request
      type. In particular, it is responsible for properly encoding the
      request type into query format. It also sets the Action and
      Version query parameters. *)
  val to_http : input -> Request.t

  (** This function converts from a HTTP response body to an output
      or an error if the response could not be decoded. *)
  val of_http : string -> [`Ok of output | `Error of error Error.error_response]

  (** This function parses an AWS error (which has been successfully
      deserialized from XML) into an API specific native error that
      could have been triggered by this call. It should fail to parse
      if the error it is given is not one of those listen in the
      specification, or if the passed HTTP status code does not match
      the specified one. *)
  val parse_error : int -> string -> error option
end

type ('i, 'o, 'e) call =
  (module Call with type input = 'i and type output = 'o and type error = 'e)

(** This module provides parsing / formatting for AWS style timestamps.
    For example: 2013-05-24T21:15:31.000Z
    It does not parse the milliseconds (it just truncates them). *)
module Time : sig

  (** Produce a Calendar.t from a string formatted like
      2013-05-24T21:15:31.000Z. Note that .000Z (or any milliseconds)
      are truncated.

      Raises 'Invalid_argument' if the string does not match the
      format. *)
  val parse : string -> CalendarLib.Calendar.t

  (** Formats a Calendar.t as 2013-05-24T21:15:31.000Z. Note that
      .000Z is always appended. *)
  val format : CalendarLib.Calendar.t -> string
end

(** This module is used to produce the nested url query structure used
    in AWS api requests. *)
module Query : sig

  (** The query type. In the following examples, constructors are
      ellided for brevity.

      Structs are encoded as [(name1, val); (name2, val)...].

      Lists are encoded as [(0, val); (1, val)...]. *)
  type t =
    | List of t list
    | Pair of (string * t)
    | Value of string option

  (** This is how to turn a Query.t into a string suitable for
      including in a url. It is a query string, ie
      field=val&field=val... *)
  val render : t -> string

  (** This is a helper to convert a list into a Query.t. It encodes it
      as [(0, val); (1, val)...]. *)
  val to_query_list : ('a -> t) -> 'a list -> t

  val to_query_hashtbl : ('a -> t) -> (string, 'a) Hashtbl.t -> t
end

module Headers : sig
  type t =
    | List of t list
    | Pair of (string * t)
    | Value of string option

  val render : t -> Request.headers

  val to_headers_list : ('a -> t) -> 'a list -> t

  val to_headers_hashtbl : ('a -> t) -> (string, 'a) Hashtbl.t -> t
end

(** This module contains helpers used for XML parsing. It wraps Ezxmlm
    and adds helpers. *)
module Xml : sig

  (** This is thrown when parsing XML responses. It will be caught in
      response handlers (M.of_http for api call M) and turned into an
      Error.t *)
  exception RequiredFieldMissing of string

  (** This function is identical to Ezxmlm.member except that in the
      case of an Ezxmlm.Tag_not_found exception it returns None. *)
  val member : string -> Ezxmlm.nodes -> Ezxmlm.nodes option

  (** This function is identical to Ezxmlm.members except in the case
      of an Ezxmlm.Tag_not_found exception it returns []. *)
  val members : string -> Ezxmlm.nodes -> Ezxmlm.nodes list

  (** This takes an error message and option time, and throws a
      RequiredFieldMissing exception (not exported) if the value is
      None. *)
  val required : string -> 'a option -> 'a

end

(** This module contains a Json type (compatible with
    Yojson.Basic.json) and helpers. *)
module Json : sig
  (** Json type. This is compatible with Yojson.Basic.json *)
  type t =
    [ `Assoc of (string * t) list
    | `Bool of bool
    | `Float of float
    | `Int of int
    | `List of t list
    | `Null
    | `String of string ]

  (** This is thrown in the case that an unsafe cast (like to_list
      below) fails. *)
  exception Casting_error of string * t

  (** This converts a `List (t list) to 't list, or throws a
      Casting_error in the case that the input is not a `List. *)
  val to_list : (t -> 't) -> t -> 't list

  (** This converts an `Assoc (string * t list) to ('a, 'b) Hashtbl.t, or throws a
      Casting_error in the case that the input is not an `Assoc. *)
  val to_hashtbl: (t -> 'b) -> t -> (string, 'b) Hashtbl.t
        
  (** If t is an `Assoc, this looks up the field specified. If it
      isn't found, or if the input is not an `Assoc, returns None. *)
  val lookup : t -> string -> t option
end

(** This module contains various helpers used in generated code. *)
module Util : sig

  (** Filters an association list, dropping any pairs where the key is
      the empty string. *)
  val drop_empty : (string * 'a) list -> (string * 'a) list

  (** If input is Some a, produces `Ok a, else produces `Error b. *)
  val or_error : 'a option -> 'b -> [`Ok of 'a | `Error of 'b]

  (** Produces the default if the option is None, else the value. *)
  val of_option : 'a -> 'a option -> 'a

  (** Produces a if Some a, else throws Failure. *)
  val of_option_exn : 'a option -> 'a

  (** Looks for key 'a in association list, producing None if it isn't
      there. *)
  val list_find : ('a * 'b) list -> 'a -> 'b option

  (** Returns list of values that were Some v. *)
  val list_filter_opt : 'a option list -> 'a list

  (** If a is Some a, applies function. Else, produce None. *)
  val option_bind : 'a option -> ('a -> 'b option) -> 'b option

  (** Applies function to value is Some, else just produce None. *)
  val option_map : 'a option -> ('a -> 'b) -> 'b option

  (** If all values in list are Some v, produce Some (list_filter_opt
      list), else produce None. *)
  val option_all : 'a option list -> 'a list option
end

(** This module contains the V4 Authorization header AWS signature
    algorithm. *)
module Signing : sig

  (** Given a service, region, and request, produce a new request with
      an Authorization header constructed according to the V4 Signing
      algorithm. This code is a direct translation of the reference implementation
      from python provided at:

      http://docs.aws.amazon.com/general/latest/gr/sigv4-signed-request-examples.html

      Note: This requires AWS_ACCESS_KEY and AWS_SECRET_KEY
      environment variables to be set.

      Also: Your system time must be accurate. If you are getting invalid
      authorization errors, check your system time!
  *)
  val sign_request :
    access_key:string ->
    secret_key:string ->
    service:string ->
    region:string ->
    Request.t -> Request.t
end

(** This module contains base case types for the various datatypes
    used as input or output by AWS api calls. *)
module BaseTypes : sig
  module type Base = sig
    type t
    val to_json : t -> Json.t
    val of_json : Json.t -> t
    val to_query : t -> Query.t
    val to_headers : t -> Headers.t
    val parse : Ezxmlm.nodes -> t option
  end

  module Unit     : Base with type t = unit
  module String   : Base with type t = string
  module Blob     : Base with type t = string
  module Boolean  : Base with type t = bool
  module Integer  : Base with type t = int
  module Long     : Base with type t = int
  module Double   : Base with type t = float
  module Float    : Base with type t = float
  module DateTime : Base with type t = CalendarLib.Calendar.t
end
