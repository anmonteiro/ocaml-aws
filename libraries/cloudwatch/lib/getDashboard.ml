open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module GetDashboardInput =
  struct
    type t =
      {
      dashboard_name: String.t
        [@ocaml.doc "<p>The name of the dashboard to be described.</p>"]}
    let make ~dashboard_name  () = { dashboard_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("dashboard_name", (String.to_json v.dashboard_name))])
    let parse xml =
      Some
        {
          dashboard_name =
            (Xml.required "DashboardName"
               (Util.option_bind (Xml.member "DashboardName" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "DashboardName"
                 ([], (String.to_xml v.dashboard_name)))])
  end
module GetDashboardOutput = GetDashboardOutput
type input = GetDashboardInput.t
type output = GetDashboardOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["GetDashboard"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (GetDashboardInput.to_query req))))) in
  (`POST, uri, (Headers.render (GetDashboardInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "GetDashboardResponse" (snd xml))
        (Xml.member "GetDashboardResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp GetDashboardOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed GetDashboardOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing GetDashboardOutput - missing field in body or children: "
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