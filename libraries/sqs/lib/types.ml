open Aws
open Aws.BaseTypes
module BinaryList =
  struct
    type t = Blob.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Blob.to_query v
    let to_headers v = Headers.to_headers_list Blob.to_headers v
    let to_json v = `List (List.map Blob.to_json v)
    let parse xml =
      Util.option_all
        (List.map Blob.parse (Xml.members "BinaryListValue" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Blob.to_xml x))) v
  end
module StringList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "StringListValue" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module MessageAttributeValue =
  struct
    type t =
      {
      string_value: String.t option
        [@ocaml.doc
          "<p>Strings are Unicode with UTF-8 binary encoding. For a list of code values, see <a href=\"http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters\">ASCII Printable Characters</a>.</p>"];
      binary_value: Blob.t option
        [@ocaml.doc
          "<p>Binary type attributes can store any binary data, such as compressed data, encrypted data, or images.</p>"];
      string_list_values: StringList.t
        [@ocaml.doc "<p>Not implemented. Reserved for future use.</p>"];
      binary_list_values: BinaryList.t
        [@ocaml.doc "<p>Not implemented. Reserved for future use.</p>"];
      data_type: String.t
        [@ocaml.doc
          "<p>Amazon SQS supports the following logical data types: <code>String</code>, <code>Number</code>, and <code>Binary</code>. For the <code>Number</code> data type, you must use <code>StringValue</code>.</p> <p>You can also append custom labels. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-attributes.html\">Amazon SQS Message Attributes</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>The user-specified message attribute value. For string data types, the <code>Value</code> attribute has the same restrictions on the content as the message body. For more information, see <code> <a>SendMessage</a>.</code> </p> <p> <code>Name</code>, <code>type</code>, <code>value</code> and the message body must not be empty or null. All parts of the message attribute, including <code>Name</code>, <code>Type</code>, and <code>Value</code>, are part of the message size restriction (256 KB or 262,144 bytes).</p>"]
    let make ?string_value  ?binary_value  ?(string_list_values= []) 
      ?(binary_list_values= [])  ~data_type  () =
      {
        string_value;
        binary_value;
        string_list_values;
        binary_list_values;
        data_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("data_type", (String.to_json v.data_type));
           Some
             ("binary_list_values",
               (BinaryList.to_json v.binary_list_values));
           Some
             ("string_list_values",
               (StringList.to_json v.string_list_values));
           Util.option_map v.binary_value
             (fun f -> ("binary_value", (Blob.to_json f)));
           Util.option_map v.string_value
             (fun f -> ("string_value", (String.to_json f)))])
    let parse xml =
      Some
        {
          string_value =
            (Util.option_bind (Xml.member "StringValue" xml) String.parse);
          binary_value =
            (Util.option_bind (Xml.member "BinaryValue" xml) Blob.parse);
          string_list_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "StringListValue" xml)
                  StringList.parse));
          binary_list_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "BinaryListValue" xml)
                  BinaryList.parse));
          data_type =
            (Xml.required "DataType"
               (Util.option_bind (Xml.member "DataType" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.string_value
                  (fun f ->
                     Ezxmlm.make_tag "StringValue" ([], (String.to_xml f)))])
              @
              [Util.option_map v.binary_value
                 (fun f ->
                    Ezxmlm.make_tag "BinaryValue" ([], (Blob.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "StringListValue"
                        ([], (StringList.to_xml [x])))) v.string_list_values))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "BinaryListValue"
                       ([], (BinaryList.to_xml [x])))) v.binary_list_values))
           @
           [Some
              (Ezxmlm.make_tag "DataType" ([], (String.to_xml v.data_type)))])
  end[@@ocaml.doc
       "<p>The user-specified message attribute value. For string data types, the <code>Value</code> attribute has the same restrictions on the content as the message body. For more information, see <code> <a>SendMessage</a>.</code> </p> <p> <code>Name</code>, <code>type</code>, <code>value</code> and the message body must not be empty or null. All parts of the message attribute, including <code>Name</code>, <code>Type</code>, and <code>Value</code>, are part of the message size restriction (256 KB or 262,144 bytes).</p>"]
module MessageSystemAttributeNameForSends =
  struct
    type t =
      | AWSTraceHeader 
    let str_to_t = [("AWSTraceHeader", AWSTraceHeader)]
    let t_to_str = [(AWSTraceHeader, "AWSTraceHeader")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module MessageSystemAttributeValue =
  struct
    type t =
      {
      string_value: String.t option
        [@ocaml.doc
          "<p>Strings are Unicode with UTF-8 binary encoding. For a list of code values, see <a href=\"http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters\">ASCII Printable Characters</a>.</p>"];
      binary_value: Blob.t option
        [@ocaml.doc
          "<p>Binary type attributes can store any binary data, such as compressed data, encrypted data, or images.</p>"];
      string_list_values: StringList.t
        [@ocaml.doc "<p>Not implemented. Reserved for future use.</p>"];
      binary_list_values: BinaryList.t
        [@ocaml.doc "<p>Not implemented. Reserved for future use.</p>"];
      data_type: String.t
        [@ocaml.doc
          "<p>Amazon SQS supports the following logical data types: <code>String</code>, <code>Number</code>, and <code>Binary</code>. For the <code>Number</code> data type, you must use <code>StringValue</code>.</p> <p>You can also append custom labels. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-attributes.html\">Amazon SQS Message Attributes</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>The user-specified message system attribute value. For string data types, the <code>Value</code> attribute has the same restrictions on the content as the message body. For more information, see <code> <a>SendMessage</a>.</code> </p> <p> <code>Name</code>, <code>type</code>, <code>value</code> and the message body must not be empty or null.</p>"]
    let make ?string_value  ?binary_value  ?(string_list_values= []) 
      ?(binary_list_values= [])  ~data_type  () =
      {
        string_value;
        binary_value;
        string_list_values;
        binary_list_values;
        data_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("data_type", (String.to_json v.data_type));
           Some
             ("binary_list_values",
               (BinaryList.to_json v.binary_list_values));
           Some
             ("string_list_values",
               (StringList.to_json v.string_list_values));
           Util.option_map v.binary_value
             (fun f -> ("binary_value", (Blob.to_json f)));
           Util.option_map v.string_value
             (fun f -> ("string_value", (String.to_json f)))])
    let parse xml =
      Some
        {
          string_value =
            (Util.option_bind (Xml.member "StringValue" xml) String.parse);
          binary_value =
            (Util.option_bind (Xml.member "BinaryValue" xml) Blob.parse);
          string_list_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "StringListValue" xml)
                  StringList.parse));
          binary_list_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "BinaryListValue" xml)
                  BinaryList.parse));
          data_type =
            (Xml.required "DataType"
               (Util.option_bind (Xml.member "DataType" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.string_value
                  (fun f ->
                     Ezxmlm.make_tag "StringValue" ([], (String.to_xml f)))])
              @
              [Util.option_map v.binary_value
                 (fun f ->
                    Ezxmlm.make_tag "BinaryValue" ([], (Blob.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "StringListValue"
                        ([], (StringList.to_xml [x])))) v.string_list_values))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "BinaryListValue"
                       ([], (BinaryList.to_xml [x])))) v.binary_list_values))
           @
           [Some
              (Ezxmlm.make_tag "DataType" ([], (String.to_xml v.data_type)))])
  end[@@ocaml.doc
       "<p>The user-specified message system attribute value. For string data types, the <code>Value</code> attribute has the same restrictions on the content as the message body. For more information, see <code> <a>SendMessage</a>.</code> </p> <p> <code>Name</code>, <code>type</code>, <code>value</code> and the message body must not be empty or null.</p>"]
module MessageSystemAttributeName =
  struct
    type t =
      | SenderId 
      | SentTimestamp 
      | ApproximateReceiveCount 
      | ApproximateFirstReceiveTimestamp 
      | SequenceNumber 
      | MessageDeduplicationId 
      | MessageGroupId 
      | AWSTraceHeader 
    let str_to_t =
      [("AWSTraceHeader", AWSTraceHeader);
      ("MessageGroupId", MessageGroupId);
      ("MessageDeduplicationId", MessageDeduplicationId);
      ("SequenceNumber", SequenceNumber);
      ("ApproximateFirstReceiveTimestamp", ApproximateFirstReceiveTimestamp);
      ("ApproximateReceiveCount", ApproximateReceiveCount);
      ("SentTimestamp", SentTimestamp);
      ("SenderId", SenderId)]
    let t_to_str =
      [(AWSTraceHeader, "AWSTraceHeader");
      (MessageGroupId, "MessageGroupId");
      (MessageDeduplicationId, "MessageDeduplicationId");
      (SequenceNumber, "SequenceNumber");
      (ApproximateFirstReceiveTimestamp, "ApproximateFirstReceiveTimestamp");
      (ApproximateReceiveCount, "ApproximateReceiveCount");
      (SentTimestamp, "SentTimestamp");
      (SenderId, "SenderId")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module MessageBodyAttributeMap =
  struct
    type t = (String.t, MessageAttributeValue.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string MessageAttributeValue.to_query
        v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k), (MessageAttributeValue.to_json v))
                  :: acc) v [])
    let parse xml = None
    let to_xml v = []
  end
module MessageBodySystemAttributeMap =
  struct
    type t =
      (MessageSystemAttributeNameForSends.t, MessageSystemAttributeValue.t)
        Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl MessageSystemAttributeNameForSends.to_string
        MessageSystemAttributeValue.to_query v
    let to_headers v =
      Headers.to_headers_hashtbl
        MessageSystemAttributeNameForSends.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((MessageSystemAttributeNameForSends.to_string k),
                    (MessageSystemAttributeValue.to_json v))
                  :: acc) v [])
    let parse xml = None
    let to_xml v = []
  end
module MessageSystemAttributeMap =
  struct
    type t = (MessageSystemAttributeName.t, String.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl MessageSystemAttributeName.to_string
        String.to_query v
    let to_headers v =
      Headers.to_headers_hashtbl MessageSystemAttributeName.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((MessageSystemAttributeName.to_string k),
                    (String.to_json v))
                  :: acc) v [])
    let parse xml = None
    let to_xml v = []
  end
module QueueAttributeName =
  struct
    type t =
      | All 
      | Policy 
      | VisibilityTimeout 
      | MaximumMessageSize 
      | MessageRetentionPeriod 
      | ApproximateNumberOfMessages 
      | ApproximateNumberOfMessagesNotVisible 
      | CreatedTimestamp 
      | LastModifiedTimestamp 
      | QueueArn 
      | ApproximateNumberOfMessagesDelayed 
      | DelaySeconds 
      | ReceiveMessageWaitTimeSeconds 
      | RedrivePolicy 
      | FifoQueue 
      | ContentBasedDeduplication 
      | KmsMasterKeyId 
      | KmsDataKeyReusePeriodSeconds 
    let str_to_t =
      [("KmsDataKeyReusePeriodSeconds", KmsDataKeyReusePeriodSeconds);
      ("KmsMasterKeyId", KmsMasterKeyId);
      ("ContentBasedDeduplication", ContentBasedDeduplication);
      ("FifoQueue", FifoQueue);
      ("RedrivePolicy", RedrivePolicy);
      ("ReceiveMessageWaitTimeSeconds", ReceiveMessageWaitTimeSeconds);
      ("DelaySeconds", DelaySeconds);
      ("ApproximateNumberOfMessagesDelayed",
        ApproximateNumberOfMessagesDelayed);
      ("QueueArn", QueueArn);
      ("LastModifiedTimestamp", LastModifiedTimestamp);
      ("CreatedTimestamp", CreatedTimestamp);
      ("ApproximateNumberOfMessagesNotVisible",
        ApproximateNumberOfMessagesNotVisible);
      ("ApproximateNumberOfMessages", ApproximateNumberOfMessages);
      ("MessageRetentionPeriod", MessageRetentionPeriod);
      ("MaximumMessageSize", MaximumMessageSize);
      ("VisibilityTimeout", VisibilityTimeout);
      ("Policy", Policy);
      ("All", All)]
    let t_to_str =
      [(KmsDataKeyReusePeriodSeconds, "KmsDataKeyReusePeriodSeconds");
      (KmsMasterKeyId, "KmsMasterKeyId");
      (ContentBasedDeduplication, "ContentBasedDeduplication");
      (FifoQueue, "FifoQueue");
      (RedrivePolicy, "RedrivePolicy");
      (ReceiveMessageWaitTimeSeconds, "ReceiveMessageWaitTimeSeconds");
      (DelaySeconds, "DelaySeconds");
      (ApproximateNumberOfMessagesDelayed,
        "ApproximateNumberOfMessagesDelayed");
      (QueueArn, "QueueArn");
      (LastModifiedTimestamp, "LastModifiedTimestamp");
      (CreatedTimestamp, "CreatedTimestamp");
      (ApproximateNumberOfMessagesNotVisible,
        "ApproximateNumberOfMessagesNotVisible");
      (ApproximateNumberOfMessages, "ApproximateNumberOfMessages");
      (MessageRetentionPeriod, "MessageRetentionPeriod");
      (MaximumMessageSize, "MaximumMessageSize");
      (VisibilityTimeout, "VisibilityTimeout");
      (Policy, "Policy");
      (All, "All")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
  end
module ChangeMessageVisibilityBatchRequestEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>An identifier for this particular receipt handle used to communicate the result.</p> <note> <p>The <code>Id</code>s of a batch request need to be unique within a request</p> </note>"];
      receipt_handle: String.t [@ocaml.doc "<p>A receipt handle.</p>"];
      visibility_timeout: Integer.t option
        [@ocaml.doc
          "<p>The new value (in seconds) for the message's visibility timeout.</p>"]}
    [@@ocaml.doc
      "<p>Encloses a receipt handle and an entry id for each message in <code> <a>ChangeMessageVisibilityBatch</a>.</code> </p> <important> <p>All of the following list parameters must be prefixed with <code>ChangeMessageVisibilityBatchRequestEntry.n</code>, where <code>n</code> is an integer value starting with <code>1</code>. For example, a parameter list for this action might look like this:</p> </important> <p> <code>&amp;ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_2</code> </p> <p> <code>&amp;ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=your_receipt_handle</code> </p> <p> <code>&amp;ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=45</code> </p>"]
    let make ~id  ~receipt_handle  ?visibility_timeout  () =
      { id; receipt_handle; visibility_timeout }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.visibility_timeout
              (fun f -> ("visibility_timeout", (Integer.to_json f)));
           Some ("receipt_handle", (String.to_json v.receipt_handle));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          receipt_handle =
            (Xml.required "ReceiptHandle"
               (Util.option_bind (Xml.member "ReceiptHandle" xml)
                  String.parse));
          visibility_timeout =
            (Util.option_bind (Xml.member "VisibilityTimeout" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
            [Some
               (Ezxmlm.make_tag "ReceiptHandle"
                  ([], (String.to_xml v.receipt_handle)))])
           @
           [Util.option_map v.visibility_timeout
              (fun f ->
                 Ezxmlm.make_tag "VisibilityTimeout" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Encloses a receipt handle and an entry id for each message in <code> <a>ChangeMessageVisibilityBatch</a>.</code> </p> <important> <p>All of the following list parameters must be prefixed with <code>ChangeMessageVisibilityBatchRequestEntry.n</code>, where <code>n</code> is an integer value starting with <code>1</code>. For example, a parameter list for this action might look like this:</p> </important> <p> <code>&amp;ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_2</code> </p> <p> <code>&amp;ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=your_receipt_handle</code> </p> <p> <code>&amp;ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=45</code> </p>"]
module SendMessageBatchRequestEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>An identifier for a message in this batch used to communicate the result.</p> <note> <p>The <code>Id</code>s of a batch request need to be unique within a request</p> <p>This identifier can have up to 80 characters. The following characters are accepted: alphanumeric characters, hyphens(-), and underscores (_).</p> </note>"];
      message_body: String.t [@ocaml.doc "<p>The body of the message.</p>"];
      delay_seconds: Integer.t option
        [@ocaml.doc
          "<p>The length of time, in seconds, for which a specific message is delayed. Valid values: 0 to 900. Maximum: 15 minutes. Messages with a positive <code>DelaySeconds</code> value become available for processing after the delay period is finished. If you don't specify a value, the default value for the queue is applied. </p> <note> <p>When you set <code>FifoQueue</code>, you can't set <code>DelaySeconds</code> per message. You can set this parameter only on a queue level.</p> </note>"];
      message_attributes: MessageBodyAttributeMap.t option
        [@ocaml.doc
          "<p>Each message attribute consists of a <code>Name</code>, <code>Type</code>, and <code>Value</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-attributes.html\">Amazon SQS Message Attributes</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"];
      message_system_attributes: MessageBodySystemAttributeMap.t option
        [@ocaml.doc
          "<p>The message system attribute to send Each message system attribute consists of a <code>Name</code>, <code>Type</code>, and <code>Value</code>.</p> <important> <ul> <li> <p>Currently, the only supported message system attribute is <code>AWSTraceHeader</code>. Its type must be <code>String</code> and its value must be a correctly formatted AWS X-Ray trace string.</p> </li> <li> <p>The size of a message system attribute doesn't count towards the total size of a message.</p> </li> </ul> </important>"];
      message_deduplication_id: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The token used for deduplication of messages within a 5-minute minimum deduplication interval. If a message with a particular <code>MessageDeduplicationId</code> is sent successfully, subsequent messages with the same <code>MessageDeduplicationId</code> are accepted successfully but aren't delivered. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queues.html#FIFO-queues-exactly-once-processing\"> Exactly-Once Processing</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <ul> <li> <p>Every message must have a unique <code>MessageDeduplicationId</code>,</p> <ul> <li> <p>You may provide a <code>MessageDeduplicationId</code> explicitly.</p> </li> <li> <p>If you aren't able to provide a <code>MessageDeduplicationId</code> and you enable <code>ContentBasedDeduplication</code> for your queue, Amazon SQS uses a SHA-256 hash to generate the <code>MessageDeduplicationId</code> using the body of the message (but not the attributes of the message). </p> </li> <li> <p>If you don't provide a <code>MessageDeduplicationId</code> and the queue doesn't have <code>ContentBasedDeduplication</code> set, the action fails with an error.</p> </li> <li> <p>If the queue has <code>ContentBasedDeduplication</code> set, your <code>MessageDeduplicationId</code> overrides the generated one.</p> </li> </ul> </li> <li> <p>When <code>ContentBasedDeduplication</code> is in effect, messages with identical content sent within the deduplication interval are treated as duplicates and only one copy of the message is delivered.</p> </li> <li> <p>If you send one message with <code>ContentBasedDeduplication</code> enabled and then another message with a <code>MessageDeduplicationId</code> that is the same as the one generated for the first <code>MessageDeduplicationId</code>, the two messages are treated as duplicates and only one copy of the message is delivered. </p> </li> </ul> <note> <p>The <code>MessageDeduplicationId</code> is available to the consumer of the message (this can be useful for troubleshooting delivery issues).</p> <p>If a message is sent successfully but the acknowledgement is lost and the message is resent with the same <code>MessageDeduplicationId</code> after the deduplication interval, Amazon SQS can't detect duplicate messages.</p> <p>Amazon SQS continues to keep track of the message deduplication ID even after the message is received and deleted.</p> </note> <p>The length of <code>MessageDeduplicationId</code> is 128 characters. <code>MessageDeduplicationId</code> can contain alphanumeric characters (<code>a-z</code>, <code>A-Z</code>, <code>0-9</code>) and punctuation (<code>!\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\]^_`{|}~</code>).</p> <p>For best practices of using <code>MessageDeduplicationId</code>, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagededuplicationid-property.html\">Using the MessageDeduplicationId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"];
      message_group_id: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The tag that specifies that a message belongs to a specific message group. Messages that belong to the same message group are processed in a FIFO manner (however, messages in different message groups might be processed out of order). To interleave multiple ordered streams within a single queue, use <code>MessageGroupId</code> values (for example, session data for multiple users). In this scenario, multiple consumers can process the queue, but the session data of each user is processed in a FIFO fashion.</p> <ul> <li> <p>You must associate a non-empty <code>MessageGroupId</code> with a message. If you don't provide a <code>MessageGroupId</code>, the action fails.</p> </li> <li> <p> <code>ReceiveMessage</code> might return messages with multiple <code>MessageGroupId</code> values. For each <code>MessageGroupId</code>, the messages are sorted by time sent. The caller can't specify a <code>MessageGroupId</code>.</p> </li> </ul> <p>The length of <code>MessageGroupId</code> is 128 characters. Valid values: alphanumeric characters and punctuation <code>(!\"#$%&amp;'()*+,-./:;&lt;=&gt;?@[\\]^_`{|}~)</code>.</p> <p>For best practices of using <code>MessageGroupId</code>, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/using-messagegroupid-property.html\">Using the MessageGroupId Property</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p> <important> <p> <code>MessageGroupId</code> is required for FIFO queues. You can't use it for Standard queues.</p> </important>"]}
    [@@ocaml.doc
      "<p>Contains the details of a single Amazon SQS message along with an <code>Id</code>.</p>"]
    let make ~id  ~message_body  ?delay_seconds  ?message_attributes 
      ?message_system_attributes  ?message_deduplication_id 
      ?message_group_id  () =
      {
        id;
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
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
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
        ((((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
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
  end[@@ocaml.doc
       "<p>Contains the details of a single Amazon SQS message along with an <code>Id</code>.</p>"]
module DeleteMessageBatchRequestEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>An identifier for this particular receipt handle. This is used to communicate the result.</p> <note> <p>The <code>Id</code>s of a batch request need to be unique within a request</p> </note>"];
      receipt_handle: String.t [@ocaml.doc "<p>A receipt handle.</p>"]}
    [@@ocaml.doc
      "<p>Encloses a receipt handle and an identifier for it.</p>"]
    let make ~id  ~receipt_handle  () = { id; receipt_handle }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("receipt_handle", (String.to_json v.receipt_handle));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          receipt_handle =
            (Xml.required "ReceiptHandle"
               (Util.option_bind (Xml.member "ReceiptHandle" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
           [Some
              (Ezxmlm.make_tag "ReceiptHandle"
                 ([], (String.to_xml v.receipt_handle)))])
  end[@@ocaml.doc
       "<p>Encloses a receipt handle and an identifier for it.</p>"]
module BatchResultErrorEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>The <code>Id</code> of an entry in a batch request.</p>"];
      sender_fault: Boolean.t
        [@ocaml.doc
          "<p>Specifies whether the error happened due to the producer.</p>"];
      code: String.t
        [@ocaml.doc
          "<p>An error code representing why the action failed on this entry.</p>"];
      message: String.t option
        [@ocaml.doc
          "<p>A message explaining why the action failed on this entry.</p>"]}
    [@@ocaml.doc
      "<p>Gives a detailed description of the result of an action on each entry in the request.</p>"]
    let make ~id  ~sender_fault  ~code  ?message  () =
      { id; sender_fault; code; message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)));
           Some ("code", (String.to_json v.code));
           Some ("sender_fault", (Boolean.to_json v.sender_fault));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          sender_fault =
            (Xml.required "SenderFault"
               (Util.option_bind (Xml.member "SenderFault" xml) Boolean.parse));
          code =
            (Xml.required "Code"
               (Util.option_bind (Xml.member "Code" xml) String.parse));
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
             [Some
                (Ezxmlm.make_tag "SenderFault"
                   ([], (Boolean.to_xml v.sender_fault)))])
            @ [Some (Ezxmlm.make_tag "Code" ([], (String.to_xml v.code)))])
           @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Gives a detailed description of the result of an action on each entry in the request.</p>"]
module ChangeMessageVisibilityBatchResultEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc
          "<p>Represents a message whose visibility timeout has been changed successfully.</p>"]}
    [@@ocaml.doc
      "<p>Encloses the <code>Id</code> of an entry in <code> <a>ChangeMessageVisibilityBatch</a>.</code> </p>"]
    let make ~id  () = { id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
  end[@@ocaml.doc
       "<p>Encloses the <code>Id</code> of an entry in <code> <a>ChangeMessageVisibilityBatch</a>.</code> </p>"]
module SendMessageBatchResultEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc "<p>An identifier for the message in this batch.</p>"];
      message_id: String.t
        [@ocaml.doc "<p>An identifier for the message.</p>"];
      m_d5_of_message_body: String.t
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest. For information about MD5, see <a href=\"https://www.ietf.org/rfc/rfc1321.txt\">RFC1321</a>.</p>"];
      m_d5_of_message_attributes: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest. For information about MD5, see <a href=\"https://www.ietf.org/rfc/rfc1321.txt\">RFC1321</a>.</p>"];
      m_d5_of_message_system_attributes: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message system attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest. For information about MD5, see <a href=\"https://www.ietf.org/rfc/rfc1321.txt\">RFC1321</a>.</p>"];
      sequence_number: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The large, non-consecutive number that Amazon SQS assigns to each message.</p> <p>The length of <code>SequenceNumber</code> is 128 bits. As <code>SequenceNumber</code> continues to increase for a particular <code>MessageGroupId</code>.</p>"]}
    [@@ocaml.doc
      "<p>Encloses a <code>MessageId</code> for a successfully-enqueued message in a <code> <a>SendMessageBatch</a>.</code> </p>"]
    let make ~id  ~message_id  ~m_d5_of_message_body 
      ?m_d5_of_message_attributes  ?m_d5_of_message_system_attributes 
      ?sequence_number  () =
      {
        id;
        message_id;
        m_d5_of_message_body;
        m_d5_of_message_attributes;
        m_d5_of_message_system_attributes;
        sequence_number
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sequence_number
              (fun f -> ("sequence_number", (String.to_json f)));
           Util.option_map v.m_d5_of_message_system_attributes
             (fun f ->
                ("m_d5_of_message_system_attributes", (String.to_json f)));
           Util.option_map v.m_d5_of_message_attributes
             (fun f -> ("m_d5_of_message_attributes", (String.to_json f)));
           Some
             ("m_d5_of_message_body",
               (String.to_json v.m_d5_of_message_body));
           Some ("message_id", (String.to_json v.message_id));
           Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          message_id =
            (Xml.required "MessageId"
               (Util.option_bind (Xml.member "MessageId" xml) String.parse));
          m_d5_of_message_body =
            (Xml.required "MD5OfMessageBody"
               (Util.option_bind (Xml.member "MD5OfMessageBody" xml)
                  String.parse));
          m_d5_of_message_attributes =
            (Util.option_bind (Xml.member "MD5OfMessageAttributes" xml)
               String.parse);
          m_d5_of_message_system_attributes =
            (Util.option_bind (Xml.member "MD5OfMessageSystemAttributes" xml)
               String.parse);
          sequence_number =
            (Util.option_bind (Xml.member "SequenceNumber" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
               @
               [Some
                  (Ezxmlm.make_tag "MessageId"
                     ([], (String.to_xml v.message_id)))])
              @
              [Some
                 (Ezxmlm.make_tag "MD5OfMessageBody"
                    ([], (String.to_xml v.m_d5_of_message_body)))])
             @
             [Util.option_map v.m_d5_of_message_attributes
                (fun f ->
                   Ezxmlm.make_tag "MD5OfMessageAttributes"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.m_d5_of_message_system_attributes
               (fun f ->
                  Ezxmlm.make_tag "MD5OfMessageSystemAttributes"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.sequence_number
              (fun f ->
                 Ezxmlm.make_tag "SequenceNumber" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Encloses a <code>MessageId</code> for a successfully-enqueued message in a <code> <a>SendMessageBatch</a>.</code> </p>"]
module Message =
  struct
    type t =
      {
      message_id: String.t option
        [@ocaml.doc
          "<p>A unique identifier for the message. A <code>MessageId</code>is considered unique across all AWS accounts for an extended period of time.</p>"];
      receipt_handle: String.t option
        [@ocaml.doc
          "<p>An identifier associated with the act of receiving the message. A new receipt handle is returned every time you receive a message. When deleting a message, you provide the last received receipt handle to delete the message.</p>"];
      m_d5_of_body: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message body string.</p>"];
      body: String.t option
        [@ocaml.doc "<p>The message's contents (not URL-encoded).</p>"];
      attributes: MessageSystemAttributeMap.t option
        [@ocaml.doc
          "<p>A map of the attributes requested in <code> <a>ReceiveMessage</a> </code> to their respective values. Supported attributes:</p> <ul> <li> <p> <code>ApproximateReceiveCount</code> </p> </li> <li> <p> <code>ApproximateFirstReceiveTimestamp</code> </p> </li> <li> <p> <code>MessageDeduplicationId</code> </p> </li> <li> <p> <code>MessageGroupId</code> </p> </li> <li> <p> <code>SenderId</code> </p> </li> <li> <p> <code>SentTimestamp</code> </p> </li> <li> <p> <code>SequenceNumber</code> </p> </li> </ul> <p> <code>ApproximateFirstReceiveTimestamp</code> and <code>SentTimestamp</code> are each returned as an integer representing the <a href=\"http://en.wikipedia.org/wiki/Unix_time\">epoch time</a> in milliseconds.</p>"];
      m_d5_of_message_attributes: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest. For information about MD5, see <a href=\"https://www.ietf.org/rfc/rfc1321.txt\">RFC1321</a>.</p>"];
      message_attributes: MessageBodyAttributeMap.t option
        [@ocaml.doc
          "<p>Each message attribute consists of a <code>Name</code>, <code>Type</code>, and <code>Value</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-message-attributes.html\">Amazon SQS Message Attributes</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"]}
    [@@ocaml.doc "<p>An Amazon SQS message.</p>"]
    let make ?message_id  ?receipt_handle  ?m_d5_of_body  ?body  ?attributes 
      ?m_d5_of_message_attributes  ?message_attributes  () =
      {
        message_id;
        receipt_handle;
        m_d5_of_body;
        body;
        attributes;
        m_d5_of_message_attributes;
        message_attributes
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message_attributes
              (fun f ->
                 ("message_attributes", (MessageBodyAttributeMap.to_json f)));
           Util.option_map v.m_d5_of_message_attributes
             (fun f -> ("m_d5_of_message_attributes", (String.to_json f)));
           Util.option_map v.attributes
             (fun f -> ("attributes", (MessageSystemAttributeMap.to_json f)));
           Util.option_map v.body (fun f -> ("body", (String.to_json f)));
           Util.option_map v.m_d5_of_body
             (fun f -> ("m_d5_of_body", (String.to_json f)));
           Util.option_map v.receipt_handle
             (fun f -> ("receipt_handle", (String.to_json f)));
           Util.option_map v.message_id
             (fun f -> ("message_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          message_id =
            (Util.option_bind (Xml.member "MessageId" xml) String.parse);
          receipt_handle =
            (Util.option_bind (Xml.member "ReceiptHandle" xml) String.parse);
          m_d5_of_body =
            (Util.option_bind (Xml.member "MD5OfBody" xml) String.parse);
          body = (Util.option_bind (Xml.member "Body" xml) String.parse);
          attributes =
            (Util.option_bind (Xml.member "Attribute" xml)
               MessageSystemAttributeMap.parse);
          m_d5_of_message_attributes =
            (Util.option_bind (Xml.member "MD5OfMessageAttributes" xml)
               String.parse);
          message_attributes =
            (Util.option_bind (Xml.member "MessageAttribute" xml)
               MessageBodyAttributeMap.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.message_id
                    (fun f ->
                       Ezxmlm.make_tag "MessageId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.receipt_handle
                   (fun f ->
                      Ezxmlm.make_tag "ReceiptHandle" ([], (String.to_xml f)))])
               @
               [Util.option_map v.m_d5_of_body
                  (fun f ->
                     Ezxmlm.make_tag "MD5OfBody" ([], (String.to_xml f)))])
              @
              [Util.option_map v.body
                 (fun f -> Ezxmlm.make_tag "Body" ([], (String.to_xml f)))])
             @
             [Util.option_map v.attributes
                (fun f ->
                   Ezxmlm.make_tag "Attribute"
                     ([], (MessageSystemAttributeMap.to_xml f)))])
            @
            [Util.option_map v.m_d5_of_message_attributes
               (fun f ->
                  Ezxmlm.make_tag "MD5OfMessageAttributes"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.message_attributes
              (fun f ->
                 Ezxmlm.make_tag "MessageAttribute"
                   ([], (MessageBodyAttributeMap.to_xml f)))])
  end[@@ocaml.doc "<p>An Amazon SQS message.</p>"]
module DeleteMessageBatchResultEntry =
  struct
    type t =
      {
      id: String.t
        [@ocaml.doc "<p>Represents a successfully deleted message.</p>"]}
    [@@ocaml.doc
      "<p>Encloses the <code>Id</code> of an entry in <code> <a>DeleteMessageBatch</a>.</code> </p>"]
    let make ~id  () = { id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("id", (String.to_json v.id))])
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
  end[@@ocaml.doc
       "<p>Encloses the <code>Id</code> of an entry in <code> <a>DeleteMessageBatch</a>.</code> </p>"]
module QueueAttributeMap =
  struct
    type t = (QueueAttributeName.t, String.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl QueueAttributeName.to_string String.to_query v
    let to_headers v =
      Headers.to_headers_hashtbl QueueAttributeName.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((QueueAttributeName.to_string k), (String.to_json v)) ::
                  acc) v [])
    let parse xml = None
    let to_xml v = []
  end
module ChangeMessageVisibilityBatchRequestEntryList =
  struct
    type t = ChangeMessageVisibilityBatchRequestEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ChangeMessageVisibilityBatchRequestEntry.to_query v
    let to_headers v =
      Headers.to_headers_list
        ChangeMessageVisibilityBatchRequestEntry.to_headers v
    let to_json v =
      `List (List.map ChangeMessageVisibilityBatchRequestEntry.to_json v)
    let parse xml =
      Util.option_all
        (List.map ChangeMessageVisibilityBatchRequestEntry.parse [xml])
    let to_xml v =
      List.concat
        (List.map ChangeMessageVisibilityBatchRequestEntry.to_xml v)
  end
module SendMessageBatchRequestEntryList =
  struct
    type t = SendMessageBatchRequestEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list SendMessageBatchRequestEntry.to_query v
    let to_headers v =
      Headers.to_headers_list SendMessageBatchRequestEntry.to_headers v
    let to_json v = `List (List.map SendMessageBatchRequestEntry.to_json v)
    let parse xml =
      Util.option_all (List.map SendMessageBatchRequestEntry.parse [xml])
    let to_xml v =
      List.concat (List.map SendMessageBatchRequestEntry.to_xml v)
  end
module DeleteMessageBatchRequestEntryList =
  struct
    type t = DeleteMessageBatchRequestEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list DeleteMessageBatchRequestEntry.to_query v
    let to_headers v =
      Headers.to_headers_list DeleteMessageBatchRequestEntry.to_headers v
    let to_json v = `List (List.map DeleteMessageBatchRequestEntry.to_json v)
    let parse xml =
      Util.option_all (List.map DeleteMessageBatchRequestEntry.parse [xml])
    let to_xml v =
      List.concat (List.map DeleteMessageBatchRequestEntry.to_xml v)
  end
module BatchResultErrorEntryList =
  struct
    type t = BatchResultErrorEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list BatchResultErrorEntry.to_query v
    let to_headers v =
      Headers.to_headers_list BatchResultErrorEntry.to_headers v
    let to_json v = `List (List.map BatchResultErrorEntry.to_json v)
    let parse xml =
      Util.option_all (List.map BatchResultErrorEntry.parse [xml])
    let to_xml v = List.concat (List.map BatchResultErrorEntry.to_xml v)
  end
module ChangeMessageVisibilityBatchResultEntryList =
  struct
    type t = ChangeMessageVisibilityBatchResultEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ChangeMessageVisibilityBatchResultEntry.to_query v
    let to_headers v =
      Headers.to_headers_list
        ChangeMessageVisibilityBatchResultEntry.to_headers v
    let to_json v =
      `List (List.map ChangeMessageVisibilityBatchResultEntry.to_json v)
    let parse xml =
      Util.option_all
        (List.map ChangeMessageVisibilityBatchResultEntry.parse [xml])
    let to_xml v =
      List.concat (List.map ChangeMessageVisibilityBatchResultEntry.to_xml v)
  end
module SendMessageBatchResultEntryList =
  struct
    type t = SendMessageBatchResultEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list SendMessageBatchResultEntry.to_query v
    let to_headers v =
      Headers.to_headers_list SendMessageBatchResultEntry.to_headers v
    let to_json v = `List (List.map SendMessageBatchResultEntry.to_json v)
    let parse xml =
      Util.option_all (List.map SendMessageBatchResultEntry.parse [xml])
    let to_xml v =
      List.concat (List.map SendMessageBatchResultEntry.to_xml v)
  end
module AWSAccountIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module ActionNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module AttributeNameList =
  struct
    type t = QueueAttributeName.t list
    let make elems () = elems
    let to_query v = Query.to_query_list QueueAttributeName.to_query v
    let to_headers v =
      Headers.to_headers_list QueueAttributeName.to_headers v
    let to_json v = `List (List.map QueueAttributeName.to_json v)
    let parse xml = Util.option_all (List.map QueueAttributeName.parse [xml])
    let to_xml v = List.concat (List.map QueueAttributeName.to_xml v)
  end
module MessageAttributeNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module QueueUrlList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module TagMap =
  struct
    type t = (String.t, String.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string String.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc -> ((String.to_string k), (String.to_json v)) :: acc)
           v [])
    let parse xml = None
    let to_xml v = []
  end
module MessageList =
  struct
    type t = Message.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Message.to_query v
    let to_headers v = Headers.to_headers_list Message.to_headers v
    let to_json v = `List (List.map Message.to_json v)
    let parse xml = Util.option_all (List.map Message.parse [xml])
    let to_xml v = List.concat (List.map Message.to_xml v)
  end
module DeleteMessageBatchResultEntryList =
  struct
    type t = DeleteMessageBatchResultEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list DeleteMessageBatchResultEntry.to_query v
    let to_headers v =
      Headers.to_headers_list DeleteMessageBatchResultEntry.to_headers v
    let to_json v = `List (List.map DeleteMessageBatchResultEntry.to_json v)
    let parse xml =
      Util.option_all (List.map DeleteMessageBatchResultEntry.parse [xml])
    let to_xml v =
      List.concat (List.map DeleteMessageBatchResultEntry.to_xml v)
  end
module TagKeyList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module GetQueueAttributesResult =
  struct
    type t =
      {
      attributes: QueueAttributeMap.t option
        [@ocaml.doc "<p>A map of attributes to their respective values.</p>"]}
    [@@ocaml.doc "<p>A list of returned queue attributes.</p>"]
    let make ?attributes  () = { attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.attributes
              (fun f -> ("attributes", (QueueAttributeMap.to_json f)))])
    let parse xml =
      Some
        {
          attributes =
            (Util.option_bind (Xml.member "Attribute" xml)
               QueueAttributeMap.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.attributes
              (fun f ->
                 Ezxmlm.make_tag "Attribute"
                   ([], (QueueAttributeMap.to_xml f)))])
  end[@@ocaml.doc "<p>A list of returned queue attributes.</p>"]
module ChangeMessageVisibilityBatchResult =
  struct
    type t =
      {
      successful: ChangeMessageVisibilityBatchResultEntryList.t
        [@ocaml.doc
          "<p>A list of <code> <a>ChangeMessageVisibilityBatchResultEntry</a> </code> items.</p>"];
      failed: BatchResultErrorEntryList.t
        [@ocaml.doc
          "<p>A list of <code> <a>BatchResultErrorEntry</a> </code> items.</p>"]}
    [@@ocaml.doc
      "<p>For each message in the batch, the response contains a <code> <a>ChangeMessageVisibilityBatchResultEntry</a> </code> tag if the message succeeds or a <code> <a>BatchResultErrorEntry</a> </code> tag if the message fails.</p>"]
    let make ~successful  ~failed  () = { successful; failed }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failed", (BatchResultErrorEntryList.to_json v.failed));
           Some
             ("successful",
               (ChangeMessageVisibilityBatchResultEntryList.to_json
                  v.successful))])
    let parse xml =
      Some
        {
          successful =
            (Xml.required "Successful"
               (ChangeMessageVisibilityBatchResultEntryList.parse xml));
          failed =
            (Xml.required "Failed" (BatchResultErrorEntryList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Successful"
                       ([],
                         (ChangeMessageVisibilityBatchResultEntryList.to_xml
                            [x])))) v.successful))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Failed"
                      ([], (BatchResultErrorEntryList.to_xml [x])))) v.failed))
  end[@@ocaml.doc
       "<p>For each message in the batch, the response contains a <code> <a>ChangeMessageVisibilityBatchResultEntry</a> </code> tag if the message succeeds or a <code> <a>BatchResultErrorEntry</a> </code> tag if the message fails.</p>"]
module SendMessageBatchResult =
  struct
    type t =
      {
      successful: SendMessageBatchResultEntryList.t
        [@ocaml.doc
          "<p>A list of <code> <a>SendMessageBatchResultEntry</a> </code> items.</p>"];
      failed: BatchResultErrorEntryList.t
        [@ocaml.doc
          "<p>A list of <code> <a>BatchResultErrorEntry</a> </code> items with error details about each message that can't be enqueued.</p>"]}
    [@@ocaml.doc
      "<p>For each message in the batch, the response contains a <code> <a>SendMessageBatchResultEntry</a> </code> tag if the message succeeds or a <code> <a>BatchResultErrorEntry</a> </code> tag if the message fails.</p>"]
    let make ~successful  ~failed  () = { successful; failed }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failed", (BatchResultErrorEntryList.to_json v.failed));
           Some
             ("successful",
               (SendMessageBatchResultEntryList.to_json v.successful))])
    let parse xml =
      Some
        {
          successful =
            (Xml.required "Successful"
               (SendMessageBatchResultEntryList.parse xml));
          failed =
            (Xml.required "Failed" (BatchResultErrorEntryList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Successful"
                       ([], (SendMessageBatchResultEntryList.to_xml [x]))))
               v.successful))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Failed"
                      ([], (BatchResultErrorEntryList.to_xml [x])))) v.failed))
  end[@@ocaml.doc
       "<p>For each message in the batch, the response contains a <code> <a>SendMessageBatchResultEntry</a> </code> tag if the message succeeds or a <code> <a>BatchResultErrorEntry</a> </code> tag if the message fails.</p>"]
module SendMessageResult =
  struct
    type t =
      {
      m_d5_of_message_body: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest. For information about MD5, see <a href=\"https://www.ietf.org/rfc/rfc1321.txt\">RFC1321</a>.</p>"];
      m_d5_of_message_attributes: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest. For information about MD5, see <a href=\"https://www.ietf.org/rfc/rfc1321.txt\">RFC1321</a>.</p>"];
      m_d5_of_message_system_attributes: String.t option
        [@ocaml.doc
          "<p>An MD5 digest of the non-URL-encoded message system attribute string. You can use this attribute to verify that Amazon SQS received the message correctly. Amazon SQS URL-decodes the message before creating the MD5 digest.</p>"];
      message_id: String.t option
        [@ocaml.doc
          "<p>An attribute containing the <code>MessageId</code> of the message sent to the queue. For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-queue-message-identifiers.html\">Queue and Message Identifiers</a> in the <i>Amazon Simple Queue Service Developer Guide</i>. </p>"];
      sequence_number: String.t option
        [@ocaml.doc
          "<p>This parameter applies only to FIFO (first-in-first-out) queues.</p> <p>The large, non-consecutive number that Amazon SQS assigns to each message.</p> <p>The length of <code>SequenceNumber</code> is 128 bits. <code>SequenceNumber</code> continues to increase for a particular <code>MessageGroupId</code>.</p>"]}
    [@@ocaml.doc
      "<p>The <code>MD5OfMessageBody</code> and <code>MessageId</code> elements.</p>"]
    let make ?m_d5_of_message_body  ?m_d5_of_message_attributes 
      ?m_d5_of_message_system_attributes  ?message_id  ?sequence_number  () =
      {
        m_d5_of_message_body;
        m_d5_of_message_attributes;
        m_d5_of_message_system_attributes;
        message_id;
        sequence_number
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sequence_number
              (fun f -> ("sequence_number", (String.to_json f)));
           Util.option_map v.message_id
             (fun f -> ("message_id", (String.to_json f)));
           Util.option_map v.m_d5_of_message_system_attributes
             (fun f ->
                ("m_d5_of_message_system_attributes", (String.to_json f)));
           Util.option_map v.m_d5_of_message_attributes
             (fun f -> ("m_d5_of_message_attributes", (String.to_json f)));
           Util.option_map v.m_d5_of_message_body
             (fun f -> ("m_d5_of_message_body", (String.to_json f)))])
    let parse xml =
      Some
        {
          m_d5_of_message_body =
            (Util.option_bind (Xml.member "MD5OfMessageBody" xml)
               String.parse);
          m_d5_of_message_attributes =
            (Util.option_bind (Xml.member "MD5OfMessageAttributes" xml)
               String.parse);
          m_d5_of_message_system_attributes =
            (Util.option_bind (Xml.member "MD5OfMessageSystemAttributes" xml)
               String.parse);
          message_id =
            (Util.option_bind (Xml.member "MessageId" xml) String.parse);
          sequence_number =
            (Util.option_bind (Xml.member "SequenceNumber" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.m_d5_of_message_body
                  (fun f ->
                     Ezxmlm.make_tag "MD5OfMessageBody"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.m_d5_of_message_attributes
                 (fun f ->
                    Ezxmlm.make_tag "MD5OfMessageAttributes"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.m_d5_of_message_system_attributes
                (fun f ->
                   Ezxmlm.make_tag "MD5OfMessageSystemAttributes"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.message_id
               (fun f -> Ezxmlm.make_tag "MessageId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.sequence_number
              (fun f ->
                 Ezxmlm.make_tag "SequenceNumber" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The <code>MD5OfMessageBody</code> and <code>MessageId</code> elements.</p>"]
module ListDeadLetterSourceQueuesResult =
  struct
    type t =
      {
      queue_urls: QueueUrlList.t
        [@ocaml.doc
          "<p>A list of source queue URLs that have the <code>RedrivePolicy</code> queue attribute configured with a dead-letter queue.</p>"]}
    [@@ocaml.doc "<p>A list of your dead letter source queues.</p>"]
    let make ~queue_urls  () = { queue_urls }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("queue_urls", (QueueUrlList.to_json v.queue_urls))])
    let parse xml =
      Some
        { queue_urls = (Xml.required "queueUrls" (QueueUrlList.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "queueUrls"
                      ([], (QueueUrlList.to_xml [x])))) v.queue_urls))
  end[@@ocaml.doc "<p>A list of your dead letter source queues.</p>"]
module CreateQueueResult =
  struct
    type t =
      {
      queue_url: String.t option
        [@ocaml.doc "<p>The URL of the created Amazon SQS queue.</p>"]}
    [@@ocaml.doc
      "<p>Returns the <code>QueueUrl</code> attribute of the created queue.</p>"]
    let make ?queue_url  () = { queue_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.queue_url
              (fun f -> ("queue_url", (String.to_json f)))])
    let parse xml =
      Some
        {
          queue_url =
            (Util.option_bind (Xml.member "QueueUrl" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.queue_url
              (fun f -> Ezxmlm.make_tag "QueueUrl" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Returns the <code>QueueUrl</code> attribute of the created queue.</p>"]
module ReceiveMessageResult =
  struct
    type t =
      {
      messages: MessageList.t [@ocaml.doc "<p>A list of messages.</p>"]}
    [@@ocaml.doc "<p>A list of received messages.</p>"]
    let make ?(messages= [])  () = { messages }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("messages", (MessageList.to_json v.messages))])
    let parse xml =
      Some { messages = (Util.of_option [] (MessageList.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Messages" ([], (MessageList.to_xml [x]))))
              v.messages))
  end[@@ocaml.doc "<p>A list of received messages.</p>"]
module DeleteMessageBatchResult =
  struct
    type t =
      {
      successful: DeleteMessageBatchResultEntryList.t
        [@ocaml.doc
          "<p>A list of <code> <a>DeleteMessageBatchResultEntry</a> </code> items.</p>"];
      failed: BatchResultErrorEntryList.t
        [@ocaml.doc
          "<p>A list of <code> <a>BatchResultErrorEntry</a> </code> items.</p>"]}
    [@@ocaml.doc
      "<p>For each message in the batch, the response contains a <code> <a>DeleteMessageBatchResultEntry</a> </code> tag if the message is deleted or a <code> <a>BatchResultErrorEntry</a> </code> tag if the message can't be deleted.</p>"]
    let make ~successful  ~failed  () = { successful; failed }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failed", (BatchResultErrorEntryList.to_json v.failed));
           Some
             ("successful",
               (DeleteMessageBatchResultEntryList.to_json v.successful))])
    let parse xml =
      Some
        {
          successful =
            (Xml.required "Successful"
               (DeleteMessageBatchResultEntryList.parse xml));
          failed =
            (Xml.required "Failed" (BatchResultErrorEntryList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Successful"
                       ([], (DeleteMessageBatchResultEntryList.to_xml [x]))))
               v.successful))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Failed"
                      ([], (BatchResultErrorEntryList.to_xml [x])))) v.failed))
  end[@@ocaml.doc
       "<p>For each message in the batch, the response contains a <code> <a>DeleteMessageBatchResultEntry</a> </code> tag if the message is deleted or a <code> <a>BatchResultErrorEntry</a> </code> tag if the message can't be deleted.</p>"]
module ListQueueTagsResult =
  struct
    type t =
      {
      tags: TagMap.t option
        [@ocaml.doc
          "<p>The list of all tags added to the specified queue.</p>"]}
    let make ?tags  () = { tags }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.tags (fun f -> ("tags", (TagMap.to_json f)))])
    let parse xml =
      Some { tags = (Util.option_bind (Xml.member "Tag" xml) TagMap.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.tags
              (fun f -> Ezxmlm.make_tag "Tag" ([], (TagMap.to_xml f)))])
  end
module ListQueuesResult =
  struct
    type t =
      {
      queue_urls: QueueUrlList.t
        [@ocaml.doc "<p>A list of queue URLs, up to 1,000 entries.</p>"]}
    [@@ocaml.doc "<p>A list of your queues.</p>"]
    let make ?(queue_urls= [])  () = { queue_urls }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("queue_urls", (QueueUrlList.to_json v.queue_urls))])
    let parse xml =
      Some { queue_urls = (Util.of_option [] (QueueUrlList.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "QueueUrls"
                      ([], (QueueUrlList.to_xml [x])))) v.queue_urls))
  end[@@ocaml.doc "<p>A list of your queues.</p>"]
module GetQueueUrlResult =
  struct
    type t =
      {
      queue_url: String.t [@ocaml.doc "<p>The URL of the queue.</p>"]}
    [@@ocaml.doc
      "<p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-responses.html\">Interpreting Responses</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"]
    let make ~queue_url  () = { queue_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("queue_url", (String.to_json v.queue_url))])
    let parse xml =
      Some
        {
          queue_url =
            (Xml.required "QueueUrl"
               (Util.option_bind (Xml.member "QueueUrl" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "QueueUrl" ([], (String.to_xml v.queue_url)))])
  end[@@ocaml.doc
       "<p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-responses.html\">Interpreting Responses</a> in the <i>Amazon Simple Queue Service Developer Guide</i>.</p>"]