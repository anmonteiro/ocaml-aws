(** "<p>Describes one or more of your DHCP options sets.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html\">DHCP Options Sets</a> in the <i>Amazon Virtual Private Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeDhcpOptionsRequest :
sig
  type t =
    {
    dhcp_options_ids: DhcpOptionsIdStringList.t ;
    filters: FilterList.t ;
    dry_run: Boolean.t option ;
    next_token: String.t option ;
    max_results: Integer.t option }
  val make :
    ?dhcp_options_ids:DhcpOptionsIdStringList.t ->
      ?filters:FilterList.t ->
        ?dry_run:Boolean.t ->
          ?next_token:String.t -> ?max_results:Integer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeDhcpOptionsResult = DescribeDhcpOptionsResult
type input = DescribeDhcpOptionsRequest.t
type output = DescribeDhcpOptionsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error