open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module ReceiveMessageRequest =
  struct
    type t =
      {
      queue_url: String.t
        [@ocaml.doc
          "<p>The URL of the Amazon SQS queue from which messages are received.</p> <p>Queue URLs and names are case-sensitive.</p>"];
      attribute_names: AttributeNameList.t
        [@ocaml.doc
          "<p>A list of attributes that need to be returned along with each message. These attributes include:</p> <ul> <li> <p> <code>All</code> - Returns all values.</p> </li> <li> <p> <code>ApproximateFirstReceiveTimestamp</code> - Returns the time the message was first received from the queue (<a href=\"http://en.wikipedia.org/wiki/Unix_time\">epoch time</a> in milliseconds).</p> </li> <li> <p> <code>ApproximateReceiveCount</code> - Returns the number of times a message has been received from the queue but not deleted.</p> </li> <li> <p> <code>AWSTraceHeader</code> - Returns the AWS X-Ray trace header string. </p> </li> <li> <p> <code>SenderId</code> </p> <ul> <li> <p>For an IAM user, returns the IAM user ID, for example <code>ABCDEFGHI1JKLMNOPQ23R</code>.</p> </li> <li> <p>For an IAM role, returns the IAM role ID, for example <code>ABCDE1F2GH3I4JK5LMNOP:i-a123b456</code>.</p> </li> </ul> </li> <li> <p> <code>SentTimestamp</code> - Returns the time the message was sent to the queue (<a href=\"http://en.wikipedia.org/wiki/Unix_time\">epoch time</a> in milliseconds).</p> </li> <li> <p> <code>MessageDeduplicationId</code> - Returns the value provided by the producer that calls the <code> <a>SendMessage</a> </code> action.</p> </li> <li> <p> <code>MessageGroupId</code> - Returns the value provided by the producer that calls the <code> <a>SendMessage</a> </code> action. Messages with the same <code>MessageGroupId</code> are returned in sequence.</p> </li> <li> <p> <code>SequenceNumber</code> - Returns the value provided by Amazon SQS.</p> </li> </ul>"];
      message_attribute_names: MessageAttributeNameList.t
        [@ocaml.doc
          "<p>The name of the message attribute, where <i>N</i> is the index.</p> <ul> <li> <p>The name can contain alphanumeric characters and the underscore (<code>_</code>), hyphen (<code>-</code>), and period (<code>.</code>).</p> </li> <li> <p>The name is case-sensitive and must be unique among all attribute names for the message.</p> </li> <li> <p>The name must not start with AWS-reserved prefixes such as <code>AWS.</code> or <code>Amazon.</code> (or any casing variants).</p> </li> <li> <p>The name must not start or end with a period (<code>.</code>), and it should not have periods in succession (<code>..</code>).</p> </li> <li> <p>The name can be up to 256 characters long.</p> </li> </ul> <p>When using <code>ReceiveMessage</code>, you can send a list of attribute names to receive, or you can return all of the attributes by specifying <code>All</code> or <code>.*</code> in your request. You can also use all message attributes starting with a prefix, for example <code>bar.*</code>.</p>"];
      max_number_of_messages: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of messages to return. Amazon SQS never returns more messages than this value (however, fewer messages might be returned). Valid values: 1 to 10. Default: 1.</p>"];
      visibility_timeout: Integer.t option
        [@ocaml.doc
          "<p>The duration (in seconds) that the received messages are hidden from subsequent retrieve requests after being retrieved by a <code>ReceiveMessage</code> request.</p>"];
      wait_time_seconds: Integer.t option
        [@ocaml.doc
          "<p>The duration (in seconds) for which the call waits for a message to arrive in the queue before returning. If a message is available, the call returns sooner than <code>WaitTimeSeconds</code>. If no messages are available and the wait time expires, the call returns successfully with an empty list of messages.</p>"];
      receive_request_attempt_id: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The token used for deduplication of <code>ReceiveMessage</code> calls. If a networking issue occurs after a <code>ReceiveMessage</code> action, and instead of a response you receive a generic error, you can retry the same action with an identical <code>ReceiveRequestAttemptId</code> to retrieve the same set of messages, even if their visibility timeout has not yet expired.</p> <ul> <li> <p>You can use <code>ReceiveRequestAttemptId</code> only for 5 minutes after a <code>ReceiveMessage</code> action.</p> </li> <li> <p>When you set <code>FifoQueue</code>, a caller of the <code>ReceiveMessage</code> action can provide a <code>ReceiveRequestAttemptId</code> explicitly.</p> </li> <li> <p>If a caller of the <code>ReceiveMessage</code> action doesn't provide a <code>ReceiveRequestAttemptId</code>, Amazon SQS generates a <code>ReceiveRequestAttemptId</code>.</p> </li> <li> <p>You can retry the <code>ReceiveMessage</code> action with the same <code>ReceiveRequestAttemptId</code> if none of the messages have been modified (deleted or had their visibility changes).</p> </li> <li> <p>During a visibility timeout, subsequent calls with the same <code>ReceiveRequestAttemptId</code> return the same messages and receipt handles. If a retry occurs within the deduplication interval, it resets the visibility timeout. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-visibility-timeout.html\">Visibility Timeout</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <important> <p>If a caller of the <code>ReceiveMessage</code> action still processes messages when the visibility timeout expires and messages become visible, another worker consuming from the same queue can receive the same messages and therefore process duplicates. Also, if a consumer whose message processing time is longer than the visibility timeout tries to delete the processed messages, the action fails with an error.</p> <p>To mitigate this effect, ensure that your application observes a safe threshold before the visibility timeout expires and extend the visibility timeout as necessary.</p> </important> </li> <li> <p>While messages with a particular <code>MessageGroupId</code> are invisible, no more messages belonging to the same <code>MessageGroupId</code> are returned until the visibility timeout expires. You can still receive messages with another <code>MessageGroupId</code> as long as it is also visible.</p> </li> <li> <p>If a caller of <code>ReceiveMessage</code> can't track the <code>ReceiveRequestAttemptId</code>, no retries work until the original visibility timeout expires. As a result, delays might occur but the messages in the queue remain in a strict order.</p> </li> </ul> <p>The length of <code>ReceiveRequestAttemptId</code> is 128 characters. <code>ReceiveRequestAttemptId</code> can contain alphanumeric characters (<code>a-z</code>, <code>A-Z</code>, <code>0-9</code>) and punctuation (<code>!\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\]^_`{|}~</code>).</p> <p>For best practices of using <code>ReceiveRequestAttemptId</code>, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-receiverequestattemptid-request-parameter.html\">Using the ReceiveRequestAttemptId Request Parameter</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ~queue_url  ?(attribute_names= [])  ?(message_attribute_names=
      [])  ?max_number_of_messages  ?visibility_timeout  ?wait_time_seconds 
      ?receive_request_attempt_id  () =
      {
        queue_url;
        attribute_names;
        message_attribute_names;
        max_number_of_messages;
        visibility_timeout;
        wait_time_seconds;
        receive_request_attempt_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.receive_request_attempt_id
              (fun f -> ("receive_request_attempt_id", (String.to_json f)));
           Util.option_map v.wait_time_seconds
             (fun f -> ("wait_time_seconds", (Integer.to_json f)));
           Util.option_map v.visibility_timeout
             (fun f -> ("visibility_timeout", (Integer.to_json f)));
           Util.option_map v.max_number_of_messages
             (fun f -> ("max_number_of_messages", (Integer.to_json f)));
           Some
             ("message_attribute_names",
               (MessageAttributeNameList.to_json v.message_attribute_names));
           Some
             ("attribute_names",
               (AttributeNameList.to_json v.attribute_names));
           Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse));
          attribute_names = (Util.of_option [] (AttributeNameList.parse xml));
          message_attribute_names =
            (Util.of_option [] (MessageAttributeNameList.parse xml));
          max_number_of_messages =
            (Util.option_bind (Xml.member "MaxNumberOfMessages" xml)
               Integer.parse);
          visibility_timeout =
            (Util.option_bind (Xml.member "VisibilityTimeout" xml)
               Integer.parse);
          wait_time_seconds =
            (Util.option_bind (Xml.member "WaitTimeSeconds" xml)
               Integer.parse);
          receive_request_attempt_id =
            (Util.option_bind (Xml.member "ReceiveRequestAttemptId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "QueueUrl"
                       ([], (String.to_xml v.queue_url)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "AttributeNames"
                           ([], (AttributeNameList.to_xml [x]))))
                   v.attribute_names))
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "MessageAttributeNames"
                          ([], (MessageAttributeNameList.to_xml [x]))))
                  v.message_attribute_names))
              @
              [Util.option_map v.max_number_of_messages
                 (fun f ->
                    Ezxmlm.make_tag "MaxNumberOfMessages"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.visibility_timeout
                (fun f ->
                   Ezxmlm.make_tag "VisibilityTimeout"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.wait_time_seconds
               (fun f ->
                  Ezxmlm.make_tag "WaitTimeSeconds" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.receive_request_attempt_id
              (fun f ->
                 Ezxmlm.make_tag "ReceiveRequestAttemptId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module ReceiveMessageResult = ReceiveMessageResult
type input = ReceiveMessageRequest.t
type output = ReceiveMessageResult.t
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append
         [("Version", ["2012-11-05"]); ("Action", ["ReceiveMessage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (ReceiveMessageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (ReceiveMessageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "ReceiveMessageResponse" (snd xml))
        (Xml.member "ReceiveMessageResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp ReceiveMessageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed ReceiveMessageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing ReceiveMessageResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      let open Error in
        `Error
          (BadResponse { body; message = ("Error parsing xml: " ^ msg) })
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