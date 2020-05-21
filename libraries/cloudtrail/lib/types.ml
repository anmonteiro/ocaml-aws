open Aws
open Aws.BaseTypes
module DataResourceValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Tag =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>The key in a key-value pair. The key must be must be no longer than 128 Unicode characters. The key must be unique for the resource to which it applies.</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>The value in a key-value pair of a tag. The value must be no longer than 256 Unicode characters.</p>"]}
    [@@ocaml.doc
      "<p>A custom key-value pair associated with a resource such as a CloudTrail trail.</p>"]
    let make ~key  ?value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        value = (Util.option_map (Json.lookup j "value") String.of_json)
      }
  end[@@ocaml.doc
       "<p>A custom key-value pair associated with a resource such as a CloudTrail trail.</p>"]
module DataResource =
  struct
    type t =
      {
      type_: String.t option
        [@ocaml.doc
          "<p>The resource type in which you want to log data events. You can specify <code>AWS::S3::Object</code> or <code>AWS::Lambda::Function</code> resources.</p>"];
      values: DataResourceValues.t
        [@ocaml.doc
          "<p>An array of Amazon Resource Name (ARN) strings or partial ARN strings for the specified objects.</p> <ul> <li> <p>To log data events for all objects in all S3 buckets in your AWS account, specify the prefix as <code>arn:aws:s3:::</code>. </p> <note> <p>This will also enable logging of data event activity performed by any user or role in your AWS account, even if that activity is performed on a bucket that belongs to another AWS account. </p> </note> </li> <li> <p>To log data events for all objects in an S3 bucket, specify the bucket and an empty object prefix such as <code>arn:aws:s3:::bucket-1/</code>. The trail logs data events for all objects in this S3 bucket.</p> </li> <li> <p>To log data events for specific objects, specify the S3 bucket and object prefix such as <code>arn:aws:s3:::bucket-1/example-images</code>. The trail logs data events for objects in this S3 bucket that match the prefix.</p> </li> <li> <p>To log data events for all functions in your AWS account, specify the prefix as <code>arn:aws:lambda</code>.</p> <note> <p>This will also enable logging of <code>Invoke</code> activity performed by any user or role in your AWS account, even if that activity is performed on a function that belongs to another AWS account. </p> </note> </li> <li> <p>To log data events for a specific Lambda function, specify the function ARN.</p> <note> <p>Lambda function ARNs are exact. For example, if you specify a function ARN <i>arn:aws:lambda:us-west-2:111111111111:function:helloworld</i>, data events will only be logged for <i>arn:aws:lambda:us-west-2:111111111111:function:helloworld</i>. They will not be logged for <i>arn:aws:lambda:us-west-2:111111111111:function:helloworld2</i>.</p> </note> </li> </ul>"]}
    [@@ocaml.doc
      "<p>The Amazon S3 buckets or AWS Lambda functions that you specify in your event selectors for your trail to log data events. Data events provide information about the resource operations performed on or within a resource itself. These are also known as data plane operations. You can specify up to 250 data resources for a trail.</p> <note> <p>The total number of allowed data resources is 250. This number can be distributed between 1 and 5 event selectors, but the total cannot exceed 250 across all selectors.</p> </note> <p>The following example demonstrates how logging works when you configure logging of all data events for an S3 bucket named <code>bucket-1</code>. In this example, the CloudTrail user specified an empty prefix, and the option to log both <code>Read</code> and <code>Write</code> data events.</p> <ol> <li> <p>A user uploads an image file to <code>bucket-1</code>.</p> </li> <li> <p>The <code>PutObject</code> API operation is an Amazon S3 object-level API. It is recorded as a data event in CloudTrail. Because the CloudTrail user specified an S3 bucket with an empty prefix, events that occur on any object in that bucket are logged. The trail processes and logs the event.</p> </li> <li> <p>A user uploads an object to an Amazon S3 bucket named <code>arn:aws:s3:::bucket-2</code>.</p> </li> <li> <p>The <code>PutObject</code> API operation occurred for an object in an S3 bucket that the CloudTrail user didn't specify for the trail. The trail doesn\226\128\153t log the event.</p> </li> </ol> <p>The following example demonstrates how logging works when you configure logging of AWS Lambda data events for a Lambda function named <i>MyLambdaFunction</i>, but not for all AWS Lambda functions.</p> <ol> <li> <p>A user runs a script that includes a call to the <i>MyLambdaFunction</i> function and the <i>MyOtherLambdaFunction</i> function.</p> </li> <li> <p>The <code>Invoke</code> API operation on <i>MyLambdaFunction</i> is an AWS Lambda API. It is recorded as a data event in CloudTrail. Because the CloudTrail user specified logging data events for <i>MyLambdaFunction</i>, any invocations of that function are logged. The trail processes and logs the event. </p> </li> <li> <p>The <code>Invoke</code> API operation on <i>MyOtherLambdaFunction</i> is an AWS Lambda API. Because the CloudTrail user did not specify logging data events for all Lambda functions, the <code>Invoke</code> operation for <i>MyOtherLambdaFunction</i> does not match the function specified for the trail. The trail doesn\226\128\153t log the event. </p> </li> </ol>"]
    let make ?type_  ?(values= [])  () = { type_; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (DataResourceValues.to_json v.values));
           Util.option_map v.type_ (fun f -> ("type_", (String.to_json f)))])
    let of_json j =
      {
        type_ = (Util.option_map (Json.lookup j "type_") String.of_json);
        values =
          (DataResourceValues.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>The Amazon S3 buckets or AWS Lambda functions that you specify in your event selectors for your trail to log data events. Data events provide information about the resource operations performed on or within a resource itself. These are also known as data plane operations. You can specify up to 250 data resources for a trail.</p> <note> <p>The total number of allowed data resources is 250. This number can be distributed between 1 and 5 event selectors, but the total cannot exceed 250 across all selectors.</p> </note> <p>The following example demonstrates how logging works when you configure logging of all data events for an S3 bucket named <code>bucket-1</code>. In this example, the CloudTrail user specified an empty prefix, and the option to log both <code>Read</code> and <code>Write</code> data events.</p> <ol> <li> <p>A user uploads an image file to <code>bucket-1</code>.</p> </li> <li> <p>The <code>PutObject</code> API operation is an Amazon S3 object-level API. It is recorded as a data event in CloudTrail. Because the CloudTrail user specified an S3 bucket with an empty prefix, events that occur on any object in that bucket are logged. The trail processes and logs the event.</p> </li> <li> <p>A user uploads an object to an Amazon S3 bucket named <code>arn:aws:s3:::bucket-2</code>.</p> </li> <li> <p>The <code>PutObject</code> API operation occurred for an object in an S3 bucket that the CloudTrail user didn't specify for the trail. The trail doesn\226\128\153t log the event.</p> </li> </ol> <p>The following example demonstrates how logging works when you configure logging of AWS Lambda data events for a Lambda function named <i>MyLambdaFunction</i>, but not for all AWS Lambda functions.</p> <ol> <li> <p>A user runs a script that includes a call to the <i>MyLambdaFunction</i> function and the <i>MyOtherLambdaFunction</i> function.</p> </li> <li> <p>The <code>Invoke</code> API operation on <i>MyLambdaFunction</i> is an AWS Lambda API. It is recorded as a data event in CloudTrail. Because the CloudTrail user specified logging data events for <i>MyLambdaFunction</i>, any invocations of that function are logged. The trail processes and logs the event. </p> </li> <li> <p>The <code>Invoke</code> API operation on <i>MyOtherLambdaFunction</i> is an AWS Lambda API. Because the CloudTrail user did not specify logging data events for all Lambda functions, the <code>Invoke</code> operation for <i>MyOtherLambdaFunction</i> does not match the function specified for the trail. The trail doesn\226\128\153t log the event. </p> </li> </ol>"]
module Resource =
  struct
    type t =
      {
      resource_type: String.t option
        [@ocaml.doc
          "<p>The type of a resource referenced by the event returned. When the resource type cannot be determined, null is returned. Some examples of resource types are: <b>Instance</b> for EC2, <b>Trail</b> for CloudTrail, <b>DBInstance</b> for RDS, and <b>AccessKey</b> for IAM. To learn more about how to look up and filter events by the resource types supported for a service, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/view-cloudtrail-events-console.html#filtering-cloudtrail-events\">Filtering CloudTrail Events</a>.</p>"];
      resource_name: String.t option
        [@ocaml.doc
          "<p>The name of the resource referenced by the event returned. These are user-created names whose values will depend on the environment. For example, the resource name might be \"auto-scaling-test-group\" for an Auto Scaling Group or \"i-1234567\" for an EC2 Instance.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the type and name of a resource referenced by an event.</p>"]
    let make ?resource_type  ?resource_name  () =
      { resource_type; resource_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource_name
              (fun f -> ("resource_name", (String.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)))])
    let of_json j =
      {
        resource_type =
          (Util.option_map (Json.lookup j "resource_type") String.of_json);
        resource_name =
          (Util.option_map (Json.lookup j "resource_name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Specifies the type and name of a resource referenced by an event.</p>"]
module InsightType =
  struct
    type t =
      | ApiCallRateInsight 
    let str_to_t = [("ApiCallRateInsight", ApiCallRateInsight)]
    let t_to_str = [(ApiCallRateInsight, "ApiCallRateInsight")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module TagsList =
  struct
    type t = Tag.t list[@@ocaml.doc "<p>A list of tags.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let of_json j = Json.to_list Tag.of_json j
  end[@@ocaml.doc "<p>A list of tags.</p>"]
module DataResources =
  struct
    type t = DataResource.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DataResource.to_query v
    let to_headers v = Headers.to_headers_list DataResource.to_headers v
    let to_json v = `List (List.map DataResource.to_json v)
    let of_json j = Json.to_list DataResource.of_json j
  end
module ExcludeManagementEventSources =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ReadWriteType =
  struct
    type t =
      | ReadOnly 
      | WriteOnly 
      | All 
    let str_to_t =
      [("All", All); ("WriteOnly", WriteOnly); ("ReadOnly", ReadOnly)]
    let t_to_str =
      [(All, "All"); (WriteOnly, "WriteOnly"); (ReadOnly, "ReadOnly")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module LookupAttributeKey =
  struct
    type t =
      | EventId 
      | EventName 
      | ReadOnly 
      | Username 
      | ResourceType 
      | ResourceName 
      | EventSource 
      | AccessKeyId 
    let str_to_t =
      [("AccessKeyId", AccessKeyId);
      ("EventSource", EventSource);
      ("ResourceName", ResourceName);
      ("ResourceType", ResourceType);
      ("Username", Username);
      ("ReadOnly", ReadOnly);
      ("EventName", EventName);
      ("EventId", EventId)]
    let t_to_str =
      [(AccessKeyId, "AccessKeyId");
      (EventSource, "EventSource");
      (ResourceName, "ResourceName");
      (ResourceType, "ResourceType");
      (Username, "Username");
      (ReadOnly, "ReadOnly");
      (EventName, "EventName");
      (EventId, "EventId")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ResourceList =
  struct
    type t = Resource.t list[@@ocaml.doc
                              "<p>A list of resources referenced by the event returned.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list Resource.to_query v
    let to_headers v = Headers.to_headers_list Resource.to_headers v
    let to_json v = `List (List.map Resource.to_json v)
    let of_json j = Json.to_list Resource.of_json j
  end[@@ocaml.doc
       "<p>A list of resources referenced by the event returned.</p>"]
module InsightSelector =
  struct
    type t =
      {
      insight_type: InsightType.t option
        [@ocaml.doc
          "<p>The type of insights to log on a trail. In this release, only <code>ApiCallRateInsight</code> is supported as an insight type.</p>"]}
    [@@ocaml.doc
      "<p>A JSON string that contains a list of insight types that are logged on a trail.</p>"]
    let make ?insight_type  () = { insight_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.insight_type
              (fun f -> ("insight_type", (InsightType.to_json f)))])
    let of_json j =
      {
        insight_type =
          (Util.option_map (Json.lookup j "insight_type") InsightType.of_json)
      }
  end[@@ocaml.doc
       "<p>A JSON string that contains a list of insight types that are logged on a trail.</p>"]
module ResourceTag =
  struct
    type t =
      {
      resource_id: String.t option
        [@ocaml.doc "<p>Specifies the ARN of the resource.</p>"];
      tags_list: TagsList.t [@ocaml.doc "<p>A list of tags.</p>"]}[@@ocaml.doc
                                                                    "<p>A resource tag.</p>"]
    let make ?resource_id  ?(tags_list= [])  () = { resource_id; tags_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags_list", (TagsList.to_json v.tags_list));
           Util.option_map v.resource_id
             (fun f -> ("resource_id", (String.to_json f)))])
    let of_json j =
      {
        resource_id =
          (Util.option_map (Json.lookup j "resource_id") String.of_json);
        tags_list =
          (TagsList.of_json (Util.of_option_exn (Json.lookup j "tags_list")))
      }
  end[@@ocaml.doc "<p>A resource tag.</p>"]
module EventSelector =
  struct
    type t =
      {
      read_write_type: ReadWriteType.t option
        [@ocaml.doc
          "<p>Specify if you want your trail to log read-only events, write-only events, or all. For example, the EC2 <code>GetConsoleOutput</code> is a read-only API operation and <code>RunInstances</code> is a write-only API operation.</p> <p> By default, the value is <code>All</code>.</p>"];
      include_management_events: Boolean.t option
        [@ocaml.doc
          "<p>Specify if you want your event selector to include management events for your trail.</p> <p> For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-management-and-data-events-with-cloudtrail.html#logging-management-events\">Management Events</a> in the <i>AWS CloudTrail User Guide</i>.</p> <p>By default, the value is <code>true</code>.</p>"];
      data_resources: DataResources.t
        [@ocaml.doc
          "<p>CloudTrail supports data event logging for Amazon S3 objects and AWS Lambda functions. You can specify up to 250 resources for an individual event selector, but the total number of data resources cannot exceed 250 across all event selectors in a trail. This limit does not apply if you configure resource logging for all data events. </p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/logging-management-and-data-events-with-cloudtrail.html#logging-data-events\">Data Events</a> and <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/WhatIsCloudTrail-Limits.html\">Limits in AWS CloudTrail</a> in the <i>AWS CloudTrail User Guide</i>.</p>"];
      exclude_management_event_sources: ExcludeManagementEventSources.t
        [@ocaml.doc
          "<p>An optional list of service event sources from which you do not want management events to be logged on your trail. In this release, the list can be empty (disables the filter), or it can filter out AWS Key Management Service events by containing <code>\"kms.amazonaws.com\"</code>. By default, <code>ExcludeManagementEventSources</code> is empty, and AWS KMS events are included in events that are logged to your trail. </p>"]}
    [@@ocaml.doc
      "<p>Use event selectors to further specify the management and data event settings for your trail. By default, trails created without specific event selectors will be configured to log all read and write management events, and no data events. When an event occurs in your account, CloudTrail evaluates the event selector for all trails. For each trail, if the event matches any event selector, the trail processes and logs the event. If the event doesn't match any event selector, the trail doesn't log the event.</p> <p>You can configure up to five event selectors for a trail.</p>"]
    let make ?read_write_type  ?include_management_events  ?(data_resources=
      [])  ?(exclude_management_event_sources= [])  () =
      {
        read_write_type;
        include_management_events;
        data_resources;
        exclude_management_event_sources
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("exclude_management_event_sources",
                (ExcludeManagementEventSources.to_json
                   v.exclude_management_event_sources));
           Some ("data_resources", (DataResources.to_json v.data_resources));
           Util.option_map v.include_management_events
             (fun f -> ("include_management_events", (Boolean.to_json f)));
           Util.option_map v.read_write_type
             (fun f -> ("read_write_type", (ReadWriteType.to_json f)))])
    let of_json j =
      {
        read_write_type =
          (Util.option_map (Json.lookup j "read_write_type")
             ReadWriteType.of_json);
        include_management_events =
          (Util.option_map (Json.lookup j "include_management_events")
             Boolean.of_json);
        data_resources =
          (DataResources.of_json
             (Util.of_option_exn (Json.lookup j "data_resources")));
        exclude_management_event_sources =
          (ExcludeManagementEventSources.of_json
             (Util.of_option_exn
                (Json.lookup j "exclude_management_event_sources")))
      }
  end[@@ocaml.doc
       "<p>Use event selectors to further specify the management and data event settings for your trail. By default, trails created without specific event selectors will be configured to log all read and write management events, and no data events. When an event occurs in your account, CloudTrail evaluates the event selector for all trails. For each trail, if the event matches any event selector, the trail processes and logs the event. If the event doesn't match any event selector, the trail doesn't log the event.</p> <p>You can configure up to five event selectors for a trail.</p>"]
module LookupAttribute =
  struct
    type t =
      {
      attribute_key: LookupAttributeKey.t
        [@ocaml.doc
          "<p>Specifies an attribute on which to filter the events returned.</p>"];
      attribute_value: String.t
        [@ocaml.doc
          "<p>Specifies a value for the specified AttributeKey.</p>"]}
    [@@ocaml.doc
      "<p>Specifies an attribute and value that filter the events returned.</p>"]
    let make ~attribute_key  ~attribute_value  () =
      { attribute_key; attribute_value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("attribute_value", (String.to_json v.attribute_value));
           Some
             ("attribute_key", (LookupAttributeKey.to_json v.attribute_key))])
    let of_json j =
      {
        attribute_key =
          (LookupAttributeKey.of_json
             (Util.of_option_exn (Json.lookup j "attribute_key")));
        attribute_value =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "attribute_value")))
      }
  end[@@ocaml.doc
       "<p>Specifies an attribute and value that filter the events returned.</p>"]
