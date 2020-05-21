open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SetAlarmStateInput =
  struct
    type t =
      {
      alarm_name: String.t
        [@ocaml.doc
          "<p>The name for the alarm. This name must be unique within the AWS account. The maximum length is 255 characters.</p>"];
      state_value: StateValue.t [@ocaml.doc "<p>The value of the state.</p>"];
      state_reason: String.t
        [@ocaml.doc
          "<p>The reason that this alarm is set to this specific state, in text format.</p>"];
      state_reason_data: String.t option
        [@ocaml.doc
          "<p>The reason that this alarm is set to this specific state, in JSON format.</p>"]}
    let make ~alarm_name  ~state_value  ~state_reason  ?state_reason_data  ()
      = { alarm_name; state_value; state_reason; state_reason_data }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.state_reason_data
              (fun f -> ("state_reason_data", (String.to_json f)));
           Some ("state_reason", (String.to_json v.state_reason));
           Some ("state_value", (StateValue.to_json v.state_value));
           Some ("alarm_name", (String.to_json v.alarm_name))])
    let parse xml =
      Some
        {
          alarm_name =
            (Xml.required "AlarmName"
               (Util.option_bind (Xml.member "AlarmName" xml) String.parse));
          state_value =
            (Xml.required "StateValue"
               (Util.option_bind (Xml.member "StateValue" xml)
                  StateValue.parse));
          state_reason =
            (Xml.required "StateReason"
               (Util.option_bind (Xml.member "StateReason" xml) String.parse));
          state_reason_data =
            (Util.option_bind (Xml.member "StateReasonData" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "AlarmName"
                    ([], (String.to_xml v.alarm_name)))])
             @
             [Some
                (Ezxmlm.make_tag "StateValue"
                   ([], (StateValue.to_xml v.state_value)))])
            @
            [Some
               (Ezxmlm.make_tag "StateReason"
                  ([], (String.to_xml v.state_reason)))])
           @
           [Util.option_map v.state_reason_data
              (fun f ->
                 Ezxmlm.make_tag "StateReasonData" ([], (String.to_xml f)))])
  end
module Output = Aws.BaseTypes.Unit
type input = SetAlarmStateInput.t
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
         [("Version", ["2010-08-01"]); ("Action", ["SetAlarmState"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SetAlarmStateInput.to_query req))))) in
  (`POST, uri, (Headers.render (SetAlarmStateInput.to_headers req)), "")
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