open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DescribeMaintenanceWindowsForTargetRequest =
  struct
    type t =
      {
      targets: Targets.t
        [@ocaml.doc
          "<p>The instance ID or key/value pair to retrieve information about.</p>"];
      resource_type: MaintenanceWindowResourceType.t
        [@ocaml.doc
          "<p>The type of resource you want to retrieve information about. For example, \"INSTANCE\".</p>"];
      max_results: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of items to return for this call. The call also returns a token that you can specify in a subsequent call to get the next set of results.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ~targets  ~resource_type  ?max_results  ?next_token  () =
      { targets; resource_type; max_results; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Util.option_map v.max_results
             (fun f -> ("max_results", (Integer.to_json f)));
           Some
             ("resource_type",
               (MaintenanceWindowResourceType.to_json v.resource_type));
           Some ("targets", (Targets.to_json v.targets))])
    let of_json j =
      {
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        resource_type =
          (MaintenanceWindowResourceType.of_json
             (Util.of_option_exn (Json.lookup j "resource_type")));
        max_results =
          (Util.option_map (Json.lookup j "max_results") Integer.of_json);
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeMaintenanceWindowsForTargetResult =
  DescribeMaintenanceWindowsForTargetResult
type input = DescribeMaintenanceWindowsForTargetRequest.t
type output = DescribeMaintenanceWindowsForTargetResult.t
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
            (Query.render
               (DescribeMaintenanceWindowsForTargetRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render
       (DescribeMaintenanceWindowsForTargetRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DescribeMaintenanceWindowsForTargetResult.of_json json)
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