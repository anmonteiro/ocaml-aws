open Aws
open Aws.BaseTypes
module RequiresRecreation =
  struct
    type t =
      | Never 
      | Conditionally 
      | Always 
    let str_to_t =
      [("Always", Always);
      ("Conditionally", Conditionally);
      ("Never", Never)]
    let t_to_str =
      [(Always, "Always");
      (Conditionally, "Conditionally");
      (Never, "Never")]
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
module ResourceAttribute =
  struct
    type t =
      | Properties 
      | Metadata 
      | CreationPolicy 
      | UpdatePolicy 
      | DeletionPolicy 
      | Tags 
    let str_to_t =
      [("Tags", Tags);
      ("DeletionPolicy", DeletionPolicy);
      ("UpdatePolicy", UpdatePolicy);
      ("CreationPolicy", CreationPolicy);
      ("Metadata", Metadata);
      ("Properties", Properties)]
    let t_to_str =
      [(Tags, "Tags");
      (DeletionPolicy, "DeletionPolicy");
      (UpdatePolicy, "UpdatePolicy");
      (CreationPolicy, "CreationPolicy");
      (Metadata, "Metadata");
      (Properties, "Properties")]
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
module ChangeSource =
  struct
    type t =
      | ResourceReference 
      | ParameterReference 
      | ResourceAttribute 
      | DirectModification 
      | Automatic 
    let str_to_t =
      [("Automatic", Automatic);
      ("DirectModification", DirectModification);
      ("ResourceAttribute", ResourceAttribute);
      ("ParameterReference", ParameterReference);
      ("ResourceReference", ResourceReference)]
    let t_to_str =
      [(Automatic, "Automatic");
      (DirectModification, "DirectModification");
      (ResourceAttribute, "ResourceAttribute");
      (ParameterReference, "ParameterReference");
      (ResourceReference, "ResourceReference")]
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
module EvaluationType =
  struct
    type t =
      | Static 
      | Dynamic 
    let str_to_t = [("Dynamic", Dynamic); ("Static", Static)]
    let t_to_str = [(Dynamic, "Dynamic"); (Static, "Static")]
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
module ResourceTargetDefinition =
  struct
    type t =
      {
      attribute: ResourceAttribute.t option
        [@ocaml.doc
          "<p>Indicates which resource attribute is triggering this update, such as a change in the resource attribute's <code>Metadata</code>, <code>Properties</code>, or <code>Tags</code>.</p>"];
      name: String.t option
        [@ocaml.doc
          "<p>If the <code>Attribute</code> value is <code>Properties</code>, the name of the property. For all other attributes, the value is null.</p>"];
      requires_recreation: RequiresRecreation.t option
        [@ocaml.doc
          "<p>If the <code>Attribute</code> value is <code>Properties</code>, indicates whether a change to this property causes the resource to be recreated. The value can be <code>Never</code>, <code>Always</code>, or <code>Conditionally</code>. To determine the conditions for a <code>Conditionally</code> recreation, see the update behavior for that <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\">property</a> in the AWS CloudFormation User Guide.</p>"]}
    [@@ocaml.doc
      "<p>The field that AWS CloudFormation will change, such as the name of a resource's property, and whether the resource will be recreated.</p>"]
    let make ?attribute  ?name  ?requires_recreation  () =
      { attribute; name; requires_recreation }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.requires_recreation
              (fun f ->
                 ("requires_recreation", (RequiresRecreation.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.attribute
             (fun f -> ("attribute", (ResourceAttribute.to_json f)))])
    let parse xml =
      Some
        {
          attribute =
            (Util.option_bind (Xml.member "Attribute" xml)
               ResourceAttribute.parse);
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          requires_recreation =
            (Util.option_bind (Xml.member "RequiresRecreation" xml)
               RequiresRecreation.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.attribute
                (fun f ->
                   Ezxmlm.make_tag "Attribute"
                     ([], (ResourceAttribute.to_xml f)))])
            @
            [Util.option_map v.name
               (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
           @
           [Util.option_map v.requires_recreation
              (fun f ->
                 Ezxmlm.make_tag "RequiresRecreation"
                   ([], (RequiresRecreation.to_xml f)))])
  end[@@ocaml.doc
       "<p>The field that AWS CloudFormation will change, such as the name of a resource's property, and whether the resource will be recreated.</p>"]
module DifferenceType =
  struct
    type t =
      | ADD 
      | REMOVE 
      | NOT_EQUAL 
    let str_to_t =
      [("NOT_EQUAL", NOT_EQUAL); ("REMOVE", REMOVE); ("ADD", ADD)]
    let t_to_str =
      [(NOT_EQUAL, "NOT_EQUAL"); (REMOVE, "REMOVE"); (ADD, "ADD")]
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
module ResourceChangeDetail =
  struct
    type t =
      {
      target: ResourceTargetDefinition.t option
        [@ocaml.doc
          "<p>A <code>ResourceTargetDefinition</code> structure that describes the field that AWS CloudFormation will change and whether the resource will be recreated.</p>"];
      evaluation: EvaluationType.t option
        [@ocaml.doc
          "<p>Indicates whether AWS CloudFormation can determine the target value, and whether the target value will change before you execute a change set.</p> <p>For <code>Static</code> evaluations, AWS CloudFormation can determine that the target value will change, and its value. For example, if you directly modify the <code>InstanceType</code> property of an EC2 instance, AWS CloudFormation knows that this property value will change, and its value, so this is a <code>Static</code> evaluation.</p> <p>For <code>Dynamic</code> evaluations, cannot determine the target value because it depends on the result of an intrinsic function, such as a <code>Ref</code> or <code>Fn::GetAtt</code> intrinsic function, when the stack is updated. For example, if your template includes a reference to a resource that is conditionally recreated, the value of the reference (the physical ID of the resource) might change, depending on if the resource is recreated. If the resource is recreated, it will have a new physical ID, so all references to that resource will also be updated.</p>"];
      change_source: ChangeSource.t option
        [@ocaml.doc
          "<p>The group to which the <code>CausingEntity</code> value belongs. There are five entity groups:</p> <ul> <li> <p> <code>ResourceReference</code> entities are <code>Ref</code> intrinsic functions that refer to resources in the template, such as <code>{ \"Ref\" : \"MyEC2InstanceResource\" }</code>.</p> </li> <li> <p> <code>ParameterReference</code> entities are <code>Ref</code> intrinsic functions that get template parameter values, such as <code>{ \"Ref\" : \"MyPasswordParameter\" }</code>.</p> </li> <li> <p> <code>ResourceAttribute</code> entities are <code>Fn::GetAtt</code> intrinsic functions that get resource attribute values, such as <code>{ \"Fn::GetAtt\" : [ \"MyEC2InstanceResource\", \"PublicDnsName\" ] }</code>.</p> </li> <li> <p> <code>DirectModification</code> entities are changes that are made directly to the template.</p> </li> <li> <p> <code>Automatic</code> entities are <code>AWS::CloudFormation::Stack</code> resource types, which are also known as nested stacks. If you made no changes to the <code>AWS::CloudFormation::Stack</code> resource, AWS CloudFormation sets the <code>ChangeSource</code> to <code>Automatic</code> because the nested stack's template might have changed. Changes to a nested stack's template aren't visible to AWS CloudFormation until you run an update on the parent stack.</p> </li> </ul>"];
      causing_entity: String.t option
        [@ocaml.doc
          "<p>The identity of the entity that triggered this change. This entity is a member of the group that is specified by the <code>ChangeSource</code> field. For example, if you modified the value of the <code>KeyPairName</code> parameter, the <code>CausingEntity</code> is the name of the parameter (<code>KeyPairName</code>).</p> <p>If the <code>ChangeSource</code> value is <code>DirectModification</code>, no value is given for <code>CausingEntity</code>.</p>"]}
    [@@ocaml.doc
      "<p>For a resource with <code>Modify</code> as the action, the <code>ResourceChange</code> structure describes the changes AWS CloudFormation will make to that resource.</p>"]
    let make ?target  ?evaluation  ?change_source  ?causing_entity  () =
      { target; evaluation; change_source; causing_entity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.causing_entity
              (fun f -> ("causing_entity", (String.to_json f)));
           Util.option_map v.change_source
             (fun f -> ("change_source", (ChangeSource.to_json f)));
           Util.option_map v.evaluation
             (fun f -> ("evaluation", (EvaluationType.to_json f)));
           Util.option_map v.target
             (fun f -> ("target", (ResourceTargetDefinition.to_json f)))])
    let parse xml =
      Some
        {
          target =
            (Util.option_bind (Xml.member "Target" xml)
               ResourceTargetDefinition.parse);
          evaluation =
            (Util.option_bind (Xml.member "Evaluation" xml)
               EvaluationType.parse);
          change_source =
            (Util.option_bind (Xml.member "ChangeSource" xml)
               ChangeSource.parse);
          causing_entity =
            (Util.option_bind (Xml.member "CausingEntity" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.target
                 (fun f ->
                    Ezxmlm.make_tag "Target"
                      ([], (ResourceTargetDefinition.to_xml f)))])
             @
             [Util.option_map v.evaluation
                (fun f ->
                   Ezxmlm.make_tag "Evaluation"
                     ([], (EvaluationType.to_xml f)))])
            @
            [Util.option_map v.change_source
               (fun f ->
                  Ezxmlm.make_tag "ChangeSource"
                    ([], (ChangeSource.to_xml f)))])
           @
           [Util.option_map v.causing_entity
              (fun f ->
                 Ezxmlm.make_tag "CausingEntity" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>For a resource with <code>Modify</code> as the action, the <code>ResourceChange</code> structure describes the changes AWS CloudFormation will make to that resource.</p>"]
module RollbackTrigger =
  struct
    type t =
      {
      arn: String.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the rollback trigger.</p> <p>If a specified trigger is missing, the entire stack operation fails and is rolled back. </p>"];
      type_: String.t
        [@ocaml.doc
          "<p>The resource type of the rollback trigger. Currently, <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-cw-alarm.html\">AWS::CloudWatch::Alarm</a> is the only supported resource type.</p>"]}
    [@@ocaml.doc
      "<p>A rollback trigger AWS CloudFormation monitors during creation and updating of stacks. If any of the alarms you specify goes to ALARM state during the stack operation or within the specified monitoring period afterwards, CloudFormation rolls back the entire stack operation. </p>"]
    let make ~arn  ~type_  () = { arn; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("type_", (String.to_json v.type_));
           Some ("arn", (String.to_json v.arn))])
    let parse xml =
      Some
        {
          arn =
            (Xml.required "Arn"
               (Util.option_bind (Xml.member "Arn" xml) String.parse));
          type_ =
            (Xml.required "Type"
               (Util.option_bind (Xml.member "Type" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Arn" ([], (String.to_xml v.arn)))]) @
           [Some (Ezxmlm.make_tag "Type" ([], (String.to_xml v.type_)))])
  end[@@ocaml.doc
       "<p>A rollback trigger AWS CloudFormation monitors during creation and updating of stacks. If any of the alarms you specify goes to ALARM state during the stack operation or within the specified monitoring period afterwards, CloudFormation rolls back the entire stack operation. </p>"]
module StackResourceDriftStatus =
  struct
    type t =
      | IN_SYNC 
      | MODIFIED 
      | DELETED 
      | NOT_CHECKED 
    let str_to_t =
      [("NOT_CHECKED", NOT_CHECKED);
      ("DELETED", DELETED);
      ("MODIFIED", MODIFIED);
      ("IN_SYNC", IN_SYNC)]
    let t_to_str =
      [(NOT_CHECKED, "NOT_CHECKED");
      (DELETED, "DELETED");
      (MODIFIED, "MODIFIED");
      (IN_SYNC, "IN_SYNC")]
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
module AccountGateStatus =
  struct
    type t =
      | SUCCEEDED 
      | FAILED 
      | SKIPPED 
    let str_to_t =
      [("SKIPPED", SKIPPED); ("FAILED", FAILED); ("SUCCEEDED", SUCCEEDED)]
    let t_to_str =
      [(SKIPPED, "SKIPPED"); (FAILED, "FAILED"); (SUCCEEDED, "SUCCEEDED")]
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
module StackDriftStatus =
  struct
    type t =
      | DRIFTED 
      | IN_SYNC 
      | UNKNOWN 
      | NOT_CHECKED 
    let str_to_t =
      [("NOT_CHECKED", NOT_CHECKED);
      ("UNKNOWN", UNKNOWN);
      ("IN_SYNC", IN_SYNC);
      ("DRIFTED", DRIFTED)]
    let t_to_str =
      [(NOT_CHECKED, "NOT_CHECKED");
      (UNKNOWN, "UNKNOWN");
      (IN_SYNC, "IN_SYNC");
      (DRIFTED, "DRIFTED")]
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
module PhysicalResourceIdContextKeyValuePair =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>The resource context key.</p>"];
      value: String.t [@ocaml.doc "<p>The resource context value.</p>"]}
    [@@ocaml.doc
      "<p>Context information that enables AWS CloudFormation to uniquely identify a resource. AWS CloudFormation uses context key-value pairs in cases where a resource's logical and physical IDs are not enough to uniquely identify that resource. Each context key-value pair specifies a resource that contains the targeted resource.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key))])
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>Context information that enables AWS CloudFormation to uniquely identify a resource. AWS CloudFormation uses context key-value pairs in cases where a resource's logical and physical IDs are not enough to uniquely identify that resource. Each context key-value pair specifies a resource that contains the targeted resource.</p>"]
module PropertyDifference =
  struct
    type t =
      {
      property_path: String.t
        [@ocaml.doc
          "<p>The fully-qualified path to the resource property.</p>"];
      expected_value: String.t
        [@ocaml.doc
          "<p>The expected property value of the resource property, as defined in the stack template and any values specified as template parameters.</p>"];
      actual_value: String.t
        [@ocaml.doc
          "<p>The actual property value of the resource property.</p>"];
      difference_type: DifferenceType.t
        [@ocaml.doc
          "<p>The type of property difference.</p> <ul> <li> <p> <code>ADD</code>: A value has been added to a resource property that is an array or list data type.</p> </li> <li> <p> <code>REMOVE</code>: The property has been removed from the current resource configuration.</p> </li> <li> <p> <code>NOT_EQUAL</code>: The current property value differs from its expected value (as defined in the stack template and any values specified as template parameters).</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Information about a resource property whose actual value differs from its expected value, as defined in the stack template and any values specified as template parameters. These will be present only for resources whose <code>StackResourceDriftStatus</code> is <code>MODIFIED</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]
    let make ~property_path  ~expected_value  ~actual_value  ~difference_type
       () = { property_path; expected_value; actual_value; difference_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("difference_type", (DifferenceType.to_json v.difference_type));
           Some ("actual_value", (String.to_json v.actual_value));
           Some ("expected_value", (String.to_json v.expected_value));
           Some ("property_path", (String.to_json v.property_path))])
    let parse xml =
      Some
        {
          property_path =
            (Xml.required "PropertyPath"
               (Util.option_bind (Xml.member "PropertyPath" xml) String.parse));
          expected_value =
            (Xml.required "ExpectedValue"
               (Util.option_bind (Xml.member "ExpectedValue" xml)
                  String.parse));
          actual_value =
            (Xml.required "ActualValue"
               (Util.option_bind (Xml.member "ActualValue" xml) String.parse));
          difference_type =
            (Xml.required "DifferenceType"
               (Util.option_bind (Xml.member "DifferenceType" xml)
                  DifferenceType.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "PropertyPath"
                    ([], (String.to_xml v.property_path)))])
             @
             [Some
                (Ezxmlm.make_tag "ExpectedValue"
                   ([], (String.to_xml v.expected_value)))])
            @
            [Some
               (Ezxmlm.make_tag "ActualValue"
                  ([], (String.to_xml v.actual_value)))])
           @
           [Some
              (Ezxmlm.make_tag "DifferenceType"
                 ([], (DifferenceType.to_xml v.difference_type)))])
  end[@@ocaml.doc
       "<p>Information about a resource property whose actual value differs from its expected value, as defined in the stack template and any values specified as template parameters. These will be present only for resources whose <code>StackResourceDriftStatus</code> is <code>MODIFIED</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]
module ChangeAction =
  struct
    type t =
      | Add 
      | Modify 
      | Remove 
      | Import 
    let str_to_t =
      [("Import", Import);
      ("Remove", Remove);
      ("Modify", Modify);
      ("Add", Add)]
    let t_to_str =
      [(Import, "Import");
      (Remove, "Remove");
      (Modify, "Modify");
      (Add, "Add")]
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
module Replacement =
  struct
    type t =
      | True 
      | False 
      | Conditional 
    let str_to_t =
      [("Conditional", Conditional); ("False", False); ("True", True)]
    let t_to_str =
      [(Conditional, "Conditional"); (False, "False"); (True, "True")]
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
module ResourceChangeDetails =
  struct
    type t = ResourceChangeDetail.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceChangeDetail.to_query v
    let to_headers v =
      Headers.to_headers_list ResourceChangeDetail.to_headers v
    let to_json v = `List (List.map ResourceChangeDetail.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceChangeDetail.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ResourceChangeDetail.to_xml x))) v
  end
module Scope =
  struct
    type t = ResourceAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceAttribute.to_query v
    let to_headers v = Headers.to_headers_list ResourceAttribute.to_headers v
    let to_json v = `List (List.map ResourceAttribute.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceAttribute.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ResourceAttribute.to_xml x)))
        v
  end
module AllowedValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Capability =
  struct
    type t =
      | CAPABILITY_IAM 
      | CAPABILITY_NAMED_IAM 
      | CAPABILITY_AUTO_EXPAND 
    let str_to_t =
      [("CAPABILITY_AUTO_EXPAND", CAPABILITY_AUTO_EXPAND);
      ("CAPABILITY_NAMED_IAM", CAPABILITY_NAMED_IAM);
      ("CAPABILITY_IAM", CAPABILITY_IAM)]
    let t_to_str =
      [(CAPABILITY_AUTO_EXPAND, "CAPABILITY_AUTO_EXPAND");
      (CAPABILITY_NAMED_IAM, "CAPABILITY_NAMED_IAM");
      (CAPABILITY_IAM, "CAPABILITY_IAM")]
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
module Output =
  struct
    type t =
      {
      output_key: String.t option
        [@ocaml.doc "<p>The key associated with the output.</p>"];
      output_value: String.t option
        [@ocaml.doc "<p>The value associated with the output.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>User defined description associated with the output.</p>"];
      export_name: String.t option
        [@ocaml.doc
          "<p>The name of the export associated with the output.</p>"]}
    [@@ocaml.doc "<p>The Output data type.</p>"]
    let make ?output_key  ?output_value  ?description  ?export_name  () =
      { output_key; output_value; description; export_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.export_name
              (fun f -> ("export_name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.output_value
             (fun f -> ("output_value", (String.to_json f)));
           Util.option_map v.output_key
             (fun f -> ("output_key", (String.to_json f)))])
    let parse xml =
      Some
        {
          output_key =
            (Util.option_bind (Xml.member "OutputKey" xml) String.parse);
          output_value =
            (Util.option_bind (Xml.member "OutputValue" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          export_name =
            (Util.option_bind (Xml.member "ExportName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.output_key
                 (fun f ->
                    Ezxmlm.make_tag "OutputKey" ([], (String.to_xml f)))])
             @
             [Util.option_map v.output_value
                (fun f ->
                   Ezxmlm.make_tag "OutputValue" ([], (String.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           [Util.option_map v.export_name
              (fun f -> Ezxmlm.make_tag "ExportName" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The Output data type.</p>"]
module Parameter =
  struct
    type t =
      {
      parameter_key: String.t option
        [@ocaml.doc
          "<p>The key associated with the parameter. If you don't specify a key and value for a particular parameter, AWS CloudFormation uses the default value that is specified in your template.</p>"];
      parameter_value: String.t option
        [@ocaml.doc "<p>The input value associated with the parameter.</p>"];
      use_previous_value: Boolean.t option
        [@ocaml.doc
          "<p>During a stack update, use the existing parameter value that the stack is using for a given parameter key. If you specify <code>true</code>, do not specify a parameter value.</p>"];
      resolved_value: String.t option
        [@ocaml.doc
          "<p>Read-only. The value that corresponds to a Systems Manager parameter key. This field is returned only for <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/parameters-section-structure.html#aws-ssm-parameter-types\"> <code>SSM</code> parameter types</a> in the template.</p>"]}
    [@@ocaml.doc "<p>The Parameter data type.</p>"]
    let make ?parameter_key  ?parameter_value  ?use_previous_value 
      ?resolved_value  () =
      { parameter_key; parameter_value; use_previous_value; resolved_value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resolved_value
              (fun f -> ("resolved_value", (String.to_json f)));
           Util.option_map v.use_previous_value
             (fun f -> ("use_previous_value", (Boolean.to_json f)));
           Util.option_map v.parameter_value
             (fun f -> ("parameter_value", (String.to_json f)));
           Util.option_map v.parameter_key
             (fun f -> ("parameter_key", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_key =
            (Util.option_bind (Xml.member "ParameterKey" xml) String.parse);
          parameter_value =
            (Util.option_bind (Xml.member "ParameterValue" xml) String.parse);
          use_previous_value =
            (Util.option_bind (Xml.member "UsePreviousValue" xml)
               Boolean.parse);
          resolved_value =
            (Util.option_bind (Xml.member "ResolvedValue" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.parameter_key
                 (fun f ->
                    Ezxmlm.make_tag "ParameterKey" ([], (String.to_xml f)))])
             @
             [Util.option_map v.parameter_value
                (fun f ->
                   Ezxmlm.make_tag "ParameterValue" ([], (String.to_xml f)))])
            @
            [Util.option_map v.use_previous_value
               (fun f ->
                  Ezxmlm.make_tag "UsePreviousValue" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.resolved_value
              (fun f ->
                 Ezxmlm.make_tag "ResolvedValue" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The Parameter data type.</p>"]
module RollbackTriggers =
  struct
    type t = RollbackTrigger.t list
    let make elems () = elems
    let to_query v = Query.to_query_list RollbackTrigger.to_query v
    let to_headers v = Headers.to_headers_list RollbackTrigger.to_headers v
    let to_json v = `List (List.map RollbackTrigger.to_json v)
    let parse xml =
      Util.option_all
        (List.map RollbackTrigger.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (RollbackTrigger.to_xml x)))
        v
  end
module Tag =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p> <i>Required</i>. A string used to identify this tag. You can specify a maximum of 128 characters for a tag key. Tags owned by Amazon Web Services (AWS) have the reserved prefix: <code>aws:</code>.</p>"];
      value: String.t
        [@ocaml.doc
          "<p> <i>Required</i>. A string containing the value for this tag. You can specify a maximum of 256 characters for a tag value.</p>"]}
    [@@ocaml.doc
      "<p>The Tag type enables you to specify a key-value pair that can be used to store information about an AWS CloudFormation stack.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key))])
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
  end[@@ocaml.doc
       "<p>The Tag type enables you to specify a key-value pair that can be used to store information about an AWS CloudFormation stack.</p>"]
module ResourceStatus =
  struct
    type t =
      | CREATE_IN_PROGRESS 
      | CREATE_FAILED 
      | CREATE_COMPLETE 
      | DELETE_IN_PROGRESS 
      | DELETE_FAILED 
      | DELETE_COMPLETE 
      | DELETE_SKIPPED 
      | UPDATE_IN_PROGRESS 
      | UPDATE_FAILED 
      | UPDATE_COMPLETE 
      | IMPORT_FAILED 
      | IMPORT_COMPLETE 
      | IMPORT_IN_PROGRESS 
      | IMPORT_ROLLBACK_IN_PROGRESS 
      | IMPORT_ROLLBACK_FAILED 
      | IMPORT_ROLLBACK_COMPLETE 
    let str_to_t =
      [("IMPORT_ROLLBACK_COMPLETE", IMPORT_ROLLBACK_COMPLETE);
      ("IMPORT_ROLLBACK_FAILED", IMPORT_ROLLBACK_FAILED);
      ("IMPORT_ROLLBACK_IN_PROGRESS", IMPORT_ROLLBACK_IN_PROGRESS);
      ("IMPORT_IN_PROGRESS", IMPORT_IN_PROGRESS);
      ("IMPORT_COMPLETE", IMPORT_COMPLETE);
      ("IMPORT_FAILED", IMPORT_FAILED);
      ("UPDATE_COMPLETE", UPDATE_COMPLETE);
      ("UPDATE_FAILED", UPDATE_FAILED);
      ("UPDATE_IN_PROGRESS", UPDATE_IN_PROGRESS);
      ("DELETE_SKIPPED", DELETE_SKIPPED);
      ("DELETE_COMPLETE", DELETE_COMPLETE);
      ("DELETE_FAILED", DELETE_FAILED);
      ("DELETE_IN_PROGRESS", DELETE_IN_PROGRESS);
      ("CREATE_COMPLETE", CREATE_COMPLETE);
      ("CREATE_FAILED", CREATE_FAILED);
      ("CREATE_IN_PROGRESS", CREATE_IN_PROGRESS)]
    let t_to_str =
      [(IMPORT_ROLLBACK_COMPLETE, "IMPORT_ROLLBACK_COMPLETE");
      (IMPORT_ROLLBACK_FAILED, "IMPORT_ROLLBACK_FAILED");
      (IMPORT_ROLLBACK_IN_PROGRESS, "IMPORT_ROLLBACK_IN_PROGRESS");
      (IMPORT_IN_PROGRESS, "IMPORT_IN_PROGRESS");
      (IMPORT_COMPLETE, "IMPORT_COMPLETE");
      (IMPORT_FAILED, "IMPORT_FAILED");
      (UPDATE_COMPLETE, "UPDATE_COMPLETE");
      (UPDATE_FAILED, "UPDATE_FAILED");
      (UPDATE_IN_PROGRESS, "UPDATE_IN_PROGRESS");
      (DELETE_SKIPPED, "DELETE_SKIPPED");
      (DELETE_COMPLETE, "DELETE_COMPLETE");
      (DELETE_FAILED, "DELETE_FAILED");
      (DELETE_IN_PROGRESS, "DELETE_IN_PROGRESS");
      (CREATE_COMPLETE, "CREATE_COMPLETE");
      (CREATE_FAILED, "CREATE_FAILED");
      (CREATE_IN_PROGRESS, "CREATE_IN_PROGRESS")]
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
module StackResourceDriftInformationSummary =
  struct
    type t =
      {
      stack_resource_drift_status: StackResourceDriftStatus.t
        [@ocaml.doc
          "<p>Status of the resource's actual configuration compared to its expected configuration</p> <ul> <li> <p> <code>DELETED</code>: The resource differs from its expected configuration in that it has been deleted.</p> </li> <li> <p> <code>MODIFIED</code>: The resource differs from its expected configuration.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the resource differs from its expected configuration.</p> <p>Any resources that do not currently support drift detection have a status of <code>NOT_CHECKED</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html\">Resources that Support Drift Detection</a>. If you performed an <a>ContinueUpdateRollback</a> operation on a stack, any resources included in <code>ResourcesToSkip</code> will also have a status of <code>NOT_CHECKED</code>. For more information on skipping resources during rollback operations, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-updating-stacks-continueupdaterollback.html\">Continue Rolling Back an Update</a> in the AWS CloudFormation User Guide.</p> </li> <li> <p> <code>IN_SYNC</code>: The resources's actual configuration matches its expected configuration.</p> </li> </ul>"];
      last_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>When AWS CloudFormation last checked if the resource had drifted from its expected configuration.</p>"]}
    [@@ocaml.doc
      "<p>Summarizes information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration.</p>"]
    let make ~stack_resource_drift_status  ?last_check_timestamp  () =
      { stack_resource_drift_status; last_check_timestamp }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_check_timestamp
              (fun f -> ("last_check_timestamp", (DateTime.to_json f)));
           Some
             ("stack_resource_drift_status",
               (StackResourceDriftStatus.to_json
                  v.stack_resource_drift_status))])
    let parse xml =
      Some
        {
          stack_resource_drift_status =
            (Xml.required "StackResourceDriftStatus"
               (Util.option_bind (Xml.member "StackResourceDriftStatus" xml)
                  StackResourceDriftStatus.parse));
          last_check_timestamp =
            (Util.option_bind (Xml.member "LastCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackResourceDriftStatus"
                  ([],
                    (StackResourceDriftStatus.to_xml
                       v.stack_resource_drift_status)))])
           @
           [Util.option_map v.last_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Summarizes information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration.</p>"]
module AccountGateResult =
  struct
    type t =
      {
      status: AccountGateStatus.t option
        [@ocaml.doc
          "<p>The status of the account gate function.</p> <ul> <li> <p> <code>SUCCEEDED</code>: The account gate function has determined that the account and region passes any requirements for a stack set operation to occur. AWS CloudFormation proceeds with the stack operation in that account and region. </p> </li> <li> <p> <code>FAILED</code>: The account gate function has determined that the account and region does not meet the requirements for a stack set operation to occur. AWS CloudFormation cancels the stack set operation in that account and region, and sets the stack set operation result status for that account and region to <code>FAILED</code>. </p> </li> <li> <p> <code>SKIPPED</code>: AWS CloudFormation has skipped calling the account gate function for this account and region, for one of the following reasons:</p> <ul> <li> <p>An account gate function has not been specified for the account and region. AWS CloudFormation proceeds with the stack set operation in this account and region.</p> </li> <li> <p>The <code>AWSCloudFormationStackSetExecutionRole</code> of the stack set adminstration account lacks permissions to invoke the function. AWS CloudFormation proceeds with the stack set operation in this account and region.</p> </li> <li> <p>Either no action is necessary, or no action is possible, on the stack. AWS CloudFormation skips the stack set operation in this account and region.</p> </li> </ul> </li> </ul>"];
      status_reason: String.t option
        [@ocaml.doc
          "<p>The reason for the account gate status assigned to this account and region for the stack set operation.</p>"]}
    [@@ocaml.doc
      "<p>Structure that contains the results of the account gate function which AWS CloudFormation invokes, if present, before proceeding with a stack set operation in an account and region.</p> <p>For each account and region, AWS CloudFormation lets you specify a Lamdba function that encapsulates any requirements that must be met before CloudFormation can proceed with a stack set operation in that account and region. CloudFormation invokes the function each time a stack set operation is requested for that account and region; if the function returns <code>FAILED</code>, CloudFormation cancels the operation in that account and region, and sets the stack set operation result status for that account and region to <code>FAILED</code>. </p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-account-gating.html\">Configuring a target account gate</a>.</p>"]
    let make ?status  ?status_reason  () = { status; status_reason }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status_reason
              (fun f -> ("status_reason", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (AccountGateStatus.to_json f)))])
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               AccountGateStatus.parse);
          status_reason =
            (Util.option_bind (Xml.member "StatusReason" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.status
               (fun f ->
                  Ezxmlm.make_tag "Status" ([], (AccountGateStatus.to_xml f)))])
           @
           [Util.option_map v.status_reason
              (fun f ->
                 Ezxmlm.make_tag "StatusReason" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Structure that contains the results of the account gate function which AWS CloudFormation invokes, if present, before proceeding with a stack set operation in an account and region.</p> <p>For each account and region, AWS CloudFormation lets you specify a Lamdba function that encapsulates any requirements that must be met before CloudFormation can proceed with a stack set operation in that account and region. CloudFormation invokes the function each time a stack set operation is requested for that account and region; if the function returns <code>FAILED</code>, CloudFormation cancels the operation in that account and region, and sets the stack set operation result status for that account and region to <code>FAILED</code>. </p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-account-gating.html\">Configuring a target account gate</a>.</p>"]
module StackSetOperationResultStatus =
  struct
    type t =
      | PENDING 
      | RUNNING 
      | SUCCEEDED 
      | FAILED 
      | CANCELLED 
    let str_to_t =
      [("CANCELLED", CANCELLED);
      ("FAILED", FAILED);
      ("SUCCEEDED", SUCCEEDED);
      ("RUNNING", RUNNING);
      ("PENDING", PENDING)]
    let t_to_str =
      [(CANCELLED, "CANCELLED");
      (FAILED, "FAILED");
      (SUCCEEDED, "SUCCEEDED");
      (RUNNING, "RUNNING");
      (PENDING, "PENDING")]
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
module StackDriftInformationSummary =
  struct
    type t =
      {
      stack_drift_status: StackDriftStatus.t
        [@ocaml.doc
          "<p>Status of the stack's actual configuration compared to its expected template configuration. </p> <ul> <li> <p> <code>DRIFTED</code>: The stack differs from its expected template configuration. A stack is considered to have drifted if one or more of its resources have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the stack differs from its expected template configuration.</p> </li> <li> <p> <code>IN_SYNC</code>: The stack's actual configuration matches its expected template configuration.</p> </li> <li> <p> <code>UNKNOWN</code>: This value is reserved for future use.</p> </li> </ul>"];
      last_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>Most recent time when a drift detection operation was initiated on the stack, or any of its individual resources that support drift detection.</p>"]}
    [@@ocaml.doc
      "<p>Contains information about whether the stack's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. A stack is considered to have drifted if one or more of its resources have drifted.</p>"]
    let make ~stack_drift_status  ?last_check_timestamp  () =
      { stack_drift_status; last_check_timestamp }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_check_timestamp
              (fun f -> ("last_check_timestamp", (DateTime.to_json f)));
           Some
             ("stack_drift_status",
               (StackDriftStatus.to_json v.stack_drift_status))])
    let parse xml =
      Some
        {
          stack_drift_status =
            (Xml.required "StackDriftStatus"
               (Util.option_bind (Xml.member "StackDriftStatus" xml)
                  StackDriftStatus.parse));
          last_check_timestamp =
            (Util.option_bind (Xml.member "LastCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackDriftStatus"
                  ([], (StackDriftStatus.to_xml v.stack_drift_status)))])
           @
           [Util.option_map v.last_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains information about whether the stack's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. A stack is considered to have drifted if one or more of its resources have drifted.</p>"]
module StackStatus =
  struct
    type t =
      | CREATE_IN_PROGRESS 
      | CREATE_FAILED 
      | CREATE_COMPLETE 
      | ROLLBACK_IN_PROGRESS 
      | ROLLBACK_FAILED 
      | ROLLBACK_COMPLETE 
      | DELETE_IN_PROGRESS 
      | DELETE_FAILED 
      | DELETE_COMPLETE 
      | UPDATE_IN_PROGRESS 
      | UPDATE_COMPLETE_CLEANUP_IN_PROGRESS 
      | UPDATE_COMPLETE 
      | UPDATE_ROLLBACK_IN_PROGRESS 
      | UPDATE_ROLLBACK_FAILED 
      | UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS 
      | UPDATE_ROLLBACK_COMPLETE 
      | REVIEW_IN_PROGRESS 
      | IMPORT_IN_PROGRESS 
      | IMPORT_COMPLETE 
      | IMPORT_ROLLBACK_IN_PROGRESS 
      | IMPORT_ROLLBACK_FAILED 
      | IMPORT_ROLLBACK_COMPLETE 
    let str_to_t =
      [("IMPORT_ROLLBACK_COMPLETE", IMPORT_ROLLBACK_COMPLETE);
      ("IMPORT_ROLLBACK_FAILED", IMPORT_ROLLBACK_FAILED);
      ("IMPORT_ROLLBACK_IN_PROGRESS", IMPORT_ROLLBACK_IN_PROGRESS);
      ("IMPORT_COMPLETE", IMPORT_COMPLETE);
      ("IMPORT_IN_PROGRESS", IMPORT_IN_PROGRESS);
      ("REVIEW_IN_PROGRESS", REVIEW_IN_PROGRESS);
      ("UPDATE_ROLLBACK_COMPLETE", UPDATE_ROLLBACK_COMPLETE);
      ("UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS",
        UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS);
      ("UPDATE_ROLLBACK_FAILED", UPDATE_ROLLBACK_FAILED);
      ("UPDATE_ROLLBACK_IN_PROGRESS", UPDATE_ROLLBACK_IN_PROGRESS);
      ("UPDATE_COMPLETE", UPDATE_COMPLETE);
      ("UPDATE_COMPLETE_CLEANUP_IN_PROGRESS",
        UPDATE_COMPLETE_CLEANUP_IN_PROGRESS);
      ("UPDATE_IN_PROGRESS", UPDATE_IN_PROGRESS);
      ("DELETE_COMPLETE", DELETE_COMPLETE);
      ("DELETE_FAILED", DELETE_FAILED);
      ("DELETE_IN_PROGRESS", DELETE_IN_PROGRESS);
      ("ROLLBACK_COMPLETE", ROLLBACK_COMPLETE);
      ("ROLLBACK_FAILED", ROLLBACK_FAILED);
      ("ROLLBACK_IN_PROGRESS", ROLLBACK_IN_PROGRESS);
      ("CREATE_COMPLETE", CREATE_COMPLETE);
      ("CREATE_FAILED", CREATE_FAILED);
      ("CREATE_IN_PROGRESS", CREATE_IN_PROGRESS)]
    let t_to_str =
      [(IMPORT_ROLLBACK_COMPLETE, "IMPORT_ROLLBACK_COMPLETE");
      (IMPORT_ROLLBACK_FAILED, "IMPORT_ROLLBACK_FAILED");
      (IMPORT_ROLLBACK_IN_PROGRESS, "IMPORT_ROLLBACK_IN_PROGRESS");
      (IMPORT_COMPLETE, "IMPORT_COMPLETE");
      (IMPORT_IN_PROGRESS, "IMPORT_IN_PROGRESS");
      (REVIEW_IN_PROGRESS, "REVIEW_IN_PROGRESS");
      (UPDATE_ROLLBACK_COMPLETE, "UPDATE_ROLLBACK_COMPLETE");
      (UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS,
        "UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS");
      (UPDATE_ROLLBACK_FAILED, "UPDATE_ROLLBACK_FAILED");
      (UPDATE_ROLLBACK_IN_PROGRESS, "UPDATE_ROLLBACK_IN_PROGRESS");
      (UPDATE_COMPLETE, "UPDATE_COMPLETE");
      (UPDATE_COMPLETE_CLEANUP_IN_PROGRESS,
        "UPDATE_COMPLETE_CLEANUP_IN_PROGRESS");
      (UPDATE_IN_PROGRESS, "UPDATE_IN_PROGRESS");
      (DELETE_COMPLETE, "DELETE_COMPLETE");
      (DELETE_FAILED, "DELETE_FAILED");
      (DELETE_IN_PROGRESS, "DELETE_IN_PROGRESS");
      (ROLLBACK_COMPLETE, "ROLLBACK_COMPLETE");
      (ROLLBACK_FAILED, "ROLLBACK_FAILED");
      (ROLLBACK_IN_PROGRESS, "ROLLBACK_IN_PROGRESS");
      (CREATE_COMPLETE, "CREATE_COMPLETE");
      (CREATE_FAILED, "CREATE_FAILED");
      (CREATE_IN_PROGRESS, "CREATE_IN_PROGRESS")]
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
module PhysicalResourceIdContext =
  struct
    type t = PhysicalResourceIdContextKeyValuePair.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list PhysicalResourceIdContextKeyValuePair.to_query v
    let to_headers v =
      Headers.to_headers_list
        PhysicalResourceIdContextKeyValuePair.to_headers v
    let to_json v =
      `List (List.map PhysicalResourceIdContextKeyValuePair.to_json v)
    let parse xml =
      Util.option_all
        (List.map PhysicalResourceIdContextKeyValuePair.parse
           (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (PhysicalResourceIdContextKeyValuePair.to_xml x))) v
  end
module PropertyDifferences =
  struct
    type t = PropertyDifference.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PropertyDifference.to_query v
    let to_headers v =
      Headers.to_headers_list PropertyDifference.to_headers v
    let to_json v = `List (List.map PropertyDifference.to_json v)
    let parse xml =
      Util.option_all
        (List.map PropertyDifference.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (PropertyDifference.to_xml x))) v
  end
module ChangeType =
  struct
    type t =
      | Resource 
    let str_to_t = [("Resource", Resource)]
    let t_to_str = [(Resource, "Resource")]
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
module ResourceChange =
  struct
    type t =
      {
      action: ChangeAction.t option
        [@ocaml.doc
          "<p>The action that AWS CloudFormation takes on the resource, such as <code>Add</code> (adds a new resource), <code>Modify</code> (changes a resource), or <code>Remove</code> (deletes a resource).</p>"];
      logical_resource_id: String.t option
        [@ocaml.doc
          "<p>The resource's logical ID, which is defined in the stack's template.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The resource's physical ID (resource name). Resources that you are adding don't have physical IDs because they haven't been created.</p>"];
      resource_type: String.t option
        [@ocaml.doc
          "<p>The type of AWS CloudFormation resource, such as <code>AWS::S3::Bucket</code>.</p>"];
      replacement: Replacement.t option
        [@ocaml.doc
          "<p>For the <code>Modify</code> action, indicates whether AWS CloudFormation will replace the resource by creating a new one and deleting the old one. This value depends on the value of the <code>RequiresRecreation</code> property in the <code>ResourceTargetDefinition</code> structure. For example, if the <code>RequiresRecreation</code> field is <code>Always</code> and the <code>Evaluation</code> field is <code>Static</code>, <code>Replacement</code> is <code>True</code>. If the <code>RequiresRecreation</code> field is <code>Always</code> and the <code>Evaluation</code> field is <code>Dynamic</code>, <code>Replacement</code> is <code>Conditionally</code>.</p> <p>If you have multiple changes with different <code>RequiresRecreation</code> values, the <code>Replacement</code> value depends on the change with the most impact. A <code>RequiresRecreation</code> value of <code>Always</code> has the most impact, followed by <code>Conditionally</code>, and then <code>Never</code>.</p>"];
      scope: Scope.t
        [@ocaml.doc
          "<p>For the <code>Modify</code> action, indicates which resource attribute is triggering this update, such as a change in the resource attribute's <code>Metadata</code>, <code>Properties</code>, or <code>Tags</code>.</p>"];
      details: ResourceChangeDetails.t
        [@ocaml.doc
          "<p>For the <code>Modify</code> action, a list of <code>ResourceChangeDetail</code> structures that describes the changes that AWS CloudFormation will make to the resource. </p>"]}
    [@@ocaml.doc
      "<p>The <code>ResourceChange</code> structure describes the resource and the action that AWS CloudFormation will perform on it if you execute this change set.</p>"]
    let make ?action  ?logical_resource_id  ?physical_resource_id 
      ?resource_type  ?replacement  ?(scope= [])  ?(details= [])  () =
      {
        action;
        logical_resource_id;
        physical_resource_id;
        resource_type;
        replacement;
        scope;
        details
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("details", (ResourceChangeDetails.to_json v.details));
           Some ("scope", (Scope.to_json v.scope));
           Util.option_map v.replacement
             (fun f -> ("replacement", (Replacement.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)));
           Util.option_map v.physical_resource_id
             (fun f -> ("physical_resource_id", (String.to_json f)));
           Util.option_map v.logical_resource_id
             (fun f -> ("logical_resource_id", (String.to_json f)));
           Util.option_map v.action
             (fun f -> ("action", (ChangeAction.to_json f)))])
    let parse xml =
      Some
        {
          action =
            (Util.option_bind (Xml.member "Action" xml) ChangeAction.parse);
          logical_resource_id =
            (Util.option_bind (Xml.member "LogicalResourceId" xml)
               String.parse);
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse);
          resource_type =
            (Util.option_bind (Xml.member "ResourceType" xml) String.parse);
          replacement =
            (Util.option_bind (Xml.member "Replacement" xml)
               Replacement.parse);
          scope =
            (Util.of_option []
               (Util.option_bind (Xml.member "Scope" xml) Scope.parse));
          details =
            (Util.of_option []
               (Util.option_bind (Xml.member "Details" xml)
                  ResourceChangeDetails.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.action
                    (fun f ->
                       Ezxmlm.make_tag "Action" ([], (ChangeAction.to_xml f)))])
                @
                [Util.option_map v.logical_resource_id
                   (fun f ->
                      Ezxmlm.make_tag "LogicalResourceId"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.physical_resource_id
                  (fun f ->
                     Ezxmlm.make_tag "PhysicalResourceId"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.resource_type
                 (fun f ->
                    Ezxmlm.make_tag "ResourceType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.replacement
                (fun f ->
                   Ezxmlm.make_tag "Replacement" ([], (Replacement.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Scope" ([], (Scope.to_xml [x]))))
               v.scope))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Details"
                      ([], (ResourceChangeDetails.to_xml [x])))) v.details))
  end[@@ocaml.doc
       "<p>The <code>ResourceChange</code> structure describes the resource and the action that AWS CloudFormation will perform on it if you execute this change set.</p>"]
module ChangeSetStatus =
  struct
    type t =
      | CREATE_PENDING 
      | CREATE_IN_PROGRESS 
      | CREATE_COMPLETE 
      | DELETE_COMPLETE 
      | FAILED 
    let str_to_t =
      [("FAILED", FAILED);
      ("DELETE_COMPLETE", DELETE_COMPLETE);
      ("CREATE_COMPLETE", CREATE_COMPLETE);
      ("CREATE_IN_PROGRESS", CREATE_IN_PROGRESS);
      ("CREATE_PENDING", CREATE_PENDING)]
    let t_to_str =
      [(FAILED, "FAILED");
      (DELETE_COMPLETE, "DELETE_COMPLETE");
      (CREATE_COMPLETE, "CREATE_COMPLETE");
      (CREATE_IN_PROGRESS, "CREATE_IN_PROGRESS");
      (CREATE_PENDING, "CREATE_PENDING")]
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
module ExecutionStatus =
  struct
    type t =
      | UNAVAILABLE 
      | AVAILABLE 
      | EXECUTE_IN_PROGRESS 
      | EXECUTE_COMPLETE 
      | EXECUTE_FAILED 
      | OBSOLETE 
    let str_to_t =
      [("OBSOLETE", OBSOLETE);
      ("EXECUTE_FAILED", EXECUTE_FAILED);
      ("EXECUTE_COMPLETE", EXECUTE_COMPLETE);
      ("EXECUTE_IN_PROGRESS", EXECUTE_IN_PROGRESS);
      ("AVAILABLE", AVAILABLE);
      ("UNAVAILABLE", UNAVAILABLE)]
    let t_to_str =
      [(OBSOLETE, "OBSOLETE");
      (EXECUTE_FAILED, "EXECUTE_FAILED");
      (EXECUTE_COMPLETE, "EXECUTE_COMPLETE");
      (EXECUTE_IN_PROGRESS, "EXECUTE_IN_PROGRESS");
      (AVAILABLE, "AVAILABLE");
      (UNAVAILABLE, "UNAVAILABLE")]
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
module ParameterConstraints =
  struct
    type t =
      {
      allowed_values: AllowedValues.t
        [@ocaml.doc
          "<p>A list of values that are permitted for a parameter.</p>"]}
    [@@ocaml.doc
      "<p>A set of criteria that AWS CloudFormation uses to validate parameter values. Although other constraints might be defined in the stack template, AWS CloudFormation returns only the <code>AllowedValues</code> property.</p>"]
    let make ?(allowed_values= [])  () = { allowed_values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("allowed_values", (AllowedValues.to_json v.allowed_values))])
    let parse xml =
      Some
        {
          allowed_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "AllowedValues" xml)
                  AllowedValues.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AllowedValues"
                      ([], (AllowedValues.to_xml [x])))) v.allowed_values))
  end[@@ocaml.doc
       "<p>A set of criteria that AWS CloudFormation uses to validate parameter values. Although other constraints might be defined in the stack template, AWS CloudFormation returns only the <code>AllowedValues</code> property.</p>"]
module LogicalResourceIds =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ResourceIdentifiers =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ResourceIdentifierProperties =
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
module StackSetStatus =
  struct
    type t =
      | ACTIVE 
      | DELETED 
    let str_to_t = [("DELETED", DELETED); ("ACTIVE", ACTIVE)]
    let t_to_str = [(DELETED, "DELETED"); (ACTIVE, "ACTIVE")]
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
module StackInstanceStatus =
  struct
    type t =
      | CURRENT 
      | OUTDATED 
      | INOPERABLE 
    let str_to_t =
      [("INOPERABLE", INOPERABLE);
      ("OUTDATED", OUTDATED);
      ("CURRENT", CURRENT)]
    let t_to_str =
      [(INOPERABLE, "INOPERABLE");
      (OUTDATED, "OUTDATED");
      (CURRENT, "CURRENT")]
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
module RegistryType =
  struct
    type t =
      | RESOURCE 
    let str_to_t = [("RESOURCE", RESOURCE)]
    let t_to_str = [(RESOURCE, "RESOURCE")]
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
module Capabilities =
  struct
    type t = Capability.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Capability.to_query v
    let to_headers v = Headers.to_headers_list Capability.to_headers v
    let to_json v = `List (List.map Capability.to_json v)
    let parse xml =
      Util.option_all (List.map Capability.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (Capability.to_xml x))) v
  end
module NotificationARNs =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module Outputs =
  struct
    type t = Output.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Output.to_query v
    let to_headers v = Headers.to_headers_list Output.to_headers v
    let to_json v = `List (List.map Output.to_json v)
    let parse xml =
      Util.option_all (List.map Output.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Output.to_xml x))) v
  end
module Parameters =
  struct
    type t = Parameter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Parameter.to_query v
    let to_headers v = Headers.to_headers_list Parameter.to_headers v
    let to_json v = `List (List.map Parameter.to_json v)
    let parse xml =
      Util.option_all (List.map Parameter.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Parameter.to_xml x)))
        v
  end
module RollbackConfiguration =
  struct
    type t =
      {
      rollback_triggers: RollbackTriggers.t
        [@ocaml.doc
          "<p>The triggers to monitor during stack creation or update actions. </p> <p>By default, AWS CloudFormation saves the rollback triggers specified for a stack and applies them to any subsequent update operations for the stack, unless you specify otherwise. If you do specify rollback triggers for this parameter, those triggers replace any list of triggers previously specified for the stack. This means:</p> <ul> <li> <p>To use the rollback triggers previously specified for this stack, if any, don't specify this parameter.</p> </li> <li> <p>To specify new or updated rollback triggers, you must specify <i>all</i> the triggers that you want used for this stack, even triggers you've specifed before (for example, when creating the stack or during a previous stack update). Any triggers that you don't include in the updated list of triggers are no longer applied to the stack.</p> </li> <li> <p>To remove all currently specified triggers, specify an empty list for this parameter.</p> </li> </ul> <p>If a specified trigger is missing, the entire stack operation fails and is rolled back. </p>"];
      monitoring_time_in_minutes: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in minutes, during which CloudFormation should monitor all the rollback triggers after the stack creation or update operation deploys all necessary resources.</p> <p>The default is 0 minutes.</p> <p>If you specify a monitoring period but do not specify any rollback triggers, CloudFormation still waits the specified period of time before cleaning up old resources after update operations. You can use this monitoring period to perform any manual stack validation desired, and manually cancel the stack creation or update (using <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_CancelUpdateStack.html\">CancelUpdateStack</a>, for example) as necessary.</p> <p>If you specify 0 for this parameter, CloudFormation still monitors the specified rollback triggers during stack creation and update operations. Then, for update operations, it begins disposing of old resources immediately once the operation completes.</p>"]}
    [@@ocaml.doc
      "<p>Structure containing the rollback triggers for AWS CloudFormation to monitor during stack creation and updating operations, and for the specified monitoring period afterwards.</p> <p>Rollback triggers enable you to have AWS CloudFormation monitor the state of your application during stack creation and updating, and to roll back that operation if the application breaches the threshold of any of the alarms you've specified. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-rollback-triggers.html\">Monitor and Roll Back Stack Operations</a>.</p>"]
    let make ?(rollback_triggers= [])  ?monitoring_time_in_minutes  () =
      { rollback_triggers; monitoring_time_in_minutes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.monitoring_time_in_minutes
              (fun f -> ("monitoring_time_in_minutes", (Integer.to_json f)));
           Some
             ("rollback_triggers",
               (RollbackTriggers.to_json v.rollback_triggers))])
    let parse xml =
      Some
        {
          rollback_triggers =
            (Util.of_option []
               (Util.option_bind (Xml.member "RollbackTriggers" xml)
                  RollbackTriggers.parse));
          monitoring_time_in_minutes =
            (Util.option_bind (Xml.member "MonitoringTimeInMinutes" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RollbackTriggers"
                       ([], (RollbackTriggers.to_xml [x]))))
               v.rollback_triggers))
           @
           [Util.option_map v.monitoring_time_in_minutes
              (fun f ->
                 Ezxmlm.make_tag "MonitoringTimeInMinutes"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Structure containing the rollback triggers for AWS CloudFormation to monitor during stack creation and updating operations, and for the specified monitoring period afterwards.</p> <p>Rollback triggers enable you to have AWS CloudFormation monitor the state of your application during stack creation and updating, and to roll back that operation if the application breaches the threshold of any of the alarms you've specified. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-rollback-triggers.html\">Monitor and Roll Back Stack Operations</a>.</p>"]
module StackDriftInformation =
  struct
    type t =
      {
      stack_drift_status: StackDriftStatus.t
        [@ocaml.doc
          "<p>Status of the stack's actual configuration compared to its expected template configuration. </p> <ul> <li> <p> <code>DRIFTED</code>: The stack differs from its expected template configuration. A stack is considered to have drifted if one or more of its resources have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the stack differs from its expected template configuration.</p> </li> <li> <p> <code>IN_SYNC</code>: The stack's actual configuration matches its expected template configuration.</p> </li> <li> <p> <code>UNKNOWN</code>: This value is reserved for future use.</p> </li> </ul>"];
      last_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>Most recent time when a drift detection operation was initiated on the stack, or any of its individual resources that support drift detection.</p>"]}
    [@@ocaml.doc
      "<p>Contains information about whether the stack's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. A stack is considered to have drifted if one or more of its resources have drifted.</p>"]
    let make ~stack_drift_status  ?last_check_timestamp  () =
      { stack_drift_status; last_check_timestamp }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_check_timestamp
              (fun f -> ("last_check_timestamp", (DateTime.to_json f)));
           Some
             ("stack_drift_status",
               (StackDriftStatus.to_json v.stack_drift_status))])
    let parse xml =
      Some
        {
          stack_drift_status =
            (Xml.required "StackDriftStatus"
               (Util.option_bind (Xml.member "StackDriftStatus" xml)
                  StackDriftStatus.parse));
          last_check_timestamp =
            (Util.option_bind (Xml.member "LastCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackDriftStatus"
                  ([], (StackDriftStatus.to_xml v.stack_drift_status)))])
           @
           [Util.option_map v.last_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains information about whether the stack's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. A stack is considered to have drifted if one or more of its resources have drifted.</p>"]
module Tags =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end
module StackSetDriftDetectionStatus =
  struct
    type t =
      | COMPLETED 
      | FAILED 
      | PARTIAL_SUCCESS 
      | IN_PROGRESS 
      | STOPPED 
    let str_to_t =
      [("STOPPED", STOPPED);
      ("IN_PROGRESS", IN_PROGRESS);
      ("PARTIAL_SUCCESS", PARTIAL_SUCCESS);
      ("FAILED", FAILED);
      ("COMPLETED", COMPLETED)]
    let t_to_str =
      [(STOPPED, "STOPPED");
      (IN_PROGRESS, "IN_PROGRESS");
      (PARTIAL_SUCCESS, "PARTIAL_SUCCESS");
      (FAILED, "FAILED");
      (COMPLETED, "COMPLETED")]
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
module StackSetDriftStatus =
  struct
    type t =
      | DRIFTED 
      | IN_SYNC 
      | NOT_CHECKED 
    let str_to_t =
      [("NOT_CHECKED", NOT_CHECKED);
      ("IN_SYNC", IN_SYNC);
      ("DRIFTED", DRIFTED)]
    let t_to_str =
      [(NOT_CHECKED, "NOT_CHECKED");
      (IN_SYNC, "IN_SYNC");
      (DRIFTED, "DRIFTED")]
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
module RegionList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module StackResourceDriftInformation =
  struct
    type t =
      {
      stack_resource_drift_status: StackResourceDriftStatus.t
        [@ocaml.doc
          "<p>Status of the resource's actual configuration compared to its expected configuration</p> <ul> <li> <p> <code>DELETED</code>: The resource differs from its expected configuration in that it has been deleted.</p> </li> <li> <p> <code>MODIFIED</code>: The resource differs from its expected configuration.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the resource differs from its expected configuration.</p> <p>Any resources that do not currently support drift detection have a status of <code>NOT_CHECKED</code>. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html\">Resources that Support Drift Detection</a>. </p> </li> <li> <p> <code>IN_SYNC</code>: The resources's actual configuration matches its expected configuration.</p> </li> </ul>"];
      last_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>When AWS CloudFormation last checked if the resource had drifted from its expected configuration.</p>"]}
    [@@ocaml.doc
      "<p>Contains information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration.</p>"]
    let make ~stack_resource_drift_status  ?last_check_timestamp  () =
      { stack_resource_drift_status; last_check_timestamp }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_check_timestamp
              (fun f -> ("last_check_timestamp", (DateTime.to_json f)));
           Some
             ("stack_resource_drift_status",
               (StackResourceDriftStatus.to_json
                  v.stack_resource_drift_status))])
    let parse xml =
      Some
        {
          stack_resource_drift_status =
            (Xml.required "StackResourceDriftStatus"
               (Util.option_bind (Xml.member "StackResourceDriftStatus" xml)
                  StackResourceDriftStatus.parse));
          last_check_timestamp =
            (Util.option_bind (Xml.member "LastCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "StackResourceDriftStatus"
                  ([],
                    (StackResourceDriftStatus.to_xml
                       v.stack_resource_drift_status)))])
           @
           [Util.option_map v.last_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration.</p>"]
module StackSetOperationAction =
  struct
    type t =
      | CREATE 
      | UPDATE 
      | DELETE 
      | DETECT_DRIFT 
    let str_to_t =
      [("DETECT_DRIFT", DETECT_DRIFT);
      ("DELETE", DELETE);
      ("UPDATE", UPDATE);
      ("CREATE", CREATE)]
    let t_to_str =
      [(DETECT_DRIFT, "DETECT_DRIFT");
      (DELETE, "DELETE");
      (UPDATE, "UPDATE");
      (CREATE, "CREATE")]
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
module StackSetOperationStatus =
  struct
    type t =
      | RUNNING 
      | SUCCEEDED 
      | FAILED 
      | STOPPING 
      | STOPPED 
    let str_to_t =
      [("STOPPED", STOPPED);
      ("STOPPING", STOPPING);
      ("FAILED", FAILED);
      ("SUCCEEDED", SUCCEEDED);
      ("RUNNING", RUNNING)]
    let t_to_str =
      [(STOPPED, "STOPPED");
      (STOPPING, "STOPPING");
      (FAILED, "FAILED");
      (SUCCEEDED, "SUCCEEDED");
      (RUNNING, "RUNNING")]
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
module StackResourceSummary =
  struct
    type t =
      {
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical name of the resource specified in the template.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The name or unique identifier that corresponds to a physical instance ID of the resource.</p>"];
      resource_type: String.t
        [@ocaml.doc
          "<p>Type of resource. (For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\"> AWS Resource Types Reference</a> in the AWS CloudFormation User Guide.)</p>"];
      last_updated_timestamp: DateTime.t
        [@ocaml.doc "<p>Time the status was updated.</p>"];
      resource_status: ResourceStatus.t
        [@ocaml.doc "<p>Current status of the resource.</p>"];
      resource_status_reason: String.t option
        [@ocaml.doc
          "<p>Success/failure message associated with the resource.</p>"];
      drift_information: StackResourceDriftInformationSummary.t option
        [@ocaml.doc
          "<p>Information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]}
    [@@ocaml.doc
      "<p>Contains high-level information about the specified stack resource.</p>"]
    let make ~logical_resource_id  ?physical_resource_id  ~resource_type 
      ~last_updated_timestamp  ~resource_status  ?resource_status_reason 
      ?drift_information  () =
      {
        logical_resource_id;
        physical_resource_id;
        resource_type;
        last_updated_timestamp;
        resource_status;
        resource_status_reason;
        drift_information
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.drift_information
              (fun f ->
                 ("drift_information",
                   (StackResourceDriftInformationSummary.to_json f)));
           Util.option_map v.resource_status_reason
             (fun f -> ("resource_status_reason", (String.to_json f)));
           Some
             ("resource_status", (ResourceStatus.to_json v.resource_status));
           Some
             ("last_updated_timestamp",
               (DateTime.to_json v.last_updated_timestamp));
           Some ("resource_type", (String.to_json v.resource_type));
           Util.option_map v.physical_resource_id
             (fun f -> ("physical_resource_id", (String.to_json f)));
           Some
             ("logical_resource_id", (String.to_json v.logical_resource_id))])
    let parse xml =
      Some
        {
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse));
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse);
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          last_updated_timestamp =
            (Xml.required "LastUpdatedTimestamp"
               (Util.option_bind (Xml.member "LastUpdatedTimestamp" xml)
                  DateTime.parse));
          resource_status =
            (Xml.required "ResourceStatus"
               (Util.option_bind (Xml.member "ResourceStatus" xml)
                  ResourceStatus.parse));
          resource_status_reason =
            (Util.option_bind (Xml.member "ResourceStatusReason" xml)
               String.parse);
          drift_information =
            (Util.option_bind (Xml.member "DriftInformation" xml)
               StackResourceDriftInformationSummary.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "LogicalResourceId"
                       ([], (String.to_xml v.logical_resource_id)))])
                @
                [Util.option_map v.physical_resource_id
                   (fun f ->
                      Ezxmlm.make_tag "PhysicalResourceId"
                        ([], (String.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "ResourceType"
                     ([], (String.to_xml v.resource_type)))])
              @
              [Some
                 (Ezxmlm.make_tag "LastUpdatedTimestamp"
                    ([], (DateTime.to_xml v.last_updated_timestamp)))])
             @
             [Some
                (Ezxmlm.make_tag "ResourceStatus"
                   ([], (ResourceStatus.to_xml v.resource_status)))])
            @
            [Util.option_map v.resource_status_reason
               (fun f ->
                  Ezxmlm.make_tag "ResourceStatusReason"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.drift_information
              (fun f ->
                 Ezxmlm.make_tag "DriftInformation"
                   ([], (StackResourceDriftInformationSummary.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains high-level information about the specified stack resource.</p>"]
module StackSetOperationResultSummary =
  struct
    type t =
      {
      account: String.t option
        [@ocaml.doc
          "<p>The name of the AWS account for this operation result.</p>"];
      region: String.t option
        [@ocaml.doc
          "<p>The name of the AWS region for this operation result.</p>"];
      status: StackSetOperationResultStatus.t option
        [@ocaml.doc
          "<p>The result status of the stack set operation for the given account in the given region.</p> <ul> <li> <p> <code>CANCELLED</code>: The operation in the specified account and region has been cancelled. This is either because a user has stopped the stack set operation, or because the failure tolerance of the stack set operation has been exceeded.</p> </li> <li> <p> <code>FAILED</code>: The operation in the specified account and region failed. </p> <p>If the stack set operation fails in enough accounts within a region, the failure tolerance for the stack set operation as a whole might be exceeded. </p> </li> <li> <p> <code>RUNNING</code>: The operation in the specified account and region is currently in progress.</p> </li> <li> <p> <code>PENDING</code>: The operation in the specified account and region has yet to start. </p> </li> <li> <p> <code>SUCCEEDED</code>: The operation in the specified account and region completed successfully.</p> </li> </ul>"];
      status_reason: String.t option
        [@ocaml.doc "<p>The reason for the assigned result status.</p>"];
      account_gate_result: AccountGateResult.t option
        [@ocaml.doc
          "<p>The results of the account gate function AWS CloudFormation invokes, if present, before proceeding with stack set operations in an account</p>"]}
    [@@ocaml.doc
      "<p>The structure that contains information about a specified operation's results for a given account in a given region.</p>"]
    let make ?account  ?region  ?status  ?status_reason  ?account_gate_result
       () = { account; region; status; status_reason; account_gate_result }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.account_gate_result
              (fun f ->
                 ("account_gate_result", (AccountGateResult.to_json f)));
           Util.option_map v.status_reason
             (fun f -> ("status_reason", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackSetOperationResultStatus.to_json f)));
           Util.option_map v.region (fun f -> ("region", (String.to_json f)));
           Util.option_map v.account
             (fun f -> ("account", (String.to_json f)))])
    let parse xml =
      Some
        {
          account =
            (Util.option_bind (Xml.member "Account" xml) String.parse);
          region = (Util.option_bind (Xml.member "Region" xml) String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               StackSetOperationResultStatus.parse);
          status_reason =
            (Util.option_bind (Xml.member "StatusReason" xml) String.parse);
          account_gate_result =
            (Util.option_bind (Xml.member "AccountGateResult" xml)
               AccountGateResult.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.account
                  (fun f -> Ezxmlm.make_tag "Account" ([], (String.to_xml f)))])
              @
              [Util.option_map v.region
                 (fun f -> Ezxmlm.make_tag "Region" ([], (String.to_xml f)))])
             @
             [Util.option_map v.status
                (fun f ->
                   Ezxmlm.make_tag "Status"
                     ([], (StackSetOperationResultStatus.to_xml f)))])
            @
            [Util.option_map v.status_reason
               (fun f ->
                  Ezxmlm.make_tag "StatusReason" ([], (String.to_xml f)))])
           @
           [Util.option_map v.account_gate_result
              (fun f ->
                 Ezxmlm.make_tag "AccountGateResult"
                   ([], (AccountGateResult.to_xml f)))])
  end[@@ocaml.doc
       "<p>The structure that contains information about a specified operation's results for a given account in a given region.</p>"]
module AccountLimit =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>The name of the account limit.</p> <p>Values: <code>ConcurrentResourcesLimit</code> | <code>StackLimit</code> | <code>StackOutputsLimit</code> </p>"];
      value: Integer.t option
        [@ocaml.doc
          "<p>The value that is associated with the account limit name.</p>"]}
    [@@ocaml.doc
      "<p>The AccountLimit data type. </p> <p>CloudFormation has the following limits per account:</p> <ul> <li> <p>Number of concurrent resources</p> </li> <li> <p>Number of stacks</p> </li> <li> <p>Number of stack outputs</p> </li> </ul> <p>For more information about these account limits, and other CloudFormation limits, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html\">AWS CloudFormation Limits</a> in the <i>AWS CloudFormation User Guide</i>.</p>"]
    let make ?name  ?value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (Integer.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.name
               (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>The AccountLimit data type. </p> <p>CloudFormation has the following limits per account:</p> <ul> <li> <p>Number of concurrent resources</p> </li> <li> <p>Number of stacks</p> </li> <li> <p>Number of stack outputs</p> </li> </ul> <p>For more information about these account limits, and other CloudFormation limits, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cloudformation-limits.html\">AWS CloudFormation Limits</a> in the <i>AWS CloudFormation User Guide</i>.</p>"]
module StackSummary =
  struct
    type t =
      {
      stack_id: String.t option
        [@ocaml.doc "<p>Unique stack identifier.</p>"];
      stack_name: String.t
        [@ocaml.doc "<p>The name associated with the stack.</p>"];
      template_description: String.t option
        [@ocaml.doc
          "<p>The template description of the template used to create the stack.</p>"];
      creation_time: DateTime.t
        [@ocaml.doc "<p>The time the stack was created.</p>"];
      last_updated_time: DateTime.t option
        [@ocaml.doc
          "<p>The time the stack was last updated. This field will only be returned if the stack has been updated at least once.</p>"];
      deletion_time: DateTime.t option
        [@ocaml.doc "<p>The time the stack was deleted.</p>"];
      stack_status: StackStatus.t
        [@ocaml.doc "<p>The current status of the stack.</p>"];
      stack_status_reason: String.t option
        [@ocaml.doc
          "<p>Success/Failure message associated with the stack status.</p>"];
      parent_id: String.t option
        [@ocaml.doc
          "<p>For nested stacks--stacks created as resources for another stack--the stack ID of the direct parent of this stack. For the first level of nested stacks, the root stack is also the parent stack.</p> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html\">Working with Nested Stacks</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      root_id: String.t option
        [@ocaml.doc
          "<p>For nested stacks--stacks created as resources for another stack--the stack ID of the top-level stack to which the nested stack ultimately belongs.</p> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html\">Working with Nested Stacks</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      drift_information: StackDriftInformationSummary.t option
        [@ocaml.doc
          "<p>Summarizes information on whether a stack's actual configuration differs, or has <i>drifted</i>, from it's expected configuration, as defined in the stack template and any values specified as template parameters. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]}
    [@@ocaml.doc "<p>The StackSummary Data Type</p>"]
    let make ?stack_id  ~stack_name  ?template_description  ~creation_time 
      ?last_updated_time  ?deletion_time  ~stack_status  ?stack_status_reason
       ?parent_id  ?root_id  ?drift_information  () =
      {
        stack_id;
        stack_name;
        template_description;
        creation_time;
        last_updated_time;
        deletion_time;
        stack_status;
        stack_status_reason;
        parent_id;
        root_id;
        drift_information
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.drift_information
              (fun f ->
                 ("drift_information",
                   (StackDriftInformationSummary.to_json f)));
           Util.option_map v.root_id
             (fun f -> ("root_id", (String.to_json f)));
           Util.option_map v.parent_id
             (fun f -> ("parent_id", (String.to_json f)));
           Util.option_map v.stack_status_reason
             (fun f -> ("stack_status_reason", (String.to_json f)));
           Some ("stack_status", (StackStatus.to_json v.stack_status));
           Util.option_map v.deletion_time
             (fun f -> ("deletion_time", (DateTime.to_json f)));
           Util.option_map v.last_updated_time
             (fun f -> ("last_updated_time", (DateTime.to_json f)));
           Some ("creation_time", (DateTime.to_json v.creation_time));
           Util.option_map v.template_description
             (fun f -> ("template_description", (String.to_json f)));
           Some ("stack_name", (String.to_json v.stack_name));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          template_description =
            (Util.option_bind (Xml.member "TemplateDescription" xml)
               String.parse);
          creation_time =
            (Xml.required "CreationTime"
               (Util.option_bind (Xml.member "CreationTime" xml)
                  DateTime.parse));
          last_updated_time =
            (Util.option_bind (Xml.member "LastUpdatedTime" xml)
               DateTime.parse);
          deletion_time =
            (Util.option_bind (Xml.member "DeletionTime" xml) DateTime.parse);
          stack_status =
            (Xml.required "StackStatus"
               (Util.option_bind (Xml.member "StackStatus" xml)
                  StackStatus.parse));
          stack_status_reason =
            (Util.option_bind (Xml.member "StackStatusReason" xml)
               String.parse);
          parent_id =
            (Util.option_bind (Xml.member "ParentId" xml) String.parse);
          root_id = (Util.option_bind (Xml.member "RootId" xml) String.parse);
          drift_information =
            (Util.option_bind (Xml.member "DriftInformation" xml)
               StackDriftInformationSummary.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.stack_id
                        (fun f ->
                           Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "StackName"
                          ([], (String.to_xml v.stack_name)))])
                   @
                   [Util.option_map v.template_description
                      (fun f ->
                         Ezxmlm.make_tag "TemplateDescription"
                           ([], (String.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "CreationTime"
                        ([], (DateTime.to_xml v.creation_time)))])
                 @
                 [Util.option_map v.last_updated_time
                    (fun f ->
                       Ezxmlm.make_tag "LastUpdatedTime"
                         ([], (DateTime.to_xml f)))])
                @
                [Util.option_map v.deletion_time
                   (fun f ->
                      Ezxmlm.make_tag "DeletionTime"
                        ([], (DateTime.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "StackStatus"
                     ([], (StackStatus.to_xml v.stack_status)))])
              @
              [Util.option_map v.stack_status_reason
                 (fun f ->
                    Ezxmlm.make_tag "StackStatusReason"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.parent_id
                (fun f -> Ezxmlm.make_tag "ParentId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.root_id
               (fun f -> Ezxmlm.make_tag "RootId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.drift_information
              (fun f ->
                 Ezxmlm.make_tag "DriftInformation"
                   ([], (StackDriftInformationSummary.to_xml f)))])
  end[@@ocaml.doc "<p>The StackSummary Data Type</p>"]
module StackResourceDrift =
  struct
    type t =
      {
      stack_id: String.t [@ocaml.doc "<p>The ID of the stack.</p>"];
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical name of the resource specified in the template.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The name or unique identifier that corresponds to a physical instance ID of a resource supported by AWS CloudFormation. </p>"];
      physical_resource_id_context: PhysicalResourceIdContext.t
        [@ocaml.doc
          "<p>Context information that enables AWS CloudFormation to uniquely identify a resource. AWS CloudFormation uses context key-value pairs in cases where a resource's logical and physical IDs are not enough to uniquely identify that resource. Each context key-value pair specifies a unique resource that contains the targeted resource.</p>"];
      resource_type: String.t [@ocaml.doc "<p>The type of the resource.</p>"];
      expected_properties: String.t option
        [@ocaml.doc
          "<p>A JSON structure containing the expected property values of the stack resource, as defined in the stack template and any values specified as template parameters. </p> <p>For resources whose <code>StackResourceDriftStatus</code> is <code>DELETED</code>, this structure will not be present. </p>"];
      actual_properties: String.t option
        [@ocaml.doc
          "<p>A JSON structure containing the actual property values of the stack resource.</p> <p>For resources whose <code>StackResourceDriftStatus</code> is <code>DELETED</code>, this structure will not be present. </p>"];
      property_differences: PropertyDifferences.t
        [@ocaml.doc
          "<p>A collection of the resource properties whose actual values differ from their expected values. These will be present only for resources whose <code>StackResourceDriftStatus</code> is <code>MODIFIED</code>. </p>"];
      stack_resource_drift_status: StackResourceDriftStatus.t
        [@ocaml.doc
          "<p>Status of the resource's actual configuration compared to its expected configuration</p> <ul> <li> <p> <code>DELETED</code>: The resource differs from its expected template configuration because the resource has been deleted.</p> </li> <li> <p> <code>MODIFIED</code>: One or more resource properties differ from their expected values (as defined in the stack template and any values specified as template parameters).</p> </li> <li> <p> <code>IN_SYNC</code>: The resources's actual configuration matches its expected template configuration.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation does not currently return this value.</p> </li> </ul>"];
      timestamp: DateTime.t
        [@ocaml.doc
          "<p>Time at which AWS CloudFormation performed drift detection on the stack resource.</p>"]}
    [@@ocaml.doc
      "<p>Contains the drift information for a resource that has been checked for drift. This includes actual and expected property values for resources in which AWS CloudFormation has detected drift. Only resource properties explicitly defined in the stack template are checked for drift. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p> <p>Resources that do not currently support drift detection cannot be checked. For a list of resources that support drift detection, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html\">Resources that Support Drift Detection</a>.</p> <p>Use <a>DetectStackResourceDrift</a> to detect drift on individual resources, or <a>DetectStackDrift</a> to detect drift on all resources in a given stack that support drift detection.</p>"]
    let make ~stack_id  ~logical_resource_id  ?physical_resource_id 
      ?(physical_resource_id_context= [])  ~resource_type 
      ?expected_properties  ?actual_properties  ?(property_differences= []) 
      ~stack_resource_drift_status  ~timestamp  () =
      {
        stack_id;
        logical_resource_id;
        physical_resource_id;
        physical_resource_id_context;
        resource_type;
        expected_properties;
        actual_properties;
        property_differences;
        stack_resource_drift_status;
        timestamp
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("timestamp", (DateTime.to_json v.timestamp));
           Some
             ("stack_resource_drift_status",
               (StackResourceDriftStatus.to_json
                  v.stack_resource_drift_status));
           Some
             ("property_differences",
               (PropertyDifferences.to_json v.property_differences));
           Util.option_map v.actual_properties
             (fun f -> ("actual_properties", (String.to_json f)));
           Util.option_map v.expected_properties
             (fun f -> ("expected_properties", (String.to_json f)));
           Some ("resource_type", (String.to_json v.resource_type));
           Some
             ("physical_resource_id_context",
               (PhysicalResourceIdContext.to_json
                  v.physical_resource_id_context));
           Util.option_map v.physical_resource_id
             (fun f -> ("physical_resource_id", (String.to_json f)));
           Some
             ("logical_resource_id", (String.to_json v.logical_resource_id));
           Some ("stack_id", (String.to_json v.stack_id))])
    let parse xml =
      Some
        {
          stack_id =
            (Xml.required "StackId"
               (Util.option_bind (Xml.member "StackId" xml) String.parse));
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse));
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse);
          physical_resource_id_context =
            (Util.of_option []
               (Util.option_bind (Xml.member "PhysicalResourceIdContext" xml)
                  PhysicalResourceIdContext.parse));
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          expected_properties =
            (Util.option_bind (Xml.member "ExpectedProperties" xml)
               String.parse);
          actual_properties =
            (Util.option_bind (Xml.member "ActualProperties" xml)
               String.parse);
          property_differences =
            (Util.of_option []
               (Util.option_bind (Xml.member "PropertyDifferences" xml)
                  PropertyDifferences.parse));
          stack_resource_drift_status =
            (Xml.required "StackResourceDriftStatus"
               (Util.option_bind (Xml.member "StackResourceDriftStatus" xml)
                  StackResourceDriftStatus.parse));
          timestamp =
            (Xml.required "Timestamp"
               (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Some
                       (Ezxmlm.make_tag "StackId"
                          ([], (String.to_xml v.stack_id)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "LogicalResourceId"
                         ([], (String.to_xml v.logical_resource_id)))])
                  @
                  [Util.option_map v.physical_resource_id
                     (fun f ->
                        Ezxmlm.make_tag "PhysicalResourceId"
                          ([], (String.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "PhysicalResourceIdContext"
                            ([], (PhysicalResourceIdContext.to_xml [x]))))
                    v.physical_resource_id_context))
                @
                [Some
                   (Ezxmlm.make_tag "ResourceType"
                      ([], (String.to_xml v.resource_type)))])
               @
               [Util.option_map v.expected_properties
                  (fun f ->
                     Ezxmlm.make_tag "ExpectedProperties"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.actual_properties
                 (fun f ->
                    Ezxmlm.make_tag "ActualProperties"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "PropertyDifferences"
                        ([], (PropertyDifferences.to_xml [x]))))
                v.property_differences))
            @
            [Some
               (Ezxmlm.make_tag "StackResourceDriftStatus"
                  ([],
                    (StackResourceDriftStatus.to_xml
                       v.stack_resource_drift_status)))])
           @
           [Some
              (Ezxmlm.make_tag "Timestamp"
                 ([], (DateTime.to_xml v.timestamp)))])
  end[@@ocaml.doc
       "<p>Contains the drift information for a resource that has been checked for drift. This includes actual and expected property values for resources in which AWS CloudFormation has detected drift. Only resource properties explicitly defined in the stack template are checked for drift. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p> <p>Resources that do not currently support drift detection cannot be checked. For a list of resources that support drift detection, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html\">Resources that Support Drift Detection</a>.</p> <p>Use <a>DetectStackResourceDrift</a> to detect drift on individual resources, or <a>DetectStackDrift</a> to detect drift on all resources in a given stack that support drift detection.</p>"]
module Change =
  struct
    type t =
      {
      type_: ChangeType.t option
        [@ocaml.doc
          "<p>The type of entity that AWS CloudFormation changes. Currently, the only entity type is <code>Resource</code>.</p>"];
      resource_change: ResourceChange.t option
        [@ocaml.doc
          "<p>A <code>ResourceChange</code> structure that describes the resource and action that AWS CloudFormation will perform.</p>"]}
    [@@ocaml.doc
      "<p>The <code>Change</code> structure describes the changes AWS CloudFormation will perform if you execute the change set.</p>"]
    let make ?type_  ?resource_change  () = { type_; resource_change }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource_change
              (fun f -> ("resource_change", (ResourceChange.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (ChangeType.to_json f)))])
    let parse xml =
      Some
        {
          type_ = (Util.option_bind (Xml.member "Type" xml) ChangeType.parse);
          resource_change =
            (Util.option_bind (Xml.member "ResourceChange" xml)
               ResourceChange.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.type_
               (fun f -> Ezxmlm.make_tag "Type" ([], (ChangeType.to_xml f)))])
           @
           [Util.option_map v.resource_change
              (fun f ->
                 Ezxmlm.make_tag "ResourceChange"
                   ([], (ResourceChange.to_xml f)))])
  end[@@ocaml.doc
       "<p>The <code>Change</code> structure describes the changes AWS CloudFormation will perform if you execute the change set.</p>"]
module ChangeSetSummary =
  struct
    type t =
      {
      stack_id: String.t option
        [@ocaml.doc
          "<p>The ID of the stack with which the change set is associated.</p>"];
      stack_name: String.t option
        [@ocaml.doc
          "<p>The name of the stack with which the change set is associated.</p>"];
      change_set_id: String.t option
        [@ocaml.doc "<p>The ID of the change set.</p>"];
      change_set_name: String.t option
        [@ocaml.doc "<p>The name of the change set.</p>"];
      execution_status: ExecutionStatus.t option
        [@ocaml.doc
          "<p>If the change set execution status is <code>AVAILABLE</code>, you can execute the change set. If you can\226\128\153t execute the change set, the status indicates why. For example, a change set might be in an <code>UNAVAILABLE</code> state because AWS CloudFormation is still creating it or in an <code>OBSOLETE</code> state because the stack was already updated.</p>"];
      status: ChangeSetStatus.t option
        [@ocaml.doc
          "<p>The state of the change set, such as <code>CREATE_IN_PROGRESS</code>, <code>CREATE_COMPLETE</code>, or <code>FAILED</code>.</p>"];
      status_reason: String.t option
        [@ocaml.doc
          "<p>A description of the change set's status. For example, if your change set is in the <code>FAILED</code> state, AWS CloudFormation shows the error message.</p>"];
      creation_time: DateTime.t option
        [@ocaml.doc
          "<p>The start time when the change set was created, in UTC.</p>"];
      description: String.t option
        [@ocaml.doc "<p>Descriptive information about the change set.</p>"]}
    [@@ocaml.doc
      "<p>The <code>ChangeSetSummary</code> structure describes a change set, its status, and the stack with which it's associated.</p>"]
    let make ?stack_id  ?stack_name  ?change_set_id  ?change_set_name 
      ?execution_status  ?status  ?status_reason  ?creation_time 
      ?description  () =
      {
        stack_id;
        stack_name;
        change_set_id;
        change_set_name;
        execution_status;
        status;
        status_reason;
        creation_time;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.creation_time
             (fun f -> ("creation_time", (DateTime.to_json f)));
           Util.option_map v.status_reason
             (fun f -> ("status_reason", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (ChangeSetStatus.to_json f)));
           Util.option_map v.execution_status
             (fun f -> ("execution_status", (ExecutionStatus.to_json f)));
           Util.option_map v.change_set_name
             (fun f -> ("change_set_name", (String.to_json f)));
           Util.option_map v.change_set_id
             (fun f -> ("change_set_id", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          change_set_id =
            (Util.option_bind (Xml.member "ChangeSetId" xml) String.parse);
          change_set_name =
            (Util.option_bind (Xml.member "ChangeSetName" xml) String.parse);
          execution_status =
            (Util.option_bind (Xml.member "ExecutionStatus" xml)
               ExecutionStatus.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml) ChangeSetStatus.parse);
          status_reason =
            (Util.option_bind (Xml.member "StatusReason" xml) String.parse);
          creation_time =
            (Util.option_bind (Xml.member "CreationTime" xml) DateTime.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.stack_id
                      (fun f ->
                         Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.stack_name
                     (fun f ->
                        Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.change_set_id
                    (fun f ->
                       Ezxmlm.make_tag "ChangeSetId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.change_set_name
                   (fun f ->
                      Ezxmlm.make_tag "ChangeSetName" ([], (String.to_xml f)))])
               @
               [Util.option_map v.execution_status
                  (fun f ->
                     Ezxmlm.make_tag "ExecutionStatus"
                       ([], (ExecutionStatus.to_xml f)))])
              @
              [Util.option_map v.status
                 (fun f ->
                    Ezxmlm.make_tag "Status" ([], (ChangeSetStatus.to_xml f)))])
             @
             [Util.option_map v.status_reason
                (fun f ->
                   Ezxmlm.make_tag "StatusReason" ([], (String.to_xml f)))])
            @
            [Util.option_map v.creation_time
               (fun f ->
                  Ezxmlm.make_tag "CreationTime" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The <code>ChangeSetSummary</code> structure describes a change set, its status, and the stack with which it's associated.</p>"]
module Export =
  struct
    type t =
      {
      exporting_stack_id: String.t option
        [@ocaml.doc
          "<p>The stack that contains the exported output name and value.</p>"];
      name: String.t option
        [@ocaml.doc
          "<p>The name of exported output value. Use this name and the <code>Fn::ImportValue</code> function to import the associated value into other stacks. The name is defined in the <code>Export</code> field in the associated stack's <code>Outputs</code> section.</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>The value of the exported output, such as a resource physical ID. This value is defined in the <code>Export</code> field in the associated stack's <code>Outputs</code> section.</p>"]}
    [@@ocaml.doc
      "<p>The <code>Export</code> structure describes the exported output values for a stack.</p>"]
    let make ?exporting_stack_id  ?name  ?value  () =
      { exporting_stack_id; name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.exporting_stack_id
             (fun f -> ("exporting_stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          exporting_stack_id =
            (Util.option_bind (Xml.member "ExportingStackId" xml)
               String.parse);
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.exporting_stack_id
                (fun f ->
                   Ezxmlm.make_tag "ExportingStackId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.name
               (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The <code>Export</code> structure describes the exported output values for a stack.</p>"]
module ParameterDeclaration =
  struct
    type t =
      {
      parameter_key: String.t option
        [@ocaml.doc "<p>The name that is associated with the parameter.</p>"];
      default_value: String.t option
        [@ocaml.doc "<p>The default value of the parameter.</p>"];
      parameter_type: String.t option
        [@ocaml.doc "<p>The type of parameter.</p>"];
      no_echo: Boolean.t option
        [@ocaml.doc
          "<p>Flag that indicates whether the parameter value is shown as plain text in logs and in the AWS Management Console.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The description that is associate with the parameter.</p>"];
      parameter_constraints: ParameterConstraints.t option
        [@ocaml.doc
          "<p>The criteria that AWS CloudFormation uses to validate parameter values.</p>"]}
    [@@ocaml.doc "<p>The ParameterDeclaration data type.</p>"]
    let make ?parameter_key  ?default_value  ?parameter_type  ?no_echo 
      ?description  ?parameter_constraints  () =
      {
        parameter_key;
        default_value;
        parameter_type;
        no_echo;
        description;
        parameter_constraints
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameter_constraints
              (fun f ->
                 ("parameter_constraints", (ParameterConstraints.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.no_echo
             (fun f -> ("no_echo", (Boolean.to_json f)));
           Util.option_map v.parameter_type
             (fun f -> ("parameter_type", (String.to_json f)));
           Util.option_map v.default_value
             (fun f -> ("default_value", (String.to_json f)));
           Util.option_map v.parameter_key
             (fun f -> ("parameter_key", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_key =
            (Util.option_bind (Xml.member "ParameterKey" xml) String.parse);
          default_value =
            (Util.option_bind (Xml.member "DefaultValue" xml) String.parse);
          parameter_type =
            (Util.option_bind (Xml.member "ParameterType" xml) String.parse);
          no_echo =
            (Util.option_bind (Xml.member "NoEcho" xml) Boolean.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          parameter_constraints =
            (Util.option_bind (Xml.member "ParameterConstraints" xml)
               ParameterConstraints.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.parameter_key
                   (fun f ->
                      Ezxmlm.make_tag "ParameterKey" ([], (String.to_xml f)))])
               @
               [Util.option_map v.default_value
                  (fun f ->
                     Ezxmlm.make_tag "DefaultValue" ([], (String.to_xml f)))])
              @
              [Util.option_map v.parameter_type
                 (fun f ->
                    Ezxmlm.make_tag "ParameterType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.no_echo
                (fun f -> Ezxmlm.make_tag "NoEcho" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           [Util.option_map v.parameter_constraints
              (fun f ->
                 Ezxmlm.make_tag "ParameterConstraints"
                   ([], (ParameterConstraints.to_xml f)))])
  end[@@ocaml.doc "<p>The ParameterDeclaration data type.</p>"]
module ResourceIdentifierSummary =
  struct
    type t =
      {
      resource_type: String.t option
        [@ocaml.doc
          "<p>The template resource type of the target resources, such as <code>AWS::S3::Bucket</code>.</p>"];
      logical_resource_ids: LogicalResourceIds.t
        [@ocaml.doc
          "<p>The logical IDs of the target resources of the specified <code>ResourceType</code>, as defined in the import template.</p>"];
      resource_identifiers: ResourceIdentifiers.t
        [@ocaml.doc
          "<p>The resource properties you can provide during the import to identify your target resources. For example, <code>BucketName</code> is a possible identifier property for <code>AWS::S3::Bucket</code> resources.</p>"]}
    [@@ocaml.doc
      "<p>Describes the target resources of a specific type in your import template (for example, all <code>AWS::S3::Bucket</code> resources) and the properties you can provide during the import to identify resources of that type.</p>"]
    let make ?resource_type  ?(logical_resource_ids= []) 
      ?(resource_identifiers= [])  () =
      { resource_type; logical_resource_ids; resource_identifiers }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resource_identifiers",
                (ResourceIdentifiers.to_json v.resource_identifiers));
           Some
             ("logical_resource_ids",
               (LogicalResourceIds.to_json v.logical_resource_ids));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          resource_type =
            (Util.option_bind (Xml.member "ResourceType" xml) String.parse);
          logical_resource_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "LogicalResourceIds" xml)
                  LogicalResourceIds.parse));
          resource_identifiers =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResourceIdentifiers" xml)
                  ResourceIdentifiers.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.resource_type
                (fun f ->
                   Ezxmlm.make_tag "ResourceType" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "LogicalResourceIds"
                       ([], (LogicalResourceIds.to_xml [x]))))
               v.logical_resource_ids))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ResourceIdentifiers"
                      ([], (ResourceIdentifiers.to_xml [x]))))
              v.resource_identifiers))
  end[@@ocaml.doc
       "<p>Describes the target resources of a specific type in your import template (for example, all <code>AWS::S3::Bucket</code> resources) and the properties you can provide during the import to identify resources of that type.</p>"]
module ResourceToImport =
  struct
    type t =
      {
      resource_type: String.t
        [@ocaml.doc
          "<p>The type of resource to import into your stack, such as <code>AWS::S3::Bucket</code>. </p>"];
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical ID of the target resource as specified in the template.</p>"];
      resource_identifier: ResourceIdentifierProperties.t
        [@ocaml.doc
          "<p>A key-value pair that identifies the target resource. The key is an identifier property (for example, <code>BucketName</code> for <code>AWS::S3::Bucket</code> resources) and the value is the actual property value (for example, <code>MyS3Bucket</code>).</p>"]}
    [@@ocaml.doc
      "<p>Describes the target resource of an import operation.</p>"]
    let make ~resource_type  ~logical_resource_id  ~resource_identifier  () =
      { resource_type; logical_resource_id; resource_identifier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resource_identifier",
                (ResourceIdentifierProperties.to_json v.resource_identifier));
           Some
             ("logical_resource_id", (String.to_json v.logical_resource_id));
           Some ("resource_type", (String.to_json v.resource_type))])
    let parse xml =
      Some
        {
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse));
          resource_identifier =
            (Xml.required "ResourceIdentifier"
               (Util.option_bind (Xml.member "ResourceIdentifier" xml)
                  ResourceIdentifierProperties.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "ResourceType"
                   ([], (String.to_xml v.resource_type)))])
            @
            [Some
               (Ezxmlm.make_tag "LogicalResourceId"
                  ([], (String.to_xml v.logical_resource_id)))])
           @
           [Some
              (Ezxmlm.make_tag "ResourceIdentifier"
                 ([],
                   (ResourceIdentifierProperties.to_xml v.resource_identifier)))])
  end[@@ocaml.doc
       "<p>Describes the target resource of an import operation.</p>"]
module TemplateParameter =
  struct
    type t =
      {
      parameter_key: String.t option
        [@ocaml.doc "<p>The name associated with the parameter.</p>"];
      default_value: String.t option
        [@ocaml.doc
          "<p>The default value associated with the parameter.</p>"];
      no_echo: Boolean.t option
        [@ocaml.doc
          "<p>Flag indicating whether the parameter should be displayed as plain text in logs and UIs.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>User defined description associated with the parameter.</p>"]}
    [@@ocaml.doc "<p>The TemplateParameter data type.</p>"]
    let make ?parameter_key  ?default_value  ?no_echo  ?description  () =
      { parameter_key; default_value; no_echo; description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.no_echo
             (fun f -> ("no_echo", (Boolean.to_json f)));
           Util.option_map v.default_value
             (fun f -> ("default_value", (String.to_json f)));
           Util.option_map v.parameter_key
             (fun f -> ("parameter_key", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_key =
            (Util.option_bind (Xml.member "ParameterKey" xml) String.parse);
          default_value =
            (Util.option_bind (Xml.member "DefaultValue" xml) String.parse);
          no_echo =
            (Util.option_bind (Xml.member "NoEcho" xml) Boolean.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.parameter_key
                 (fun f ->
                    Ezxmlm.make_tag "ParameterKey" ([], (String.to_xml f)))])
             @
             [Util.option_map v.default_value
                (fun f ->
                   Ezxmlm.make_tag "DefaultValue" ([], (String.to_xml f)))])
            @
            [Util.option_map v.no_echo
               (fun f -> Ezxmlm.make_tag "NoEcho" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The TemplateParameter data type.</p>"]
module StackSetSummary =
  struct
    type t =
      {
      stack_set_name: String.t option
        [@ocaml.doc "<p>The name of the stack set.</p>"];
      stack_set_id: String.t option
        [@ocaml.doc "<p>The ID of the stack set.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description of the stack set that you specify when the stack set is created or updated.</p>"];
      status: StackSetStatus.t option
        [@ocaml.doc "<p>The status of the stack set.</p>"];
      drift_status: StackDriftStatus.t option
        [@ocaml.doc
          "<p>Status of the stack set's actual configuration compared to its expected template and parameter configuration. A stack set is considered to have drifted if one or more of its stack instances have drifted from their expected template and parameter configuration.</p> <ul> <li> <p> <code>DRIFTED</code>: One or more of the stack instances belonging to the stack set stack differs from the expected template and parameter configuration. A stack instance is considered to have drifted if one or more of the resources in the associated stack have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked the stack set for drift.</p> </li> <li> <p> <code>IN_SYNC</code>: All of the stack instances belonging to the stack set stack match from the expected template and parameter configuration.</p> </li> <li> <p> <code>UNKNOWN</code>: This value is reserved for future use.</p> </li> </ul>"];
      last_drift_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>Most recent time when CloudFormation performed a drift detection operation on the stack set. This value will be <code>NULL</code> for any stack set on which drift detection has not yet been performed.</p>"]}
    [@@ocaml.doc
      "<p>The structures that contain summary information about the specified stack set.</p>"]
    let make ?stack_set_name  ?stack_set_id  ?description  ?status 
      ?drift_status  ?last_drift_check_timestamp  () =
      {
        stack_set_name;
        stack_set_id;
        description;
        status;
        drift_status;
        last_drift_check_timestamp
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_drift_check_timestamp
              (fun f -> ("last_drift_check_timestamp", (DateTime.to_json f)));
           Util.option_map v.drift_status
             (fun f -> ("drift_status", (StackDriftStatus.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackSetStatus.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.stack_set_id
             (fun f -> ("stack_set_id", (String.to_json f)));
           Util.option_map v.stack_set_name
             (fun f -> ("stack_set_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Util.option_bind (Xml.member "StackSetName" xml) String.parse);
          stack_set_id =
            (Util.option_bind (Xml.member "StackSetId" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml) StackSetStatus.parse);
          drift_status =
            (Util.option_bind (Xml.member "DriftStatus" xml)
               StackDriftStatus.parse);
          last_drift_check_timestamp =
            (Util.option_bind (Xml.member "LastDriftCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.stack_set_name
                   (fun f ->
                      Ezxmlm.make_tag "StackSetName" ([], (String.to_xml f)))])
               @
               [Util.option_map v.stack_set_id
                  (fun f ->
                     Ezxmlm.make_tag "StackSetId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
             @
             [Util.option_map v.status
                (fun f ->
                   Ezxmlm.make_tag "Status" ([], (StackSetStatus.to_xml f)))])
            @
            [Util.option_map v.drift_status
               (fun f ->
                  Ezxmlm.make_tag "DriftStatus"
                    ([], (StackDriftStatus.to_xml f)))])
           @
           [Util.option_map v.last_drift_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastDriftCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>The structures that contain summary information about the specified stack set.</p>"]
module StackInstanceSummary =
  struct
    type t =
      {
      stack_set_id: String.t option
        [@ocaml.doc
          "<p>The name or unique ID of the stack set that the stack instance is associated with.</p>"];
      region: String.t option
        [@ocaml.doc
          "<p>The name of the AWS region that the stack instance is associated with.</p>"];
      account: String.t option
        [@ocaml.doc
          "<p>The name of the AWS account that the stack instance is associated with.</p>"];
      stack_id: String.t option
        [@ocaml.doc "<p>The ID of the stack instance.</p>"];
      status: StackInstanceStatus.t option
        [@ocaml.doc
          "<p>The status of the stack instance, in terms of its synchronization with its associated stack set.</p> <ul> <li> <p> <code>INOPERABLE</code>: A <code>DeleteStackInstances</code> operation has failed and left the stack in an unstable state. Stacks in this state are excluded from further <code>UpdateStackSet</code> operations. You might need to perform a <code>DeleteStackInstances</code> operation, with <code>RetainStacks</code> set to <code>true</code>, to delete the stack instance, and then delete the stack manually.</p> </li> <li> <p> <code>OUTDATED</code>: The stack isn't currently up to date with the stack set because:</p> <ul> <li> <p>The associated stack failed during a <code>CreateStackSet</code> or <code>UpdateStackSet</code> operation. </p> </li> <li> <p>The stack was part of a <code>CreateStackSet</code> or <code>UpdateStackSet</code> operation that failed or was stopped before the stack was created or updated. </p> </li> </ul> </li> <li> <p> <code>CURRENT</code>: The stack is currently up to date with the stack set.</p> </li> </ul>"];
      status_reason: String.t option
        [@ocaml.doc
          "<p>The explanation for the specific status code assigned to this stack instance.</p>"];
      drift_status: StackDriftStatus.t option
        [@ocaml.doc
          "<p>Status of the stack instance's actual configuration compared to the expected template and parameter configuration of the stack set to which it belongs. </p> <ul> <li> <p> <code>DRIFTED</code>: The stack differs from the expected template and parameter configuration of the stack set to which it belongs. A stack instance is considered to have drifted if one or more of the resources in the associated stack have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the stack instance differs from its expected stack set configuration.</p> </li> <li> <p> <code>IN_SYNC</code>: The stack instance's actual configuration matches its expected stack set configuration.</p> </li> <li> <p> <code>UNKNOWN</code>: This value is reserved for future use.</p> </li> </ul>"];
      last_drift_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>Most recent time when CloudFormation performed a drift detection operation on the stack instance. This value will be <code>NULL</code> for any stack instance on which drift detection has not yet been performed.</p>"]}
    [@@ocaml.doc
      "<p>The structure that contains summary information about a stack instance.</p>"]
    let make ?stack_set_id  ?region  ?account  ?stack_id  ?status 
      ?status_reason  ?drift_status  ?last_drift_check_timestamp  () =
      {
        stack_set_id;
        region;
        account;
        stack_id;
        status;
        status_reason;
        drift_status;
        last_drift_check_timestamp
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_drift_check_timestamp
              (fun f -> ("last_drift_check_timestamp", (DateTime.to_json f)));
           Util.option_map v.drift_status
             (fun f -> ("drift_status", (StackDriftStatus.to_json f)));
           Util.option_map v.status_reason
             (fun f -> ("status_reason", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackInstanceStatus.to_json f)));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)));
           Util.option_map v.account
             (fun f -> ("account", (String.to_json f)));
           Util.option_map v.region (fun f -> ("region", (String.to_json f)));
           Util.option_map v.stack_set_id
             (fun f -> ("stack_set_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_set_id =
            (Util.option_bind (Xml.member "StackSetId" xml) String.parse);
          region = (Util.option_bind (Xml.member "Region" xml) String.parse);
          account =
            (Util.option_bind (Xml.member "Account" xml) String.parse);
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               StackInstanceStatus.parse);
          status_reason =
            (Util.option_bind (Xml.member "StatusReason" xml) String.parse);
          drift_status =
            (Util.option_bind (Xml.member "DriftStatus" xml)
               StackDriftStatus.parse);
          last_drift_check_timestamp =
            (Util.option_bind (Xml.member "LastDriftCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.stack_set_id
                     (fun f ->
                        Ezxmlm.make_tag "StackSetId" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.region
                    (fun f ->
                       Ezxmlm.make_tag "Region" ([], (String.to_xml f)))])
                @
                [Util.option_map v.account
                   (fun f ->
                      Ezxmlm.make_tag "Account" ([], (String.to_xml f)))])
               @
               [Util.option_map v.stack_id
                  (fun f -> Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.status
                 (fun f ->
                    Ezxmlm.make_tag "Status"
                      ([], (StackInstanceStatus.to_xml f)))])
             @
             [Util.option_map v.status_reason
                (fun f ->
                   Ezxmlm.make_tag "StatusReason" ([], (String.to_xml f)))])
            @
            [Util.option_map v.drift_status
               (fun f ->
                  Ezxmlm.make_tag "DriftStatus"
                    ([], (StackDriftStatus.to_xml f)))])
           @
           [Util.option_map v.last_drift_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastDriftCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>The structure that contains summary information about a stack instance.</p>"]
module TypeSummary =
  struct
    type t =
      {
      type_: RegistryType.t option [@ocaml.doc "<p>The kind of type.</p>"];
      type_name: String.t option [@ocaml.doc "<p>The name of the type.</p>"];
      default_version_id: String.t option
        [@ocaml.doc
          "<p>The ID of the default version of the type. The default version is used when the type version is not specified.</p> <p>To set the default version of a type, use <code> <a>SetTypeDefaultVersion</a> </code>. </p>"];
      type_arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the type.</p>"];
      last_updated: DateTime.t option
        [@ocaml.doc
          "<p>When the current default version of the type was registered.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the type.</p>"]}[@@ocaml.doc
                                                             "<p>Contains summary information about the specified CloudFormation type.</p>"]
    let make ?type_  ?type_name  ?default_version_id  ?type_arn 
      ?last_updated  ?description  () =
      {
        type_;
        type_name;
        default_version_id;
        type_arn;
        last_updated;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.last_updated
             (fun f -> ("last_updated", (DateTime.to_json f)));
           Util.option_map v.type_arn
             (fun f -> ("type_arn", (String.to_json f)));
           Util.option_map v.default_version_id
             (fun f -> ("default_version_id", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (RegistryType.to_json f)))])
    let parse xml =
      Some
        {
          type_ =
            (Util.option_bind (Xml.member "Type" xml) RegistryType.parse);
          type_name =
            (Util.option_bind (Xml.member "TypeName" xml) String.parse);
          default_version_id =
            (Util.option_bind (Xml.member "DefaultVersionId" xml)
               String.parse);
          type_arn =
            (Util.option_bind (Xml.member "TypeArn" xml) String.parse);
          last_updated =
            (Util.option_bind (Xml.member "LastUpdated" xml) DateTime.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.type_
                   (fun f ->
                      Ezxmlm.make_tag "Type" ([], (RegistryType.to_xml f)))])
               @
               [Util.option_map v.type_name
                  (fun f ->
                     Ezxmlm.make_tag "TypeName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.default_version_id
                 (fun f ->
                    Ezxmlm.make_tag "DefaultVersionId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.type_arn
                (fun f -> Ezxmlm.make_tag "TypeArn" ([], (String.to_xml f)))])
            @
            [Util.option_map v.last_updated
               (fun f ->
                  Ezxmlm.make_tag "LastUpdated" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains summary information about the specified CloudFormation type.</p>"]
module Stack =
  struct
    type t =
      {
      stack_id: String.t option
        [@ocaml.doc "<p>Unique identifier of the stack.</p>"];
      stack_name: String.t
        [@ocaml.doc "<p>The name associated with the stack.</p>"];
      change_set_id: String.t option
        [@ocaml.doc "<p>The unique ID of the change set.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A user-defined description associated with the stack.</p>"];
      parameters: Parameters.t
        [@ocaml.doc "<p>A list of <code>Parameter</code> structures.</p>"];
      creation_time: DateTime.t
        [@ocaml.doc "<p>The time at which the stack was created.</p>"];
      deletion_time: DateTime.t option
        [@ocaml.doc "<p>The time the stack was deleted.</p>"];
      last_updated_time: DateTime.t option
        [@ocaml.doc
          "<p>The time the stack was last updated. This field will only be returned if the stack has been updated at least once.</p>"];
      rollback_configuration: RollbackConfiguration.t option
        [@ocaml.doc
          "<p>The rollback triggers for AWS CloudFormation to monitor during stack creation and updating operations, and for the specified monitoring period afterwards.</p>"];
      stack_status: StackStatus.t
        [@ocaml.doc "<p>Current status of the stack.</p>"];
      stack_status_reason: String.t option
        [@ocaml.doc
          "<p>Success/failure message associated with the stack status.</p>"];
      disable_rollback: Boolean.t option
        [@ocaml.doc
          "<p>Boolean to enable or disable rollback on stack creation failures:</p> <ul> <li> <p> <code>true</code>: disable rollback</p> </li> <li> <p> <code>false</code>: enable rollback</p> </li> </ul>"];
      notification_a_r_ns: NotificationARNs.t
        [@ocaml.doc
          "<p>SNS topic ARNs to which stack related events are published.</p>"];
      timeout_in_minutes: Integer.t option
        [@ocaml.doc
          "<p>The amount of time within which stack creation should complete.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc "<p>The capabilities allowed in the stack.</p>"];
      outputs: Outputs.t [@ocaml.doc "<p>A list of output structures.</p>"];
      role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an AWS Identity and Access Management (IAM) role that is associated with the stack. During a stack operation, AWS CloudFormation uses this role's credentials to make calls on your behalf.</p>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>A list of <code>Tag</code>s that specify information about the stack.</p>"];
      enable_termination_protection: Boolean.t option
        [@ocaml.doc
          "<p>Whether termination protection is enabled for the stack.</p> <p> For <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html\">nested stacks</a>, termination protection is set on the root stack and cannot be changed directly on the nested stack. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-protect-stacks.html\">Protecting a Stack From Being Deleted</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      parent_id: String.t option
        [@ocaml.doc
          "<p>For nested stacks--stacks created as resources for another stack--the stack ID of the direct parent of this stack. For the first level of nested stacks, the root stack is also the parent stack.</p> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html\">Working with Nested Stacks</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      root_id: String.t option
        [@ocaml.doc
          "<p>For nested stacks--stacks created as resources for another stack--the stack ID of the top-level stack to which the nested stack ultimately belongs.</p> <p>For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html\">Working with Nested Stacks</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      drift_information: StackDriftInformation.t option
        [@ocaml.doc
          "<p>Information on whether a stack's actual configuration differs, or has <i>drifted</i>, from it's expected configuration, as defined in the stack template and any values specified as template parameters. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]}
    [@@ocaml.doc "<p>The Stack data type.</p>"]
    let make ?stack_id  ~stack_name  ?change_set_id  ?description 
      ?(parameters= [])  ~creation_time  ?deletion_time  ?last_updated_time 
      ?rollback_configuration  ~stack_status  ?stack_status_reason 
      ?disable_rollback  ?(notification_a_r_ns= [])  ?timeout_in_minutes 
      ?(capabilities= [])  ?(outputs= [])  ?role_a_r_n  ?(tags= []) 
      ?enable_termination_protection  ?parent_id  ?root_id 
      ?drift_information  () =
      {
        stack_id;
        stack_name;
        change_set_id;
        description;
        parameters;
        creation_time;
        deletion_time;
        last_updated_time;
        rollback_configuration;
        stack_status;
        stack_status_reason;
        disable_rollback;
        notification_a_r_ns;
        timeout_in_minutes;
        capabilities;
        outputs;
        role_a_r_n;
        tags;
        enable_termination_protection;
        parent_id;
        root_id;
        drift_information
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.drift_information
              (fun f ->
                 ("drift_information", (StackDriftInformation.to_json f)));
           Util.option_map v.root_id
             (fun f -> ("root_id", (String.to_json f)));
           Util.option_map v.parent_id
             (fun f -> ("parent_id", (String.to_json f)));
           Util.option_map v.enable_termination_protection
             (fun f -> ("enable_termination_protection", (Boolean.to_json f)));
           Some ("tags", (Tags.to_json v.tags));
           Util.option_map v.role_a_r_n
             (fun f -> ("role_a_r_n", (String.to_json f)));
           Some ("outputs", (Outputs.to_json v.outputs));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Util.option_map v.timeout_in_minutes
             (fun f -> ("timeout_in_minutes", (Integer.to_json f)));
           Some
             ("notification_a_r_ns",
               (NotificationARNs.to_json v.notification_a_r_ns));
           Util.option_map v.disable_rollback
             (fun f -> ("disable_rollback", (Boolean.to_json f)));
           Util.option_map v.stack_status_reason
             (fun f -> ("stack_status_reason", (String.to_json f)));
           Some ("stack_status", (StackStatus.to_json v.stack_status));
           Util.option_map v.rollback_configuration
             (fun f ->
                ("rollback_configuration", (RollbackConfiguration.to_json f)));
           Util.option_map v.last_updated_time
             (fun f -> ("last_updated_time", (DateTime.to_json f)));
           Util.option_map v.deletion_time
             (fun f -> ("deletion_time", (DateTime.to_json f)));
           Some ("creation_time", (DateTime.to_json v.creation_time));
           Some ("parameters", (Parameters.to_json v.parameters));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.change_set_id
             (fun f -> ("change_set_id", (String.to_json f)));
           Some ("stack_name", (String.to_json v.stack_name));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          change_set_id =
            (Util.option_bind (Xml.member "ChangeSetId" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  Parameters.parse));
          creation_time =
            (Xml.required "CreationTime"
               (Util.option_bind (Xml.member "CreationTime" xml)
                  DateTime.parse));
          deletion_time =
            (Util.option_bind (Xml.member "DeletionTime" xml) DateTime.parse);
          last_updated_time =
            (Util.option_bind (Xml.member "LastUpdatedTime" xml)
               DateTime.parse);
          rollback_configuration =
            (Util.option_bind (Xml.member "RollbackConfiguration" xml)
               RollbackConfiguration.parse);
          stack_status =
            (Xml.required "StackStatus"
               (Util.option_bind (Xml.member "StackStatus" xml)
                  StackStatus.parse));
          stack_status_reason =
            (Util.option_bind (Xml.member "StackStatusReason" xml)
               String.parse);
          disable_rollback =
            (Util.option_bind (Xml.member "DisableRollback" xml)
               Boolean.parse);
          notification_a_r_ns =
            (Util.of_option []
               (Util.option_bind (Xml.member "NotificationARNs" xml)
                  NotificationARNs.parse));
          timeout_in_minutes =
            (Util.option_bind (Xml.member "TimeoutInMinutes" xml)
               Integer.parse);
          capabilities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Capabilities" xml)
                  Capabilities.parse));
          outputs =
            (Util.of_option []
               (Util.option_bind (Xml.member "Outputs" xml) Outputs.parse));
          role_a_r_n =
            (Util.option_bind (Xml.member "RoleARN" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          enable_termination_protection =
            (Util.option_bind (Xml.member "EnableTerminationProtection" xml)
               Boolean.parse);
          parent_id =
            (Util.option_bind (Xml.member "ParentId" xml) String.parse);
          root_id = (Util.option_bind (Xml.member "RootId" xml) String.parse);
          drift_information =
            (Util.option_bind (Xml.member "DriftInformation" xml)
               StackDriftInformation.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((([] @
                                [Util.option_map v.stack_id
                                   (fun f ->
                                      Ezxmlm.make_tag "StackId"
                                        ([], (String.to_xml f)))])
                               @
                               [Some
                                  (Ezxmlm.make_tag "StackName"
                                     ([], (String.to_xml v.stack_name)))])
                              @
                              [Util.option_map v.change_set_id
                                 (fun f ->
                                    Ezxmlm.make_tag "ChangeSetId"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.description
                                (fun f ->
                                   Ezxmlm.make_tag "Description"
                                     ([], (String.to_xml f)))])
                            @
                            (List.map
                               (fun x ->
                                  Some
                                    (Ezxmlm.make_tag "Parameters"
                                       ([], (Parameters.to_xml [x]))))
                               v.parameters))
                           @
                           [Some
                              (Ezxmlm.make_tag "CreationTime"
                                 ([], (DateTime.to_xml v.creation_time)))])
                          @
                          [Util.option_map v.deletion_time
                             (fun f ->
                                Ezxmlm.make_tag "DeletionTime"
                                  ([], (DateTime.to_xml f)))])
                         @
                         [Util.option_map v.last_updated_time
                            (fun f ->
                               Ezxmlm.make_tag "LastUpdatedTime"
                                 ([], (DateTime.to_xml f)))])
                        @
                        [Util.option_map v.rollback_configuration
                           (fun f ->
                              Ezxmlm.make_tag "RollbackConfiguration"
                                ([], (RollbackConfiguration.to_xml f)))])
                       @
                       [Some
                          (Ezxmlm.make_tag "StackStatus"
                             ([], (StackStatus.to_xml v.stack_status)))])
                      @
                      [Util.option_map v.stack_status_reason
                         (fun f ->
                            Ezxmlm.make_tag "StackStatusReason"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.disable_rollback
                        (fun f ->
                           Ezxmlm.make_tag "DisableRollback"
                             ([], (Boolean.to_xml f)))])
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "NotificationARNs"
                               ([], (NotificationARNs.to_xml [x]))))
                       v.notification_a_r_ns))
                   @
                   [Util.option_map v.timeout_in_minutes
                      (fun f ->
                         Ezxmlm.make_tag "TimeoutInMinutes"
                           ([], (Integer.to_xml f)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "Capabilities"
                             ([], (Capabilities.to_xml [x])))) v.capabilities))
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "Outputs"
                            ([], (Outputs.to_xml [x])))) v.outputs))
                @
                [Util.option_map v.role_a_r_n
                   (fun f ->
                      Ezxmlm.make_tag "RoleARN" ([], (String.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
                  v.tags))
              @
              [Util.option_map v.enable_termination_protection
                 (fun f ->
                    Ezxmlm.make_tag "EnableTerminationProtection"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.parent_id
                (fun f -> Ezxmlm.make_tag "ParentId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.root_id
               (fun f -> Ezxmlm.make_tag "RootId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.drift_information
              (fun f ->
                 Ezxmlm.make_tag "DriftInformation"
                   ([], (StackDriftInformation.to_xml f)))])
  end[@@ocaml.doc "<p>The Stack data type.</p>"]
module StackSetDriftDetectionDetails =
  struct
    type t =
      {
      drift_status: StackSetDriftStatus.t option
        [@ocaml.doc
          "<p>Status of the stack set's actual configuration compared to its expected template and parameter configuration. A stack set is considered to have drifted if one or more of its stack instances have drifted from their expected template and parameter configuration.</p> <ul> <li> <p> <code>DRIFTED</code>: One or more of the stack instances belonging to the stack set stack differs from the expected template and parameter configuration. A stack instance is considered to have drifted if one or more of the resources in the associated stack have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked the stack set for drift.</p> </li> <li> <p> <code>IN_SYNC</code>: All of the stack instances belonging to the stack set stack match from the expected template and parameter configuration.</p> </li> </ul>"];
      drift_detection_status: StackSetDriftDetectionStatus.t option
        [@ocaml.doc
          "<p>The status of the stack set drift detection operation.</p> <ul> <li> <p> <code>COMPLETED</code>: The drift detection operation completed without failing on any stack instances.</p> </li> <li> <p> <code>FAILED</code>: The drift detection operation exceeded the specified failure tolerance. </p> </li> <li> <p> <code>PARTIAL_SUCCESS</code>: The drift detection operation completed without exceeding the failure tolerance for the operation.</p> </li> <li> <p> <code>IN_PROGRESS</code>: The drift detection operation is currently being performed.</p> </li> <li> <p> <code>STOPPED</code>: The user has cancelled the drift detection operation.</p> </li> </ul>"];
      last_drift_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>Most recent time when CloudFormation performed a drift detection operation on the stack set. This value will be <code>NULL</code> for any stack set on which drift detection has not yet been performed.</p>"];
      total_stack_instances_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of stack instances belonging to this stack set. </p> <p>The total number of stack instances is equal to the total of:</p> <ul> <li> <p>Stack instances that match the stack set configuration. </p> </li> <li> <p>Stack instances that have drifted from the stack set configuration. </p> </li> <li> <p>Stack instances where the drift detection operation has failed.</p> </li> <li> <p>Stack instances currently being checked for drift.</p> </li> </ul>"];
      drifted_stack_instances_count: Integer.t option
        [@ocaml.doc
          "<p>The number of stack instances that have drifted from the expected template and parameter configuration of the stack set. A stack instance is considered to have drifted if one or more of the resources in the associated stack do not match their expected configuration.</p>"];
      in_sync_stack_instances_count: Integer.t option
        [@ocaml.doc
          "<p>The number of stack instances which match the expected template and parameter configuration of the stack set.</p>"];
      in_progress_stack_instances_count: Integer.t option
        [@ocaml.doc
          "<p>The number of stack instances that are currently being checked for drift.</p>"];
      failed_stack_instances_count: Integer.t option
        [@ocaml.doc
          "<p>The number of stack instances for which the drift detection operation failed.</p>"]}
    [@@ocaml.doc
      "<p>Detailed information about the drift status of the stack set.</p> <p>For stack sets, contains information about the last <i>completed</i> drift operation performed on the stack set. Information about drift operations in-progress is not included. </p> <p>For stack set operations, includes information about drift operations currently being performed on the stack set.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html\">Detecting Unmanaged Changes in Stack Sets</a> in the <i>AWS CloudFormation User Guide</i>.</p>"]
    let make ?drift_status  ?drift_detection_status 
      ?last_drift_check_timestamp  ?total_stack_instances_count 
      ?drifted_stack_instances_count  ?in_sync_stack_instances_count 
      ?in_progress_stack_instances_count  ?failed_stack_instances_count  () =
      {
        drift_status;
        drift_detection_status;
        last_drift_check_timestamp;
        total_stack_instances_count;
        drifted_stack_instances_count;
        in_sync_stack_instances_count;
        in_progress_stack_instances_count;
        failed_stack_instances_count
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.failed_stack_instances_count
              (fun f -> ("failed_stack_instances_count", (Integer.to_json f)));
           Util.option_map v.in_progress_stack_instances_count
             (fun f ->
                ("in_progress_stack_instances_count", (Integer.to_json f)));
           Util.option_map v.in_sync_stack_instances_count
             (fun f -> ("in_sync_stack_instances_count", (Integer.to_json f)));
           Util.option_map v.drifted_stack_instances_count
             (fun f -> ("drifted_stack_instances_count", (Integer.to_json f)));
           Util.option_map v.total_stack_instances_count
             (fun f -> ("total_stack_instances_count", (Integer.to_json f)));
           Util.option_map v.last_drift_check_timestamp
             (fun f -> ("last_drift_check_timestamp", (DateTime.to_json f)));
           Util.option_map v.drift_detection_status
             (fun f ->
                ("drift_detection_status",
                  (StackSetDriftDetectionStatus.to_json f)));
           Util.option_map v.drift_status
             (fun f -> ("drift_status", (StackSetDriftStatus.to_json f)))])
    let parse xml =
      Some
        {
          drift_status =
            (Util.option_bind (Xml.member "DriftStatus" xml)
               StackSetDriftStatus.parse);
          drift_detection_status =
            (Util.option_bind (Xml.member "DriftDetectionStatus" xml)
               StackSetDriftDetectionStatus.parse);
          last_drift_check_timestamp =
            (Util.option_bind (Xml.member "LastDriftCheckTimestamp" xml)
               DateTime.parse);
          total_stack_instances_count =
            (Util.option_bind (Xml.member "TotalStackInstancesCount" xml)
               Integer.parse);
          drifted_stack_instances_count =
            (Util.option_bind (Xml.member "DriftedStackInstancesCount" xml)
               Integer.parse);
          in_sync_stack_instances_count =
            (Util.option_bind (Xml.member "InSyncStackInstancesCount" xml)
               Integer.parse);
          in_progress_stack_instances_count =
            (Util.option_bind
               (Xml.member "InProgressStackInstancesCount" xml) Integer.parse);
          failed_stack_instances_count =
            (Util.option_bind (Xml.member "FailedStackInstancesCount" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.drift_status
                     (fun f ->
                        Ezxmlm.make_tag "DriftStatus"
                          ([], (StackSetDriftStatus.to_xml f)))])
                 @
                 [Util.option_map v.drift_detection_status
                    (fun f ->
                       Ezxmlm.make_tag "DriftDetectionStatus"
                         ([], (StackSetDriftDetectionStatus.to_xml f)))])
                @
                [Util.option_map v.last_drift_check_timestamp
                   (fun f ->
                      Ezxmlm.make_tag "LastDriftCheckTimestamp"
                        ([], (DateTime.to_xml f)))])
               @
               [Util.option_map v.total_stack_instances_count
                  (fun f ->
                     Ezxmlm.make_tag "TotalStackInstancesCount"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.drifted_stack_instances_count
                 (fun f ->
                    Ezxmlm.make_tag "DriftedStackInstancesCount"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.in_sync_stack_instances_count
                (fun f ->
                   Ezxmlm.make_tag "InSyncStackInstancesCount"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.in_progress_stack_instances_count
               (fun f ->
                  Ezxmlm.make_tag "InProgressStackInstancesCount"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.failed_stack_instances_count
              (fun f ->
                 Ezxmlm.make_tag "FailedStackInstancesCount"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Detailed information about the drift status of the stack set.</p> <p>For stack sets, contains information about the last <i>completed</i> drift operation performed on the stack set. Information about drift operations in-progress is not included. </p> <p>For stack set operations, includes information about drift operations currently being performed on the stack set.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html\">Detecting Unmanaged Changes in Stack Sets</a> in the <i>AWS CloudFormation User Guide</i>.</p>"]
module StackSetOperationPreferences =
  struct
    type t =
      {
      region_order: RegionList.t
        [@ocaml.doc
          "<p>The order of the regions in where you want to perform the stack operation.</p>"];
      failure_tolerance_count: Integer.t option
        [@ocaml.doc
          "<p>The number of accounts, per region, for which this operation can fail before AWS CloudFormation stops the operation in that region. If the operation is stopped in a region, AWS CloudFormation doesn't attempt the operation in any subsequent regions.</p> <p>Conditional: You must specify either <code>FailureToleranceCount</code> or <code>FailureTolerancePercentage</code> (but not both).</p>"];
      failure_tolerance_percentage: Integer.t option
        [@ocaml.doc
          "<p>The percentage of accounts, per region, for which this stack operation can fail before AWS CloudFormation stops the operation in that region. If the operation is stopped in a region, AWS CloudFormation doesn't attempt the operation in any subsequent regions.</p> <p>When calculating the number of accounts based on the specified percentage, AWS CloudFormation rounds <i>down</i> to the next whole number.</p> <p>Conditional: You must specify either <code>FailureToleranceCount</code> or <code>FailureTolerancePercentage</code>, but not both.</p>"];
      max_concurrent_count: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of accounts in which to perform this operation at one time. This is dependent on the value of <code>FailureToleranceCount</code>\226\128\148<code>MaxConcurrentCount</code> is at most one more than the <code>FailureToleranceCount</code> .</p> <p>Note that this setting lets you specify the <i>maximum</i> for operations. For large deployments, under certain circumstances the actual number of accounts acted upon concurrently may be lower due to service throttling.</p> <p>Conditional: You must specify either <code>MaxConcurrentCount</code> or <code>MaxConcurrentPercentage</code>, but not both.</p>"];
      max_concurrent_percentage: Integer.t option
        [@ocaml.doc
          "<p>The maximum percentage of accounts in which to perform this operation at one time.</p> <p>When calculating the number of accounts based on the specified percentage, AWS CloudFormation rounds down to the next whole number. This is true except in cases where rounding down would result is zero. In this case, CloudFormation sets the number as one instead.</p> <p>Note that this setting lets you specify the <i>maximum</i> for operations. For large deployments, under certain circumstances the actual number of accounts acted upon concurrently may be lower due to service throttling.</p> <p>Conditional: You must specify either <code>MaxConcurrentCount</code> or <code>MaxConcurrentPercentage</code>, but not both.</p>"]}
    [@@ocaml.doc
      "<p>The user-specified preferences for how AWS CloudFormation performs a stack set operation. </p> <p>For more information on maximum concurrent accounts and failure tolerance, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options\">Stack set operation options</a>.</p>"]
    let make ?(region_order= [])  ?failure_tolerance_count 
      ?failure_tolerance_percentage  ?max_concurrent_count 
      ?max_concurrent_percentage  () =
      {
        region_order;
        failure_tolerance_count;
        failure_tolerance_percentage;
        max_concurrent_count;
        max_concurrent_percentage
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_concurrent_percentage
              (fun f -> ("max_concurrent_percentage", (Integer.to_json f)));
           Util.option_map v.max_concurrent_count
             (fun f -> ("max_concurrent_count", (Integer.to_json f)));
           Util.option_map v.failure_tolerance_percentage
             (fun f -> ("failure_tolerance_percentage", (Integer.to_json f)));
           Util.option_map v.failure_tolerance_count
             (fun f -> ("failure_tolerance_count", (Integer.to_json f)));
           Some ("region_order", (RegionList.to_json v.region_order))])
    let parse xml =
      Some
        {
          region_order =
            (Util.of_option []
               (Util.option_bind (Xml.member "RegionOrder" xml)
                  RegionList.parse));
          failure_tolerance_count =
            (Util.option_bind (Xml.member "FailureToleranceCount" xml)
               Integer.parse);
          failure_tolerance_percentage =
            (Util.option_bind (Xml.member "FailureTolerancePercentage" xml)
               Integer.parse);
          max_concurrent_count =
            (Util.option_bind (Xml.member "MaxConcurrentCount" xml)
               Integer.parse);
          max_concurrent_percentage =
            (Util.option_bind (Xml.member "MaxConcurrentPercentage" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "RegionOrder"
                          ([], (RegionList.to_xml [x])))) v.region_order))
              @
              [Util.option_map v.failure_tolerance_count
                 (fun f ->
                    Ezxmlm.make_tag "FailureToleranceCount"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.failure_tolerance_percentage
                (fun f ->
                   Ezxmlm.make_tag "FailureTolerancePercentage"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.max_concurrent_count
               (fun f ->
                  Ezxmlm.make_tag "MaxConcurrentCount"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.max_concurrent_percentage
              (fun f ->
                 Ezxmlm.make_tag "MaxConcurrentPercentage"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>The user-specified preferences for how AWS CloudFormation performs a stack set operation. </p> <p>For more information on maximum concurrent accounts and failure tolerance, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options\">Stack set operation options</a>.</p>"]
module StackEvent =
  struct
    type t =
      {
      stack_id: String.t
        [@ocaml.doc
          "<p>The unique ID name of the instance of the stack.</p>"];
      event_id: String.t [@ocaml.doc "<p>The unique ID of this event.</p>"];
      stack_name: String.t
        [@ocaml.doc "<p>The name associated with a stack.</p>"];
      logical_resource_id: String.t option
        [@ocaml.doc
          "<p>The logical name of the resource specified in the template.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The name or unique identifier associated with the physical instance of the resource.</p>"];
      resource_type: String.t option
        [@ocaml.doc
          "<p>Type of resource. (For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\"> AWS Resource Types Reference</a> in the AWS CloudFormation User Guide.)</p>"];
      timestamp: DateTime.t
        [@ocaml.doc "<p>Time the status was updated.</p>"];
      resource_status: ResourceStatus.t option
        [@ocaml.doc "<p>Current status of the resource.</p>"];
      resource_status_reason: String.t option
        [@ocaml.doc
          "<p>Success/failure message associated with the resource.</p>"];
      resource_properties: String.t option
        [@ocaml.doc
          "<p>BLOB of the properties used to create the resource.</p>"];
      client_request_token: String.t option
        [@ocaml.doc
          "<p>The token passed to the operation that generated this event.</p> <p>All events triggered by a given stack operation are assigned the same client request token, which you can use to track operations. For example, if you execute a <code>CreateStack</code> operation with the token <code>token1</code>, then all the <code>StackEvents</code> generated by that operation will have <code>ClientRequestToken</code> set as <code>token1</code>.</p> <p>In the console, stack operations display the client request token on the Events tab. Stack operations that are initiated from the console use the token format <i>Console-StackOperation-ID</i>, which helps you easily identify the stack operation . For example, if you create a stack using the console, each stack event would be assigned the same token in the following format: <code>Console-CreateStack-7f59c3cf-00d2-40c7-b2ff-e75db0987002</code>. </p>"]}
    [@@ocaml.doc "<p>The StackEvent data type.</p>"]
    let make ~stack_id  ~event_id  ~stack_name  ?logical_resource_id 
      ?physical_resource_id  ?resource_type  ~timestamp  ?resource_status 
      ?resource_status_reason  ?resource_properties  ?client_request_token 
      () =
      {
        stack_id;
        event_id;
        stack_name;
        logical_resource_id;
        physical_resource_id;
        resource_type;
        timestamp;
        resource_status;
        resource_status_reason;
        resource_properties;
        client_request_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.client_request_token
              (fun f -> ("client_request_token", (String.to_json f)));
           Util.option_map v.resource_properties
             (fun f -> ("resource_properties", (String.to_json f)));
           Util.option_map v.resource_status_reason
             (fun f -> ("resource_status_reason", (String.to_json f)));
           Util.option_map v.resource_status
             (fun f -> ("resource_status", (ResourceStatus.to_json f)));
           Some ("timestamp", (DateTime.to_json v.timestamp));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)));
           Util.option_map v.physical_resource_id
             (fun f -> ("physical_resource_id", (String.to_json f)));
           Util.option_map v.logical_resource_id
             (fun f -> ("logical_resource_id", (String.to_json f)));
           Some ("stack_name", (String.to_json v.stack_name));
           Some ("event_id", (String.to_json v.event_id));
           Some ("stack_id", (String.to_json v.stack_id))])
    let parse xml =
      Some
        {
          stack_id =
            (Xml.required "StackId"
               (Util.option_bind (Xml.member "StackId" xml) String.parse));
          event_id =
            (Xml.required "EventId"
               (Util.option_bind (Xml.member "EventId" xml) String.parse));
          stack_name =
            (Xml.required "StackName"
               (Util.option_bind (Xml.member "StackName" xml) String.parse));
          logical_resource_id =
            (Util.option_bind (Xml.member "LogicalResourceId" xml)
               String.parse);
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse);
          resource_type =
            (Util.option_bind (Xml.member "ResourceType" xml) String.parse);
          timestamp =
            (Xml.required "Timestamp"
               (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse));
          resource_status =
            (Util.option_bind (Xml.member "ResourceStatus" xml)
               ResourceStatus.parse);
          resource_status_reason =
            (Util.option_bind (Xml.member "ResourceStatusReason" xml)
               String.parse);
          resource_properties =
            (Util.option_bind (Xml.member "ResourceProperties" xml)
               String.parse);
          client_request_token =
            (Util.option_bind (Xml.member "ClientRequestToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Some
                        (Ezxmlm.make_tag "StackId"
                           ([], (String.to_xml v.stack_id)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "EventId"
                          ([], (String.to_xml v.event_id)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "StackName"
                         ([], (String.to_xml v.stack_name)))])
                  @
                  [Util.option_map v.logical_resource_id
                     (fun f ->
                        Ezxmlm.make_tag "LogicalResourceId"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.physical_resource_id
                    (fun f ->
                       Ezxmlm.make_tag "PhysicalResourceId"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.resource_type
                   (fun f ->
                      Ezxmlm.make_tag "ResourceType" ([], (String.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "Timestamp"
                     ([], (DateTime.to_xml v.timestamp)))])
              @
              [Util.option_map v.resource_status
                 (fun f ->
                    Ezxmlm.make_tag "ResourceStatus"
                      ([], (ResourceStatus.to_xml f)))])
             @
             [Util.option_map v.resource_status_reason
                (fun f ->
                   Ezxmlm.make_tag "ResourceStatusReason"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.resource_properties
               (fun f ->
                  Ezxmlm.make_tag "ResourceProperties"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.client_request_token
              (fun f ->
                 Ezxmlm.make_tag "ClientRequestToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The StackEvent data type.</p>"]
module StackResource =
  struct
    type t =
      {
      stack_name: String.t option
        [@ocaml.doc "<p>The name associated with the stack.</p>"];
      stack_id: String.t option
        [@ocaml.doc "<p>Unique identifier of the stack.</p>"];
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical name of the resource specified in the template.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The name or unique identifier that corresponds to a physical instance ID of a resource supported by AWS CloudFormation.</p>"];
      resource_type: String.t
        [@ocaml.doc
          "<p>Type of resource. (For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\"> AWS Resource Types Reference</a> in the AWS CloudFormation User Guide.)</p>"];
      timestamp: DateTime.t
        [@ocaml.doc "<p>Time the status was updated.</p>"];
      resource_status: ResourceStatus.t
        [@ocaml.doc "<p>Current status of the resource.</p>"];
      resource_status_reason: String.t option
        [@ocaml.doc
          "<p>Success/failure message associated with the resource.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>User defined description associated with the resource.</p>"];
      drift_information: StackResourceDriftInformation.t option
        [@ocaml.doc
          "<p>Information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]}
    [@@ocaml.doc "<p>The StackResource data type.</p>"]
    let make ?stack_name  ?stack_id  ~logical_resource_id 
      ?physical_resource_id  ~resource_type  ~timestamp  ~resource_status 
      ?resource_status_reason  ?description  ?drift_information  () =
      {
        stack_name;
        stack_id;
        logical_resource_id;
        physical_resource_id;
        resource_type;
        timestamp;
        resource_status;
        resource_status_reason;
        description;
        drift_information
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.drift_information
              (fun f ->
                 ("drift_information",
                   (StackResourceDriftInformation.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.resource_status_reason
             (fun f -> ("resource_status_reason", (String.to_json f)));
           Some
             ("resource_status", (ResourceStatus.to_json v.resource_status));
           Some ("timestamp", (DateTime.to_json v.timestamp));
           Some ("resource_type", (String.to_json v.resource_type));
           Util.option_map v.physical_resource_id
             (fun f -> ("physical_resource_id", (String.to_json f)));
           Some
             ("logical_resource_id", (String.to_json v.logical_resource_id));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse));
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse);
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          timestamp =
            (Xml.required "Timestamp"
               (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse));
          resource_status =
            (Xml.required "ResourceStatus"
               (Util.option_bind (Xml.member "ResourceStatus" xml)
                  ResourceStatus.parse));
          resource_status_reason =
            (Util.option_bind (Xml.member "ResourceStatusReason" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          drift_information =
            (Util.option_bind (Xml.member "DriftInformation" xml)
               StackResourceDriftInformation.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.stack_name
                       (fun f ->
                          Ezxmlm.make_tag "StackName" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.stack_id
                      (fun f ->
                         Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "LogicalResourceId"
                        ([], (String.to_xml v.logical_resource_id)))])
                 @
                 [Util.option_map v.physical_resource_id
                    (fun f ->
                       Ezxmlm.make_tag "PhysicalResourceId"
                         ([], (String.to_xml f)))])
                @
                [Some
                   (Ezxmlm.make_tag "ResourceType"
                      ([], (String.to_xml v.resource_type)))])
               @
               [Some
                  (Ezxmlm.make_tag "Timestamp"
                     ([], (DateTime.to_xml v.timestamp)))])
              @
              [Some
                 (Ezxmlm.make_tag "ResourceStatus"
                    ([], (ResourceStatus.to_xml v.resource_status)))])
             @
             [Util.option_map v.resource_status_reason
                (fun f ->
                   Ezxmlm.make_tag "ResourceStatusReason"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           [Util.option_map v.drift_information
              (fun f ->
                 Ezxmlm.make_tag "DriftInformation"
                   ([], (StackResourceDriftInformation.to_xml f)))])
  end[@@ocaml.doc "<p>The StackResource data type.</p>"]
module TypeVersionSummary =
  struct
    type t =
      {
      type_: RegistryType.t option [@ocaml.doc "<p>The kind of type.</p>"];
      type_name: String.t option [@ocaml.doc "<p>The name of the type.</p>"];
      version_id: String.t option
        [@ocaml.doc
          "<p>The ID of a specific version of the type. The version ID is the value at the end of the Amazon Resource Name (ARN) assigned to the type version when it is registered.</p>"];
      arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the type version.</p>"];
      time_created: DateTime.t option
        [@ocaml.doc "<p>When the version was registered.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the type version.</p>"]}[@@ocaml.doc
                                                                    "<p>Contains summary information about a specific version of a CloudFormation type.</p>"]
    let make ?type_  ?type_name  ?version_id  ?arn  ?time_created 
      ?description  () =
      { type_; type_name; version_id; arn; time_created; description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.time_created
             (fun f -> ("time_created", (DateTime.to_json f)));
           Util.option_map v.arn (fun f -> ("arn", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (RegistryType.to_json f)))])
    let parse xml =
      Some
        {
          type_ =
            (Util.option_bind (Xml.member "Type" xml) RegistryType.parse);
          type_name =
            (Util.option_bind (Xml.member "TypeName" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse);
          arn = (Util.option_bind (Xml.member "Arn" xml) String.parse);
          time_created =
            (Util.option_bind (Xml.member "TimeCreated" xml) DateTime.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.type_
                   (fun f ->
                      Ezxmlm.make_tag "Type" ([], (RegistryType.to_xml f)))])
               @
               [Util.option_map v.type_name
                  (fun f ->
                     Ezxmlm.make_tag "TypeName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.version_id
                 (fun f ->
                    Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.arn
                (fun f -> Ezxmlm.make_tag "Arn" ([], (String.to_xml f)))])
            @
            [Util.option_map v.time_created
               (fun f ->
                  Ezxmlm.make_tag "TimeCreated" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains summary information about a specific version of a CloudFormation type.</p>"]
module TemplateStage =
  struct
    type t =
      | Original 
      | Processed 
    let str_to_t = [("Processed", Processed); ("Original", Original)]
    let t_to_str = [(Processed, "Processed"); (Original, "Original")]
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
module StackSetOperationSummary =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc "<p>The unique ID of the stack set operation.</p>"];
      action: StackSetOperationAction.t option
        [@ocaml.doc
          "<p>The type of operation: <code>CREATE</code>, <code>UPDATE</code>, or <code>DELETE</code>. Create and delete operations affect only the specified stack instances that are associated with the specified stack set. Update operations affect both the stack set itself as well as <i>all</i> associated stack set instances.</p>"];
      status: StackSetOperationStatus.t option
        [@ocaml.doc
          "<p>The overall status of the operation.</p> <ul> <li> <p> <code>FAILED</code>: The operation exceeded the specified failure tolerance. The failure tolerance value that you've set for an operation is applied for each region during stack create and update operations. If the number of failed stacks within a region exceeds the failure tolerance, the status of the operation in the region is set to <code>FAILED</code>. This in turn sets the status of the operation as a whole to <code>FAILED</code>, and AWS CloudFormation cancels the operation in any remaining regions.</p> </li> <li> <p> <code>RUNNING</code>: The operation is currently being performed.</p> </li> <li> <p> <code>STOPPED</code>: The user has cancelled the operation.</p> </li> <li> <p> <code>STOPPING</code>: The operation is in the process of stopping, at user request. </p> </li> <li> <p> <code>SUCCEEDED</code>: The operation completed creating or updating all the specified stacks without exceeding the failure tolerance for the operation.</p> </li> </ul>"];
      creation_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time at which the operation was initiated. Note that the creation times for the stack set operation might differ from the creation time of the individual stacks themselves. This is because AWS CloudFormation needs to perform preparatory work for the operation, such as dispatching the work to the requested regions, before actually creating the first stacks.</p>"];
      end_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time at which the stack set operation ended, across all accounts and regions specified. Note that this doesn't necessarily mean that the stack set operation was successful, or even attempted, in each account or region.</p>"]}
    [@@ocaml.doc
      "<p>The structures that contain summary information about the specified operation.</p>"]
    let make ?operation_id  ?action  ?status  ?creation_timestamp 
      ?end_timestamp  () =
      { operation_id; action; status; creation_timestamp; end_timestamp }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_timestamp
              (fun f -> ("end_timestamp", (DateTime.to_json f)));
           Util.option_map v.creation_timestamp
             (fun f -> ("creation_timestamp", (DateTime.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackSetOperationStatus.to_json f)));
           Util.option_map v.action
             (fun f -> ("action", (StackSetOperationAction.to_json f)));
           Util.option_map v.operation_id
             (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse);
          action =
            (Util.option_bind (Xml.member "Action" xml)
               StackSetOperationAction.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               StackSetOperationStatus.parse);
          creation_timestamp =
            (Util.option_bind (Xml.member "CreationTimestamp" xml)
               DateTime.parse);
          end_timestamp =
            (Util.option_bind (Xml.member "EndTimestamp" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.operation_id
                  (fun f ->
                     Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.action
                 (fun f ->
                    Ezxmlm.make_tag "Action"
                      ([], (StackSetOperationAction.to_xml f)))])
             @
             [Util.option_map v.status
                (fun f ->
                   Ezxmlm.make_tag "Status"
                     ([], (StackSetOperationStatus.to_xml f)))])
            @
            [Util.option_map v.creation_timestamp
               (fun f ->
                  Ezxmlm.make_tag "CreationTimestamp"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.end_timestamp
              (fun f ->
                 Ezxmlm.make_tag "EndTimestamp" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>The structures that contain summary information about the specified operation.</p>"]
module StackResourceDriftStatusFilters =
  struct
    type t = StackResourceDriftStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackResourceDriftStatus.to_query v
    let to_headers v =
      Headers.to_headers_list StackResourceDriftStatus.to_headers v
    let to_json v = `List (List.map StackResourceDriftStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackResourceDriftStatus.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (StackResourceDriftStatus.to_xml x)))
        v
  end
module DeprecatedStatus =
  struct
    type t =
      | LIVE 
      | DEPRECATED 
    let str_to_t = [("DEPRECATED", DEPRECATED); ("LIVE", LIVE)]
    let t_to_str = [(DEPRECATED, "DEPRECATED"); (LIVE, "LIVE")]
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
module StackResourceSummaries =
  struct
    type t = StackResourceSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackResourceSummary.to_query v
    let to_headers v =
      Headers.to_headers_list StackResourceSummary.to_headers v
    let to_json v = `List (List.map StackResourceSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackResourceSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (StackResourceSummary.to_xml x))) v
  end
module StackSetOperationResultSummaries =
  struct
    type t = StackSetOperationResultSummary.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list StackSetOperationResultSummary.to_query v
    let to_headers v =
      Headers.to_headers_list StackSetOperationResultSummary.to_headers v
    let to_json v = `List (List.map StackSetOperationResultSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackSetOperationResultSummary.parse
           (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (StackSetOperationResultSummary.to_xml x))) v
  end
module AccountLimitList =
  struct
    type t = AccountLimit.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AccountLimit.to_query v
    let to_headers v = Headers.to_headers_list AccountLimit.to_headers v
    let to_json v = `List (List.map AccountLimit.to_json v)
    let parse xml =
      Util.option_all
        (List.map AccountLimit.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AccountLimit.to_xml x))) v
  end
module RegistrationStatus =
  struct
    type t =
      | COMPLETE 
      | IN_PROGRESS 
      | FAILED 
    let str_to_t =
      [("FAILED", FAILED);
      ("IN_PROGRESS", IN_PROGRESS);
      ("COMPLETE", COMPLETE)]
    let t_to_str =
      [(FAILED, "FAILED");
      (IN_PROGRESS, "IN_PROGRESS");
      (COMPLETE, "COMPLETE")]
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
module HandlerErrorCode =
  struct
    type t =
      | NotUpdatable 
      | InvalidRequest 
      | AccessDenied 
      | InvalidCredentials 
      | AlreadyExists 
      | NotFound 
      | ResourceConflict 
      | Throttling 
      | ServiceLimitExceeded 
      | NotStabilized 
      | GeneralServiceException 
      | ServiceInternalError 
      | NetworkFailure 
      | InternalFailure 
    let str_to_t =
      [("InternalFailure", InternalFailure);
      ("NetworkFailure", NetworkFailure);
      ("ServiceInternalError", ServiceInternalError);
      ("GeneralServiceException", GeneralServiceException);
      ("NotStabilized", NotStabilized);
      ("ServiceLimitExceeded", ServiceLimitExceeded);
      ("Throttling", Throttling);
      ("ResourceConflict", ResourceConflict);
      ("NotFound", NotFound);
      ("AlreadyExists", AlreadyExists);
      ("InvalidCredentials", InvalidCredentials);
      ("AccessDenied", AccessDenied);
      ("InvalidRequest", InvalidRequest);
      ("NotUpdatable", NotUpdatable)]
    let t_to_str =
      [(InternalFailure, "InternalFailure");
      (NetworkFailure, "NetworkFailure");
      (ServiceInternalError, "ServiceInternalError");
      (GeneralServiceException, "GeneralServiceException");
      (NotStabilized, "NotStabilized");
      (ServiceLimitExceeded, "ServiceLimitExceeded");
      (Throttling, "Throttling");
      (ResourceConflict, "ResourceConflict");
      (NotFound, "NotFound");
      (AlreadyExists, "AlreadyExists");
      (InvalidCredentials, "InvalidCredentials");
      (AccessDenied, "AccessDenied");
      (InvalidRequest, "InvalidRequest");
      (NotUpdatable, "NotUpdatable")]
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
module OperationStatus =
  struct
    type t =
      | PENDING 
      | IN_PROGRESS 
      | SUCCESS 
      | FAILED 
    let str_to_t =
      [("FAILED", FAILED);
      ("SUCCESS", SUCCESS);
      ("IN_PROGRESS", IN_PROGRESS);
      ("PENDING", PENDING)]
    let t_to_str =
      [(FAILED, "FAILED");
      (SUCCESS, "SUCCESS");
      (IN_PROGRESS, "IN_PROGRESS");
      (PENDING, "PENDING")]
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
module StackSummaries =
  struct
    type t = StackSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackSummary.to_query v
    let to_headers v = Headers.to_headers_list StackSummary.to_headers v
    let to_json v = `List (List.map StackSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StackSummary.to_xml x))) v
  end
module StackResourceDrifts =
  struct
    type t = StackResourceDrift.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackResourceDrift.to_query v
    let to_headers v =
      Headers.to_headers_list StackResourceDrift.to_headers v
    let to_json v = `List (List.map StackResourceDrift.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackResourceDrift.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (StackResourceDrift.to_xml x))) v
  end
module StackStatusFilter =
  struct
    type t = StackStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackStatus.to_query v
    let to_headers v = Headers.to_headers_list StackStatus.to_headers v
    let to_json v = `List (List.map StackStatus.to_json v)
    let parse xml =
      Util.option_all (List.map StackStatus.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StackStatus.to_xml x))) v
  end
module Changes =
  struct
    type t = Change.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Change.to_query v
    let to_headers v = Headers.to_headers_list Change.to_headers v
    let to_json v = `List (List.map Change.to_json v)
    let parse xml =
      Util.option_all (List.map Change.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Change.to_xml x))) v
  end
module LoggingConfig =
  struct
    type t =
      {
      log_role_arn: String.t
        [@ocaml.doc
          "<p>The ARN of the role that CloudFormation should assume when sending log entries to CloudWatch logs.</p>"];
      log_group_name: String.t
        [@ocaml.doc
          "<p>The Amazon CloudWatch log group to which CloudFormation sends error logging information when invoking the type's handlers.</p>"]}
    [@@ocaml.doc
      "<p>Contains logging configuration information for a type.</p>"]
    let make ~log_role_arn  ~log_group_name  () =
      { log_role_arn; log_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("log_group_name", (String.to_json v.log_group_name));
           Some ("log_role_arn", (String.to_json v.log_role_arn))])
    let parse xml =
      Some
        {
          log_role_arn =
            (Xml.required "LogRoleArn"
               (Util.option_bind (Xml.member "LogRoleArn" xml) String.parse));
          log_group_name =
            (Xml.required "LogGroupName"
               (Util.option_bind (Xml.member "LogGroupName" xml) String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "LogRoleArn"
                  ([], (String.to_xml v.log_role_arn)))])
           @
           [Some
              (Ezxmlm.make_tag "LogGroupName"
                 ([], (String.to_xml v.log_group_name)))])
  end[@@ocaml.doc
       "<p>Contains logging configuration information for a type.</p>"]
module ProvisioningType =
  struct
    type t =
      | NON_PROVISIONABLE 
      | IMMUTABLE 
      | FULLY_MUTABLE 
    let str_to_t =
      [("FULLY_MUTABLE", FULLY_MUTABLE);
      ("IMMUTABLE", IMMUTABLE);
      ("NON_PROVISIONABLE", NON_PROVISIONABLE)]
    let t_to_str =
      [(FULLY_MUTABLE, "FULLY_MUTABLE");
      (IMMUTABLE, "IMMUTABLE");
      (NON_PROVISIONABLE, "NON_PROVISIONABLE")]
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
module Visibility =
  struct
    type t =
      | PUBLIC 
      | PRIVATE 
    let str_to_t = [("PRIVATE", PRIVATE); ("PUBLIC", PUBLIC)]
    let t_to_str = [(PRIVATE, "PRIVATE"); (PUBLIC, "PUBLIC")]
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
module ChangeSetSummaries =
  struct
    type t = ChangeSetSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ChangeSetSummary.to_query v
    let to_headers v = Headers.to_headers_list ChangeSetSummary.to_headers v
    let to_json v = `List (List.map ChangeSetSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map ChangeSetSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ChangeSetSummary.to_xml x)))
        v
  end
module Exports =
  struct
    type t = Export.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Export.to_query v
    let to_headers v = Headers.to_headers_list Export.to_headers v
    let to_json v = `List (List.map Export.to_json v)
    let parse xml =
      Util.option_all (List.map Export.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Export.to_xml x))) v
  end
module ResourceSignalStatus =
  struct
    type t =
      | SUCCESS 
      | FAILURE 
    let str_to_t = [("FAILURE", FAILURE); ("SUCCESS", SUCCESS)]
    let t_to_str = [(FAILURE, "FAILURE"); (SUCCESS, "SUCCESS")]
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
module RetainResources =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module AccountList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ParameterDeclarations =
  struct
    type t = ParameterDeclaration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParameterDeclaration.to_query v
    let to_headers v =
      Headers.to_headers_list ParameterDeclaration.to_headers v
    let to_json v = `List (List.map ParameterDeclaration.to_json v)
    let parse xml =
      Util.option_all
        (List.map ParameterDeclaration.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ParameterDeclaration.to_xml x))) v
  end
module ResourceIdentifierSummaries =
  struct
    type t = ResourceIdentifierSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceIdentifierSummary.to_query v
    let to_headers v =
      Headers.to_headers_list ResourceIdentifierSummary.to_headers v
    let to_json v = `List (List.map ResourceIdentifierSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceIdentifierSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ResourceIdentifierSummary.to_xml x))) v
  end
module ResourceTypes =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module TransformsList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ChangeSetType =
  struct
    type t =
      | CREATE 
      | UPDATE 
      | IMPORT 
    let str_to_t =
      [("IMPORT", IMPORT); ("UPDATE", UPDATE); ("CREATE", CREATE)]
    let t_to_str =
      [(IMPORT, "IMPORT"); (UPDATE, "UPDATE"); (CREATE, "CREATE")]
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
module ResourcesToImport =
  struct
    type t = ResourceToImport.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceToImport.to_query v
    let to_headers v = Headers.to_headers_list ResourceToImport.to_headers v
    let to_json v = `List (List.map ResourceToImport.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourceToImport.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ResourceToImport.to_xml x)))
        v
  end
module ResourcesToSkip =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module TemplateParameters =
  struct
    type t = TemplateParameter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TemplateParameter.to_query v
    let to_headers v = Headers.to_headers_list TemplateParameter.to_headers v
    let to_json v = `List (List.map TemplateParameter.to_json v)
    let parse xml =
      Util.option_all
        (List.map TemplateParameter.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TemplateParameter.to_xml x)))
        v
  end
module StackInstance =
  struct
    type t =
      {
      stack_set_id: String.t option
        [@ocaml.doc
          "<p>The name or unique ID of the stack set that the stack instance is associated with.</p>"];
      region: String.t option
        [@ocaml.doc
          "<p>The name of the AWS region that the stack instance is associated with.</p>"];
      account: String.t option
        [@ocaml.doc
          "<p>The name of the AWS account that the stack instance is associated with.</p>"];
      stack_id: String.t option
        [@ocaml.doc "<p>The ID of the stack instance.</p>"];
      parameter_overrides: Parameters.t
        [@ocaml.doc
          "<p>A list of parameters from the stack set template whose values have been overridden in this stack instance.</p>"];
      status: StackInstanceStatus.t option
        [@ocaml.doc
          "<p>The status of the stack instance, in terms of its synchronization with its associated stack set.</p> <ul> <li> <p> <code>INOPERABLE</code>: A <code>DeleteStackInstances</code> operation has failed and left the stack in an unstable state. Stacks in this state are excluded from further <code>UpdateStackSet</code> operations. You might need to perform a <code>DeleteStackInstances</code> operation, with <code>RetainStacks</code> set to <code>true</code>, to delete the stack instance, and then delete the stack manually.</p> </li> <li> <p> <code>OUTDATED</code>: The stack isn't currently up to date with the stack set because:</p> <ul> <li> <p>The associated stack failed during a <code>CreateStackSet</code> or <code>UpdateStackSet</code> operation. </p> </li> <li> <p>The stack was part of a <code>CreateStackSet</code> or <code>UpdateStackSet</code> operation that failed or was stopped before the stack was created or updated. </p> </li> </ul> </li> <li> <p> <code>CURRENT</code>: The stack is currently up to date with the stack set.</p> </li> </ul>"];
      status_reason: String.t option
        [@ocaml.doc
          "<p>The explanation for the specific status code that is assigned to this stack instance.</p>"];
      drift_status: StackDriftStatus.t option
        [@ocaml.doc
          "<p>Status of the stack instance's actual configuration compared to the expected template and parameter configuration of the stack set to which it belongs. </p> <ul> <li> <p> <code>DRIFTED</code>: The stack differs from the expected template and parameter configuration of the stack set to which it belongs. A stack instance is considered to have drifted if one or more of the resources in the associated stack have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the stack instance differs from its expected stack set configuration.</p> </li> <li> <p> <code>IN_SYNC</code>: The stack instance's actual configuration matches its expected stack set configuration.</p> </li> <li> <p> <code>UNKNOWN</code>: This value is reserved for future use.</p> </li> </ul>"];
      last_drift_check_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>Most recent time when CloudFormation performed a drift detection operation on the stack instance. This value will be <code>NULL</code> for any stack instance on which drift detection has not yet been performed.</p>"]}
    [@@ocaml.doc
      "<p>An AWS CloudFormation stack, in a specific account and region, that's part of a stack set operation. A stack instance is a reference to an attempted or actual stack in a given account within a given region. A stack instance can exist without a stack\226\128\148for example, if the stack couldn't be created for some reason. A stack instance is associated with only one stack set. Each stack instance contains the ID of its associated stack set, as well as the ID of the actual stack and the stack status.</p>"]
    let make ?stack_set_id  ?region  ?account  ?stack_id 
      ?(parameter_overrides= [])  ?status  ?status_reason  ?drift_status 
      ?last_drift_check_timestamp  () =
      {
        stack_set_id;
        region;
        account;
        stack_id;
        parameter_overrides;
        status;
        status_reason;
        drift_status;
        last_drift_check_timestamp
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_drift_check_timestamp
              (fun f -> ("last_drift_check_timestamp", (DateTime.to_json f)));
           Util.option_map v.drift_status
             (fun f -> ("drift_status", (StackDriftStatus.to_json f)));
           Util.option_map v.status_reason
             (fun f -> ("status_reason", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackInstanceStatus.to_json f)));
           Some
             ("parameter_overrides",
               (Parameters.to_json v.parameter_overrides));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)));
           Util.option_map v.account
             (fun f -> ("account", (String.to_json f)));
           Util.option_map v.region (fun f -> ("region", (String.to_json f)));
           Util.option_map v.stack_set_id
             (fun f -> ("stack_set_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_set_id =
            (Util.option_bind (Xml.member "StackSetId" xml) String.parse);
          region = (Util.option_bind (Xml.member "Region" xml) String.parse);
          account =
            (Util.option_bind (Xml.member "Account" xml) String.parse);
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          parameter_overrides =
            (Util.of_option []
               (Util.option_bind (Xml.member "ParameterOverrides" xml)
                  Parameters.parse));
          status =
            (Util.option_bind (Xml.member "Status" xml)
               StackInstanceStatus.parse);
          status_reason =
            (Util.option_bind (Xml.member "StatusReason" xml) String.parse);
          drift_status =
            (Util.option_bind (Xml.member "DriftStatus" xml)
               StackDriftStatus.parse);
          last_drift_check_timestamp =
            (Util.option_bind (Xml.member "LastDriftCheckTimestamp" xml)
               DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.stack_set_id
                      (fun f ->
                         Ezxmlm.make_tag "StackSetId" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.region
                     (fun f ->
                        Ezxmlm.make_tag "Region" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.account
                    (fun f ->
                       Ezxmlm.make_tag "Account" ([], (String.to_xml f)))])
                @
                [Util.option_map v.stack_id
                   (fun f ->
                      Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ParameterOverrides"
                          ([], (Parameters.to_xml [x]))))
                  v.parameter_overrides))
              @
              [Util.option_map v.status
                 (fun f ->
                    Ezxmlm.make_tag "Status"
                      ([], (StackInstanceStatus.to_xml f)))])
             @
             [Util.option_map v.status_reason
                (fun f ->
                   Ezxmlm.make_tag "StatusReason" ([], (String.to_xml f)))])
            @
            [Util.option_map v.drift_status
               (fun f ->
                  Ezxmlm.make_tag "DriftStatus"
                    ([], (StackDriftStatus.to_xml f)))])
           @
           [Util.option_map v.last_drift_check_timestamp
              (fun f ->
                 Ezxmlm.make_tag "LastDriftCheckTimestamp"
                   ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>An AWS CloudFormation stack, in a specific account and region, that's part of a stack set operation. A stack instance is a reference to an attempted or actual stack in a given account within a given region. A stack instance can exist without a stack\226\128\148for example, if the stack couldn't be created for some reason. A stack instance is associated with only one stack set. Each stack instance contains the ID of its associated stack set, as well as the ID of the actual stack and the stack status.</p>"]
module StackSetSummaries =
  struct
    type t = StackSetSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackSetSummary.to_query v
    let to_headers v = Headers.to_headers_list StackSetSummary.to_headers v
    let to_json v = `List (List.map StackSetSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackSetSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StackSetSummary.to_xml x)))
        v
  end
module StackInstanceSummaries =
  struct
    type t = StackInstanceSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackInstanceSummary.to_query v
    let to_headers v =
      Headers.to_headers_list StackInstanceSummary.to_headers v
    let to_json v = `List (List.map StackInstanceSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackInstanceSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (StackInstanceSummary.to_xml x))) v
  end
module TypeSummaries =
  struct
    type t = TypeSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TypeSummary.to_query v
    let to_headers v = Headers.to_headers_list TypeSummary.to_headers v
    let to_json v = `List (List.map TypeSummary.to_json v)
    let parse xml =
      Util.option_all (List.map TypeSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TypeSummary.to_xml x))) v
  end
module Stacks =
  struct
    type t = Stack.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Stack.to_query v
    let to_headers v = Headers.to_headers_list Stack.to_headers v
    let to_json v = `List (List.map Stack.to_json v)
    let parse xml =
      Util.option_all (List.map Stack.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Stack.to_xml x))) v
  end
module StackResourceDetail =
  struct
    type t =
      {
      stack_name: String.t option
        [@ocaml.doc "<p>The name associated with the stack.</p>"];
      stack_id: String.t option
        [@ocaml.doc "<p>Unique identifier of the stack.</p>"];
      logical_resource_id: String.t
        [@ocaml.doc
          "<p>The logical name of the resource specified in the template.</p>"];
      physical_resource_id: String.t option
        [@ocaml.doc
          "<p>The name or unique identifier that corresponds to a physical instance ID of a resource supported by AWS CloudFormation.</p>"];
      resource_type: String.t
        [@ocaml.doc
          "<p>Type of resource. ((For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\"> AWS Resource Types Reference</a> in the AWS CloudFormation User Guide.)</p>"];
      last_updated_timestamp: DateTime.t
        [@ocaml.doc "<p>Time the status was updated.</p>"];
      resource_status: ResourceStatus.t
        [@ocaml.doc "<p>Current status of the resource.</p>"];
      resource_status_reason: String.t option
        [@ocaml.doc
          "<p>Success/failure message associated with the resource.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>User defined description associated with the resource.</p>"];
      metadata: String.t option
        [@ocaml.doc
          "<p>The content of the <code>Metadata</code> attribute declared for the resource. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-metadata.html\">Metadata Attribute</a> in the AWS CloudFormation User Guide.</p>"];
      drift_information: StackResourceDriftInformation.t option
        [@ocaml.doc
          "<p>Information about whether the resource's actual configuration differs, or has <i>drifted</i>, from its expected configuration, as defined in the stack template and any values specified as template parameters. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift.html\">Detecting Unregulated Configuration Changes to Stacks and Resources</a>.</p>"]}
    [@@ocaml.doc
      "<p>Contains detailed information about the specified stack resource.</p>"]
    let make ?stack_name  ?stack_id  ~logical_resource_id 
      ?physical_resource_id  ~resource_type  ~last_updated_timestamp 
      ~resource_status  ?resource_status_reason  ?description  ?metadata 
      ?drift_information  () =
      {
        stack_name;
        stack_id;
        logical_resource_id;
        physical_resource_id;
        resource_type;
        last_updated_timestamp;
        resource_status;
        resource_status_reason;
        description;
        metadata;
        drift_information
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.drift_information
              (fun f ->
                 ("drift_information",
                   (StackResourceDriftInformation.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.resource_status_reason
             (fun f -> ("resource_status_reason", (String.to_json f)));
           Some
             ("resource_status", (ResourceStatus.to_json v.resource_status));
           Some
             ("last_updated_timestamp",
               (DateTime.to_json v.last_updated_timestamp));
           Some ("resource_type", (String.to_json v.resource_type));
           Util.option_map v.physical_resource_id
             (fun f -> ("physical_resource_id", (String.to_json f)));
           Some
             ("logical_resource_id", (String.to_json v.logical_resource_id));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          logical_resource_id =
            (Xml.required "LogicalResourceId"
               (Util.option_bind (Xml.member "LogicalResourceId" xml)
                  String.parse));
          physical_resource_id =
            (Util.option_bind (Xml.member "PhysicalResourceId" xml)
               String.parse);
          resource_type =
            (Xml.required "ResourceType"
               (Util.option_bind (Xml.member "ResourceType" xml) String.parse));
          last_updated_timestamp =
            (Xml.required "LastUpdatedTimestamp"
               (Util.option_bind (Xml.member "LastUpdatedTimestamp" xml)
                  DateTime.parse));
          resource_status =
            (Xml.required "ResourceStatus"
               (Util.option_bind (Xml.member "ResourceStatus" xml)
                  ResourceStatus.parse));
          resource_status_reason =
            (Util.option_bind (Xml.member "ResourceStatusReason" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          metadata =
            (Util.option_bind (Xml.member "Metadata" xml) String.parse);
          drift_information =
            (Util.option_bind (Xml.member "DriftInformation" xml)
               StackResourceDriftInformation.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.stack_name
                        (fun f ->
                           Ezxmlm.make_tag "StackName"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.stack_id
                       (fun f ->
                          Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "LogicalResourceId"
                         ([], (String.to_xml v.logical_resource_id)))])
                  @
                  [Util.option_map v.physical_resource_id
                     (fun f ->
                        Ezxmlm.make_tag "PhysicalResourceId"
                          ([], (String.to_xml f)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "ResourceType"
                       ([], (String.to_xml v.resource_type)))])
                @
                [Some
                   (Ezxmlm.make_tag "LastUpdatedTimestamp"
                      ([], (DateTime.to_xml v.last_updated_timestamp)))])
               @
               [Some
                  (Ezxmlm.make_tag "ResourceStatus"
                     ([], (ResourceStatus.to_xml v.resource_status)))])
              @
              [Util.option_map v.resource_status_reason
                 (fun f ->
                    Ezxmlm.make_tag "ResourceStatusReason"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.metadata
               (fun f -> Ezxmlm.make_tag "Metadata" ([], (String.to_xml f)))])
           @
           [Util.option_map v.drift_information
              (fun f ->
                 Ezxmlm.make_tag "DriftInformation"
                   ([], (StackResourceDriftInformation.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains detailed information about the specified stack resource.</p>"]
module StackDriftDetectionStatus =
  struct
    type t =
      | DETECTION_IN_PROGRESS 
      | DETECTION_FAILED 
      | DETECTION_COMPLETE 
    let str_to_t =
      [("DETECTION_COMPLETE", DETECTION_COMPLETE);
      ("DETECTION_FAILED", DETECTION_FAILED);
      ("DETECTION_IN_PROGRESS", DETECTION_IN_PROGRESS)]
    let t_to_str =
      [(DETECTION_COMPLETE, "DETECTION_COMPLETE");
      (DETECTION_FAILED, "DETECTION_FAILED");
      (DETECTION_IN_PROGRESS, "DETECTION_IN_PROGRESS")]
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
module OnFailure =
  struct
    type t =
      | DO_NOTHING 
      | ROLLBACK 
      | DELETE 
    let str_to_t =
      [("DELETE", DELETE);
      ("ROLLBACK", ROLLBACK);
      ("DO_NOTHING", DO_NOTHING)]
    let t_to_str =
      [(DELETE, "DELETE");
      (ROLLBACK, "ROLLBACK");
      (DO_NOTHING, "DO_NOTHING")]
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
module RegistrationTokenList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module StackSetOperation =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc "<p>The unique ID of a stack set operation.</p>"];
      stack_set_id: String.t option
        [@ocaml.doc "<p>The ID of the stack set.</p>"];
      action: StackSetOperationAction.t option
        [@ocaml.doc
          "<p>The type of stack set operation: <code>CREATE</code>, <code>UPDATE</code>, or <code>DELETE</code>. Create and delete operations affect only the specified stack set instances that are associated with the specified stack set. Update operations affect both the stack set itself, as well as <i>all</i> associated stack set instances.</p>"];
      status: StackSetOperationStatus.t option
        [@ocaml.doc
          "<p>The status of the operation. </p> <ul> <li> <p> <code>FAILED</code>: The operation exceeded the specified failure tolerance. The failure tolerance value that you've set for an operation is applied for each region during stack create and update operations. If the number of failed stacks within a region exceeds the failure tolerance, the status of the operation in the region is set to <code>FAILED</code>. This in turn sets the status of the operation as a whole to <code>FAILED</code>, and AWS CloudFormation cancels the operation in any remaining regions.</p> </li> <li> <p> <code>RUNNING</code>: The operation is currently being performed.</p> </li> <li> <p> <code>STOPPED</code>: The user has cancelled the operation.</p> </li> <li> <p> <code>STOPPING</code>: The operation is in the process of stopping, at user request. </p> </li> <li> <p> <code>SUCCEEDED</code>: The operation completed creating or updating all the specified stacks without exceeding the failure tolerance for the operation.</p> </li> </ul>"];
      operation_preferences: StackSetOperationPreferences.t option
        [@ocaml.doc
          "<p>The preferences for how AWS CloudFormation performs this stack set operation.</p>"];
      retain_stacks: Boolean.t option
        [@ocaml.doc
          "<p>For stack set operations of action type <code>DELETE</code>, specifies whether to remove the stack instances from the specified stack set, but doesn't delete the stacks. You can't reassociate a retained stack, or add an existing, saved stack to a new stack set.</p>"];
      administration_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Number (ARN) of the IAM role used to perform this stack set operation. </p> <p>Use customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html\">Define Permissions for Multiple Administrators</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      execution_role_name: String.t option
        [@ocaml.doc
          "<p>The name of the IAM execution role used to create or update the stack set.</p> <p>Use customized execution roles to control which stack resources users and groups can include in their stack sets. </p>"];
      creation_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time at which the operation was initiated. Note that the creation times for the stack set operation might differ from the creation time of the individual stacks themselves. This is because AWS CloudFormation needs to perform preparatory work for the operation, such as dispatching the work to the requested regions, before actually creating the first stacks.</p>"];
      end_timestamp: DateTime.t option
        [@ocaml.doc
          "<p>The time at which the stack set operation ended, across all accounts and regions specified. Note that this doesn't necessarily mean that the stack set operation was successful, or even attempted, in each account or region.</p>"];
      stack_set_drift_detection_details:
        StackSetDriftDetectionDetails.t option
        [@ocaml.doc
          "<p>Detailed information about the drift status of the stack set. This includes information about drift operations currently being performed on the stack set.</p> <p>this information will only be present for stack set operations whose <code>Action</code> type is <code>DETECT_DRIFT</code>.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-drift.html\">Detecting Unmanaged Changes in Stack Sets</a> in the AWS CloudFormation User Guide.</p>"]}
    [@@ocaml.doc
      "<p>The structure that contains information about a stack set operation. </p>"]
    let make ?operation_id  ?stack_set_id  ?action  ?status 
      ?operation_preferences  ?retain_stacks  ?administration_role_a_r_n 
      ?execution_role_name  ?creation_timestamp  ?end_timestamp 
      ?stack_set_drift_detection_details  () =
      {
        operation_id;
        stack_set_id;
        action;
        status;
        operation_preferences;
        retain_stacks;
        administration_role_a_r_n;
        execution_role_name;
        creation_timestamp;
        end_timestamp;
        stack_set_drift_detection_details
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_set_drift_detection_details
              (fun f ->
                 ("stack_set_drift_detection_details",
                   (StackSetDriftDetectionDetails.to_json f)));
           Util.option_map v.end_timestamp
             (fun f -> ("end_timestamp", (DateTime.to_json f)));
           Util.option_map v.creation_timestamp
             (fun f -> ("creation_timestamp", (DateTime.to_json f)));
           Util.option_map v.execution_role_name
             (fun f -> ("execution_role_name", (String.to_json f)));
           Util.option_map v.administration_role_a_r_n
             (fun f -> ("administration_role_a_r_n", (String.to_json f)));
           Util.option_map v.retain_stacks
             (fun f -> ("retain_stacks", (Boolean.to_json f)));
           Util.option_map v.operation_preferences
             (fun f ->
                ("operation_preferences",
                  (StackSetOperationPreferences.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackSetOperationStatus.to_json f)));
           Util.option_map v.action
             (fun f -> ("action", (StackSetOperationAction.to_json f)));
           Util.option_map v.stack_set_id
             (fun f -> ("stack_set_id", (String.to_json f)));
           Util.option_map v.operation_id
             (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse);
          stack_set_id =
            (Util.option_bind (Xml.member "StackSetId" xml) String.parse);
          action =
            (Util.option_bind (Xml.member "Action" xml)
               StackSetOperationAction.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               StackSetOperationStatus.parse);
          operation_preferences =
            (Util.option_bind (Xml.member "OperationPreferences" xml)
               StackSetOperationPreferences.parse);
          retain_stacks =
            (Util.option_bind (Xml.member "RetainStacks" xml) Boolean.parse);
          administration_role_a_r_n =
            (Util.option_bind (Xml.member "AdministrationRoleARN" xml)
               String.parse);
          execution_role_name =
            (Util.option_bind (Xml.member "ExecutionRoleName" xml)
               String.parse);
          creation_timestamp =
            (Util.option_bind (Xml.member "CreationTimestamp" xml)
               DateTime.parse);
          end_timestamp =
            (Util.option_bind (Xml.member "EndTimestamp" xml) DateTime.parse);
          stack_set_drift_detection_details =
            (Util.option_bind
               (Xml.member "StackSetDriftDetectionDetails" xml)
               StackSetDriftDetectionDetails.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.operation_id
                        (fun f ->
                           Ezxmlm.make_tag "OperationId"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.stack_set_id
                       (fun f ->
                          Ezxmlm.make_tag "StackSetId"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.action
                      (fun f ->
                         Ezxmlm.make_tag "Action"
                           ([], (StackSetOperationAction.to_xml f)))])
                  @
                  [Util.option_map v.status
                     (fun f ->
                        Ezxmlm.make_tag "Status"
                          ([], (StackSetOperationStatus.to_xml f)))])
                 @
                 [Util.option_map v.operation_preferences
                    (fun f ->
                       Ezxmlm.make_tag "OperationPreferences"
                         ([], (StackSetOperationPreferences.to_xml f)))])
                @
                [Util.option_map v.retain_stacks
                   (fun f ->
                      Ezxmlm.make_tag "RetainStacks" ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.administration_role_a_r_n
                  (fun f ->
                     Ezxmlm.make_tag "AdministrationRoleARN"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.execution_role_name
                 (fun f ->
                    Ezxmlm.make_tag "ExecutionRoleName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.creation_timestamp
                (fun f ->
                   Ezxmlm.make_tag "CreationTimestamp"
                     ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.end_timestamp
               (fun f ->
                  Ezxmlm.make_tag "EndTimestamp" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.stack_set_drift_detection_details
              (fun f ->
                 Ezxmlm.make_tag "StackSetDriftDetectionDetails"
                   ([], (StackSetDriftDetectionDetails.to_xml f)))])
  end[@@ocaml.doc
       "<p>The structure that contains information about a stack set operation. </p>"]
module StackEvents =
  struct
    type t = StackEvent.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackEvent.to_query v
    let to_headers v = Headers.to_headers_list StackEvent.to_headers v
    let to_json v = `List (List.map StackEvent.to_json v)
    let parse xml =
      Util.option_all (List.map StackEvent.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StackEvent.to_xml x))) v
  end
module StackResources =
  struct
    type t = StackResource.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackResource.to_query v
    let to_headers v = Headers.to_headers_list StackResource.to_headers v
    let to_json v = `List (List.map StackResource.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackResource.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (StackResource.to_xml x))) v
  end
module StackSet =
  struct
    type t =
      {
      stack_set_name: String.t option
        [@ocaml.doc "<p>The name that's associated with the stack set.</p>"];
      stack_set_id: String.t option
        [@ocaml.doc "<p>The ID of the stack set.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description of the stack set that you specify when the stack set is created or updated.</p>"];
      status: StackSetStatus.t option
        [@ocaml.doc "<p>The status of the stack set.</p>"];
      template_body: String.t option
        [@ocaml.doc
          "<p>The structure that contains the body of the template that was used to create or update the stack set.</p>"];
      parameters: Parameters.t
        [@ocaml.doc "<p>A list of input parameters for a stack set.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>The capabilities that are allowed in the stack set. Some stack set templates might include resources that can affect permissions in your AWS account\226\128\148for example, by creating new AWS Identity and Access Management (IAM) users. For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates.</a> </p>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>A list of tags that specify information about the stack set. A maximum number of 50 tags can be specified.</p>"];
      stack_set_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Number (ARN) of the stack set.</p>"];
      administration_role_a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Number (ARN) of the IAM role used to create or update the stack set.</p> <p>Use customized administrator roles to control which users or groups can manage specific stack sets within the same administrator account. For more information, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-prereqs.html\">Prerequisites: Granting Permissions for Stack Set Operations</a> in the <i>AWS CloudFormation User Guide</i>.</p>"];
      execution_role_name: String.t option
        [@ocaml.doc
          "<p>The name of the IAM execution role used to create or update the stack set. </p> <p>Use customized execution roles to control which stack resources users and groups can include in their stack sets. </p>"];
      stack_set_drift_detection_details:
        StackSetDriftDetectionDetails.t option
        [@ocaml.doc
          "<p>Detailed information about the drift status of the stack set.</p> <p>For stack sets, contains information about the last <i>completed</i> drift operation performed on the stack set. Information about drift operations currently in progress is not included.</p>"]}
    [@@ocaml.doc
      "<p>A structure that contains information about a stack set. A stack set enables you to provision stacks into AWS accounts and across regions by using a single CloudFormation template. In the stack set, you specify the template to use, as well as any parameters and capabilities that the template requires. </p>"]
    let make ?stack_set_name  ?stack_set_id  ?description  ?status 
      ?template_body  ?(parameters= [])  ?(capabilities= [])  ?(tags= []) 
      ?stack_set_a_r_n  ?administration_role_a_r_n  ?execution_role_name 
      ?stack_set_drift_detection_details  () =
      {
        stack_set_name;
        stack_set_id;
        description;
        status;
        template_body;
        parameters;
        capabilities;
        tags;
        stack_set_a_r_n;
        administration_role_a_r_n;
        execution_role_name;
        stack_set_drift_detection_details
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_set_drift_detection_details
              (fun f ->
                 ("stack_set_drift_detection_details",
                   (StackSetDriftDetectionDetails.to_json f)));
           Util.option_map v.execution_role_name
             (fun f -> ("execution_role_name", (String.to_json f)));
           Util.option_map v.administration_role_a_r_n
             (fun f -> ("administration_role_a_r_n", (String.to_json f)));
           Util.option_map v.stack_set_a_r_n
             (fun f -> ("stack_set_a_r_n", (String.to_json f)));
           Some ("tags", (Tags.to_json v.tags));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Some ("parameters", (Parameters.to_json v.parameters));
           Util.option_map v.template_body
             (fun f -> ("template_body", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (StackSetStatus.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.stack_set_id
             (fun f -> ("stack_set_id", (String.to_json f)));
           Util.option_map v.stack_set_name
             (fun f -> ("stack_set_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_set_name =
            (Util.option_bind (Xml.member "StackSetName" xml) String.parse);
          stack_set_id =
            (Util.option_bind (Xml.member "StackSetId" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml) StackSetStatus.parse);
          template_body =
            (Util.option_bind (Xml.member "TemplateBody" xml) String.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  Parameters.parse));
          capabilities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Capabilities" xml)
                  Capabilities.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          stack_set_a_r_n =
            (Util.option_bind (Xml.member "StackSetARN" xml) String.parse);
          administration_role_a_r_n =
            (Util.option_bind (Xml.member "AdministrationRoleARN" xml)
               String.parse);
          execution_role_name =
            (Util.option_bind (Xml.member "ExecutionRoleName" xml)
               String.parse);
          stack_set_drift_detection_details =
            (Util.option_bind
               (Xml.member "StackSetDriftDetectionDetails" xml)
               StackSetDriftDetectionDetails.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.stack_set_name
                         (fun f ->
                            Ezxmlm.make_tag "StackSetName"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.stack_set_id
                        (fun f ->
                           Ezxmlm.make_tag "StackSetId"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.description
                       (fun f ->
                          Ezxmlm.make_tag "Description"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.status
                      (fun f ->
                         Ezxmlm.make_tag "Status"
                           ([], (StackSetStatus.to_xml f)))])
                  @
                  [Util.option_map v.template_body
                     (fun f ->
                        Ezxmlm.make_tag "TemplateBody"
                          ([], (String.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "Parameters"
                            ([], (Parameters.to_xml [x])))) v.parameters))
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "Capabilities"
                           ([], (Capabilities.to_xml [x])))) v.capabilities))
               @
               (List.map
                  (fun x ->
                     Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
                  v.tags))
              @
              [Util.option_map v.stack_set_a_r_n
                 (fun f ->
                    Ezxmlm.make_tag "StackSetARN" ([], (String.to_xml f)))])
             @
             [Util.option_map v.administration_role_a_r_n
                (fun f ->
                   Ezxmlm.make_tag "AdministrationRoleARN"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.execution_role_name
               (fun f ->
                  Ezxmlm.make_tag "ExecutionRoleName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.stack_set_drift_detection_details
              (fun f ->
                 Ezxmlm.make_tag "StackSetDriftDetectionDetails"
                   ([], (StackSetDriftDetectionDetails.to_xml f)))])
  end[@@ocaml.doc
       "<p>A structure that contains information about a stack set. A stack set enables you to provision stacks into AWS accounts and across regions by using a single CloudFormation template. In the stack set, you specify the template to use, as well as any parameters and capabilities that the template requires. </p>"]
module TypeVersionSummaries =
  struct
    type t = TypeVersionSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TypeVersionSummary.to_query v
    let to_headers v =
      Headers.to_headers_list TypeVersionSummary.to_headers v
    let to_json v = `List (List.map TypeVersionSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map TypeVersionSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (TypeVersionSummary.to_xml x))) v
  end
module Imports =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module StageList =
  struct
    type t = TemplateStage.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TemplateStage.to_query v
    let to_headers v = Headers.to_headers_list TemplateStage.to_headers v
    let to_json v = `List (List.map TemplateStage.to_json v)
    let parse xml =
      Util.option_all
        (List.map TemplateStage.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TemplateStage.to_xml x))) v
  end
module StackSetOperationSummaries =
  struct
    type t = StackSetOperationSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StackSetOperationSummary.to_query v
    let to_headers v =
      Headers.to_headers_list StackSetOperationSummary.to_headers v
    let to_json v = `List (List.map StackSetOperationSummary.to_json v)
    let parse xml =
      Util.option_all
        (List.map StackSetOperationSummary.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (StackSetOperationSummary.to_xml x)))
        v
  end
module ListStackResourcesOutput =
  struct
    type t =
      {
      stack_resource_summaries: StackResourceSummaries.t
        [@ocaml.doc
          "<p>A list of <code>StackResourceSummary</code> structures.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB, a string that identifies the next page of stack resources. If no additional page exists, this value is null.</p>"]}
    [@@ocaml.doc "<p>The output for a <a>ListStackResources</a> action.</p>"]
    let make ?(stack_resource_summaries= [])  ?next_token  () =
      { stack_resource_summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("stack_resource_summaries",
               (StackResourceSummaries.to_json v.stack_resource_summaries))])
    let parse xml =
      Some
        {
          stack_resource_summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "StackResourceSummaries" xml)
                  StackResourceSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "StackResourceSummaries"
                       ([], (StackResourceSummaries.to_xml [x]))))
               v.stack_resource_summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The output for a <a>ListStackResources</a> action.</p>"]
module ListStackSetOperationResultsOutput =
  struct
    type t =
      {
      summaries: StackSetOperationResultSummaries.t
        [@ocaml.doc
          "<p>A list of <code>StackSetOperationResultSummary</code> structures that contain information about the specified operation results, for accounts and regions that are included in the operation.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call <code>ListOperationResults</code> again and assign that token to the request object's <code>NextToken</code> parameter. If there are no remaining results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(summaries= [])  ?next_token  () = { summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("summaries",
               (StackSetOperationResultSummaries.to_json v.summaries))])
    let parse xml =
      Some
        {
          summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "Summaries" xml)
                  StackSetOperationResultSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Summaries"
                       ([], (StackSetOperationResultSummaries.to_xml [x]))))
               v.summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeAccountLimitsOutput =
  struct
    type t =
      {
      account_limits: AccountLimitList.t
        [@ocaml.doc
          "<p>An account limit structure that contain a list of AWS CloudFormation account limits and their values.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB in size, a string that identifies the next page of limits. If no additional page exists, this value is null.</p>"]}
    [@@ocaml.doc
      "<p>The output for the <a>DescribeAccountLimits</a> action.</p>"]
    let make ?(account_limits= [])  ?next_token  () =
      { account_limits; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("account_limits", (AccountLimitList.to_json v.account_limits))])
    let parse xml =
      Some
        {
          account_limits =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccountLimits" xml)
                  AccountLimitList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AccountLimits"
                       ([], (AccountLimitList.to_xml [x])))) v.account_limits))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The output for the <a>DescribeAccountLimits</a> action.</p>"]
module CreateStackOutput =
  struct
    type t =
      {
      stack_id: String.t option
        [@ocaml.doc "<p>Unique identifier of the stack.</p>"]}[@@ocaml.doc
                                                                "<p>The output for a <a>CreateStack</a> action.</p>"]
    let make ?stack_id  () = { stack_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_id
              (fun f -> ("stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_id
              (fun f -> Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for a <a>CreateStack</a> action.</p>"]
module DescribeTypeRegistrationOutput =
  struct
    type t =
      {
      progress_status: RegistrationStatus.t option
        [@ocaml.doc
          "<p>The current status of the type registration request.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The description of the type registration request.</p>"];
      type_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the type being registered.</p> <p>For registration requests with a <code>ProgressStatus</code> of other than <code>COMPLETE</code>, this will be <code>null</code>.</p>"];
      type_version_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of this specific version of the type being registered.</p> <p>For registration requests with a <code>ProgressStatus</code> of other than <code>COMPLETE</code>, this will be <code>null</code>.</p>"]}
    let make ?progress_status  ?description  ?type_arn  ?type_version_arn  ()
      = { progress_status; description; type_arn; type_version_arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_version_arn
              (fun f -> ("type_version_arn", (String.to_json f)));
           Util.option_map v.type_arn
             (fun f -> ("type_arn", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.progress_status
             (fun f -> ("progress_status", (RegistrationStatus.to_json f)))])
    let parse xml =
      Some
        {
          progress_status =
            (Util.option_bind (Xml.member "ProgressStatus" xml)
               RegistrationStatus.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          type_arn =
            (Util.option_bind (Xml.member "TypeArn" xml) String.parse);
          type_version_arn =
            (Util.option_bind (Xml.member "TypeVersionArn" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.progress_status
                 (fun f ->
                    Ezxmlm.make_tag "ProgressStatus"
                      ([], (RegistrationStatus.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.type_arn
               (fun f -> Ezxmlm.make_tag "TypeArn" ([], (String.to_xml f)))])
           @
           [Util.option_map v.type_version_arn
              (fun f ->
                 Ezxmlm.make_tag "TypeVersionArn" ([], (String.to_xml f)))])
  end
module DetectStackSetDriftOutput =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc
          "<p>The ID of the drift detection stack set operation. </p> <p>you can use this operation id with <code> <a>DescribeStackSetOperation</a> </code> to monitor the progress of the drift detection operation. </p>"]}
    let make ?operation_id  () = { operation_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module CreateChangeSetOutput =
  struct
    type t =
      {
      id: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the change set.</p>"];
      stack_id: String.t option
        [@ocaml.doc "<p>The unique ID of the stack.</p>"]}[@@ocaml.doc
                                                            "<p>The output for the <a>CreateChangeSet</a> action.</p>"]
    let make ?id  ?stack_id  () = { id; stack_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_id
              (fun f -> ("stack_id", (String.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.id
               (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
           @
           [Util.option_map v.stack_id
              (fun f -> Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for the <a>CreateChangeSet</a> action.</p>"]
module ListStacksOutput =
  struct
    type t =
      {
      stack_summaries: StackSummaries.t
        [@ocaml.doc
          "<p>A list of <code>StackSummary</code> structures containing information about the specified stacks.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB in size, a string that identifies the next page of stacks. If no additional page exists, this value is null.</p>"]}
    [@@ocaml.doc "<p>The output for <a>ListStacks</a> action.</p>"]
    let make ?(stack_summaries= [])  ?next_token  () =
      { stack_summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("stack_summaries", (StackSummaries.to_json v.stack_summaries))])
    let parse xml =
      Some
        {
          stack_summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "StackSummaries" xml)
                  StackSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "StackSummaries"
                       ([], (StackSummaries.to_xml [x])))) v.stack_summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for <a>ListStacks</a> action.</p>"]
module DescribeStackResourceDriftsOutput =
  struct
    type t =
      {
      stack_resource_drifts: StackResourceDrifts.t
        [@ocaml.doc
          "<p>Drift information for the resources that have been checked for drift in the specified stack. This includes actual and expected configuration values for resources where AWS CloudFormation detects drift.</p> <p>For a given stack, there will be one <code>StackResourceDrift</code> for each stack resource that has been checked for drift. Resources that have not yet been checked for drift are not included. Resources that do not currently support drift detection are not checked, and so not included. For a list of resources that support drift detection, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-stack-drift-resource-list.html\">Resources that Support Drift Detection</a>.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all of the remaining results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call <code>DescribeStackResourceDrifts</code> again and assign that token to the request object's <code>NextToken</code> parameter. If the request returns all results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ~stack_resource_drifts  ?next_token  () =
      { stack_resource_drifts; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("stack_resource_drifts",
               (StackResourceDrifts.to_json v.stack_resource_drifts))])
    let parse xml =
      Some
        {
          stack_resource_drifts =
            (Xml.required "StackResourceDrifts"
               (Util.option_bind (Xml.member "StackResourceDrifts" xml)
                  StackResourceDrifts.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "StackResourceDrifts"
                       ([], (StackResourceDrifts.to_xml [x]))))
               v.stack_resource_drifts))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module StopStackSetOperationOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DeleteStackInstancesOutput =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier for this stack set operation.</p>"]}
    let make ?operation_id  () = { operation_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module EstimateTemplateCostOutput =
  struct
    type t =
      {
      url: String.t option
        [@ocaml.doc
          "<p>An AWS Simple Monthly Calculator URL with a query string that describes the resources required to run the template.</p>"]}
    [@@ocaml.doc
      "<p>The output for a <a>EstimateTemplateCost</a> action.</p>"]
    let make ?url  () = { url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.url (fun f -> ("url", (String.to_json f)))])
    let parse xml =
      Some { url = (Util.option_bind (Xml.member "Url" xml) String.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.url
              (fun f -> Ezxmlm.make_tag "Url" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The output for a <a>EstimateTemplateCost</a> action.</p>"]
module DescribeChangeSetOutput =
  struct
    type t =
      {
      change_set_name: String.t option
        [@ocaml.doc "<p>The name of the change set.</p>"];
      change_set_id: String.t option
        [@ocaml.doc "<p>The ARN of the change set.</p>"];
      stack_id: String.t option
        [@ocaml.doc
          "<p>The ARN of the stack that is associated with the change set.</p>"];
      stack_name: String.t option
        [@ocaml.doc
          "<p>The name of the stack that is associated with the change set.</p>"];
      description: String.t option
        [@ocaml.doc "<p>Information about the change set.</p>"];
      parameters: Parameters.t
        [@ocaml.doc
          "<p>A list of <code>Parameter</code> structures that describes the input parameters and their values used to create the change set. For more information, see the <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_Parameter.html\">Parameter</a> data type.</p>"];
      creation_time: DateTime.t option
        [@ocaml.doc
          "<p>The start time when the change set was created, in UTC.</p>"];
      execution_status: ExecutionStatus.t option
        [@ocaml.doc
          "<p>If the change set execution status is <code>AVAILABLE</code>, you can execute the change set. If you can\226\128\153t execute the change set, the status indicates why. For example, a change set might be in an <code>UNAVAILABLE</code> state because AWS CloudFormation is still creating it or in an <code>OBSOLETE</code> state because the stack was already updated.</p>"];
      status: ChangeSetStatus.t option
        [@ocaml.doc
          "<p>The current status of the change set, such as <code>CREATE_IN_PROGRESS</code>, <code>CREATE_COMPLETE</code>, or <code>FAILED</code>.</p>"];
      status_reason: String.t option
        [@ocaml.doc
          "<p>A description of the change set's status. For example, if your attempt to create a change set failed, AWS CloudFormation shows the error message.</p>"];
      notification_a_r_ns: NotificationARNs.t
        [@ocaml.doc
          "<p>The ARNs of the Amazon Simple Notification Service (Amazon SNS) topics that will be associated with the stack if you execute the change set.</p>"];
      rollback_configuration: RollbackConfiguration.t option
        [@ocaml.doc
          "<p>The rollback triggers for AWS CloudFormation to monitor during stack creation and updating operations, and for the specified monitoring period afterwards.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>If you execute the change set, the list of capabilities that were explicitly acknowledged when the change set was created.</p>"];
      tags: Tags.t
        [@ocaml.doc
          "<p>If you execute the change set, the tags that will be associated with the stack.</p>"];
      changes: Changes.t
        [@ocaml.doc
          "<p>A list of <code>Change</code> structures that describes the resources AWS CloudFormation changes if you execute the change set.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB, a string that identifies the next page of changes. If there is no additional page, this value is null.</p>"]}
    [@@ocaml.doc
      "<p>The output for the <a>DescribeChangeSet</a> action.</p>"]
    let make ?change_set_name  ?change_set_id  ?stack_id  ?stack_name 
      ?description  ?(parameters= [])  ?creation_time  ?execution_status 
      ?status  ?status_reason  ?(notification_a_r_ns= []) 
      ?rollback_configuration  ?(capabilities= [])  ?(tags= [])  ?(changes=
      [])  ?next_token  () =
      {
        change_set_name;
        change_set_id;
        stack_id;
        stack_name;
        description;
        parameters;
        creation_time;
        execution_status;
        status;
        status_reason;
        notification_a_r_ns;
        rollback_configuration;
        capabilities;
        tags;
        changes;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("changes", (Changes.to_json v.changes));
           Some ("tags", (Tags.to_json v.tags));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Util.option_map v.rollback_configuration
             (fun f ->
                ("rollback_configuration", (RollbackConfiguration.to_json f)));
           Some
             ("notification_a_r_ns",
               (NotificationARNs.to_json v.notification_a_r_ns));
           Util.option_map v.status_reason
             (fun f -> ("status_reason", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (ChangeSetStatus.to_json f)));
           Util.option_map v.execution_status
             (fun f -> ("execution_status", (ExecutionStatus.to_json f)));
           Util.option_map v.creation_time
             (fun f -> ("creation_time", (DateTime.to_json f)));
           Some ("parameters", (Parameters.to_json v.parameters));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.stack_name
             (fun f -> ("stack_name", (String.to_json f)));
           Util.option_map v.stack_id
             (fun f -> ("stack_id", (String.to_json f)));
           Util.option_map v.change_set_id
             (fun f -> ("change_set_id", (String.to_json f)));
           Util.option_map v.change_set_name
             (fun f -> ("change_set_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          change_set_name =
            (Util.option_bind (Xml.member "ChangeSetName" xml) String.parse);
          change_set_id =
            (Util.option_bind (Xml.member "ChangeSetId" xml) String.parse);
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse);
          stack_name =
            (Util.option_bind (Xml.member "StackName" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  Parameters.parse));
          creation_time =
            (Util.option_bind (Xml.member "CreationTime" xml) DateTime.parse);
          execution_status =
            (Util.option_bind (Xml.member "ExecutionStatus" xml)
               ExecutionStatus.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml) ChangeSetStatus.parse);
          status_reason =
            (Util.option_bind (Xml.member "StatusReason" xml) String.parse);
          notification_a_r_ns =
            (Util.of_option []
               (Util.option_bind (Xml.member "NotificationARNs" xml)
                  NotificationARNs.parse));
          rollback_configuration =
            (Util.option_bind (Xml.member "RollbackConfiguration" xml)
               RollbackConfiguration.parse);
          capabilities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Capabilities" xml)
                  Capabilities.parse));
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tags" xml) Tags.parse));
          changes =
            (Util.of_option []
               (Util.option_bind (Xml.member "Changes" xml) Changes.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((([] @
                          [Util.option_map v.change_set_name
                             (fun f ->
                                Ezxmlm.make_tag "ChangeSetName"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.change_set_id
                            (fun f ->
                               Ezxmlm.make_tag "ChangeSetId"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.stack_id
                           (fun f ->
                              Ezxmlm.make_tag "StackId"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.stack_name
                          (fun f ->
                             Ezxmlm.make_tag "StackName"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.description
                         (fun f ->
                            Ezxmlm.make_tag "Description"
                              ([], (String.to_xml f)))])
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "Parameters"
                                ([], (Parameters.to_xml [x])))) v.parameters))
                    @
                    [Util.option_map v.creation_time
                       (fun f ->
                          Ezxmlm.make_tag "CreationTime"
                            ([], (DateTime.to_xml f)))])
                   @
                   [Util.option_map v.execution_status
                      (fun f ->
                         Ezxmlm.make_tag "ExecutionStatus"
                           ([], (ExecutionStatus.to_xml f)))])
                  @
                  [Util.option_map v.status
                     (fun f ->
                        Ezxmlm.make_tag "Status"
                          ([], (ChangeSetStatus.to_xml f)))])
                 @
                 [Util.option_map v.status_reason
                    (fun f ->
                       Ezxmlm.make_tag "StatusReason" ([], (String.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "NotificationARNs"
                           ([], (NotificationARNs.to_xml [x]))))
                   v.notification_a_r_ns))
               @
               [Util.option_map v.rollback_configuration
                  (fun f ->
                     Ezxmlm.make_tag "RollbackConfiguration"
                       ([], (RollbackConfiguration.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Capabilities"
                         ([], (Capabilities.to_xml [x])))) v.capabilities))
             @
             (List.map
                (fun x ->
                   Some (Ezxmlm.make_tag "Tags" ([], (Tags.to_xml [x]))))
                v.tags))
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Changes" ([], (Changes.to_xml [x]))))
               v.changes))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The output for the <a>DescribeChangeSet</a> action.</p>"]
module GetStackPolicyOutput =
  struct
    type t =
      {
      stack_policy_body: String.t option
        [@ocaml.doc
          "<p>Structure containing the stack policy body. (For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/protect-stack-resources.html\"> Prevent Updates to Stack Resources</a> in the AWS CloudFormation User Guide.)</p>"]}
    [@@ocaml.doc "<p>The output for the <a>GetStackPolicy</a> action.</p>"]
    let make ?stack_policy_body  () = { stack_policy_body }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_policy_body
              (fun f -> ("stack_policy_body", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_policy_body =
            (Util.option_bind (Xml.member "StackPolicyBody" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_policy_body
              (fun f ->
                 Ezxmlm.make_tag "StackPolicyBody" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for the <a>GetStackPolicy</a> action.</p>"]
module DescribeTypeOutput =
  struct
    type t =
      {
      arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) of the type.</p>"];
      type_: RegistryType.t option
        [@ocaml.doc
          "<p>The kind of type. </p> <p>Currently the only valid value is <code>RESOURCE</code>.</p>"];
      type_name: String.t option
        [@ocaml.doc "<p>The name of the registered type.</p>"];
      default_version_id: String.t option
        [@ocaml.doc
          "<p>The ID of the default version of the type. The default version is used when the type version is not specified.</p> <p>To set the default version of a type, use <code> <a>SetTypeDefaultVersion</a> </code>. </p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the registered type.</p>"];
      schema: String.t option
        [@ocaml.doc
          "<p>The schema that defines the type.</p> <p>For more information on type schemas, see <a href=\"https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/resource-type-schema.html\">Resource Provider Schema</a> in the <i>CloudFormation CLI User Guide</i>.</p>"];
      provisioning_type: ProvisioningType.t option
        [@ocaml.doc
          "<p>The provisioning behavior of the type. AWS CloudFormation determines the provisioning type during registration, based on the types of handlers in the schema handler package submitted.</p> <p>Valid values include:</p> <ul> <li> <p> <code>FULLY_MUTABLE</code>: The type includes an update handler to process updates to the type during stack update operations.</p> </li> <li> <p> <code>IMMUTABLE</code>: The type does not include an update handler, so the type cannot be updated and must instead be replaced during stack update operations.</p> </li> <li> <p> <code>NON_PROVISIONABLE</code>: The type does not include all of the following handlers, and therefore cannot actually be provisioned.</p> <ul> <li> <p>create</p> </li> <li> <p>read</p> </li> <li> <p>delete</p> </li> </ul> </li> </ul>"];
      deprecated_status: DeprecatedStatus.t option
        [@ocaml.doc
          "<p>The deprecation status of the type.</p> <p>Valid values include:</p> <ul> <li> <p> <code>LIVE</code>: The type is registered and can be used in CloudFormation operations, dependent on its provisioning behavior and visibility scope.</p> </li> <li> <p> <code>DEPRECATED</code>: The type has been deregistered and can no longer be used in CloudFormation operations. </p> </li> </ul>"];
      logging_config: LoggingConfig.t option
        [@ocaml.doc
          "<p>Contains logging configuration information for a type.</p>"];
      execution_role_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM execution role used to register the type. If your resource type calls AWS APIs in any of its handlers, you must create an <i> <a href=\"https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html\">IAM execution role</a> </i> that includes the necessary permissions to call those AWS APIs, and provision that execution role in your account. CloudFormation then assumes that execution role to provide your resource type with the appropriate credentials.</p>"];
      visibility: Visibility.t option
        [@ocaml.doc
          "<p>The scope at which the type is visible and usable in CloudFormation operations.</p> <p>Valid values include:</p> <ul> <li> <p> <code>PRIVATE</code>: The type is only visible and usable within the account in which it is registered. Currently, AWS CloudFormation marks any types you register as <code>PRIVATE</code>.</p> </li> <li> <p> <code>PUBLIC</code>: The type is publically visible and usable within any Amazon account.</p> </li> </ul>"];
      source_url: String.t option
        [@ocaml.doc "<p>The URL of the source code for the type.</p>"];
      documentation_url: String.t option
        [@ocaml.doc
          "<p>The URL of a page providing detailed documentation for this type.</p>"];
      last_updated: DateTime.t option
        [@ocaml.doc "<p>When the specified type version was registered.</p>"];
      time_created: DateTime.t option
        [@ocaml.doc "<p>When the specified type version was registered.</p>"]}
    let make ?arn  ?type_  ?type_name  ?default_version_id  ?description 
      ?schema  ?provisioning_type  ?deprecated_status  ?logging_config 
      ?execution_role_arn  ?visibility  ?source_url  ?documentation_url 
      ?last_updated  ?time_created  () =
      {
        arn;
        type_;
        type_name;
        default_version_id;
        description;
        schema;
        provisioning_type;
        deprecated_status;
        logging_config;
        execution_role_arn;
        visibility;
        source_url;
        documentation_url;
        last_updated;
        time_created
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.time_created
              (fun f -> ("time_created", (DateTime.to_json f)));
           Util.option_map v.last_updated
             (fun f -> ("last_updated", (DateTime.to_json f)));
           Util.option_map v.documentation_url
             (fun f -> ("documentation_url", (String.to_json f)));
           Util.option_map v.source_url
             (fun f -> ("source_url", (String.to_json f)));
           Util.option_map v.visibility
             (fun f -> ("visibility", (Visibility.to_json f)));
           Util.option_map v.execution_role_arn
             (fun f -> ("execution_role_arn", (String.to_json f)));
           Util.option_map v.logging_config
             (fun f -> ("logging_config", (LoggingConfig.to_json f)));
           Util.option_map v.deprecated_status
             (fun f -> ("deprecated_status", (DeprecatedStatus.to_json f)));
           Util.option_map v.provisioning_type
             (fun f -> ("provisioning_type", (ProvisioningType.to_json f)));
           Util.option_map v.schema (fun f -> ("schema", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.default_version_id
             (fun f -> ("default_version_id", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (RegistryType.to_json f)));
           Util.option_map v.arn (fun f -> ("arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          arn = (Util.option_bind (Xml.member "Arn" xml) String.parse);
          type_ =
            (Util.option_bind (Xml.member "Type" xml) RegistryType.parse);
          type_name =
            (Util.option_bind (Xml.member "TypeName" xml) String.parse);
          default_version_id =
            (Util.option_bind (Xml.member "DefaultVersionId" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          schema = (Util.option_bind (Xml.member "Schema" xml) String.parse);
          provisioning_type =
            (Util.option_bind (Xml.member "ProvisioningType" xml)
               ProvisioningType.parse);
          deprecated_status =
            (Util.option_bind (Xml.member "DeprecatedStatus" xml)
               DeprecatedStatus.parse);
          logging_config =
            (Util.option_bind (Xml.member "LoggingConfig" xml)
               LoggingConfig.parse);
          execution_role_arn =
            (Util.option_bind (Xml.member "ExecutionRoleArn" xml)
               String.parse);
          visibility =
            (Util.option_bind (Xml.member "Visibility" xml) Visibility.parse);
          source_url =
            (Util.option_bind (Xml.member "SourceUrl" xml) String.parse);
          documentation_url =
            (Util.option_bind (Xml.member "DocumentationUrl" xml)
               String.parse);
          last_updated =
            (Util.option_bind (Xml.member "LastUpdated" xml) DateTime.parse);
          time_created =
            (Util.option_bind (Xml.member "TimeCreated" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((([] @
                         [Util.option_map v.arn
                            (fun f ->
                               Ezxmlm.make_tag "Arn" ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.type_
                           (fun f ->
                              Ezxmlm.make_tag "Type"
                                ([], (RegistryType.to_xml f)))])
                       @
                       [Util.option_map v.type_name
                          (fun f ->
                             Ezxmlm.make_tag "TypeName"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.default_version_id
                         (fun f ->
                            Ezxmlm.make_tag "DefaultVersionId"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.description
                        (fun f ->
                           Ezxmlm.make_tag "Description"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.schema
                       (fun f ->
                          Ezxmlm.make_tag "Schema" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.provisioning_type
                      (fun f ->
                         Ezxmlm.make_tag "ProvisioningType"
                           ([], (ProvisioningType.to_xml f)))])
                  @
                  [Util.option_map v.deprecated_status
                     (fun f ->
                        Ezxmlm.make_tag "DeprecatedStatus"
                          ([], (DeprecatedStatus.to_xml f)))])
                 @
                 [Util.option_map v.logging_config
                    (fun f ->
                       Ezxmlm.make_tag "LoggingConfig"
                         ([], (LoggingConfig.to_xml f)))])
                @
                [Util.option_map v.execution_role_arn
                   (fun f ->
                      Ezxmlm.make_tag "ExecutionRoleArn"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.visibility
                  (fun f ->
                     Ezxmlm.make_tag "Visibility" ([], (Visibility.to_xml f)))])
              @
              [Util.option_map v.source_url
                 (fun f ->
                    Ezxmlm.make_tag "SourceUrl" ([], (String.to_xml f)))])
             @
             [Util.option_map v.documentation_url
                (fun f ->
                   Ezxmlm.make_tag "DocumentationUrl" ([], (String.to_xml f)))])
            @
            [Util.option_map v.last_updated
               (fun f ->
                  Ezxmlm.make_tag "LastUpdated" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.time_created
              (fun f ->
                 Ezxmlm.make_tag "TimeCreated" ([], (DateTime.to_xml f)))])
  end
module DeregisterTypeOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module ListChangeSetsOutput =
  struct
    type t =
      {
      summaries: ChangeSetSummaries.t
        [@ocaml.doc
          "<p>A list of <code>ChangeSetSummary</code> structures that provides the ID and status of each change set for the specified stack.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB, a string that identifies the next page of change sets. If there is no additional page, this value is null.</p>"]}
    [@@ocaml.doc "<p>The output for the <a>ListChangeSets</a> action.</p>"]
    let make ?(summaries= [])  ?next_token  () = { summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("summaries", (ChangeSetSummaries.to_json v.summaries))])
    let parse xml =
      Some
        {
          summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "Summaries" xml)
                  ChangeSetSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Summaries"
                       ([], (ChangeSetSummaries.to_xml [x])))) v.summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for the <a>ListChangeSets</a> action.</p>"]
module DetectStackDriftOutput =
  struct
    type t =
      {
      stack_drift_detection_id: String.t
        [@ocaml.doc
          "<p>The ID of the drift detection results of this operation. </p> <p>AWS CloudFormation generates new results, with a new drift detection ID, each time this operation is run. However, the number of drift results AWS CloudFormation retains for any given stack, and for how long, may vary. </p>"]}
    let make ~stack_drift_detection_id  () = { stack_drift_detection_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("stack_drift_detection_id",
                (String.to_json v.stack_drift_detection_id))])
    let parse xml =
      Some
        {
          stack_drift_detection_id =
            (Xml.required "StackDriftDetectionId"
               (Util.option_bind (Xml.member "StackDriftDetectionId" xml)
                  String.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "StackDriftDetectionId"
                 ([], (String.to_xml v.stack_drift_detection_id)))])
  end
module ListExportsOutput =
  struct
    type t =
      {
      exports: Exports.t
        [@ocaml.doc "<p>The output for the <a>ListExports</a> action.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 100 exported output values, a string that identifies the next page of exports. If there is no additional page, this value is null.</p>"]}
    let make ?(exports= [])  ?next_token  () = { exports; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("exports", (Exports.to_json v.exports))])
    let parse xml =
      Some
        {
          exports =
            (Util.of_option []
               (Util.option_bind (Xml.member "Exports" xml) Exports.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Exports" ([], (Exports.to_xml [x]))))
               v.exports))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module UpdateStackInstancesOutput =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier for this stack set operation. </p>"]}
    let make ?operation_id  () = { operation_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module GetTemplateSummaryOutput =
  struct
    type t =
      {
      parameters: ParameterDeclarations.t
        [@ocaml.doc
          "<p>A list of parameter declarations that describe various properties for each parameter.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The value that is defined in the <code>Description</code> property of the template.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>The capabilities found within the template. If your template contains IAM resources, you must specify the CAPABILITY_IAM or CAPABILITY_NAMED_IAM value for this parameter when you use the <a>CreateStack</a> or <a>UpdateStack</a> actions with your template; otherwise, those actions return an InsufficientCapabilities error.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates</a>.</p>"];
      capabilities_reason: String.t option
        [@ocaml.doc
          "<p>The list of resources that generated the values in the <code>Capabilities</code> response element.</p>"];
      resource_types: ResourceTypes.t
        [@ocaml.doc
          "<p>A list of all the template resource types that are defined in the template, such as <code>AWS::EC2::Instance</code>, <code>AWS::Dynamo::Table</code>, and <code>Custom::MyCustomInstance</code>.</p>"];
      version: String.t option
        [@ocaml.doc
          "<p>The AWS template format version, which identifies the capabilities of the template.</p>"];
      metadata: String.t option
        [@ocaml.doc
          "<p>The value that is defined for the <code>Metadata</code> property of the template.</p>"];
      declared_transforms: TransformsList.t
        [@ocaml.doc
          "<p>A list of the transforms that are declared in the template.</p>"];
      resource_identifier_summaries: ResourceIdentifierSummaries.t
        [@ocaml.doc
          "<p>A list of resource identifier summaries that describe the target resources of an import operation and the properties you can provide during the import to identify the target resources. For example, <code>BucketName</code> is a possible identifier property for an <code>AWS::S3::Bucket</code> resource. </p>"]}
    [@@ocaml.doc
      "<p>The output for the <a>GetTemplateSummary</a> action.</p>"]
    let make ?(parameters= [])  ?description  ?(capabilities= []) 
      ?capabilities_reason  ?(resource_types= [])  ?version  ?metadata 
      ?(declared_transforms= [])  ?(resource_identifier_summaries= [])  () =
      {
        parameters;
        description;
        capabilities;
        capabilities_reason;
        resource_types;
        version;
        metadata;
        declared_transforms;
        resource_identifier_summaries
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("resource_identifier_summaries",
                (ResourceIdentifierSummaries.to_json
                   v.resource_identifier_summaries));
           Some
             ("declared_transforms",
               (TransformsList.to_json v.declared_transforms));
           Util.option_map v.metadata
             (fun f -> ("metadata", (String.to_json f)));
           Util.option_map v.version
             (fun f -> ("version", (String.to_json f)));
           Some ("resource_types", (ResourceTypes.to_json v.resource_types));
           Util.option_map v.capabilities_reason
             (fun f -> ("capabilities_reason", (String.to_json f)));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("parameters", (ParameterDeclarations.to_json v.parameters))])
    let parse xml =
      Some
        {
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParameterDeclarations.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          capabilities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Capabilities" xml)
                  Capabilities.parse));
          capabilities_reason =
            (Util.option_bind (Xml.member "CapabilitiesReason" xml)
               String.parse);
          resource_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "ResourceTypes" xml)
                  ResourceTypes.parse));
          version =
            (Util.option_bind (Xml.member "Version" xml) String.parse);
          metadata =
            (Util.option_bind (Xml.member "Metadata" xml) String.parse);
          declared_transforms =
            (Util.of_option []
               (Util.option_bind (Xml.member "DeclaredTransforms" xml)
                  TransformsList.parse));
          resource_identifier_summaries =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ResourceIdentifierSummaries" xml)
                  ResourceIdentifierSummaries.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "Parameters"
                              ([], (ParameterDeclarations.to_xml [x]))))
                      v.parameters))
                  @
                  [Util.option_map v.description
                     (fun f ->
                        Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "Capabilities"
                            ([], (Capabilities.to_xml [x])))) v.capabilities))
                @
                [Util.option_map v.capabilities_reason
                   (fun f ->
                      Ezxmlm.make_tag "CapabilitiesReason"
                        ([], (String.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ResourceTypes"
                          ([], (ResourceTypes.to_xml [x])))) v.resource_types))
              @
              [Util.option_map v.version
                 (fun f -> Ezxmlm.make_tag "Version" ([], (String.to_xml f)))])
             @
             [Util.option_map v.metadata
                (fun f -> Ezxmlm.make_tag "Metadata" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DeclaredTransforms"
                       ([], (TransformsList.to_xml [x]))))
               v.declared_transforms))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ResourceIdentifierSummaries"
                      ([], (ResourceIdentifierSummaries.to_xml [x]))))
              v.resource_identifier_summaries))
  end[@@ocaml.doc
       "<p>The output for the <a>GetTemplateSummary</a> action.</p>"]
module DeleteStackSetOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module ExecuteChangeSetOutput =
  struct
    type t = unit[@@ocaml.doc
                   "<p>The output for the <a>ExecuteChangeSet</a> action.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>The output for the <a>ExecuteChangeSet</a> action.</p>"]
module UpdateTerminationProtectionOutput =
  struct
    type t =
      {
      stack_id: String.t option
        [@ocaml.doc "<p>The unique ID of the stack.</p>"]}
    let make ?stack_id  () = { stack_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_id
              (fun f -> ("stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_id
              (fun f -> Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
  end
module ValidateTemplateOutput =
  struct
    type t =
      {
      parameters: TemplateParameters.t
        [@ocaml.doc
          "<p>A list of <code>TemplateParameter</code> structures.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description found within the template.</p>"];
      capabilities: Capabilities.t
        [@ocaml.doc
          "<p>The capabilities found within the template. If your template contains IAM resources, you must specify the CAPABILITY_IAM or CAPABILITY_NAMED_IAM value for this parameter when you use the <a>CreateStack</a> or <a>UpdateStack</a> actions with your template; otherwise, those actions return an InsufficientCapabilities error.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-iam-template.html#capabilities\">Acknowledging IAM Resources in AWS CloudFormation Templates</a>.</p>"];
      capabilities_reason: String.t option
        [@ocaml.doc
          "<p>The list of resources that generated the values in the <code>Capabilities</code> response element.</p>"];
      declared_transforms: TransformsList.t
        [@ocaml.doc
          "<p>A list of the transforms that are declared in the template.</p>"]}
    [@@ocaml.doc "<p>The output for <a>ValidateTemplate</a> action.</p>"]
    let make ?(parameters= [])  ?description  ?(capabilities= []) 
      ?capabilities_reason  ?(declared_transforms= [])  () =
      {
        parameters;
        description;
        capabilities;
        capabilities_reason;
        declared_transforms
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("declared_transforms",
                (TransformsList.to_json v.declared_transforms));
           Util.option_map v.capabilities_reason
             (fun f -> ("capabilities_reason", (String.to_json f)));
           Some ("capabilities", (Capabilities.to_json v.capabilities));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Some ("parameters", (TemplateParameters.to_json v.parameters))])
    let parse xml =
      Some
        {
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  TemplateParameters.parse));
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          capabilities =
            (Util.of_option []
               (Util.option_bind (Xml.member "Capabilities" xml)
                  Capabilities.parse));
          capabilities_reason =
            (Util.option_bind (Xml.member "CapabilitiesReason" xml)
               String.parse);
          declared_transforms =
            (Util.of_option []
               (Util.option_bind (Xml.member "DeclaredTransforms" xml)
                  TransformsList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "Parameters"
                          ([], (TemplateParameters.to_xml [x]))))
                  v.parameters))
              @
              [Util.option_map v.description
                 (fun f ->
                    Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Capabilities"
                        ([], (Capabilities.to_xml [x])))) v.capabilities))
            @
            [Util.option_map v.capabilities_reason
               (fun f ->
                  Ezxmlm.make_tag "CapabilitiesReason"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DeclaredTransforms"
                      ([], (TransformsList.to_xml [x]))))
              v.declared_transforms))
  end[@@ocaml.doc "<p>The output for <a>ValidateTemplate</a> action.</p>"]
module DescribeStackInstanceOutput =
  struct
    type t =
      {
      stack_instance: StackInstance.t option
        [@ocaml.doc
          "<p>The stack instance that matches the specified request parameters.</p>"]}
    let make ?stack_instance  () = { stack_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_instance
              (fun f -> ("stack_instance", (StackInstance.to_json f)))])
    let parse xml =
      Some
        {
          stack_instance =
            (Util.option_bind (Xml.member "StackInstance" xml)
               StackInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_instance
              (fun f ->
                 Ezxmlm.make_tag "StackInstance"
                   ([], (StackInstance.to_xml f)))])
  end
module SetTypeDefaultVersionOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module ListStackSetsOutput =
  struct
    type t =
      {
      summaries: StackSetSummaries.t
        [@ocaml.doc
          "<p>A list of <code>StackSetSummary</code> structures that contain information about the user's stack sets.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all of the remaining results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call <code>ListStackInstances</code> again and assign that token to the request object's <code>NextToken</code> parameter. If the request returns all results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(summaries= [])  ?next_token  () = { summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("summaries", (StackSetSummaries.to_json v.summaries))])
    let parse xml =
      Some
        {
          summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "Summaries" xml)
                  StackSetSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Summaries"
                       ([], (StackSetSummaries.to_xml [x])))) v.summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module UpdateStackOutput =
  struct
    type t =
      {
      stack_id: String.t option
        [@ocaml.doc "<p>Unique identifier of the stack.</p>"]}[@@ocaml.doc
                                                                "<p>The output for an <a>UpdateStack</a> action.</p>"]
    let make ?stack_id  () = { stack_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_id
              (fun f -> ("stack_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_id =
            (Util.option_bind (Xml.member "StackId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_id
              (fun f -> Ezxmlm.make_tag "StackId" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for an <a>UpdateStack</a> action.</p>"]
module ListStackInstancesOutput =
  struct
    type t =
      {
      summaries: StackInstanceSummaries.t
        [@ocaml.doc
          "<p>A list of <code>StackInstanceSummary</code> structures that contain information about the specified stack instances.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all of the remaining results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call <code>ListStackInstances</code> again and assign that token to the request object's <code>NextToken</code> parameter. If the request returns all results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(summaries= [])  ?next_token  () = { summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("summaries", (StackInstanceSummaries.to_json v.summaries))])
    let parse xml =
      Some
        {
          summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "Summaries" xml)
                  StackInstanceSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Summaries"
                       ([], (StackInstanceSummaries.to_xml [x]))))
               v.summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module ListTypesOutput =
  struct
    type t =
      {
      type_summaries: TypeSummaries.t
        [@ocaml.doc
          "<p>A list of <code>TypeSummary</code> structures that contain information about the specified types.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all of the remaining results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call this action again and assign that token to the request object's <code>NextToken</code> parameter. If the request returns all results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(type_summaries= [])  ?next_token  () =
      { type_summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("type_summaries", (TypeSummaries.to_json v.type_summaries))])
    let parse xml =
      Some
        {
          type_summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "TypeSummaries" xml)
                  TypeSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TypeSummaries"
                       ([], (TypeSummaries.to_xml [x])))) v.type_summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module CreateStackInstancesOutput =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier for this stack set operation.</p>"]}
    let make ?operation_id  () = { operation_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end
module DescribeStacksOutput =
  struct
    type t =
      {
      stacks: Stacks.t [@ocaml.doc "<p>A list of stack structures.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB in size, a string that identifies the next page of stacks. If no additional page exists, this value is null.</p>"]}
    [@@ocaml.doc "<p>The output for a <a>DescribeStacks</a> action.</p>"]
    let make ?(stacks= [])  ?next_token  () = { stacks; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("stacks", (Stacks.to_json v.stacks))])
    let parse xml =
      Some
        {
          stacks =
            (Util.of_option []
               (Util.option_bind (Xml.member "Stacks" xml) Stacks.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Stacks" ([], (Stacks.to_xml [x]))))
               v.stacks))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>The output for a <a>DescribeStacks</a> action.</p>"]
module DescribeStackResourceOutput =
  struct
    type t =
      {
      stack_resource_detail: StackResourceDetail.t option
        [@ocaml.doc
          "<p>A <code>StackResourceDetail</code> structure containing the description of the specified resource in the specified stack.</p>"]}
    [@@ocaml.doc
      "<p>The output for a <a>DescribeStackResource</a> action.</p>"]
    let make ?stack_resource_detail  () = { stack_resource_detail }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_resource_detail
              (fun f ->
                 ("stack_resource_detail", (StackResourceDetail.to_json f)))])
    let parse xml =
      Some
        {
          stack_resource_detail =
            (Util.option_bind (Xml.member "StackResourceDetail" xml)
               StackResourceDetail.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_resource_detail
              (fun f ->
                 Ezxmlm.make_tag "StackResourceDetail"
                   ([], (StackResourceDetail.to_xml f)))])
  end[@@ocaml.doc
       "<p>The output for a <a>DescribeStackResource</a> action.</p>"]
module RecordHandlerProgressOutput =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module DescribeStackDriftDetectionStatusOutput =
  struct
    type t =
      {
      stack_id: String.t [@ocaml.doc "<p>The ID of the stack.</p>"];
      stack_drift_detection_id: String.t
        [@ocaml.doc
          "<p>The ID of the drift detection results of this operation. </p> <p>AWS CloudFormation generates new results, with a new drift detection ID, each time this operation is run. However, the number of reports AWS CloudFormation retains for any given stack, and for how long, may vary.</p>"];
      stack_drift_status: StackDriftStatus.t option
        [@ocaml.doc
          "<p>Status of the stack's actual configuration compared to its expected configuration. </p> <ul> <li> <p> <code>DRIFTED</code>: The stack differs from its expected template configuration. A stack is considered to have drifted if one or more of its resources have drifted.</p> </li> <li> <p> <code>NOT_CHECKED</code>: AWS CloudFormation has not checked if the stack differs from its expected template configuration.</p> </li> <li> <p> <code>IN_SYNC</code>: The stack's actual configuration matches its expected template configuration.</p> </li> <li> <p> <code>UNKNOWN</code>: This value is reserved for future use.</p> </li> </ul>"];
      detection_status: StackDriftDetectionStatus.t
        [@ocaml.doc
          "<p>The status of the stack drift detection operation.</p> <ul> <li> <p> <code>DETECTION_COMPLETE</code>: The stack drift detection operation has successfully completed for all resources in the stack that support drift detection. (Resources that do not currently support stack detection remain unchecked.)</p> <p>If you specified logical resource IDs for AWS CloudFormation to use as a filter for the stack drift detection operation, only the resources with those logical IDs are checked for drift.</p> </li> <li> <p> <code>DETECTION_FAILED</code>: The stack drift detection operation has failed for at least one resource in the stack. Results will be available for resources on which AWS CloudFormation successfully completed drift detection.</p> </li> <li> <p> <code>DETECTION_IN_PROGRESS</code>: The stack drift detection operation is currently in progress.</p> </li> </ul>"];
      detection_status_reason: String.t option
        [@ocaml.doc
          "<p>The reason the stack drift detection operation has its current status.</p>"];
      drifted_stack_resource_count: Integer.t option
        [@ocaml.doc
          "<p>Total number of stack resources that have drifted. This is NULL until the drift detection operation reaches a status of <code>DETECTION_COMPLETE</code>. This value will be 0 for stacks whose drift status is <code>IN_SYNC</code>.</p>"];
      timestamp: DateTime.t
        [@ocaml.doc
          "<p>Time at which the stack drift detection operation was initiated.</p>"]}
    let make ~stack_id  ~stack_drift_detection_id  ?stack_drift_status 
      ~detection_status  ?detection_status_reason 
      ?drifted_stack_resource_count  ~timestamp  () =
      {
        stack_id;
        stack_drift_detection_id;
        stack_drift_status;
        detection_status;
        detection_status_reason;
        drifted_stack_resource_count;
        timestamp
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("timestamp", (DateTime.to_json v.timestamp));
           Util.option_map v.drifted_stack_resource_count
             (fun f -> ("drifted_stack_resource_count", (Integer.to_json f)));
           Util.option_map v.detection_status_reason
             (fun f -> ("detection_status_reason", (String.to_json f)));
           Some
             ("detection_status",
               (StackDriftDetectionStatus.to_json v.detection_status));
           Util.option_map v.stack_drift_status
             (fun f -> ("stack_drift_status", (StackDriftStatus.to_json f)));
           Some
             ("stack_drift_detection_id",
               (String.to_json v.stack_drift_detection_id));
           Some ("stack_id", (String.to_json v.stack_id))])
    let parse xml =
      Some
        {
          stack_id =
            (Xml.required "StackId"
               (Util.option_bind (Xml.member "StackId" xml) String.parse));
          stack_drift_detection_id =
            (Xml.required "StackDriftDetectionId"
               (Util.option_bind (Xml.member "StackDriftDetectionId" xml)
                  String.parse));
          stack_drift_status =
            (Util.option_bind (Xml.member "StackDriftStatus" xml)
               StackDriftStatus.parse);
          detection_status =
            (Xml.required "DetectionStatus"
               (Util.option_bind (Xml.member "DetectionStatus" xml)
                  StackDriftDetectionStatus.parse));
          detection_status_reason =
            (Util.option_bind (Xml.member "DetectionStatusReason" xml)
               String.parse);
          drifted_stack_resource_count =
            (Util.option_bind (Xml.member "DriftedStackResourceCount" xml)
               Integer.parse);
          timestamp =
            (Xml.required "Timestamp"
               (Util.option_bind (Xml.member "Timestamp" xml) DateTime.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "StackId"
                       ([], (String.to_xml v.stack_id)))])
                @
                [Some
                   (Ezxmlm.make_tag "StackDriftDetectionId"
                      ([], (String.to_xml v.stack_drift_detection_id)))])
               @
               [Util.option_map v.stack_drift_status
                  (fun f ->
                     Ezxmlm.make_tag "StackDriftStatus"
                       ([], (StackDriftStatus.to_xml f)))])
              @
              [Some
                 (Ezxmlm.make_tag "DetectionStatus"
                    ([],
                      (StackDriftDetectionStatus.to_xml v.detection_status)))])
             @
             [Util.option_map v.detection_status_reason
                (fun f ->
                   Ezxmlm.make_tag "DetectionStatusReason"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.drifted_stack_resource_count
               (fun f ->
                  Ezxmlm.make_tag "DriftedStackResourceCount"
                    ([], (Integer.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "Timestamp"
                 ([], (DateTime.to_xml v.timestamp)))])
  end
module CreateStackSetOutput =
  struct
    type t =
      {
      stack_set_id: String.t option
        [@ocaml.doc "<p>The ID of the stack set that you're creating.</p>"]}
    let make ?stack_set_id  () = { stack_set_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_set_id
              (fun f -> ("stack_set_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          stack_set_id =
            (Util.option_bind (Xml.member "StackSetId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_set_id
              (fun f -> Ezxmlm.make_tag "StackSetId" ([], (String.to_xml f)))])
  end
module ListTypeRegistrationsOutput =
  struct
    type t =
      {
      registration_token_list: RegistrationTokenList.t
        [@ocaml.doc
          "<p> A list of type registration tokens.</p> <p>Use <code> <a>DescribeTypeRegistration</a> </code> to return detailed information about a type registration request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all of the remaining results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call this action again and assign that token to the request object's <code>NextToken</code> parameter. If the request returns all results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(registration_token_list= [])  ?next_token  () =
      { registration_token_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("registration_token_list",
               (RegistrationTokenList.to_json v.registration_token_list))])
    let parse xml =
      Some
        {
          registration_token_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "RegistrationTokenList" xml)
                  RegistrationTokenList.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "RegistrationTokenList"
                       ([], (RegistrationTokenList.to_xml [x]))))
               v.registration_token_list))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DescribeStackSetOperationOutput =
  struct
    type t =
      {
      stack_set_operation: StackSetOperation.t option
        [@ocaml.doc "<p>The specified stack set operation.</p>"]}
    let make ?stack_set_operation  () = { stack_set_operation }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_set_operation
              (fun f ->
                 ("stack_set_operation", (StackSetOperation.to_json f)))])
    let parse xml =
      Some
        {
          stack_set_operation =
            (Util.option_bind (Xml.member "StackSetOperation" xml)
               StackSetOperation.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_set_operation
              (fun f ->
                 Ezxmlm.make_tag "StackSetOperation"
                   ([], (StackSetOperation.to_xml f)))])
  end
module ContinueUpdateRollbackOutput =
  struct
    type t = unit[@@ocaml.doc
                   "<p>The output for a <a>ContinueUpdateRollback</a> action.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc
       "<p>The output for a <a>ContinueUpdateRollback</a> action.</p>"]
module DescribeStackEventsOutput =
  struct
    type t =
      {
      stack_events: StackEvents.t
        [@ocaml.doc "<p>A list of <code>StackEvents</code> structures.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the output exceeds 1 MB in size, a string that identifies the next page of events. If no additional page exists, this value is null.</p>"]}
    [@@ocaml.doc
      "<p>The output for a <a>DescribeStackEvents</a> action.</p>"]
    let make ?(stack_events= [])  ?next_token  () =
      { stack_events; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("stack_events", (StackEvents.to_json v.stack_events))])
    let parse xml =
      Some
        {
          stack_events =
            (Util.of_option []
               (Util.option_bind (Xml.member "StackEvents" xml)
                  StackEvents.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "StackEvents"
                       ([], (StackEvents.to_xml [x])))) v.stack_events))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The output for a <a>DescribeStackEvents</a> action.</p>"]
module DescribeStackResourcesOutput =
  struct
    type t =
      {
      stack_resources: StackResources.t
        [@ocaml.doc
          "<p>A list of <code>StackResource</code> structures.</p>"]}
    [@@ocaml.doc
      "<p>The output for a <a>DescribeStackResources</a> action.</p>"]
    let make ?(stack_resources= [])  () = { stack_resources }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("stack_resources", (StackResources.to_json v.stack_resources))])
    let parse xml =
      Some
        {
          stack_resources =
            (Util.of_option []
               (Util.option_bind (Xml.member "StackResources" xml)
                  StackResources.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "StackResources"
                      ([], (StackResources.to_xml [x])))) v.stack_resources))
  end[@@ocaml.doc
       "<p>The output for a <a>DescribeStackResources</a> action.</p>"]
module DescribeStackSetOutput =
  struct
    type t =
      {
      stack_set: StackSet.t option
        [@ocaml.doc "<p>The specified stack set.</p>"]}
    let make ?stack_set  () = { stack_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stack_set
              (fun f -> ("stack_set", (StackSet.to_json f)))])
    let parse xml =
      Some
        {
          stack_set =
            (Util.option_bind (Xml.member "StackSet" xml) StackSet.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.stack_set
              (fun f -> Ezxmlm.make_tag "StackSet" ([], (StackSet.to_xml f)))])
  end
module ListTypeVersionsOutput =
  struct
    type t =
      {
      type_version_summaries: TypeVersionSummaries.t
        [@ocaml.doc
          "<p>A list of <code>TypeVersionSummary</code> structures that contain information about the specified type's versions.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all of the remaining results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call this action again and assign that token to the request object's <code>NextToken</code> parameter. If the request returns all results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(type_version_summaries= [])  ?next_token  () =
      { type_version_summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("type_version_summaries",
               (TypeVersionSummaries.to_json v.type_version_summaries))])
    let parse xml =
      Some
        {
          type_version_summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "TypeVersionSummaries" xml)
                  TypeVersionSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TypeVersionSummaries"
                       ([], (TypeVersionSummaries.to_xml [x]))))
               v.type_version_summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DeleteChangeSetOutput =
  struct
    type t = unit[@@ocaml.doc
                   "<p>The output for the <a>DeleteChangeSet</a> action.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p>The output for the <a>DeleteChangeSet</a> action.</p>"]
module ListImportsOutput =
  struct
    type t =
      {
      imports: Imports.t
        [@ocaml.doc
          "<p>A list of stack names that are importing the specified exported output value. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>A string that identifies the next page of exports. If there is no additional page, this value is null.</p>"]}
    let make ?(imports= [])  ?next_token  () = { imports; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("imports", (Imports.to_json v.imports))])
    let parse xml =
      Some
        {
          imports =
            (Util.of_option []
               (Util.option_bind (Xml.member "Imports" xml) Imports.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Imports" ([], (Imports.to_xml [x]))))
               v.imports))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DetectStackResourceDriftOutput =
  struct
    type t =
      {
      stack_resource_drift: StackResourceDrift.t
        [@ocaml.doc
          "<p>Information about whether the resource's actual configuration has drifted from its expected template configuration, including actual and expected property values and any differences detected.</p>"]}
    let make ~stack_resource_drift  () = { stack_resource_drift }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("stack_resource_drift",
                (StackResourceDrift.to_json v.stack_resource_drift))])
    let parse xml =
      Some
        {
          stack_resource_drift =
            (Xml.required "StackResourceDrift"
               (Util.option_bind (Xml.member "StackResourceDrift" xml)
                  StackResourceDrift.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "StackResourceDrift"
                 ([], (StackResourceDrift.to_xml v.stack_resource_drift)))])
  end
module RegisterTypeOutput =
  struct
    type t =
      {
      registration_token: String.t option
        [@ocaml.doc
          "<p>The identifier for this registration request.</p> <p>Use this registration token when calling <code> <a>DescribeTypeRegistration</a> </code>, which returns information about the status and IDs of the type registration. </p>"]}
    let make ?registration_token  () = { registration_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.registration_token
              (fun f -> ("registration_token", (String.to_json f)))])
    let parse xml =
      Some
        {
          registration_token =
            (Util.option_bind (Xml.member "RegistrationToken" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.registration_token
              (fun f ->
                 Ezxmlm.make_tag "RegistrationToken" ([], (String.to_xml f)))])
  end
module GetTemplateOutput =
  struct
    type t =
      {
      template_body: String.t option
        [@ocaml.doc
          "<p>Structure containing the template body. (For more information, go to <a href=\"https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html\">Template Anatomy</a> in the AWS CloudFormation User Guide.)</p> <p>AWS CloudFormation returns the same template that was used when the stack was created.</p>"];
      stages_available: StageList.t
        [@ocaml.doc
          "<p>The stage of the template that you can retrieve. For stacks, the <code>Original</code> and <code>Processed</code> templates are always available. For change sets, the <code>Original</code> template is always available. After AWS CloudFormation finishes creating the change set, the <code>Processed</code> template becomes available.</p>"]}
    [@@ocaml.doc "<p>The output for <a>GetTemplate</a> action.</p>"]
    let make ?template_body  ?(stages_available= [])  () =
      { template_body; stages_available }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("stages_available", (StageList.to_json v.stages_available));
           Util.option_map v.template_body
             (fun f -> ("template_body", (String.to_json f)))])
    let parse xml =
      Some
        {
          template_body =
            (Util.option_bind (Xml.member "TemplateBody" xml) String.parse);
          stages_available =
            (Util.of_option []
               (Util.option_bind (Xml.member "StagesAvailable" xml)
                  StageList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.template_body
               (fun f ->
                  Ezxmlm.make_tag "TemplateBody" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "StagesAvailable"
                      ([], (StageList.to_xml [x])))) v.stages_available))
  end[@@ocaml.doc "<p>The output for <a>GetTemplate</a> action.</p>"]
module ListStackSetOperationsOutput =
  struct
    type t =
      {
      summaries: StackSetOperationSummaries.t
        [@ocaml.doc
          "<p>A list of <code>StackSetOperationSummary</code> structures that contain summary information about operations for the specified stack set.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>If the request doesn't return all results, <code>NextToken</code> is set to a token. To retrieve the next set of results, call <code>ListOperationResults</code> again and assign that token to the request object's <code>NextToken</code> parameter. If there are no remaining results, <code>NextToken</code> is set to <code>null</code>.</p>"]}
    let make ?(summaries= [])  ?next_token  () = { summaries; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("summaries", (StackSetOperationSummaries.to_json v.summaries))])
    let parse xml =
      Some
        {
          summaries =
            (Util.of_option []
               (Util.option_bind (Xml.member "Summaries" xml)
                  StackSetOperationSummaries.parse));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Summaries"
                       ([], (StackSetOperationSummaries.to_xml [x]))))
               v.summaries))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module UpdateStackSetOutput =
  struct
    type t =
      {
      operation_id: String.t option
        [@ocaml.doc "<p>The unique ID for this stack set operation.</p>"]}
    let make ?operation_id  () = { operation_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operation_id
              (fun f -> ("operation_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          operation_id =
            (Util.option_bind (Xml.member "OperationId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.operation_id
              (fun f -> Ezxmlm.make_tag "OperationId" ([], (String.to_xml f)))])
  end