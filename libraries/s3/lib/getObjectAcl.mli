(** "<p>Returns the access control list (ACL) of an object. To use this operation, you must have READ_ACP access to the object.</p> <p> <b>Versioning</b> </p> <p>By default, GET returns ACL information about the current version of an object. To return ACL information about a different version, use the versionId subresource.</p> <p>The following operations are related to <code>GetObjectAcl</code>:</p> <ul> <li> <p> <a>GetObject</a> </p> </li> <li> <p> <a>DeleteObject</a> </p> </li> <li> <p> <a>PutObject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetObjectAclRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    version_id: String.t option ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      key:String.t ->
        ?version_id:String.t -> ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetObjectAclOutput = GetObjectAclOutput
type input = GetObjectAclRequest.t
type output = GetObjectAclOutput.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error