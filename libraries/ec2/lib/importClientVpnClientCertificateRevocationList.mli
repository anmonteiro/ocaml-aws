(** "<p>Uploads a client certificate revocation list to the specified Client VPN endpoint. Uploading a client certificate revocation list overwrites the existing client certificate revocation list.</p> <p>Uploading a client certificate revocation list resets existing client connections.</p>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module ImportClientVpnClientCertificateRevocationListRequest :
sig
  type t =
    {
    client_vpn_endpoint_id: String.t ;
    certificate_revocation_list: String.t ;
    dry_run: Boolean.t option }
  val make :
    client_vpn_endpoint_id:String.t ->
      certificate_revocation_list:String.t -> ?dry_run:Boolean.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module ImportClientVpnClientCertificateRevocationListResult =
ImportClientVpnClientCertificateRevocationListResult
type input = ImportClientVpnClientCertificateRevocationListRequest.t
type output = ImportClientVpnClientCertificateRevocationListResult.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error