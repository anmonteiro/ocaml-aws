open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DisableAlarmActionsInput =
  struct
    type t =
      {
      alarm_names: AlarmNames.t
        [@ocaml.doc "<p>The names of the alarms.</p>"]}
    let make ~alarm_names  () = { alarm_names }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("alarm_names", (AlarmNames.to_json v.alarm_names))])
    let parse xml =
      Some
        {
          alarm_names =
            (Xml.required "AlarmNames"
               (Util.option_bind (Xml.member "AlarmNames" xml)
                  AlarmNames.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AlarmNames"
                      ([], (AlarmNames.to_xml [x])))) v.alarm_names))
  end
module Output = Aws.BaseTypes.Unit
type input = DisableAlarmActionsInput.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["DisableAlarmActions"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DisableAlarmActionsInput.to_query req))))) in
  (`POST, uri, (Headers.render (DisableAlarmActionsInput.to_headers req)),
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