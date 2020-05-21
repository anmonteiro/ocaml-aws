open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteInstallationMediaMessage =
  struct
    type t =
      {
      installation_media_id: String.t
        [@ocaml.doc "<p>The installation medium ID.</p>"]}
    let make ~installation_media_id  () = { installation_media_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("installation_media_id",
                (String.to_json v.installation_media_id))])
    let parse xml =
      Some
        {
          installation_media_id =
            (Xml.required "InstallationMediaId"
               (Util.option_bind (Xml.member "InstallationMediaId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "InstallationMediaId"
                 ([], (String.to_xml v.installation_media_id)))])
  end
module InstallationMedia = InstallationMedia
type input = DeleteInstallationMediaMessage.t
type output = InstallationMedia.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]);
         ("Action", ["DeleteInstallationMedia"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteInstallationMediaMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (DeleteInstallationMediaMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "DeleteInstallationMediaResponse" (snd xml))
        (Xml.member "DeleteInstallationMediaResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp InstallationMedia.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed InstallationMedia."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing InstallationMedia - missing field in body or children: "
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