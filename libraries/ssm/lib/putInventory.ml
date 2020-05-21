open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module PutInventoryRequest =
  struct
    type t =
      {
      instance_id: String.t
        [@ocaml.doc
          "<p>An instance ID where you want to add or update inventory items.</p>"];
      items: InventoryItemList.t
        [@ocaml.doc
          "<p>The inventory items that you want to add or update on instances.</p>"]}
    let make ~instance_id  ~items  () = { instance_id; items }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("items", (InventoryItemList.to_json v.items));
           Some ("instance_id", (String.to_json v.instance_id))])
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        items =
          (InventoryItemList.of_json
             (Util.of_option_exn (Json.lookup j "items")))
      }
  end
module PutInventoryResult = PutInventoryResult
type input = PutInventoryRequest.t
type output = PutInventoryResult.t
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
            (Query.render (PutInventoryRequest.to_query req)))) in
  (`POST, uri, (Headers.render (PutInventoryRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let json = Yojson.Basic.from_string body in
    `Ok (PutInventoryResult.of_json json)
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