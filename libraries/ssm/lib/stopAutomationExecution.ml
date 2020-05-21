open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module StopAutomationExecutionRequest =
  struct
    type t =
      {
      automation_execution_id: String.t
        [@ocaml.doc "<p>The execution ID of the Automation to stop.</p>"];
      type_: StopType.t option
        [@ocaml.doc
          "<p>The stop request type. Valid types include the following: Cancel and Complete. The default type is Cancel.</p>"]}
    let make ~automation_execution_id  ?type_  () =
      { automation_execution_id; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (StopType.to_json f)));
           Some
             ("automation_execution_id",
               (String.to_json v.automation_execution_id))])
    let of_json j =
      {
        automation_execution_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "automation_execution_id")));
        type_ = (Util.option_map (Json.lookup j "type_") StopType.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = StopAutomationExecutionRequest.t
type output = unit
type error = Errors_internal.t
let streaming = false
let service = "ssm"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (Util.drop_empty
         (Uri.query_of_encoded
            (Query.render (StopAutomationExecutionRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (StopAutomationExecutionRequest.to_headers req)), "")
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