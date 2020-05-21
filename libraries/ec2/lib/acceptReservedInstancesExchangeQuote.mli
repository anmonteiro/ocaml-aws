(** "<p>Accepts the Convertible Reserved Instance exchange quote described in the <a>GetReservedInstancesExchangeQuote</a> call.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module AcceptReservedInstancesExchangeQuoteRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    reserved_instance_ids: ReservedInstanceIdSet.t ;
    target_configurations: TargetConfigurationRequestSet.t }[@@ocaml.doc
                                                              "<p>Contains the parameters for accepting the quote.</p>"]
  val make :
    ?dry_run:Boolean.t ->
      reserved_instance_ids:ReservedInstanceIdSet.t ->
        ?target_configurations:TargetConfigurationRequestSet.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module AcceptReservedInstancesExchangeQuoteResult =
AcceptReservedInstancesExchangeQuoteResult
type input = AcceptReservedInstancesExchangeQuoteRequest.t
type output = AcceptReservedInstancesExchangeQuoteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error