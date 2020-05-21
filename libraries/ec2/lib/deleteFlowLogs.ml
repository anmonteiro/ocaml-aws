open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteFlowLogsRequest =
  struct
    type t =
      {
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      flow_log_ids: ValueStringList.t
        [@ocaml.doc
          "<p>One or more flow log IDs.</p> <p>Constraint: Maximum of 1000 flow log IDs.</p>"]}
    let make ?dry_run  ~flow_log_ids  () = { dry_run; flow_log_ids }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some
              (Query.Pair
                 ("FlowLogId", (ValueStringList.to_query v.flow_log_ids)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("flow_log_ids", (ValueStringList.to_json v.flow_log_ids));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)))])
    let parse xml =
      Some
        {
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          flow_log_ids =
            (Xml.required "FlowLogId"
               (Util.option_bind (Xml.member "FlowLogId" xml)
                  ValueStringList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "FlowLogId"
                      ([], (ValueStringList.to_xml [x])))) v.flow_log_ids))
  end
module DeleteFlowLogsResult = DeleteFlowLogsResult
type input = DeleteFlowLogsRequest.t
type output = DeleteFlowLogsResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["DeleteFlowLogs"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteFlowLogsRequest.to_query req))))) in
  (`POST, uri, (Headers.render (DeleteFlowLogsRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "DeleteFlowLogsResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DeleteFlowLogsResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DeleteFlowLogsResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteFlowLogsResult - missing field in body or children: "
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