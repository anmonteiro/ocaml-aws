open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module DeleteResourceDataSyncRequest =
  struct
    type t =
      {
      sync_name: String.t
        [@ocaml.doc "<p>The name of the configuration to delete.</p>"];
      sync_type: String.t option
        [@ocaml.doc
          "<p>Specify the type of resource data sync to delete.</p>"]}
    let make ~sync_name  ?sync_type  () = { sync_name; sync_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sync_type
              (fun f -> ("sync_type", (String.to_json f)));
           Some ("sync_name", (String.to_json v.sync_name))])
    let of_json j =
      {
        sync_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "sync_name")));
        sync_type =
          (Util.option_map (Json.lookup j "sync_type") String.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = DeleteResourceDataSyncRequest.t
type output = unit
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
            (Query.render (DeleteResourceDataSyncRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (DeleteResourceDataSyncRequest.to_headers req)), "")
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