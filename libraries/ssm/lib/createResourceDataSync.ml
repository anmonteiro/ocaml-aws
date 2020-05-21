open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module CreateResourceDataSyncRequest =
  struct
    type t =
      {
      sync_name: String.t [@ocaml.doc "<p>A name for the configuration.</p>"];
      s3_destination: ResourceDataSyncS3Destination.t option
        [@ocaml.doc "<p>Amazon S3 configuration details for the sync.</p>"];
      sync_type: String.t option
        [@ocaml.doc
          "<p>Specify <code>SyncToDestination</code> to create a resource data sync that synchronizes data from multiple AWS Regions to an Amazon S3 bucket. Specify <code>SyncFromSource</code> to synchronize data from multiple AWS accounts and Regions, as listed in AWS Organizations.</p>"];
      sync_source: ResourceDataSyncSource.t option
        [@ocaml.doc
          "<p>Specify information about the data sources to synchronize.</p>"]}
    let make ~sync_name  ?s3_destination  ?sync_type  ?sync_source  () =
      { sync_name; s3_destination; sync_type; sync_source }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sync_source
              (fun f -> ("sync_source", (ResourceDataSyncSource.to_json f)));
           Util.option_map v.sync_type
             (fun f -> ("sync_type", (String.to_json f)));
           Util.option_map v.s3_destination
             (fun f ->
                ("s3_destination", (ResourceDataSyncS3Destination.to_json f)));
           Some ("sync_name", (String.to_json v.sync_name))])
    let of_json j =
      {
        sync_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "sync_name")));
        s3_destination =
          (Util.option_map (Json.lookup j "s3_destination")
             ResourceDataSyncS3Destination.of_json);
        sync_type =
          (Util.option_map (Json.lookup j "sync_type") String.of_json);
        sync_source =
          (Util.option_map (Json.lookup j "sync_source")
             ResourceDataSyncSource.of_json)
      }
  end
module Output = Aws.BaseTypes.Unit
type input = CreateResourceDataSyncRequest.t
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
            (Query.render (CreateResourceDataSyncRequest.to_query req)))) in
  (`POST, uri,
    (Headers.render (CreateResourceDataSyncRequest.to_headers req)), "")
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