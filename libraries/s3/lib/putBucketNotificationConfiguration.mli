(** "<p>Enables notifications of specified events for a bucket. For more information about event notifications, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Configuring Event Notifications</a>.</p> <p>Using this API, you can replace an existing notification configuration. The configuration is an XML file that defines the event types that you want Amazon S3 to publish and the destination where you want Amazon S3 to publish an event notification when it detects an event of the specified type.</p> <p>By default, your bucket has no event notifications configured. That is, the notification configuration will be an empty <code>NotificationConfiguration</code>.</p> <p> <code>&lt;NotificationConfiguration&gt;</code> </p> <p> <code>&lt;/NotificationConfiguration&gt;</code> </p> <p>This operation replaces the existing notification configuration with the configuration you include in the request body.</p> <p>After Amazon S3 receives this request, it first verifies that any Amazon Simple Notification Service (Amazon SNS) or Amazon Simple Queue Service (Amazon SQS) destination exists, and that the bucket owner has permission to publish to it by sending a test notification. In the case of AWS Lambda destinations, Amazon S3 verifies that the Lambda function permissions grant Amazon S3 permission to invoke the function from the Amazon S3 bucket. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html\">Configuring Notifications for Amazon S3 Events</a>.</p> <p>You can disable notifications by adding the empty NotificationConfiguration element.</p> <p>By default, only the bucket owner can configure notifications on a bucket. However, bucket owners can use a bucket policy to grant permission to other users to set this configuration with <code>s3:PutBucketNotification</code> permission.</p> <note> <p>The PUT notification is an atomic operation. For example, suppose your notification configuration includes SNS topic, SQS queue, and Lambda function configurations. When you send a PUT request with this configuration, Amazon S3 sends test messages to your SNS topic. If the message fails, the entire PUT operation will fail, and Amazon S3 will not add the configuration to your bucket.</p> </note> <p> <b>Responses</b> </p> <p>If the configuration in the request body includes only one <code>TopicConfiguration</code> specifying only the <code>s3:ReducedRedundancyLostObject</code> event type, the response will also include the <code>x-amz-sns-test-message-id</code> header containing the message ID of the test notification sent to the topic.</p> <p>The following operation is related to <code>PutBucketNotificationConfiguration</code>:</p> <ul> <li> <p> <a>GetBucketNotificationConfiguration</a> </p> </li> </ul>" *)
open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
module PutBucketNotificationConfigurationRequest :
sig
  type t =
    {
    bucket: String.t ;
    notification_configuration: NotificationConfiguration.t }
  val make :
    bucket:String.t ->
      notification_configuration:NotificationConfiguration.t -> unit -> t
  val to_query : t -> Aws.Query.t
  val to_headers : t -> Aws.Headers.t
  val to_json : t -> Aws.Json.t
  val parse : Ezxmlm.nodes -> t option
  val to_xml : t -> Ezxmlm.nodes
end
module Output = Aws.BaseTypes.Unit
type input = PutBucketNotificationConfigurationRequest.t
type output = unit
type error = Errors_internal.t
include
  Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error