open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteTagsType =
  struct
    type t = {
      tags: Tags.t [@ocaml.doc "<p>One or more tags.</p>"]}
    let make ~tags  () = { tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("tags", (Tags.to_json v.tags))])
    let parse xml =
      Some
        {
          tags =
            (Xml.required "Tags"
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x -> Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
              v.tags))
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteTagsType.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "autoscaling"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2011-01-01"]); ("Action", ["DeleteTags"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteTagsType.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteTagsType.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) = `Ok ()
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