(** "<p>Return torrent files from a bucket. BitTorrent can save you bandwidth when you're distributing large files. For more information about BitTorrent, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/S3Torrent.html\">Amazon S3 Torrent</a>.</p> <note> <p>You can get torrent only for objects that are less than 5 GB in size and that are not encrypted using server-side encryption with customer-provided encryption key.</p> </note> <p>To use GET, you must have READ access to the object.</p> <p>The following operation is related to <code>GetObjectTorrent</code>:</p> <ul> <li> <p> <a>GetObject</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetObjectTorrentRequest :
sig
  type t =
    {
    bucket: String.t ;
    key: String.t ;
    request_payer: RequestPayer.t option }
  val make :
    bucket:String.t ->
      key:String.t -> ?request_payer:RequestPayer.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module GetObjectTorrentOutput = GetObjectTorrentOutput
type input = GetObjectTorrentRequest.t
type output = (GetObjectTorrentOutput.t * Piaf.Body.t)
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error