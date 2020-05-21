open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DomainMetadataRequest =
  struct
    type t =
      {
      domain_name: String.t
        [@ocaml.doc
          "The name of the domain for which to display the metadata of."]}
    let make ~domain_name  () = { domain_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("domain_name", (String.to_json v.domain_name))])
    let parse xml =
      Some
        {
          domain_name =
            (Xml.required "DomainName"
               (Util.option_bind (Xml.member "DomainName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DomainName"
                 ([], (String.to_xml v.domain_name)))])
  end
module DomainMetadataResult = DomainMetadataResult
type input = DomainMetadataRequest.t
type output = DomainMetadataResult.t
type error = Errors_internal.t
let streaming = false
let service = "sdb"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2009-04-15"]); ("Action", ["DomainMetadata"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DomainMetadataRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DomainMetadataRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DomainMetadataResponse" (snd xml))
        (Xml.member "DomainMetadataResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DomainMetadataResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DomainMetadataResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DomainMetadataResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors =
    [Errors_internal.NoSuchDomain; Errors_internal.MissingParameter] @
      Errors_internal.common in
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