open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CancelConversionRequest =
  struct
    type t =
      {
      conversion_task_id: String.t
        [@ocaml.doc "<p>The ID of the conversion task.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Checks whether you have the required permissions for the action, without actually making the request, and provides an error response. If you have the required permissions, the error response is <code>DryRunOperation</code>. Otherwise, it is <code>UnauthorizedOperation</code>.</p>"];
      reason_message: String.t option
        [@ocaml.doc "<p>The reason for canceling the conversion task.</p>"]}
    let make ~conversion_task_id  ?dry_run  ?reason_message  () =
      { conversion_task_id; dry_run; reason_message }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.reason_message
              (fun f -> Query.Pair ("ReasonMessage", (String.to_query f)));
           Util.option_map v.dry_run
             (fun f -> Query.Pair ("DryRun", (Boolean.to_query f)));
           Some
             (Query.Pair
                ("ConversionTaskId", (String.to_query v.conversion_task_id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reason_message
              (fun f -> ("reason_message", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Some ("conversion_task_id", (String.to_json v.conversion_task_id))])
    let parse xml =
      Some
        {
          conversion_task_id =
            (Xml.required "conversionTaskId"
               (Util.option_bind (Xml.member "conversionTaskId" xml)
                  String.parse));
          dry_run =
            (Util.option_bind (Xml.member "dryRun" xml) Boolean.parse);
          reason_message =
            (Util.option_bind (Xml.member "reasonMessage" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "conversionTaskId"
                   ([], (String.to_xml v.conversion_task_id)))])
            @
            [Util.option_map v.dry_run
               (fun f -> Ezxmlm.make_tag "dryRun" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.reason_message
              (fun f ->
                 Ezxmlm.make_tag "reasonMessage" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = CancelConversionRequest.t
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
         [("Version", ["2016-11-15"]); ("Action", ["CancelConversionTask"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (CancelConversionRequest.to_query req))))) in
  (`POST, uri, (Headers.render (CancelConversionRequest.to_headers req)), "")
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