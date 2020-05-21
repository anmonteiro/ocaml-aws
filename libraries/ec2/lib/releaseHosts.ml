open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReleaseHostsRequest =
  struct
    type t =
      {
      host_ids: RequestHostIdList.t
        [@ocaml.doc "<p>The IDs of the Dedicated Hosts to release.</p>"]}
    let make ~host_ids  () = { host_ids }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair ("HostId", (RequestHostIdList.to_query v.host_ids)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("host_ids", (RequestHostIdList.to_json v.host_ids))])
    let parse xml =
      Some
        {
          host_ids =
            (Xml.required "hostId"
               (Util.option_bind (Xml.member "hostId" xml)
                  RequestHostIdList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "hostId"
                      ([], (RequestHostIdList.to_xml [x])))) v.host_ids))
  end
module ReleaseHostsResult = ReleaseHostsResult
type input = ReleaseHostsRequest.t
type output = ReleaseHostsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["ReleaseHosts"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ReleaseHostsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ReleaseHostsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "ReleaseHostsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ReleaseHostsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ReleaseHostsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReleaseHostsResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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