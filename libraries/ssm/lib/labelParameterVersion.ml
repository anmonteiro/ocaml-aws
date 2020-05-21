open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module LabelParameterVersionRequest =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The parameter name on which you want to attach one or more labels.</p>"];
      parameter_version: Long.t option
        [@ocaml.doc
          "<p>The specific version of the parameter on which you want to attach one or more labels. If no version is specified, the system attaches the label to the latest version.</p>"];
      labels: ParameterLabelList.t
        [@ocaml.doc
          "<p>One or more labels to attach to the specified parameter version.</p>"]}
    let make ~name  ?parameter_version  ~labels  () =
      { name; parameter_version; labels }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("labels", (ParameterLabelList.to_json v.labels));
           Util.option_map v.parameter_version
             (fun f -> ("parameter_version", (Long.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        parameter_version =
          (Util.option_map (Json.lookup j "parameter_version") Long.of_json);
        labels =
          (ParameterLabelList.of_json
             (Util.of_option_exn (Json.lookup j "labels")))
      }
  end
module LabelParameterVersionResult = LabelParameterVersionResult
type input = LabelParameterVersionRequest.t
type output = LabelParameterVersionResult.t
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
            (Query.render (LabelParameterVersionRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (LabelParameterVersionRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (LabelParameterVersionResult.of_json json)
  with
  | Yojson.Json_error msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing JSON: " ^ msg) })
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