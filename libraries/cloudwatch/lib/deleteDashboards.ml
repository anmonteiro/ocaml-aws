open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteDashboardsInput =
  struct
    type t =
      {
      dashboard_names: DashboardNames.t
        [@ocaml.doc
          "<p>The dashboards to be deleted. This parameter is required.</p>"]}
    let make ~dashboard_names  () = { dashboard_names }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("dashboard_names", (DashboardNames.to_json v.dashboard_names))])
    let parse xml =
      Some
        {
          dashboard_names =
            (Xml.required "DashboardNames"
               (Util.option_bind (Xml.member "DashboardNames" xml)
                  DashboardNames.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DashboardNames"
                      ([], (DashboardNames.to_xml [x])))) v.dashboard_names))
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteDashboardsInput.t
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
         [("Version", ["2010-08-01"]); ("Action", ["DeleteDashboards"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteDashboardsInput.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteDashboardsInput.to_headers req)), "")
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