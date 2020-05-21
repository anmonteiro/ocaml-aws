open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CancelImportTaskRequest =
  struct
    type t =
      {
      cancel_reason: String.t option
        [@ocaml.doc "<p>The reason for canceling the task.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      import_task_id: String.t option
        [@ocaml.doc
          "<p>The ID of the import image or import snapshot task to be canceled.</p>"]}
    let make ?cancel_reason  ?dry_run  ?import_task_id  () =
      { cancel_reason; dry_run; import_task_id }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.import_task_id
              (fun f -> Query.Pair ("ImportTaskId", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Util.option_map v.cancel_reason
             (fun f -> Query.Pair ("CancelReason", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.import_task_id
              (fun f -> ("import_task_id", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.cancel_reason
             (fun f -> ("cancel_reason", (String.to_json f)))])
    let parse xml =
      Some
        {
          cancel_reason =
            (Util.option_bind (Xml.member "CancelReason" xml) String.parse);
          dry_run =
            (Util.option_bind (Xml.member "DryRun" xml) Boolean.parse);
          import_task_id =
            (Util.option_bind (Xml.member "ImportTaskId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.cancel_reason
                (fun f ->
                   Ezxmlm.make_tag "CancelReason" ([], (String.to_xml f)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "DryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.import_task_id
              (fun f ->
                 Ezxmlm.make_tag "ImportTaskId" ([], (String.to_xml f)))])
  end
module CancelImportTaskResult = CancelImportTaskResult
type input = CancelImportTaskRequest.t
type output = CancelImportTaskResult.t
type error = Errors_internal.t
let streaming = false
let service = "ec2"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2016-11-15"]); ("Action", ["CancelImportTask"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CancelImportTaskRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CancelImportTaskRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp = Xml.member "CancelImportTaskResponse" (snd xml) in
    try
      let open Error in
        Util.or_error (Util.option_bind resp CancelImportTaskResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed CancelImportTaskResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing CancelImportTaskResult - missing field in body or children: "
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