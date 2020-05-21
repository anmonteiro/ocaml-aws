open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteInventoryRequest =
  struct
    type t =
      {
      type_name: String.t
        [@ocaml.doc
          "<p>The name of the custom inventory type for which you want to delete either all previously collected data, or the inventory type itself. </p>"];
      schema_delete_option: InventorySchemaDeleteOption.t option
        [@ocaml.doc
          "<p>Use the <code>SchemaDeleteOption</code> to delete a custom inventory type (schema). If you don't choose this option, the system only deletes existing inventory data associated with the custom inventory type. Choose one of the following options:</p> <p>DisableSchema: If you choose this option, the system ignores all inventory data for the specified version, and any earlier versions. To enable this schema again, you must call the <code>PutInventory</code> action for a version greater than the disabled version.</p> <p>DeleteSchema: This option deletes the specified custom type from the Inventory service. You can recreate the schema later, if you want.</p>"];
      dry_run: Boolean.t option
        [@ocaml.doc
          "<p>Use this option to view a summary of the deletion request without deleting any data or the data type. This option is useful when you only want to understand what will be deleted. Once you validate that the data to be deleted is what you intend to delete, you can run the same command without specifying the <code>DryRun</code> option.</p>"];
      client_token: String.t option
        [@ocaml.doc "<p>User-provided idempotency token.</p>"]}
    let make ~type_name  ?schema_delete_option  ?dry_run  ?client_token  () =
      { type_name; schema_delete_option; dry_run; client_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_token
              (fun f -> ("client_token", (String.to_json f)));
           Util.option_map v.dry_run
             (fun f -> ("dry_run", (Boolean.to_json f)));
           Util.option_map v.schema_delete_option
             (fun f ->
                ("schema_delete_option",
                  (InventorySchemaDeleteOption.to_json f)));
           Some ("type_name", (String.to_json v.type_name))])
    let of_json j =
      {
        type_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "type_name")));
        schema_delete_option =
          (Util.option_map (Json.lookup j "schema_delete_option")
             InventorySchemaDeleteOption.of_json);
        dry_run = (Util.option_map (Json.lookup j "dry_run") Boolean.of_json);
        client_token =
          (Util.option_map (Json.lookup j "client_token") String.of_json)
      }
  end
module DeleteInventoryResult = DeleteInventoryResult
type input = DeleteInventoryRequest.t
type output = DeleteInventoryResult.t
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
            (Query.render (DeleteInventoryRequest.to_query req)))) in
  (`POST, uri, (Headers.render (DeleteInventoryRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (DeleteInventoryResult.of_json json)
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