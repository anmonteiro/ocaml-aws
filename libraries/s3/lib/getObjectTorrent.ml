open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetObjectTorrentRequest =
  struct
    type t =
      {
      bucket: String.t
        [@ocaml.doc
          "<p>The name of the bucket containing the object for which to get the torrent files.</p>"];
      key: String.t
        [@ocaml.doc
          "<p>The object key for which to get the information.</p>"];
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?request_payer  () =
      { bucket; key; request_payer }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
  end
module GetObjectTorrentOutput = GetObjectTorrentOutput
type input = GetObjectTorrentRequest.t
type output = (GetObjectTorrentOutput.t * Piaf.Body.t)
type error = Errors_internal.t
let streaming = true
let service = "s3"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^
            (((("/" ^ req.GetObjectTorrentRequest.bucket) ^ "/") ^
                req.GetObjectTorrentRequest.key)
               ^ "?torrent")))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (GetObjectTorrentRequest.to_query req)))) in
  (`GET, uri, (Headers.render (GetObjectTorrentRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`Streaming body) :
    [ `String of string  | `Streaming of Piaf.Body.t ]) = body[@@ocaml.warning
                                                                "-8"] in
  `Ok ((GetObjectTorrentOutput.of_headers headers), body)
let parse_error code err =
  let errors = [] @ Errors_internal.common in
  match Errors_internal.of_string err with
  | Some v ->
      if
        (List.mem v errors) &&
          ((match Errors_internal.to_http_code v with
            | Some x -> x = code
            | None -> true))
      then Some v
      else None
  | None -> None