open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CancelExportTaskRequest =
  struct
    type t =
      {
      export_task_id: String.t
        [@ocaml.doc
          "<p>The ID of the export task. This is the ID returned by <code>CreateInstanceExportTask</code>.</p>"]}
    let make ~export_task_id  () = { export_task_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("ExportTaskId", (String.to_query v.export_task_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("export_task_id", (String.to_json v.export_task_id))])
    let parse xml =
      Some
        {
          export_task_id =
            (Xml.required "exportTaskId"
               (Util.option_bind (Xml.member "exportTaskId" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "exportTaskId"
                 ([], (String.to_xml v.export_task_id)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CancelExportTaskRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CancelExportTask"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CancelExportTaskRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CancelExportTaskRequest.to_headers req)), "")
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