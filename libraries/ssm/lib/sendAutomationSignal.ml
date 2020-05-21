open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SendAutomationSignalRequest =
  struct
    type t =
      {
      automation_execution_id: String.t
        [@ocaml.doc
          "<p>The unique identifier for an existing Automation execution that you want to send the signal to.</p>"];
      signal_type: SignalType.t
        [@ocaml.doc
          "<p>The type of signal to send to an Automation execution. </p>"];
      payload: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>The data sent with the signal. The data schema depends on the type of signal used in the request.</p> <p>For <code>Approve</code> and <code>Reject</code> signal types, the payload is an optional comment that you can send with the signal type. For example:</p> <p> <code>Comment=\"Looks good\"</code> </p> <p>For <code>StartStep</code> and <code>Resume</code> signal types, you must send the name of the Automation step to start or resume as the payload. For example:</p> <p> <code>StepName=\"step1\"</code> </p> <p>For the <code>StopStep</code> signal type, you must send the step execution ID as the payload. For example:</p> <p> <code>StepExecutionId=\"97fff367-fc5a-4299-aed8-0123456789ab\"</code> </p>"]}
    let make ~automation_execution_id  ~signal_type  ?payload  () =
      { automation_execution_id; signal_type; payload }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payload
              (fun f -> ("payload", (AutomationParameterMap.to_json f)));
           Some ("signal_type", (SignalType.to_json v.signal_type));
           Some
             ("automation_execution_id",
               (String.to_json v.automation_execution_id))])
    let of_json j =
      {
        automation_execution_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "automation_execution_id")));
        signal_type =
          (SignalType.of_json
             (Util.of_option_exn (Json.lookup j "signal_type")));
        payload =
          (Util.option_map (Json.lookup j "payload")
             AutomationParameterMap.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = SendAutomationSignalRequest.t
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
            (Query.render (SendAutomationSignalRequest.to_query req)))) in
  (`POST, uri, (Headers.render (SendAutomationSignalRequest.to_headers req)),
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