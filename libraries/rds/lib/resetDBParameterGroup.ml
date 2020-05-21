open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ResetDBParameterGroupMessage =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB parameter group.</p> <p>Constraints:</p> <ul> <li> <p>Must match the name of an existing <code>DBParameterGroup</code>.</p> </li> </ul>"];
      reset_all_parameters: Boolean.t option
        [@ocaml.doc
          "<p> A value that indicates whether to reset all parameters in the DB parameter group to default values. By default, all parameters in the DB parameter group are reset to default values. </p>"];
      parameters: ParametersList.t
        [@ocaml.doc
          "<p>To reset the entire DB parameter group, specify the <code>DBParameterGroup</code> name and <code>ResetAllParameters</code> parameters. To reset specific parameters, provide a list of the following: <code>ParameterName</code> and <code>ApplyMethod</code>. A maximum of 20 parameters can be modified in a single request.</p> <p> <b>MySQL</b> </p> <p>Valid Values (for Apply method): <code>immediate</code> | <code>pending-reboot</code> </p> <p>You can use the immediate value with dynamic parameters only. You can use the <code>pending-reboot</code> value for both dynamic and static parameters, and changes are applied when DB instance reboots.</p> <p> <b>MariaDB</b> </p> <p>Valid Values (for Apply method): <code>immediate</code> | <code>pending-reboot</code> </p> <p>You can use the immediate value with dynamic parameters only. You can use the <code>pending-reboot</code> value for both dynamic and static parameters, and changes are applied when DB instance reboots.</p> <p> <b>Oracle</b> </p> <p>Valid Values (for Apply method): <code>pending-reboot</code> </p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_parameter_group_name  ?reset_all_parameters  ?(parameters=
      [])  () =
      { d_b_parameter_group_name; reset_all_parameters; parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("parameters", (ParametersList.to_json v.parameters));
           Util.option_map v.reset_all_parameters
             (fun f -> ("reset_all_parameters", (Boolean.to_json f)));
           Some
             ("d_b_parameter_group_name",
               (String.to_json v.d_b_parameter_group_name))])
    let parse xml =
      Some
        {
          d_b_parameter_group_name =
            (Xml.required "DBParameterGroupName"
               (Util.option_bind (Xml.member "DBParameterGroupName" xml)
                  String.parse));
          reset_all_parameters =
            (Util.option_bind (Xml.member "ResetAllParameters" xml)
               Boolean.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "DBParameterGroupName"
                   ([], (String.to_xml v.d_b_parameter_group_name)))])
            @
            [Util.option_map v.reset_all_parameters
               (fun f ->
                  Ezxmlm.make_tag "ResetAllParameters"
                    ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Parameters"
                      ([], (ParametersList.to_xml [x])))) v.parameters))
  end[@@ocaml.doc "<p/>"]
module DBParameterGroupNameMessage = DBParameterGroupNameMessage
type input = ResetDBParameterGroupMessage.t
type output = DBParameterGroupNameMessage.t
type error = Errors_internal.t
let streaming = false
let service = "rds"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2014-10-31"]); ("Action", ["ResetDBParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ResetDBParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ResetDBParameterGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ResetDBParameterGroupResponse" (snd xml))
        (Xml.member "ResetDBParameterGroupResult") in
    try
      let open Error in
        Util.or_error
          (Util.option_bind resp DBParameterGroupNameMessage.parse)
          (BadResponse
             {
               body;
               message =
                 "Could not find well formed DBParameterGroupNameMessage."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DBParameterGroupNameMessage - missing field in body or children: "
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