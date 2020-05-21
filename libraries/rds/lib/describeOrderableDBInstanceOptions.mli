(** "<p>Returns a list of orderable DB instance options for the specified engine.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module DescribeOrderableDBInstanceOptionsMessage :
sig
  type t =
    {
    engine: String.t ;
    engine_version: String.t option ;
    d_b_instance_class: String.t option ;
    license_model: String.t option ;
    vpc: Boolean.t option ;
    filters: FilterList.t ;
    max_records: Integer.t option ;
    marker: String.t option }[@@ocaml.doc "<p/>"]
  val make :
    engine:String.t ->
      ?engine_version:String.t ->
        ?d_b_instance_class:String.t ->
          ?license_model:String.t ->
            ?vpc:Boolean.t ->
              ?filters:FilterList.t ->
                ?max_records:Integer.t -> ?marker:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module OrderableDBInstanceOptionsMessage = OrderableDBInstanceOptionsMessage
type input = DescribeOrderableDBInstanceOptionsMessage.t
type output = OrderableDBInstanceOptionsMessage.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error