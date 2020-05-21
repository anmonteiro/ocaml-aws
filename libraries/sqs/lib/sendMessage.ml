open Types[@@ocaml.warning "-33"]
open Aws.BaseTypes[@@ocaml.warning "-33"]
open Aws
module SendMessageRequest =
  struct
    type t =
      {
      queue_url: String.t
        [@ocaml.doc
          "<p>The URL of the Amazon SQS queue to which a message is sent.</p> <p>Queue URLs and names are case-sensitive.</p>"];
      message_body: String.t
        [@ocaml.doc
          "<p>The message to send. The maximum string size is 256 KB.</p> <important> <p>A message can include only XML, JSON, and unformatted text. The following Unicode characters are allowed:</p> <p> <code>#x9</code> | <code>#xA</code> | <code>#xD</code> | <code>#x20</code> to <code>#xD7FF</code> | <code>#xE000</code> to <code>#xFFFD</code> | <code>#x10000</code> to <code>#x10FFFF</code> </p> <p>Any characters not included in this list will be rejected. For more information, see the <a href=\"http://www.w3.org/TR/REC-xml/#charsets\">W3C specification for characters</a>.</p> </important>"];
      delay_seconds: Integer.t option
        [@ocaml.doc
          "<p> The length of time, in seconds, for which to delay a specific message. Valid values: 0 to 900. Maximum: 15 minutes. Messages with a positive <code>DelaySeconds</code> value become available for processing after the delay period is finished. If you don't specify a value, the default value for the queue applies. </p> <note> <p>When you set <code>FifoQueue</code>, you can't set <code>DelaySeconds</code> per message. You can set this parameter only on a queue level.</p> </note>"];
      message_attributes: MessageBodyAttributeMap.t option
        [@ocaml.doc
          "<p>Each message attribute consists of a <code>Name</code>, <code>Type</code>, and <code>Value</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-attributes.html\">Amazon SQS Message Attributes</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"];
      message_system_attributes: MessageBodySystemAttributeMap.t option
        [@ocaml.doc
          "<p>The message system attribute to send. Each message system attribute consists of a <code>Name</code>, <code>Type</code>, and <code>Value</code>.</p> <important> <ul> <li> <p>Currently, the only supported message system attribute is <code>AWSTraceHeader</code>. Its type must be <code>String</code> and its value must be a correctly formatted AWS X-Ray trace string.</p> </li> <li> <p>The size of a message system attribute doesn't count towards the total size of a message.</p> </li> </ul> </important>"];
      message_deduplication_id: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The token used for deduplication of sent messages. If a message with a particular <code>MessageDeduplicationId</code> is sent successfully, any messages sent with the same <code>MessageDeduplicationId</code> are accepted successfully but aren't delivered during the 5-minute deduplication interval. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\"> Exactly-Once Processing</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <ul> <li> <p>Every message must have a unique <code>MessageDeduplicationId</code>,</p> <ul> <li> <p>You may provide a <code>MessageDeduplicationId</code> explicitly.</p> </li> <li> <p>If you aren't able to provide a <code>MessageDeduplicationId</code> and you enable <code>ContentBasedDeduplication</code> for your queue, Amazon SQS uses a SHA-256 hash to generate the <code>MessageDeduplicationId</code> using the body of the message (but not the attributes of the message). </p> </li> <li> <p>If you don't provide a <code>MessageDeduplicationId</code> and the queue doesn't have <code>ContentBasedDeduplication</code> set, the action fails with an error.</p> </li> <li> <p>If the queue has <code>ContentBasedDeduplication</code> set, your <code>MessageDeduplicationId</code> overrides the generated one.</p> </li> </ul> </li> <li> <p>When <code>ContentBasedDeduplication</code> is in effect, messages with identical content sent within the deduplication interval are treated as duplicates and only one copy of the message is delivered.</p> </li> <li> <p>If you send one message with <code>ContentBasedDeduplication</code> enabled and then another message with a <code>MessageDeduplicationId</code> that is the same as the one generated for the first <code>MessageDeduplicationId</code>, the two messages are treated as duplicates and only one copy of the message is delivered. </p> </li> </ul> <note> <p>The <code>MessageDeduplicationId</code> is available to the consumer of the message (this can be useful for troubleshooting delivery issues).</p> <p>If a message is sent successfully but the acknowledgement is lost and the message is resent with the same <code>MessageDeduplicationId</code> after the deduplication interval, Amazon SQS can't detect duplicate messages.</p> <p>Amazon SQS continues to keep track of the message deduplication ID even after the message is received and deleted.</p> </note> <p>The length of <code>MessageDeduplicationId</code> is 128 characters. <code>MessageDeduplicationId</code> can contain alphanumeric characters (<code>a-z</code>, <code>A-Z</code>, <code>0-9</code>) and punctuation (<code>!\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\]^_`{|}~</code>).</p> <p>For best practices of using <code>MessageDeduplicationId</code>, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagededuplicationid-property.html\">Using the MessageDeduplicationId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"];
      message_group_id: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The tag that specifies that a message belongs to a specific message group. Messages that belong to the same message group are processed in a FIFO manner (however, messages in different message groups might be processed out of order). To interleave multiple ordered streams within a single queue, use <code>MessageGroupId</code> values (for example, session data for multiple users). In this scenario, multiple consumers can process the queue, but the session data of each user is processed in a FIFO fashion.</p> <ul> <li> <p>You must associate a non-empty <code>MessageGroupId</code> with a message. If you don't provide a <code>MessageGroupId</code>, the action fails.</p> </li> <li> <p> <code>ReceiveMessage</code> might return messages with multiple <code>MessageGroupId</code> values. For each <code>MessageGroupId</code>, the messages are sorted by time sent. The caller can't specify a <code>MessageGroupId</code>.</p> </li> </ul> <p>The length of <code>MessageGroupId</code> is 128 characters. Valid values: alphanumeric characters and punctuation <code>(!\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\]^_`{|}~)</code>.</p> <p>For best practices of using <code>MessageGroupId</code>, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagegroupid-property.html\">Using the MessageGroupId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <important> <p> <code>MessageGroupId</code> is required for FIFO queues. You can't use it for Standard queues.</p> </important>"]}
    [@@ocaml.doc "<p/>"]
    let make ~queue_url  ~message_body  ?delay_seconds  ?message_attributes 
      ?message_system_attributes  ?message_deduplication_id 
      ?message_group_id  () =
      {
        queue_url;
        message_body;
        delay_seconds;
        message_attributes;
        message_system_attributes;
        message_deduplication_id;
        message_group_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message_group_id
              (fun f -> ("message_group_id", (String.to_json f)));
           Util.option_map v.message_deduplication_id
             (fun f -> ("message_deduplication_id", (String.to_json f)));
           Util.option_map v.message_system_attributes
             (fun f ->
                ("message_system_attributes",
                  (MessageBodySystemAttributeMap.to_json f)));
           Util.option_map v.message_attributes
             (fun f ->
                ("message_attributes", (MessageBodyAttributeMap.to_json f)));
           Util.option_map v.delay_seconds
             (fun f -> ("delay_seconds", (Integer.to_json f)));
           Some ("message_body", (String.to_json v.message_body));
           Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse));
          message_body =
            (Xml.required "MessageBody"
               (Util.option_bind (Xml.member "MessageBody" xml) String.parse));
          delay_seconds =
            (Util.option_bind (Xml.member "DelaySeconds" xml) Integer.parse);
          message_attributes =
            (Util.option_bind (Xml.member "MessageAttribute" xml)
               MessageBodyAttributeMap.parse);
          message_system_attributes =
            (Util.option_bind (Xml.member "MessageSystemAttribute" xml)
               MessageBodySystemAttributeMap.parse);
          message_deduplication_id =
            (Util.option_bind (Xml.member "MessageDeduplicationId" xml)
               String.parse);
          message_group_id =
            (Util.option_bind (Xml.member "MessageGroupId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "QueueUrl"
                       ([], (String.to_xml v.queue_url)))])
                @
                [Some
                   (Ezxmlm.make_tag "MessageBody"
                      ([], (String.to_xml v.message_body)))])
               @
               [Util.option_map v.delay_seconds
                  (fun f ->
                     Ezxmlm.make_tag "DelaySeconds" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.message_attributes
                 (fun f ->
                    Ezxmlm.make_tag "MessageAttribute"
                      ([], (MessageBodyAttributeMap.to_xml f)))])
             @
             [Util.option_map v.message_system_attributes
                (fun f ->
                   Ezxmlm.make_tag "MessageSystemAttribute"
                     ([], (MessageBodySystemAttributeMap.to_xml f)))])
            @
            [Util.option_map v.message_deduplication_id
               (fun f ->
                  Ezxmlm.make_tag "MessageDeduplicationId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.message_group_id
              (fun f ->
                 Ezxmlm.make_tag "MessageGroupId" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module SendMessageResult = SendMessageResult
type input = SendMessageRequest.t
type output = SendMessageResult.t
type error = Errors_internal.t
let streaming = false
let service = "sqs"
let to_http service region req =
  let uri =
    Uri.add_query_params
      (Uri.of_string
         ((Aws.Util.of_option_exn (Endpoints.url_of service region)) ^ "/"))
      (List.append [("Version", ["2012-11-05"]); ("Action", ["SendMessage"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (SendMessageRequest.to_query req))))) in
  (`POST, uri, (Headers.render (SendMessageRequest.to_headers req)), "")
let of_http headers
  (body : [ `String of string  | `Streaming of Piaf.Body.t ]) =
  let ((`String body) : [ `String of string  | `Streaming of Piaf.Body.t ]) =
    body[@@ocaml.warning "-8"] in
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "SendMessageResponse" (snd xml))
        (Xml.member "SendMessageResult") in
    try
      let open Error in
        Util.or_error (Util.option_bind resp SendMessageResult.parse)
          (BadResponse
             {
               body;
               message = "Could not find well formed SendMessageResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing SendMessageResult - missing field in body or children: "
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