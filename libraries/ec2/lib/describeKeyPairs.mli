(** "<p>Describes the specified key pairs or all of your key pairs.</p> <p>For more information about key pairs, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html\">Key Pairs</a> in the <i>Amazon Elastic Compute Cloud User Guide</i>.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeKeyPairsRequest :
sig
  type t =
    {
    filters: FilterList.t ;
    key_names: KeyNameStringList.t ;
    key_pair_ids: KeyPairIdStringList.t ;
    dry_run: Boolean.t option }
  val make :
    ?filters:FilterList.t ->
      ?key_names:KeyNameStringList.t ->
        ?key_pair_ids:KeyPairIdStringList.t ->
          ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module DescribeKeyPairsResult = DescribeKeyPairsResult
type input = DescribeKeyPairsRequest.t
type output = DescribeKeyPairsResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error