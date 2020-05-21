open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ModifyDBParameterGroupMessage =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t
        [@ocaml.doc
          "<p>The name of the DB parameter group.</p> <p>Constraints:</p> <ul> <li> <p>If supplied, must match the name of an existing <code>DBParameterGroup</code>.</p> </li> </ul>"];
      parameters: ParametersList.t
        [@ocaml.doc
          "<p>An array of parameter names, values, and the apply method for the parameter update. At least one parameter name, value, and apply method must be supplied; subsequent arguments are optional. A maximum of 20 parameters can be modified in a single request.</p> <p>Valid Values (for the application method): <code>immediate | pending-reboot</code> </p> <note> <p>You can use the immediate value with dynamic parameters only. You can use the pending-reboot value for both dynamic and static parameters, and changes are applied when you reboot the DB instance without failover.</p> </note>"]}
    [@@ocaml.doc "<p/>"]
    let make ~d_b_parameter_group_name  ~parameters  () =
      { d_b_parameter_group_name; parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("parameters", (ParametersList.to_json v.parameters));
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
          parameters =
            (Xml.required "Parameters"
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "DBParameterGroupName"
                  ([], (String.to_xml v.d_b_parameter_group_name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Parameters"
                      ([], (ParametersList.to_xml [x])))) v.parameters))
  end[@@ocaml.doc "<p/>"]
module DBParameterGroupNameMessage = DBParameterGroupNameMessage
type input = ModifyDBParameterGroupMessage.t
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
         [("Version", ["2014-10-31"]);
         ("Action", ["ModifyDBParameterGroup"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ModifyDBParameterGroupMessage.to_query req))))) in
  (`POST, uri,
    (Headers.render (ModifyDBParameterGroupMessage.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind
        (Xml.member "ModifyDBParameterGroupResponse" (snd xml))
        (Xml.member "ModifyDBParameterGroupResult") in
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