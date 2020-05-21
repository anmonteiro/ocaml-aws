open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeAlarmsInput =
  struct
    type t =
      {
      alarm_names: AlarmNames.t
        [@ocaml.doc "<p>The names of the alarms.</p>"];
      alarm_name_prefix: String.t option
        [@ocaml.doc
          "<p>The alarm name prefix. If this parameter is specified, you cannot specify <code>AlarmNames</code>.</p>"];
      state_value: StateValue.t option
        [@ocaml.doc "<p>The state value to be used in matching alarms.</p>"];
      action_prefix: String.t option
        [@ocaml.doc "<p>The action name prefix.</p>"];
      max_records: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of alarm descriptions to retrieve.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token returned by a previous call to indicate that there is more data available.</p>"]}
    let make ?(alarm_names= [])  ?alarm_name_prefix  ?state_value 
      ?action_prefix  ?max_records  ?next_token  () =
      {
        alarm_names;
        alarm_name_prefix;
        state_value;
        action_prefix;
        max_records;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_records
             (fun f -> ("max_records", (Integer.to_json f)));
           Util.option_map v.action_prefix
             (fun f -> ("action_prefix", (String.to_json f)));
           Util.option_map v.state_value
             (fun f -> ("state_value", (StateValue.to_json f)));
           Util.option_map v.alarm_name_prefix
             (fun f -> ("alarm_name_prefix", (String.to_json f)));
           Some ("alarm_names", (AlarmNames.to_json v.alarm_names))])
    let parse xml =
      Some
        {
          alarm_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "AlarmNames" xml)
                  AlarmNames.parse));
          alarm_name_prefix =
            (Util.option_bind (Xml.member "AlarmNamePrefix" xml) String.parse);
          state_value =
            (Util.option_bind (Xml.member "StateValue" xml) StateValue.parse);
          action_prefix =
            (Util.option_bind (Xml.member "ActionPrefix" xml) String.parse);
          max_records =
            (Util.option_bind (Xml.member "MaxRecords" xml) Integer.parse);
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "AlarmNames"
                           ([], (AlarmNames.to_xml [x])))) v.alarm_names))
               @
               [Util.option_map v.alarm_name_prefix
                  (fun f ->
                     Ezxmlm.make_tag "AlarmNamePrefix"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.state_value
                 (fun f ->
                    Ezxmlm.make_tag "StateValue" ([], (StateValue.to_xml f)))])
             @
             [Util.option_map v.action_prefix
                (fun f ->
                   Ezxmlm.make_tag "ActionPrefix" ([], (String.to_xml f)))])
            @
            [Util.option_map v.max_records
               (fun f ->
                  Ezxmlm.make_tag "MaxRecords" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeAlarmsOutput = DescribeAlarmsOutput
type input = DescribeAlarmsInput.t
type output = DescribeAlarmsOutput.t
type error = Errors_internal.t
let streaming = false
let service = "monitoring"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2010-08-01"]); ("Action", ["DescribeAlarms"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DescribeAlarmsInput.to_query req))))) in
  (`POST, uri, (Headers.render (DescribeAlarmsInput.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DescribeAlarmsResponse" (snd xml))
        (Xml.member "DescribeAlarmsResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp DescribeAlarmsOutput.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed DescribeAlarmsOutput."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DescribeAlarmsOutput - missing field in body or children: "
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