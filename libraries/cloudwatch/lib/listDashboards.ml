open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ListDashboardsInput =
  struct
    type t =
      {
      dashboard_name_prefix: String.t option
        [@ocaml.doc
          "<p>If you specify this parameter, only the dashboards with names starting with the specified string are listed. The maximum length is 255, and valid characters are A-Z, a-z, 0-9, \".\", \"-\", and \"_\". </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token returned by a previous call to indicate that there is more data available.</p>"]}
    let make ?dashboard_name_prefix  ?next_token  () =
      { dashboard_name_prefix; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.dashboard_name_prefix
             (fun f -> ("dashboard_name_prefix", (String.to_json f)))])
    let parse xml =
      Some
        {
          dashboard_name_prefix =
            (Util.option_bind (Xml.member "DashboardNamePrefix" xml)
               String.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.dashboard_name_prefix
               (fun f ->
                  Ezxmlm.make_tag "DashboardNamePrefix"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListDashboardsOutput = ListDashboardsOutput
type input = ListDashboardsInput.t
type output = ListDashboardsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["ListDashboards"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ListDashboardsInput.to_query req))))) in
  (`POST, uri, (Headers.render (ListDashboardsInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ListDashboardsResponse" (snd xml))
        (Xml.member "ListDashboardsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ListDashboardsOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ListDashboardsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ListDashboardsOutput - missing field in body or children: "
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