module TrailInfo =
  struct
    type t =
      {
      trail_a_r_n: String.t option [@ocaml.doc "<p>The ARN of a trail.</p>"];
      name: String.t option [@ocaml.doc "<p>The name of a trail.</p>"];
      home_region: String.t option
        [@ocaml.doc "<p>The AWS region in which a trail was created.</p>"]}
    [@@ocaml.doc
      "<p>Information about a CloudTrail trail, including the trail's name, home region, and Amazon Resource Name (ARN).</p>"]
    let make ?trail_a_r_n  ?name  ?home_region  () =
      { trail_a_r_n; name; home_region }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.home_region
              (fun f -> ("home_region", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        home_region =
          (Util.option_map (Json.lookup j "home_region") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about a CloudTrail trail, including the trail's name, home region, and Amazon Resource Name (ARN).</p>"]
module Event =
  struct
    type t =
      {
      event_id: String.t option
        [@ocaml.doc "<p>The CloudTrail ID of the event returned.</p>"];
      event_name: String.t option
        [@ocaml.doc "<p>The name of the event returned.</p>"];
      read_only: String.t option
        [@ocaml.doc
          "<p>Information about whether the event is a write event or a read event. </p>"];
      access_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS access key ID that was used to sign the request. If the request was made with temporary security credentials, this is the access key ID of the temporary credentials.</p>"];
      event_time: DateTime.t option
        [@ocaml.doc "<p>The date and time of the event returned.</p>"];
      event_source: String.t option
        [@ocaml.doc "<p>The AWS service that the request was made to.</p>"];
      username: String.t option
        [@ocaml.doc
          "<p>A user name or role name of the requester that called the API in the event returned.</p>"];
      resources: ResourceList.t
        [@ocaml.doc
          "<p>A list of resources referenced by the event returned.</p>"];
      cloud_trail_event: String.t option
        [@ocaml.doc
          "<p>A JSON string that contains a representation of the event returned.</p>"]}
    [@@ocaml.doc
      "<p>Contains information about an event that was returned by a lookup request. The result includes a representation of a CloudTrail event.</p>"]
    let make ?event_id  ?event_name  ?read_only  ?access_key_id  ?event_time 
      ?event_source  ?username  ?(resources= [])  ?cloud_trail_event  () =
      {
        event_id;
        event_name;
        read_only;
        access_key_id;
        event_time;
        event_source;
        username;
        resources;
        cloud_trail_event
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_trail_event
              (fun f -> ("cloud_trail_event", (String.to_json f)));
           Some ("resources", (ResourceList.to_json v.resources));
           Util.option_map v.username
             (fun f -> ("username", (String.to_json f)));
           Util.option_map v.event_source
             (fun f -> ("event_source", (String.to_json f)));
           Util.option_map v.event_time
             (fun f -> ("event_time", (DateTime.to_json f)));
           Util.option_map v.access_key_id
             (fun f -> ("access_key_id", (String.to_json f)));
           Util.option_map v.read_only
             (fun f -> ("read_only", (String.to_json f)));
           Util.option_map v.event_name
             (fun f -> ("event_name", (String.to_json f)));
           Util.option_map v.event_id
             (fun f -> ("event_id", (String.to_json f)))])
    let of_json j =
      {
        event_id =
          (Util.option_map (Json.lookup j "event_id") String.of_json);
        event_name =
          (Util.option_map (Json.lookup j "event_name") String.of_json);
        read_only =
          (Util.option_map (Json.lookup j "read_only") String.of_json);
        access_key_id =
          (Util.option_map (Json.lookup j "access_key_id") String.of_json);
        event_time =
          (Util.option_map (Json.lookup j "event_time") DateTime.of_json);
        event_source =
          (Util.option_map (Json.lookup j "event_source") String.of_json);
        username =
          (Util.option_map (Json.lookup j "username") String.of_json);
        resources =
          (ResourceList.of_json
             (Util.of_option_exn (Json.lookup j "resources")));
        cloud_trail_event =
          (Util.option_map (Json.lookup j "cloud_trail_event") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Contains information about an event that was returned by a lookup request. The result includes a representation of a CloudTrail event.</p>"]
module PublicKey =
  struct
    type t =
      {
      value: Blob.t option
        [@ocaml.doc
          "<p>The DER encoded public key value in PKCS#1 format.</p>"];
      validity_start_time: DateTime.t option
        [@ocaml.doc
          "<p>The starting time of validity of the public key.</p>"];
      validity_end_time: DateTime.t option
        [@ocaml.doc "<p>The ending time of validity of the public key.</p>"];
      fingerprint: String.t option
        [@ocaml.doc "<p>The fingerprint of the public key.</p>"]}[@@ocaml.doc
                                                                   "<p>Contains information about a returned public key.</p>"]
    let make ?value  ?validity_start_time  ?validity_end_time  ?fingerprint 
      () = { value; validity_start_time; validity_end_time; fingerprint }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.fingerprint
              (fun f -> ("fingerprint", (String.to_json f)));
           Util.option_map v.validity_end_time
             (fun f -> ("validity_end_time", (DateTime.to_json f)));
           Util.option_map v.validity_start_time
             (fun f -> ("validity_start_time", (DateTime.to_json f)));
           Util.option_map v.value (fun f -> ("value", (Blob.to_json f)))])
    let of_json j =
      {
        value = (Util.option_map (Json.lookup j "value") Blob.of_json);
        validity_start_time =
          (Util.option_map (Json.lookup j "validity_start_time")
             DateTime.of_json);
        validity_end_time =
          (Util.option_map (Json.lookup j "validity_end_time")
             DateTime.of_json);
        fingerprint =
          (Util.option_map (Json.lookup j "fingerprint") String.of_json)
      }
  end[@@ocaml.doc "<p>Contains information about a returned public key.</p>"]
module Trail =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>Name of the trail set by calling <a>CreateTrail</a>. The maximum length is 128 characters.</p>"];
      s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>Name of the Amazon S3 bucket into which CloudTrail delivers your trail files. See <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create_trail_naming_policy.html\">Amazon S3 Bucket Naming Requirements</a>.</p>"];
      s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-find-log-files.html\">Finding Your CloudTrail Log Files</a>.The maximum length is 200 characters.</p>"];
      sns_topic_name: String.t option
        [@ocaml.doc
          "<p>This field is no longer in use. Use SnsTopicARN.</p>"];
      sns_topic_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the Amazon SNS topic that CloudTrail uses to send notifications when log files are delivered. The format of a topic ARN is:</p> <p> <code>arn:aws:sns:us-east-2:123456789012:MyTopic</code> </p>"];
      include_global_service_events: Boolean.t option
        [@ocaml.doc
          "<p>Set to <b>True</b> to include AWS API calls from AWS global services such as IAM. Otherwise, <b>False</b>.</p>"];
      is_multi_region_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail exists only in one region or exists in all regions.</p>"];
      home_region: String.t option
        [@ocaml.doc "<p>The region in which the trail was created.</p>"];
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the trail. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      log_file_validation_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether log file validation is enabled.</p>"];
      cloud_watch_logs_log_group_arn: String.t option
        [@ocaml.doc
          "<p>Specifies an Amazon Resource Name (ARN), a unique identifier that represents the log group to which CloudTrail logs will be delivered.</p>"];
      cloud_watch_logs_role_arn: String.t option
        [@ocaml.doc
          "<p>Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>Specifies the KMS key ID that encrypts the logs delivered by CloudTrail. The value is a fully specified ARN to a KMS key in the format:</p> <p> <code>arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012</code> </p>"];
      has_custom_event_selectors: Boolean.t option
        [@ocaml.doc
          "<p>Specifies if the trail has custom event selectors.</p>"];
      has_insight_selectors: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether a trail has insight types specified in an <code>InsightSelector</code> list.</p>"];
      is_organization_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is an organization trail.</p>"]}
    [@@ocaml.doc "<p>The settings for a trail.</p>"]
    let make ?name  ?s3_bucket_name  ?s3_key_prefix  ?sns_topic_name 
      ?sns_topic_a_r_n  ?include_global_service_events 
      ?is_multi_region_trail  ?home_region  ?trail_a_r_n 
      ?log_file_validation_enabled  ?cloud_watch_logs_log_group_arn 
      ?cloud_watch_logs_role_arn  ?kms_key_id  ?has_custom_event_selectors 
      ?has_insight_selectors  ?is_organization_trail  () =
      {
        name;
        s3_bucket_name;
        s3_key_prefix;
        sns_topic_name;
        sns_topic_a_r_n;
        include_global_service_events;
        is_multi_region_trail;
        home_region;
        trail_a_r_n;
        log_file_validation_enabled;
        cloud_watch_logs_log_group_arn;
        cloud_watch_logs_role_arn;
        kms_key_id;
        has_custom_event_selectors;
        has_insight_selectors;
        is_organization_trail
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_organization_trail
              (fun f -> ("is_organization_trail", (Boolean.to_json f)));
           Util.option_map v.has_insight_selectors
             (fun f -> ("has_insight_selectors", (Boolean.to_json f)));
           Util.option_map v.has_custom_event_selectors
             (fun f -> ("has_custom_event_selectors", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_role_arn
             (fun f -> ("cloud_watch_logs_role_arn", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_log_group_arn
             (fun f -> ("cloud_watch_logs_log_group_arn", (String.to_json f)));
           Util.option_map v.log_file_validation_enabled
             (fun f -> ("log_file_validation_enabled", (Boolean.to_json f)));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)));
           Util.option_map v.home_region
             (fun f -> ("home_region", (String.to_json f)));
           Util.option_map v.is_multi_region_trail
             (fun f -> ("is_multi_region_trail", (Boolean.to_json f)));
           Util.option_map v.include_global_service_events
             (fun f -> ("include_global_service_events", (Boolean.to_json f)));
           Util.option_map v.sns_topic_a_r_n
             (fun f -> ("sns_topic_a_r_n", (String.to_json f)));
           Util.option_map v.sns_topic_name
             (fun f -> ("sns_topic_name", (String.to_json f)));
           Util.option_map v.s3_key_prefix
             (fun f -> ("s3_key_prefix", (String.to_json f)));
           Util.option_map v.s3_bucket_name
             (fun f -> ("s3_bucket_name", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        s3_bucket_name =
          (Util.option_map (Json.lookup j "s3_bucket_name") String.of_json);
        s3_key_prefix =
          (Util.option_map (Json.lookup j "s3_key_prefix") String.of_json);
        sns_topic_name =
          (Util.option_map (Json.lookup j "sns_topic_name") String.of_json);
        sns_topic_a_r_n =
          (Util.option_map (Json.lookup j "sns_topic_a_r_n") String.of_json);
        include_global_service_events =
          (Util.option_map (Json.lookup j "include_global_service_events")
             Boolean.of_json);
        is_multi_region_trail =
          (Util.option_map (Json.lookup j "is_multi_region_trail")
             Boolean.of_json);
        home_region =
          (Util.option_map (Json.lookup j "home_region") String.of_json);
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        log_file_validation_enabled =
          (Util.option_map (Json.lookup j "log_file_validation_enabled")
             Boolean.of_json);
        cloud_watch_logs_log_group_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_log_group_arn")
             String.of_json);
        cloud_watch_logs_role_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_role_arn")
             String.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json);
        has_custom_event_selectors =
          (Util.option_map (Json.lookup j "has_custom_event_selectors")
             Boolean.of_json);
        has_insight_selectors =
          (Util.option_map (Json.lookup j "has_insight_selectors")
             Boolean.of_json);
        is_organization_trail =
          (Util.option_map (Json.lookup j "is_organization_trail")
             Boolean.of_json)
      }
  end[@@ocaml.doc "<p>The settings for a trail.</p>"]
module InsightSelectors =
  struct
    type t = InsightSelector.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InsightSelector.to_query v
    let to_headers v = Headers.to_headers_list InsightSelector.to_headers v
    let to_json v = `List (List.map InsightSelector.to_json v)
    let of_json j = Json.to_list InsightSelector.of_json j
  end
module ResourceIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ResourceTagList =
  struct
    type t = ResourceTag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceTag.to_query v
    let to_headers v = Headers.to_headers_list ResourceTag.to_headers v
    let to_json v = `List (List.map ResourceTag.to_json v)
    let of_json j = Json.to_list ResourceTag.of_json j
  end
module EventSelectors =
  struct
    type t = EventSelector.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EventSelector.to_query v
    let to_headers v = Headers.to_headers_list EventSelector.to_headers v
    let to_json v = `List (List.map EventSelector.to_json v)
    let of_json j = Json.to_list EventSelector.of_json j
  end
module EventCategory =
  struct
    type t =
      | Insight 
    let str_to_t = [("insight", Insight)]
    let t_to_str = [(Insight, "insight")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module LookupAttributesList =
  struct
    type t = LookupAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list LookupAttribute.to_query v
    let to_headers v = Headers.to_headers_list LookupAttribute.to_headers v
    let to_json v = `List (List.map LookupAttribute.to_json v)
    let of_json j = Json.to_list LookupAttribute.of_json j
  end
module Trails =
  struct
    type t = TrailInfo.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TrailInfo.to_query v
    let to_headers v = Headers.to_headers_list TrailInfo.to_headers v
    let to_json v = `List (List.map TrailInfo.to_json v)
    let of_json j = Json.to_list TrailInfo.of_json j
  end
module TrailNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module EventsList =
  struct
    type t = Event.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Event.to_query v
    let to_headers v = Headers.to_headers_list Event.to_headers v
    let to_json v = `List (List.map Event.to_json v)
    let of_json j = Json.to_list Event.of_json j
  end
module PublicKeyList =
  struct
    type t = PublicKey.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PublicKey.to_query v
    let to_headers v = Headers.to_headers_list PublicKey.to_headers v
    let to_json v = `List (List.map PublicKey.to_json v)
    let of_json j = Json.to_list PublicKey.of_json j
  end
module TrailList =
  struct
    type t = Trail.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Trail.to_query v
    let to_headers v = Headers.to_headers_list Trail.to_headers v
    let to_json v = `List (List.map Trail.to_json v)
    let of_json j = Json.to_list Trail.of_json j
  end
module DeleteTrailResponse =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module GetInsightSelectorsResponse =
  struct
    type t =
      {
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of a trail for which you want to get Insights selectors.</p>"];
      insight_selectors: InsightSelectors.t
        [@ocaml.doc
          "<p>A JSON string that contains the insight types you want to log on a trail. In this release, only <code>ApiCallRateInsight</code> is supported as an insight type.</p>"]}
    let make ?trail_a_r_n  ?(insight_selectors= [])  () =
      { trail_a_r_n; insight_selectors }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("insight_selectors",
                (InsightSelectors.to_json v.insight_selectors));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        insight_selectors =
          (InsightSelectors.of_json
             (Util.of_option_exn (Json.lookup j "insight_selectors")))
      }
  end
