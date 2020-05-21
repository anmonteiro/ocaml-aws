(** "<p>Retrieve information about one or more parameters in a specific hierarchy. </p> <note> <p>Request results are returned on a best-effort basis. If you specify <code>MaxResults</code> in the request, the response includes information up to the limit specified. The number of items returned, however, can be between zero and the value of <code>MaxResults</code>. If the service reaches an internal limit while processing the results, it stops the operation and returns the matching values up to that point and a <code>NextToken</code>. You can specify the <code>NextToken</code> in a subsequent call to get the next set of results.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetParametersByPathRequest :
sig
  type t =
    {
    path: String.t ;
    recursive: Boolean.t option ;
    parameter_filters: ParameterStringFilterList.t ;
    with_decryption: Boolean.t option ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    path:String.t ->
      ?recursive:Boolean.t ->
        ?parameter_filters:ParameterStringFilterList.t ->
          ?with_decryption:Boolean.t ->
            ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module GetParametersByPathResult = GetParametersByPathResult
type input = GetParametersByPathRequest.t
type output = GetParametersByPathResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error