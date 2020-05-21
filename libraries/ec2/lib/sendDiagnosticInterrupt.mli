(** "<p>Sends a diagnostic interrupt to the specified Amazon EC2 instance to trigger a <i>kernel panic</i> (on Linux instances), or a <i>blue screen</i>/<i>stop error</i> (on Windows instances). For instances based on Intel and AMD processors, the interrupt is received as a <i>non-maskable interrupt</i> (NMI).</p> <p>In general, the operating system crashes and reboots when a kernel panic or stop error is triggered. The operating system can also be configured to perform diagnostic tasks, such as generating a memory dump file, loading a secondary kernel, or obtaining a call trace.</p> <p>Before sending a diagnostic interrupt to your instance, ensure that its operating system is configured to perform the required diagnostic tasks.</p> <p>For more information about configuring your operating system to generate a crash dump when a kernel panic or stop error occurs, see <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/diagnostic-interrupt.html\">Send a Diagnostic Interrupt</a> (Linux instances) or <a href=\"https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/diagnostic-interrupt.html\">Send a Diagnostic Interrupt</a> (Windows instances).</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module SendDiagnosticInterruptRequest :
sig
  type t = {
    instance_id: String.t ;
    dry_run: Boolean.t option }
  val make : instance_id:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = SendDiagnosticInterruptRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error