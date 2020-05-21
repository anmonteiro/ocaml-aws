open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module RegisterTargetWithMaintenanceWindowRequest =
  struct
    type t =
      {
      window_id: String.t
        [@ocaml.doc
          "<p>The ID of the maintenance window the target should be registered with.</p>"];
      resource_type: MaintenanceWindowResourceType.t
        [@ocaml.doc
          "<p>The type of target being registered with the maintenance window.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets to register with the maintenance window. In other words, the instances to run commands on when the maintenance window runs.</p> <p>You can specify targets using instance IDs, resource group names, or tags that have been applied to instances.</p> <p> <b>Example 1</b>: Specify instance IDs</p> <p> <code>Key=InstanceIds,Values=<i>instance-id-1</i>,<i>instance-id-2</i>,<i>instance-id-3</i> </code> </p> <p> <b>Example 2</b>: Use tag key-pairs applied to instances</p> <p> <code>Key=tag:<i>my-tag-key</i>,Values=<i>my-tag-value-1</i>,<i>my-tag-value-2</i> </code> </p> <p> <b>Example 3</b>: Use tag-keys applied to instances</p> <p> <code>Key=tag-key,Values=<i>my-tag-key-1</i>,<i>my-tag-key-2</i> </code> </p> <p> <b>Example 4</b>: Use resource group names</p> <p> <code>Key=resource-groups:Name,Values=<i>resource-group-name</i> </code> </p> <p> <b>Example 5</b>: Use filters for resource group types</p> <p> <code>Key=resource-groups:ResourceTypeFilters,Values=<i>resource-type-1</i>,<i>resource-type-2</i> </code> </p> <note> <p>For <code>Key=resource-groups:ResourceTypeFilters</code>, specify resource types in the following format</p> <p> <code>Key=resource-groups:ResourceTypeFilters,Values=<i>AWS::EC2::INSTANCE</i>,<i>AWS::EC2::VPC</i> </code> </p> </note> <p>For more information about these examples formats, including the best use case for each one, see <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/mw-cli-tutorial-targets-examples.html\">Examples: Register Targets with a Maintenance Window</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      owner_information: String.t option
        [@ocaml.doc
          "<p>User-provided value that will be included in any CloudWatch events raised while running tasks for these targets in this maintenance window.</p>"];
      name: String.t option
        [@ocaml.doc "<p>An optional name for the target.</p>"];
      description: String.t option
        [@ocaml.doc "<p>An optional description for the target.</p>"];
      client_token: String.t option
        [@ocaml.doc "<p>User-provided idempotency token.</p>"]}
    let make ~window_id  ~resource_type  ~targets  ?owner_information  ?name 
      ?description  ?client_token  () =
      {
        window_id;
        resource_type;
        targets;
        owner_information;
        name;
        description;
        client_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Some
             ("resource_type",
               (MaintenanceWindowResourceType.to_json v.resource_type));
           Some ("window_id", (String.to_json v.window_id))])
    let of_json j =
      {
        window_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "window_id")));
        resource_type =
          (MaintenanceWindowResourceType.of_json
             (Util.of_option_exn (Json.lookup j "resource_type")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        client_token =
          (Util.option_map (Json.lookup j "client_token") String.of_json)
      }
  end
module RegisterTargetWithMaintenanceWindowResult =
  RegisterTargetWithMaintenanceWindowResult
type input = RegisterTargetWithMaintenanceWindowRequest.t
type output = RegisterTargetWithMaintenanceWindowResult.t
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
               (RegisterTargetWithMaintenanceWindowRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render
       (RegisterTargetWithMaintenanceWindowRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (RegisterTargetWithMaintenanceWindowResult.of_json json)
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