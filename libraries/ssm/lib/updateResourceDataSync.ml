open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module UpdateResourceDataSyncRequest =
  struct
    type t =
      {
      sync_name: String.t
        [@ocaml.doc
          "<p>The name of the resource data sync you want to update.</p>"];
      sync_type: String.t
        [@ocaml.doc
          "<p>The type of resource data sync. If <code>SyncType</code> is <code>SyncToDestination</code>, then the resource data sync synchronizes data to an Amazon S3 bucket. If the <code>SyncType</code> is <code>SyncFromSource</code> then the resource data sync synchronizes data from AWS Organizations or from multiple AWS Regions.</p>"];
      sync_source: ResourceDataSyncSource.t
        [@ocaml.doc
          "<p>Specify information about the data sources to synchronize.</p>"]}
    let make ~sync_name  ~sync_type  ~sync_source  () =
      { sync_name; sync_type; sync_source }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("sync_source", (ResourceDataSyncSource.to_json v.sync_source));
           Some ("sync_type", (String.to_json v.sync_type));
           Some ("sync_name", (String.to_json v.sync_name))])
    let of_json j =
      {
        sync_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "sync_name")));
        sync_type =
          (String.of_json (Util.of_option_exn (Json.lookup j "sync_type")));
        sync_source =
          (ResourceDataSyncSource.of_json
             (Util.of_option_exn (Json.lookup j "sync_source")))
      }
  end
module Output = Aws.BaseTypes.Unit
type input = UpdateResourceDataSyncRequest.t
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
            (Query.render (UpdateResourceDataSyncRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (UpdateResourceDataSyncRequest.to_headers req)), "")
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