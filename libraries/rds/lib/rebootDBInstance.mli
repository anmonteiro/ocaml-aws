(** "<p>You might need to reboot your DB instance, usually for maintenance reasons. For example, if you make certain modifications, or if you change the DB parameter group associated with the DB instance, you must reboot the instance for the changes to take effect. </p> <p>Rebooting a DB instance restarts the database engine service. Rebooting a DB instance results in a momentary outage, during which the DB instance status is set to rebooting. </p> <p>For more information about rebooting, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_RebootInstance.html\">Rebooting a DB Instance</a> in the <i>Amazon RDS User Guide.</i> </p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module RebootDBInstanceMessage :
sig
  type t =
    {
    d_b_instance_identifier: String.t ;
    force_failover: Boolean.t option }[@@ocaml.doc "<p/>"]
  val make :
    d_b_instance_identifier:String.t ->
      ?force_failover:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module RebootDBInstanceResult = RebootDBInstanceResult
type input = RebootDBInstanceMessage.t
type output = RebootDBInstanceResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error