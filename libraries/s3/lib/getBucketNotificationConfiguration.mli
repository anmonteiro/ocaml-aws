(** "<p>Returns the notification configuration of a bucket.</p> <p>If notifications are not enabled on the bucket, the operation returns an empty <code>NotificationConfiguration</code> element.</p> <p>By default, you must be the bucket owner to read the notification configuration of a bucket. However, the bucket owner can use a bucket policy to grant permission to other users to read this configuration with the <code>s3:GetBucketNotification</code> permission.</p> <p>For more information about setting and reading the notification configuration on a bucket, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Setting Up Notification of Bucket Events</a>. For more information about bucket policies, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/using-iam-policies.html\">Using Bucket Policies</a>.</p> <p>The following operation is related to <code>GetBucketNotification</code>:</p> <ul> <li> <p> <a>PutBucketNotification</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module GetBucketNotificationConfigurationRequest :
sig
  type t = {
    bucket: String.t }
  val make : bucket:String.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module NotificationConfiguration = NotificationConfiguration
type input = GetBucketNotificationConfigurationRequest.t
type output = NotificationConfiguration.t
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error