(** "<p>Initiates a connection to a target (for example, an instance) for a Session Manager session. Returns a URL and token that can be used to open a WebSocket connection for sending input and receiving outputs.</p> <note> <p>AWS CLI usage: <code>start-session</code> is an interactive command that requires the Session Manager plugin to be installed on the client machine making the call. For information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html\"> Install the Session Manager Plugin for the AWS CLI</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>AWS Tools for PowerShell usage: Start-SSMSession is not currently supported by AWS Tools for PowerShell on Windows local machines.</p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module StartSessionRequest :
sig
  type t =
    {
    target: String.t ;
    document_name: String.t option ;
    parameters: SessionManagerParameters.t option }
  val make :
    target:String.t ->
      ?document_name:String.t ->
        ?parameters:SessionManagerParameters.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module StartSessionResponse = StartSessionResponse
type input = StartSessionRequest.t
type output = StartSessionResponse.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error