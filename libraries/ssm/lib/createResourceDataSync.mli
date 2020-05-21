(** "<p>A resource data sync helps you view data from multiple sources in a single location. Systems Manager offers two types of resource data sync: <code>SyncToDestination</code> and <code>SyncFromSource</code>.</p> <p>You can configure Systems Manager Inventory to use the <code>SyncToDestination</code> type to synchronize Inventory data from multiple AWS Regions to a single Amazon S3 bucket. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-datasync.html\">Configuring Resource Data Sync for Inventory</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>You can configure Systems Manager Explorer to use the <code>SyncToDestination</code> type to synchronize operational work items (OpsItems) and operational data (OpsData) from multiple AWS Regions to a single Amazon S3 bucket. You can also configure Explorer to use the <code>SyncFromSource</code> type. This type synchronizes OpsItems and OpsData from multiple AWS accounts and Regions by using AWS Organizations. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/Explorer-resource-data-sync.html\">Setting Up Explorer to Display Data from Multiple Accounts and Regions</a> in the <i>AWS Systems Manager User Guide</i>.</p> <p>A resource data sync is an asynchronous operation that returns immediately. After a successful initial sync is completed, the system continuously syncs data. To check the status of a sync, use the <a>ListResourceDataSync</a>.</p> <note> <p>By default, data is not encrypted in Amazon S3. We strongly recommend that you enable encryption in Amazon S3 to ensure secure data storage. We also recommend that you secure access to the Amazon S3 bucket by creating a restrictive bucket policy. </p> </note>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module CreateResourceDataSyncRequest :
sig
  type t =
    {
    sync_name: String.t ;
    s3_destination: ResourceDataSyncS3Destination.t option ;
    sync_type: String.t option ;
    sync_source: ResourceDataSyncSource.t option }
  val make :
    sync_name:String.t ->
      ?s3_destination:ResourceDataSyncS3Destination.t ->
        ?sync_type:String.t ->
          ?sync_source:ResourceDataSyncSource.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val of_json : Aws.Json.t -> t
end
module Output = Aws.BaseTypes.Unit
type input = CreateResourceDataSyncRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error