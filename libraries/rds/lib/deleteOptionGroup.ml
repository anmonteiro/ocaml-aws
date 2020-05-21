open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteOptionGroupMessage =
  struct
    type t =
      {
      option_group_name: String.t
        [@ocaml.doc
          "<p>The name of the option group to be deleted.</p> <note> <p>You can't delete default option groups.</p> </note>"]}
    [@@ocaml.doc "<p/>"]
    let make ~option_group_name  () = { option_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("option_group_name", (String.to_json v.option_group_name))])
    let parse xml =
      Some
        {
          option_group_name =
            (Xml.required "OptionGroupName"
               (Util.option_bind (Xml.member "OptionGroupName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "OptionGroupName"
                 ([], (String.to_xml v.option_group_name)))])
  end[@@ocaml.doc "<p/>"]
module Output = Aws.BaseTypes.Unit
type input = DeleteOptionGroupMessage.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["DeleteOptionGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteOptionGroupMessage.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteOptionGroupMessage.to_headers req)),
    "")
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