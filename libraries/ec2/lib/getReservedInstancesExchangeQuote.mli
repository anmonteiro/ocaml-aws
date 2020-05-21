(** "<p>Returns a quote and exchange information for exchanging one or more specified Convertible Reserved Instances for a new Convertible Reserved Instance. If the exchange cannot be performed, the reason is returned in the response. Use <a>AcceptReservedInstancesExchangeQuote</a> to perform the exchange.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetReservedInstancesExchangeQuoteRequest :
sig
  type t =
    {
    dry_run: Boolean.t option ;
    reserved_instance_ids: ReservedInstanceIdSet.t ;
    target_configurations: TargetConfigurationRequestSet.t }[@@ocaml.doc
                                                              "<p>Contains the parameters for GetReservedInstanceExchangeQuote.</p>"]
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
module GetReservedInstancesExchangeQuoteResult =
GetReservedInstancesExchangeQuoteResult
type input = GetReservedInstancesExchangeQuoteRequest.t
type output = GetReservedInstancesExchangeQuoteResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error