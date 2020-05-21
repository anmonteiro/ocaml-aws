open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateMaintenanceWindowTargetRequest =
  struct
    type t =
      {
      window_id: String.t
        [@ocaml.doc
          "<p>The maintenance window ID with which to modify the target.</p>"];
      window_target_id: String.t
        [@ocaml.doc "<p>The target ID to modify.</p>"];
      targets: Targets.t [@ocaml.doc "<p>The targets to add or replace.</p>"];
      owner_information: String.t option
        [@ocaml.doc
          "<p>User-provided value that will be included in any CloudWatch events raised while running tasks for these targets in this maintenance window.</p>"];
      name: String.t option [@ocaml.doc "<p>A name for the update.</p>"];
      description: String.t option
        [@ocaml.doc "<p>An optional description for the update.</p>"];
      replace: Boolean.t option
        [@ocaml.doc
          "<p>If True, then all fields that are required by the RegisterTargetWithMaintenanceWindow action are also required for this API request. Optional fields that are not specified are set to null.</p>"]}
    let make ~window_id  ~window_target_id  ?(targets= []) 
      ?owner_information  ?name  ?description  ?replace  () =
      {
        window_id;
        window_target_id;
        targets;
        owner_information;
        name;
        description;
        replace
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replace
              (fun f -> ("replace", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Some ("window_target_id", (String.to_json v.window_target_id));
           Some ("window_id", (String.to_json v.window_id))])
    let of_json j =
      {
        window_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "window_id")));
        window_target_id =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "window_target_id")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        replace = (Util.option_map (Json.lookup j "replace") Boolean.of_json)
      }
  end
module UpdateMaintenanceWindowTargetResult =
  UpdateMaintenanceWindowTargetResult
type input = UpdateMaintenanceWindowTargetRequest.t
type output = UpdateMaintenanceWindowTargetResult.t
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
            (Query.render (UpdateMaintenanceWindowTargetRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateMaintenanceWindowTargetRequest.to_headers req)),
    "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (UpdateMaintenanceWindowTargetResult.of_json json)
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