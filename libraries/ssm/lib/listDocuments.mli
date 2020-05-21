(** "<p>Describes one or more of your Systems Manager documents.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ListDocumentsRequest :
sig
  type t =
    {
    document_filter_list: DocumentFilterList.t ;
    filters: DocumentKeyValuesFilterList.t ;
    max_results: Integer.t option ;
    next_token: String.t option }
  val make :
    ?document_filter_list:DocumentFilterList.t ->
      ?filters:DocumentKeyValuesFilterList.t ->
        ?max_results:Integer.t -> ?next_token:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module ListDocumentsResult = ListDocumentsResult
type input = ListDocumentsRequest.t
type output = ListDocumentsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error