module ListTagsResponse =
  struct
    type t =
      {
      resource_tag_list: ResourceTagList.t
        [@ocaml.doc "<p>A list of resource tags.</p>"];
      next_token: String.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"]}[@@ocaml.doc
                                                         "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make ?(resource_tag_list= [])  ?next_token  () =
      { resource_tag_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("resource_tag_list",
               (ResourceTagList.to_json v.resource_tag_list))])
    let of_json j =
      {
        resource_tag_list =
          (ResourceTagList.of_json
             (Util.of_option_exn (Json.lookup j "resource_tag_list")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module PutEventSelectorsResponse =
  struct
    type t =
      {
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the trail that was updated with event selectors. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      event_selectors: EventSelectors.t
        [@ocaml.doc
          "<p>Specifies the event selectors configured for your trail.</p>"]}
    let make ?trail_a_r_n  ?(event_selectors= [])  () =
      { trail_a_r_n; event_selectors }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_selectors", (EventSelectors.to_json v.event_selectors));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        event_selectors =
          (EventSelectors.of_json
             (Util.of_option_exn (Json.lookup j "event_selectors")))
      }
  end
module StopLoggingResponse =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module GetTrailStatusResponse =
  struct
    type t =
      {
      is_logging: Boolean.t option
        [@ocaml.doc
          "<p>Whether the CloudTrail is currently logging AWS API calls.</p>"];
      latest_delivery_error: String.t option
        [@ocaml.doc
          "<p>Displays any Amazon S3 error that CloudTrail encountered when attempting to deliver log files to the designated bucket. For more information see the topic <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html\">Error Responses</a> in the Amazon S3 API Reference. </p> <note> <p>This error occurs only when there is a problem with the destination S3 bucket and will not occur for timeouts. To resolve the issue, create a new bucket and call <code>UpdateTrail</code> to specify the new bucket, or fix the existing objects so that CloudTrail can again write to the bucket.</p> </note>"];
      latest_notification_error: String.t option
        [@ocaml.doc
          "<p>Displays any Amazon SNS error that CloudTrail encountered when attempting to send a notification. For more information about Amazon SNS errors, see the <a href=\"https://docs.aws.amazon.com/sns/latest/dg/welcome.html\">Amazon SNS Developer Guide</a>. </p>"];
      latest_delivery_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the date and time that CloudTrail last delivered log files to an account's Amazon S3 bucket.</p>"];
      latest_notification_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the date and time of the most recent Amazon SNS notification that CloudTrail has written a new log file to an account's Amazon S3 bucket.</p>"];
      start_logging_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the most recent date and time when CloudTrail started recording API calls for an AWS account.</p>"];
      stop_logging_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the most recent date and time when CloudTrail stopped recording API calls for an AWS account.</p>"];
      latest_cloud_watch_logs_delivery_error: String.t option
        [@ocaml.doc
          "<p>Displays any CloudWatch Logs error that CloudTrail encountered when attempting to deliver logs to CloudWatch Logs.</p>"];
      latest_cloud_watch_logs_delivery_time: DateTime.t option
        [@ocaml.doc
          "<p>Displays the most recent date and time when CloudTrail delivered logs to CloudWatch Logs.</p>"];
      latest_digest_delivery_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the date and time that CloudTrail last delivered a digest file to an account's Amazon S3 bucket.</p>"];
      latest_digest_delivery_error: String.t option
        [@ocaml.doc
          "<p>Displays any Amazon S3 error that CloudTrail encountered when attempting to deliver a digest file to the designated bucket. For more information see the topic <a href=\"https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html\">Error Responses</a> in the Amazon S3 API Reference. </p> <note> <p>This error occurs only when there is a problem with the destination S3 bucket and will not occur for timeouts. To resolve the issue, create a new bucket and call <code>UpdateTrail</code> to specify the new bucket, or fix the existing objects so that CloudTrail can again write to the bucket.</p> </note>"];
      latest_delivery_attempt_time: String.t option
        [@ocaml.doc "<p>This field is no longer in use.</p>"];
      latest_notification_attempt_time: String.t option
        [@ocaml.doc "<p>This field is no longer in use.</p>"];
      latest_notification_attempt_succeeded: String.t option
        [@ocaml.doc "<p>This field is no longer in use.</p>"];
      latest_delivery_attempt_succeeded: String.t option
        [@ocaml.doc "<p>This field is no longer in use.</p>"];
      time_logging_started: String.t option
        [@ocaml.doc "<p>This field is no longer in use.</p>"];
      time_logging_stopped: String.t option
        [@ocaml.doc "<p>This field is no longer in use.</p>"]}[@@ocaml.doc
                                                                "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make ?is_logging  ?latest_delivery_error  ?latest_notification_error 
      ?latest_delivery_time  ?latest_notification_time  ?start_logging_time 
      ?stop_logging_time  ?latest_cloud_watch_logs_delivery_error 
      ?latest_cloud_watch_logs_delivery_time  ?latest_digest_delivery_time 
      ?latest_digest_delivery_error  ?latest_delivery_attempt_time 
      ?latest_notification_attempt_time 
      ?latest_notification_attempt_succeeded 
      ?latest_delivery_attempt_succeeded  ?time_logging_started 
      ?time_logging_stopped  () =
      {
        is_logging;
        latest_delivery_error;
        latest_notification_error;
        latest_delivery_time;
        latest_notification_time;
        start_logging_time;
        stop_logging_time;
        latest_cloud_watch_logs_delivery_error;
        latest_cloud_watch_logs_delivery_time;
        latest_digest_delivery_time;
        latest_digest_delivery_error;
        latest_delivery_attempt_time;
        latest_notification_attempt_time;
        latest_notification_attempt_succeeded;
        latest_delivery_attempt_succeeded;
        time_logging_started;
        time_logging_stopped
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.time_logging_stopped
              (fun f -> ("time_logging_stopped", (String.to_json f)));
           Util.option_map v.time_logging_started
             (fun f -> ("time_logging_started", (String.to_json f)));
           Util.option_map v.latest_delivery_attempt_succeeded
             (fun f ->
                ("latest_delivery_attempt_succeeded", (String.to_json f)));
           Util.option_map v.latest_notification_attempt_succeeded
             (fun f ->
                ("latest_notification_attempt_succeeded", (String.to_json f)));
           Util.option_map v.latest_notification_attempt_time
             (fun f ->
                ("latest_notification_attempt_time", (String.to_json f)));
           Util.option_map v.latest_delivery_attempt_time
             (fun f -> ("latest_delivery_attempt_time", (String.to_json f)));
           Util.option_map v.latest_digest_delivery_error
             (fun f -> ("latest_digest_delivery_error", (String.to_json f)));
           Util.option_map v.latest_digest_delivery_time
             (fun f -> ("latest_digest_delivery_time", (DateTime.to_json f)));
           Util.option_map v.latest_cloud_watch_logs_delivery_time
             (fun f ->
                ("latest_cloud_watch_logs_delivery_time",
                  (DateTime.to_json f)));
           Util.option_map v.latest_cloud_watch_logs_delivery_error
             (fun f ->
                ("latest_cloud_watch_logs_delivery_error",
                  (String.to_json f)));
           Util.option_map v.stop_logging_time
             (fun f -> ("stop_logging_time", (DateTime.to_json f)));
           Util.option_map v.start_logging_time
             (fun f -> ("start_logging_time", (DateTime.to_json f)));
           Util.option_map v.latest_notification_time
             (fun f -> ("latest_notification_time", (DateTime.to_json f)));
           Util.option_map v.latest_delivery_time
             (fun f -> ("latest_delivery_time", (DateTime.to_json f)));
           Util.option_map v.latest_notification_error
             (fun f -> ("latest_notification_error", (String.to_json f)));
           Util.option_map v.latest_delivery_error
             (fun f -> ("latest_delivery_error", (String.to_json f)));
           Util.option_map v.is_logging
             (fun f -> ("is_logging", (Boolean.to_json f)))])
    let of_json j =
      {
        is_logging =
          (Util.option_map (Json.lookup j "is_logging") Boolean.of_json);
        latest_delivery_error =
          (Util.option_map (Json.lookup j "latest_delivery_error")
             String.of_json);
        latest_notification_error =
          (Util.option_map (Json.lookup j "latest_notification_error")
             String.of_json);
        latest_delivery_time =
          (Util.option_map (Json.lookup j "latest_delivery_time")
             DateTime.of_json);
        latest_notification_time =
          (Util.option_map (Json.lookup j "latest_notification_time")
             DateTime.of_json);
        start_logging_time =
          (Util.option_map (Json.lookup j "start_logging_time")
             DateTime.of_json);
        stop_logging_time =
          (Util.option_map (Json.lookup j "stop_logging_time")
             DateTime.of_json);
        latest_cloud_watch_logs_delivery_error =
          (Util.option_map
             (Json.lookup j "latest_cloud_watch_logs_delivery_error")
             String.of_json);
        latest_cloud_watch_logs_delivery_time =
          (Util.option_map
             (Json.lookup j "latest_cloud_watch_logs_delivery_time")
             DateTime.of_json);
        latest_digest_delivery_time =
          (Util.option_map (Json.lookup j "latest_digest_delivery_time")
             DateTime.of_json);
        latest_digest_delivery_error =
          (Util.option_map (Json.lookup j "latest_digest_delivery_error")
             String.of_json);
        latest_delivery_attempt_time =
          (Util.option_map (Json.lookup j "latest_delivery_attempt_time")
             String.of_json);
        latest_notification_attempt_time =
          (Util.option_map (Json.lookup j "latest_notification_attempt_time")
             String.of_json);
        latest_notification_attempt_succeeded =
          (Util.option_map
             (Json.lookup j "latest_notification_attempt_succeeded")
             String.of_json);
        latest_delivery_attempt_succeeded =
          (Util.option_map
             (Json.lookup j "latest_delivery_attempt_succeeded")
             String.of_json);
        time_logging_started =
          (Util.option_map (Json.lookup j "time_logging_started")
             String.of_json);
        time_logging_stopped =
          (Util.option_map (Json.lookup j "time_logging_stopped")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module ListTrailsResponse =
  struct
    type t =
      {
      trails: Trails.t
        [@ocaml.doc
          "<p>Returns the name, ARN, and home region of trails in the current account.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use to get the next page of results after a previous API call. If the token does not appear, there are no more results to return. The token must be passed in with the same parameters as the previous call. For example, if the original call specified an AttributeKey of 'Username' with a value of 'root', the call with NextToken should include those same parameters.</p>"]}
    let make ?(trails= [])  ?next_token  () = { trails; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("trails", (Trails.to_json v.trails))])
    let of_json j =
      {
        trails =
          (Trails.of_json (Util.of_option_exn (Json.lookup j "trails")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetTrailResponse =
  struct
    type t = {
      trail: Trail.t option }
    let make ?trail  () = { trail }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.trail (fun f -> ("trail", (Trail.to_json f)))])
    let of_json j =
      { trail = (Util.option_map (Json.lookup j "trail") Trail.of_json) }
  end
module UpdateTrailResponse =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>Specifies the name of the trail.</p>"];
      s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the Amazon S3 bucket designated for publishing log files.</p>"];
      s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-find-log-files.html\">Finding Your CloudTrail Log Files</a>.</p>"];
      sns_topic_name: String.t option
        [@ocaml.doc
          "<p>This field is no longer in use. Use SnsTopicARN.</p>"];
      sns_topic_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the Amazon SNS topic that CloudTrail uses to send notifications when log files are delivered. The format of a topic ARN is:</p> <p> <code>arn:aws:sns:us-east-2:123456789012:MyTopic</code> </p>"];
      include_global_service_events: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is publishing events from global services such as IAM to the log files.</p>"];
      is_multi_region_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail exists in one region or in all regions.</p>"];
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the trail that was updated. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      log_file_validation_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether log file integrity validation is enabled.</p>"];
      cloud_watch_logs_log_group_arn: String.t option
        [@ocaml.doc
          "<p>Specifies the Amazon Resource Name (ARN) of the log group to which CloudTrail logs will be delivered.</p>"];
      cloud_watch_logs_role_arn: String.t option
        [@ocaml.doc
          "<p>Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>Specifies the KMS key ID that encrypts the logs delivered by CloudTrail. The value is a fully specified ARN to a KMS key in the format:</p> <p> <code>arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012</code> </p>"];
      is_organization_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is an organization trail.</p>"]}
    [@@ocaml.doc
      "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make ?name  ?s3_bucket_name  ?s3_key_prefix  ?sns_topic_name 
      ?sns_topic_a_r_n  ?include_global_service_events 
      ?is_multi_region_trail  ?trail_a_r_n  ?log_file_validation_enabled 
      ?cloud_watch_logs_log_group_arn  ?cloud_watch_logs_role_arn 
      ?kms_key_id  ?is_organization_trail  () =
      {
        name;
        s3_bucket_name;
        s3_key_prefix;
        sns_topic_name;
        sns_topic_a_r_n;
        include_global_service_events;
        is_multi_region_trail;
        trail_a_r_n;
        log_file_validation_enabled;
        cloud_watch_logs_log_group_arn;
        cloud_watch_logs_role_arn;
        kms_key_id;
        is_organization_trail
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_organization_trail
              (fun f -> ("is_organization_trail", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_role_arn
             (fun f -> ("cloud_watch_logs_role_arn", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_log_group_arn
             (fun f -> ("cloud_watch_logs_log_group_arn", (String.to_json f)));
           Util.option_map v.log_file_validation_enabled
             (fun f -> ("log_file_validation_enabled", (Boolean.to_json f)));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)));
           Util.option_map v.is_multi_region_trail
             (fun f -> ("is_multi_region_trail", (Boolean.to_json f)));
           Util.option_map v.include_global_service_events
             (fun f -> ("include_global_service_events", (Boolean.to_json f)));
           Util.option_map v.sns_topic_a_r_n
             (fun f -> ("sns_topic_a_r_n", (String.to_json f)));
           Util.option_map v.sns_topic_name
             (fun f -> ("sns_topic_name", (String.to_json f)));
           Util.option_map v.s3_key_prefix
             (fun f -> ("s3_key_prefix", (String.to_json f)));
           Util.option_map v.s3_bucket_name
             (fun f -> ("s3_bucket_name", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        s3_bucket_name =
          (Util.option_map (Json.lookup j "s3_bucket_name") String.of_json);
        s3_key_prefix =
          (Util.option_map (Json.lookup j "s3_key_prefix") String.of_json);
        sns_topic_name =
          (Util.option_map (Json.lookup j "sns_topic_name") String.of_json);
        sns_topic_a_r_n =
          (Util.option_map (Json.lookup j "sns_topic_a_r_n") String.of_json);
        include_global_service_events =
          (Util.option_map (Json.lookup j "include_global_service_events")
             Boolean.of_json);
        is_multi_region_trail =
          (Util.option_map (Json.lookup j "is_multi_region_trail")
             Boolean.of_json);
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        log_file_validation_enabled =
          (Util.option_map (Json.lookup j "log_file_validation_enabled")
             Boolean.of_json);
        cloud_watch_logs_log_group_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_log_group_arn")
             String.of_json);
        cloud_watch_logs_role_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_role_arn")
             String.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json);
        is_organization_trail =
          (Util.option_map (Json.lookup j "is_organization_trail")
             Boolean.of_json)
      }
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module AddTagsResponse =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module StartLoggingResponse =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module LookupEventsResponse =
  struct
    type t =
      {
      events: EventsList.t
        [@ocaml.doc
          "<p>A list of events returned based on the lookup attributes specified and the CloudTrail event. The events list is sorted by time. The most recent event is listed first.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use to get the next page of results after a previous API call. If the token does not appear, there are no more results to return. The token must be passed in with the same parameters as the previous call. For example, if the original call specified an AttributeKey of 'Username' with a value of 'root', the call with NextToken should include those same parameters.</p>"]}
    [@@ocaml.doc "<p>Contains a response to a LookupEvents action.</p>"]
    let make ?(events= [])  ?next_token  () = { events; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("events", (EventsList.to_json v.events))])
    let of_json j =
      {
        events =
          (EventsList.of_json (Util.of_option_exn (Json.lookup j "events")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end[@@ocaml.doc "<p>Contains a response to a LookupEvents action.</p>"]
module RemoveTagsResponse =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module GetEventSelectorsResponse =
  struct
    type t =
      {
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>The specified trail ARN that has the event selectors.</p>"];
      event_selectors: EventSelectors.t
        [@ocaml.doc
          "<p>The event selectors that are configured for the trail.</p>"]}
    let make ?trail_a_r_n  ?(event_selectors= [])  () =
      { trail_a_r_n; event_selectors }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_selectors", (EventSelectors.to_json v.event_selectors));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        event_selectors =
          (EventSelectors.of_json
             (Util.of_option_exn (Json.lookup j "event_selectors")))
      }
  end
module PutInsightSelectorsResponse =
  struct
    type t =
      {
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of a trail for which you want to change or add Insights selectors.</p>"];
      insight_selectors: InsightSelectors.t
        [@ocaml.doc
          "<p>A JSON string that contains the insight types you want to log on a trail. In this release, only <code>ApiCallRateInsight</code> is supported as an insight type.</p>"]}
    let make ?trail_a_r_n  ?(insight_selectors= [])  () =
      { trail_a_r_n; insight_selectors }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("insight_selectors",
                (InsightSelectors.to_json v.insight_selectors));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)))])
    let of_json j =
      {
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        insight_selectors =
          (InsightSelectors.of_json
             (Util.of_option_exn (Json.lookup j "insight_selectors")))
      }
  end
module ListPublicKeysResponse =
  struct
    type t =
      {
      public_key_list: PublicKeyList.t
        [@ocaml.doc
          "<p>Contains an array of PublicKey objects.</p> <note> <p>The returned public keys may have validity time ranges that overlap.</p> </note>"];
      next_token: String.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"]}[@@ocaml.doc
                                                         "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make ?(public_key_list= [])  ?next_token  () =
      { public_key_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("public_key_list", (PublicKeyList.to_json v.public_key_list))])
    let of_json j =
      {
        public_key_list =
          (PublicKeyList.of_json
             (Util.of_option_exn (Json.lookup j "public_key_list")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module CreateTrailResponse =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>Specifies the name of the trail.</p>"];
      s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the Amazon S3 bucket designated for publishing log files.</p>"];
      s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>Specifies the Amazon S3 key prefix that comes after the name of the bucket you have designated for log file delivery. For more information, see <a href=\"https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-find-log-files.html\">Finding Your CloudTrail Log Files</a>.</p>"];
      sns_topic_name: String.t option
        [@ocaml.doc
          "<p>This field is no longer in use. Use SnsTopicARN.</p>"];
      sns_topic_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the Amazon SNS topic that CloudTrail uses to send notifications when log files are delivered. The format of a topic ARN is:</p> <p> <code>arn:aws:sns:us-east-2:123456789012:MyTopic</code> </p>"];
      include_global_service_events: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is publishing events from global services such as IAM to the log files.</p>"];
      is_multi_region_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail exists in one region or in all regions.</p>"];
      trail_a_r_n: String.t option
        [@ocaml.doc
          "<p>Specifies the ARN of the trail that was created. The format of a trail ARN is:</p> <p> <code>arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail</code> </p>"];
      log_file_validation_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether log file integrity validation is enabled.</p>"];
      cloud_watch_logs_log_group_arn: String.t option
        [@ocaml.doc
          "<p>Specifies the Amazon Resource Name (ARN) of the log group to which CloudTrail logs will be delivered.</p>"];
      cloud_watch_logs_role_arn: String.t option
        [@ocaml.doc
          "<p>Specifies the role for the CloudWatch Logs endpoint to assume to write to a user's log group.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>Specifies the KMS key ID that encrypts the logs delivered by CloudTrail. The value is a fully specified ARN to a KMS key in the format:</p> <p> <code>arn:aws:kms:us-east-2:123456789012:key/12345678-1234-1234-1234-123456789012</code> </p>"];
      is_organization_trail: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the trail is an organization trail.</p>"]}
    [@@ocaml.doc
      "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make ?name  ?s3_bucket_name  ?s3_key_prefix  ?sns_topic_name 
      ?sns_topic_a_r_n  ?include_global_service_events 
      ?is_multi_region_trail  ?trail_a_r_n  ?log_file_validation_enabled 
      ?cloud_watch_logs_log_group_arn  ?cloud_watch_logs_role_arn 
      ?kms_key_id  ?is_organization_trail  () =
      {
        name;
        s3_bucket_name;
        s3_key_prefix;
        sns_topic_name;
        sns_topic_a_r_n;
        include_global_service_events;
        is_multi_region_trail;
        trail_a_r_n;
        log_file_validation_enabled;
        cloud_watch_logs_log_group_arn;
        cloud_watch_logs_role_arn;
        kms_key_id;
        is_organization_trail
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_organization_trail
              (fun f -> ("is_organization_trail", (Boolean.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_role_arn
             (fun f -> ("cloud_watch_logs_role_arn", (String.to_json f)));
           Util.option_map v.cloud_watch_logs_log_group_arn
             (fun f -> ("cloud_watch_logs_log_group_arn", (String.to_json f)));
           Util.option_map v.log_file_validation_enabled
             (fun f -> ("log_file_validation_enabled", (Boolean.to_json f)));
           Util.option_map v.trail_a_r_n
             (fun f -> ("trail_a_r_n", (String.to_json f)));
           Util.option_map v.is_multi_region_trail
             (fun f -> ("is_multi_region_trail", (Boolean.to_json f)));
           Util.option_map v.include_global_service_events
             (fun f -> ("include_global_service_events", (Boolean.to_json f)));
           Util.option_map v.sns_topic_a_r_n
             (fun f -> ("sns_topic_a_r_n", (String.to_json f)));
           Util.option_map v.sns_topic_name
             (fun f -> ("sns_topic_name", (String.to_json f)));
           Util.option_map v.s3_key_prefix
             (fun f -> ("s3_key_prefix", (String.to_json f)));
           Util.option_map v.s3_bucket_name
             (fun f -> ("s3_bucket_name", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        s3_bucket_name =
          (Util.option_map (Json.lookup j "s3_bucket_name") String.of_json);
        s3_key_prefix =
          (Util.option_map (Json.lookup j "s3_key_prefix") String.of_json);
        sns_topic_name =
          (Util.option_map (Json.lookup j "sns_topic_name") String.of_json);
        sns_topic_a_r_n =
          (Util.option_map (Json.lookup j "sns_topic_a_r_n") String.of_json);
        include_global_service_events =
          (Util.option_map (Json.lookup j "include_global_service_events")
             Boolean.of_json);
        is_multi_region_trail =
          (Util.option_map (Json.lookup j "is_multi_region_trail")
             Boolean.of_json);
        trail_a_r_n =
          (Util.option_map (Json.lookup j "trail_a_r_n") String.of_json);
        log_file_validation_enabled =
          (Util.option_map (Json.lookup j "log_file_validation_enabled")
             Boolean.of_json);
        cloud_watch_logs_log_group_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_log_group_arn")
             String.of_json);
        cloud_watch_logs_role_arn =
          (Util.option_map (Json.lookup j "cloud_watch_logs_role_arn")
             String.of_json);
        kms_key_id =
          (Util.option_map (Json.lookup j "kms_key_id") String.of_json);
        is_organization_trail =
          (Util.option_map (Json.lookup j "is_organization_trail")
             Boolean.of_json)
      }
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
module DescribeTrailsResponse =
  struct
    type t =
      {
      trail_list: TrailList.t
        [@ocaml.doc
          "<p>The list of trail objects. Trail objects with string values are only returned if values for the objects exist in a trail's configuration. For example, <code>SNSTopicName</code> and <code>SNSTopicARN</code> are only returned in results if a trail is configured to send SNS notifications. Similarly, <code>KMSKeyId</code> only appears in results if a trail's log files are encrypted with AWS KMS-managed keys.</p>"]}
    [@@ocaml.doc
      "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]
    let make ?(trail_list= [])  () = { trail_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("trail_list", (TrailList.to_json v.trail_list))])
    let of_json j =
      {
        trail_list =
          (TrailList.of_json
             (Util.of_option_exn (Json.lookup j "trail_list")))
      }
  end[@@ocaml.doc
       "<p>Returns the objects or data listed below if successful. Otherwise, returns an error.</p>"]