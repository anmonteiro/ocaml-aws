open Aws
open Aws.BaseTypes
module MinimumEngineVersionPerAllowedValue =
  struct
    type t =
      {
      allowed_value: String.t option
        [@ocaml.doc "<p>The allowed value for an option setting.</p>"];
      minimum_engine_version: String.t option
        [@ocaml.doc
          "<p>The minimum DB engine version required for the allowed value.</p>"]}
    [@@ocaml.doc
      "<p>The minimum DB engine version required for each corresponding allowed value for an option setting.</p>"]
    let make ?allowed_value  ?minimum_engine_version  () =
      { allowed_value; minimum_engine_version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.minimum_engine_version
              (fun f -> ("minimum_engine_version", (String.to_json f)));
           Util.option_map v.allowed_value
             (fun f -> ("allowed_value", (String.to_json f)))])
    let parse xml =
      Some
        {
          allowed_value =
            (Util.option_bind (Xml.member "AllowedValue" xml) String.parse);
          minimum_engine_version =
            (Util.option_bind (Xml.member "MinimumEngineVersion" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.allowed_value
               (fun f ->
                  Ezxmlm.make_tag "AllowedValue" ([], (String.to_xml f)))])
           @
           [Util.option_map v.minimum_engine_version
              (fun f ->
                 Ezxmlm.make_tag "MinimumEngineVersion"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The minimum DB engine version required for each corresponding allowed value for an option setting.</p>"]
module AvailabilityZone =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Availability Zone.</p>"]}[@@ocaml.doc
                                                                   "<p>Contains Availability Zone information.</p> <p> This data type is used as an element in the <code>OrderableDBInstanceOption</code> data type.</p>"]
    let make ?name  () = { name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some { name = (Util.option_bind (Xml.member "Name" xml) String.parse) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.name
              (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains Availability Zone information.</p> <p> This data type is used as an element in the <code>OrderableDBInstanceOption</code> data type.</p>"]
module DBSecurityGroupMembership =
  struct
    type t =
      {
      d_b_security_group_name: String.t option
        [@ocaml.doc "<p>The name of the DB security group.</p>"];
      status: String.t option
        [@ocaml.doc "<p>The status of the DB security group.</p>"]}[@@ocaml.doc
                                                                    "<p>This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>ModifyDBInstance</code> </p> </li> <li> <p> <code>RebootDBInstance</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromDBSnapshot</code> </p> </li> <li> <p> <code>RestoreDBInstanceToPointInTime</code> </p> </li> </ul>"]
    let make ?d_b_security_group_name  ?status  () =
      { d_b_security_group_name; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.d_b_security_group_name
             (fun f -> ("d_b_security_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_security_group_name =
            (Util.option_bind (Xml.member "DBSecurityGroupName" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.d_b_security_group_name
               (fun f ->
                  Ezxmlm.make_tag "DBSecurityGroupName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>ModifyDBInstance</code> </p> </li> <li> <p> <code>RebootDBInstance</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromDBSnapshot</code> </p> </li> <li> <p> <code>RestoreDBInstanceToPointInTime</code> </p> </li> </ul>"]
module OptionSetting =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>The name of the option that has settings that you can set.</p>"];
      value: String.t option
        [@ocaml.doc "<p>The current value of the option setting.</p>"];
      default_value: String.t option
        [@ocaml.doc "<p>The default value of the option setting.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the option setting.</p>"];
      apply_type: String.t option
        [@ocaml.doc "<p>The DB engine specific parameter type.</p>"];
      data_type: String.t option
        [@ocaml.doc "<p>The data type of the option setting.</p>"];
      allowed_values: String.t option
        [@ocaml.doc "<p>The allowed values of the option setting.</p>"];
      is_modifiable: Boolean.t option
        [@ocaml.doc
          "<p>A Boolean value that, when true, indicates the option setting can be modified from the default.</p>"];
      is_collection: Boolean.t option
        [@ocaml.doc
          "<p>Indicates if the option setting is part of a collection.</p>"]}
    [@@ocaml.doc
      "<p>Option settings are the actual settings being applied or configured for that option. It is used when you modify an option group or describe option groups. For example, the NATIVE_NETWORK_ENCRYPTION option has a setting called SQLNET.ENCRYPTION_SERVER that can have several different values.</p>"]
    let make ?name  ?value  ?default_value  ?description  ?apply_type 
      ?data_type  ?allowed_values  ?is_modifiable  ?is_collection  () =
      {
        name;
        value;
        default_value;
        description;
        apply_type;
        data_type;
        allowed_values;
        is_modifiable;
        is_collection
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_collection
              (fun f -> ("is_collection", (Boolean.to_json f)));
           Util.option_map v.is_modifiable
             (fun f -> ("is_modifiable", (Boolean.to_json f)));
           Util.option_map v.allowed_values
             (fun f -> ("allowed_values", (String.to_json f)));
           Util.option_map v.data_type
             (fun f -> ("data_type", (String.to_json f)));
           Util.option_map v.apply_type
             (fun f -> ("apply_type", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.default_value
             (fun f -> ("default_value", (String.to_json f)));
           Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse);
          default_value =
            (Util.option_bind (Xml.member "DefaultValue" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          apply_type =
            (Util.option_bind (Xml.member "ApplyType" xml) String.parse);
          data_type =
            (Util.option_bind (Xml.member "DataType" xml) String.parse);
          allowed_values =
            (Util.option_bind (Xml.member "AllowedValues" xml) String.parse);
          is_modifiable =
            (Util.option_bind (Xml.member "IsModifiable" xml) Boolean.parse);
          is_collection =
            (Util.option_bind (Xml.member "IsCollection" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.name
                      (fun f ->
                         Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.value
                     (fun f ->
                        Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.default_value
                    (fun f ->
                       Ezxmlm.make_tag "DefaultValue" ([], (String.to_xml f)))])
                @
                [Util.option_map v.description
                   (fun f ->
                      Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
               @
               [Util.option_map v.apply_type
                  (fun f ->
                     Ezxmlm.make_tag "ApplyType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.data_type
                 (fun f -> Ezxmlm.make_tag "DataType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.allowed_values
                (fun f ->
                   Ezxmlm.make_tag "AllowedValues" ([], (String.to_xml f)))])
            @
            [Util.option_map v.is_modifiable
               (fun f ->
                  Ezxmlm.make_tag "IsModifiable" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.is_collection
              (fun f ->
                 Ezxmlm.make_tag "IsCollection" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Option settings are the actual settings being applied or configured for that option. It is used when you modify an option group or describe option groups. For example, the NATIVE_NETWORK_ENCRYPTION option has a setting called SQLNET.ENCRYPTION_SERVER that can have several different values.</p>"]
module VpcSecurityGroupMembership =
  struct
    type t =
      {
      vpc_security_group_id: String.t option
        [@ocaml.doc "<p>The name of the VPC security group.</p>"];
      status: String.t option
        [@ocaml.doc "<p>The status of the VPC security group.</p>"]}[@@ocaml.doc
                                                                    "<p>This data type is used as a response element for queries on VPC security group membership.</p>"]
    let make ?vpc_security_group_id  ?status  () =
      { vpc_security_group_id; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.vpc_security_group_id
             (fun f -> ("vpc_security_group_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          vpc_security_group_id =
            (Util.option_bind (Xml.member "VpcSecurityGroupId" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.vpc_security_group_id
               (fun f ->
                  Ezxmlm.make_tag "VpcSecurityGroupId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type is used as a response element for queries on VPC security group membership.</p>"]
module MinimumEngineVersionPerAllowedValueList =
  struct
    type t = MinimumEngineVersionPerAllowedValue.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list MinimumEngineVersionPerAllowedValue.to_query v
    let to_headers v =
      Headers.to_headers_list MinimumEngineVersionPerAllowedValue.to_headers
        v
    let to_json v =
      `List (List.map MinimumEngineVersionPerAllowedValue.to_json v)
    let parse xml =
      Util.option_all
        (List.map MinimumEngineVersionPerAllowedValue.parse
           (Xml.members "MinimumEngineVersionPerAllowedValue" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (MinimumEngineVersionPerAllowedValue.to_xml x))) v
  end
module DoubleRange =
  struct
    type t =
      {
      from: Double.t option
        [@ocaml.doc "<p>The minimum value in the range.</p>"];
      to_: Double.t option
        [@ocaml.doc "<p>The maximum value in the range.</p>"]}[@@ocaml.doc
                                                                "<p>A range of double values.</p>"]
    let make ?from  ?to_  () = { from; to_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.to_ (fun f -> ("to_", (Double.to_json f)));
           Util.option_map v.from (fun f -> ("from", (Double.to_json f)))])
    let parse xml =
      Some
        {
          from = (Util.option_bind (Xml.member "From" xml) Double.parse);
          to_ = (Util.option_bind (Xml.member "To" xml) Double.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.from
               (fun f -> Ezxmlm.make_tag "From" ([], (Double.to_xml f)))])
           @
           [Util.option_map v.to_
              (fun f -> Ezxmlm.make_tag "To" ([], (Double.to_xml f)))])
  end[@@ocaml.doc "<p>A range of double values.</p>"]
module Range =
  struct
    type t =
      {
      from: Integer.t option
        [@ocaml.doc "<p>The minimum value in the range.</p>"];
      to_: Integer.t option
        [@ocaml.doc "<p>The maximum value in the range.</p>"];
      step: Integer.t option
        [@ocaml.doc
          "<p>The step value for the range. For example, if you have a range of 5,000 to 10,000, with a step value of 1,000, the valid values start at 5,000 and step up by 1,000. Even though 7,500 is within the range, it isn't a valid value for the range. The valid values are 5,000, 6,000, 7,000, 8,000... </p>"]}
    [@@ocaml.doc "<p>A range of integer values.</p>"]
    let make ?from  ?to_  ?step  () = { from; to_; step }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.step (fun f -> ("step", (Integer.to_json f)));
           Util.option_map v.to_ (fun f -> ("to_", (Integer.to_json f)));
           Util.option_map v.from (fun f -> ("from", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          from = (Util.option_bind (Xml.member "From" xml) Integer.parse);
          to_ = (Util.option_bind (Xml.member "To" xml) Integer.parse);
          step = (Util.option_bind (Xml.member "Step" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.from
                (fun f -> Ezxmlm.make_tag "From" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.to_
               (fun f -> Ezxmlm.make_tag "To" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.step
              (fun f -> Ezxmlm.make_tag "Step" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc "<p>A range of integer values.</p>"]
module AuthScheme =
  struct
    type t =
      | SECRETS 
    let str_to_t = [("SECRETS", SECRETS)]
    let t_to_str = [(SECRETS, "SECRETS")]
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
module IAMAuthMode =
  struct
    type t =
      | DISABLED 
      | REQUIRED 
    let str_to_t = [("REQUIRED", REQUIRED); ("DISABLED", DISABLED)]
    let t_to_str = [(REQUIRED, "REQUIRED"); (DISABLED, "DISABLED")]
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
module Subnet =
  struct
    type t =
      {
      subnet_identifier: String.t option
        [@ocaml.doc "<p>Specifies the identifier of the subnet.</p>"];
      subnet_availability_zone: AvailabilityZone.t option ;
      subnet_status: String.t option
        [@ocaml.doc "<p>Specifies the status of the subnet.</p>"]}[@@ocaml.doc
                                                                    "<p> This data type is used as a response element in the <code>DescribeDBSubnetGroups</code> action. </p>"]
    let make ?subnet_identifier  ?subnet_availability_zone  ?subnet_status 
      () = { subnet_identifier; subnet_availability_zone; subnet_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.subnet_status
              (fun f -> ("subnet_status", (String.to_json f)));
           Util.option_map v.subnet_availability_zone
             (fun f ->
                ("subnet_availability_zone", (AvailabilityZone.to_json f)));
           Util.option_map v.subnet_identifier
             (fun f -> ("subnet_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          subnet_identifier =
            (Util.option_bind (Xml.member "SubnetIdentifier" xml)
               String.parse);
          subnet_availability_zone =
            (Util.option_bind (Xml.member "SubnetAvailabilityZone" xml)
               AvailabilityZone.parse);
          subnet_status =
            (Util.option_bind (Xml.member "SubnetStatus" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.subnet_identifier
                (fun f ->
                   Ezxmlm.make_tag "SubnetIdentifier" ([], (String.to_xml f)))])
            @
            [Util.option_map v.subnet_availability_zone
               (fun f ->
                  Ezxmlm.make_tag "SubnetAvailabilityZone"
                    ([], (AvailabilityZone.to_xml f)))])
           @
           [Util.option_map v.subnet_status
              (fun f ->
                 Ezxmlm.make_tag "SubnetStatus" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>DescribeDBSubnetGroups</code> action. </p>"]
module LogTypeList =
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
module ProcessorFeature =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>The name of the processor feature. Valid names are <code>coreCount</code> and <code>threadsPerCore</code>.</p>"];
      value: String.t option
        [@ocaml.doc "<p>The value of a processor feature name.</p>"]}
    [@@ocaml.doc
      "<p>Contains the processor features of a DB instance class.</p> <p>To specify the number of CPU cores, use the <code>coreCount</code> feature name for the <code>Name</code> parameter. To specify the number of threads per core, use the <code>threadsPerCore</code> feature name for the <code>Name</code> parameter.</p> <p>You can set the processor features of the DB instance class for a DB instance when you call one of the following actions:</p> <ul> <li> <p> <code>CreateDBInstance</code> </p> </li> <li> <p> <code>ModifyDBInstance</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromDBSnapshot</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromS3</code> </p> </li> <li> <p> <code>RestoreDBInstanceToPointInTime</code> </p> </li> </ul> <p>You can view the valid processor values for a particular instance class by calling the <code>DescribeOrderableDBInstanceOptions</code> action and specifying the instance class for the <code>DBInstanceClass</code> parameter.</p> <p>In addition, you can use the following actions for DB instance class processor information:</p> <ul> <li> <p> <code>DescribeDBInstances</code> </p> </li> <li> <p> <code>DescribeDBSnapshots</code> </p> </li> <li> <p> <code>DescribeValidDBInstanceModifications</code> </p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor\">Configuring the Processor of the DB Instance Class</a> in the <i>Amazon RDS User Guide. </i> </p>"]
    let make ?name  ?value  () = { name; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.name
               (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the processor features of a DB instance class.</p> <p>To specify the number of CPU cores, use the <code>coreCount</code> feature name for the <code>Name</code> parameter. To specify the number of threads per core, use the <code>threadsPerCore</code> feature name for the <code>Name</code> parameter.</p> <p>You can set the processor features of the DB instance class for a DB instance when you call one of the following actions:</p> <ul> <li> <p> <code>CreateDBInstance</code> </p> </li> <li> <p> <code>ModifyDBInstance</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromDBSnapshot</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromS3</code> </p> </li> <li> <p> <code>RestoreDBInstanceToPointInTime</code> </p> </li> </ul> <p>You can view the valid processor values for a particular instance class by calling the <code>DescribeOrderableDBInstanceOptions</code> action and specifying the instance class for the <code>DBInstanceClass</code> parameter.</p> <p>In addition, you can use the following actions for DB instance class processor information:</p> <ul> <li> <p> <code>DescribeDBInstances</code> </p> </li> <li> <p> <code>DescribeDBSnapshots</code> </p> </li> <li> <p> <code>DescribeValidDBInstanceModifications</code> </p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor\">Configuring the Processor of the DB Instance Class</a> in the <i>Amazon RDS User Guide. </i> </p>"]
module ReadersArnList =
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
module DBSecurityGroupMembershipList =
  struct
    type t = DBSecurityGroupMembership.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBSecurityGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list DBSecurityGroupMembership.to_headers v
    let to_json v = `List (List.map DBSecurityGroupMembership.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBSecurityGroupMembership.parse
           (Xml.members "DBSecurityGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (DBSecurityGroupMembership.to_xml x))) v
  end
module OptionSettingConfigurationList =
  struct
    type t = OptionSetting.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionSetting.to_query v
    let to_headers v = Headers.to_headers_list OptionSetting.to_headers v
    let to_json v = `List (List.map OptionSetting.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionSetting.parse (Xml.members "OptionSetting" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (OptionSetting.to_xml x))) v
  end
module VpcSecurityGroupMembershipList =
  struct
    type t = VpcSecurityGroupMembership.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list VpcSecurityGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list VpcSecurityGroupMembership.to_headers v
    let to_json v = `List (List.map VpcSecurityGroupMembership.to_json v)
    let parse xml =
      Util.option_all
        (List.map VpcSecurityGroupMembership.parse
           (Xml.members "VpcSecurityGroupMembership" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (VpcSecurityGroupMembership.to_xml x))) v
  end
module OptionGroupOptionSetting =
  struct
    type t =
      {
      setting_name: String.t option
        [@ocaml.doc "<p>The name of the option group option.</p>"];
      setting_description: String.t option
        [@ocaml.doc "<p>The description of the option group option.</p>"];
      default_value: String.t option
        [@ocaml.doc "<p>The default value for the option group option.</p>"];
      apply_type: String.t option
        [@ocaml.doc
          "<p>The DB engine specific parameter type for the option group option.</p>"];
      allowed_values: String.t option
        [@ocaml.doc
          "<p>Indicates the acceptable values for the option group option.</p>"];
      is_modifiable: Boolean.t option
        [@ocaml.doc
          "<p>Boolean value where true indicates that this option group option can be changed from the default value.</p>"];
      is_required: Boolean.t option
        [@ocaml.doc
          "<p>Boolean value where true indicates that a value must be specified for this option setting of the option group option.</p>"];
      minimum_engine_version_per_allowed_value:
        MinimumEngineVersionPerAllowedValueList.t
        [@ocaml.doc
          "<p>The minimum DB engine version required for the corresponding allowed value for this option setting.</p>"]}
    [@@ocaml.doc
      "<p>Option group option settings are used to display settings available for each option with their default values and other information. These values are used with the DescribeOptionGroupOptions action.</p>"]
    let make ?setting_name  ?setting_description  ?default_value  ?apply_type
       ?allowed_values  ?is_modifiable  ?is_required 
      ?(minimum_engine_version_per_allowed_value= [])  () =
      {
        setting_name;
        setting_description;
        default_value;
        apply_type;
        allowed_values;
        is_modifiable;
        is_required;
        minimum_engine_version_per_allowed_value
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("minimum_engine_version_per_allowed_value",
                (MinimumEngineVersionPerAllowedValueList.to_json
                   v.minimum_engine_version_per_allowed_value));
           Util.option_map v.is_required
             (fun f -> ("is_required", (Boolean.to_json f)));
           Util.option_map v.is_modifiable
             (fun f -> ("is_modifiable", (Boolean.to_json f)));
           Util.option_map v.allowed_values
             (fun f -> ("allowed_values", (String.to_json f)));
           Util.option_map v.apply_type
             (fun f -> ("apply_type", (String.to_json f)));
           Util.option_map v.default_value
             (fun f -> ("default_value", (String.to_json f)));
           Util.option_map v.setting_description
             (fun f -> ("setting_description", (String.to_json f)));
           Util.option_map v.setting_name
             (fun f -> ("setting_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          setting_name =
            (Util.option_bind (Xml.member "SettingName" xml) String.parse);
          setting_description =
            (Util.option_bind (Xml.member "SettingDescription" xml)
               String.parse);
          default_value =
            (Util.option_bind (Xml.member "DefaultValue" xml) String.parse);
          apply_type =
            (Util.option_bind (Xml.member "ApplyType" xml) String.parse);
          allowed_values =
            (Util.option_bind (Xml.member "AllowedValues" xml) String.parse);
          is_modifiable =
            (Util.option_bind (Xml.member "IsModifiable" xml) Boolean.parse);
          is_required =
            (Util.option_bind (Xml.member "IsRequired" xml) Boolean.parse);
          minimum_engine_version_per_allowed_value =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "MinimumEngineVersionPerAllowedValue" xml)
                  MinimumEngineVersionPerAllowedValueList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.setting_name
                     (fun f ->
                        Ezxmlm.make_tag "SettingName" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.setting_description
                    (fun f ->
                       Ezxmlm.make_tag "SettingDescription"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.default_value
                   (fun f ->
                      Ezxmlm.make_tag "DefaultValue" ([], (String.to_xml f)))])
               @
               [Util.option_map v.apply_type
                  (fun f ->
                     Ezxmlm.make_tag "ApplyType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.allowed_values
                 (fun f ->
                    Ezxmlm.make_tag "AllowedValues" ([], (String.to_xml f)))])
             @
             [Util.option_map v.is_modifiable
                (fun f ->
                   Ezxmlm.make_tag "IsModifiable" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.is_required
               (fun f ->
                  Ezxmlm.make_tag "IsRequired" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "MinimumEngineVersionPerAllowedValue"
                      ([],
                        (MinimumEngineVersionPerAllowedValueList.to_xml [x]))))
              v.minimum_engine_version_per_allowed_value))
  end[@@ocaml.doc
       "<p>Option group option settings are used to display settings available for each option with their default values and other information. These values are used with the DescribeOptionGroupOptions action.</p>"]
module OptionVersion =
  struct
    type t =
      {
      version: String.t option
        [@ocaml.doc "<p>The version of the option.</p>"];
      is_default: Boolean.t option
        [@ocaml.doc
          "<p>True if the version is the default version of the option, and otherwise false.</p>"]}
    [@@ocaml.doc
      "<p>The version for an option. Option group option versions are returned by the <code>DescribeOptionGroupOptions</code> action.</p>"]
    let make ?version  ?is_default  () = { version; is_default }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_default
              (fun f -> ("is_default", (Boolean.to_json f)));
           Util.option_map v.version
             (fun f -> ("version", (String.to_json f)))])
    let parse xml =
      Some
        {
          version =
            (Util.option_bind (Xml.member "Version" xml) String.parse);
          is_default =
            (Util.option_bind (Xml.member "IsDefault" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.version
               (fun f -> Ezxmlm.make_tag "Version" ([], (String.to_xml f)))])
           @
           [Util.option_map v.is_default
              (fun f -> Ezxmlm.make_tag "IsDefault" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>The version for an option. Option group option versions are returned by the <code>DescribeOptionGroupOptions</code> action.</p>"]
module DoubleRangeList =
  struct
    type t = DoubleRange.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DoubleRange.to_query v
    let to_headers v = Headers.to_headers_list DoubleRange.to_headers v
    let to_json v = `List (List.map DoubleRange.to_json v)
    let parse xml =
      Util.option_all
        (List.map DoubleRange.parse (Xml.members "DoubleRange" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DoubleRange.to_xml x))) v
  end
module RangeList =
  struct
    type t = Range.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Range.to_query v
    let to_headers v = Headers.to_headers_list Range.to_headers v
    let to_json v = `List (List.map Range.to_json v)
    let parse xml =
      Util.option_all (List.map Range.parse (Xml.members "Range" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Range.to_xml x))) v
  end
module ApplyMethod =
  struct
    type t =
      | Immediate 
      | Pending_reboot 
    let str_to_t =
      [("pending-reboot", Pending_reboot); ("immediate", Immediate)]
    let t_to_str =
      [(Pending_reboot, "pending-reboot"); (Immediate, "immediate")]
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
module EngineModeList =
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
module RecurringCharge =
  struct
    type t =
      {
      recurring_charge_amount: Double.t option
        [@ocaml.doc "<p>The amount of the recurring charge.</p>"];
      recurring_charge_frequency: String.t option
        [@ocaml.doc "<p>The frequency of the recurring charge.</p>"]}
    [@@ocaml.doc
      "<p> This data type is used as a response element in the <code>DescribeReservedDBInstances</code> and <code>DescribeReservedDBInstancesOfferings</code> actions. </p>"]
    let make ?recurring_charge_amount  ?recurring_charge_frequency  () =
      { recurring_charge_amount; recurring_charge_frequency }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.recurring_charge_frequency
              (fun f -> ("recurring_charge_frequency", (String.to_json f)));
           Util.option_map v.recurring_charge_amount
             (fun f -> ("recurring_charge_amount", (Double.to_json f)))])
    let parse xml =
      Some
        {
          recurring_charge_amount =
            (Util.option_bind (Xml.member "RecurringChargeAmount" xml)
               Double.parse);
          recurring_charge_frequency =
            (Util.option_bind (Xml.member "RecurringChargeFrequency" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.recurring_charge_amount
               (fun f ->
                  Ezxmlm.make_tag "RecurringChargeAmount"
                    ([], (Double.to_xml f)))])
           @
           [Util.option_map v.recurring_charge_frequency
              (fun f ->
                 Ezxmlm.make_tag "RecurringChargeFrequency"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>DescribeReservedDBInstances</code> and <code>DescribeReservedDBInstancesOfferings</code> actions. </p>"]
module AttributeValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "AttributeValue" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module PendingMaintenanceAction =
  struct
    type t =
      {
      action: String.t option
        [@ocaml.doc
          "<p>The type of pending maintenance action that is available for the resource. Valid actions are <code>system-update</code>, <code>db-upgrade</code>, <code>hardware-maintenance</code>, and <code>ca-certificate-rotation</code>.</p>"];
      auto_applied_after_date: DateTime.t option
        [@ocaml.doc
          "<p>The date of the maintenance window when the action is applied. The maintenance action is applied to the resource during its first maintenance window after this date.</p>"];
      forced_apply_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when the maintenance action is automatically applied. The maintenance action is applied to the resource on this date regardless of the maintenance window for the resource.</p>"];
      opt_in_status: String.t option
        [@ocaml.doc
          "<p>Indicates the type of opt-in request that has been received for the resource.</p>"];
      current_apply_date: DateTime.t option
        [@ocaml.doc
          "<p>The effective date when the pending maintenance action is applied to the resource. This date takes into account opt-in requests received from the <code>ApplyPendingMaintenanceAction</code> API, the <code>AutoAppliedAfterDate</code>, and the <code>ForcedApplyDate</code>. This value is blank if an opt-in request has not been received and nothing has been specified as <code>AutoAppliedAfterDate</code> or <code>ForcedApplyDate</code>.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description providing more detail about the maintenance action.</p>"]}
    [@@ocaml.doc
      "<p>Provides information about a pending maintenance action for a resource.</p>"]
    let make ?action  ?auto_applied_after_date  ?forced_apply_date 
      ?opt_in_status  ?current_apply_date  ?description  () =
      {
        action;
        auto_applied_after_date;
        forced_apply_date;
        opt_in_status;
        current_apply_date;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.current_apply_date
             (fun f -> ("current_apply_date", (DateTime.to_json f)));
           Util.option_map v.opt_in_status
             (fun f -> ("opt_in_status", (String.to_json f)));
           Util.option_map v.forced_apply_date
             (fun f -> ("forced_apply_date", (DateTime.to_json f)));
           Util.option_map v.auto_applied_after_date
             (fun f -> ("auto_applied_after_date", (DateTime.to_json f)));
           Util.option_map v.action (fun f -> ("action", (String.to_json f)))])
    let parse xml =
      Some
        {
          action = (Util.option_bind (Xml.member "Action" xml) String.parse);
          auto_applied_after_date =
            (Util.option_bind (Xml.member "AutoAppliedAfterDate" xml)
               DateTime.parse);
          forced_apply_date =
            (Util.option_bind (Xml.member "ForcedApplyDate" xml)
               DateTime.parse);
          opt_in_status =
            (Util.option_bind (Xml.member "OptInStatus" xml) String.parse);
          current_apply_date =
            (Util.option_bind (Xml.member "CurrentApplyDate" xml)
               DateTime.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.action
                   (fun f -> Ezxmlm.make_tag "Action" ([], (String.to_xml f)))])
               @
               [Util.option_map v.auto_applied_after_date
                  (fun f ->
                     Ezxmlm.make_tag "AutoAppliedAfterDate"
                       ([], (DateTime.to_xml f)))])
              @
              [Util.option_map v.forced_apply_date
                 (fun f ->
                    Ezxmlm.make_tag "ForcedApplyDate"
                      ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.opt_in_status
                (fun f ->
                   Ezxmlm.make_tag "OptInStatus" ([], (String.to_xml f)))])
            @
            [Util.option_map v.current_apply_date
               (fun f ->
                  Ezxmlm.make_tag "CurrentApplyDate"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.description
              (fun f -> Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Provides information about a pending maintenance action for a resource.</p>"]
module StringList =
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
module CharacterSet =
  struct
    type t =
      {
      character_set_name: String.t option
        [@ocaml.doc "<p>The name of the character set.</p>"];
      character_set_description: String.t option
        [@ocaml.doc "<p>The description of the character set.</p>"]}[@@ocaml.doc
                                                                    "<p> This data type is used as a response element in the action <code>DescribeDBEngineVersions</code>. </p>"]
    let make ?character_set_name  ?character_set_description  () =
      { character_set_name; character_set_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.character_set_description
              (fun f -> ("character_set_description", (String.to_json f)));
           Util.option_map v.character_set_name
             (fun f -> ("character_set_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          character_set_name =
            (Util.option_bind (Xml.member "CharacterSetName" xml)
               String.parse);
          character_set_description =
            (Util.option_bind (Xml.member "CharacterSetDescription" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.character_set_name
               (fun f ->
                  Ezxmlm.make_tag "CharacterSetName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.character_set_description
              (fun f ->
                 Ezxmlm.make_tag "CharacterSetDescription"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the action <code>DescribeDBEngineVersions</code>. </p>"]
module Timezone =
  struct
    type t =
      {
      timezone_name: String.t option
        [@ocaml.doc "<p>The name of the time zone.</p>"]}[@@ocaml.doc
                                                           "<p>A time zone associated with a <code>DBInstance</code> or a <code>DBSnapshot</code>. This data type is an element in the response to the <code>DescribeDBInstances</code>, the <code>DescribeDBSnapshots</code>, and the <code>DescribeDBEngineVersions</code> actions. </p>"]
    let make ?timezone_name  () = { timezone_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timezone_name
              (fun f -> ("timezone_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          timezone_name =
            (Util.option_bind (Xml.member "TimezoneName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.timezone_name
              (fun f ->
                 Ezxmlm.make_tag "TimezoneName" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>A time zone associated with a <code>DBInstance</code> or a <code>DBSnapshot</code>. This data type is an element in the response to the <code>DescribeDBInstances</code>, the <code>DescribeDBSnapshots</code>, and the <code>DescribeDBEngineVersions</code> actions. </p>"]
module UpgradeTarget =
  struct
    type t =
      {
      engine: String.t option
        [@ocaml.doc "<p>The name of the upgrade target database engine.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version number of the upgrade target database engine.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>The version of the database engine that a DB instance can be upgraded to.</p>"];
      auto_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the target version is applied to any source DB instances that have <code>AutoMinorVersionUpgrade</code> set to true.</p>"];
      is_major_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether a database engine is upgraded to a major version.</p>"]}
    [@@ocaml.doc
      "<p>The version of the database engine that a DB instance can be upgraded to.</p>"]
    let make ?engine  ?engine_version  ?description  ?auto_upgrade 
      ?is_major_version_upgrade  () =
      {
        engine;
        engine_version;
        description;
        auto_upgrade;
        is_major_version_upgrade
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_major_version_upgrade
              (fun f -> ("is_major_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.auto_upgrade
             (fun f -> ("auto_upgrade", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          auto_upgrade =
            (Util.option_bind (Xml.member "AutoUpgrade" xml) Boolean.parse);
          is_major_version_upgrade =
            (Util.option_bind (Xml.member "IsMajorVersionUpgrade" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.engine
                  (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
              @
              [Util.option_map v.engine_version
                 (fun f ->
                    Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.auto_upgrade
               (fun f ->
                  Ezxmlm.make_tag "AutoUpgrade" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.is_major_version_upgrade
              (fun f ->
                 Ezxmlm.make_tag "IsMajorVersionUpgrade"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>The version of the database engine that a DB instance can be upgraded to.</p>"]
module UserAuthConfigInfo =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p>A user-specified description about the authentication used by a proxy to log in as a specific database user.</p>"];
      user_name: String.t option
        [@ocaml.doc
          "<p>The name of the database user to which the proxy connects.</p>"];
      auth_scheme: AuthScheme.t option
        [@ocaml.doc
          "<p>The type of authentication that the proxy uses for connections from the proxy to the underlying database.</p>"];
      secret_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) representing the secret that the proxy uses to authenticate to the RDS DB instance or Aurora DB cluster. These secrets are stored within Amazon Secrets Manager.</p>"];
      i_a_m_auth: IAMAuthMode.t option
        [@ocaml.doc
          "<p>Whether to require or disallow AWS Identity and Access Management (IAM) authentication for connections to the proxy.</p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Returns the details of authentication used by a proxy to log in as a specific database user.</p>"]
    let make ?description  ?user_name  ?auth_scheme  ?secret_arn  ?i_a_m_auth
       () = { description; user_name; auth_scheme; secret_arn; i_a_m_auth }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_a_m_auth
              (fun f -> ("i_a_m_auth", (IAMAuthMode.to_json f)));
           Util.option_map v.secret_arn
             (fun f -> ("secret_arn", (String.to_json f)));
           Util.option_map v.auth_scheme
             (fun f -> ("auth_scheme", (AuthScheme.to_json f)));
           Util.option_map v.user_name
             (fun f -> ("user_name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          user_name =
            (Util.option_bind (Xml.member "UserName" xml) String.parse);
          auth_scheme =
            (Util.option_bind (Xml.member "AuthScheme" xml) AuthScheme.parse);
          secret_arn =
            (Util.option_bind (Xml.member "SecretArn" xml) String.parse);
          i_a_m_auth =
            (Util.option_bind (Xml.member "IAMAuth" xml) IAMAuthMode.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
              @
              [Util.option_map v.user_name
                 (fun f -> Ezxmlm.make_tag "UserName" ([], (String.to_xml f)))])
             @
             [Util.option_map v.auth_scheme
                (fun f ->
                   Ezxmlm.make_tag "AuthScheme" ([], (AuthScheme.to_xml f)))])
            @
            [Util.option_map v.secret_arn
               (fun f -> Ezxmlm.make_tag "SecretArn" ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_a_m_auth
              (fun f ->
                 Ezxmlm.make_tag "IAMAuth" ([], (IAMAuthMode.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Returns the details of authentication used by a proxy to log in as a specific database user.</p>"]
module DBInstanceRole =
  struct
    type t =
      {
      role_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM role that is associated with the DB instance.</p>"];
      feature_name: String.t option
        [@ocaml.doc
          "<p>The name of the feature associated with the AWS Identity and Access Management (IAM) role. For the list of supported feature names, see <code>DBEngineVersion</code>. </p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Describes the state of association between the IAM role and the DB instance. The Status property returns one of the following values:</p> <ul> <li> <p> <code>ACTIVE</code> - the IAM role ARN is associated with the DB instance and can be used to access other AWS services on your behalf.</p> </li> <li> <p> <code>PENDING</code> - the IAM role ARN is being associated with the DB instance.</p> </li> <li> <p> <code>INVALID</code> - the IAM role ARN is associated with the DB instance, but the DB instance is unable to assume the IAM role in order to access other AWS services on your behalf.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Describes an AWS Identity and Access Management (IAM) role that is associated with a DB instance.</p>"]
    let make ?role_arn  ?feature_name  ?status  () =
      { role_arn; feature_name; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.feature_name
             (fun f -> ("feature_name", (String.to_json f)));
           Util.option_map v.role_arn
             (fun f -> ("role_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          role_arn =
            (Util.option_bind (Xml.member "RoleArn" xml) String.parse);
          feature_name =
            (Util.option_bind (Xml.member "FeatureName" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.role_arn
                (fun f -> Ezxmlm.make_tag "RoleArn" ([], (String.to_xml f)))])
            @
            [Util.option_map v.feature_name
               (fun f ->
                  Ezxmlm.make_tag "FeatureName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an AWS Identity and Access Management (IAM) role that is associated with a DB instance.</p>"]
module DBInstanceStatusInfo =
  struct
    type t =
      {
      status_type: String.t option
        [@ocaml.doc "<p>This value is currently \"read replication.\"</p>"];
      normal: Boolean.t option
        [@ocaml.doc
          "<p>Boolean value that is true if the instance is operating normally, or false if the instance is in an error state.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Status of the DB instance. For a StatusType of Read Replica, the values can be replicating, replication stop point set, replication stop point reached, error, stopped, or terminated.</p>"];
      message: String.t option
        [@ocaml.doc
          "<p>Details of the error if there is an error for the instance. If the instance isn't in an error state, this value is blank.</p>"]}
    [@@ocaml.doc
      "<p>Provides a list of status information for a DB instance.</p>"]
    let make ?status_type  ?normal  ?status  ?message  () =
      { status_type; normal; status; message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.normal
             (fun f -> ("normal", (Boolean.to_json f)));
           Util.option_map v.status_type
             (fun f -> ("status_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          status_type =
            (Util.option_bind (Xml.member "StatusType" xml) String.parse);
          normal = (Util.option_bind (Xml.member "Normal" xml) Boolean.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.status_type
                 (fun f ->
                    Ezxmlm.make_tag "StatusType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.normal
                (fun f -> Ezxmlm.make_tag "Normal" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.status
               (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
           @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Provides a list of status information for a DB instance.</p>"]
module DBParameterGroupStatus =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t option
        [@ocaml.doc "<p>The name of the DB parameter group.</p>"];
      parameter_apply_status: String.t option
        [@ocaml.doc "<p>The status of parameter updates.</p>"]}[@@ocaml.doc
                                                                 "<p>The status of the DB parameter group.</p> <p>This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>CreateDBInstance</code> </p> </li> <li> <p> <code>CreateDBInstanceReadReplica</code> </p> </li> <li> <p> <code>DeleteDBInstance</code> </p> </li> <li> <p> <code>ModifyDBInstance</code> </p> </li> <li> <p> <code>RebootDBInstance</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromDBSnapshot</code> </p> </li> </ul>"]
    let make ?d_b_parameter_group_name  ?parameter_apply_status  () =
      { d_b_parameter_group_name; parameter_apply_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameter_apply_status
              (fun f -> ("parameter_apply_status", (String.to_json f)));
           Util.option_map v.d_b_parameter_group_name
             (fun f -> ("d_b_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_parameter_group_name =
            (Util.option_bind (Xml.member "DBParameterGroupName" xml)
               String.parse);
          parameter_apply_status =
            (Util.option_bind (Xml.member "ParameterApplyStatus" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.d_b_parameter_group_name
               (fun f ->
                  Ezxmlm.make_tag "DBParameterGroupName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.parameter_apply_status
              (fun f ->
                 Ezxmlm.make_tag "ParameterApplyStatus"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>The status of the DB parameter group.</p> <p>This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>CreateDBInstance</code> </p> </li> <li> <p> <code>CreateDBInstanceReadReplica</code> </p> </li> <li> <p> <code>DeleteDBInstance</code> </p> </li> <li> <p> <code>ModifyDBInstance</code> </p> </li> <li> <p> <code>RebootDBInstance</code> </p> </li> <li> <p> <code>RestoreDBInstanceFromDBSnapshot</code> </p> </li> </ul>"]
module SubnetList =
  struct
    type t = Subnet.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Subnet.to_query v
    let to_headers v = Headers.to_headers_list Subnet.to_headers v
    let to_json v = `List (List.map Subnet.to_json v)
    let parse xml =
      Util.option_all (List.map Subnet.parse (Xml.members "Subnet" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Subnet.to_xml x))) v
  end
module DomainMembership =
  struct
    type t =
      {
      domain: String.t option
        [@ocaml.doc "<p>The identifier of the Active Directory Domain.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the DB instance's Active Directory Domain membership, such as joined, pending-join, failed etc).</p>"];
      f_q_d_n: String.t option
        [@ocaml.doc
          "<p>The fully qualified domain name of the Active Directory Domain.</p>"];
      i_a_m_role_name: String.t option
        [@ocaml.doc
          "<p>The name of the IAM role to be used when making API calls to the Directory Service.</p>"]}
    [@@ocaml.doc
      "<p>An Active Directory Domain membership record associated with the DB instance.</p>"]
    let make ?domain  ?status  ?f_q_d_n  ?i_a_m_role_name  () =
      { domain; status; f_q_d_n; i_a_m_role_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_a_m_role_name
              (fun f -> ("i_a_m_role_name", (String.to_json f)));
           Util.option_map v.f_q_d_n
             (fun f -> ("f_q_d_n", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.domain (fun f -> ("domain", (String.to_json f)))])
    let parse xml =
      Some
        {
          domain = (Util.option_bind (Xml.member "Domain" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          f_q_d_n = (Util.option_bind (Xml.member "FQDN" xml) String.parse);
          i_a_m_role_name =
            (Util.option_bind (Xml.member "IAMRoleName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.domain
                 (fun f -> Ezxmlm.make_tag "Domain" ([], (String.to_xml f)))])
             @
             [Util.option_map v.status
                (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
            @
            [Util.option_map v.f_q_d_n
               (fun f -> Ezxmlm.make_tag "FQDN" ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_a_m_role_name
              (fun f -> Ezxmlm.make_tag "IAMRoleName" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>An Active Directory Domain membership record associated with the DB instance.</p>"]
module OptionGroupMembership =
  struct
    type t =
      {
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the option group that the instance belongs to.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the DB instance's option group membership. Valid values are: <code>in-sync</code>, <code>pending-apply</code>, <code>pending-removal</code>, <code>pending-maintenance-apply</code>, <code>pending-maintenance-removal</code>, <code>applying</code>, <code>removing</code>, and <code>failed</code>. </p>"]}
    [@@ocaml.doc
      "<p>Provides information on the option groups the DB instance is a member of.</p>"]
    let make ?option_group_name  ?status  () = { option_group_name; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.option_group_name
               (fun f ->
                  Ezxmlm.make_tag "OptionGroupName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Provides information on the option groups the DB instance is a member of.</p>"]
module PendingCloudwatchLogsExports =
  struct
    type t =
      {
      log_types_to_enable: LogTypeList.t
        [@ocaml.doc
          "<p>Log types that are in the process of being deactivated. After they are deactivated, these log types aren't exported to CloudWatch Logs.</p>"];
      log_types_to_disable: LogTypeList.t
        [@ocaml.doc
          "<p>Log types that are in the process of being enabled. After they are enabled, these log types are exported to CloudWatch Logs.</p>"]}
    [@@ocaml.doc
      "<p>A list of the log types whose configuration is still pending. In other words, these log types are in the process of being activated or deactivated.</p>"]
    let make ?(log_types_to_enable= [])  ?(log_types_to_disable= [])  () =
      { log_types_to_enable; log_types_to_disable }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("log_types_to_disable",
                (LogTypeList.to_json v.log_types_to_disable));
           Some
             ("log_types_to_enable",
               (LogTypeList.to_json v.log_types_to_enable))])
    let parse xml =
      Some
        {
          log_types_to_enable =
            (Util.of_option []
               (Util.option_bind (Xml.member "LogTypesToEnable" xml)
                  LogTypeList.parse));
          log_types_to_disable =
            (Util.of_option []
               (Util.option_bind (Xml.member "LogTypesToDisable" xml)
                  LogTypeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "LogTypesToEnable"
                       ([], (LogTypeList.to_xml [x])))) v.log_types_to_enable))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "LogTypesToDisable"
                      ([], (LogTypeList.to_xml [x])))) v.log_types_to_disable))
  end[@@ocaml.doc
       "<p>A list of the log types whose configuration is still pending. In other words, these log types are in the process of being activated or deactivated.</p>"]
module ProcessorFeatureList =
  struct
    type t = ProcessorFeature.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ProcessorFeature.to_query v
    let to_headers v = Headers.to_headers_list ProcessorFeature.to_headers v
    let to_json v = `List (List.map ProcessorFeature.to_json v)
    let parse xml =
      Util.option_all
        (List.map ProcessorFeature.parse (Xml.members "ProcessorFeature" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (ProcessorFeature.to_xml x)))
        v
  end
module GlobalClusterMember =
  struct
    type t =
      {
      d_b_cluster_arn: String.t option
        [@ocaml.doc
          "<p> The Amazon Resource Name (ARN) for each Aurora cluster. </p>"];
      readers: ReadersArnList.t
        [@ocaml.doc
          "<p> The Amazon Resource Name (ARN) for each read-only secondary cluster associated with the Aurora global database. </p>"];
      is_writer: Boolean.t option
        [@ocaml.doc
          "<p> Specifies whether the Aurora cluster is the primary cluster (that is, has read-write capability) for the Aurora global database with which it is associated. </p>"]}
    [@@ocaml.doc
      "<p> A data structure with information about any primary and secondary clusters associated with an Aurora global database. </p>"]
    let make ?d_b_cluster_arn  ?(readers= [])  ?is_writer  () =
      { d_b_cluster_arn; readers; is_writer }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_writer
              (fun f -> ("is_writer", (Boolean.to_json f)));
           Some ("readers", (ReadersArnList.to_json v.readers));
           Util.option_map v.d_b_cluster_arn
             (fun f -> ("d_b_cluster_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_arn =
            (Util.option_bind (Xml.member "DBClusterArn" xml) String.parse);
          readers =
            (Util.of_option []
               (Util.option_bind (Xml.member "Readers" xml)
                  ReadersArnList.parse));
          is_writer =
            (Util.option_bind (Xml.member "IsWriter" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.d_b_cluster_arn
                (fun f ->
                   Ezxmlm.make_tag "DBClusterArn" ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Readers"
                       ([], (ReadersArnList.to_xml [x])))) v.readers))
           @
           [Util.option_map v.is_writer
              (fun f -> Ezxmlm.make_tag "IsWriter" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p> A data structure with information about any primary and secondary clusters associated with an Aurora global database. </p>"]
module Option =
  struct
    type t =
      {
      option_name: String.t option
        [@ocaml.doc "<p>The name of the option.</p>"];
      option_description: String.t option
        [@ocaml.doc "<p>The description of the option.</p>"];
      persistent: Boolean.t option
        [@ocaml.doc "<p>Indicate if this option is persistent.</p>"];
      permanent: Boolean.t option
        [@ocaml.doc "<p>Indicate if this option is permanent.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>If required, the port configured for this option to use.</p>"];
      option_version: String.t option
        [@ocaml.doc "<p>The version of the option.</p>"];
      option_settings: OptionSettingConfigurationList.t
        [@ocaml.doc "<p>The option settings for this option.</p>"];
      d_b_security_group_memberships: DBSecurityGroupMembershipList.t
        [@ocaml.doc
          "<p>If the option requires access to a port, then this DB security group allows access to the port.</p>"];
      vpc_security_group_memberships: VpcSecurityGroupMembershipList.t
        [@ocaml.doc
          "<p>If the option requires access to a port, then this VPC security group allows access to the port.</p>"]}
    [@@ocaml.doc "<p>Option details.</p>"]
    let make ?option_name  ?option_description  ?persistent  ?permanent 
      ?port  ?option_version  ?(option_settings= []) 
      ?(d_b_security_group_memberships= []) 
      ?(vpc_security_group_memberships= [])  () =
      {
        option_name;
        option_description;
        persistent;
        permanent;
        port;
        option_version;
        option_settings;
        d_b_security_group_memberships;
        vpc_security_group_memberships
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("vpc_security_group_memberships",
                (VpcSecurityGroupMembershipList.to_json
                   v.vpc_security_group_memberships));
           Some
             ("d_b_security_group_memberships",
               (DBSecurityGroupMembershipList.to_json
                  v.d_b_security_group_memberships));
           Some
             ("option_settings",
               (OptionSettingConfigurationList.to_json v.option_settings));
           Util.option_map v.option_version
             (fun f -> ("option_version", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.permanent
             (fun f -> ("permanent", (Boolean.to_json f)));
           Util.option_map v.persistent
             (fun f -> ("persistent", (Boolean.to_json f)));
           Util.option_map v.option_description
             (fun f -> ("option_description", (String.to_json f)));
           Util.option_map v.option_name
             (fun f -> ("option_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          option_name =
            (Util.option_bind (Xml.member "OptionName" xml) String.parse);
          option_description =
            (Util.option_bind (Xml.member "OptionDescription" xml)
               String.parse);
          persistent =
            (Util.option_bind (Xml.member "Persistent" xml) Boolean.parse);
          permanent =
            (Util.option_bind (Xml.member "Permanent" xml) Boolean.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          option_version =
            (Util.option_bind (Xml.member "OptionVersion" xml) String.parse);
          option_settings =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionSettings" xml)
                  OptionSettingConfigurationList.parse));
          d_b_security_group_memberships =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "DBSecurityGroupMemberships" xml)
                  DBSecurityGroupMembershipList.parse));
          vpc_security_group_memberships =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "VpcSecurityGroupMemberships" xml)
                  VpcSecurityGroupMembershipList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.option_name
                      (fun f ->
                         Ezxmlm.make_tag "OptionName" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.option_description
                     (fun f ->
                        Ezxmlm.make_tag "OptionDescription"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.persistent
                    (fun f ->
                       Ezxmlm.make_tag "Persistent" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.permanent
                   (fun f ->
                      Ezxmlm.make_tag "Permanent" ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.port
                  (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.option_version
                 (fun f ->
                    Ezxmlm.make_tag "OptionVersion" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "OptionSettings"
                        ([], (OptionSettingConfigurationList.to_xml [x]))))
                v.option_settings))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DBSecurityGroupMemberships"
                       ([], (DBSecurityGroupMembershipList.to_xml [x]))))
               v.d_b_security_group_memberships))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "VpcSecurityGroupMemberships"
                      ([], (VpcSecurityGroupMembershipList.to_xml [x]))))
              v.vpc_security_group_memberships))
  end[@@ocaml.doc "<p>Option details.</p>"]
module AvailableProcessorFeature =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>The name of the processor feature. Valid names are <code>coreCount</code> and <code>threadsPerCore</code>.</p>"];
      default_value: String.t option
        [@ocaml.doc
          "<p>The default value for the processor feature of the DB instance class.</p>"];
      allowed_values: String.t option
        [@ocaml.doc
          "<p>The allowed values for the processor feature of the DB instance class.</p>"]}
    [@@ocaml.doc
      "<p>Contains the available processor feature information for the DB instance class of a DB instance.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor\">Configuring the Processor of the DB Instance Class</a> in the <i>Amazon RDS User Guide. </i> </p>"]
    let make ?name  ?default_value  ?allowed_values  () =
      { name; default_value; allowed_values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.allowed_values
              (fun f -> ("allowed_values", (String.to_json f)));
           Util.option_map v.default_value
             (fun f -> ("default_value", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          default_value =
            (Util.option_bind (Xml.member "DefaultValue" xml) String.parse);
          allowed_values =
            (Util.option_bind (Xml.member "AllowedValues" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.name
                (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
            @
            [Util.option_map v.default_value
               (fun f ->
                  Ezxmlm.make_tag "DefaultValue" ([], (String.to_xml f)))])
           @
           [Util.option_map v.allowed_values
              (fun f ->
                 Ezxmlm.make_tag "AllowedValues" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the available processor feature information for the DB instance class of a DB instance.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html#USER_ConfigureProcessor\">Configuring the Processor of the DB Instance Class</a> in the <i>Amazon RDS User Guide. </i> </p>"]
module DBClusterMember =
  struct
    type t =
      {
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>Specifies the instance identifier for this member of the DB cluster.</p>"];
      is_cluster_writer: Boolean.t option
        [@ocaml.doc
          "<p>Value that is <code>true</code> if the cluster member is the primary instance for the DB cluster and <code>false</code> otherwise.</p>"];
      d_b_cluster_parameter_group_status: String.t option
        [@ocaml.doc
          "<p>Specifies the status of the DB cluster parameter group for this member of the DB cluster.</p>"];
      promotion_tier: Integer.t option
        [@ocaml.doc
          "<p>A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance\"> Fault Tolerance for an Aurora DB Cluster</a> in the <i>Amazon Aurora User Guide</i>. </p>"]}
    [@@ocaml.doc
      "<p>Contains information about an instance that is part of a DB cluster.</p>"]
    let make ?d_b_instance_identifier  ?is_cluster_writer 
      ?d_b_cluster_parameter_group_status  ?promotion_tier  () =
      {
        d_b_instance_identifier;
        is_cluster_writer;
        d_b_cluster_parameter_group_status;
        promotion_tier
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.promotion_tier
              (fun f -> ("promotion_tier", (Integer.to_json f)));
           Util.option_map v.d_b_cluster_parameter_group_status
             (fun f ->
                ("d_b_cluster_parameter_group_status", (String.to_json f)));
           Util.option_map v.is_cluster_writer
             (fun f -> ("is_cluster_writer", (Boolean.to_json f)));
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
               String.parse);
          is_cluster_writer =
            (Util.option_bind (Xml.member "IsClusterWriter" xml)
               Boolean.parse);
          d_b_cluster_parameter_group_status =
            (Util.option_bind
               (Xml.member "DBClusterParameterGroupStatus" xml) String.parse);
          promotion_tier =
            (Util.option_bind (Xml.member "PromotionTier" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.d_b_instance_identifier
                 (fun f ->
                    Ezxmlm.make_tag "DBInstanceIdentifier"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.is_cluster_writer
                (fun f ->
                   Ezxmlm.make_tag "IsClusterWriter" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.d_b_cluster_parameter_group_status
               (fun f ->
                  Ezxmlm.make_tag "DBClusterParameterGroupStatus"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.promotion_tier
              (fun f ->
                 Ezxmlm.make_tag "PromotionTier" ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains information about an instance that is part of a DB cluster.</p>"]
module DBClusterOptionGroupStatus =
  struct
    type t =
      {
      d_b_cluster_option_group_name: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the DB cluster option group.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Specifies the status of the DB cluster option group.</p>"]}
    [@@ocaml.doc
      "<p>Contains status information for a DB cluster option group.</p>"]
    let make ?d_b_cluster_option_group_name  ?status  () =
      { d_b_cluster_option_group_name; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.d_b_cluster_option_group_name
             (fun f -> ("d_b_cluster_option_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_option_group_name =
            (Util.option_bind (Xml.member "DBClusterOptionGroupName" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.d_b_cluster_option_group_name
               (fun f ->
                  Ezxmlm.make_tag "DBClusterOptionGroupName"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains status information for a DB cluster option group.</p>"]
module DBClusterRole =
  struct
    type t =
      {
      role_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM role that is associated with the DB cluster.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Describes the state of association between the IAM role and the DB cluster. The Status property returns one of the following values:</p> <ul> <li> <p> <code>ACTIVE</code> - the IAM role ARN is associated with the DB cluster and can be used to access other AWS services on your behalf.</p> </li> <li> <p> <code>PENDING</code> - the IAM role ARN is being associated with the DB cluster.</p> </li> <li> <p> <code>INVALID</code> - the IAM role ARN is associated with the DB cluster, but the DB cluster is unable to assume the IAM role in order to access other AWS services on your behalf.</p> </li> </ul>"];
      feature_name: String.t option
        [@ocaml.doc
          "<p>The name of the feature associated with the AWS Identity and Access Management (IAM) role. For the list of supported feature names, see <a>DBEngineVersion</a>. </p>"]}
    [@@ocaml.doc
      "<p>Describes an AWS Identity and Access Management (IAM) role that is associated with a DB cluster.</p>"]
    let make ?role_arn  ?status  ?feature_name  () =
      { role_arn; status; feature_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.feature_name
              (fun f -> ("feature_name", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.role_arn
             (fun f -> ("role_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          role_arn =
            (Util.option_bind (Xml.member "RoleArn" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          feature_name =
            (Util.option_bind (Xml.member "FeatureName" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.role_arn
                (fun f -> Ezxmlm.make_tag "RoleArn" ([], (String.to_xml f)))])
            @
            [Util.option_map v.status
               (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
           @
           [Util.option_map v.feature_name
              (fun f -> Ezxmlm.make_tag "FeatureName" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes an AWS Identity and Access Management (IAM) role that is associated with a DB cluster.</p>"]
module EC2SecurityGroup =
  struct
    type t =
      {
      status: String.t option
        [@ocaml.doc
          "<p>Provides the status of the EC2 security group. Status can be \"authorizing\", \"authorized\", \"revoking\", and \"revoked\".</p>"];
      e_c2_security_group_name: String.t option
        [@ocaml.doc "<p>Specifies the name of the EC2 security group.</p>"];
      e_c2_security_group_id: String.t option
        [@ocaml.doc "<p>Specifies the id of the EC2 security group.</p>"];
      e_c2_security_group_owner_id: String.t option
        [@ocaml.doc
          "<p> Specifies the AWS ID of the owner of the EC2 security group specified in the <code>EC2SecurityGroupName</code> field. </p>"]}
    [@@ocaml.doc
      "<p>This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>AuthorizeDBSecurityGroupIngress</code> </p> </li> <li> <p> <code>DescribeDBSecurityGroups</code> </p> </li> <li> <p> <code>RevokeDBSecurityGroupIngress</code> </p> </li> </ul>"]
    let make ?status  ?e_c2_security_group_name  ?e_c2_security_group_id 
      ?e_c2_security_group_owner_id  () =
      {
        status;
        e_c2_security_group_name;
        e_c2_security_group_id;
        e_c2_security_group_owner_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f -> ("e_c2_security_group_owner_id", (String.to_json f)));
           Util.option_map v.e_c2_security_group_id
             (fun f -> ("e_c2_security_group_id", (String.to_json f)));
           Util.option_map v.e_c2_security_group_name
             (fun f -> ("e_c2_security_group_name", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)))])
    let parse xml =
      Some
        {
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          e_c2_security_group_name =
            (Util.option_bind (Xml.member "EC2SecurityGroupName" xml)
               String.parse);
          e_c2_security_group_id =
            (Util.option_bind (Xml.member "EC2SecurityGroupId" xml)
               String.parse);
          e_c2_security_group_owner_id =
            (Util.option_bind (Xml.member "EC2SecurityGroupOwnerId" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.status
                 (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
             @
             [Util.option_map v.e_c2_security_group_name
                (fun f ->
                   Ezxmlm.make_tag "EC2SecurityGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.e_c2_security_group_id
               (fun f ->
                  Ezxmlm.make_tag "EC2SecurityGroupId"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.e_c2_security_group_owner_id
              (fun f ->
                 Ezxmlm.make_tag "EC2SecurityGroupOwnerId"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>AuthorizeDBSecurityGroupIngress</code> </p> </li> <li> <p> <code>DescribeDBSecurityGroups</code> </p> </li> <li> <p> <code>RevokeDBSecurityGroupIngress</code> </p> </li> </ul>"]
module IPRange =
  struct
    type t =
      {
      status: String.t option
        [@ocaml.doc
          "<p>Specifies the status of the IP range. Status can be \"authorizing\", \"authorized\", \"revoking\", and \"revoked\".</p>"];
      c_i_d_r_i_p: String.t option
        [@ocaml.doc "<p>Specifies the IP range.</p>"]}[@@ocaml.doc
                                                        "<p> This data type is used as a response element in the <code>DescribeDBSecurityGroups</code> action. </p>"]
    let make ?status  ?c_i_d_r_i_p  () = { status; c_i_d_r_i_p }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.c_i_d_r_i_p
              (fun f -> ("c_i_d_r_i_p", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)))])
    let parse xml =
      Some
        {
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          c_i_d_r_i_p =
            (Util.option_bind (Xml.member "CIDRIP" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.status
               (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
           @
           [Util.option_map v.c_i_d_r_i_p
              (fun f -> Ezxmlm.make_tag "CIDRIP" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>DescribeDBSecurityGroups</code> action. </p>"]
module FilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "Value" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module OptionGroupOptionSettingsList =
  struct
    type t = OptionGroupOptionSetting.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionGroupOptionSetting.to_query v
    let to_headers v =
      Headers.to_headers_list OptionGroupOptionSetting.to_headers v
    let to_json v = `List (List.map OptionGroupOptionSetting.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionGroupOptionSetting.parse
           (Xml.members "OptionGroupOptionSetting" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (OptionGroupOptionSetting.to_xml x)))
        v
  end
module OptionGroupOptionVersionsList =
  struct
    type t = OptionVersion.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionVersion.to_query v
    let to_headers v = Headers.to_headers_list OptionVersion.to_headers v
    let to_json v = `List (List.map OptionVersion.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionVersion.parse (Xml.members "OptionVersion" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (OptionVersion.to_xml x))) v
  end
module OptionsConflictsWith =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "OptionConflictName" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module OptionsDependedOn =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "OptionName" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ValidStorageOptions =
  struct
    type t =
      {
      storage_type: String.t option
        [@ocaml.doc
          "<p>The valid storage types for your DB instance. For example, gp2, io1. </p>"];
      storage_size: RangeList.t
        [@ocaml.doc
          "<p>The valid range of storage in gibibytes. For example, 100 to 16384. </p>"];
      provisioned_iops: RangeList.t
        [@ocaml.doc
          "<p>The valid range of provisioned IOPS. For example, 1000-20000. </p>"];
      iops_to_storage_ratio: DoubleRangeList.t
        [@ocaml.doc
          "<p>The valid range of Provisioned IOPS to gibibytes of storage multiplier. For example, 3-10, which means that provisioned IOPS can be between 3 and 10 times storage. </p>"];
      supports_storage_autoscaling: Boolean.t option
        [@ocaml.doc
          "<p>Whether or not Amazon RDS can automatically scale storage for DB instances that use the new instance class.</p>"]}
    [@@ocaml.doc
      "<p>Information about valid modifications that you can make to your DB instance. Contains the result of a successful call to the <code>DescribeValidDBInstanceModifications</code> action. </p>"]
    let make ?storage_type  ?(storage_size= [])  ?(provisioned_iops= []) 
      ?(iops_to_storage_ratio= [])  ?supports_storage_autoscaling  () =
      {
        storage_type;
        storage_size;
        provisioned_iops;
        iops_to_storage_ratio;
        supports_storage_autoscaling
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.supports_storage_autoscaling
              (fun f -> ("supports_storage_autoscaling", (Boolean.to_json f)));
           Some
             ("iops_to_storage_ratio",
               (DoubleRangeList.to_json v.iops_to_storage_ratio));
           Some ("provisioned_iops", (RangeList.to_json v.provisioned_iops));
           Some ("storage_size", (RangeList.to_json v.storage_size));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          storage_size =
            (Util.of_option []
               (Util.option_bind (Xml.member "StorageSize" xml)
                  RangeList.parse));
          provisioned_iops =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProvisionedIops" xml)
                  RangeList.parse));
          iops_to_storage_ratio =
            (Util.of_option []
               (Util.option_bind (Xml.member "IopsToStorageRatio" xml)
                  DoubleRangeList.parse));
          supports_storage_autoscaling =
            (Util.option_bind (Xml.member "SupportsStorageAutoscaling" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.storage_type
                  (fun f ->
                     Ezxmlm.make_tag "StorageType" ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "StorageSize"
                         ([], (RangeList.to_xml [x])))) v.storage_size))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "ProvisionedIops"
                        ([], (RangeList.to_xml [x])))) v.provisioned_iops))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "IopsToStorageRatio"
                       ([], (DoubleRangeList.to_xml [x]))))
               v.iops_to_storage_ratio))
           @
           [Util.option_map v.supports_storage_autoscaling
              (fun f ->
                 Ezxmlm.make_tag "SupportsStorageAutoscaling"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Information about valid modifications that you can make to your DB instance. Contains the result of a successful call to the <code>DescribeValidDBInstanceModifications</code> action. </p>"]
module VpnDetails =
  struct
    type t =
      {
      vpn_id: String.t option [@ocaml.doc "<p>The ID of the VPN.</p>"];
      vpn_tunnel_originator_i_p: String.t option
        [@ocaml.doc
          "<p>The IP address of network traffic from your on-premises data center. A custom AZ receives the network traffic.</p>"];
      vpn_gateway_ip: String.t option
        [@ocaml.doc
          "<p>The IP address of network traffic from AWS to your on-premises data center.</p>"];
      vpn_p_s_k: String.t option
        [@ocaml.doc "<p>The preshared key (PSK) for the VPN.</p>"];
      vpn_name: String.t option [@ocaml.doc "<p>The name of the VPN.</p>"];
      vpn_state: String.t option [@ocaml.doc "<p>The state of the VPN.</p>"]}
    [@@ocaml.doc
      "<p>Information about the virtual private network (VPN) between the VMware vSphere cluster and the AWS website.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p>"]
    let make ?vpn_id  ?vpn_tunnel_originator_i_p  ?vpn_gateway_ip  ?vpn_p_s_k
       ?vpn_name  ?vpn_state  () =
      {
        vpn_id;
        vpn_tunnel_originator_i_p;
        vpn_gateway_ip;
        vpn_p_s_k;
        vpn_name;
        vpn_state
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.vpn_state
              (fun f -> ("vpn_state", (String.to_json f)));
           Util.option_map v.vpn_name
             (fun f -> ("vpn_name", (String.to_json f)));
           Util.option_map v.vpn_p_s_k
             (fun f -> ("vpn_p_s_k", (String.to_json f)));
           Util.option_map v.vpn_gateway_ip
             (fun f -> ("vpn_gateway_ip", (String.to_json f)));
           Util.option_map v.vpn_tunnel_originator_i_p
             (fun f -> ("vpn_tunnel_originator_i_p", (String.to_json f)));
           Util.option_map v.vpn_id (fun f -> ("vpn_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          vpn_id = (Util.option_bind (Xml.member "VpnId" xml) String.parse);
          vpn_tunnel_originator_i_p =
            (Util.option_bind (Xml.member "VpnTunnelOriginatorIP" xml)
               String.parse);
          vpn_gateway_ip =
            (Util.option_bind (Xml.member "VpnGatewayIp" xml) String.parse);
          vpn_p_s_k =
            (Util.option_bind (Xml.member "VpnPSK" xml) String.parse);
          vpn_name =
            (Util.option_bind (Xml.member "VpnName" xml) String.parse);
          vpn_state =
            (Util.option_bind (Xml.member "VpnState" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.vpn_id
                   (fun f -> Ezxmlm.make_tag "VpnId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.vpn_tunnel_originator_i_p
                  (fun f ->
                     Ezxmlm.make_tag "VpnTunnelOriginatorIP"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.vpn_gateway_ip
                 (fun f ->
                    Ezxmlm.make_tag "VpnGatewayIp" ([], (String.to_xml f)))])
             @
             [Util.option_map v.vpn_p_s_k
                (fun f -> Ezxmlm.make_tag "VpnPSK" ([], (String.to_xml f)))])
            @
            [Util.option_map v.vpn_name
               (fun f -> Ezxmlm.make_tag "VpnName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.vpn_state
              (fun f -> Ezxmlm.make_tag "VpnState" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Information about the virtual private network (VPN) between the VMware vSphere cluster and the AWS website.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p>"]
module Parameter =
  struct
    type t =
      {
      parameter_name: String.t option
        [@ocaml.doc "<p>Specifies the name of the parameter.</p>"];
      parameter_value: String.t option
        [@ocaml.doc "<p>Specifies the value of the parameter.</p>"];
      description: String.t option
        [@ocaml.doc "<p>Provides a description of the parameter.</p>"];
      source: String.t option
        [@ocaml.doc "<p>Indicates the source of the parameter value.</p>"];
      apply_type: String.t option
        [@ocaml.doc "<p>Specifies the engine specific parameters type.</p>"];
      data_type: String.t option
        [@ocaml.doc
          "<p>Specifies the valid data type for the parameter.</p>"];
      allowed_values: String.t option
        [@ocaml.doc
          "<p>Specifies the valid range of values for the parameter.</p>"];
      is_modifiable: Boolean.t option
        [@ocaml.doc
          "<p> Indicates whether (<code>true</code>) or not (<code>false</code>) the parameter can be modified. Some parameters have security or operational implications that prevent them from being changed. </p>"];
      minimum_engine_version: String.t option
        [@ocaml.doc
          "<p>The earliest engine version to which the parameter can apply.</p>"];
      apply_method: ApplyMethod.t option
        [@ocaml.doc "<p>Indicates when to apply parameter updates.</p>"];
      supported_engine_modes: EngineModeList.t
        [@ocaml.doc "<p>The valid DB engine modes.</p>"]}[@@ocaml.doc
                                                           "<p> This data type is used as a request parameter in the <code>ModifyDBParameterGroup</code> and <code>ResetDBParameterGroup</code> actions. </p> <p>This data type is used as a response element in the <code>DescribeEngineDefaultParameters</code> and <code>DescribeDBParameters</code> actions.</p>"]
    let make ?parameter_name  ?parameter_value  ?description  ?source 
      ?apply_type  ?data_type  ?allowed_values  ?is_modifiable 
      ?minimum_engine_version  ?apply_method  ?(supported_engine_modes= []) 
      () =
      {
        parameter_name;
        parameter_value;
        description;
        source;
        apply_type;
        data_type;
        allowed_values;
        is_modifiable;
        minimum_engine_version;
        apply_method;
        supported_engine_modes
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("supported_engine_modes",
                (EngineModeList.to_json v.supported_engine_modes));
           Util.option_map v.apply_method
             (fun f -> ("apply_method", (ApplyMethod.to_json f)));
           Util.option_map v.minimum_engine_version
             (fun f -> ("minimum_engine_version", (String.to_json f)));
           Util.option_map v.is_modifiable
             (fun f -> ("is_modifiable", (Boolean.to_json f)));
           Util.option_map v.allowed_values
             (fun f -> ("allowed_values", (String.to_json f)));
           Util.option_map v.data_type
             (fun f -> ("data_type", (String.to_json f)));
           Util.option_map v.apply_type
             (fun f -> ("apply_type", (String.to_json f)));
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.parameter_value
             (fun f -> ("parameter_value", (String.to_json f)));
           Util.option_map v.parameter_name
             (fun f -> ("parameter_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          parameter_name =
            (Util.option_bind (Xml.member "ParameterName" xml) String.parse);
          parameter_value =
            (Util.option_bind (Xml.member "ParameterValue" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          source = (Util.option_bind (Xml.member "Source" xml) String.parse);
          apply_type =
            (Util.option_bind (Xml.member "ApplyType" xml) String.parse);
          data_type =
            (Util.option_bind (Xml.member "DataType" xml) String.parse);
          allowed_values =
            (Util.option_bind (Xml.member "AllowedValues" xml) String.parse);
          is_modifiable =
            (Util.option_bind (Xml.member "IsModifiable" xml) Boolean.parse);
          minimum_engine_version =
            (Util.option_bind (Xml.member "MinimumEngineVersion" xml)
               String.parse);
          apply_method =
            (Util.option_bind (Xml.member "ApplyMethod" xml)
               ApplyMethod.parse);
          supported_engine_modes =
            (Util.of_option []
               (Util.option_bind (Xml.member "SupportedEngineModes" xml)
                  EngineModeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.parameter_name
                        (fun f ->
                           Ezxmlm.make_tag "ParameterName"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.parameter_value
                       (fun f ->
                          Ezxmlm.make_tag "ParameterValue"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.description
                      (fun f ->
                         Ezxmlm.make_tag "Description"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.source
                     (fun f ->
                        Ezxmlm.make_tag "Source" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.apply_type
                    (fun f ->
                       Ezxmlm.make_tag "ApplyType" ([], (String.to_xml f)))])
                @
                [Util.option_map v.data_type
                   (fun f ->
                      Ezxmlm.make_tag "DataType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.allowed_values
                  (fun f ->
                     Ezxmlm.make_tag "AllowedValues" ([], (String.to_xml f)))])
              @
              [Util.option_map v.is_modifiable
                 (fun f ->
                    Ezxmlm.make_tag "IsModifiable" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.minimum_engine_version
                (fun f ->
                   Ezxmlm.make_tag "MinimumEngineVersion"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.apply_method
               (fun f ->
                  Ezxmlm.make_tag "ApplyMethod" ([], (ApplyMethod.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SupportedEngineModes"
                      ([], (EngineModeList.to_xml [x]))))
              v.supported_engine_modes))
  end[@@ocaml.doc
       "<p> This data type is used as a request parameter in the <code>ModifyDBParameterGroup</code> and <code>ResetDBParameterGroup</code> actions. </p> <p>This data type is used as a response element in the <code>DescribeEngineDefaultParameters</code> and <code>DescribeDBParameters</code> actions.</p>"]
module EventCategoriesList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "EventCategory" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module SourceIdsList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all (List.map String.parse (Xml.members "SourceId" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module DBSecurityGroupNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "DBSecurityGroupName" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module OptionSettingsList =
  struct
    type t = OptionSetting.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionSetting.to_query v
    let to_headers v = Headers.to_headers_list OptionSetting.to_headers v
    let to_json v = `List (List.map OptionSetting.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionSetting.parse (Xml.members "OptionSetting" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (OptionSetting.to_xml x))) v
  end
module VpcSecurityGroupIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "VpcSecurityGroupId" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module RecurringChargeList =
  struct
    type t = RecurringCharge.t list
    let make elems () = elems
    let to_query v = Query.to_query_list RecurringCharge.to_query v
    let to_headers v = Headers.to_headers_list RecurringCharge.to_headers v
    let to_json v = `List (List.map RecurringCharge.to_json v)
    let parse xml =
      Util.option_all
        (List.map RecurringCharge.parse (Xml.members "RecurringCharge" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (RecurringCharge.to_xml x)))
        v
  end
module DBClusterSnapshotAttribute =
  struct
    type t =
      {
      attribute_name: String.t option
        [@ocaml.doc
          "<p>The name of the manual DB cluster snapshot attribute.</p> <p>The attribute named <code>restore</code> refers to the list of AWS accounts that have permission to copy or restore the manual DB cluster snapshot. For more information, see the <code>ModifyDBClusterSnapshotAttribute</code> API action.</p>"];
      attribute_values: AttributeValueList.t
        [@ocaml.doc
          "<p>The value(s) for the manual DB cluster snapshot attribute.</p> <p>If the <code>AttributeName</code> field is set to <code>restore</code>, then this element returns a list of IDs of the AWS accounts that are authorized to copy or restore the manual DB cluster snapshot. If a value of <code>all</code> is in the list, then the manual DB cluster snapshot is public and available for any AWS account to copy or restore.</p>"]}
    [@@ocaml.doc
      "<p>Contains the name and values of a manual DB cluster snapshot attribute.</p> <p>Manual DB cluster snapshot attributes are used to authorize other AWS accounts to restore a manual DB cluster snapshot. For more information, see the <code>ModifyDBClusterSnapshotAttribute</code> API action.</p>"]
    let make ?attribute_name  ?(attribute_values= [])  () =
      { attribute_name; attribute_values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("attribute_values",
                (AttributeValueList.to_json v.attribute_values));
           Util.option_map v.attribute_name
             (fun f -> ("attribute_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          attribute_name =
            (Util.option_bind (Xml.member "AttributeName" xml) String.parse);
          attribute_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "AttributeValues" xml)
                  AttributeValueList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.attribute_name
               (fun f ->
                  Ezxmlm.make_tag "AttributeName" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AttributeValues"
                      ([], (AttributeValueList.to_xml [x]))))
              v.attribute_values))
  end[@@ocaml.doc
       "<p>Contains the name and values of a manual DB cluster snapshot attribute.</p> <p>Manual DB cluster snapshot attributes are used to authorize other AWS accounts to restore a manual DB cluster snapshot. For more information, see the <code>ModifyDBClusterSnapshotAttribute</code> API action.</p>"]
module PendingMaintenanceActionDetails =
  struct
    type t = PendingMaintenanceAction.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PendingMaintenanceAction.to_query v
    let to_headers v =
      Headers.to_headers_list PendingMaintenanceAction.to_headers v
    let to_json v = `List (List.map PendingMaintenanceAction.to_json v)
    let parse xml =
      Util.option_all
        (List.map PendingMaintenanceAction.parse
           (Xml.members "PendingMaintenanceAction" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (PendingMaintenanceAction.to_xml x)))
        v
  end
module ConnectionPoolConfigurationInfo =
  struct
    type t =
      {
      max_connections_percent: Integer.t option
        [@ocaml.doc
          "<p>The maximum size of the connection pool for each target in a target group. For Aurora MySQL, it is expressed as a percentage of the <code>max_connections</code> setting for the RDS DB instance or Aurora DB cluster used by the target group.</p>"];
      max_idle_connections_percent: Integer.t option
        [@ocaml.doc
          "<p> Controls how actively the proxy closes idle database connections in the connection pool. A high value enables the proxy to leave a high percentage of idle connections open. A low value causes the proxy to close idle client connections and return the underlying database connections to the connection pool. For Aurora MySQL, it is expressed as a percentage of the <code>max_connections</code> setting for the RDS DB instance or Aurora DB cluster used by the target group. </p>"];
      connection_borrow_timeout: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds for a proxy to wait for a connection to become available in the connection pool. Only applies when the proxy has opened its maximum number of connections and all connections are busy with client sessions.</p>"];
      session_pinning_filters: StringList.t
        [@ocaml.doc
          "<p>Each item in the list represents a class of SQL operations that normally cause all later statements in a session using a proxy to be pinned to the same underlying database connection. Including an item in the list exempts that class of SQL operations from the pinning behavior. Currently, the only allowed value is <code>EXCLUDE_VARIABLE_SETS</code>.</p>"];
      init_query: String.t option
        [@ocaml.doc
          "<p> One or more SQL statements for the proxy to run when opening each new database connection. Typically used with <code>SET</code> statements to make sure that each connection has identical settings such as time zone and character set. This setting is empty by default. For multiple statements, use semicolons as the separator. You can also include multiple variables in a single <code>SET</code> statement, such as <code>SET x=1, y=2</code>. </p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Displays the settings that control the size and behavior of the connection pool associated with a <code>DBProxyTarget</code>.</p>"]
    let make ?max_connections_percent  ?max_idle_connections_percent 
      ?connection_borrow_timeout  ?(session_pinning_filters= [])  ?init_query
       () =
      {
        max_connections_percent;
        max_idle_connections_percent;
        connection_borrow_timeout;
        session_pinning_filters;
        init_query
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.init_query
              (fun f -> ("init_query", (String.to_json f)));
           Some
             ("session_pinning_filters",
               (StringList.to_json v.session_pinning_filters));
           Util.option_map v.connection_borrow_timeout
             (fun f -> ("connection_borrow_timeout", (Integer.to_json f)));
           Util.option_map v.max_idle_connections_percent
             (fun f -> ("max_idle_connections_percent", (Integer.to_json f)));
           Util.option_map v.max_connections_percent
             (fun f -> ("max_connections_percent", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          max_connections_percent =
            (Util.option_bind (Xml.member "MaxConnectionsPercent" xml)
               Integer.parse);
          max_idle_connections_percent =
            (Util.option_bind (Xml.member "MaxIdleConnectionsPercent" xml)
               Integer.parse);
          connection_borrow_timeout =
            (Util.option_bind (Xml.member "ConnectionBorrowTimeout" xml)
               Integer.parse);
          session_pinning_filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "SessionPinningFilters" xml)
                  StringList.parse));
          init_query =
            (Util.option_bind (Xml.member "InitQuery" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.max_connections_percent
                  (fun f ->
                     Ezxmlm.make_tag "MaxConnectionsPercent"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.max_idle_connections_percent
                 (fun f ->
                    Ezxmlm.make_tag "MaxIdleConnectionsPercent"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.connection_borrow_timeout
                (fun f ->
                   Ezxmlm.make_tag "ConnectionBorrowTimeout"
                     ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "SessionPinningFilters"
                       ([], (StringList.to_xml [x]))))
               v.session_pinning_filters))
           @
           [Util.option_map v.init_query
              (fun f -> Ezxmlm.make_tag "InitQuery" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Displays the settings that control the size and behavior of the connection pool associated with a <code>DBProxyTarget</code>.</p>"]
module TargetType =
  struct
    type t =
      | RDS_INSTANCE 
      | RDS_SERVERLESS_ENDPOINT 
      | TRACKED_CLUSTER 
    let str_to_t =
      [("TRACKED_CLUSTER", TRACKED_CLUSTER);
      ("RDS_SERVERLESS_ENDPOINT", RDS_SERVERLESS_ENDPOINT);
      ("RDS_INSTANCE", RDS_INSTANCE)]
    let t_to_str =
      [(TRACKED_CLUSTER, "TRACKED_CLUSTER");
      (RDS_SERVERLESS_ENDPOINT, "RDS_SERVERLESS_ENDPOINT");
      (RDS_INSTANCE, "RDS_INSTANCE")]
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
module FeatureNameList =
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
module SupportedCharacterSetsList =
  struct
    type t = CharacterSet.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CharacterSet.to_query v
    let to_headers v = Headers.to_headers_list CharacterSet.to_headers v
    let to_json v = `List (List.map CharacterSet.to_json v)
    let parse xml =
      Util.option_all
        (List.map CharacterSet.parse (Xml.members "CharacterSet" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (CharacterSet.to_xml x))) v
  end
module SupportedTimezonesList =
  struct
    type t = Timezone.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Timezone.to_query v
    let to_headers v = Headers.to_headers_list Timezone.to_headers v
    let to_json v = `List (List.map Timezone.to_json v)
    let parse xml =
      Util.option_all (List.map Timezone.parse (Xml.members "Timezone" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Timezone.to_xml x)))
        v
  end
module ValidUpgradeTargetList =
  struct
    type t = UpgradeTarget.t list
    let make elems () = elems
    let to_query v = Query.to_query_list UpgradeTarget.to_query v
    let to_headers v = Headers.to_headers_list UpgradeTarget.to_headers v
    let to_json v = `List (List.map UpgradeTarget.to_json v)
    let parse xml =
      Util.option_all
        (List.map UpgradeTarget.parse (Xml.members "UpgradeTarget" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (UpgradeTarget.to_xml x))) v
  end
module DBSnapshotAttribute =
  struct
    type t =
      {
      attribute_name: String.t option
        [@ocaml.doc
          "<p>The name of the manual DB snapshot attribute.</p> <p>The attribute named <code>restore</code> refers to the list of AWS accounts that have permission to copy or restore the manual DB cluster snapshot. For more information, see the <code>ModifyDBSnapshotAttribute</code> API action.</p>"];
      attribute_values: AttributeValueList.t
        [@ocaml.doc
          "<p>The value or values for the manual DB snapshot attribute.</p> <p>If the <code>AttributeName</code> field is set to <code>restore</code>, then this element returns a list of IDs of the AWS accounts that are authorized to copy or restore the manual DB snapshot. If a value of <code>all</code> is in the list, then the manual DB snapshot is public and available for any AWS account to copy or restore.</p>"]}
    [@@ocaml.doc
      "<p>Contains the name and values of a manual DB snapshot attribute</p> <p>Manual DB snapshot attributes are used to authorize other AWS accounts to restore a manual DB snapshot. For more information, see the <code>ModifyDBSnapshotAttribute</code> API.</p>"]
    let make ?attribute_name  ?(attribute_values= [])  () =
      { attribute_name; attribute_values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("attribute_values",
                (AttributeValueList.to_json v.attribute_values));
           Util.option_map v.attribute_name
             (fun f -> ("attribute_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          attribute_name =
            (Util.option_bind (Xml.member "AttributeName" xml) String.parse);
          attribute_values =
            (Util.of_option []
               (Util.option_bind (Xml.member "AttributeValues" xml)
                  AttributeValueList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.attribute_name
               (fun f ->
                  Ezxmlm.make_tag "AttributeName" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AttributeValues"
                      ([], (AttributeValueList.to_xml [x]))))
              v.attribute_values))
  end[@@ocaml.doc
       "<p>Contains the name and values of a manual DB snapshot attribute</p> <p>Manual DB snapshot attributes are used to authorize other AWS accounts to restore a manual DB snapshot. For more information, see the <code>ModifyDBSnapshotAttribute</code> API.</p>"]
module DBProxyStatus =
  struct
    type t =
      | Available 
      | Modifying 
      | Incompatible_network 
      | Insufficient_resource_limits 
      | Creating 
      | Deleting 
    let str_to_t =
      [("deleting", Deleting);
      ("creating", Creating);
      ("insufficient-resource-limits", Insufficient_resource_limits);
      ("incompatible-network", Incompatible_network);
      ("modifying", Modifying);
      ("available", Available)]
    let t_to_str =
      [(Deleting, "deleting");
      (Creating, "creating");
      (Insufficient_resource_limits, "insufficient-resource-limits");
      (Incompatible_network, "incompatible-network");
      (Modifying, "modifying");
      (Available, "available")]
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
module UserAuthConfigInfoList =
  struct
    type t = UserAuthConfigInfo.t list
    let make elems () = elems
    let to_query v = Query.to_query_list UserAuthConfigInfo.to_query v
    let to_headers v =
      Headers.to_headers_list UserAuthConfigInfo.to_headers v
    let to_json v = `List (List.map UserAuthConfigInfo.to_json v)
    let parse xml =
      Util.option_all
        (List.map UserAuthConfigInfo.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (UserAuthConfigInfo.to_xml x))) v
  end
module DBInstanceRoles =
  struct
    type t = DBInstanceRole.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBInstanceRole.to_query v
    let to_headers v = Headers.to_headers_list DBInstanceRole.to_headers v
    let to_json v = `List (List.map DBInstanceRole.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBInstanceRole.parse (Xml.members "DBInstanceRole" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBInstanceRole.to_xml x))) v
  end
module DBInstanceStatusInfoList =
  struct
    type t = DBInstanceStatusInfo.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBInstanceStatusInfo.to_query v
    let to_headers v =
      Headers.to_headers_list DBInstanceStatusInfo.to_headers v
    let to_json v = `List (List.map DBInstanceStatusInfo.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBInstanceStatusInfo.parse
           (Xml.members "DBInstanceStatusInfo" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (DBInstanceStatusInfo.to_xml x))) v
  end
module DBParameterGroupStatusList =
  struct
    type t = DBParameterGroupStatus.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBParameterGroupStatus.to_query v
    let to_headers v =
      Headers.to_headers_list DBParameterGroupStatus.to_headers v
    let to_json v = `List (List.map DBParameterGroupStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBParameterGroupStatus.parse
           (Xml.members "DBParameterGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (DBParameterGroupStatus.to_xml x)))
        v
  end
module DBSubnetGroup =
  struct
    type t =
      {
      d_b_subnet_group_name: String.t option
        [@ocaml.doc "<p>The name of the DB subnet group.</p>"];
      d_b_subnet_group_description: String.t option
        [@ocaml.doc
          "<p>Provides the description of the DB subnet group.</p>"];
      vpc_id: String.t option
        [@ocaml.doc "<p>Provides the VpcId of the DB subnet group.</p>"];
      subnet_group_status: String.t option
        [@ocaml.doc "<p>Provides the status of the DB subnet group.</p>"];
      subnets: SubnetList.t
        [@ocaml.doc
          "<p> Contains a list of <code>Subnet</code> elements. </p>"];
      d_b_subnet_group_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB subnet group.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details of an Amazon RDS DB subnet group. </p> <p>This data type is used as a response element in the <code>DescribeDBSubnetGroups</code> action. </p>"]
    let make ?d_b_subnet_group_name  ?d_b_subnet_group_description  ?vpc_id 
      ?subnet_group_status  ?(subnets= [])  ?d_b_subnet_group_arn  () =
      {
        d_b_subnet_group_name;
        d_b_subnet_group_description;
        vpc_id;
        subnet_group_status;
        subnets;
        d_b_subnet_group_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_subnet_group_arn
              (fun f -> ("d_b_subnet_group_arn", (String.to_json f)));
           Some ("subnets", (SubnetList.to_json v.subnets));
           Util.option_map v.subnet_group_status
             (fun f -> ("subnet_group_status", (String.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.d_b_subnet_group_description
             (fun f -> ("d_b_subnet_group_description", (String.to_json f)));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          d_b_subnet_group_description =
            (Util.option_bind (Xml.member "DBSubnetGroupDescription" xml)
               String.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          subnet_group_status =
            (Util.option_bind (Xml.member "SubnetGroupStatus" xml)
               String.parse);
          subnets =
            (Util.of_option []
               (Util.option_bind (Xml.member "Subnets" xml) SubnetList.parse));
          d_b_subnet_group_arn =
            (Util.option_bind (Xml.member "DBSubnetGroupArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.d_b_subnet_group_name
                   (fun f ->
                      Ezxmlm.make_tag "DBSubnetGroupName"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.d_b_subnet_group_description
                  (fun f ->
                     Ezxmlm.make_tag "DBSubnetGroupDescription"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.vpc_id
                 (fun f -> Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.subnet_group_status
                (fun f ->
                   Ezxmlm.make_tag "SubnetGroupStatus"
                     ([], (String.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Subnets" ([], (SubnetList.to_xml [x]))))
               v.subnets))
           @
           [Util.option_map v.d_b_subnet_group_arn
              (fun f ->
                 Ezxmlm.make_tag "DBSubnetGroupArn" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details of an Amazon RDS DB subnet group. </p> <p>This data type is used as a response element in the <code>DescribeDBSubnetGroups</code> action. </p>"]
module DomainMembershipList =
  struct
    type t = DomainMembership.t list[@@ocaml.doc
                                      "<p>List of Active Directory Domain membership records associated with a DB instance.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list DomainMembership.to_query v
    let to_headers v = Headers.to_headers_list DomainMembership.to_headers v
    let to_json v = `List (List.map DomainMembership.to_json v)
    let parse xml =
      Util.option_all
        (List.map DomainMembership.parse (Xml.members "DomainMembership" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DomainMembership.to_xml x)))
        v
  end[@@ocaml.doc
       "<p>List of Active Directory Domain membership records associated with a DB instance.</p>"]
module Endpoint =
  struct
    type t =
      {
      address: String.t option
        [@ocaml.doc "<p>Specifies the DNS address of the DB instance.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>Specifies the port that the database engine is listening on.</p>"];
      hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.</p>"]}
    [@@ocaml.doc
      "<p>This data type represents the information you need to connect to an Amazon RDS DB instance. This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>CreateDBInstance</code> </p> </li> <li> <p> <code>DescribeDBInstances</code> </p> </li> <li> <p> <code>DeleteDBInstance</code> </p> </li> </ul> <p>For the data structure that represents Amazon Aurora DB cluster endpoints, see <code>DBClusterEndpoint</code>.</p>"]
    let make ?address  ?port  ?hosted_zone_id  () =
      { address; port; hosted_zone_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.hosted_zone_id
              (fun f -> ("hosted_zone_id", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.address
             (fun f -> ("address", (String.to_json f)))])
    let parse xml =
      Some
        {
          address =
            (Util.option_bind (Xml.member "Address" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          hosted_zone_id =
            (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.address
                (fun f -> Ezxmlm.make_tag "Address" ([], (String.to_xml f)))])
            @
            [Util.option_map v.port
               (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.hosted_zone_id
              (fun f ->
                 Ezxmlm.make_tag "HostedZoneId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type represents the information you need to connect to an Amazon RDS DB instance. This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>CreateDBInstance</code> </p> </li> <li> <p> <code>DescribeDBInstances</code> </p> </li> <li> <p> <code>DeleteDBInstance</code> </p> </li> </ul> <p>For the data structure that represents Amazon Aurora DB cluster endpoints, see <code>DBClusterEndpoint</code>.</p>"]
module OptionGroupMembershipList =
  struct
    type t = OptionGroupMembership.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionGroupMembership.to_query v
    let to_headers v =
      Headers.to_headers_list OptionGroupMembership.to_headers v
    let to_json v = `List (List.map OptionGroupMembership.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionGroupMembership.parse
           (Xml.members "OptionGroupMembership" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (OptionGroupMembership.to_xml x))) v
  end
module PendingModifiedValues =
  struct
    type t =
      {
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p> Contains the new <code>DBInstanceClass</code> for the DB instance that will be applied or is currently being applied. </p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p> Contains the new <code>AllocatedStorage</code> size for the DB instance that will be applied or is currently being applied. </p>"];
      master_user_password: String.t option
        [@ocaml.doc
          "<p>Contains the pending or currently-in-progress change of the master credentials for the DB instance.</p>"];
      port: Integer.t option
        [@ocaml.doc "<p>Specifies the pending port for the DB instance.</p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>Specifies the pending number of days for which automated backups are retained.</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>Indicates that the Single-AZ DB instance is to change to a Multi-AZ deployment.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>Indicates the database engine version.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>The license model for the DB instance.</p> <p>Valid values: <code>license-included</code> | <code>bring-your-own-license</code> | <code>general-public-license</code> </p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>Specifies the new Provisioned IOPS value for the DB instance that will be applied or is currently being applied.</p>"];
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p> Contains the new <code>DBInstanceIdentifier</code> for the DB instance that will be applied or is currently being applied. </p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type to be associated with the DB instance.</p>"];
      c_a_certificate_identifier: String.t option
        [@ocaml.doc
          "<p>Specifies the identifier of the CA certificate for the DB instance.</p>"];
      d_b_subnet_group_name: String.t option
        [@ocaml.doc "<p>The new DB subnet group for the DB instance. </p>"];
      pending_cloudwatch_logs_exports: PendingCloudwatchLogsExports.t option ;
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"]}
    [@@ocaml.doc
      "<p> This data type is used as a response element in the <code>ModifyDBInstance</code> action. </p>"]
    let make ?d_b_instance_class  ?allocated_storage  ?master_user_password 
      ?port  ?backup_retention_period  ?multi_a_z  ?engine_version 
      ?license_model  ?iops  ?d_b_instance_identifier  ?storage_type 
      ?c_a_certificate_identifier  ?d_b_subnet_group_name 
      ?pending_cloudwatch_logs_exports  ?(processor_features= [])  () =
      {
        d_b_instance_class;
        allocated_storage;
        master_user_password;
        port;
        backup_retention_period;
        multi_a_z;
        engine_version;
        license_model;
        iops;
        d_b_instance_identifier;
        storage_type;
        c_a_certificate_identifier;
        d_b_subnet_group_name;
        pending_cloudwatch_logs_exports;
        processor_features
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("processor_features",
                (ProcessorFeatureList.to_json v.processor_features));
           Util.option_map v.pending_cloudwatch_logs_exports
             (fun f ->
                ("pending_cloudwatch_logs_exports",
                  (PendingCloudwatchLogsExports.to_json f)));
           Util.option_map v.d_b_subnet_group_name
             (fun f -> ("d_b_subnet_group_name", (String.to_json f)));
           Util.option_map v.c_a_certificate_identifier
             (fun f -> ("c_a_certificate_identifier", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.master_user_password
             (fun f -> ("master_user_password", (String.to_json f)));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          master_user_password =
            (Util.option_bind (Xml.member "MasterUserPassword" xml)
               String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
               String.parse);
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          c_a_certificate_identifier =
            (Util.option_bind (Xml.member "CACertificateIdentifier" xml)
               String.parse);
          d_b_subnet_group_name =
            (Util.option_bind (Xml.member "DBSubnetGroupName" xml)
               String.parse);
          pending_cloudwatch_logs_exports =
            (Util.option_bind (Xml.member "PendingCloudwatchLogsExports" xml)
               PendingCloudwatchLogsExports.parse);
          processor_features =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProcessorFeatures" xml)
                  ProcessorFeatureList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((([] @
                         [Util.option_map v.d_b_instance_class
                            (fun f ->
                               Ezxmlm.make_tag "DBInstanceClass"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.allocated_storage
                           (fun f ->
                              Ezxmlm.make_tag "AllocatedStorage"
                                ([], (Integer.to_xml f)))])
                       @
                       [Util.option_map v.master_user_password
                          (fun f ->
                             Ezxmlm.make_tag "MasterUserPassword"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.port
                         (fun f ->
                            Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
                     @
                     [Util.option_map v.backup_retention_period
                        (fun f ->
                           Ezxmlm.make_tag "BackupRetentionPeriod"
                             ([], (Integer.to_xml f)))])
                    @
                    [Util.option_map v.multi_a_z
                       (fun f ->
                          Ezxmlm.make_tag "MultiAZ" ([], (Boolean.to_xml f)))])
                   @
                   [Util.option_map v.engine_version
                      (fun f ->
                         Ezxmlm.make_tag "EngineVersion"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.license_model
                     (fun f ->
                        Ezxmlm.make_tag "LicenseModel"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.iops
                    (fun f -> Ezxmlm.make_tag "Iops" ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.d_b_instance_identifier
                   (fun f ->
                      Ezxmlm.make_tag "DBInstanceIdentifier"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.storage_type
                  (fun f ->
                     Ezxmlm.make_tag "StorageType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.c_a_certificate_identifier
                 (fun f ->
                    Ezxmlm.make_tag "CACertificateIdentifier"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.d_b_subnet_group_name
                (fun f ->
                   Ezxmlm.make_tag "DBSubnetGroupName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.pending_cloudwatch_logs_exports
               (fun f ->
                  Ezxmlm.make_tag "PendingCloudwatchLogsExports"
                    ([], (PendingCloudwatchLogsExports.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ProcessorFeatures"
                      ([], (ProcessorFeatureList.to_xml [x]))))
              v.processor_features))
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>ModifyDBInstance</code> action. </p>"]
module ReadReplicaDBClusterIdentifierList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse
           (Xml.members "ReadReplicaDBClusterIdentifier" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ReadReplicaDBInstanceIdentifierList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse
           (Xml.members "ReadReplicaDBInstanceIdentifier" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module InstallationMediaFailureCause =
  struct
    type t =
      {
      message: String.t option
        [@ocaml.doc
          "<p>The reason that an installation media import failed.</p>"]}
    [@@ocaml.doc
      "<p>Contains the cause of an installation media failure. Installation media is used for a DB engine that requires an on-premises customer provided license, such as Microsoft SQL Server.</p>"]
    let make ?message  () = { message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let parse xml =
      Some
        {
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the cause of an installation media failure. Installation media is used for a DB engine that requires an on-premises customer provided license, such as Microsoft SQL Server.</p>"]
module GlobalClusterMemberList =
  struct
    type t = GlobalClusterMember.t list
    let make elems () = elems
    let to_query v = Query.to_query_list GlobalClusterMember.to_query v
    let to_headers v =
      Headers.to_headers_list GlobalClusterMember.to_headers v
    let to_json v = `List (List.map GlobalClusterMember.to_json v)
    let parse xml =
      Util.option_all
        (List.map GlobalClusterMember.parse
           (Xml.members "GlobalClusterMember" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (GlobalClusterMember.to_xml x))) v
  end
module RestoreWindow =
  struct
    type t =
      {
      earliest_time: DateTime.t option
        [@ocaml.doc
          "<p>The earliest time you can restore an instance to.</p>"];
      latest_time: DateTime.t option
        [@ocaml.doc "<p>The latest time you can restore an instance to.</p>"]}
    [@@ocaml.doc
      "<p>Earliest and latest time an instance can be restored to:</p>"]
    let make ?earliest_time  ?latest_time  () =
      { earliest_time; latest_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.latest_time
              (fun f -> ("latest_time", (DateTime.to_json f)));
           Util.option_map v.earliest_time
             (fun f -> ("earliest_time", (DateTime.to_json f)))])
    let parse xml =
      Some
        {
          earliest_time =
            (Util.option_bind (Xml.member "EarliestTime" xml) DateTime.parse);
          latest_time =
            (Util.option_bind (Xml.member "LatestTime" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.earliest_time
               (fun f ->
                  Ezxmlm.make_tag "EarliestTime" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.latest_time
              (fun f ->
                 Ezxmlm.make_tag "LatestTime" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<p>Earliest and latest time an instance can be restored to:</p>"]
module SourceType =
  struct
    type t =
      | Db_instance 
      | Db_parameter_group 
      | Db_security_group 
      | Db_snapshot 
      | Db_cluster 
      | Db_cluster_snapshot 
    let str_to_t =
      [("db-cluster-snapshot", Db_cluster_snapshot);
      ("db-cluster", Db_cluster);
      ("db-snapshot", Db_snapshot);
      ("db-security-group", Db_security_group);
      ("db-parameter-group", Db_parameter_group);
      ("db-instance", Db_instance)]
    let t_to_str =
      [(Db_cluster_snapshot, "db-cluster-snapshot");
      (Db_cluster, "db-cluster");
      (Db_snapshot, "db-snapshot");
      (Db_security_group, "db-security-group");
      (Db_parameter_group, "db-parameter-group");
      (Db_instance, "db-instance")]
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
module OptionsList =
  struct
    type t = Option.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Option.to_query v
    let to_headers v = Headers.to_headers_list Option.to_headers v
    let to_json v = `List (List.map Option.to_json v)
    let parse xml =
      Util.option_all (List.map Option.parse (Xml.members "Option" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Option.to_xml x))) v
  end
module AvailabilityZoneList =
  struct
    type t = AvailabilityZone.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AvailabilityZone.to_query v
    let to_headers v = Headers.to_headers_list AvailabilityZone.to_headers v
    let to_json v = `List (List.map AvailabilityZone.to_json v)
    let parse xml =
      Util.option_all
        (List.map AvailabilityZone.parse (Xml.members "AvailabilityZone" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AvailabilityZone.to_xml x)))
        v
  end
module AvailableProcessorFeatureList =
  struct
    type t = AvailableProcessorFeature.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AvailableProcessorFeature.to_query v
    let to_headers v =
      Headers.to_headers_list AvailableProcessorFeature.to_headers v
    let to_json v = `List (List.map AvailableProcessorFeature.to_json v)
    let parse xml =
      Util.option_all
        (List.map AvailableProcessorFeature.parse
           (Xml.members "AvailableProcessorFeature" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (AvailableProcessorFeature.to_xml x))) v
  end
module AvailabilityZones =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "AvailabilityZone" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ActivityStreamMode =
  struct
    type t =
      | Sync 
      | Async 
    let str_to_t = [("async", Async); ("sync", Sync)]
    let t_to_str = [(Async, "async"); (Sync, "sync")]
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
module ActivityStreamStatus =
  struct
    type t =
      | Stopped 
      | Starting 
      | Started 
      | Stopping 
    let str_to_t =
      [("stopping", Stopping);
      ("started", Started);
      ("starting", Starting);
      ("stopped", Stopped)]
    let t_to_str =
      [(Stopping, "stopping");
      (Started, "started");
      (Starting, "starting");
      (Stopped, "stopped")]
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
module DBClusterMemberList =
  struct
    type t = DBClusterMember.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBClusterMember.to_query v
    let to_headers v = Headers.to_headers_list DBClusterMember.to_headers v
    let to_json v = `List (List.map DBClusterMember.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterMember.parse (Xml.members "DBClusterMember" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBClusterMember.to_xml x)))
        v
  end
module DBClusterOptionGroupMemberships =
  struct
    type t = DBClusterOptionGroupStatus.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list DBClusterOptionGroupStatus.to_query v
    let to_headers v =
      Headers.to_headers_list DBClusterOptionGroupStatus.to_headers v
    let to_json v = `List (List.map DBClusterOptionGroupStatus.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterOptionGroupStatus.parse
           (Xml.members "DBClusterOptionGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (DBClusterOptionGroupStatus.to_xml x))) v
  end
module DBClusterRoles =
  struct
    type t = DBClusterRole.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBClusterRole.to_query v
    let to_headers v = Headers.to_headers_list DBClusterRole.to_headers v
    let to_json v = `List (List.map DBClusterRole.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterRole.parse (Xml.members "DBClusterRole" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBClusterRole.to_xml x))) v
  end
module ReadReplicaIdentifierList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "ReadReplicaIdentifier" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ScalingConfigurationInfo =
  struct
    type t =
      {
      min_capacity: Integer.t option
        [@ocaml.doc
          "<p>The maximum capacity for the Aurora DB cluster in <code>serverless</code> DB engine mode.</p>"];
      max_capacity: Integer.t option
        [@ocaml.doc
          "<p>The maximum capacity for an Aurora DB cluster in <code>serverless</code> DB engine mode.</p>"];
      auto_pause: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether automatic pause is allowed for the Aurora DB cluster in <code>serverless</code> DB engine mode.</p> <p>When the value is set to false for an Aurora Serverless DB cluster, the DB cluster automatically resumes.</p>"];
      seconds_until_auto_pause: Integer.t option
        [@ocaml.doc
          "<p>The remaining amount of time, in seconds, before the Aurora DB cluster in <code>serverless</code> mode is paused. A DB cluster can be paused only when it's idle (it has no connections).</p>"];
      timeout_action: String.t option
        [@ocaml.doc
          "<p>The timeout action of a call to <code>ModifyCurrentDBClusterCapacity</code>, either <code>ForceApplyCapacityChange</code> or <code>RollbackCapacityChange</code>.</p>"]}
    [@@ocaml.doc
      "<p>Shows the scaling configuration for an Aurora DB cluster in <code>serverless</code> DB engine mode.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html\">Using Amazon Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"]
    let make ?min_capacity  ?max_capacity  ?auto_pause 
      ?seconds_until_auto_pause  ?timeout_action  () =
      {
        min_capacity;
        max_capacity;
        auto_pause;
        seconds_until_auto_pause;
        timeout_action
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timeout_action
              (fun f -> ("timeout_action", (String.to_json f)));
           Util.option_map v.seconds_until_auto_pause
             (fun f -> ("seconds_until_auto_pause", (Integer.to_json f)));
           Util.option_map v.auto_pause
             (fun f -> ("auto_pause", (Boolean.to_json f)));
           Util.option_map v.max_capacity
             (fun f -> ("max_capacity", (Integer.to_json f)));
           Util.option_map v.min_capacity
             (fun f -> ("min_capacity", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          min_capacity =
            (Util.option_bind (Xml.member "MinCapacity" xml) Integer.parse);
          max_capacity =
            (Util.option_bind (Xml.member "MaxCapacity" xml) Integer.parse);
          auto_pause =
            (Util.option_bind (Xml.member "AutoPause" xml) Boolean.parse);
          seconds_until_auto_pause =
            (Util.option_bind (Xml.member "SecondsUntilAutoPause" xml)
               Integer.parse);
          timeout_action =
            (Util.option_bind (Xml.member "TimeoutAction" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.min_capacity
                  (fun f ->
                     Ezxmlm.make_tag "MinCapacity" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.max_capacity
                 (fun f ->
                    Ezxmlm.make_tag "MaxCapacity" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.auto_pause
                (fun f ->
                   Ezxmlm.make_tag "AutoPause" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.seconds_until_auto_pause
               (fun f ->
                  Ezxmlm.make_tag "SecondsUntilAutoPause"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.timeout_action
              (fun f ->
                 Ezxmlm.make_tag "TimeoutAction" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Shows the scaling configuration for an Aurora DB cluster in <code>serverless</code> DB engine mode.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html\">Using Amazon Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"]
module EC2SecurityGroupList =
  struct
    type t = EC2SecurityGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EC2SecurityGroup.to_query v
    let to_headers v = Headers.to_headers_list EC2SecurityGroup.to_headers v
    let to_json v = `List (List.map EC2SecurityGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map EC2SecurityGroup.parse (Xml.members "EC2SecurityGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (EC2SecurityGroup.to_xml x)))
        v
  end
module IPRangeList =
  struct
    type t = IPRange.t list
    let make elems () = elems
    let to_query v = Query.to_query_list IPRange.to_query v
    let to_headers v = Headers.to_headers_list IPRange.to_headers v
    let to_json v = `List (List.map IPRange.to_json v)
    let parse xml =
      Util.option_all (List.map IPRange.parse (Xml.members "IPRange" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (IPRange.to_xml x))) v
  end
module Tag =
  struct
    type t =
      {
      key: String.t option
        [@ocaml.doc
          "<p>A key is the required name of the tag. The string value can be from 1 to 128 Unicode characters in length and can't be prefixed with \"aws:\" or \"rds:\". The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', '/', '=', '+', '-' (Java regex: \"^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-]*)$\").</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>A value is the optional value of the tag. The string value can be from 1 to 256 Unicode characters in length and can't be prefixed with \"aws:\" or \"rds:\". The string can only contain only the set of Unicode letters, digits, white-space, '_', '.', '/', '=', '+', '-' (Java regex: \"^([\\\\p{L}\\\\p{Z}\\\\p{N}_.:/=+\\\\-]*)$\").</p>"]}
    [@@ocaml.doc
      "<p>Metadata assigned to an Amazon RDS resource consisting of a key-value pair.</p>"]
    let make ?key  ?value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let parse xml =
      Some
        {
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.key
               (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Metadata assigned to an Amazon RDS resource consisting of a key-value pair.</p>"]
module Filter =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the filter. Filter names are case-sensitive.</p>"];
      values: FilterValueList.t
        [@ocaml.doc
          "<p>One or more filter values. Filter values are case-sensitive.</p>"]}
    [@@ocaml.doc
      "<p>A filter name and value pair that is used to return a more specific list of results from a describe operation. Filters can be used to match a set of resources by specific criteria, such as IDs. The filters supported by a describe operation are documented with the describe operation.</p> <note> <p>Currently, wildcards are not supported in filters.</p> </note> <p>The following actions can be filtered:</p> <ul> <li> <p> <code>DescribeDBClusterBacktracks</code> </p> </li> <li> <p> <code>DescribeDBClusterEndpoints</code> </p> </li> <li> <p> <code>DescribeDBClusters</code> </p> </li> <li> <p> <code>DescribeDBInstances</code> </p> </li> <li> <p> <code>DescribePendingMaintenanceActions</code> </p> </li> </ul>"]
    let make ~name  ~values  () = { name; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (FilterValueList.to_json v.values));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          values =
            (Xml.required "Values"
               (Util.option_bind (Xml.member "Values" xml)
                  FilterValueList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Values"
                      ([], (FilterValueList.to_xml [x])))) v.values))
  end[@@ocaml.doc
       "<p>A filter name and value pair that is used to return a more specific list of results from a describe operation. Filters can be used to match a set of resources by specific criteria, such as IDs. The filters supported by a describe operation are documented with the describe operation.</p> <note> <p>Currently, wildcards are not supported in filters.</p> </note> <p>The following actions can be filtered:</p> <ul> <li> <p> <code>DescribeDBClusterBacktracks</code> </p> </li> <li> <p> <code>DescribeDBClusterEndpoints</code> </p> </li> <li> <p> <code>DescribeDBClusters</code> </p> </li> <li> <p> <code>DescribeDBInstances</code> </p> </li> <li> <p> <code>DescribePendingMaintenanceActions</code> </p> </li> </ul>"]
module OptionGroupOption =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of the option.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the option.</p>"];
      engine_name: String.t option
        [@ocaml.doc
          "<p>The name of the engine that this option can be applied to.</p>"];
      major_engine_version: String.t option
        [@ocaml.doc
          "<p>Indicates the major engine version that the option is available for.</p>"];
      minimum_required_minor_engine_version: String.t option
        [@ocaml.doc
          "<p>The minimum required engine version for the option to be applied.</p>"];
      port_required: Boolean.t option
        [@ocaml.doc "<p>Specifies whether the option requires a port.</p>"];
      default_port: Integer.t option
        [@ocaml.doc
          "<p>If the option requires a port, specifies the default port for the option.</p>"];
      options_depended_on: OptionsDependedOn.t
        [@ocaml.doc
          "<p>The options that are prerequisites for this option.</p>"];
      options_conflicts_with: OptionsConflictsWith.t
        [@ocaml.doc "<p>The options that conflict with this option.</p>"];
      persistent: Boolean.t option
        [@ocaml.doc
          "<p>Persistent options can't be removed from an option group while DB instances are associated with the option group. If you disassociate all DB instances from the option group, your can remove the persistent option from the option group.</p>"];
      permanent: Boolean.t option
        [@ocaml.doc
          "<p>Permanent options can never be removed from an option group. An option group containing a permanent option can't be removed from a DB instance.</p>"];
      requires_auto_minor_engine_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>If true, you must enable the Auto Minor Version Upgrade setting for your DB instance before you can use this option. You can enable Auto Minor Version Upgrade when you first create your DB instance, or by modifying your DB instance later. </p>"];
      vpc_only: Boolean.t option
        [@ocaml.doc
          "<p>If true, you can only use this option with a DB instance that is in a VPC. </p>"];
      supports_option_version_downgrade: Boolean.t option
        [@ocaml.doc
          "<p>If true, you can change the option to an earlier version of the option. This only applies to options that have different versions available. </p>"];
      option_group_option_settings: OptionGroupOptionSettingsList.t
        [@ocaml.doc
          "<p>The option settings that are available (and the default value) for each option in an option group.</p>"];
      option_group_option_versions: OptionGroupOptionVersionsList.t
        [@ocaml.doc "<p>The versions that are available for the option.</p>"]}
    [@@ocaml.doc "<p>Available option.</p>"]
    let make ?name  ?description  ?engine_name  ?major_engine_version 
      ?minimum_required_minor_engine_version  ?port_required  ?default_port 
      ?(options_depended_on= [])  ?(options_conflicts_with= [])  ?persistent 
      ?permanent  ?requires_auto_minor_engine_version_upgrade  ?vpc_only 
      ?supports_option_version_downgrade  ?(option_group_option_settings= [])
       ?(option_group_option_versions= [])  () =
      {
        name;
        description;
        engine_name;
        major_engine_version;
        minimum_required_minor_engine_version;
        port_required;
        default_port;
        options_depended_on;
        options_conflicts_with;
        persistent;
        permanent;
        requires_auto_minor_engine_version_upgrade;
        vpc_only;
        supports_option_version_downgrade;
        option_group_option_settings;
        option_group_option_versions
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("option_group_option_versions",
                (OptionGroupOptionVersionsList.to_json
                   v.option_group_option_versions));
           Some
             ("option_group_option_settings",
               (OptionGroupOptionSettingsList.to_json
                  v.option_group_option_settings));
           Util.option_map v.supports_option_version_downgrade
             (fun f ->
                ("supports_option_version_downgrade", (Boolean.to_json f)));
           Util.option_map v.vpc_only
             (fun f -> ("vpc_only", (Boolean.to_json f)));
           Util.option_map v.requires_auto_minor_engine_version_upgrade
             (fun f ->
                ("requires_auto_minor_engine_version_upgrade",
                  (Boolean.to_json f)));
           Util.option_map v.permanent
             (fun f -> ("permanent", (Boolean.to_json f)));
           Util.option_map v.persistent
             (fun f -> ("persistent", (Boolean.to_json f)));
           Some
             ("options_conflicts_with",
               (OptionsConflictsWith.to_json v.options_conflicts_with));
           Some
             ("options_depended_on",
               (OptionsDependedOn.to_json v.options_depended_on));
           Util.option_map v.default_port
             (fun f -> ("default_port", (Integer.to_json f)));
           Util.option_map v.port_required
             (fun f -> ("port_required", (Boolean.to_json f)));
           Util.option_map v.minimum_required_minor_engine_version
             (fun f ->
                ("minimum_required_minor_engine_version", (String.to_json f)));
           Util.option_map v.major_engine_version
             (fun f -> ("major_engine_version", (String.to_json f)));
           Util.option_map v.engine_name
             (fun f -> ("engine_name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          engine_name =
            (Util.option_bind (Xml.member "EngineName" xml) String.parse);
          major_engine_version =
            (Util.option_bind (Xml.member "MajorEngineVersion" xml)
               String.parse);
          minimum_required_minor_engine_version =
            (Util.option_bind
               (Xml.member "MinimumRequiredMinorEngineVersion" xml)
               String.parse);
          port_required =
            (Util.option_bind (Xml.member "PortRequired" xml) Boolean.parse);
          default_port =
            (Util.option_bind (Xml.member "DefaultPort" xml) Integer.parse);
          options_depended_on =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionsDependedOn" xml)
                  OptionsDependedOn.parse));
          options_conflicts_with =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionsConflictsWith" xml)
                  OptionsConflictsWith.parse));
          persistent =
            (Util.option_bind (Xml.member "Persistent" xml) Boolean.parse);
          permanent =
            (Util.option_bind (Xml.member "Permanent" xml) Boolean.parse);
          requires_auto_minor_engine_version_upgrade =
            (Util.option_bind
               (Xml.member "RequiresAutoMinorEngineVersionUpgrade" xml)
               Boolean.parse);
          vpc_only =
            (Util.option_bind (Xml.member "VpcOnly" xml) Boolean.parse);
          supports_option_version_downgrade =
            (Util.option_bind
               (Xml.member "SupportsOptionVersionDowngrade" xml)
               Boolean.parse);
          option_group_option_settings =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionGroupOptionSettings" xml)
                  OptionGroupOptionSettingsList.parse));
          option_group_option_versions =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionGroupOptionVersions" xml)
                  OptionGroupOptionVersionsList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((([] @
                          [Util.option_map v.name
                             (fun f ->
                                Ezxmlm.make_tag "Name"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.description
                            (fun f ->
                               Ezxmlm.make_tag "Description"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.engine_name
                           (fun f ->
                              Ezxmlm.make_tag "EngineName"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.major_engine_version
                          (fun f ->
                             Ezxmlm.make_tag "MajorEngineVersion"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map
                         v.minimum_required_minor_engine_version
                         (fun f ->
                            Ezxmlm.make_tag
                              "MinimumRequiredMinorEngineVersion"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.port_required
                        (fun f ->
                           Ezxmlm.make_tag "PortRequired"
                             ([], (Boolean.to_xml f)))])
                    @
                    [Util.option_map v.default_port
                       (fun f ->
                          Ezxmlm.make_tag "DefaultPort"
                            ([], (Integer.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "OptionsDependedOn"
                              ([], (OptionsDependedOn.to_xml [x]))))
                      v.options_depended_on))
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "OptionsConflictsWith"
                             ([], (OptionsConflictsWith.to_xml [x]))))
                     v.options_conflicts_with))
                 @
                 [Util.option_map v.persistent
                    (fun f ->
                       Ezxmlm.make_tag "Persistent" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.permanent
                   (fun f ->
                      Ezxmlm.make_tag "Permanent" ([], (Boolean.to_xml f)))])
               @
               [Util.option_map v.requires_auto_minor_engine_version_upgrade
                  (fun f ->
                     Ezxmlm.make_tag "RequiresAutoMinorEngineVersionUpgrade"
                       ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.vpc_only
                 (fun f -> Ezxmlm.make_tag "VpcOnly" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.supports_option_version_downgrade
                (fun f ->
                   Ezxmlm.make_tag "SupportsOptionVersionDowngrade"
                     ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "OptionGroupOptionSettings"
                       ([], (OptionGroupOptionSettingsList.to_xml [x]))))
               v.option_group_option_settings))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "OptionGroupOptionVersions"
                      ([], (OptionGroupOptionVersionsList.to_xml [x]))))
              v.option_group_option_versions))
  end[@@ocaml.doc "<p>Available option.</p>"]
module ValidStorageOptionsList =
  struct
    type t = ValidStorageOptions.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ValidStorageOptions.to_query v
    let to_headers v =
      Headers.to_headers_list ValidStorageOptions.to_headers v
    let to_json v = `List (List.map ValidStorageOptions.to_json v)
    let parse xml =
      Util.option_all
        (List.map ValidStorageOptions.parse
           (Xml.members "ValidStorageOptions" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ValidStorageOptions.to_xml x))) v
  end
module CustomAvailabilityZone =
  struct
    type t =
      {
      custom_availability_zone_id: String.t option
        [@ocaml.doc
          "<p>The identifier of the custom AZ.</p> <p>Amazon RDS generates a unique identifier when a custom AZ is created.</p>"];
      custom_availability_zone_name: String.t option
        [@ocaml.doc "<p>The name of the custom AZ.</p>"];
      custom_availability_zone_status: String.t option
        [@ocaml.doc "<p>The status of the custom AZ.</p>"];
      vpn_details: VpnDetails.t option
        [@ocaml.doc
          "<p>Information about the virtual private network (VPN) between the VMware vSphere cluster and the AWS website.</p>"]}
    [@@ocaml.doc
      "<p>A custom Availability Zone (AZ) is an on-premises AZ that is integrated with a VMware vSphere cluster.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p>"]
    let make ?custom_availability_zone_id  ?custom_availability_zone_name 
      ?custom_availability_zone_status  ?vpn_details  () =
      {
        custom_availability_zone_id;
        custom_availability_zone_name;
        custom_availability_zone_status;
        vpn_details
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.vpn_details
              (fun f -> ("vpn_details", (VpnDetails.to_json f)));
           Util.option_map v.custom_availability_zone_status
             (fun f ->
                ("custom_availability_zone_status", (String.to_json f)));
           Util.option_map v.custom_availability_zone_name
             (fun f -> ("custom_availability_zone_name", (String.to_json f)));
           Util.option_map v.custom_availability_zone_id
             (fun f -> ("custom_availability_zone_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          custom_availability_zone_id =
            (Util.option_bind (Xml.member "CustomAvailabilityZoneId" xml)
               String.parse);
          custom_availability_zone_name =
            (Util.option_bind (Xml.member "CustomAvailabilityZoneName" xml)
               String.parse);
          custom_availability_zone_status =
            (Util.option_bind (Xml.member "CustomAvailabilityZoneStatus" xml)
               String.parse);
          vpn_details =
            (Util.option_bind (Xml.member "VpnDetails" xml) VpnDetails.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.custom_availability_zone_id
                 (fun f ->
                    Ezxmlm.make_tag "CustomAvailabilityZoneId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.custom_availability_zone_name
                (fun f ->
                   Ezxmlm.make_tag "CustomAvailabilityZoneName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.custom_availability_zone_status
               (fun f ->
                  Ezxmlm.make_tag "CustomAvailabilityZoneStatus"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.vpn_details
              (fun f ->
                 Ezxmlm.make_tag "VpnDetails" ([], (VpnDetails.to_xml f)))])
  end[@@ocaml.doc
       "<p>A custom Availability Zone (AZ) is an on-premises AZ that is integrated with a VMware vSphere cluster.</p> <p>For more information about RDS on VMware, see the <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/RDSonVMwareUserGuide/rds-on-vmware.html\"> <i>RDS on VMware User Guide.</i> </a> </p>"]
module ParametersList =
  struct
    type t = Parameter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Parameter.to_query v
    let to_headers v = Headers.to_headers_list Parameter.to_headers v
    let to_json v = `List (List.map Parameter.to_json v)
    let parse xml =
      Util.option_all
        (List.map Parameter.parse (Xml.members "Parameter" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Parameter.to_xml x)))
        v
  end
module DBClusterEndpoint =
  struct
    type t =
      {
      d_b_cluster_endpoint_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier associated with the endpoint. This parameter is stored as a lowercase string.</p>"];
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>The DB cluster identifier of the DB cluster associated with the endpoint. This parameter is stored as a lowercase string.</p>"];
      d_b_cluster_endpoint_resource_identifier: String.t option
        [@ocaml.doc
          "<p>A unique system-generated identifier for an endpoint. It remains the same for the whole life of the endpoint.</p>"];
      endpoint: String.t option
        [@ocaml.doc "<p>The DNS address of the endpoint.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The current status of the endpoint. One of: <code>creating</code>, <code>available</code>, <code>deleting</code>, <code>modifying</code>.</p>"];
      endpoint_type: String.t option
        [@ocaml.doc
          "<p>The type of the endpoint. One of: <code>READER</code>, <code>WRITER</code>, <code>CUSTOM</code>.</p>"];
      custom_endpoint_type: String.t option
        [@ocaml.doc
          "<p>The type associated with a custom endpoint. One of: <code>READER</code>, <code>WRITER</code>, <code>ANY</code>.</p>"];
      static_members: StringList.t
        [@ocaml.doc
          "<p>List of DB instance identifiers that are part of the custom endpoint group.</p>"];
      excluded_members: StringList.t
        [@ocaml.doc
          "<p>List of DB instance identifiers that aren't part of the custom endpoint group. All other eligible instances are reachable through the custom endpoint. Only relevant if the list of static members is empty.</p>"];
      d_b_cluster_endpoint_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the endpoint.</p>"]}
    [@@ocaml.doc
      "<p>This data type represents the information you need to connect to an Amazon Aurora DB cluster. This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>CreateDBClusterEndpoint</code> </p> </li> <li> <p> <code>DescribeDBClusterEndpoints</code> </p> </li> <li> <p> <code>ModifyDBClusterEndpoint</code> </p> </li> <li> <p> <code>DeleteDBClusterEndpoint</code> </p> </li> </ul> <p>For the data structure that represents Amazon RDS DB instance endpoints, see <code>Endpoint</code>.</p>"]
    let make ?d_b_cluster_endpoint_identifier  ?d_b_cluster_identifier 
      ?d_b_cluster_endpoint_resource_identifier  ?endpoint  ?status 
      ?endpoint_type  ?custom_endpoint_type  ?(static_members= []) 
      ?(excluded_members= [])  ?d_b_cluster_endpoint_arn  () =
      {
        d_b_cluster_endpoint_identifier;
        d_b_cluster_identifier;
        d_b_cluster_endpoint_resource_identifier;
        endpoint;
        status;
        endpoint_type;
        custom_endpoint_type;
        static_members;
        excluded_members;
        d_b_cluster_endpoint_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_endpoint_arn
              (fun f -> ("d_b_cluster_endpoint_arn", (String.to_json f)));
           Some ("excluded_members", (StringList.to_json v.excluded_members));
           Some ("static_members", (StringList.to_json v.static_members));
           Util.option_map v.custom_endpoint_type
             (fun f -> ("custom_endpoint_type", (String.to_json f)));
           Util.option_map v.endpoint_type
             (fun f -> ("endpoint_type", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (String.to_json f)));
           Util.option_map v.d_b_cluster_endpoint_resource_identifier
             (fun f ->
                ("d_b_cluster_endpoint_resource_identifier",
                  (String.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)));
           Util.option_map v.d_b_cluster_endpoint_identifier
             (fun f ->
                ("d_b_cluster_endpoint_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_endpoint_identifier =
            (Util.option_bind (Xml.member "DBClusterEndpointIdentifier" xml)
               String.parse);
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          d_b_cluster_endpoint_resource_identifier =
            (Util.option_bind
               (Xml.member "DBClusterEndpointResourceIdentifier" xml)
               String.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          endpoint_type =
            (Util.option_bind (Xml.member "EndpointType" xml) String.parse);
          custom_endpoint_type =
            (Util.option_bind (Xml.member "CustomEndpointType" xml)
               String.parse);
          static_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "StaticMembers" xml)
                  StringList.parse));
          excluded_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "ExcludedMembers" xml)
                  StringList.parse));
          d_b_cluster_endpoint_arn =
            (Util.option_bind (Xml.member "DBClusterEndpointArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.d_b_cluster_endpoint_identifier
                       (fun f ->
                          Ezxmlm.make_tag "DBClusterEndpointIdentifier"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.d_b_cluster_identifier
                      (fun f ->
                         Ezxmlm.make_tag "DBClusterIdentifier"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.d_b_cluster_endpoint_resource_identifier
                     (fun f ->
                        Ezxmlm.make_tag "DBClusterEndpointResourceIdentifier"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.endpoint
                    (fun f ->
                       Ezxmlm.make_tag "Endpoint" ([], (String.to_xml f)))])
                @
                [Util.option_map v.status
                   (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
               @
               [Util.option_map v.endpoint_type
                  (fun f ->
                     Ezxmlm.make_tag "EndpointType" ([], (String.to_xml f)))])
              @
              [Util.option_map v.custom_endpoint_type
                 (fun f ->
                    Ezxmlm.make_tag "CustomEndpointType"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "StaticMembers"
                        ([], (StringList.to_xml [x])))) v.static_members))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ExcludedMembers"
                       ([], (StringList.to_xml [x])))) v.excluded_members))
           @
           [Util.option_map v.d_b_cluster_endpoint_arn
              (fun f ->
                 Ezxmlm.make_tag "DBClusterEndpointArn"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type represents the information you need to connect to an Amazon Aurora DB cluster. This data type is used as a response element in the following actions:</p> <ul> <li> <p> <code>CreateDBClusterEndpoint</code> </p> </li> <li> <p> <code>DescribeDBClusterEndpoints</code> </p> </li> <li> <p> <code>ModifyDBClusterEndpoint</code> </p> </li> <li> <p> <code>DeleteDBClusterEndpoint</code> </p> </li> </ul> <p>For the data structure that represents Amazon RDS DB instance endpoints, see <code>Endpoint</code>.</p>"]
module EventSubscription =
  struct
    type t =
      {
      customer_aws_id: String.t option
        [@ocaml.doc
          "<p>The AWS customer account associated with the RDS event notification subscription.</p>"];
      cust_subscription_id: String.t option
        [@ocaml.doc "<p>The RDS event notification subscription Id.</p>"];
      sns_topic_arn: String.t option
        [@ocaml.doc
          "<p>The topic ARN of the RDS event notification subscription.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the RDS event notification subscription.</p> <p>Constraints:</p> <p>Can be one of the following: creating | modifying | deleting | active | no-permission | topic-not-exist</p> <p>The status \"no-permission\" indicates that RDS no longer has permission to post to the SNS topic. The status \"topic-not-exist\" indicates that the topic was deleted after the subscription was created.</p>"];
      subscription_creation_time: String.t option
        [@ocaml.doc
          "<p>The time the RDS event notification subscription was created.</p>"];
      source_type: String.t option
        [@ocaml.doc
          "<p>The source type for the RDS event notification subscription.</p>"];
      source_ids_list: SourceIdsList.t
        [@ocaml.doc
          "<p>A list of source IDs for the RDS event notification subscription.</p>"];
      event_categories_list: EventCategoriesList.t
        [@ocaml.doc
          "<p>A list of event categories for the RDS event notification subscription.</p>"];
      enabled: Boolean.t option
        [@ocaml.doc
          "<p>A Boolean value indicating if the subscription is enabled. True indicates the subscription is enabled.</p>"];
      event_subscription_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the event subscription.</p>"]}
    [@@ocaml.doc
      "<p>Contains the results of a successful invocation of the <code>DescribeEventSubscriptions</code> action.</p>"]
    let make ?customer_aws_id  ?cust_subscription_id  ?sns_topic_arn  ?status
       ?subscription_creation_time  ?source_type  ?(source_ids_list= []) 
      ?(event_categories_list= [])  ?enabled  ?event_subscription_arn  () =
      {
        customer_aws_id;
        cust_subscription_id;
        sns_topic_arn;
        status;
        subscription_creation_time;
        source_type;
        source_ids_list;
        event_categories_list;
        enabled;
        event_subscription_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.event_subscription_arn
              (fun f -> ("event_subscription_arn", (String.to_json f)));
           Util.option_map v.enabled
             (fun f -> ("enabled", (Boolean.to_json f)));
           Some
             ("event_categories_list",
               (EventCategoriesList.to_json v.event_categories_list));
           Some
             ("source_ids_list", (SourceIdsList.to_json v.source_ids_list));
           Util.option_map v.source_type
             (fun f -> ("source_type", (String.to_json f)));
           Util.option_map v.subscription_creation_time
             (fun f -> ("subscription_creation_time", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.sns_topic_arn
             (fun f -> ("sns_topic_arn", (String.to_json f)));
           Util.option_map v.cust_subscription_id
             (fun f -> ("cust_subscription_id", (String.to_json f)));
           Util.option_map v.customer_aws_id
             (fun f -> ("customer_aws_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          customer_aws_id =
            (Util.option_bind (Xml.member "CustomerAwsId" xml) String.parse);
          cust_subscription_id =
            (Util.option_bind (Xml.member "CustSubscriptionId" xml)
               String.parse);
          sns_topic_arn =
            (Util.option_bind (Xml.member "SnsTopicArn" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          subscription_creation_time =
            (Util.option_bind (Xml.member "SubscriptionCreationTime" xml)
               String.parse);
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) String.parse);
          source_ids_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "SourceIdsList" xml)
                  SourceIdsList.parse));
          event_categories_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "EventCategoriesList" xml)
                  EventCategoriesList.parse));
          enabled =
            (Util.option_bind (Xml.member "Enabled" xml) Boolean.parse);
          event_subscription_arn =
            (Util.option_bind (Xml.member "EventSubscriptionArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.customer_aws_id
                       (fun f ->
                          Ezxmlm.make_tag "CustomerAwsId"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.cust_subscription_id
                      (fun f ->
                         Ezxmlm.make_tag "CustSubscriptionId"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.sns_topic_arn
                     (fun f ->
                        Ezxmlm.make_tag "SnsTopicArn" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.status
                    (fun f ->
                       Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
                @
                [Util.option_map v.subscription_creation_time
                   (fun f ->
                      Ezxmlm.make_tag "SubscriptionCreationTime"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.source_type
                  (fun f ->
                     Ezxmlm.make_tag "SourceType" ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "SourceIdsList"
                         ([], (SourceIdsList.to_xml [x])))) v.source_ids_list))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "EventCategoriesList"
                        ([], (EventCategoriesList.to_xml [x]))))
                v.event_categories_list))
            @
            [Util.option_map v.enabled
               (fun f -> Ezxmlm.make_tag "Enabled" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.event_subscription_arn
              (fun f ->
                 Ezxmlm.make_tag "EventSubscriptionArn"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the results of a successful invocation of the <code>DescribeEventSubscriptions</code> action.</p>"]
module OptionConfiguration =
  struct
    type t =
      {
      option_name: String.t
        [@ocaml.doc
          "<p>The configuration of options to include in a group.</p>"];
      port: Integer.t option
        [@ocaml.doc "<p>The optional port for the option.</p>"];
      option_version: String.t option
        [@ocaml.doc "<p>The version for the option.</p>"];
      d_b_security_group_memberships: DBSecurityGroupNameList.t
        [@ocaml.doc
          "<p>A list of DBSecurityGroupMembership name strings used for this option.</p>"];
      vpc_security_group_memberships: VpcSecurityGroupIdList.t
        [@ocaml.doc
          "<p>A list of VpcSecurityGroupMembership name strings used for this option.</p>"];
      option_settings: OptionSettingsList.t
        [@ocaml.doc
          "<p>The option settings to include in an option group.</p>"]}
    [@@ocaml.doc "<p>A list of all available options</p>"]
    let make ~option_name  ?port  ?option_version 
      ?(d_b_security_group_memberships= []) 
      ?(vpc_security_group_memberships= [])  ?(option_settings= [])  () =
      {
        option_name;
        port;
        option_version;
        d_b_security_group_memberships;
        vpc_security_group_memberships;
        option_settings
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("option_settings",
                (OptionSettingsList.to_json v.option_settings));
           Some
             ("vpc_security_group_memberships",
               (VpcSecurityGroupIdList.to_json
                  v.vpc_security_group_memberships));
           Some
             ("d_b_security_group_memberships",
               (DBSecurityGroupNameList.to_json
                  v.d_b_security_group_memberships));
           Util.option_map v.option_version
             (fun f -> ("option_version", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Some ("option_name", (String.to_json v.option_name))])
    let parse xml =
      Some
        {
          option_name =
            (Xml.required "OptionName"
               (Util.option_bind (Xml.member "OptionName" xml) String.parse));
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          option_version =
            (Util.option_bind (Xml.member "OptionVersion" xml) String.parse);
          d_b_security_group_memberships =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "DBSecurityGroupMemberships" xml)
                  DBSecurityGroupNameList.parse));
          vpc_security_group_memberships =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "VpcSecurityGroupMemberships" xml)
                  VpcSecurityGroupIdList.parse));
          option_settings =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionSettings" xml)
                  OptionSettingsList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "OptionName"
                      ([], (String.to_xml v.option_name)))])
               @
               [Util.option_map v.port
                  (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.option_version
                 (fun f ->
                    Ezxmlm.make_tag "OptionVersion" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "DBSecurityGroupMemberships"
                        ([], (DBSecurityGroupNameList.to_xml [x]))))
                v.d_b_security_group_memberships))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "VpcSecurityGroupMemberships"
                       ([], (VpcSecurityGroupIdList.to_xml [x]))))
               v.vpc_security_group_memberships))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "OptionSettings"
                      ([], (OptionSettingsList.to_xml [x]))))
              v.option_settings))
  end[@@ocaml.doc "<p>A list of all available options</p>"]
module ReservedDBInstance =
  struct
    type t =
      {
      reserved_d_b_instance_id: String.t option
        [@ocaml.doc "<p>The unique identifier for the reservation.</p>"];
      reserved_d_b_instances_offering_id: String.t option
        [@ocaml.doc "<p>The offering identifier.</p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The DB instance class for the reserved DB instance.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc "<p>The time the reservation started.</p>"];
      duration: Integer.t option
        [@ocaml.doc "<p>The duration of the reservation in seconds.</p>"];
      fixed_price: Double.t option
        [@ocaml.doc
          "<p>The fixed price charged for this reserved DB instance.</p>"];
      usage_price: Double.t option
        [@ocaml.doc
          "<p>The hourly price charged for this reserved DB instance.</p>"];
      currency_code: String.t option
        [@ocaml.doc "<p>The currency code for the reserved DB instance.</p>"];
      d_b_instance_count: Integer.t option
        [@ocaml.doc "<p>The number of reserved DB instances.</p>"];
      product_description: String.t option
        [@ocaml.doc "<p>The description of the reserved DB instance.</p>"];
      offering_type: String.t option
        [@ocaml.doc "<p>The offering type of this reserved DB instance.</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>Indicates if the reservation applies to Multi-AZ deployments.</p>"];
      state: String.t option
        [@ocaml.doc "<p>The state of the reserved DB instance.</p>"];
      recurring_charges: RecurringChargeList.t
        [@ocaml.doc
          "<p>The recurring price charged to run this reserved DB instance.</p>"];
      reserved_d_b_instance_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the reserved DB instance.</p>"];
      lease_id: String.t option
        [@ocaml.doc
          "<p>The unique identifier for the lease associated with the reserved DB instance.</p> <note> <p>AWS Support might request the lease ID for an issue related to a reserved DB instance.</p> </note>"]}
    [@@ocaml.doc
      "<p> This data type is used as a response element in the <code>DescribeReservedDBInstances</code> and <code>PurchaseReservedDBInstancesOffering</code> actions. </p>"]
    let make ?reserved_d_b_instance_id  ?reserved_d_b_instances_offering_id 
      ?d_b_instance_class  ?start_time  ?duration  ?fixed_price  ?usage_price
       ?currency_code  ?d_b_instance_count  ?product_description 
      ?offering_type  ?multi_a_z  ?state  ?(recurring_charges= []) 
      ?reserved_d_b_instance_arn  ?lease_id  () =
      {
        reserved_d_b_instance_id;
        reserved_d_b_instances_offering_id;
        d_b_instance_class;
        start_time;
        duration;
        fixed_price;
        usage_price;
        currency_code;
        d_b_instance_count;
        product_description;
        offering_type;
        multi_a_z;
        state;
        recurring_charges;
        reserved_d_b_instance_arn;
        lease_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.lease_id
              (fun f -> ("lease_id", (String.to_json f)));
           Util.option_map v.reserved_d_b_instance_arn
             (fun f -> ("reserved_d_b_instance_arn", (String.to_json f)));
           Some
             ("recurring_charges",
               (RecurringChargeList.to_json v.recurring_charges));
           Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.d_b_instance_count
             (fun f -> ("d_b_instance_count", (Integer.to_json f)));
           Util.option_map v.currency_code
             (fun f -> ("currency_code", (String.to_json f)));
           Util.option_map v.usage_price
             (fun f -> ("usage_price", (Double.to_json f)));
           Util.option_map v.fixed_price
             (fun f -> ("fixed_price", (Double.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.reserved_d_b_instances_offering_id
             (fun f ->
                ("reserved_d_b_instances_offering_id", (String.to_json f)));
           Util.option_map v.reserved_d_b_instance_id
             (fun f -> ("reserved_d_b_instance_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          reserved_d_b_instance_id =
            (Util.option_bind (Xml.member "ReservedDBInstanceId" xml)
               String.parse);
          reserved_d_b_instances_offering_id =
            (Util.option_bind
               (Xml.member "ReservedDBInstancesOfferingId" xml) String.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          start_time =
            (Util.option_bind (Xml.member "StartTime" xml) DateTime.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) Integer.parse);
          fixed_price =
            (Util.option_bind (Xml.member "FixedPrice" xml) Double.parse);
          usage_price =
            (Util.option_bind (Xml.member "UsagePrice" xml) Double.parse);
          currency_code =
            (Util.option_bind (Xml.member "CurrencyCode" xml) String.parse);
          d_b_instance_count =
            (Util.option_bind (Xml.member "DBInstanceCount" xml)
               Integer.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          state = (Util.option_bind (Xml.member "State" xml) String.parse);
          recurring_charges =
            (Util.of_option []
               (Util.option_bind (Xml.member "RecurringCharges" xml)
                  RecurringChargeList.parse));
          reserved_d_b_instance_arn =
            (Util.option_bind (Xml.member "ReservedDBInstanceArn" xml)
               String.parse);
          lease_id =
            (Util.option_bind (Xml.member "LeaseId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((([] @
                          [Util.option_map v.reserved_d_b_instance_id
                             (fun f ->
                                Ezxmlm.make_tag "ReservedDBInstanceId"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map
                            v.reserved_d_b_instances_offering_id
                            (fun f ->
                               Ezxmlm.make_tag
                                 "ReservedDBInstancesOfferingId"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.d_b_instance_class
                           (fun f ->
                              Ezxmlm.make_tag "DBInstanceClass"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.start_time
                          (fun f ->
                             Ezxmlm.make_tag "StartTime"
                               ([], (DateTime.to_xml f)))])
                      @
                      [Util.option_map v.duration
                         (fun f ->
                            Ezxmlm.make_tag "Duration"
                              ([], (Integer.to_xml f)))])
                     @
                     [Util.option_map v.fixed_price
                        (fun f ->
                           Ezxmlm.make_tag "FixedPrice"
                             ([], (Double.to_xml f)))])
                    @
                    [Util.option_map v.usage_price
                       (fun f ->
                          Ezxmlm.make_tag "UsagePrice"
                            ([], (Double.to_xml f)))])
                   @
                   [Util.option_map v.currency_code
                      (fun f ->
                         Ezxmlm.make_tag "CurrencyCode"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.d_b_instance_count
                     (fun f ->
                        Ezxmlm.make_tag "DBInstanceCount"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.product_description
                    (fun f ->
                       Ezxmlm.make_tag "ProductDescription"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.offering_type
                   (fun f ->
                      Ezxmlm.make_tag "OfferingType" ([], (String.to_xml f)))])
               @
               [Util.option_map v.multi_a_z
                  (fun f ->
                     Ezxmlm.make_tag "MultiAZ" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.state
                 (fun f -> Ezxmlm.make_tag "State" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "RecurringCharges"
                        ([], (RecurringChargeList.to_xml [x]))))
                v.recurring_charges))
            @
            [Util.option_map v.reserved_d_b_instance_arn
               (fun f ->
                  Ezxmlm.make_tag "ReservedDBInstanceArn"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.lease_id
              (fun f -> Ezxmlm.make_tag "LeaseId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>DescribeReservedDBInstances</code> and <code>PurchaseReservedDBInstancesOffering</code> actions. </p>"]
module DBClusterSnapshotAttributeList =
  struct
    type t = DBClusterSnapshotAttribute.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list DBClusterSnapshotAttribute.to_query v
    let to_headers v =
      Headers.to_headers_list DBClusterSnapshotAttribute.to_headers v
    let to_json v = `List (List.map DBClusterSnapshotAttribute.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterSnapshotAttribute.parse
           (Xml.members "DBClusterSnapshotAttribute" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (DBClusterSnapshotAttribute.to_xml x))) v
  end
module ResourcePendingMaintenanceActions =
  struct
    type t =
      {
      resource_identifier: String.t option
        [@ocaml.doc
          "<p>The ARN of the resource that has pending maintenance actions.</p>"];
      pending_maintenance_action_details: PendingMaintenanceActionDetails.t
        [@ocaml.doc
          "<p>A list that provides details about the pending maintenance actions for the resource.</p>"]}
    [@@ocaml.doc
      "<p>Describes the pending maintenance actions for a resource.</p>"]
    let make ?resource_identifier  ?(pending_maintenance_action_details= []) 
      () = { resource_identifier; pending_maintenance_action_details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("pending_maintenance_action_details",
                (PendingMaintenanceActionDetails.to_json
                   v.pending_maintenance_action_details));
           Util.option_map v.resource_identifier
             (fun f -> ("resource_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          resource_identifier =
            (Util.option_bind (Xml.member "ResourceIdentifier" xml)
               String.parse);
          pending_maintenance_action_details =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "PendingMaintenanceActionDetails" xml)
                  PendingMaintenanceActionDetails.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.resource_identifier
               (fun f ->
                  Ezxmlm.make_tag "ResourceIdentifier"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "PendingMaintenanceActionDetails"
                      ([], (PendingMaintenanceActionDetails.to_xml [x]))))
              v.pending_maintenance_action_details))
  end[@@ocaml.doc
       "<p>Describes the pending maintenance actions for a resource.</p>"]
module DBProxyTargetGroup =
  struct
    type t =
      {
      d_b_proxy_name: String.t option
        [@ocaml.doc
          "<p>The identifier for the RDS proxy associated with this target group.</p>"];
      target_group_name: String.t option
        [@ocaml.doc
          "<p>The identifier for the target group. This name must be unique for all target groups owned by your AWS account in the specified AWS Region.</p>"];
      target_group_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) representing the target group.</p>"];
      is_default: Boolean.t option
        [@ocaml.doc
          "<p>Whether this target group is the first one used for connection requests by the associated proxy. Because each proxy is currently associated with a single target group, currently this setting is always <code>true</code>.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The current status of this target group. A status of <code>available</code> means the target group is correctly associated with a database. Other values indicate that you must wait for the target group to be ready, or take some action to resolve an issue.</p>"];
      connection_pool_config: ConnectionPoolConfigurationInfo.t option
        [@ocaml.doc
          "<p>The settings that determine the size and behavior of the connection pool for the target group.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the target group was first created.</p>"];
      updated_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the target group was last updated.</p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Represents a set of RDS DB instances, Aurora DB clusters, or both that a proxy can connect to. Currently, each target group is associated with exactly one RDS DB instance or Aurora DB cluster.</p> <p>This data type is used as a response element in the <code>DescribeDBProxyTargetGroups</code> action.</p>"]
    let make ?d_b_proxy_name  ?target_group_name  ?target_group_arn 
      ?is_default  ?status  ?connection_pool_config  ?created_date 
      ?updated_date  () =
      {
        d_b_proxy_name;
        target_group_name;
        target_group_arn;
        is_default;
        status;
        connection_pool_config;
        created_date;
        updated_date
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.updated_date
              (fun f -> ("updated_date", (DateTime.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.connection_pool_config
             (fun f ->
                ("connection_pool_config",
                  (ConnectionPoolConfigurationInfo.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.is_default
             (fun f -> ("is_default", (Boolean.to_json f)));
           Util.option_map v.target_group_arn
             (fun f -> ("target_group_arn", (String.to_json f)));
           Util.option_map v.target_group_name
             (fun f -> ("target_group_name", (String.to_json f)));
           Util.option_map v.d_b_proxy_name
             (fun f -> ("d_b_proxy_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_proxy_name =
            (Util.option_bind (Xml.member "DBProxyName" xml) String.parse);
          target_group_name =
            (Util.option_bind (Xml.member "TargetGroupName" xml) String.parse);
          target_group_arn =
            (Util.option_bind (Xml.member "TargetGroupArn" xml) String.parse);
          is_default =
            (Util.option_bind (Xml.member "IsDefault" xml) Boolean.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          connection_pool_config =
            (Util.option_bind (Xml.member "ConnectionPoolConfig" xml)
               ConnectionPoolConfigurationInfo.parse);
          created_date =
            (Util.option_bind (Xml.member "CreatedDate" xml) DateTime.parse);
          updated_date =
            (Util.option_bind (Xml.member "UpdatedDate" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.d_b_proxy_name
                     (fun f ->
                        Ezxmlm.make_tag "DBProxyName" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.target_group_name
                    (fun f ->
                       Ezxmlm.make_tag "TargetGroupName"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.target_group_arn
                   (fun f ->
                      Ezxmlm.make_tag "TargetGroupArn"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.is_default
                  (fun f ->
                     Ezxmlm.make_tag "IsDefault" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.status
                 (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
             @
             [Util.option_map v.connection_pool_config
                (fun f ->
                   Ezxmlm.make_tag "ConnectionPoolConfig"
                     ([], (ConnectionPoolConfigurationInfo.to_xml f)))])
            @
            [Util.option_map v.created_date
               (fun f ->
                  Ezxmlm.make_tag "CreatedDate" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.updated_date
              (fun f ->
                 Ezxmlm.make_tag "UpdatedDate" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Represents a set of RDS DB instances, Aurora DB clusters, or both that a proxy can connect to. Currently, each target group is associated with exactly one RDS DB instance or Aurora DB cluster.</p> <p>This data type is used as a response element in the <code>DescribeDBProxyTargetGroups</code> action.</p>"]
module DBProxyTarget =
  struct
    type t =
      {
      target_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the RDS DB instance or Aurora DB cluster.</p>"];
      endpoint: String.t option
        [@ocaml.doc
          "<p>The writer endpoint for the RDS DB instance or Aurora DB cluster.</p>"];
      tracked_cluster_id: String.t option
        [@ocaml.doc
          "<p>The DB cluster identifier when the target represents an Aurora DB cluster. This field is blank when the target represents an RDS DB instance.</p>"];
      rds_resource_id: String.t option
        [@ocaml.doc
          "<p>The identifier representing the target. It can be the instance identifier for an RDS DB instance, or the cluster identifier for an Aurora DB cluster.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port that the RDS Proxy uses to connect to the target RDS DB instance or Aurora DB cluster.</p>"];
      type_: TargetType.t option
        [@ocaml.doc
          "<p>Specifies the kind of database, such as an RDS DB instance or an Aurora DB cluster, that the target represents.</p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Contains the details for an RDS Proxy target. It represents an RDS DB instance or Aurora DB cluster that the proxy can connect to. One or more targets are associated with an RDS Proxy target group.</p> <p>This data type is used as a response element in the <code>DescribeDBProxyTargets</code> action.</p>"]
    let make ?target_arn  ?endpoint  ?tracked_cluster_id  ?rds_resource_id 
      ?port  ?type_  () =
      {
        target_arn;
        endpoint;
        tracked_cluster_id;
        rds_resource_id;
        port;
        type_
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (TargetType.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.rds_resource_id
             (fun f -> ("rds_resource_id", (String.to_json f)));
           Util.option_map v.tracked_cluster_id
             (fun f -> ("tracked_cluster_id", (String.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (String.to_json f)));
           Util.option_map v.target_arn
             (fun f -> ("target_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          target_arn =
            (Util.option_bind (Xml.member "TargetArn" xml) String.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) String.parse);
          tracked_cluster_id =
            (Util.option_bind (Xml.member "TrackedClusterId" xml)
               String.parse);
          rds_resource_id =
            (Util.option_bind (Xml.member "RdsResourceId" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          type_ = (Util.option_bind (Xml.member "Type" xml) TargetType.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.target_arn
                   (fun f ->
                      Ezxmlm.make_tag "TargetArn" ([], (String.to_xml f)))])
               @
               [Util.option_map v.endpoint
                  (fun f ->
                     Ezxmlm.make_tag "Endpoint" ([], (String.to_xml f)))])
              @
              [Util.option_map v.tracked_cluster_id
                 (fun f ->
                    Ezxmlm.make_tag "TrackedClusterId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.rds_resource_id
                (fun f ->
                   Ezxmlm.make_tag "RdsResourceId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.port
               (fun f -> Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.type_
              (fun f -> Ezxmlm.make_tag "Type" ([], (TargetType.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Contains the details for an RDS Proxy target. It represents an RDS DB instance or Aurora DB cluster that the proxy can connect to. One or more targets are associated with an RDS Proxy target group.</p> <p>This data type is used as a response element in the <code>DescribeDBProxyTargets</code> action.</p>"]
module DBEngineVersion =
  struct
    type t =
      {
      engine: String.t option
        [@ocaml.doc "<p>The name of the database engine.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>The version number of the database engine.</p>"];
      d_b_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>The name of the DB parameter group family for the database engine.</p>"];
      d_b_engine_description: String.t option
        [@ocaml.doc "<p>The description of the database engine.</p>"];
      d_b_engine_version_description: String.t option
        [@ocaml.doc "<p>The description of the database engine version.</p>"];
      default_character_set: CharacterSet.t option
        [@ocaml.doc
          "<p> The default character set for new instances of this engine version, if the <code>CharacterSetName</code> parameter of the CreateDBInstance API isn't specified. </p>"];
      supported_character_sets: SupportedCharacterSetsList.t
        [@ocaml.doc
          "<p> A list of the character sets supported by this engine for the <code>CharacterSetName</code> parameter of the <code>CreateDBInstance</code> action. </p>"];
      valid_upgrade_target: ValidUpgradeTargetList.t
        [@ocaml.doc
          "<p>A list of engine versions that this database engine version can be upgraded to.</p>"];
      supported_timezones: SupportedTimezonesList.t
        [@ocaml.doc
          "<p>A list of the time zones supported by this engine for the <code>Timezone</code> parameter of the <code>CreateDBInstance</code> action. </p>"];
      exportable_log_types: LogTypeList.t
        [@ocaml.doc
          "<p>The types of logs that the database engine has available for export to CloudWatch Logs.</p>"];
      supports_log_exports_to_cloudwatch_logs: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the engine version supports exporting the log types specified by ExportableLogTypes to CloudWatch Logs.</p>"];
      supports_read_replica: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the database engine version supports Read Replicas.</p>"];
      supported_engine_modes: EngineModeList.t
        [@ocaml.doc "<p>A list of the supported DB engine modes.</p>"];
      supported_feature_names: FeatureNameList.t
        [@ocaml.doc
          "<p> A list of features supported by the DB engine. Supported feature names include the following. </p> <ul> <li> <p>s3Import</p> </li> </ul>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the DB engine version, either <code>available</code> or <code>deprecated</code>.</p>"]}
    [@@ocaml.doc
      "<p> This data type is used as a response element in the action <code>DescribeDBEngineVersions</code>. </p>"]
    let make ?engine  ?engine_version  ?d_b_parameter_group_family 
      ?d_b_engine_description  ?d_b_engine_version_description 
      ?default_character_set  ?(supported_character_sets= []) 
      ?(valid_upgrade_target= [])  ?(supported_timezones= []) 
      ?(exportable_log_types= [])  ?supports_log_exports_to_cloudwatch_logs 
      ?supports_read_replica  ?(supported_engine_modes= []) 
      ?(supported_feature_names= [])  ?status  () =
      {
        engine;
        engine_version;
        d_b_parameter_group_family;
        d_b_engine_description;
        d_b_engine_version_description;
        default_character_set;
        supported_character_sets;
        valid_upgrade_target;
        supported_timezones;
        exportable_log_types;
        supports_log_exports_to_cloudwatch_logs;
        supports_read_replica;
        supported_engine_modes;
        supported_feature_names;
        status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Some
             ("supported_feature_names",
               (FeatureNameList.to_json v.supported_feature_names));
           Some
             ("supported_engine_modes",
               (EngineModeList.to_json v.supported_engine_modes));
           Util.option_map v.supports_read_replica
             (fun f -> ("supports_read_replica", (Boolean.to_json f)));
           Util.option_map v.supports_log_exports_to_cloudwatch_logs
             (fun f ->
                ("supports_log_exports_to_cloudwatch_logs",
                  (Boolean.to_json f)));
           Some
             ("exportable_log_types",
               (LogTypeList.to_json v.exportable_log_types));
           Some
             ("supported_timezones",
               (SupportedTimezonesList.to_json v.supported_timezones));
           Some
             ("valid_upgrade_target",
               (ValidUpgradeTargetList.to_json v.valid_upgrade_target));
           Some
             ("supported_character_sets",
               (SupportedCharacterSetsList.to_json v.supported_character_sets));
           Util.option_map v.default_character_set
             (fun f -> ("default_character_set", (CharacterSet.to_json f)));
           Util.option_map v.d_b_engine_version_description
             (fun f -> ("d_b_engine_version_description", (String.to_json f)));
           Util.option_map v.d_b_engine_description
             (fun f -> ("d_b_engine_description", (String.to_json f)));
           Util.option_map v.d_b_parameter_group_family
             (fun f -> ("d_b_parameter_group_family", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          d_b_parameter_group_family =
            (Util.option_bind (Xml.member "DBParameterGroupFamily" xml)
               String.parse);
          d_b_engine_description =
            (Util.option_bind (Xml.member "DBEngineDescription" xml)
               String.parse);
          d_b_engine_version_description =
            (Util.option_bind (Xml.member "DBEngineVersionDescription" xml)
               String.parse);
          default_character_set =
            (Util.option_bind (Xml.member "DefaultCharacterSet" xml)
               CharacterSet.parse);
          supported_character_sets =
            (Util.of_option []
               (Util.option_bind (Xml.member "SupportedCharacterSets" xml)
                  SupportedCharacterSetsList.parse));
          valid_upgrade_target =
            (Util.of_option []
               (Util.option_bind (Xml.member "ValidUpgradeTarget" xml)
                  ValidUpgradeTargetList.parse));
          supported_timezones =
            (Util.of_option []
               (Util.option_bind (Xml.member "SupportedTimezones" xml)
                  SupportedTimezonesList.parse));
          exportable_log_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "ExportableLogTypes" xml)
                  LogTypeList.parse));
          supports_log_exports_to_cloudwatch_logs =
            (Util.option_bind
               (Xml.member "SupportsLogExportsToCloudwatchLogs" xml)
               Boolean.parse);
          supports_read_replica =
            (Util.option_bind (Xml.member "SupportsReadReplica" xml)
               Boolean.parse);
          supported_engine_modes =
            (Util.of_option []
               (Util.option_bind (Xml.member "SupportedEngineModes" xml)
                  EngineModeList.parse));
          supported_feature_names =
            (Util.of_option []
               (Util.option_bind (Xml.member "SupportedFeatureNames" xml)
                  FeatureNameList.parse));
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((([] @
                         [Util.option_map v.engine
                            (fun f ->
                               Ezxmlm.make_tag "Engine"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.engine_version
                           (fun f ->
                              Ezxmlm.make_tag "EngineVersion"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.d_b_parameter_group_family
                          (fun f ->
                             Ezxmlm.make_tag "DBParameterGroupFamily"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.d_b_engine_description
                         (fun f ->
                            Ezxmlm.make_tag "DBEngineDescription"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.d_b_engine_version_description
                        (fun f ->
                           Ezxmlm.make_tag "DBEngineVersionDescription"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.default_character_set
                       (fun f ->
                          Ezxmlm.make_tag "DefaultCharacterSet"
                            ([], (CharacterSet.to_xml f)))])
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "SupportedCharacterSets"
                              ([], (SupportedCharacterSetsList.to_xml [x]))))
                      v.supported_character_sets))
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "ValidUpgradeTarget"
                             ([], (ValidUpgradeTargetList.to_xml [x]))))
                     v.valid_upgrade_target))
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "SupportedTimezones"
                            ([], (SupportedTimezonesList.to_xml [x]))))
                    v.supported_timezones))
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "ExportableLogTypes"
                           ([], (LogTypeList.to_xml [x]))))
                   v.exportable_log_types))
               @
               [Util.option_map v.supports_log_exports_to_cloudwatch_logs
                  (fun f ->
                     Ezxmlm.make_tag "SupportsLogExportsToCloudwatchLogs"
                       ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.supports_read_replica
                 (fun f ->
                    Ezxmlm.make_tag "SupportsReadReplica"
                      ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "SupportedEngineModes"
                        ([], (EngineModeList.to_xml [x]))))
                v.supported_engine_modes))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "SupportedFeatureNames"
                       ([], (FeatureNameList.to_xml [x]))))
               v.supported_feature_names))
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the action <code>DescribeDBEngineVersions</code>. </p>"]
module DBSnapshot =
  struct
    type t =
      {
      d_b_snapshot_identifier: String.t option
        [@ocaml.doc "<p>Specifies the identifier for the DB snapshot.</p>"];
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>Specifies the DB instance identifier of the DB instance this DB snapshot was created from.</p>"];
      snapshot_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Provides the time when the snapshot was taken, in Universal Coordinated Time (UTC).</p>"];
      engine: String.t option
        [@ocaml.doc "<p>Specifies the name of the database engine.</p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>Specifies the allocated storage size in gibibytes (GiB).</p>"];
      status: String.t option
        [@ocaml.doc "<p>Specifies the status of this DB snapshot.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>Specifies the port that the database engine was listening on at the time of the snapshot.</p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the Availability Zone the DB instance was located in at the time of the DB snapshot.</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>Provides the VPC ID associated with the DB snapshot.</p>"];
      instance_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the time when the snapshot was taken, in Universal Coordinated Time (UTC).</p>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>Provides the master username for the DB snapshot.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>Specifies the version of the database engine.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>License model information for the restored DB instance.</p>"];
      snapshot_type: String.t option
        [@ocaml.doc "<p>Provides the type of the DB snapshot.</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>Specifies the Provisioned IOPS (I/O operations per second) value of the DB instance at the time of the snapshot.</p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>Provides the option group name for the DB snapshot.</p>"];
      percent_progress: Integer.t option
        [@ocaml.doc
          "<p>The percentage of the estimated data that has been transferred.</p>"];
      source_region: String.t option
        [@ocaml.doc
          "<p>The AWS Region that the DB snapshot was created in or copied from.</p>"];
      source_d_b_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>The DB snapshot Amazon Resource Name (ARN) that the DB snapshot was copied from. It only has value in case of cross-customer or cross-region copy.</p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type associated with DB snapshot.</p>"];
      tde_credential_arn: String.t option
        [@ocaml.doc
          "<p>The ARN from the key store with which to associate the instance for TDE encryption.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc "<p>Specifies whether the DB snapshot is encrypted.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p> If <code>Encrypted</code> is true, the AWS KMS key identifier for the encrypted DB snapshot. </p>"];
      d_b_snapshot_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB snapshot.</p>"];
      timezone: String.t option
        [@ocaml.doc
          "<p>The time zone of the DB snapshot. In most cases, the <code>Timezone</code> element is empty. <code>Timezone</code> content appears only for snapshots taken from Microsoft SQL Server DB instances that were created with a time zone specified. </p>"];
      i_a_m_database_authentication_enabled: Boolean.t option
        [@ocaml.doc
          "<p>True if mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false.</p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance when the DB snapshot was created.</p>"];
      dbi_resource_id: String.t option
        [@ocaml.doc
          "<p>The identifier for the source DB instance, which can't be changed and which is unique to an AWS Region.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details of an Amazon RDS DB snapshot. </p> <p>This data type is used as a response element in the <code>DescribeDBSnapshots</code> action. </p>"]
    let make ?d_b_snapshot_identifier  ?d_b_instance_identifier 
      ?snapshot_create_time  ?engine  ?allocated_storage  ?status  ?port 
      ?availability_zone  ?vpc_id  ?instance_create_time  ?master_username 
      ?engine_version  ?license_model  ?snapshot_type  ?iops 
      ?option_group_name  ?percent_progress  ?source_region 
      ?source_d_b_snapshot_identifier  ?storage_type  ?tde_credential_arn 
      ?encrypted  ?kms_key_id  ?d_b_snapshot_arn  ?timezone 
      ?i_a_m_database_authentication_enabled  ?(processor_features= []) 
      ?dbi_resource_id  () =
      {
        d_b_snapshot_identifier;
        d_b_instance_identifier;
        snapshot_create_time;
        engine;
        allocated_storage;
        status;
        port;
        availability_zone;
        vpc_id;
        instance_create_time;
        master_username;
        engine_version;
        license_model;
        snapshot_type;
        iops;
        option_group_name;
        percent_progress;
        source_region;
        source_d_b_snapshot_identifier;
        storage_type;
        tde_credential_arn;
        encrypted;
        kms_key_id;
        d_b_snapshot_arn;
        timezone;
        i_a_m_database_authentication_enabled;
        processor_features;
        dbi_resource_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.dbi_resource_id
              (fun f -> ("dbi_resource_id", (String.to_json f)));
           Some
             ("processor_features",
               (ProcessorFeatureList.to_json v.processor_features));
           Util.option_map v.i_a_m_database_authentication_enabled
             (fun f ->
                ("i_a_m_database_authentication_enabled",
                  (Boolean.to_json f)));
           Util.option_map v.timezone
             (fun f -> ("timezone", (String.to_json f)));
           Util.option_map v.d_b_snapshot_arn
             (fun f -> ("d_b_snapshot_arn", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.tde_credential_arn
             (fun f -> ("tde_credential_arn", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Util.option_map v.source_d_b_snapshot_identifier
             (fun f -> ("source_d_b_snapshot_identifier", (String.to_json f)));
           Util.option_map v.source_region
             (fun f -> ("source_region", (String.to_json f)));
           Util.option_map v.percent_progress
             (fun f -> ("percent_progress", (Integer.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.snapshot_type
             (fun f -> ("snapshot_type", (String.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
           Util.option_map v.instance_create_time
             (fun f -> ("instance_create_time", (DateTime.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.snapshot_create_time
             (fun f -> ("snapshot_create_time", (DateTime.to_json f)));
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)));
           Util.option_map v.d_b_snapshot_identifier
             (fun f -> ("d_b_snapshot_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "DBSnapshotIdentifier" xml)
               String.parse);
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
               String.parse);
          snapshot_create_time =
            (Util.option_bind (Xml.member "SnapshotCreateTime" xml)
               DateTime.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          instance_create_time =
            (Util.option_bind (Xml.member "InstanceCreateTime" xml)
               DateTime.parse);
          master_username =
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          snapshot_type =
            (Util.option_bind (Xml.member "SnapshotType" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          percent_progress =
            (Util.option_bind (Xml.member "PercentProgress" xml)
               Integer.parse);
          source_region =
            (Util.option_bind (Xml.member "SourceRegion" xml) String.parse);
          source_d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "SourceDBSnapshotIdentifier" xml)
               String.parse);
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          tde_credential_arn =
            (Util.option_bind (Xml.member "TdeCredentialArn" xml)
               String.parse);
          encrypted =
            (Util.option_bind (Xml.member "Encrypted" xml) Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          d_b_snapshot_arn =
            (Util.option_bind (Xml.member "DBSnapshotArn" xml) String.parse);
          timezone =
            (Util.option_bind (Xml.member "Timezone" xml) String.parse);
          i_a_m_database_authentication_enabled =
            (Util.option_bind
               (Xml.member "IAMDatabaseAuthenticationEnabled" xml)
               Boolean.parse);
          processor_features =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProcessorFeatures" xml)
                  ProcessorFeatureList.parse));
          dbi_resource_id =
            (Util.option_bind (Xml.member "DbiResourceId" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((([] @
                                      [Util.option_map
                                         v.d_b_snapshot_identifier
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "DBSnapshotIdentifier"
                                              ([], (String.to_xml f)))])
                                     @
                                     [Util.option_map
                                        v.d_b_instance_identifier
                                        (fun f ->
                                           Ezxmlm.make_tag
                                             "DBInstanceIdentifier"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.snapshot_create_time
                                       (fun f ->
                                          Ezxmlm.make_tag
                                            "SnapshotCreateTime"
                                            ([], (DateTime.to_xml f)))])
                                   @
                                   [Util.option_map v.engine
                                      (fun f ->
                                         Ezxmlm.make_tag "Engine"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.allocated_storage
                                     (fun f ->
                                        Ezxmlm.make_tag "AllocatedStorage"
                                          ([], (Integer.to_xml f)))])
                                 @
                                 [Util.option_map v.status
                                    (fun f ->
                                       Ezxmlm.make_tag "Status"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.port
                                   (fun f ->
                                      Ezxmlm.make_tag "Port"
                                        ([], (Integer.to_xml f)))])
                               @
                               [Util.option_map v.availability_zone
                                  (fun f ->
                                     Ezxmlm.make_tag "AvailabilityZone"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.vpc_id
                                 (fun f ->
                                    Ezxmlm.make_tag "VpcId"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.instance_create_time
                                (fun f ->
                                   Ezxmlm.make_tag "InstanceCreateTime"
                                     ([], (DateTime.to_xml f)))])
                            @
                            [Util.option_map v.master_username
                               (fun f ->
                                  Ezxmlm.make_tag "MasterUsername"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.engine_version
                              (fun f ->
                                 Ezxmlm.make_tag "EngineVersion"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.license_model
                             (fun f ->
                                Ezxmlm.make_tag "LicenseModel"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.snapshot_type
                            (fun f ->
                               Ezxmlm.make_tag "SnapshotType"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.iops
                           (fun f ->
                              Ezxmlm.make_tag "Iops" ([], (Integer.to_xml f)))])
                       @
                       [Util.option_map v.option_group_name
                          (fun f ->
                             Ezxmlm.make_tag "OptionGroupName"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.percent_progress
                         (fun f ->
                            Ezxmlm.make_tag "PercentProgress"
                              ([], (Integer.to_xml f)))])
                     @
                     [Util.option_map v.source_region
                        (fun f ->
                           Ezxmlm.make_tag "SourceRegion"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.source_d_b_snapshot_identifier
                       (fun f ->
                          Ezxmlm.make_tag "SourceDBSnapshotIdentifier"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.storage_type
                      (fun f ->
                         Ezxmlm.make_tag "StorageType"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.tde_credential_arn
                     (fun f ->
                        Ezxmlm.make_tag "TdeCredentialArn"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.encrypted
                    (fun f ->
                       Ezxmlm.make_tag "Encrypted" ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.kms_key_id
                   (fun f ->
                      Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.d_b_snapshot_arn
                  (fun f ->
                     Ezxmlm.make_tag "DBSnapshotArn" ([], (String.to_xml f)))])
              @
              [Util.option_map v.timezone
                 (fun f -> Ezxmlm.make_tag "Timezone" ([], (String.to_xml f)))])
             @
             [Util.option_map v.i_a_m_database_authentication_enabled
                (fun f ->
                   Ezxmlm.make_tag "IAMDatabaseAuthenticationEnabled"
                     ([], (Boolean.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ProcessorFeatures"
                       ([], (ProcessorFeatureList.to_xml [x]))))
               v.processor_features))
           @
           [Util.option_map v.dbi_resource_id
              (fun f ->
                 Ezxmlm.make_tag "DbiResourceId" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details of an Amazon RDS DB snapshot. </p> <p>This data type is used as a response element in the <code>DescribeDBSnapshots</code> action. </p>"]
module DBSnapshotAttributeList =
  struct
    type t = DBSnapshotAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBSnapshotAttribute.to_query v
    let to_headers v =
      Headers.to_headers_list DBSnapshotAttribute.to_headers v
    let to_json v = `List (List.map DBSnapshotAttribute.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBSnapshotAttribute.parse
           (Xml.members "DBSnapshotAttribute" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (DBSnapshotAttribute.to_xml x))) v
  end
module EventCategoriesMap =
  struct
    type t =
      {
      source_type: String.t option
        [@ocaml.doc
          "<p>The source type that the returned categories belong to</p>"];
      event_categories: EventCategoriesList.t
        [@ocaml.doc
          "<p>The event categories for the specified source type</p>"]}
    [@@ocaml.doc
      "<p>Contains the results of a successful invocation of the <code>DescribeEventCategories</code> action.</p>"]
    let make ?source_type  ?(event_categories= [])  () =
      { source_type; event_categories }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_categories",
                (EventCategoriesList.to_json v.event_categories));
           Util.option_map v.source_type
             (fun f -> ("source_type", (String.to_json f)))])
    let parse xml =
      Some
        {
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) String.parse);
          event_categories =
            (Util.of_option []
               (Util.option_bind (Xml.member "EventCategories" xml)
                  EventCategoriesList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.source_type
               (fun f -> Ezxmlm.make_tag "SourceType" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "EventCategories"
                      ([], (EventCategoriesList.to_xml [x]))))
              v.event_categories))
  end[@@ocaml.doc
       "<p>Contains the results of a successful invocation of the <code>DescribeEventCategories</code> action.</p>"]
module DBProxy =
  struct
    type t =
      {
      d_b_proxy_name: String.t option
        [@ocaml.doc
          "<p>The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region.</p>"];
      d_b_proxy_arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) for the proxy.</p>"];
      status: DBProxyStatus.t option
        [@ocaml.doc
          "<p>The current status of this proxy. A status of <code>available</code> means the proxy is ready to handle requests. Other values indicate that you must wait for the proxy to be ready, or take some action to resolve an issue.</p>"];
      engine_family: String.t option
        [@ocaml.doc
          "<p>Currently, this value is always <code>MYSQL</code>. The engine family applies to both RDS MySQL and Aurora MySQL.</p>"];
      vpc_security_group_ids: StringList.t
        [@ocaml.doc
          "<p>Provides a list of VPC security groups that the proxy belongs to.</p>"];
      vpc_subnet_ids: StringList.t
        [@ocaml.doc "<p>The EC2 subnet IDs for the proxy.</p>"];
      auth: UserAuthConfigInfoList.t
        [@ocaml.doc
          "<p>One or more data structures specifying the authorization mechanism to connect to the associated RDS DB instance or Aurora DB cluster.</p>"];
      role_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the IAM role that the proxy uses to access Amazon Secrets Manager.</p>"];
      endpoint: String.t option
        [@ocaml.doc
          "<p>The endpoint that you can use to connect to the proxy. You include the endpoint value in the connection string for a database client application.</p>"];
      require_t_l_s: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether Transport Layer Security (TLS) encryption is required for connections to the proxy.</p>"];
      idle_client_timeout: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds a connection to the proxy can have no activity before the proxy drops the client connection. The proxy keeps the underlying database connection open and puts it back into the connection pool for reuse by later connection requests.</p> <p>Default: 1800 (30 minutes)</p> <p>Constraints: 1 to 28,800</p>"];
      debug_logging: Boolean.t option
        [@ocaml.doc
          "<p>Whether the proxy includes detailed information about SQL statements in its logs. This information helps you to debug issues involving SQL behavior or the performance and scalability of the proxy connections. The debug information includes the text of SQL statements that you submit through the proxy. Thus, only enable this setting when needed for debugging, and only when you have security measures in place to safeguard any sensitive information that appears in the logs.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the proxy was first created.</p>"];
      updated_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when the proxy was last updated.</p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>The data structure representing a proxy managed by the RDS Proxy.</p> <p>This data type is used as a response element in the <code>DescribeDBProxies</code> action.</p>"]
    let make ?d_b_proxy_name  ?d_b_proxy_arn  ?status  ?engine_family 
      ?(vpc_security_group_ids= [])  ?(vpc_subnet_ids= [])  ?(auth= []) 
      ?role_arn  ?endpoint  ?require_t_l_s  ?idle_client_timeout 
      ?debug_logging  ?created_date  ?updated_date  () =
      {
        d_b_proxy_name;
        d_b_proxy_arn;
        status;
        engine_family;
        vpc_security_group_ids;
        vpc_subnet_ids;
        auth;
        role_arn;
        endpoint;
        require_t_l_s;
        idle_client_timeout;
        debug_logging;
        created_date;
        updated_date
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.updated_date
              (fun f -> ("updated_date", (DateTime.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.debug_logging
             (fun f -> ("debug_logging", (Boolean.to_json f)));
           Util.option_map v.idle_client_timeout
             (fun f -> ("idle_client_timeout", (Integer.to_json f)));
           Util.option_map v.require_t_l_s
             (fun f -> ("require_t_l_s", (Boolean.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (String.to_json f)));
           Util.option_map v.role_arn
             (fun f -> ("role_arn", (String.to_json f)));
           Some ("auth", (UserAuthConfigInfoList.to_json v.auth));
           Some ("vpc_subnet_ids", (StringList.to_json v.vpc_subnet_ids));
           Some
             ("vpc_security_group_ids",
               (StringList.to_json v.vpc_security_group_ids));
           Util.option_map v.engine_family
             (fun f -> ("engine_family", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (DBProxyStatus.to_json f)));
           Util.option_map v.d_b_proxy_arn
             (fun f -> ("d_b_proxy_arn", (String.to_json f)));
           Util.option_map v.d_b_proxy_name
             (fun f -> ("d_b_proxy_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_proxy_name =
            (Util.option_bind (Xml.member "DBProxyName" xml) String.parse);
          d_b_proxy_arn =
            (Util.option_bind (Xml.member "DBProxyArn" xml) String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml) DBProxyStatus.parse);
          engine_family =
            (Util.option_bind (Xml.member "EngineFamily" xml) String.parse);
          vpc_security_group_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroupIds" xml)
                  StringList.parse));
          vpc_subnet_ids =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSubnetIds" xml)
                  StringList.parse));
          auth =
            (Util.of_option []
               (Util.option_bind (Xml.member "Auth" xml)
                  UserAuthConfigInfoList.parse));
          role_arn =
            (Util.option_bind (Xml.member "RoleArn" xml) String.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) String.parse);
          require_t_l_s =
            (Util.option_bind (Xml.member "RequireTLS" xml) Boolean.parse);
          idle_client_timeout =
            (Util.option_bind (Xml.member "IdleClientTimeout" xml)
               Integer.parse);
          debug_logging =
            (Util.option_bind (Xml.member "DebugLogging" xml) Boolean.parse);
          created_date =
            (Util.option_bind (Xml.member "CreatedDate" xml) DateTime.parse);
          updated_date =
            (Util.option_bind (Xml.member "UpdatedDate" xml) DateTime.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((([] @
                        [Util.option_map v.d_b_proxy_name
                           (fun f ->
                              Ezxmlm.make_tag "DBProxyName"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.d_b_proxy_arn
                          (fun f ->
                             Ezxmlm.make_tag "DBProxyArn"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.status
                         (fun f ->
                            Ezxmlm.make_tag "Status"
                              ([], (DBProxyStatus.to_xml f)))])
                     @
                     [Util.option_map v.engine_family
                        (fun f ->
                           Ezxmlm.make_tag "EngineFamily"
                             ([], (String.to_xml f)))])
                    @
                    (List.map
                       (fun x ->
                          Some
                            (Ezxmlm.make_tag "VpcSecurityGroupIds"
                               ([], (StringList.to_xml [x]))))
                       v.vpc_security_group_ids))
                   @
                   (List.map
                      (fun x ->
                         Some
                           (Ezxmlm.make_tag "VpcSubnetIds"
                              ([], (StringList.to_xml [x]))))
                      v.vpc_subnet_ids))
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "Auth"
                             ([], (UserAuthConfigInfoList.to_xml [x]))))
                     v.auth))
                 @
                 [Util.option_map v.role_arn
                    (fun f ->
                       Ezxmlm.make_tag "RoleArn" ([], (String.to_xml f)))])
                @
                [Util.option_map v.endpoint
                   (fun f ->
                      Ezxmlm.make_tag "Endpoint" ([], (String.to_xml f)))])
               @
               [Util.option_map v.require_t_l_s
                  (fun f ->
                     Ezxmlm.make_tag "RequireTLS" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.idle_client_timeout
                 (fun f ->
                    Ezxmlm.make_tag "IdleClientTimeout"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.debug_logging
                (fun f ->
                   Ezxmlm.make_tag "DebugLogging" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.created_date
               (fun f ->
                  Ezxmlm.make_tag "CreatedDate" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.updated_date
              (fun f ->
                 Ezxmlm.make_tag "UpdatedDate" ([], (DateTime.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>The data structure representing a proxy managed by the RDS Proxy.</p> <p>This data type is used as a response element in the <code>DescribeDBProxies</code> action.</p>"]
module DBInstance =
  struct
    type t =
      {
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>Contains a user-supplied database identifier. This identifier is the unique key that identifies a DB instance.</p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>Contains the name of the compute and memory capacity class of the DB instance.</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>Provides the name of the database engine to be used for this DB instance.</p>"];
      d_b_instance_status: String.t option
        [@ocaml.doc "<p>Specifies the current state of this database.</p>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>Contains the master username for the DB instance.</p>"];
      d_b_name: String.t option
        [@ocaml.doc
          "<p>The meaning of this parameter differs according to the database engine you use.</p> <p> <b>MySQL, MariaDB, SQL Server, PostgreSQL</b> </p> <p>Contains the name of the initial database of this instance that was provided at create time, if one was specified when the DB instance was created. This same name is returned for the life of the DB instance.</p> <p>Type: String</p> <p> <b>Oracle</b> </p> <p>Contains the Oracle System ID (SID) of the created DB instance. Not shown when the returned parameters do not apply to an Oracle DB instance.</p>"];
      endpoint: Endpoint.t option
        [@ocaml.doc "<p>Specifies the connection endpoint.</p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>Specifies the allocated storage size specified in gibibytes.</p>"];
      instance_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Provides the date and time the DB instance was created.</p>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p> Specifies the daily time range during which automated backups are created if automated backups are enabled, as determined by the <code>BackupRetentionPeriod</code>. </p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>Specifies the number of days for which automatic DB snapshots are retained.</p>"];
      d_b_security_groups: DBSecurityGroupMembershipList.t
        [@ocaml.doc
          "<p> A list of DB security group elements containing <code>DBSecurityGroup.Name</code> and <code>DBSecurityGroup.Status</code> subelements. </p>"];
      vpc_security_groups: VpcSecurityGroupMembershipList.t
        [@ocaml.doc
          "<p>Provides a list of VPC security group elements that the DB instance belongs to.</p>"];
      d_b_parameter_groups: DBParameterGroupStatusList.t
        [@ocaml.doc
          "<p>Provides the list of DB parameter groups applied to this DB instance.</p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the Availability Zone the DB instance is located in.</p>"];
      d_b_subnet_group: DBSubnetGroup.t option
        [@ocaml.doc
          "<p>Specifies information on the subnet group associated with the DB instance, including the name, description, and subnets in the subnet group.</p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).</p>"];
      pending_modified_values: PendingModifiedValues.t option
        [@ocaml.doc
          "<p>Specifies that changes to the DB instance are pending. This element is only included when changes are pending. Specific changes are identified by subelements.</p>"];
      latest_restorable_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the latest time to which a database can be restored with point-in-time restore.</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>Specifies if the DB instance is a Multi-AZ deployment.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>Indicates the database engine version.</p>"];
      auto_minor_version_upgrade: Boolean.t option
        [@ocaml.doc
          "<p>Indicates that minor version patches are applied automatically.</p>"];
      read_replica_source_d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>Contains the identifier of the source DB instance if this DB instance is a Read Replica.</p>"];
      read_replica_d_b_instance_identifiers:
        ReadReplicaDBInstanceIdentifierList.t
        [@ocaml.doc
          "<p>Contains one or more identifiers of the Read Replicas associated with this DB instance.</p>"];
      read_replica_d_b_cluster_identifiers:
        ReadReplicaDBClusterIdentifierList.t
        [@ocaml.doc
          "<p>Contains one or more identifiers of Aurora DB clusters to which the RDS DB instance is replicated as a Read Replica. For example, when you create an Aurora Read Replica of an RDS MySQL DB instance, the Aurora MySQL DB cluster for the Aurora Read Replica is shown. This output does not contain information about cross region Aurora Read Replicas.</p> <note> <p>Currently, each RDS DB instance can have only one Aurora Read Replica.</p> </note>"];
      license_model: String.t option
        [@ocaml.doc "<p>License model information for this DB instance.</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>Specifies the Provisioned IOPS (I/O operations per second) value.</p>"];
      option_group_memberships: OptionGroupMembershipList.t
        [@ocaml.doc
          "<p>Provides the list of option group memberships for this DB instance.</p>"];
      character_set_name: String.t option
        [@ocaml.doc
          "<p>If present, specifies the name of the character set that this instance is associated with.</p>"];
      secondary_availability_zone: String.t option
        [@ocaml.doc
          "<p>If present, specifies the name of the secondary Availability Zone for a DB instance with multi-AZ support.</p>"];
      publicly_accessible: Boolean.t option
        [@ocaml.doc
          "<p>Specifies the accessibility options for the DB instance. A value of true specifies an Internet-facing instance with a publicly resolvable DNS name, which resolves to a public IP address. A value of false specifies an internal instance with a DNS name that resolves to a private IP address.</p>"];
      status_infos: DBInstanceStatusInfoList.t
        [@ocaml.doc
          "<p>The status of a Read Replica. If the instance isn't a Read Replica, this is blank.</p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type associated with DB instance.</p>"];
      tde_credential_arn: String.t option
        [@ocaml.doc
          "<p>The ARN from the key store with which the instance is associated for TDE encryption.</p>"];
      db_instance_port: Integer.t option
        [@ocaml.doc
          "<p>Specifies the port that the DB instance listens on. If the DB instance is part of a DB cluster, this can be a different port than the DB cluster port.</p>"];
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>If the DB instance is a member of a DB cluster, contains the name of the DB cluster that the DB instance is a member of.</p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc "<p>Specifies whether the DB instance is encrypted.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p> If <code>StorageEncrypted</code> is true, the AWS KMS key identifier for the encrypted DB instance. </p>"];
      dbi_resource_id: String.t option
        [@ocaml.doc
          "<p>The AWS Region-unique, immutable identifier for the DB instance. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB instance is accessed.</p>"];
      c_a_certificate_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the CA certificate for this DB instance.</p>"];
      domain_memberships: DomainMembershipList.t
        [@ocaml.doc
          "<p>The Active Directory Domain membership records associated with the DB instance.</p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether tags are copied from the DB instance to snapshots of the DB instance.</p> <p> <b>Amazon Aurora</b> </p> <p>Not applicable. Copying tags to snapshots is managed by the DB cluster. Setting this value for an Aurora DB instance has no effect on the DB cluster setting. For more information, see <code>DBCluster</code>.</p>"];
      monitoring_interval: Integer.t option
        [@ocaml.doc
          "<p>The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance.</p>"];
      enhanced_monitoring_resource_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the Amazon CloudWatch Logs log stream that receives the Enhanced Monitoring metrics data for the DB instance.</p>"];
      monitoring_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN for the IAM role that permits RDS to send Enhanced Monitoring metrics to Amazon CloudWatch Logs.</p>"];
      promotion_tier: Integer.t option
        [@ocaml.doc
          "<p>A value that specifies the order in which an Aurora Replica is promoted to the primary instance after a failure of the existing primary instance. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html#Aurora.Managing.FaultTolerance\"> Fault Tolerance for an Aurora DB Cluster</a> in the <i>Amazon Aurora User Guide</i>. </p>"];
      d_b_instance_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB instance.</p>"];
      timezone: String.t option
        [@ocaml.doc
          "<p>The time zone of the DB instance. In most cases, the <code>Timezone</code> element is empty. <code>Timezone</code> content appears only for Microsoft SQL Server DB instances that were created with a time zone specified. </p>"];
      i_a_m_database_authentication_enabled: Boolean.t option
        [@ocaml.doc
          "<p>True if mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false.</p> <p>IAM database authentication can be enabled for the following database engines</p> <ul> <li> <p>For MySQL 5.6, minor version 5.6.34 or higher</p> </li> <li> <p>For MySQL 5.7, minor version 5.7.16 or higher</p> </li> <li> <p>Aurora 5.6 or higher. To enable IAM database authentication for Aurora, see DBCluster Type.</p> </li> </ul>"];
      performance_insights_enabled: Boolean.t option
        [@ocaml.doc
          "<p>True if Performance Insights is enabled for the DB instance, and otherwise false.</p>"];
      performance_insights_k_m_s_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encryption of Performance Insights data. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key.</p>"];
      performance_insights_retention_period: Integer.t option
        [@ocaml.doc
          "<p>The amount of time, in days, to retain Performance Insights data. Valid values are 7 or 731 (2 years). </p>"];
      enabled_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>A list of log types that this DB instance is configured to export to CloudWatch Logs.</p> <p>Log types vary by DB engine. For information about the log types for each DB engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html\">Amazon RDS Database Log Files</a> in the <i>Amazon RDS User Guide.</i> </p>"];
      processor_features: ProcessorFeatureList.t
        [@ocaml.doc
          "<p>The number of CPU cores and the number of threads per core for the DB instance class of the DB instance.</p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>Indicates if the DB instance has deletion protection enabled. The database can't be deleted when deletion protection is enabled. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_DeleteInstance.html\"> Deleting a DB Instance</a>. </p>"];
      associated_roles: DBInstanceRoles.t
        [@ocaml.doc
          "<p> The AWS Identity and Access Management (IAM) roles associated with the DB instance. </p>"];
      listener_endpoint: Endpoint.t option
        [@ocaml.doc
          "<p>Specifies the listener connection endpoint for SQL Server Always On.</p>"];
      max_allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>The upper limit to which Amazon RDS can automatically scale the storage of the DB instance.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details of an Amazon RDS DB instance. </p> <p>This data type is used as a response element in the <code>DescribeDBInstances</code> action. </p>"]
    let make ?d_b_instance_identifier  ?d_b_instance_class  ?engine 
      ?d_b_instance_status  ?master_username  ?d_b_name  ?endpoint 
      ?allocated_storage  ?instance_create_time  ?preferred_backup_window 
      ?backup_retention_period  ?(d_b_security_groups= []) 
      ?(vpc_security_groups= [])  ?(d_b_parameter_groups= []) 
      ?availability_zone  ?d_b_subnet_group  ?preferred_maintenance_window 
      ?pending_modified_values  ?latest_restorable_time  ?multi_a_z 
      ?engine_version  ?auto_minor_version_upgrade 
      ?read_replica_source_d_b_instance_identifier 
      ?(read_replica_d_b_instance_identifiers= []) 
      ?(read_replica_d_b_cluster_identifiers= [])  ?license_model  ?iops 
      ?(option_group_memberships= [])  ?character_set_name 
      ?secondary_availability_zone  ?publicly_accessible  ?(status_infos= [])
       ?storage_type  ?tde_credential_arn  ?db_instance_port 
      ?d_b_cluster_identifier  ?storage_encrypted  ?kms_key_id 
      ?dbi_resource_id  ?c_a_certificate_identifier  ?(domain_memberships=
      [])  ?copy_tags_to_snapshot  ?monitoring_interval 
      ?enhanced_monitoring_resource_arn  ?monitoring_role_arn 
      ?promotion_tier  ?d_b_instance_arn  ?timezone 
      ?i_a_m_database_authentication_enabled  ?performance_insights_enabled 
      ?performance_insights_k_m_s_key_id 
      ?performance_insights_retention_period 
      ?(enabled_cloudwatch_logs_exports= [])  ?(processor_features= []) 
      ?deletion_protection  ?(associated_roles= [])  ?listener_endpoint 
      ?max_allocated_storage  () =
      {
        d_b_instance_identifier;
        d_b_instance_class;
        engine;
        d_b_instance_status;
        master_username;
        d_b_name;
        endpoint;
        allocated_storage;
        instance_create_time;
        preferred_backup_window;
        backup_retention_period;
        d_b_security_groups;
        vpc_security_groups;
        d_b_parameter_groups;
        availability_zone;
        d_b_subnet_group;
        preferred_maintenance_window;
        pending_modified_values;
        latest_restorable_time;
        multi_a_z;
        engine_version;
        auto_minor_version_upgrade;
        read_replica_source_d_b_instance_identifier;
        read_replica_d_b_instance_identifiers;
        read_replica_d_b_cluster_identifiers;
        license_model;
        iops;
        option_group_memberships;
        character_set_name;
        secondary_availability_zone;
        publicly_accessible;
        status_infos;
        storage_type;
        tde_credential_arn;
        db_instance_port;
        d_b_cluster_identifier;
        storage_encrypted;
        kms_key_id;
        dbi_resource_id;
        c_a_certificate_identifier;
        domain_memberships;
        copy_tags_to_snapshot;
        monitoring_interval;
        enhanced_monitoring_resource_arn;
        monitoring_role_arn;
        promotion_tier;
        d_b_instance_arn;
        timezone;
        i_a_m_database_authentication_enabled;
        performance_insights_enabled;
        performance_insights_k_m_s_key_id;
        performance_insights_retention_period;
        enabled_cloudwatch_logs_exports;
        processor_features;
        deletion_protection;
        associated_roles;
        listener_endpoint;
        max_allocated_storage
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_allocated_storage
              (fun f -> ("max_allocated_storage", (Integer.to_json f)));
           Util.option_map v.listener_endpoint
             (fun f -> ("listener_endpoint", (Endpoint.to_json f)));
           Some
             ("associated_roles",
               (DBInstanceRoles.to_json v.associated_roles));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Some
             ("processor_features",
               (ProcessorFeatureList.to_json v.processor_features));
           Some
             ("enabled_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enabled_cloudwatch_logs_exports));
           Util.option_map v.performance_insights_retention_period
             (fun f ->
                ("performance_insights_retention_period",
                  (Integer.to_json f)));
           Util.option_map v.performance_insights_k_m_s_key_id
             (fun f ->
                ("performance_insights_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.performance_insights_enabled
             (fun f -> ("performance_insights_enabled", (Boolean.to_json f)));
           Util.option_map v.i_a_m_database_authentication_enabled
             (fun f ->
                ("i_a_m_database_authentication_enabled",
                  (Boolean.to_json f)));
           Util.option_map v.timezone
             (fun f -> ("timezone", (String.to_json f)));
           Util.option_map v.d_b_instance_arn
             (fun f -> ("d_b_instance_arn", (String.to_json f)));
           Util.option_map v.promotion_tier
             (fun f -> ("promotion_tier", (Integer.to_json f)));
           Util.option_map v.monitoring_role_arn
             (fun f -> ("monitoring_role_arn", (String.to_json f)));
           Util.option_map v.enhanced_monitoring_resource_arn
             (fun f ->
                ("enhanced_monitoring_resource_arn", (String.to_json f)));
           Util.option_map v.monitoring_interval
             (fun f -> ("monitoring_interval", (Integer.to_json f)));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Some
             ("domain_memberships",
               (DomainMembershipList.to_json v.domain_memberships));
           Util.option_map v.c_a_certificate_identifier
             (fun f -> ("c_a_certificate_identifier", (String.to_json f)));
           Util.option_map v.dbi_resource_id
             (fun f -> ("dbi_resource_id", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)));
           Util.option_map v.db_instance_port
             (fun f -> ("db_instance_port", (Integer.to_json f)));
           Util.option_map v.tde_credential_arn
             (fun f -> ("tde_credential_arn", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Some
             ("status_infos",
               (DBInstanceStatusInfoList.to_json v.status_infos));
           Util.option_map v.publicly_accessible
             (fun f -> ("publicly_accessible", (Boolean.to_json f)));
           Util.option_map v.secondary_availability_zone
             (fun f -> ("secondary_availability_zone", (String.to_json f)));
           Util.option_map v.character_set_name
             (fun f -> ("character_set_name", (String.to_json f)));
           Some
             ("option_group_memberships",
               (OptionGroupMembershipList.to_json v.option_group_memberships));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Some
             ("read_replica_d_b_cluster_identifiers",
               (ReadReplicaDBClusterIdentifierList.to_json
                  v.read_replica_d_b_cluster_identifiers));
           Some
             ("read_replica_d_b_instance_identifiers",
               (ReadReplicaDBInstanceIdentifierList.to_json
                  v.read_replica_d_b_instance_identifiers));
           Util.option_map v.read_replica_source_d_b_instance_identifier
             (fun f ->
                ("read_replica_source_d_b_instance_identifier",
                  (String.to_json f)));
           Util.option_map v.auto_minor_version_upgrade
             (fun f -> ("auto_minor_version_upgrade", (Boolean.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.latest_restorable_time
             (fun f -> ("latest_restorable_time", (DateTime.to_json f)));
           Util.option_map v.pending_modified_values
             (fun f ->
                ("pending_modified_values",
                  (PendingModifiedValues.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.d_b_subnet_group
             (fun f -> ("d_b_subnet_group", (DBSubnetGroup.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Some
             ("d_b_parameter_groups",
               (DBParameterGroupStatusList.to_json v.d_b_parameter_groups));
           Some
             ("vpc_security_groups",
               (VpcSecurityGroupMembershipList.to_json v.vpc_security_groups));
           Some
             ("d_b_security_groups",
               (DBSecurityGroupMembershipList.to_json v.d_b_security_groups));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Util.option_map v.instance_create_time
             (fun f -> ("instance_create_time", (DateTime.to_json f)));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (Endpoint.to_json f)));
           Util.option_map v.d_b_name
             (fun f -> ("d_b_name", (String.to_json f)));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
           Util.option_map v.d_b_instance_status
             (fun f -> ("d_b_instance_status", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
               String.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          d_b_instance_status =
            (Util.option_bind (Xml.member "DBInstanceStatus" xml)
               String.parse);
          master_username =
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          d_b_name =
            (Util.option_bind (Xml.member "DBName" xml) String.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) Endpoint.parse);
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          instance_create_time =
            (Util.option_bind (Xml.member "InstanceCreateTime" xml)
               DateTime.parse);
          preferred_backup_window =
            (Util.option_bind (Xml.member "PreferredBackupWindow" xml)
               String.parse);
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          d_b_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSecurityGroups" xml)
                  DBSecurityGroupMembershipList.parse));
          vpc_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroups" xml)
                  VpcSecurityGroupMembershipList.parse));
          d_b_parameter_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBParameterGroups" xml)
                  DBParameterGroupStatusList.parse));
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          d_b_subnet_group =
            (Util.option_bind (Xml.member "DBSubnetGroup" xml)
               DBSubnetGroup.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          pending_modified_values =
            (Util.option_bind (Xml.member "PendingModifiedValues" xml)
               PendingModifiedValues.parse);
          latest_restorable_time =
            (Util.option_bind (Xml.member "LatestRestorableTime" xml)
               DateTime.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          auto_minor_version_upgrade =
            (Util.option_bind (Xml.member "AutoMinorVersionUpgrade" xml)
               Boolean.parse);
          read_replica_source_d_b_instance_identifier =
            (Util.option_bind
               (Xml.member "ReadReplicaSourceDBInstanceIdentifier" xml)
               String.parse);
          read_replica_d_b_instance_identifiers =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ReadReplicaDBInstanceIdentifiers" xml)
                  ReadReplicaDBInstanceIdentifierList.parse));
          read_replica_d_b_cluster_identifiers =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ReadReplicaDBClusterIdentifiers" xml)
                  ReadReplicaDBClusterIdentifierList.parse));
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_memberships =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionGroupMemberships" xml)
                  OptionGroupMembershipList.parse));
          character_set_name =
            (Util.option_bind (Xml.member "CharacterSetName" xml)
               String.parse);
          secondary_availability_zone =
            (Util.option_bind (Xml.member "SecondaryAvailabilityZone" xml)
               String.parse);
          publicly_accessible =
            (Util.option_bind (Xml.member "PubliclyAccessible" xml)
               Boolean.parse);
          status_infos =
            (Util.of_option []
               (Util.option_bind (Xml.member "StatusInfos" xml)
                  DBInstanceStatusInfoList.parse));
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          tde_credential_arn =
            (Util.option_bind (Xml.member "TdeCredentialArn" xml)
               String.parse);
          db_instance_port =
            (Util.option_bind (Xml.member "DbInstancePort" xml) Integer.parse);
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          dbi_resource_id =
            (Util.option_bind (Xml.member "DbiResourceId" xml) String.parse);
          c_a_certificate_identifier =
            (Util.option_bind (Xml.member "CACertificateIdentifier" xml)
               String.parse);
          domain_memberships =
            (Util.of_option []
               (Util.option_bind (Xml.member "DomainMemberships" xml)
                  DomainMembershipList.parse));
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          monitoring_interval =
            (Util.option_bind (Xml.member "MonitoringInterval" xml)
               Integer.parse);
          enhanced_monitoring_resource_arn =
            (Util.option_bind
               (Xml.member "EnhancedMonitoringResourceArn" xml) String.parse);
          monitoring_role_arn =
            (Util.option_bind (Xml.member "MonitoringRoleArn" xml)
               String.parse);
          promotion_tier =
            (Util.option_bind (Xml.member "PromotionTier" xml) Integer.parse);
          d_b_instance_arn =
            (Util.option_bind (Xml.member "DBInstanceArn" xml) String.parse);
          timezone =
            (Util.option_bind (Xml.member "Timezone" xml) String.parse);
          i_a_m_database_authentication_enabled =
            (Util.option_bind
               (Xml.member "IAMDatabaseAuthenticationEnabled" xml)
               Boolean.parse);
          performance_insights_enabled =
            (Util.option_bind (Xml.member "PerformanceInsightsEnabled" xml)
               Boolean.parse);
          performance_insights_k_m_s_key_id =
            (Util.option_bind (Xml.member "PerformanceInsightsKMSKeyId" xml)
               String.parse);
          performance_insights_retention_period =
            (Util.option_bind
               (Xml.member "PerformanceInsightsRetentionPeriod" xml)
               Integer.parse);
          enabled_cloudwatch_logs_exports =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "EnabledCloudwatchLogsExports" xml)
                  LogTypeList.parse));
          processor_features =
            (Util.of_option []
               (Util.option_bind (Xml.member "ProcessorFeatures" xml)
                  ProcessorFeatureList.parse));
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          associated_roles =
            (Util.of_option []
               (Util.option_bind (Xml.member "AssociatedRoles" xml)
                  DBInstanceRoles.parse));
          listener_endpoint =
            (Util.option_bind (Xml.member "ListenerEndpoint" xml)
               Endpoint.parse);
          max_allocated_storage =
            (Util.option_bind (Xml.member "MaxAllocatedStorage" xml)
               Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((((((((((((((((((((((((((((((([] @
                                                                    [
                                                                    Util.option_map
                                                                    v.d_b_instance_identifier
                                                                    (fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "DBInstanceIdentifier"
                                                                    ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                                   @
                                                                   [Util.option_map
                                                                    v.d_b_instance_class
                                                                    (fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "DBInstanceClass"
                                                                    ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                                  @
                                                                  [Util.option_map
                                                                    v.engine
                                                                    (fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "Engine"
                                                                    ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                                 @
                                                                 [Util.option_map
                                                                    v.d_b_instance_status
                                                                    (
                                                                    fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "DBInstanceStatus"
                                                                    ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                                @
                                                                [Util.option_map
                                                                   v.master_username
                                                                   (fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "MasterUsername"
                                                                    ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                               @
                                                               [Util.option_map
                                                                  v.d_b_name
                                                                  (fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "DBName"
                                                                    ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                              @
                                                              [Util.option_map
                                                                 v.endpoint
                                                                 (fun f ->
                                                                    Ezxmlm.make_tag
                                                                    "Endpoint"
                                                                    ([],
                                                                    (Endpoint.to_xml
                                                                    f)))])
                                                             @
                                                             [Util.option_map
                                                                v.allocated_storage
                                                                (fun f ->
                                                                   Ezxmlm.make_tag
                                                                    "AllocatedStorage"
                                                                    ([],
                                                                    (Integer.to_xml
                                                                    f)))])
                                                            @
                                                            [Util.option_map
                                                               v.instance_create_time
                                                               (fun f ->
                                                                  Ezxmlm.make_tag
                                                                    "InstanceCreateTime"
                                                                    ([],
                                                                    (DateTime.to_xml
                                                                    f)))])
                                                           @
                                                           [Util.option_map
                                                              v.preferred_backup_window
                                                              (fun f ->
                                                                 Ezxmlm.make_tag
                                                                   "PreferredBackupWindow"
                                                                   ([],
                                                                    (String.to_xml
                                                                    f)))])
                                                          @
                                                          [Util.option_map
                                                             v.backup_retention_period
                                                             (fun f ->
                                                                Ezxmlm.make_tag
                                                                  "BackupRetentionPeriod"
                                                                  ([],
                                                                    (
                                                                    Integer.to_xml
                                                                    f)))])
                                                         @
                                                         (List.map
                                                            (fun x ->
                                                               Some
                                                                 (Ezxmlm.make_tag
                                                                    "DBSecurityGroups"
                                                                    ([],
                                                                    (DBSecurityGroupMembershipList.to_xml
                                                                    [x]))))
                                                            v.d_b_security_groups))
                                                        @
                                                        (List.map
                                                           (fun x ->
                                                              Some
                                                                (Ezxmlm.make_tag
                                                                   "VpcSecurityGroups"
                                                                   ([],
                                                                    (VpcSecurityGroupMembershipList.to_xml
                                                                    [x]))))
                                                           v.vpc_security_groups))
                                                       @
                                                       (List.map
                                                          (fun x ->
                                                             Some
                                                               (Ezxmlm.make_tag
                                                                  "DBParameterGroups"
                                                                  ([],
                                                                    (
                                                                    DBParameterGroupStatusList.to_xml
                                                                    [x]))))
                                                          v.d_b_parameter_groups))
                                                      @
                                                      [Util.option_map
                                                         v.availability_zone
                                                         (fun f ->
                                                            Ezxmlm.make_tag
                                                              "AvailabilityZone"
                                                              ([],
                                                                (String.to_xml
                                                                   f)))])
                                                     @
                                                     [Util.option_map
                                                        v.d_b_subnet_group
                                                        (fun f ->
                                                           Ezxmlm.make_tag
                                                             "DBSubnetGroup"
                                                             ([],
                                                               (DBSubnetGroup.to_xml
                                                                  f)))])
                                                    @
                                                    [Util.option_map
                                                       v.preferred_maintenance_window
                                                       (fun f ->
                                                          Ezxmlm.make_tag
                                                            "PreferredMaintenanceWindow"
                                                            ([],
                                                              (String.to_xml
                                                                 f)))])
                                                   @
                                                   [Util.option_map
                                                      v.pending_modified_values
                                                      (fun f ->
                                                         Ezxmlm.make_tag
                                                           "PendingModifiedValues"
                                                           ([],
                                                             (PendingModifiedValues.to_xml
                                                                f)))])
                                                  @
                                                  [Util.option_map
                                                     v.latest_restorable_time
                                                     (fun f ->
                                                        Ezxmlm.make_tag
                                                          "LatestRestorableTime"
                                                          ([],
                                                            (DateTime.to_xml
                                                               f)))])
                                                 @
                                                 [Util.option_map v.multi_a_z
                                                    (fun f ->
                                                       Ezxmlm.make_tag
                                                         "MultiAZ"
                                                         ([],
                                                           (Boolean.to_xml f)))])
                                                @
                                                [Util.option_map
                                                   v.engine_version
                                                   (fun f ->
                                                      Ezxmlm.make_tag
                                                        "EngineVersion"
                                                        ([],
                                                          (String.to_xml f)))])
                                               @
                                               [Util.option_map
                                                  v.auto_minor_version_upgrade
                                                  (fun f ->
                                                     Ezxmlm.make_tag
                                                       "AutoMinorVersionUpgrade"
                                                       ([],
                                                         (Boolean.to_xml f)))])
                                              @
                                              [Util.option_map
                                                 v.read_replica_source_d_b_instance_identifier
                                                 (fun f ->
                                                    Ezxmlm.make_tag
                                                      "ReadReplicaSourceDBInstanceIdentifier"
                                                      ([], (String.to_xml f)))])
                                             @
                                             (List.map
                                                (fun x ->
                                                   Some
                                                     (Ezxmlm.make_tag
                                                        "ReadReplicaDBInstanceIdentifiers"
                                                        ([],
                                                          (ReadReplicaDBInstanceIdentifierList.to_xml
                                                             [x]))))
                                                v.read_replica_d_b_instance_identifiers))
                                            @
                                            (List.map
                                               (fun x ->
                                                  Some
                                                    (Ezxmlm.make_tag
                                                       "ReadReplicaDBClusterIdentifiers"
                                                       ([],
                                                         (ReadReplicaDBClusterIdentifierList.to_xml
                                                            [x]))))
                                               v.read_replica_d_b_cluster_identifiers))
                                           @
                                           [Util.option_map v.license_model
                                              (fun f ->
                                                 Ezxmlm.make_tag
                                                   "LicenseModel"
                                                   ([], (String.to_xml f)))])
                                          @
                                          [Util.option_map v.iops
                                             (fun f ->
                                                Ezxmlm.make_tag "Iops"
                                                  ([], (Integer.to_xml f)))])
                                         @
                                         (List.map
                                            (fun x ->
                                               Some
                                                 (Ezxmlm.make_tag
                                                    "OptionGroupMemberships"
                                                    ([],
                                                      (OptionGroupMembershipList.to_xml
                                                         [x]))))
                                            v.option_group_memberships))
                                        @
                                        [Util.option_map v.character_set_name
                                           (fun f ->
                                              Ezxmlm.make_tag
                                                "CharacterSetName"
                                                ([], (String.to_xml f)))])
                                       @
                                       [Util.option_map
                                          v.secondary_availability_zone
                                          (fun f ->
                                             Ezxmlm.make_tag
                                               "SecondaryAvailabilityZone"
                                               ([], (String.to_xml f)))])
                                      @
                                      [Util.option_map v.publicly_accessible
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "PubliclyAccessible"
                                              ([], (Boolean.to_xml f)))])
                                     @
                                     (List.map
                                        (fun x ->
                                           Some
                                             (Ezxmlm.make_tag "StatusInfos"
                                                ([],
                                                  (DBInstanceStatusInfoList.to_xml
                                                     [x])))) v.status_infos))
                                    @
                                    [Util.option_map v.storage_type
                                       (fun f ->
                                          Ezxmlm.make_tag "StorageType"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Util.option_map v.tde_credential_arn
                                      (fun f ->
                                         Ezxmlm.make_tag "TdeCredentialArn"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.db_instance_port
                                     (fun f ->
                                        Ezxmlm.make_tag "DbInstancePort"
                                          ([], (Integer.to_xml f)))])
                                 @
                                 [Util.option_map v.d_b_cluster_identifier
                                    (fun f ->
                                       Ezxmlm.make_tag "DBClusterIdentifier"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.storage_encrypted
                                   (fun f ->
                                      Ezxmlm.make_tag "StorageEncrypted"
                                        ([], (Boolean.to_xml f)))])
                               @
                               [Util.option_map v.kms_key_id
                                  (fun f ->
                                     Ezxmlm.make_tag "KmsKeyId"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.dbi_resource_id
                                 (fun f ->
                                    Ezxmlm.make_tag "DbiResourceId"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.c_a_certificate_identifier
                                (fun f ->
                                   Ezxmlm.make_tag "CACertificateIdentifier"
                                     ([], (String.to_xml f)))])
                            @
                            (List.map
                               (fun x ->
                                  Some
                                    (Ezxmlm.make_tag "DomainMemberships"
                                       ([],
                                         (DomainMembershipList.to_xml [x]))))
                               v.domain_memberships))
                           @
                           [Util.option_map v.copy_tags_to_snapshot
                              (fun f ->
                                 Ezxmlm.make_tag "CopyTagsToSnapshot"
                                   ([], (Boolean.to_xml f)))])
                          @
                          [Util.option_map v.monitoring_interval
                             (fun f ->
                                Ezxmlm.make_tag "MonitoringInterval"
                                  ([], (Integer.to_xml f)))])
                         @
                         [Util.option_map v.enhanced_monitoring_resource_arn
                            (fun f ->
                               Ezxmlm.make_tag
                                 "EnhancedMonitoringResourceArn"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.monitoring_role_arn
                           (fun f ->
                              Ezxmlm.make_tag "MonitoringRoleArn"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.promotion_tier
                          (fun f ->
                             Ezxmlm.make_tag "PromotionTier"
                               ([], (Integer.to_xml f)))])
                      @
                      [Util.option_map v.d_b_instance_arn
                         (fun f ->
                            Ezxmlm.make_tag "DBInstanceArn"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.timezone
                        (fun f ->
                           Ezxmlm.make_tag "Timezone" ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.i_a_m_database_authentication_enabled
                       (fun f ->
                          Ezxmlm.make_tag "IAMDatabaseAuthenticationEnabled"
                            ([], (Boolean.to_xml f)))])
                   @
                   [Util.option_map v.performance_insights_enabled
                      (fun f ->
                         Ezxmlm.make_tag "PerformanceInsightsEnabled"
                           ([], (Boolean.to_xml f)))])
                  @
                  [Util.option_map v.performance_insights_k_m_s_key_id
                     (fun f ->
                        Ezxmlm.make_tag "PerformanceInsightsKMSKeyId"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.performance_insights_retention_period
                    (fun f ->
                       Ezxmlm.make_tag "PerformanceInsightsRetentionPeriod"
                         ([], (Integer.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "EnabledCloudwatchLogsExports"
                           ([], (LogTypeList.to_xml [x]))))
                   v.enabled_cloudwatch_logs_exports))
               @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "ProcessorFeatures"
                          ([], (ProcessorFeatureList.to_xml [x]))))
                  v.processor_features))
              @
              [Util.option_map v.deletion_protection
                 (fun f ->
                    Ezxmlm.make_tag "DeletionProtection"
                      ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AssociatedRoles"
                        ([], (DBInstanceRoles.to_xml [x]))))
                v.associated_roles))
            @
            [Util.option_map v.listener_endpoint
               (fun f ->
                  Ezxmlm.make_tag "ListenerEndpoint"
                    ([], (Endpoint.to_xml f)))])
           @
           [Util.option_map v.max_allocated_storage
              (fun f ->
                 Ezxmlm.make_tag "MaxAllocatedStorage"
                   ([], (Integer.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details of an Amazon RDS DB instance. </p> <p>This data type is used as a response element in the <code>DescribeDBInstances</code> action. </p>"]
module InstallationMedia =
  struct
    type t =
      {
      installation_media_id: String.t option
        [@ocaml.doc "<p>The installation medium ID.</p>"];
      custom_availability_zone_id: String.t option
        [@ocaml.doc
          "<p>The custom Availability Zone (AZ) that contains the installation media.</p>"];
      engine: String.t option [@ocaml.doc "<p>The DB engine.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>The engine version of the DB engine.</p>"];
      engine_installation_media_path: String.t option
        [@ocaml.doc
          "<p>The path to the installation medium for the DB engine.</p>"];
      o_s_installation_media_path: String.t option
        [@ocaml.doc
          "<p>The path to the installation medium for the operating system associated with the DB engine.</p>"];
      status: String.t option
        [@ocaml.doc "<p>The status of the installation medium.</p>"];
      failure_cause: InstallationMediaFailureCause.t option
        [@ocaml.doc
          "<p>If an installation media failure occurred, the cause of the failure.</p>"]}
    [@@ocaml.doc
      "<p>Contains the installation media for a DB engine that requires an on-premises customer provided license, such as Microsoft SQL Server.</p>"]
    let make ?installation_media_id  ?custom_availability_zone_id  ?engine 
      ?engine_version  ?engine_installation_media_path 
      ?o_s_installation_media_path  ?status  ?failure_cause  () =
      {
        installation_media_id;
        custom_availability_zone_id;
        engine;
        engine_version;
        engine_installation_media_path;
        o_s_installation_media_path;
        status;
        failure_cause
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.failure_cause
              (fun f ->
                 ("failure_cause", (InstallationMediaFailureCause.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.o_s_installation_media_path
             (fun f -> ("o_s_installation_media_path", (String.to_json f)));
           Util.option_map v.engine_installation_media_path
             (fun f -> ("engine_installation_media_path", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.custom_availability_zone_id
             (fun f -> ("custom_availability_zone_id", (String.to_json f)));
           Util.option_map v.installation_media_id
             (fun f -> ("installation_media_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          installation_media_id =
            (Util.option_bind (Xml.member "InstallationMediaId" xml)
               String.parse);
          custom_availability_zone_id =
            (Util.option_bind (Xml.member "CustomAvailabilityZoneId" xml)
               String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          engine_installation_media_path =
            (Util.option_bind (Xml.member "EngineInstallationMediaPath" xml)
               String.parse);
          o_s_installation_media_path =
            (Util.option_bind (Xml.member "OSInstallationMediaPath" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          failure_cause =
            (Util.option_bind (Xml.member "FailureCause" xml)
               InstallationMediaFailureCause.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.installation_media_id
                     (fun f ->
                        Ezxmlm.make_tag "InstallationMediaId"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.custom_availability_zone_id
                    (fun f ->
                       Ezxmlm.make_tag "CustomAvailabilityZoneId"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.engine
                   (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
               @
               [Util.option_map v.engine_version
                  (fun f ->
                     Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
              @
              [Util.option_map v.engine_installation_media_path
                 (fun f ->
                    Ezxmlm.make_tag "EngineInstallationMediaPath"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.o_s_installation_media_path
                (fun f ->
                   Ezxmlm.make_tag "OSInstallationMediaPath"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.status
               (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
           @
           [Util.option_map v.failure_cause
              (fun f ->
                 Ezxmlm.make_tag "FailureCause"
                   ([], (InstallationMediaFailureCause.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the installation media for a DB engine that requires an on-premises customer provided license, such as Microsoft SQL Server.</p>"]
module AccountQuota =
  struct
    type t =
      {
      account_quota_name: String.t option
        [@ocaml.doc
          "<p>The name of the Amazon RDS quota for this AWS account.</p>"];
      used: Long.t option
        [@ocaml.doc
          "<p>The amount currently used toward the quota maximum.</p>"];
      max: Long.t option
        [@ocaml.doc "<p>The maximum allowed value for the quota.</p>"]}
    [@@ocaml.doc
      "<p>Describes a quota for an AWS account.</p> <p>The following are account quotas:</p> <ul> <li> <p> <code>AllocatedStorage</code> - The total allocated storage per account, in GiB. The used value is the total allocated storage in the account, in GiB.</p> </li> <li> <p> <code>AuthorizationsPerDBSecurityGroup</code> - The number of ingress rules per DB security group. The used value is the highest number of ingress rules in a DB security group in the account. Other DB security groups in the account might have a lower number of ingress rules.</p> </li> <li> <p> <code>CustomEndpointsPerDBCluster</code> - The number of custom endpoints per DB cluster. The used value is the highest number of custom endpoints in a DB clusters in the account. Other DB clusters in the account might have a lower number of custom endpoints.</p> </li> <li> <p> <code>DBClusterParameterGroups</code> - The number of DB cluster parameter groups per account, excluding default parameter groups. The used value is the count of nondefault DB cluster parameter groups in the account.</p> </li> <li> <p> <code>DBClusterRoles</code> - The number of associated AWS Identity and Access Management (IAM) roles per DB cluster. The used value is the highest number of associated IAM roles for a DB cluster in the account. Other DB clusters in the account might have a lower number of associated IAM roles.</p> </li> <li> <p> <code>DBClusters</code> - The number of DB clusters per account. The used value is the count of DB clusters in the account.</p> </li> <li> <p> <code>DBInstanceRoles</code> - The number of associated IAM roles per DB instance. The used value is the highest number of associated IAM roles for a DB instance in the account. Other DB instances in the account might have a lower number of associated IAM roles.</p> </li> <li> <p> <code>DBInstances</code> - The number of DB instances per account. The used value is the count of the DB instances in the account.</p> </li> <li> <p> <code>DBParameterGroups</code> - The number of DB parameter groups per account, excluding default parameter groups. The used value is the count of nondefault DB parameter groups in the account.</p> </li> <li> <p> <code>DBSecurityGroups</code> - The number of DB security groups (not VPC security groups) per account, excluding the default security group. The used value is the count of nondefault DB security groups in the account.</p> </li> <li> <p> <code>DBSubnetGroups</code> - The number of DB subnet groups per account. The used value is the count of the DB subnet groups in the account.</p> </li> <li> <p> <code>EventSubscriptions</code> - The number of event subscriptions per account. The used value is the count of the event subscriptions in the account.</p> </li> <li> <p> <code>ManualSnapshots</code> - The number of manual DB snapshots per account. The used value is the count of the manual DB snapshots in the account.</p> </li> <li> <p> <code>OptionGroups</code> - The number of DB option groups per account, excluding default option groups. The used value is the count of nondefault DB option groups in the account.</p> </li> <li> <p> <code>ReadReplicasPerMaster</code> - The number of Read Replicas per DB instance. The used value is the highest number of Read Replicas for a DB instance in the account. Other DB instances in the account might have a lower number of Read Replicas.</p> </li> <li> <p> <code>ReservedDBInstances</code> - The number of reserved DB instances per account. The used value is the count of the active reserved DB instances in the account.</p> </li> <li> <p> <code>SubnetsPerDBSubnetGroup</code> - The number of subnets per DB subnet group. The used value is highest number of subnets for a DB subnet group in the account. Other DB subnet groups in the account might have a lower number of subnets.</p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html\">Limits</a> in the <i>Amazon RDS User Guide</i> and <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_Limits.html\">Limits</a> in the <i>Amazon Aurora User Guide</i>.</p>"]
    let make ?account_quota_name  ?used  ?max  () =
      { account_quota_name; used; max }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max (fun f -> ("max", (Long.to_json f)));
           Util.option_map v.used (fun f -> ("used", (Long.to_json f)));
           Util.option_map v.account_quota_name
             (fun f -> ("account_quota_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          account_quota_name =
            (Util.option_bind (Xml.member "AccountQuotaName" xml)
               String.parse);
          used = (Util.option_bind (Xml.member "Used" xml) Long.parse);
          max = (Util.option_bind (Xml.member "Max" xml) Long.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.account_quota_name
                (fun f ->
                   Ezxmlm.make_tag "AccountQuotaName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.used
               (fun f -> Ezxmlm.make_tag "Used" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.max
              (fun f -> Ezxmlm.make_tag "Max" ([], (Long.to_xml f)))])
  end[@@ocaml.doc
       "<p>Describes a quota for an AWS account.</p> <p>The following are account quotas:</p> <ul> <li> <p> <code>AllocatedStorage</code> - The total allocated storage per account, in GiB. The used value is the total allocated storage in the account, in GiB.</p> </li> <li> <p> <code>AuthorizationsPerDBSecurityGroup</code> - The number of ingress rules per DB security group. The used value is the highest number of ingress rules in a DB security group in the account. Other DB security groups in the account might have a lower number of ingress rules.</p> </li> <li> <p> <code>CustomEndpointsPerDBCluster</code> - The number of custom endpoints per DB cluster. The used value is the highest number of custom endpoints in a DB clusters in the account. Other DB clusters in the account might have a lower number of custom endpoints.</p> </li> <li> <p> <code>DBClusterParameterGroups</code> - The number of DB cluster parameter groups per account, excluding default parameter groups. The used value is the count of nondefault DB cluster parameter groups in the account.</p> </li> <li> <p> <code>DBClusterRoles</code> - The number of associated AWS Identity and Access Management (IAM) roles per DB cluster. The used value is the highest number of associated IAM roles for a DB cluster in the account. Other DB clusters in the account might have a lower number of associated IAM roles.</p> </li> <li> <p> <code>DBClusters</code> - The number of DB clusters per account. The used value is the count of DB clusters in the account.</p> </li> <li> <p> <code>DBInstanceRoles</code> - The number of associated IAM roles per DB instance. The used value is the highest number of associated IAM roles for a DB instance in the account. Other DB instances in the account might have a lower number of associated IAM roles.</p> </li> <li> <p> <code>DBInstances</code> - The number of DB instances per account. The used value is the count of the DB instances in the account.</p> </li> <li> <p> <code>DBParameterGroups</code> - The number of DB parameter groups per account, excluding default parameter groups. The used value is the count of nondefault DB parameter groups in the account.</p> </li> <li> <p> <code>DBSecurityGroups</code> - The number of DB security groups (not VPC security groups) per account, excluding the default security group. The used value is the count of nondefault DB security groups in the account.</p> </li> <li> <p> <code>DBSubnetGroups</code> - The number of DB subnet groups per account. The used value is the count of the DB subnet groups in the account.</p> </li> <li> <p> <code>EventSubscriptions</code> - The number of event subscriptions per account. The used value is the count of the event subscriptions in the account.</p> </li> <li> <p> <code>ManualSnapshots</code> - The number of manual DB snapshots per account. The used value is the count of the manual DB snapshots in the account.</p> </li> <li> <p> <code>OptionGroups</code> - The number of DB option groups per account, excluding default option groups. The used value is the count of nondefault DB option groups in the account.</p> </li> <li> <p> <code>ReadReplicasPerMaster</code> - The number of Read Replicas per DB instance. The used value is the highest number of Read Replicas for a DB instance in the account. Other DB instances in the account might have a lower number of Read Replicas.</p> </li> <li> <p> <code>ReservedDBInstances</code> - The number of reserved DB instances per account. The used value is the count of the active reserved DB instances in the account.</p> </li> <li> <p> <code>SubnetsPerDBSubnetGroup</code> - The number of subnets per DB subnet group. The used value is highest number of subnets for a DB subnet group in the account. Other DB subnet groups in the account might have a lower number of subnets.</p> </li> </ul> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Limits.html\">Limits</a> in the <i>Amazon RDS User Guide</i> and <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_Limits.html\">Limits</a> in the <i>Amazon Aurora User Guide</i>.</p>"]
module GlobalCluster =
  struct
    type t =
      {
      global_cluster_identifier: String.t option
        [@ocaml.doc
          "<p> Contains a user-supplied global database cluster identifier. This identifier is the unique key that identifies a global database cluster. </p>"];
      global_cluster_resource_id: String.t option
        [@ocaml.doc
          "<p> The AWS Region-unique, immutable identifier for the global database cluster. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB cluster is accessed. </p>"];
      global_cluster_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the global database cluster.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Specifies the current state of this global database cluster.</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p> The Aurora database engine used by the global database cluster. </p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>Indicates the database engine version.</p>"];
      database_name: String.t option
        [@ocaml.doc
          "<p> The default database name within the new global database cluster. </p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p> The storage encryption setting for the global database cluster. </p>"];
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p> The deletion protection setting for the new global database cluster. </p>"];
      global_cluster_members: GlobalClusterMemberList.t
        [@ocaml.doc
          "<p> The list of cluster IDs for secondary clusters within the global database cluster. Currently limited to 1 item. </p>"]}
    [@@ocaml.doc
      "<p>A data type representing an Aurora global database.</p>"]
    let make ?global_cluster_identifier  ?global_cluster_resource_id 
      ?global_cluster_arn  ?status  ?engine  ?engine_version  ?database_name 
      ?storage_encrypted  ?deletion_protection  ?(global_cluster_members= [])
       () =
      {
        global_cluster_identifier;
        global_cluster_resource_id;
        global_cluster_arn;
        status;
        engine;
        engine_version;
        database_name;
        storage_encrypted;
        deletion_protection;
        global_cluster_members
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("global_cluster_members",
                (GlobalClusterMemberList.to_json v.global_cluster_members));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.database_name
             (fun f -> ("database_name", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.global_cluster_arn
             (fun f -> ("global_cluster_arn", (String.to_json f)));
           Util.option_map v.global_cluster_resource_id
             (fun f -> ("global_cluster_resource_id", (String.to_json f)));
           Util.option_map v.global_cluster_identifier
             (fun f -> ("global_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster_identifier =
            (Util.option_bind (Xml.member "GlobalClusterIdentifier" xml)
               String.parse);
          global_cluster_resource_id =
            (Util.option_bind (Xml.member "GlobalClusterResourceId" xml)
               String.parse);
          global_cluster_arn =
            (Util.option_bind (Xml.member "GlobalClusterArn" xml)
               String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          database_name =
            (Util.option_bind (Xml.member "DatabaseName" xml) String.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          global_cluster_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "GlobalClusterMembers" xml)
                  GlobalClusterMemberList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.global_cluster_identifier
                       (fun f ->
                          Ezxmlm.make_tag "GlobalClusterIdentifier"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.global_cluster_resource_id
                      (fun f ->
                         Ezxmlm.make_tag "GlobalClusterResourceId"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.global_cluster_arn
                     (fun f ->
                        Ezxmlm.make_tag "GlobalClusterArn"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.status
                    (fun f ->
                       Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
                @
                [Util.option_map v.engine
                   (fun f -> Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
               @
               [Util.option_map v.engine_version
                  (fun f ->
                     Ezxmlm.make_tag "EngineVersion" ([], (String.to_xml f)))])
              @
              [Util.option_map v.database_name
                 (fun f ->
                    Ezxmlm.make_tag "DatabaseName" ([], (String.to_xml f)))])
             @
             [Util.option_map v.storage_encrypted
                (fun f ->
                   Ezxmlm.make_tag "StorageEncrypted"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.deletion_protection
               (fun f ->
                  Ezxmlm.make_tag "DeletionProtection"
                    ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "GlobalClusterMembers"
                      ([], (GlobalClusterMemberList.to_xml [x]))))
              v.global_cluster_members))
  end[@@ocaml.doc
       "<p>A data type representing an Aurora global database.</p>"]
module DBInstanceAutomatedBackup =
  struct
    type t =
      {
      d_b_instance_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the automated backup.</p>"];
      dbi_resource_id: String.t option
        [@ocaml.doc
          "<p>The identifier for the source DB instance, which can't be changed and which is unique to an AWS Region.</p>"];
      region: String.t option
        [@ocaml.doc
          "<p>The AWS Region associated with the automated backup.</p>"];
      d_b_instance_identifier: String.t option
        [@ocaml.doc
          "<p>The customer id of the instance that is/was associated with the automated backup. </p>"];
      restore_window: RestoreWindow.t option
        [@ocaml.doc
          "<p>Earliest and latest time an instance can be restored to.</p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>Specifies the allocated storage size in gibibytes (GiB).</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Provides a list of status information for an automated backup:</p> <ul> <li> <p> <code>active</code> - automated backups for current instances</p> </li> <li> <p> <code>retained</code> - automated backups for deleted instances</p> </li> <li> <p> <code>creating</code> - automated backups that are waiting for the first automated snapshot to be available.</p> </li> </ul>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>The port number that the automated backup used for connections.</p> <p>Default: Inherits from the source DB instance</p> <p>Valid Values: <code>1150-65535</code> </p>"];
      availability_zone: String.t option
        [@ocaml.doc
          "<p>The Availability Zone that the automated backup was created in. For information on AWS Regions and Availability Zones, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html\">Regions and Availability Zones</a>.</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>Provides the VPC ID associated with the DB instance</p>"];
      instance_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Provides the date and time that the DB instance was created. </p>"];
      master_username: String.t option
        [@ocaml.doc "<p>The license model of an automated backup.</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>The name of the database engine for this automated backup.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>The version of the database engine for the automated backup.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>License model information for the automated backup.</p>"];
      iops: Integer.t option
        [@ocaml.doc
          "<p>The IOPS (I/O operations per second) value for the automated backup. </p>"];
      option_group_name: String.t option
        [@ocaml.doc
          "<p>The option group the automated backup is associated with. If omitted, the default option group for the engine specified is used.</p>"];
      tde_credential_arn: String.t option
        [@ocaml.doc
          "<p>The ARN from the key store with which the automated backup is associated for TDE encryption.</p>"];
      encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the automated backup is encrypted.</p>"];
      storage_type: String.t option
        [@ocaml.doc
          "<p>Specifies the storage type associated with the automated backup.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key ID for an automated backup. The KMS key ID is the Amazon Resource Name (ARN), KMS key identifier, or the KMS key alias for the KMS encryption key. </p>"];
      timezone: String.t option
        [@ocaml.doc
          "<p>The time zone of the automated backup. In most cases, the <code>Timezone</code> element is empty. <code>Timezone</code> content appears only for Microsoft SQL Server DB instances that were created with a time zone specified.</p>"];
      i_a_m_database_authentication_enabled: Boolean.t option
        [@ocaml.doc
          "<p>True if mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false.</p>"]}
    [@@ocaml.doc
      "<p>An automated backup of a DB instance. It it consists of system backups, transaction logs, and the database instance properties that existed at the time you deleted the source instance. </p>"]
    let make ?d_b_instance_arn  ?dbi_resource_id  ?region 
      ?d_b_instance_identifier  ?restore_window  ?allocated_storage  ?status 
      ?port  ?availability_zone  ?vpc_id  ?instance_create_time 
      ?master_username  ?engine  ?engine_version  ?license_model  ?iops 
      ?option_group_name  ?tde_credential_arn  ?encrypted  ?storage_type 
      ?kms_key_id  ?timezone  ?i_a_m_database_authentication_enabled  () =
      {
        d_b_instance_arn;
        dbi_resource_id;
        region;
        d_b_instance_identifier;
        restore_window;
        allocated_storage;
        status;
        port;
        availability_zone;
        vpc_id;
        instance_create_time;
        master_username;
        engine;
        engine_version;
        license_model;
        iops;
        option_group_name;
        tde_credential_arn;
        encrypted;
        storage_type;
        kms_key_id;
        timezone;
        i_a_m_database_authentication_enabled
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_a_m_database_authentication_enabled
              (fun f ->
                 ("i_a_m_database_authentication_enabled",
                   (Boolean.to_json f)));
           Util.option_map v.timezone
             (fun f -> ("timezone", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Util.option_map v.encrypted
             (fun f -> ("encrypted", (Boolean.to_json f)));
           Util.option_map v.tde_credential_arn
             (fun f -> ("tde_credential_arn", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)));
           Util.option_map v.iops (fun f -> ("iops", (Integer.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
           Util.option_map v.instance_create_time
             (fun f -> ("instance_create_time", (DateTime.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.availability_zone
             (fun f -> ("availability_zone", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
           Util.option_map v.restore_window
             (fun f -> ("restore_window", (RestoreWindow.to_json f)));
           Util.option_map v.d_b_instance_identifier
             (fun f -> ("d_b_instance_identifier", (String.to_json f)));
           Util.option_map v.region (fun f -> ("region", (String.to_json f)));
           Util.option_map v.dbi_resource_id
             (fun f -> ("dbi_resource_id", (String.to_json f)));
           Util.option_map v.d_b_instance_arn
             (fun f -> ("d_b_instance_arn", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance_arn =
            (Util.option_bind (Xml.member "DBInstanceArn" xml) String.parse);
          dbi_resource_id =
            (Util.option_bind (Xml.member "DbiResourceId" xml) String.parse);
          region = (Util.option_bind (Xml.member "Region" xml) String.parse);
          d_b_instance_identifier =
            (Util.option_bind (Xml.member "DBInstanceIdentifier" xml)
               String.parse);
          restore_window =
            (Util.option_bind (Xml.member "RestoreWindow" xml)
               RestoreWindow.parse);
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          availability_zone =
            (Util.option_bind (Xml.member "AvailabilityZone" xml)
               String.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          instance_create_time =
            (Util.option_bind (Xml.member "InstanceCreateTime" xml)
               DateTime.parse);
          master_username =
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          iops = (Util.option_bind (Xml.member "Iops" xml) Integer.parse);
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          tde_credential_arn =
            (Util.option_bind (Xml.member "TdeCredentialArn" xml)
               String.parse);
          encrypted =
            (Util.option_bind (Xml.member "Encrypted" xml) Boolean.parse);
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          timezone =
            (Util.option_bind (Xml.member "Timezone" xml) String.parse);
          i_a_m_database_authentication_enabled =
            (Util.option_bind
               (Xml.member "IAMDatabaseAuthenticationEnabled" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((([] @
                                 [Util.option_map v.d_b_instance_arn
                                    (fun f ->
                                       Ezxmlm.make_tag "DBInstanceArn"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.dbi_resource_id
                                   (fun f ->
                                      Ezxmlm.make_tag "DbiResourceId"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.region
                                  (fun f ->
                                     Ezxmlm.make_tag "Region"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.d_b_instance_identifier
                                 (fun f ->
                                    Ezxmlm.make_tag "DBInstanceIdentifier"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.restore_window
                                (fun f ->
                                   Ezxmlm.make_tag "RestoreWindow"
                                     ([], (RestoreWindow.to_xml f)))])
                            @
                            [Util.option_map v.allocated_storage
                               (fun f ->
                                  Ezxmlm.make_tag "AllocatedStorage"
                                    ([], (Integer.to_xml f)))])
                           @
                           [Util.option_map v.status
                              (fun f ->
                                 Ezxmlm.make_tag "Status"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.port
                             (fun f ->
                                Ezxmlm.make_tag "Port"
                                  ([], (Integer.to_xml f)))])
                         @
                         [Util.option_map v.availability_zone
                            (fun f ->
                               Ezxmlm.make_tag "AvailabilityZone"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.vpc_id
                           (fun f ->
                              Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.instance_create_time
                          (fun f ->
                             Ezxmlm.make_tag "InstanceCreateTime"
                               ([], (DateTime.to_xml f)))])
                      @
                      [Util.option_map v.master_username
                         (fun f ->
                            Ezxmlm.make_tag "MasterUsername"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.engine
                        (fun f ->
                           Ezxmlm.make_tag "Engine" ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.engine_version
                       (fun f ->
                          Ezxmlm.make_tag "EngineVersion"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.license_model
                      (fun f ->
                         Ezxmlm.make_tag "LicenseModel"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.iops
                     (fun f ->
                        Ezxmlm.make_tag "Iops" ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.option_group_name
                    (fun f ->
                       Ezxmlm.make_tag "OptionGroupName"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.tde_credential_arn
                   (fun f ->
                      Ezxmlm.make_tag "TdeCredentialArn"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.encrypted
                  (fun f ->
                     Ezxmlm.make_tag "Encrypted" ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.storage_type
                 (fun f ->
                    Ezxmlm.make_tag "StorageType" ([], (String.to_xml f)))])
             @
             [Util.option_map v.kms_key_id
                (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.timezone
               (fun f -> Ezxmlm.make_tag "Timezone" ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_a_m_database_authentication_enabled
              (fun f ->
                 Ezxmlm.make_tag "IAMDatabaseAuthenticationEnabled"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>An automated backup of a DB instance. It it consists of system backups, transaction logs, and the database instance properties that existed at the time you deleted the source instance. </p>"]
module DBClusterParameterGroup =
  struct
    type t =
      {
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>Provides the name of the DB cluster parameter group.</p>"];
      d_b_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>Provides the name of the DB parameter group family that this DB cluster parameter group is compatible with.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>Provides the customer-specified description for this DB cluster parameter group.</p>"];
      d_b_cluster_parameter_group_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB cluster parameter group.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details of an Amazon RDS DB cluster parameter group. </p> <p>This data type is used as a response element in the <code>DescribeDBClusterParameterGroups</code> action. </p>"]
    let make ?d_b_cluster_parameter_group_name  ?d_b_parameter_group_family 
      ?description  ?d_b_cluster_parameter_group_arn  () =
      {
        d_b_cluster_parameter_group_name;
        d_b_parameter_group_family;
        description;
        d_b_cluster_parameter_group_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_parameter_group_arn
              (fun f ->
                 ("d_b_cluster_parameter_group_arn", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.d_b_parameter_group_family
             (fun f -> ("d_b_parameter_group_family", (String.to_json f)));
           Util.option_map v.d_b_cluster_parameter_group_name
             (fun f ->
                ("d_b_cluster_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_parameter_group_name =
            (Util.option_bind (Xml.member "DBClusterParameterGroupName" xml)
               String.parse);
          d_b_parameter_group_family =
            (Util.option_bind (Xml.member "DBParameterGroupFamily" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          d_b_cluster_parameter_group_arn =
            (Util.option_bind (Xml.member "DBClusterParameterGroupArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.d_b_cluster_parameter_group_name
                 (fun f ->
                    Ezxmlm.make_tag "DBClusterParameterGroupName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.d_b_parameter_group_family
                (fun f ->
                   Ezxmlm.make_tag "DBParameterGroupFamily"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           [Util.option_map v.d_b_cluster_parameter_group_arn
              (fun f ->
                 Ezxmlm.make_tag "DBClusterParameterGroupArn"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details of an Amazon RDS DB cluster parameter group. </p> <p>This data type is used as a response element in the <code>DescribeDBClusterParameterGroups</code> action. </p>"]
module DescribeDBLogFilesDetails =
  struct
    type t =
      {
      log_file_name: String.t option
        [@ocaml.doc
          "<p>The name of the log file for the specified DB instance.</p>"];
      last_written: Long.t option
        [@ocaml.doc
          "<p>A POSIX timestamp when the last log entry was written.</p>"];
      size: Long.t option
        [@ocaml.doc
          "<p>The size, in bytes, of the log file for the specified DB instance.</p>"]}
    [@@ocaml.doc
      "<p>This data type is used as a response element to <code>DescribeDBLogFiles</code>.</p>"]
    let make ?log_file_name  ?last_written  ?size  () =
      { log_file_name; last_written; size }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.size (fun f -> ("size", (Long.to_json f)));
           Util.option_map v.last_written
             (fun f -> ("last_written", (Long.to_json f)));
           Util.option_map v.log_file_name
             (fun f -> ("log_file_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          log_file_name =
            (Util.option_bind (Xml.member "LogFileName" xml) String.parse);
          last_written =
            (Util.option_bind (Xml.member "LastWritten" xml) Long.parse);
          size = (Util.option_bind (Xml.member "Size" xml) Long.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.log_file_name
                (fun f ->
                   Ezxmlm.make_tag "LogFileName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.last_written
               (fun f -> Ezxmlm.make_tag "LastWritten" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.size
              (fun f -> Ezxmlm.make_tag "Size" ([], (Long.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type is used as a response element to <code>DescribeDBLogFiles</code>.</p>"]
module UserAuthConfig =
  struct
    type t =
      {
      description: String.t option
        [@ocaml.doc
          "<p>A user-specified description about the authentication used by a proxy to log in as a specific database user.</p>"];
      user_name: String.t option
        [@ocaml.doc
          "<p>The name of the database user to which the proxy connects.</p>"];
      auth_scheme: AuthScheme.t option
        [@ocaml.doc
          "<p>The type of authentication that the proxy uses for connections from the proxy to the underlying database.</p>"];
      secret_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) representing the secret that the proxy uses to authenticate to the RDS DB instance or Aurora DB cluster. These secrets are stored within Amazon Secrets Manager.</p>"];
      i_a_m_auth: IAMAuthMode.t option
        [@ocaml.doc
          "<p>Whether to require or disallow AWS Identity and Access Management (IAM) authentication for connections to the proxy.</p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Specifies the details of authentication used by a proxy to log in as a specific database user.</p>"]
    let make ?description  ?user_name  ?auth_scheme  ?secret_arn  ?i_a_m_auth
       () = { description; user_name; auth_scheme; secret_arn; i_a_m_auth }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_a_m_auth
              (fun f -> ("i_a_m_auth", (IAMAuthMode.to_json f)));
           Util.option_map v.secret_arn
             (fun f -> ("secret_arn", (String.to_json f)));
           Util.option_map v.auth_scheme
             (fun f -> ("auth_scheme", (AuthScheme.to_json f)));
           Util.option_map v.user_name
             (fun f -> ("user_name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)))])
    let parse xml =
      Some
        {
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          user_name =
            (Util.option_bind (Xml.member "UserName" xml) String.parse);
          auth_scheme =
            (Util.option_bind (Xml.member "AuthScheme" xml) AuthScheme.parse);
          secret_arn =
            (Util.option_bind (Xml.member "SecretArn" xml) String.parse);
          i_a_m_auth =
            (Util.option_bind (Xml.member "IAMAuth" xml) IAMAuthMode.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.description
                  (fun f ->
                     Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
              @
              [Util.option_map v.user_name
                 (fun f -> Ezxmlm.make_tag "UserName" ([], (String.to_xml f)))])
             @
             [Util.option_map v.auth_scheme
                (fun f ->
                   Ezxmlm.make_tag "AuthScheme" ([], (AuthScheme.to_xml f)))])
            @
            [Util.option_map v.secret_arn
               (fun f -> Ezxmlm.make_tag "SecretArn" ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_a_m_auth
              (fun f ->
                 Ezxmlm.make_tag "IAMAuth" ([], (IAMAuthMode.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Specifies the details of authentication used by a proxy to log in as a specific database user.</p>"]
module DBParameterGroup =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t option
        [@ocaml.doc "<p>Provides the name of the DB parameter group.</p>"];
      d_b_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>Provides the name of the DB parameter group family that this DB parameter group is compatible with.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>Provides the customer-specified description for this DB parameter group.</p>"];
      d_b_parameter_group_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB parameter group.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details of an Amazon RDS DB parameter group. </p> <p>This data type is used as a response element in the <code>DescribeDBParameterGroups</code> action. </p>"]
    let make ?d_b_parameter_group_name  ?d_b_parameter_group_family 
      ?description  ?d_b_parameter_group_arn  () =
      {
        d_b_parameter_group_name;
        d_b_parameter_group_family;
        description;
        d_b_parameter_group_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_parameter_group_arn
              (fun f -> ("d_b_parameter_group_arn", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.d_b_parameter_group_family
             (fun f -> ("d_b_parameter_group_family", (String.to_json f)));
           Util.option_map v.d_b_parameter_group_name
             (fun f -> ("d_b_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_parameter_group_name =
            (Util.option_bind (Xml.member "DBParameterGroupName" xml)
               String.parse);
          d_b_parameter_group_family =
            (Util.option_bind (Xml.member "DBParameterGroupFamily" xml)
               String.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          d_b_parameter_group_arn =
            (Util.option_bind (Xml.member "DBParameterGroupArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.d_b_parameter_group_name
                 (fun f ->
                    Ezxmlm.make_tag "DBParameterGroupName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.d_b_parameter_group_family
                (fun f ->
                   Ezxmlm.make_tag "DBParameterGroupFamily"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.description
               (fun f ->
                  Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
           @
           [Util.option_map v.d_b_parameter_group_arn
              (fun f ->
                 Ezxmlm.make_tag "DBParameterGroupArn"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details of an Amazon RDS DB parameter group. </p> <p>This data type is used as a response element in the <code>DescribeDBParameterGroups</code> action. </p>"]
module Event =
  struct
    type t =
      {
      source_identifier: String.t option
        [@ocaml.doc
          "<p>Provides the identifier for the source of the event.</p>"];
      source_type: SourceType.t option
        [@ocaml.doc "<p>Specifies the source type for this event.</p>"];
      message: String.t option
        [@ocaml.doc "<p>Provides the text of this event.</p>"];
      event_categories: EventCategoriesList.t
        [@ocaml.doc "<p>Specifies the category for the event.</p>"];
      date: DateTime.t option
        [@ocaml.doc "<p>Specifies the date and time of the event.</p>"];
      source_arn: String.t option
        [@ocaml.doc "<p>The Amazon Resource Name (ARN) for the event.</p>"]}
    [@@ocaml.doc
      "<p> This data type is used as a response element in the <code>DescribeEvents</code> action. </p>"]
    let make ?source_identifier  ?source_type  ?message  ?(event_categories=
      [])  ?date  ?source_arn  () =
      {
        source_identifier;
        source_type;
        message;
        event_categories;
        date;
        source_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.source_arn
              (fun f -> ("source_arn", (String.to_json f)));
           Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)));
           Some
             ("event_categories",
               (EventCategoriesList.to_json v.event_categories));
           Util.option_map v.message
             (fun f -> ("message", (String.to_json f)));
           Util.option_map v.source_type
             (fun f -> ("source_type", (SourceType.to_json f)));
           Util.option_map v.source_identifier
             (fun f -> ("source_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          source_identifier =
            (Util.option_bind (Xml.member "SourceIdentifier" xml)
               String.parse);
          source_type =
            (Util.option_bind (Xml.member "SourceType" xml) SourceType.parse);
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse);
          event_categories =
            (Util.of_option []
               (Util.option_bind (Xml.member "EventCategories" xml)
                  EventCategoriesList.parse));
          date = (Util.option_bind (Xml.member "Date" xml) DateTime.parse);
          source_arn =
            (Util.option_bind (Xml.member "SourceArn" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.source_identifier
                   (fun f ->
                      Ezxmlm.make_tag "SourceIdentifier"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.source_type
                  (fun f ->
                     Ezxmlm.make_tag "SourceType" ([], (SourceType.to_xml f)))])
              @
              [Util.option_map v.message
                 (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "EventCategories"
                        ([], (EventCategoriesList.to_xml [x]))))
                v.event_categories))
            @
            [Util.option_map v.date
               (fun f -> Ezxmlm.make_tag "Date" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.source_arn
              (fun f -> Ezxmlm.make_tag "SourceArn" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>DescribeEvents</code> action. </p>"]
module Certificate =
  struct
    type t =
      {
      certificate_identifier: String.t option
        [@ocaml.doc "<p>The unique key that identifies a certificate.</p>"];
      certificate_type: String.t option
        [@ocaml.doc "<p>The type of the certificate.</p>"];
      thumbprint: String.t option
        [@ocaml.doc "<p>The thumbprint of the certificate.</p>"];
      valid_from: DateTime.t option
        [@ocaml.doc
          "<p>The starting date from which the certificate is valid.</p>"];
      valid_till: DateTime.t option
        [@ocaml.doc
          "<p>The final date that the certificate continues to be valid.</p>"];
      certificate_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the certificate.</p>"]}
    [@@ocaml.doc "<p>A CA certificate for an AWS account.</p>"]
    let make ?certificate_identifier  ?certificate_type  ?thumbprint 
      ?valid_from  ?valid_till  ?certificate_arn  () =
      {
        certificate_identifier;
        certificate_type;
        thumbprint;
        valid_from;
        valid_till;
        certificate_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.certificate_arn
              (fun f -> ("certificate_arn", (String.to_json f)));
           Util.option_map v.valid_till
             (fun f -> ("valid_till", (DateTime.to_json f)));
           Util.option_map v.valid_from
             (fun f -> ("valid_from", (DateTime.to_json f)));
           Util.option_map v.thumbprint
             (fun f -> ("thumbprint", (String.to_json f)));
           Util.option_map v.certificate_type
             (fun f -> ("certificate_type", (String.to_json f)));
           Util.option_map v.certificate_identifier
             (fun f -> ("certificate_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          certificate_identifier =
            (Util.option_bind (Xml.member "CertificateIdentifier" xml)
               String.parse);
          certificate_type =
            (Util.option_bind (Xml.member "CertificateType" xml) String.parse);
          thumbprint =
            (Util.option_bind (Xml.member "Thumbprint" xml) String.parse);
          valid_from =
            (Util.option_bind (Xml.member "ValidFrom" xml) DateTime.parse);
          valid_till =
            (Util.option_bind (Xml.member "ValidTill" xml) DateTime.parse);
          certificate_arn =
            (Util.option_bind (Xml.member "CertificateArn" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.certificate_identifier
                   (fun f ->
                      Ezxmlm.make_tag "CertificateIdentifier"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.certificate_type
                  (fun f ->
                     Ezxmlm.make_tag "CertificateType"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.thumbprint
                 (fun f ->
                    Ezxmlm.make_tag "Thumbprint" ([], (String.to_xml f)))])
             @
             [Util.option_map v.valid_from
                (fun f ->
                   Ezxmlm.make_tag "ValidFrom" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.valid_till
               (fun f ->
                  Ezxmlm.make_tag "ValidTill" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.certificate_arn
              (fun f ->
                 Ezxmlm.make_tag "CertificateArn" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>A CA certificate for an AWS account.</p>"]
module OptionGroup =
  struct
    type t =
      {
      option_group_name: String.t option
        [@ocaml.doc "<p>Specifies the name of the option group.</p>"];
      option_group_description: String.t option
        [@ocaml.doc "<p>Provides a description of the option group.</p>"];
      engine_name: String.t option
        [@ocaml.doc
          "<p>Indicates the name of the engine that this option group can be applied to.</p>"];
      major_engine_version: String.t option
        [@ocaml.doc
          "<p>Indicates the major engine version associated with this option group.</p>"];
      options: OptionsList.t
        [@ocaml.doc
          "<p>Indicates what options are available in the option group.</p>"];
      allows_vpc_and_non_vpc_instance_memberships: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether this option group can be applied to both VPC and non-VPC instances. The value <code>true</code> indicates the option group can be applied to both VPC and non-VPC instances. </p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>If <b>AllowsVpcAndNonVpcInstanceMemberships</b> is <code>false</code>, this field is blank. If <b>AllowsVpcAndNonVpcInstanceMemberships</b> is <code>true</code> and this field is blank, then this option group can be applied to both VPC and non-VPC instances. If this field contains a value, then this option group can only be applied to instances that are in the VPC indicated by this field. </p>"];
      option_group_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the option group.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?option_group_name  ?option_group_description  ?engine_name 
      ?major_engine_version  ?(options= []) 
      ?allows_vpc_and_non_vpc_instance_memberships  ?vpc_id 
      ?option_group_arn  () =
      {
        option_group_name;
        option_group_description;
        engine_name;
        major_engine_version;
        options;
        allows_vpc_and_non_vpc_instance_memberships;
        vpc_id;
        option_group_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.option_group_arn
              (fun f -> ("option_group_arn", (String.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.allows_vpc_and_non_vpc_instance_memberships
             (fun f ->
                ("allows_vpc_and_non_vpc_instance_memberships",
                  (Boolean.to_json f)));
           Some ("options", (OptionsList.to_json v.options));
           Util.option_map v.major_engine_version
             (fun f -> ("major_engine_version", (String.to_json f)));
           Util.option_map v.engine_name
             (fun f -> ("engine_name", (String.to_json f)));
           Util.option_map v.option_group_description
             (fun f -> ("option_group_description", (String.to_json f)));
           Util.option_map v.option_group_name
             (fun f -> ("option_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          option_group_name =
            (Util.option_bind (Xml.member "OptionGroupName" xml) String.parse);
          option_group_description =
            (Util.option_bind (Xml.member "OptionGroupDescription" xml)
               String.parse);
          engine_name =
            (Util.option_bind (Xml.member "EngineName" xml) String.parse);
          major_engine_version =
            (Util.option_bind (Xml.member "MajorEngineVersion" xml)
               String.parse);
          options =
            (Util.of_option []
               (Util.option_bind (Xml.member "Options" xml) OptionsList.parse));
          allows_vpc_and_non_vpc_instance_memberships =
            (Util.option_bind
               (Xml.member "AllowsVpcAndNonVpcInstanceMemberships" xml)
               Boolean.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          option_group_arn =
            (Util.option_bind (Xml.member "OptionGroupArn" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.option_group_name
                     (fun f ->
                        Ezxmlm.make_tag "OptionGroupName"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.option_group_description
                    (fun f ->
                       Ezxmlm.make_tag "OptionGroupDescription"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.engine_name
                   (fun f ->
                      Ezxmlm.make_tag "EngineName" ([], (String.to_xml f)))])
               @
               [Util.option_map v.major_engine_version
                  (fun f ->
                     Ezxmlm.make_tag "MajorEngineVersion"
                       ([], (String.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Options"
                         ([], (OptionsList.to_xml [x])))) v.options))
             @
             [Util.option_map v.allows_vpc_and_non_vpc_instance_memberships
                (fun f ->
                   Ezxmlm.make_tag "AllowsVpcAndNonVpcInstanceMemberships"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.vpc_id
               (fun f -> Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.option_group_arn
              (fun f ->
                 Ezxmlm.make_tag "OptionGroupArn" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module OrderableDBInstanceOption =
  struct
    type t =
      {
      engine: String.t option
        [@ocaml.doc "<p>The engine type of a DB instance.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>The engine version of a DB instance.</p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc "<p>The DB instance class for a DB instance.</p>"];
      license_model: String.t option
        [@ocaml.doc "<p>The license model for a DB instance.</p>"];
      availability_zones: AvailabilityZoneList.t
        [@ocaml.doc "<p>A list of Availability Zones for a DB instance.</p>"];
      multi_a_z_capable: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether a DB instance is Multi-AZ capable.</p>"];
      read_replica_capable: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether a DB instance can have a Read Replica.</p>"];
      vpc: Boolean.t option
        [@ocaml.doc "<p>Indicates whether a DB instance is in a VPC.</p>"];
      supports_storage_encryption: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether a DB instance supports encrypted storage.</p>"];
      storage_type: String.t option
        [@ocaml.doc "<p>Indicates the storage type for a DB instance.</p>"];
      supports_iops: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether a DB instance supports provisioned IOPS.</p>"];
      supports_enhanced_monitoring: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether a DB instance supports Enhanced Monitoring at intervals from 1 to 60 seconds.</p>"];
      supports_i_a_m_database_authentication: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether a DB instance supports IAM database authentication.</p>"];
      supports_performance_insights: Boolean.t option
        [@ocaml.doc
          "<p>True if a DB instance supports Performance Insights, otherwise false.</p>"];
      min_storage_size: Integer.t option
        [@ocaml.doc "<p>Minimum storage size for a DB instance.</p>"];
      max_storage_size: Integer.t option
        [@ocaml.doc "<p>Maximum storage size for a DB instance.</p>"];
      min_iops_per_db_instance: Integer.t option
        [@ocaml.doc
          "<p>Minimum total provisioned IOPS for a DB instance.</p>"];
      max_iops_per_db_instance: Integer.t option
        [@ocaml.doc
          "<p>Maximum total provisioned IOPS for a DB instance.</p>"];
      min_iops_per_gib: Double.t option
        [@ocaml.doc
          "<p>Minimum provisioned IOPS per GiB for a DB instance.</p>"];
      max_iops_per_gib: Double.t option
        [@ocaml.doc
          "<p>Maximum provisioned IOPS per GiB for a DB instance.</p>"];
      available_processor_features: AvailableProcessorFeatureList.t
        [@ocaml.doc
          "<p>A list of the available processor features for the DB instance class of a DB instance.</p>"];
      supported_engine_modes: EngineModeList.t
        [@ocaml.doc "<p>A list of the supported DB engine modes.</p>"];
      supports_storage_autoscaling: Boolean.t option
        [@ocaml.doc
          "<p>Whether or not Amazon RDS can automatically scale storage for DB instances that use the specified instance class.</p>"];
      supports_kerberos_authentication: Boolean.t option
        [@ocaml.doc
          "<p>Whether a DB instance supports Kerberos Authentication.</p>"]}
    [@@ocaml.doc
      "<p>Contains a list of available options for a DB instance.</p> <p> This data type is used as a response element in the <code>DescribeOrderableDBInstanceOptions</code> action. </p>"]
    let make ?engine  ?engine_version  ?d_b_instance_class  ?license_model 
      ?(availability_zones= [])  ?multi_a_z_capable  ?read_replica_capable 
      ?vpc  ?supports_storage_encryption  ?storage_type  ?supports_iops 
      ?supports_enhanced_monitoring  ?supports_i_a_m_database_authentication 
      ?supports_performance_insights  ?min_storage_size  ?max_storage_size 
      ?min_iops_per_db_instance  ?max_iops_per_db_instance  ?min_iops_per_gib
       ?max_iops_per_gib  ?(available_processor_features= []) 
      ?(supported_engine_modes= [])  ?supports_storage_autoscaling 
      ?supports_kerberos_authentication  () =
      {
        engine;
        engine_version;
        d_b_instance_class;
        license_model;
        availability_zones;
        multi_a_z_capable;
        read_replica_capable;
        vpc;
        supports_storage_encryption;
        storage_type;
        supports_iops;
        supports_enhanced_monitoring;
        supports_i_a_m_database_authentication;
        supports_performance_insights;
        min_storage_size;
        max_storage_size;
        min_iops_per_db_instance;
        max_iops_per_db_instance;
        min_iops_per_gib;
        max_iops_per_gib;
        available_processor_features;
        supported_engine_modes;
        supports_storage_autoscaling;
        supports_kerberos_authentication
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.supports_kerberos_authentication
              (fun f ->
                 ("supports_kerberos_authentication", (Boolean.to_json f)));
           Util.option_map v.supports_storage_autoscaling
             (fun f -> ("supports_storage_autoscaling", (Boolean.to_json f)));
           Some
             ("supported_engine_modes",
               (EngineModeList.to_json v.supported_engine_modes));
           Some
             ("available_processor_features",
               (AvailableProcessorFeatureList.to_json
                  v.available_processor_features));
           Util.option_map v.max_iops_per_gib
             (fun f -> ("max_iops_per_gib", (Double.to_json f)));
           Util.option_map v.min_iops_per_gib
             (fun f -> ("min_iops_per_gib", (Double.to_json f)));
           Util.option_map v.max_iops_per_db_instance
             (fun f -> ("max_iops_per_db_instance", (Integer.to_json f)));
           Util.option_map v.min_iops_per_db_instance
             (fun f -> ("min_iops_per_db_instance", (Integer.to_json f)));
           Util.option_map v.max_storage_size
             (fun f -> ("max_storage_size", (Integer.to_json f)));
           Util.option_map v.min_storage_size
             (fun f -> ("min_storage_size", (Integer.to_json f)));
           Util.option_map v.supports_performance_insights
             (fun f -> ("supports_performance_insights", (Boolean.to_json f)));
           Util.option_map v.supports_i_a_m_database_authentication
             (fun f ->
                ("supports_i_a_m_database_authentication",
                  (Boolean.to_json f)));
           Util.option_map v.supports_enhanced_monitoring
             (fun f -> ("supports_enhanced_monitoring", (Boolean.to_json f)));
           Util.option_map v.supports_iops
             (fun f -> ("supports_iops", (Boolean.to_json f)));
           Util.option_map v.storage_type
             (fun f -> ("storage_type", (String.to_json f)));
           Util.option_map v.supports_storage_encryption
             (fun f -> ("supports_storage_encryption", (Boolean.to_json f)));
           Util.option_map v.vpc (fun f -> ("vpc", (Boolean.to_json f)));
           Util.option_map v.read_replica_capable
             (fun f -> ("read_replica_capable", (Boolean.to_json f)));
           Util.option_map v.multi_a_z_capable
             (fun f -> ("multi_a_z_capable", (Boolean.to_json f)));
           Some
             ("availability_zones",
               (AvailabilityZoneList.to_json v.availability_zones));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)))])
    let parse xml =
      Some
        {
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "AvailabilityZones" xml)
                  AvailabilityZoneList.parse));
          multi_a_z_capable =
            (Util.option_bind (Xml.member "MultiAZCapable" xml) Boolean.parse);
          read_replica_capable =
            (Util.option_bind (Xml.member "ReadReplicaCapable" xml)
               Boolean.parse);
          vpc = (Util.option_bind (Xml.member "Vpc" xml) Boolean.parse);
          supports_storage_encryption =
            (Util.option_bind (Xml.member "SupportsStorageEncryption" xml)
               Boolean.parse);
          storage_type =
            (Util.option_bind (Xml.member "StorageType" xml) String.parse);
          supports_iops =
            (Util.option_bind (Xml.member "SupportsIops" xml) Boolean.parse);
          supports_enhanced_monitoring =
            (Util.option_bind (Xml.member "SupportsEnhancedMonitoring" xml)
               Boolean.parse);
          supports_i_a_m_database_authentication =
            (Util.option_bind
               (Xml.member "SupportsIAMDatabaseAuthentication" xml)
               Boolean.parse);
          supports_performance_insights =
            (Util.option_bind (Xml.member "SupportsPerformanceInsights" xml)
               Boolean.parse);
          min_storage_size =
            (Util.option_bind (Xml.member "MinStorageSize" xml) Integer.parse);
          max_storage_size =
            (Util.option_bind (Xml.member "MaxStorageSize" xml) Integer.parse);
          min_iops_per_db_instance =
            (Util.option_bind (Xml.member "MinIopsPerDbInstance" xml)
               Integer.parse);
          max_iops_per_db_instance =
            (Util.option_bind (Xml.member "MaxIopsPerDbInstance" xml)
               Integer.parse);
          min_iops_per_gib =
            (Util.option_bind (Xml.member "MinIopsPerGib" xml) Double.parse);
          max_iops_per_gib =
            (Util.option_bind (Xml.member "MaxIopsPerGib" xml) Double.parse);
          available_processor_features =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "AvailableProcessorFeatures" xml)
                  AvailableProcessorFeatureList.parse));
          supported_engine_modes =
            (Util.of_option []
               (Util.option_bind (Xml.member "SupportedEngineModes" xml)
                  EngineModeList.parse));
          supports_storage_autoscaling =
            (Util.option_bind (Xml.member "SupportsStorageAutoscaling" xml)
               Boolean.parse);
          supports_kerberos_authentication =
            (Util.option_bind
               (Xml.member "SupportsKerberosAuthentication" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((([] @
                                  [Util.option_map v.engine
                                     (fun f ->
                                        Ezxmlm.make_tag "Engine"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.engine_version
                                    (fun f ->
                                       Ezxmlm.make_tag "EngineVersion"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.d_b_instance_class
                                   (fun f ->
                                      Ezxmlm.make_tag "DBInstanceClass"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.license_model
                                  (fun f ->
                                     Ezxmlm.make_tag "LicenseModel"
                                       ([], (String.to_xml f)))])
                              @
                              (List.map
                                 (fun x ->
                                    Some
                                      (Ezxmlm.make_tag "AvailabilityZones"
                                         ([],
                                           (AvailabilityZoneList.to_xml [x]))))
                                 v.availability_zones))
                             @
                             [Util.option_map v.multi_a_z_capable
                                (fun f ->
                                   Ezxmlm.make_tag "MultiAZCapable"
                                     ([], (Boolean.to_xml f)))])
                            @
                            [Util.option_map v.read_replica_capable
                               (fun f ->
                                  Ezxmlm.make_tag "ReadReplicaCapable"
                                    ([], (Boolean.to_xml f)))])
                           @
                           [Util.option_map v.vpc
                              (fun f ->
                                 Ezxmlm.make_tag "Vpc"
                                   ([], (Boolean.to_xml f)))])
                          @
                          [Util.option_map v.supports_storage_encryption
                             (fun f ->
                                Ezxmlm.make_tag "SupportsStorageEncryption"
                                  ([], (Boolean.to_xml f)))])
                         @
                         [Util.option_map v.storage_type
                            (fun f ->
                               Ezxmlm.make_tag "StorageType"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.supports_iops
                           (fun f ->
                              Ezxmlm.make_tag "SupportsIops"
                                ([], (Boolean.to_xml f)))])
                       @
                       [Util.option_map v.supports_enhanced_monitoring
                          (fun f ->
                             Ezxmlm.make_tag "SupportsEnhancedMonitoring"
                               ([], (Boolean.to_xml f)))])
                      @
                      [Util.option_map
                         v.supports_i_a_m_database_authentication
                         (fun f ->
                            Ezxmlm.make_tag
                              "SupportsIAMDatabaseAuthentication"
                              ([], (Boolean.to_xml f)))])
                     @
                     [Util.option_map v.supports_performance_insights
                        (fun f ->
                           Ezxmlm.make_tag "SupportsPerformanceInsights"
                             ([], (Boolean.to_xml f)))])
                    @
                    [Util.option_map v.min_storage_size
                       (fun f ->
                          Ezxmlm.make_tag "MinStorageSize"
                            ([], (Integer.to_xml f)))])
                   @
                   [Util.option_map v.max_storage_size
                      (fun f ->
                         Ezxmlm.make_tag "MaxStorageSize"
                           ([], (Integer.to_xml f)))])
                  @
                  [Util.option_map v.min_iops_per_db_instance
                     (fun f ->
                        Ezxmlm.make_tag "MinIopsPerDbInstance"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.max_iops_per_db_instance
                    (fun f ->
                       Ezxmlm.make_tag "MaxIopsPerDbInstance"
                         ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.min_iops_per_gib
                   (fun f ->
                      Ezxmlm.make_tag "MinIopsPerGib" ([], (Double.to_xml f)))])
               @
               [Util.option_map v.max_iops_per_gib
                  (fun f ->
                     Ezxmlm.make_tag "MaxIopsPerGib" ([], (Double.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "AvailableProcessorFeatures"
                         ([], (AvailableProcessorFeatureList.to_xml [x]))))
                 v.available_processor_features))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "SupportedEngineModes"
                        ([], (EngineModeList.to_xml [x]))))
                v.supported_engine_modes))
            @
            [Util.option_map v.supports_storage_autoscaling
               (fun f ->
                  Ezxmlm.make_tag "SupportsStorageAutoscaling"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.supports_kerberos_authentication
              (fun f ->
                 Ezxmlm.make_tag "SupportsKerberosAuthentication"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains a list of available options for a DB instance.</p> <p> This data type is used as a response element in the <code>DescribeOrderableDBInstanceOptions</code> action. </p>"]
module SourceRegion =
  struct
    type t =
      {
      region_name: String.t option
        [@ocaml.doc "<p>The name of the source AWS Region.</p>"];
      endpoint: String.t option
        [@ocaml.doc
          "<p>The endpoint for the source AWS Region endpoint.</p>"];
      status: String.t option
        [@ocaml.doc "<p>The status of the source AWS Region.</p>"]}[@@ocaml.doc
                                                                    "<p>Contains an AWS Region name as the result of a successful call to the <code>DescribeSourceRegions</code> action.</p>"]
    let make ?region_name  ?endpoint  ?status  () =
      { region_name; endpoint; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (String.to_json f)));
           Util.option_map v.region_name
             (fun f -> ("region_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          region_name =
            (Util.option_bind (Xml.member "RegionName" xml) String.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.region_name
                (fun f ->
                   Ezxmlm.make_tag "RegionName" ([], (String.to_xml f)))])
            @
            [Util.option_map v.endpoint
               (fun f -> Ezxmlm.make_tag "Endpoint" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains an AWS Region name as the result of a successful call to the <code>DescribeSourceRegions</code> action.</p>"]
module DBClusterSnapshot =
  struct
    type t =
      {
      availability_zones: AvailabilityZones.t
        [@ocaml.doc
          "<p>Provides the list of Availability Zones (AZs) where instances in the DB cluster snapshot can be restored.</p>"];
      d_b_cluster_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>Specifies the identifier for the DB cluster snapshot.</p>"];
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>Specifies the DB cluster identifier of the DB cluster that this DB cluster snapshot was created from.</p>"];
      snapshot_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Provides the time when the snapshot was taken, in Universal Coordinated Time (UTC).</p>"];
      engine: String.t option
        [@ocaml.doc "<p>Specifies the name of the database engine.</p>"];
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>Specifies the allocated storage size in gibibytes (GiB).</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Specifies the status of this DB cluster snapshot.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>Specifies the port that the DB cluster was listening on at the time of the snapshot.</p>"];
      vpc_id: String.t option
        [@ocaml.doc
          "<p>Provides the VPC ID associated with the DB cluster snapshot.</p>"];
      cluster_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the time when the DB cluster was created, in Universal Coordinated Time (UTC).</p>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>Provides the master username for the DB cluster snapshot.</p>"];
      engine_version: String.t option
        [@ocaml.doc
          "<p>Provides the version of the database engine for this DB cluster snapshot.</p>"];
      license_model: String.t option
        [@ocaml.doc
          "<p>Provides the license model information for this DB cluster snapshot.</p>"];
      snapshot_type: String.t option
        [@ocaml.doc "<p>Provides the type of the DB cluster snapshot.</p>"];
      percent_progress: Integer.t option
        [@ocaml.doc
          "<p>Specifies the percentage of the estimated data that has been transferred.</p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the DB cluster snapshot is encrypted.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>If <code>StorageEncrypted</code> is true, the AWS KMS key identifier for the encrypted DB cluster snapshot.</p>"];
      d_b_cluster_snapshot_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB cluster snapshot.</p>"];
      source_d_b_cluster_snapshot_arn: String.t option
        [@ocaml.doc
          "<p>If the DB cluster snapshot was copied from a source DB cluster snapshot, the Amazon Resource Name (ARN) for the source DB cluster snapshot, otherwise, a null value.</p>"];
      i_a_m_database_authentication_enabled: Boolean.t option
        [@ocaml.doc
          "<p>True if mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled, and otherwise false.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details for an Amazon RDS DB cluster snapshot </p> <p>This data type is used as a response element in the <code>DescribeDBClusterSnapshots</code> action. </p>"]
    let make ?(availability_zones= [])  ?d_b_cluster_snapshot_identifier 
      ?d_b_cluster_identifier  ?snapshot_create_time  ?engine 
      ?allocated_storage  ?status  ?port  ?vpc_id  ?cluster_create_time 
      ?master_username  ?engine_version  ?license_model  ?snapshot_type 
      ?percent_progress  ?storage_encrypted  ?kms_key_id 
      ?d_b_cluster_snapshot_arn  ?source_d_b_cluster_snapshot_arn 
      ?i_a_m_database_authentication_enabled  () =
      {
        availability_zones;
        d_b_cluster_snapshot_identifier;
        d_b_cluster_identifier;
        snapshot_create_time;
        engine;
        allocated_storage;
        status;
        port;
        vpc_id;
        cluster_create_time;
        master_username;
        engine_version;
        license_model;
        snapshot_type;
        percent_progress;
        storage_encrypted;
        kms_key_id;
        d_b_cluster_snapshot_arn;
        source_d_b_cluster_snapshot_arn;
        i_a_m_database_authentication_enabled
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_a_m_database_authentication_enabled
              (fun f ->
                 ("i_a_m_database_authentication_enabled",
                   (Boolean.to_json f)));
           Util.option_map v.source_d_b_cluster_snapshot_arn
             (fun f ->
                ("source_d_b_cluster_snapshot_arn", (String.to_json f)));
           Util.option_map v.d_b_cluster_snapshot_arn
             (fun f -> ("d_b_cluster_snapshot_arn", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.percent_progress
             (fun f -> ("percent_progress", (Integer.to_json f)));
           Util.option_map v.snapshot_type
             (fun f -> ("snapshot_type", (String.to_json f)));
           Util.option_map v.license_model
             (fun f -> ("license_model", (String.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
           Util.option_map v.cluster_create_time
             (fun f -> ("cluster_create_time", (DateTime.to_json f)));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.snapshot_create_time
             (fun f -> ("snapshot_create_time", (DateTime.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)));
           Util.option_map v.d_b_cluster_snapshot_identifier
             (fun f ->
                ("d_b_cluster_snapshot_identifier", (String.to_json f)));
           Some
             ("availability_zones",
               (AvailabilityZones.to_json v.availability_zones))])
    let parse xml =
      Some
        {
          availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "AvailabilityZones" xml)
                  AvailabilityZones.parse));
          d_b_cluster_snapshot_identifier =
            (Util.option_bind (Xml.member "DBClusterSnapshotIdentifier" xml)
               String.parse);
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          snapshot_create_time =
            (Util.option_bind (Xml.member "SnapshotCreateTime" xml)
               DateTime.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          cluster_create_time =
            (Util.option_bind (Xml.member "ClusterCreateTime" xml)
               DateTime.parse);
          master_username =
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          license_model =
            (Util.option_bind (Xml.member "LicenseModel" xml) String.parse);
          snapshot_type =
            (Util.option_bind (Xml.member "SnapshotType" xml) String.parse);
          percent_progress =
            (Util.option_bind (Xml.member "PercentProgress" xml)
               Integer.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          d_b_cluster_snapshot_arn =
            (Util.option_bind (Xml.member "DBClusterSnapshotArn" xml)
               String.parse);
          source_d_b_cluster_snapshot_arn =
            (Util.option_bind (Xml.member "SourceDBClusterSnapshotArn" xml)
               String.parse);
          i_a_m_database_authentication_enabled =
            (Util.option_bind
               (Xml.member "IAMDatabaseAuthenticationEnabled" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((([] @
                              (List.map
                                 (fun x ->
                                    Some
                                      (Ezxmlm.make_tag "AvailabilityZones"
                                         ([], (AvailabilityZones.to_xml [x]))))
                                 v.availability_zones))
                             @
                             [Util.option_map
                                v.d_b_cluster_snapshot_identifier
                                (fun f ->
                                   Ezxmlm.make_tag
                                     "DBClusterSnapshotIdentifier"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.d_b_cluster_identifier
                               (fun f ->
                                  Ezxmlm.make_tag "DBClusterIdentifier"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.snapshot_create_time
                              (fun f ->
                                 Ezxmlm.make_tag "SnapshotCreateTime"
                                   ([], (DateTime.to_xml f)))])
                          @
                          [Util.option_map v.engine
                             (fun f ->
                                Ezxmlm.make_tag "Engine"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.allocated_storage
                            (fun f ->
                               Ezxmlm.make_tag "AllocatedStorage"
                                 ([], (Integer.to_xml f)))])
                        @
                        [Util.option_map v.status
                           (fun f ->
                              Ezxmlm.make_tag "Status"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.port
                          (fun f ->
                             Ezxmlm.make_tag "Port" ([], (Integer.to_xml f)))])
                      @
                      [Util.option_map v.vpc_id
                         (fun f ->
                            Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.cluster_create_time
                        (fun f ->
                           Ezxmlm.make_tag "ClusterCreateTime"
                             ([], (DateTime.to_xml f)))])
                    @
                    [Util.option_map v.master_username
                       (fun f ->
                          Ezxmlm.make_tag "MasterUsername"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.engine_version
                      (fun f ->
                         Ezxmlm.make_tag "EngineVersion"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.license_model
                     (fun f ->
                        Ezxmlm.make_tag "LicenseModel"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.snapshot_type
                    (fun f ->
                       Ezxmlm.make_tag "SnapshotType" ([], (String.to_xml f)))])
                @
                [Util.option_map v.percent_progress
                   (fun f ->
                      Ezxmlm.make_tag "PercentProgress"
                        ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.storage_encrypted
                  (fun f ->
                     Ezxmlm.make_tag "StorageEncrypted"
                       ([], (Boolean.to_xml f)))])
              @
              [Util.option_map v.kms_key_id
                 (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.d_b_cluster_snapshot_arn
                (fun f ->
                   Ezxmlm.make_tag "DBClusterSnapshotArn"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.source_d_b_cluster_snapshot_arn
               (fun f ->
                  Ezxmlm.make_tag "SourceDBClusterSnapshotArn"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_a_m_database_authentication_enabled
              (fun f ->
                 Ezxmlm.make_tag "IAMDatabaseAuthenticationEnabled"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details for an Amazon RDS DB cluster snapshot </p> <p>This data type is used as a response element in the <code>DescribeDBClusterSnapshots</code> action. </p>"]
module ReservedDBInstancesOffering =
  struct
    type t =
      {
      reserved_d_b_instances_offering_id: String.t option
        [@ocaml.doc "<p>The offering identifier.</p>"];
      d_b_instance_class: String.t option
        [@ocaml.doc
          "<p>The DB instance class for the reserved DB instance.</p>"];
      duration: Integer.t option
        [@ocaml.doc "<p>The duration of the offering in seconds.</p>"];
      fixed_price: Double.t option
        [@ocaml.doc "<p>The fixed price charged for this offering.</p>"];
      usage_price: Double.t option
        [@ocaml.doc "<p>The hourly price charged for this offering.</p>"];
      currency_code: String.t option
        [@ocaml.doc
          "<p>The currency code for the reserved DB instance offering.</p>"];
      product_description: String.t option
        [@ocaml.doc "<p>The database engine used by the offering.</p>"];
      offering_type: String.t option [@ocaml.doc "<p>The offering type.</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>Indicates if the offering applies to Multi-AZ deployments.</p>"];
      recurring_charges: RecurringChargeList.t
        [@ocaml.doc
          "<p>The recurring price charged to run this reserved DB instance.</p>"]}
    [@@ocaml.doc
      "<p> This data type is used as a response element in the <code>DescribeReservedDBInstancesOfferings</code> action. </p>"]
    let make ?reserved_d_b_instances_offering_id  ?d_b_instance_class 
      ?duration  ?fixed_price  ?usage_price  ?currency_code 
      ?product_description  ?offering_type  ?multi_a_z  ?(recurring_charges=
      [])  () =
      {
        reserved_d_b_instances_offering_id;
        d_b_instance_class;
        duration;
        fixed_price;
        usage_price;
        currency_code;
        product_description;
        offering_type;
        multi_a_z;
        recurring_charges
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("recurring_charges",
                (RecurringChargeList.to_json v.recurring_charges));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Util.option_map v.offering_type
             (fun f -> ("offering_type", (String.to_json f)));
           Util.option_map v.product_description
             (fun f -> ("product_description", (String.to_json f)));
           Util.option_map v.currency_code
             (fun f -> ("currency_code", (String.to_json f)));
           Util.option_map v.usage_price
             (fun f -> ("usage_price", (Double.to_json f)));
           Util.option_map v.fixed_price
             (fun f -> ("fixed_price", (Double.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.d_b_instance_class
             (fun f -> ("d_b_instance_class", (String.to_json f)));
           Util.option_map v.reserved_d_b_instances_offering_id
             (fun f ->
                ("reserved_d_b_instances_offering_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          reserved_d_b_instances_offering_id =
            (Util.option_bind
               (Xml.member "ReservedDBInstancesOfferingId" xml) String.parse);
          d_b_instance_class =
            (Util.option_bind (Xml.member "DBInstanceClass" xml) String.parse);
          duration =
            (Util.option_bind (Xml.member "Duration" xml) Integer.parse);
          fixed_price =
            (Util.option_bind (Xml.member "FixedPrice" xml) Double.parse);
          usage_price =
            (Util.option_bind (Xml.member "UsagePrice" xml) Double.parse);
          currency_code =
            (Util.option_bind (Xml.member "CurrencyCode" xml) String.parse);
          product_description =
            (Util.option_bind (Xml.member "ProductDescription" xml)
               String.parse);
          offering_type =
            (Util.option_bind (Xml.member "OfferingType" xml) String.parse);
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          recurring_charges =
            (Util.of_option []
               (Util.option_bind (Xml.member "RecurringCharges" xml)
                  RecurringChargeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.reserved_d_b_instances_offering_id
                       (fun f ->
                          Ezxmlm.make_tag "ReservedDBInstancesOfferingId"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.d_b_instance_class
                      (fun f ->
                         Ezxmlm.make_tag "DBInstanceClass"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.duration
                     (fun f ->
                        Ezxmlm.make_tag "Duration" ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.fixed_price
                    (fun f ->
                       Ezxmlm.make_tag "FixedPrice" ([], (Double.to_xml f)))])
                @
                [Util.option_map v.usage_price
                   (fun f ->
                      Ezxmlm.make_tag "UsagePrice" ([], (Double.to_xml f)))])
               @
               [Util.option_map v.currency_code
                  (fun f ->
                     Ezxmlm.make_tag "CurrencyCode" ([], (String.to_xml f)))])
              @
              [Util.option_map v.product_description
                 (fun f ->
                    Ezxmlm.make_tag "ProductDescription"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.offering_type
                (fun f ->
                   Ezxmlm.make_tag "OfferingType" ([], (String.to_xml f)))])
            @
            [Util.option_map v.multi_a_z
               (fun f -> Ezxmlm.make_tag "MultiAZ" ([], (Boolean.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RecurringCharges"
                      ([], (RecurringChargeList.to_xml [x]))))
              v.recurring_charges))
  end[@@ocaml.doc
       "<p> This data type is used as a response element in the <code>DescribeReservedDBInstancesOfferings</code> action. </p>"]
module DBClusterBacktrack =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>Contains a user-supplied DB cluster identifier. This identifier is the unique key that identifies a DB cluster.</p>"];
      backtrack_identifier: String.t option
        [@ocaml.doc "<p>Contains the backtrack identifier.</p>"];
      backtrack_to: DateTime.t option
        [@ocaml.doc
          "<p>The timestamp of the time to which the DB cluster was backtracked.</p>"];
      backtracked_from: DateTime.t option
        [@ocaml.doc
          "<p>The timestamp of the time from which the DB cluster was backtracked.</p>"];
      backtrack_request_creation_time: DateTime.t option
        [@ocaml.doc
          "<p>The timestamp of the time at which the backtrack was requested.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the backtrack. This property returns one of the following values:</p> <ul> <li> <p> <code>applying</code> - The backtrack is currently being applied to or rolled back from the DB cluster.</p> </li> <li> <p> <code>completed</code> - The backtrack has successfully been applied to or rolled back from the DB cluster.</p> </li> <li> <p> <code>failed</code> - An error occurred while the backtrack was applied to or rolled back from the DB cluster.</p> </li> <li> <p> <code>pending</code> - The backtrack is currently pending application to or rollback from the DB cluster.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>This data type is used as a response element in the <code>DescribeDBClusterBacktracks</code> action.</p>"]
    let make ?d_b_cluster_identifier  ?backtrack_identifier  ?backtrack_to 
      ?backtracked_from  ?backtrack_request_creation_time  ?status  () =
      {
        d_b_cluster_identifier;
        backtrack_identifier;
        backtrack_to;
        backtracked_from;
        backtrack_request_creation_time;
        status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.backtrack_request_creation_time
             (fun f ->
                ("backtrack_request_creation_time", (DateTime.to_json f)));
           Util.option_map v.backtracked_from
             (fun f -> ("backtracked_from", (DateTime.to_json f)));
           Util.option_map v.backtrack_to
             (fun f -> ("backtrack_to", (DateTime.to_json f)));
           Util.option_map v.backtrack_identifier
             (fun f -> ("backtrack_identifier", (String.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          backtrack_identifier =
            (Util.option_bind (Xml.member "BacktrackIdentifier" xml)
               String.parse);
          backtrack_to =
            (Util.option_bind (Xml.member "BacktrackTo" xml) DateTime.parse);
          backtracked_from =
            (Util.option_bind (Xml.member "BacktrackedFrom" xml)
               DateTime.parse);
          backtrack_request_creation_time =
            (Util.option_bind (Xml.member "BacktrackRequestCreationTime" xml)
               DateTime.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.d_b_cluster_identifier
                   (fun f ->
                      Ezxmlm.make_tag "DBClusterIdentifier"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.backtrack_identifier
                  (fun f ->
                     Ezxmlm.make_tag "BacktrackIdentifier"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.backtrack_to
                 (fun f ->
                    Ezxmlm.make_tag "BacktrackTo" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.backtracked_from
                (fun f ->
                   Ezxmlm.make_tag "BacktrackedFrom"
                     ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.backtrack_request_creation_time
               (fun f ->
                  Ezxmlm.make_tag "BacktrackRequestCreationTime"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f -> Ezxmlm.make_tag "Status" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type is used as a response element in the <code>DescribeDBClusterBacktracks</code> action.</p>"]
module DBCluster =
  struct
    type t =
      {
      allocated_storage: Integer.t option
        [@ocaml.doc
          "<p>For all database engines except Amazon Aurora, <code>AllocatedStorage</code> specifies the allocated storage size in gibibytes (GiB). For Aurora, <code>AllocatedStorage</code> always returns 1, because Aurora DB cluster storage size isn't fixed, but instead automatically adjusts as needed.</p>"];
      availability_zones: AvailabilityZones.t
        [@ocaml.doc
          "<p>Provides the list of Availability Zones (AZs) where instances in the DB cluster can be created.</p>"];
      backup_retention_period: Integer.t option
        [@ocaml.doc
          "<p>Specifies the number of days for which automatic DB snapshots are retained.</p>"];
      character_set_name: String.t option
        [@ocaml.doc
          "<p>If present, specifies the name of the character set that this cluster is associated with.</p>"];
      database_name: String.t option
        [@ocaml.doc
          "<p>Contains the name of the initial database of this DB cluster that was provided at create time, if one was specified when the DB cluster was created. This same name is returned for the life of the DB cluster.</p>"];
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>Contains a user-supplied DB cluster identifier. This identifier is the unique key that identifies a DB cluster.</p>"];
      d_b_cluster_parameter_group: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the DB cluster parameter group for the DB cluster.</p>"];
      d_b_subnet_group: String.t option
        [@ocaml.doc
          "<p>Specifies information on the subnet group associated with the DB cluster, including the name, description, and subnets in the subnet group.</p>"];
      status: String.t option
        [@ocaml.doc "<p>Specifies the current state of this DB cluster.</p>"];
      percent_progress: String.t option
        [@ocaml.doc
          "<p>Specifies the progress of the operation as a percentage.</p>"];
      earliest_restorable_time: DateTime.t option
        [@ocaml.doc
          "<p>The earliest time to which a database can be restored with point-in-time restore.</p>"];
      endpoint: String.t option
        [@ocaml.doc
          "<p>Specifies the connection endpoint for the primary instance of the DB cluster.</p>"];
      reader_endpoint: String.t option
        [@ocaml.doc
          "<p>The reader endpoint for the DB cluster. The reader endpoint for a DB cluster load-balances connections across the Aurora Replicas that are available in a DB cluster. As clients request new connections to the reader endpoint, Aurora distributes the connection requests among the Aurora Replicas in the DB cluster. This functionality can help balance your read workload across multiple Aurora Replicas in your DB cluster. </p> <p>If a failover occurs, and the Aurora Replica that you are connected to is promoted to be the primary instance, your connection is dropped. To continue sending your read workload to other Aurora Replicas in the cluster, you can then reconnect to the reader endpoint.</p>"];
      custom_endpoints: StringList.t
        [@ocaml.doc
          "<p>Identifies all custom endpoints associated with the cluster.</p>"];
      multi_a_z: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the DB cluster has instances in multiple Availability Zones.</p>"];
      engine: String.t option
        [@ocaml.doc
          "<p>Provides the name of the database engine to be used for this DB cluster.</p>"];
      engine_version: String.t option
        [@ocaml.doc "<p>Indicates the database engine version.</p>"];
      latest_restorable_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the latest time to which a database can be restored with point-in-time restore.</p>"];
      port: Integer.t option
        [@ocaml.doc
          "<p>Specifies the port that the database engine is listening on.</p>"];
      master_username: String.t option
        [@ocaml.doc
          "<p>Contains the master username for the DB cluster.</p>"];
      d_b_cluster_option_group_memberships: DBClusterOptionGroupMemberships.t
        [@ocaml.doc
          "<p>Provides the list of option group memberships for this DB cluster.</p>"];
      preferred_backup_window: String.t option
        [@ocaml.doc
          "<p>Specifies the daily time range during which automated backups are created if automated backups are enabled, as determined by the <code>BackupRetentionPeriod</code>. </p>"];
      preferred_maintenance_window: String.t option
        [@ocaml.doc
          "<p>Specifies the weekly time range during which system maintenance can occur, in Universal Coordinated Time (UTC).</p>"];
      replication_source_identifier: String.t option
        [@ocaml.doc
          "<p>Contains the identifier of the source DB cluster if this DB cluster is a Read Replica.</p>"];
      read_replica_identifiers: ReadReplicaIdentifierList.t
        [@ocaml.doc
          "<p>Contains one or more identifiers of the Read Replicas associated with this DB cluster.</p>"];
      d_b_cluster_members: DBClusterMemberList.t
        [@ocaml.doc
          "<p>Provides the list of instances that make up the DB cluster.</p>"];
      vpc_security_groups: VpcSecurityGroupMembershipList.t
        [@ocaml.doc
          "<p>Provides a list of VPC security groups that the DB cluster belongs to.</p>"];
      hosted_zone_id: String.t option
        [@ocaml.doc
          "<p>Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.</p>"];
      storage_encrypted: Boolean.t option
        [@ocaml.doc "<p>Specifies whether the DB cluster is encrypted.</p>"];
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>If <code>StorageEncrypted</code> is enabled, the AWS KMS key identifier for the encrypted DB cluster.</p>"];
      db_cluster_resource_id: String.t option
        [@ocaml.doc
          "<p>The AWS Region-unique, immutable identifier for the DB cluster. This identifier is found in AWS CloudTrail log entries whenever the AWS KMS key for the DB cluster is accessed.</p>"];
      d_b_cluster_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB cluster.</p>"];
      associated_roles: DBClusterRoles.t
        [@ocaml.doc
          "<p>Provides a list of the AWS Identity and Access Management (IAM) roles that are associated with the DB cluster. IAM roles that are associated with a DB cluster grant permission for the DB cluster to access other AWS services on your behalf.</p>"];
      i_a_m_database_authentication_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the mapping of AWS Identity and Access Management (IAM) accounts to database accounts is enabled.</p>"];
      clone_group_id: String.t option
        [@ocaml.doc
          "<p>Identifies the clone group to which the DB cluster is associated.</p>"];
      cluster_create_time: DateTime.t option
        [@ocaml.doc
          "<p>Specifies the time when the DB cluster was created, in Universal Coordinated Time (UTC).</p>"];
      earliest_backtrack_time: DateTime.t option
        [@ocaml.doc
          "<p>The earliest time to which a DB cluster can be backtracked.</p>"];
      backtrack_window: Long.t option
        [@ocaml.doc
          "<p>The target backtrack window, in seconds. If this value is set to 0, backtracking is disabled for the DB cluster. Otherwise, backtracking is enabled.</p>"];
      backtrack_consumed_change_records: Long.t option
        [@ocaml.doc
          "<p>The number of change records stored for Backtrack.</p>"];
      enabled_cloudwatch_logs_exports: LogTypeList.t
        [@ocaml.doc
          "<p>A list of log types that this DB cluster is configured to export to CloudWatch Logs.</p> <p>Log types vary by DB engine. For information about the log types for each DB engine, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_LogAccess.html\">Amazon RDS Database Log Files</a> in the <i>Amazon Aurora User Guide.</i> </p>"];
      capacity: Integer.t option
        [@ocaml.doc
          "<p>The current capacity of an Aurora Serverless DB cluster. The capacity is 0 (zero) when the cluster is paused.</p> <p>For more information about Aurora Serverless, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html\">Using Amazon Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      engine_mode: String.t option
        [@ocaml.doc
          "<p>The DB engine mode of the DB cluster, either <code>provisioned</code>, <code>serverless</code>, <code>parallelquery</code>, <code>global</code>, or <code>multimaster</code>.</p>"];
      scaling_configuration_info: ScalingConfigurationInfo.t option ;
      deletion_protection: Boolean.t option
        [@ocaml.doc
          "<p>Indicates if the DB cluster has deletion protection enabled. The database can't be deleted when deletion protection is enabled. </p>"];
      http_endpoint_enabled: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether the HTTP endpoint for an Aurora Serverless DB cluster is enabled.</p> <p>When enabled, the HTTP endpoint provides a connectionless web service API for running SQL queries on the Aurora Serverless DB cluster. You can also query your database from inside the RDS console with the query editor.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/data-api.html\">Using the Data API for Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"];
      activity_stream_mode: ActivityStreamMode.t option
        [@ocaml.doc
          "<p>The mode of the database activity stream. Database events such as a change or access generate an activity stream event. The database session can handle these events either synchronously or asynchronously. </p>"];
      activity_stream_status: ActivityStreamStatus.t option
        [@ocaml.doc "<p>The status of the database activity stream.</p>"];
      activity_stream_kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier used for encrypting messages in the database activity stream.</p>"];
      activity_stream_kinesis_stream_name: String.t option
        [@ocaml.doc
          "<p>The name of the Amazon Kinesis data stream used for the database activity stream.</p>"];
      copy_tags_to_snapshot: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether tags are copied from the DB cluster to snapshots of the DB cluster.</p>"];
      cross_account_clone: Boolean.t option
        [@ocaml.doc
          "<p>Specifies whether the DB cluster is a clone of a DB cluster owned by a different AWS account.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details of an Amazon Aurora DB cluster. </p> <p>This data type is used as a response element in the <code>DescribeDBClusters</code>, <code>StopDBCluster</code>, and <code>StartDBCluster</code> actions. </p>"]
    let make ?allocated_storage  ?(availability_zones= []) 
      ?backup_retention_period  ?character_set_name  ?database_name 
      ?d_b_cluster_identifier  ?d_b_cluster_parameter_group 
      ?d_b_subnet_group  ?status  ?percent_progress 
      ?earliest_restorable_time  ?endpoint  ?reader_endpoint 
      ?(custom_endpoints= [])  ?multi_a_z  ?engine  ?engine_version 
      ?latest_restorable_time  ?port  ?master_username 
      ?(d_b_cluster_option_group_memberships= [])  ?preferred_backup_window 
      ?preferred_maintenance_window  ?replication_source_identifier 
      ?(read_replica_identifiers= [])  ?(d_b_cluster_members= []) 
      ?(vpc_security_groups= [])  ?hosted_zone_id  ?storage_encrypted 
      ?kms_key_id  ?db_cluster_resource_id  ?d_b_cluster_arn 
      ?(associated_roles= [])  ?i_a_m_database_authentication_enabled 
      ?clone_group_id  ?cluster_create_time  ?earliest_backtrack_time 
      ?backtrack_window  ?backtrack_consumed_change_records 
      ?(enabled_cloudwatch_logs_exports= [])  ?capacity  ?engine_mode 
      ?scaling_configuration_info  ?deletion_protection 
      ?http_endpoint_enabled  ?activity_stream_mode  ?activity_stream_status 
      ?activity_stream_kms_key_id  ?activity_stream_kinesis_stream_name 
      ?copy_tags_to_snapshot  ?cross_account_clone  () =
      {
        allocated_storage;
        availability_zones;
        backup_retention_period;
        character_set_name;
        database_name;
        d_b_cluster_identifier;
        d_b_cluster_parameter_group;
        d_b_subnet_group;
        status;
        percent_progress;
        earliest_restorable_time;
        endpoint;
        reader_endpoint;
        custom_endpoints;
        multi_a_z;
        engine;
        engine_version;
        latest_restorable_time;
        port;
        master_username;
        d_b_cluster_option_group_memberships;
        preferred_backup_window;
        preferred_maintenance_window;
        replication_source_identifier;
        read_replica_identifiers;
        d_b_cluster_members;
        vpc_security_groups;
        hosted_zone_id;
        storage_encrypted;
        kms_key_id;
        db_cluster_resource_id;
        d_b_cluster_arn;
        associated_roles;
        i_a_m_database_authentication_enabled;
        clone_group_id;
        cluster_create_time;
        earliest_backtrack_time;
        backtrack_window;
        backtrack_consumed_change_records;
        enabled_cloudwatch_logs_exports;
        capacity;
        engine_mode;
        scaling_configuration_info;
        deletion_protection;
        http_endpoint_enabled;
        activity_stream_mode;
        activity_stream_status;
        activity_stream_kms_key_id;
        activity_stream_kinesis_stream_name;
        copy_tags_to_snapshot;
        cross_account_clone
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cross_account_clone
              (fun f -> ("cross_account_clone", (Boolean.to_json f)));
           Util.option_map v.copy_tags_to_snapshot
             (fun f -> ("copy_tags_to_snapshot", (Boolean.to_json f)));
           Util.option_map v.activity_stream_kinesis_stream_name
             (fun f ->
                ("activity_stream_kinesis_stream_name", (String.to_json f)));
           Util.option_map v.activity_stream_kms_key_id
             (fun f -> ("activity_stream_kms_key_id", (String.to_json f)));
           Util.option_map v.activity_stream_status
             (fun f ->
                ("activity_stream_status", (ActivityStreamStatus.to_json f)));
           Util.option_map v.activity_stream_mode
             (fun f ->
                ("activity_stream_mode", (ActivityStreamMode.to_json f)));
           Util.option_map v.http_endpoint_enabled
             (fun f -> ("http_endpoint_enabled", (Boolean.to_json f)));
           Util.option_map v.deletion_protection
             (fun f -> ("deletion_protection", (Boolean.to_json f)));
           Util.option_map v.scaling_configuration_info
             (fun f ->
                ("scaling_configuration_info",
                  (ScalingConfigurationInfo.to_json f)));
           Util.option_map v.engine_mode
             (fun f -> ("engine_mode", (String.to_json f)));
           Util.option_map v.capacity
             (fun f -> ("capacity", (Integer.to_json f)));
           Some
             ("enabled_cloudwatch_logs_exports",
               (LogTypeList.to_json v.enabled_cloudwatch_logs_exports));
           Util.option_map v.backtrack_consumed_change_records
             (fun f ->
                ("backtrack_consumed_change_records", (Long.to_json f)));
           Util.option_map v.backtrack_window
             (fun f -> ("backtrack_window", (Long.to_json f)));
           Util.option_map v.earliest_backtrack_time
             (fun f -> ("earliest_backtrack_time", (DateTime.to_json f)));
           Util.option_map v.cluster_create_time
             (fun f -> ("cluster_create_time", (DateTime.to_json f)));
           Util.option_map v.clone_group_id
             (fun f -> ("clone_group_id", (String.to_json f)));
           Util.option_map v.i_a_m_database_authentication_enabled
             (fun f ->
                ("i_a_m_database_authentication_enabled",
                  (Boolean.to_json f)));
           Some
             ("associated_roles",
               (DBClusterRoles.to_json v.associated_roles));
           Util.option_map v.d_b_cluster_arn
             (fun f -> ("d_b_cluster_arn", (String.to_json f)));
           Util.option_map v.db_cluster_resource_id
             (fun f -> ("db_cluster_resource_id", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)));
           Util.option_map v.storage_encrypted
             (fun f -> ("storage_encrypted", (Boolean.to_json f)));
           Util.option_map v.hosted_zone_id
             (fun f -> ("hosted_zone_id", (String.to_json f)));
           Some
             ("vpc_security_groups",
               (VpcSecurityGroupMembershipList.to_json v.vpc_security_groups));
           Some
             ("d_b_cluster_members",
               (DBClusterMemberList.to_json v.d_b_cluster_members));
           Some
             ("read_replica_identifiers",
               (ReadReplicaIdentifierList.to_json v.read_replica_identifiers));
           Util.option_map v.replication_source_identifier
             (fun f -> ("replication_source_identifier", (String.to_json f)));
           Util.option_map v.preferred_maintenance_window
             (fun f -> ("preferred_maintenance_window", (String.to_json f)));
           Util.option_map v.preferred_backup_window
             (fun f -> ("preferred_backup_window", (String.to_json f)));
           Some
             ("d_b_cluster_option_group_memberships",
               (DBClusterOptionGroupMemberships.to_json
                  v.d_b_cluster_option_group_memberships));
           Util.option_map v.master_username
             (fun f -> ("master_username", (String.to_json f)));
           Util.option_map v.port (fun f -> ("port", (Integer.to_json f)));
           Util.option_map v.latest_restorable_time
             (fun f -> ("latest_restorable_time", (DateTime.to_json f)));
           Util.option_map v.engine_version
             (fun f -> ("engine_version", (String.to_json f)));
           Util.option_map v.engine (fun f -> ("engine", (String.to_json f)));
           Util.option_map v.multi_a_z
             (fun f -> ("multi_a_z", (Boolean.to_json f)));
           Some ("custom_endpoints", (StringList.to_json v.custom_endpoints));
           Util.option_map v.reader_endpoint
             (fun f -> ("reader_endpoint", (String.to_json f)));
           Util.option_map v.endpoint
             (fun f -> ("endpoint", (String.to_json f)));
           Util.option_map v.earliest_restorable_time
             (fun f -> ("earliest_restorable_time", (DateTime.to_json f)));
           Util.option_map v.percent_progress
             (fun f -> ("percent_progress", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.d_b_subnet_group
             (fun f -> ("d_b_subnet_group", (String.to_json f)));
           Util.option_map v.d_b_cluster_parameter_group
             (fun f -> ("d_b_cluster_parameter_group", (String.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)));
           Util.option_map v.database_name
             (fun f -> ("database_name", (String.to_json f)));
           Util.option_map v.character_set_name
             (fun f -> ("character_set_name", (String.to_json f)));
           Util.option_map v.backup_retention_period
             (fun f -> ("backup_retention_period", (Integer.to_json f)));
           Some
             ("availability_zones",
               (AvailabilityZones.to_json v.availability_zones));
           Util.option_map v.allocated_storage
             (fun f -> ("allocated_storage", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          allocated_storage =
            (Util.option_bind (Xml.member "AllocatedStorage" xml)
               Integer.parse);
          availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "AvailabilityZones" xml)
                  AvailabilityZones.parse));
          backup_retention_period =
            (Util.option_bind (Xml.member "BackupRetentionPeriod" xml)
               Integer.parse);
          character_set_name =
            (Util.option_bind (Xml.member "CharacterSetName" xml)
               String.parse);
          database_name =
            (Util.option_bind (Xml.member "DatabaseName" xml) String.parse);
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          d_b_cluster_parameter_group =
            (Util.option_bind (Xml.member "DBClusterParameterGroup" xml)
               String.parse);
          d_b_subnet_group =
            (Util.option_bind (Xml.member "DBSubnetGroup" xml) String.parse);
          status = (Util.option_bind (Xml.member "Status" xml) String.parse);
          percent_progress =
            (Util.option_bind (Xml.member "PercentProgress" xml) String.parse);
          earliest_restorable_time =
            (Util.option_bind (Xml.member "EarliestRestorableTime" xml)
               DateTime.parse);
          endpoint =
            (Util.option_bind (Xml.member "Endpoint" xml) String.parse);
          reader_endpoint =
            (Util.option_bind (Xml.member "ReaderEndpoint" xml) String.parse);
          custom_endpoints =
            (Util.of_option []
               (Util.option_bind (Xml.member "CustomEndpoints" xml)
                  StringList.parse));
          multi_a_z =
            (Util.option_bind (Xml.member "MultiAZ" xml) Boolean.parse);
          engine = (Util.option_bind (Xml.member "Engine" xml) String.parse);
          engine_version =
            (Util.option_bind (Xml.member "EngineVersion" xml) String.parse);
          latest_restorable_time =
            (Util.option_bind (Xml.member "LatestRestorableTime" xml)
               DateTime.parse);
          port = (Util.option_bind (Xml.member "Port" xml) Integer.parse);
          master_username =
            (Util.option_bind (Xml.member "MasterUsername" xml) String.parse);
          d_b_cluster_option_group_memberships =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "DBClusterOptionGroupMemberships" xml)
                  DBClusterOptionGroupMemberships.parse));
          preferred_backup_window =
            (Util.option_bind (Xml.member "PreferredBackupWindow" xml)
               String.parse);
          preferred_maintenance_window =
            (Util.option_bind (Xml.member "PreferredMaintenanceWindow" xml)
               String.parse);
          replication_source_identifier =
            (Util.option_bind (Xml.member "ReplicationSourceIdentifier" xml)
               String.parse);
          read_replica_identifiers =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReadReplicaIdentifiers" xml)
                  ReadReplicaIdentifierList.parse));
          d_b_cluster_members =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusterMembers" xml)
                  DBClusterMemberList.parse));
          vpc_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "VpcSecurityGroups" xml)
                  VpcSecurityGroupMembershipList.parse));
          hosted_zone_id =
            (Util.option_bind (Xml.member "HostedZoneId" xml) String.parse);
          storage_encrypted =
            (Util.option_bind (Xml.member "StorageEncrypted" xml)
               Boolean.parse);
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          db_cluster_resource_id =
            (Util.option_bind (Xml.member "DbClusterResourceId" xml)
               String.parse);
          d_b_cluster_arn =
            (Util.option_bind (Xml.member "DBClusterArn" xml) String.parse);
          associated_roles =
            (Util.of_option []
               (Util.option_bind (Xml.member "AssociatedRoles" xml)
                  DBClusterRoles.parse));
          i_a_m_database_authentication_enabled =
            (Util.option_bind
               (Xml.member "IAMDatabaseAuthenticationEnabled" xml)
               Boolean.parse);
          clone_group_id =
            (Util.option_bind (Xml.member "CloneGroupId" xml) String.parse);
          cluster_create_time =
            (Util.option_bind (Xml.member "ClusterCreateTime" xml)
               DateTime.parse);
          earliest_backtrack_time =
            (Util.option_bind (Xml.member "EarliestBacktrackTime" xml)
               DateTime.parse);
          backtrack_window =
            (Util.option_bind (Xml.member "BacktrackWindow" xml) Long.parse);
          backtrack_consumed_change_records =
            (Util.option_bind
               (Xml.member "BacktrackConsumedChangeRecords" xml) Long.parse);
          enabled_cloudwatch_logs_exports =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "EnabledCloudwatchLogsExports" xml)
                  LogTypeList.parse));
          capacity =
            (Util.option_bind (Xml.member "Capacity" xml) Integer.parse);
          engine_mode =
            (Util.option_bind (Xml.member "EngineMode" xml) String.parse);
          scaling_configuration_info =
            (Util.option_bind (Xml.member "ScalingConfigurationInfo" xml)
               ScalingConfigurationInfo.parse);
          deletion_protection =
            (Util.option_bind (Xml.member "DeletionProtection" xml)
               Boolean.parse);
          http_endpoint_enabled =
            (Util.option_bind (Xml.member "HttpEndpointEnabled" xml)
               Boolean.parse);
          activity_stream_mode =
            (Util.option_bind (Xml.member "ActivityStreamMode" xml)
               ActivityStreamMode.parse);
          activity_stream_status =
            (Util.option_bind (Xml.member "ActivityStreamStatus" xml)
               ActivityStreamStatus.parse);
          activity_stream_kms_key_id =
            (Util.option_bind (Xml.member "ActivityStreamKmsKeyId" xml)
               String.parse);
          activity_stream_kinesis_stream_name =
            (Util.option_bind
               (Xml.member "ActivityStreamKinesisStreamName" xml)
               String.parse);
          copy_tags_to_snapshot =
            (Util.option_bind (Xml.member "CopyTagsToSnapshot" xml)
               Boolean.parse);
          cross_account_clone =
            (Util.option_bind (Xml.member "CrossAccountClone" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((((((((((((((((((((((((([] @
                                                             [Util.option_map
                                                                v.allocated_storage
                                                                (fun f ->
                                                                   Ezxmlm.make_tag
                                                                    "AllocatedStorage"
                                                                    ([],
                                                                    (Integer.to_xml
                                                                    f)))])
                                                            @
                                                            (List.map
                                                               (fun x ->
                                                                  Some
                                                                    (
                                                                    Ezxmlm.make_tag
                                                                    "AvailabilityZones"
                                                                    ([],
                                                                    (AvailabilityZones.to_xml
                                                                    [x]))))
                                                               v.availability_zones))
                                                           @
                                                           [Util.option_map
                                                              v.backup_retention_period
                                                              (fun f ->
                                                                 Ezxmlm.make_tag
                                                                   "BackupRetentionPeriod"
                                                                   ([],
                                                                    (Integer.to_xml
                                                                    f)))])
                                                          @
                                                          [Util.option_map
                                                             v.character_set_name
                                                             (fun f ->
                                                                Ezxmlm.make_tag
                                                                  "CharacterSetName"
                                                                  ([],
                                                                    (
                                                                    String.to_xml
                                                                    f)))])
                                                         @
                                                         [Util.option_map
                                                            v.database_name
                                                            (fun f ->
                                                               Ezxmlm.make_tag
                                                                 "DatabaseName"
                                                                 ([],
                                                                   (String.to_xml
                                                                    f)))])
                                                        @
                                                        [Util.option_map
                                                           v.d_b_cluster_identifier
                                                           (fun f ->
                                                              Ezxmlm.make_tag
                                                                "DBClusterIdentifier"
                                                                ([],
                                                                  (String.to_xml
                                                                    f)))])
                                                       @
                                                       [Util.option_map
                                                          v.d_b_cluster_parameter_group
                                                          (fun f ->
                                                             Ezxmlm.make_tag
                                                               "DBClusterParameterGroup"
                                                               ([],
                                                                 (String.to_xml
                                                                    f)))])
                                                      @
                                                      [Util.option_map
                                                         v.d_b_subnet_group
                                                         (fun f ->
                                                            Ezxmlm.make_tag
                                                              "DBSubnetGroup"
                                                              ([],
                                                                (String.to_xml
                                                                   f)))])
                                                     @
                                                     [Util.option_map
                                                        v.status
                                                        (fun f ->
                                                           Ezxmlm.make_tag
                                                             "Status"
                                                             ([],
                                                               (String.to_xml
                                                                  f)))])
                                                    @
                                                    [Util.option_map
                                                       v.percent_progress
                                                       (fun f ->
                                                          Ezxmlm.make_tag
                                                            "PercentProgress"
                                                            ([],
                                                              (String.to_xml
                                                                 f)))])
                                                   @
                                                   [Util.option_map
                                                      v.earliest_restorable_time
                                                      (fun f ->
                                                         Ezxmlm.make_tag
                                                           "EarliestRestorableTime"
                                                           ([],
                                                             (DateTime.to_xml
                                                                f)))])
                                                  @
                                                  [Util.option_map v.endpoint
                                                     (fun f ->
                                                        Ezxmlm.make_tag
                                                          "Endpoint"
                                                          ([],
                                                            (String.to_xml f)))])
                                                 @
                                                 [Util.option_map
                                                    v.reader_endpoint
                                                    (fun f ->
                                                       Ezxmlm.make_tag
                                                         "ReaderEndpoint"
                                                         ([],
                                                           (String.to_xml f)))])
                                                @
                                                (List.map
                                                   (fun x ->
                                                      Some
                                                        (Ezxmlm.make_tag
                                                           "CustomEndpoints"
                                                           ([],
                                                             (StringList.to_xml
                                                                [x]))))
                                                   v.custom_endpoints))
                                               @
                                               [Util.option_map v.multi_a_z
                                                  (fun f ->
                                                     Ezxmlm.make_tag
                                                       "MultiAZ"
                                                       ([],
                                                         (Boolean.to_xml f)))])
                                              @
                                              [Util.option_map v.engine
                                                 (fun f ->
                                                    Ezxmlm.make_tag "Engine"
                                                      ([], (String.to_xml f)))])
                                             @
                                             [Util.option_map
                                                v.engine_version
                                                (fun f ->
                                                   Ezxmlm.make_tag
                                                     "EngineVersion"
                                                     ([], (String.to_xml f)))])
                                            @
                                            [Util.option_map
                                               v.latest_restorable_time
                                               (fun f ->
                                                  Ezxmlm.make_tag
                                                    "LatestRestorableTime"
                                                    ([], (DateTime.to_xml f)))])
                                           @
                                           [Util.option_map v.port
                                              (fun f ->
                                                 Ezxmlm.make_tag "Port"
                                                   ([], (Integer.to_xml f)))])
                                          @
                                          [Util.option_map v.master_username
                                             (fun f ->
                                                Ezxmlm.make_tag
                                                  "MasterUsername"
                                                  ([], (String.to_xml f)))])
                                         @
                                         (List.map
                                            (fun x ->
                                               Some
                                                 (Ezxmlm.make_tag
                                                    "DBClusterOptionGroupMemberships"
                                                    ([],
                                                      (DBClusterOptionGroupMemberships.to_xml
                                                         [x]))))
                                            v.d_b_cluster_option_group_memberships))
                                        @
                                        [Util.option_map
                                           v.preferred_backup_window
                                           (fun f ->
                                              Ezxmlm.make_tag
                                                "PreferredBackupWindow"
                                                ([], (String.to_xml f)))])
                                       @
                                       [Util.option_map
                                          v.preferred_maintenance_window
                                          (fun f ->
                                             Ezxmlm.make_tag
                                               "PreferredMaintenanceWindow"
                                               ([], (String.to_xml f)))])
                                      @
                                      [Util.option_map
                                         v.replication_source_identifier
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "ReplicationSourceIdentifier"
                                              ([], (String.to_xml f)))])
                                     @
                                     (List.map
                                        (fun x ->
                                           Some
                                             (Ezxmlm.make_tag
                                                "ReadReplicaIdentifiers"
                                                ([],
                                                  (ReadReplicaIdentifierList.to_xml
                                                     [x]))))
                                        v.read_replica_identifiers))
                                    @
                                    (List.map
                                       (fun x ->
                                          Some
                                            (Ezxmlm.make_tag
                                               "DBClusterMembers"
                                               ([],
                                                 (DBClusterMemberList.to_xml
                                                    [x]))))
                                       v.d_b_cluster_members))
                                   @
                                   (List.map
                                      (fun x ->
                                         Some
                                           (Ezxmlm.make_tag
                                              "VpcSecurityGroups"
                                              ([],
                                                (VpcSecurityGroupMembershipList.to_xml
                                                   [x]))))
                                      v.vpc_security_groups))
                                  @
                                  [Util.option_map v.hosted_zone_id
                                     (fun f ->
                                        Ezxmlm.make_tag "HostedZoneId"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.storage_encrypted
                                    (fun f ->
                                       Ezxmlm.make_tag "StorageEncrypted"
                                         ([], (Boolean.to_xml f)))])
                                @
                                [Util.option_map v.kms_key_id
                                   (fun f ->
                                      Ezxmlm.make_tag "KmsKeyId"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.db_cluster_resource_id
                                  (fun f ->
                                     Ezxmlm.make_tag "DbClusterResourceId"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.d_b_cluster_arn
                                 (fun f ->
                                    Ezxmlm.make_tag "DBClusterArn"
                                      ([], (String.to_xml f)))])
                             @
                             (List.map
                                (fun x ->
                                   Some
                                     (Ezxmlm.make_tag "AssociatedRoles"
                                        ([], (DBClusterRoles.to_xml [x]))))
                                v.associated_roles))
                            @
                            [Util.option_map
                               v.i_a_m_database_authentication_enabled
                               (fun f ->
                                  Ezxmlm.make_tag
                                    "IAMDatabaseAuthenticationEnabled"
                                    ([], (Boolean.to_xml f)))])
                           @
                           [Util.option_map v.clone_group_id
                              (fun f ->
                                 Ezxmlm.make_tag "CloneGroupId"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.cluster_create_time
                             (fun f ->
                                Ezxmlm.make_tag "ClusterCreateTime"
                                  ([], (DateTime.to_xml f)))])
                         @
                         [Util.option_map v.earliest_backtrack_time
                            (fun f ->
                               Ezxmlm.make_tag "EarliestBacktrackTime"
                                 ([], (DateTime.to_xml f)))])
                        @
                        [Util.option_map v.backtrack_window
                           (fun f ->
                              Ezxmlm.make_tag "BacktrackWindow"
                                ([], (Long.to_xml f)))])
                       @
                       [Util.option_map v.backtrack_consumed_change_records
                          (fun f ->
                             Ezxmlm.make_tag "BacktrackConsumedChangeRecords"
                               ([], (Long.to_xml f)))])
                      @
                      (List.map
                         (fun x ->
                            Some
                              (Ezxmlm.make_tag "EnabledCloudwatchLogsExports"
                                 ([], (LogTypeList.to_xml [x]))))
                         v.enabled_cloudwatch_logs_exports))
                     @
                     [Util.option_map v.capacity
                        (fun f ->
                           Ezxmlm.make_tag "Capacity"
                             ([], (Integer.to_xml f)))])
                    @
                    [Util.option_map v.engine_mode
                       (fun f ->
                          Ezxmlm.make_tag "EngineMode"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.scaling_configuration_info
                      (fun f ->
                         Ezxmlm.make_tag "ScalingConfigurationInfo"
                           ([], (ScalingConfigurationInfo.to_xml f)))])
                  @
                  [Util.option_map v.deletion_protection
                     (fun f ->
                        Ezxmlm.make_tag "DeletionProtection"
                          ([], (Boolean.to_xml f)))])
                 @
                 [Util.option_map v.http_endpoint_enabled
                    (fun f ->
                       Ezxmlm.make_tag "HttpEndpointEnabled"
                         ([], (Boolean.to_xml f)))])
                @
                [Util.option_map v.activity_stream_mode
                   (fun f ->
                      Ezxmlm.make_tag "ActivityStreamMode"
                        ([], (ActivityStreamMode.to_xml f)))])
               @
               [Util.option_map v.activity_stream_status
                  (fun f ->
                     Ezxmlm.make_tag "ActivityStreamStatus"
                       ([], (ActivityStreamStatus.to_xml f)))])
              @
              [Util.option_map v.activity_stream_kms_key_id
                 (fun f ->
                    Ezxmlm.make_tag "ActivityStreamKmsKeyId"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.activity_stream_kinesis_stream_name
                (fun f ->
                   Ezxmlm.make_tag "ActivityStreamKinesisStreamName"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.copy_tags_to_snapshot
               (fun f ->
                  Ezxmlm.make_tag "CopyTagsToSnapshot"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.cross_account_clone
              (fun f ->
                 Ezxmlm.make_tag "CrossAccountClone" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details of an Amazon Aurora DB cluster. </p> <p>This data type is used as a response element in the <code>DescribeDBClusters</code>, <code>StopDBCluster</code>, and <code>StartDBCluster</code> actions. </p>"]
module DBSecurityGroup =
  struct
    type t =
      {
      owner_id: String.t option
        [@ocaml.doc
          "<p>Provides the AWS ID of the owner of a specific DB security group.</p>"];
      d_b_security_group_name: String.t option
        [@ocaml.doc "<p>Specifies the name of the DB security group.</p>"];
      d_b_security_group_description: String.t option
        [@ocaml.doc
          "<p>Provides the description of the DB security group.</p>"];
      vpc_id: String.t option
        [@ocaml.doc "<p>Provides the VpcId of the DB security group.</p>"];
      e_c2_security_groups: EC2SecurityGroupList.t
        [@ocaml.doc
          "<p> Contains a list of <code>EC2SecurityGroup</code> elements. </p>"];
      i_p_ranges: IPRangeList.t
        [@ocaml.doc
          "<p> Contains a list of <code>IPRange</code> elements. </p>"];
      d_b_security_group_arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) for the DB security group.</p>"]}
    [@@ocaml.doc
      "<p>Contains the details for an Amazon RDS DB security group. </p> <p>This data type is used as a response element in the <code>DescribeDBSecurityGroups</code> action. </p>"]
    let make ?owner_id  ?d_b_security_group_name 
      ?d_b_security_group_description  ?vpc_id  ?(e_c2_security_groups= []) 
      ?(i_p_ranges= [])  ?d_b_security_group_arn  () =
      {
        owner_id;
        d_b_security_group_name;
        d_b_security_group_description;
        vpc_id;
        e_c2_security_groups;
        i_p_ranges;
        d_b_security_group_arn
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_security_group_arn
              (fun f -> ("d_b_security_group_arn", (String.to_json f)));
           Some ("i_p_ranges", (IPRangeList.to_json v.i_p_ranges));
           Some
             ("e_c2_security_groups",
               (EC2SecurityGroupList.to_json v.e_c2_security_groups));
           Util.option_map v.vpc_id (fun f -> ("vpc_id", (String.to_json f)));
           Util.option_map v.d_b_security_group_description
             (fun f -> ("d_b_security_group_description", (String.to_json f)));
           Util.option_map v.d_b_security_group_name
             (fun f -> ("d_b_security_group_name", (String.to_json f)));
           Util.option_map v.owner_id
             (fun f -> ("owner_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          owner_id =
            (Util.option_bind (Xml.member "OwnerId" xml) String.parse);
          d_b_security_group_name =
            (Util.option_bind (Xml.member "DBSecurityGroupName" xml)
               String.parse);
          d_b_security_group_description =
            (Util.option_bind (Xml.member "DBSecurityGroupDescription" xml)
               String.parse);
          vpc_id = (Util.option_bind (Xml.member "VpcId" xml) String.parse);
          e_c2_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "EC2SecurityGroups" xml)
                  EC2SecurityGroupList.parse));
          i_p_ranges =
            (Util.of_option []
               (Util.option_bind (Xml.member "IPRanges" xml)
                  IPRangeList.parse));
          d_b_security_group_arn =
            (Util.option_bind (Xml.member "DBSecurityGroupArn" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.owner_id
                    (fun f ->
                       Ezxmlm.make_tag "OwnerId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.d_b_security_group_name
                   (fun f ->
                      Ezxmlm.make_tag "DBSecurityGroupName"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.d_b_security_group_description
                  (fun f ->
                     Ezxmlm.make_tag "DBSecurityGroupDescription"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.vpc_id
                 (fun f -> Ezxmlm.make_tag "VpcId" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "EC2SecurityGroups"
                        ([], (EC2SecurityGroupList.to_xml [x]))))
                v.e_c2_security_groups))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "IPRanges"
                       ([], (IPRangeList.to_xml [x])))) v.i_p_ranges))
           @
           [Util.option_map v.d_b_security_group_arn
              (fun f ->
                 Ezxmlm.make_tag "DBSecurityGroupArn" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the details for an Amazon RDS DB security group. </p> <p>This data type is used as a response element in the <code>DescribeDBSecurityGroups</code> action. </p>"]
module TagList =
  struct
    type t = Tag.t list[@@ocaml.doc
                         "<p>A list of tags. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html\">Tagging Amazon RDS Resources</a> in the <i>Amazon RDS User Guide.</i> </p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "Tag" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
  end[@@ocaml.doc
       "<p>A list of tags. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html\">Tagging Amazon RDS Resources</a> in the <i>Amazon RDS User Guide.</i> </p>"]
module FilterList =
  struct
    type t = Filter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Filter.to_query v
    let to_headers v = Headers.to_headers_list Filter.to_headers v
    let to_json v = `List (List.map Filter.to_json v)
    let parse xml =
      Util.option_all (List.map Filter.parse (Xml.members "Filter" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Filter.to_xml x))) v
  end
module OptionGroupOptionsList =
  struct
    type t = OptionGroupOption.t list[@@ocaml.doc
                                       "<p>List of available option group options.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list OptionGroupOption.to_query v
    let to_headers v = Headers.to_headers_list OptionGroupOption.to_headers v
    let to_json v = `List (List.map OptionGroupOption.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionGroupOption.parse
           (Xml.members "OptionGroupOption" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (OptionGroupOption.to_xml x)))
        v
  end[@@ocaml.doc "<p>List of available option group options.</p>"]
module SubnetIdentifierList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml =
      Util.option_all
        (List.map String.parse (Xml.members "SubnetIdentifier" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (String.to_xml x))) v
  end
module ConnectionPoolConfiguration =
  struct
    type t =
      {
      max_connections_percent: Integer.t option
        [@ocaml.doc
          "<p>The maximum size of the connection pool for each target in a target group. For Aurora MySQL, it is expressed as a percentage of the <code>max_connections</code> setting for the RDS DB instance or Aurora DB cluster used by the target group.</p> <p>Default: 100</p> <p>Constraints: between 1 and 100</p>"];
      max_idle_connections_percent: Integer.t option
        [@ocaml.doc
          "<p> Controls how actively the proxy closes idle database connections in the connection pool. A high value enables the proxy to leave a high percentage of idle connections open. A low value causes the proxy to close idle client connections and return the underlying database connections to the connection pool. For Aurora MySQL, it is expressed as a percentage of the <code>max_connections</code> setting for the RDS DB instance or Aurora DB cluster used by the target group. </p> <p>Default: 50</p> <p>Constraints: between 0 and <code>MaxConnectionsPercent</code> </p>"];
      connection_borrow_timeout: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds for a proxy to wait for a connection to become available in the connection pool. Only applies when the proxy has opened its maximum number of connections and all connections are busy with client sessions.</p> <p>Default: 120</p> <p>Constraints: between 1 and 3600, or 0 representing unlimited</p>"];
      session_pinning_filters: StringList.t
        [@ocaml.doc
          "<p>Each item in the list represents a class of SQL operations that normally cause all later statements in a session using a proxy to be pinned to the same underlying database connection. Including an item in the list exempts that class of SQL operations from the pinning behavior.</p> <p>Default: no session pinning filters</p>"];
      init_query: String.t option
        [@ocaml.doc
          "<p> One or more SQL statements for the proxy to run when opening each new database connection. Typically used with <code>SET</code> statements to make sure that each connection has identical settings such as time zone and character set. For multiple statements, use semicolons as the separator. You can also include multiple variables in a single <code>SET</code> statement, such as <code>SET x=1, y=2</code>. </p> <p>Default: no initialization query</p>"]}
    [@@ocaml.doc
      "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Specifies the settings that control the size and behavior of the connection pool associated with a <code>DBProxyTargetGroup</code>.</p>"]
    let make ?max_connections_percent  ?max_idle_connections_percent 
      ?connection_borrow_timeout  ?(session_pinning_filters= [])  ?init_query
       () =
      {
        max_connections_percent;
        max_idle_connections_percent;
        connection_borrow_timeout;
        session_pinning_filters;
        init_query
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.init_query
              (fun f -> ("init_query", (String.to_json f)));
           Some
             ("session_pinning_filters",
               (StringList.to_json v.session_pinning_filters));
           Util.option_map v.connection_borrow_timeout
             (fun f -> ("connection_borrow_timeout", (Integer.to_json f)));
           Util.option_map v.max_idle_connections_percent
             (fun f -> ("max_idle_connections_percent", (Integer.to_json f)));
           Util.option_map v.max_connections_percent
             (fun f -> ("max_connections_percent", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          max_connections_percent =
            (Util.option_bind (Xml.member "MaxConnectionsPercent" xml)
               Integer.parse);
          max_idle_connections_percent =
            (Util.option_bind (Xml.member "MaxIdleConnectionsPercent" xml)
               Integer.parse);
          connection_borrow_timeout =
            (Util.option_bind (Xml.member "ConnectionBorrowTimeout" xml)
               Integer.parse);
          session_pinning_filters =
            (Util.of_option []
               (Util.option_bind (Xml.member "SessionPinningFilters" xml)
                  StringList.parse));
          init_query =
            (Util.option_bind (Xml.member "InitQuery" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.max_connections_percent
                  (fun f ->
                     Ezxmlm.make_tag "MaxConnectionsPercent"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.max_idle_connections_percent
                 (fun f ->
                    Ezxmlm.make_tag "MaxIdleConnectionsPercent"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.connection_borrow_timeout
                (fun f ->
                   Ezxmlm.make_tag "ConnectionBorrowTimeout"
                     ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "SessionPinningFilters"
                       ([], (StringList.to_xml [x]))))
               v.session_pinning_filters))
           @
           [Util.option_map v.init_query
              (fun f -> Ezxmlm.make_tag "InitQuery" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<note> <p>This is prerelease documentation for the RDS Database Proxy feature in preview release. It is subject to change.</p> </note> <p>Specifies the settings that control the size and behavior of the connection pool associated with a <code>DBProxyTargetGroup</code>.</p>"]
module ValidDBInstanceModificationsMessage =
  struct
    type t =
      {
      storage: ValidStorageOptionsList.t
        [@ocaml.doc "<p>Valid storage options for your DB instance. </p>"];
      valid_processor_features: AvailableProcessorFeatureList.t
        [@ocaml.doc "<p>Valid processor features for your DB instance. </p>"]}
    [@@ocaml.doc
      "<p>Information about valid modifications that you can make to your DB instance. Contains the result of a successful call to the <code>DescribeValidDBInstanceModifications</code> action. You can use this information when you call <code>ModifyDBInstance</code>. </p>"]
    let make ?(storage= [])  ?(valid_processor_features= [])  () =
      { storage; valid_processor_features }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("valid_processor_features",
                (AvailableProcessorFeatureList.to_json
                   v.valid_processor_features));
           Some ("storage", (ValidStorageOptionsList.to_json v.storage))])
    let parse xml =
      Some
        {
          storage =
            (Util.of_option []
               (Util.option_bind (Xml.member "Storage" xml)
                  ValidStorageOptionsList.parse));
          valid_processor_features =
            (Util.of_option []
               (Util.option_bind (Xml.member "ValidProcessorFeatures" xml)
                  AvailableProcessorFeatureList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Storage"
                       ([], (ValidStorageOptionsList.to_xml [x])))) v.storage))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ValidProcessorFeatures"
                      ([], (AvailableProcessorFeatureList.to_xml [x]))))
              v.valid_processor_features))
  end[@@ocaml.doc
       "<p>Information about valid modifications that you can make to your DB instance. Contains the result of a successful call to the <code>DescribeValidDBInstanceModifications</code> action. You can use this information when you call <code>ModifyDBInstance</code>. </p>"]
module CustomAvailabilityZoneList =
  struct
    type t = CustomAvailabilityZone.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CustomAvailabilityZone.to_query v
    let to_headers v =
      Headers.to_headers_list CustomAvailabilityZone.to_headers v
    let to_json v = `List (List.map CustomAvailabilityZone.to_json v)
    let parse xml =
      Util.option_all
        (List.map CustomAvailabilityZone.parse
           (Xml.members "CustomAvailabilityZone" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (CustomAvailabilityZone.to_xml x)))
        v
  end
module CloudwatchLogsExportConfiguration =
  struct
    type t =
      {
      enable_log_types: LogTypeList.t
        [@ocaml.doc "<p>The list of log types to enable.</p>"];
      disable_log_types: LogTypeList.t
        [@ocaml.doc "<p>The list of log types to disable.</p>"]}[@@ocaml.doc
                                                                  "<p>The configuration setting for the log types to be enabled for export to CloudWatch Logs for a specific DB instance or DB cluster.</p> <p>The <code>EnableLogTypes</code> and <code>DisableLogTypes</code> arrays determine which logs will be exported (or not exported) to CloudWatch Logs. The values within these arrays depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs </a> in the <i>Amazon RDS User Guide</i>.</p>"]
    let make ?(enable_log_types= [])  ?(disable_log_types= [])  () =
      { enable_log_types; disable_log_types }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("disable_log_types",
                (LogTypeList.to_json v.disable_log_types));
           Some
             ("enable_log_types", (LogTypeList.to_json v.enable_log_types))])
    let parse xml =
      Some
        {
          enable_log_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "EnableLogTypes" xml)
                  LogTypeList.parse));
          disable_log_types =
            (Util.of_option []
               (Util.option_bind (Xml.member "DisableLogTypes" xml)
                  LogTypeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "EnableLogTypes"
                       ([], (LogTypeList.to_xml [x])))) v.enable_log_types))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DisableLogTypes"
                      ([], (LogTypeList.to_xml [x])))) v.disable_log_types))
  end[@@ocaml.doc
       "<p>The configuration setting for the log types to be enabled for export to CloudWatch Logs for a specific DB instance or DB cluster.</p> <p>The <code>EnableLogTypes</code> and <code>DisableLogTypes</code> arrays determine which logs will be exported (or not exported) to CloudWatch Logs. The values within these arrays depend on the DB engine being used. For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_LogAccess.html#USER_LogAccess.Procedural.UploadtoCloudWatch\">Publishing Database Logs to Amazon CloudWatch Logs </a> in the <i>Amazon RDS User Guide</i>.</p>"]
module ScalingConfiguration =
  struct
    type t =
      {
      min_capacity: Integer.t option
        [@ocaml.doc
          "<p>The minimum capacity for an Aurora DB cluster in <code>serverless</code> DB engine mode.</p> <p>For Aurora MySQL, valid capacity values are <code>1</code>, <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>128</code>, and <code>256</code>.</p> <p>For Aurora PostgreSQL, valid capacity values are <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>192</code>, and <code>384</code>.</p> <p>The minimum capacity must be less than or equal to the maximum capacity.</p>"];
      max_capacity: Integer.t option
        [@ocaml.doc
          "<p>The maximum capacity for an Aurora DB cluster in <code>serverless</code> DB engine mode.</p> <p>For Aurora MySQL, valid capacity values are <code>1</code>, <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>128</code>, and <code>256</code>.</p> <p>For Aurora PostgreSQL, valid capacity values are <code>2</code>, <code>4</code>, <code>8</code>, <code>16</code>, <code>32</code>, <code>64</code>, <code>192</code>, and <code>384</code>.</p> <p>The maximum capacity must be greater than or equal to the minimum capacity.</p>"];
      auto_pause: Boolean.t option
        [@ocaml.doc
          "<p>A value that indicates whether to allow or disallow automatic pause for an Aurora DB cluster in <code>serverless</code> DB engine mode. A DB cluster can be paused only when it's idle (it has no connections).</p> <note> <p>If a DB cluster is paused for more than seven days, the DB cluster might be backed up with a snapshot. In this case, the DB cluster is restored when there is a request to connect to it. </p> </note>"];
      seconds_until_auto_pause: Integer.t option
        [@ocaml.doc
          "<p>The time, in seconds, before an Aurora DB cluster in <code>serverless</code> mode is paused.</p>"];
      timeout_action: String.t option
        [@ocaml.doc
          "<p>The action to take when the timeout is reached, either <code>ForceApplyCapacityChange</code> or <code>RollbackCapacityChange</code>.</p> <p> <code>ForceApplyCapacityChange</code> sets the capacity to the specified value as soon as possible.</p> <p> <code>RollbackCapacityChange</code>, the default, ignores the capacity change if a scaling point isn't found in the timeout period.</p> <important> <p>If you specify <code>ForceApplyCapacityChange</code>, connections that prevent Aurora Serverless from finding a scaling point might be dropped.</p> </important> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.how-it-works.html#aurora-serverless.how-it-works.auto-scaling\"> Autoscaling for Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"]}
    [@@ocaml.doc
      "<p>Contains the scaling configuration of an Aurora Serverless DB cluster.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html\">Using Amazon Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"]
    let make ?min_capacity  ?max_capacity  ?auto_pause 
      ?seconds_until_auto_pause  ?timeout_action  () =
      {
        min_capacity;
        max_capacity;
        auto_pause;
        seconds_until_auto_pause;
        timeout_action
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timeout_action
              (fun f -> ("timeout_action", (String.to_json f)));
           Util.option_map v.seconds_until_auto_pause
             (fun f -> ("seconds_until_auto_pause", (Integer.to_json f)));
           Util.option_map v.auto_pause
             (fun f -> ("auto_pause", (Boolean.to_json f)));
           Util.option_map v.max_capacity
             (fun f -> ("max_capacity", (Integer.to_json f)));
           Util.option_map v.min_capacity
             (fun f -> ("min_capacity", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          min_capacity =
            (Util.option_bind (Xml.member "MinCapacity" xml) Integer.parse);
          max_capacity =
            (Util.option_bind (Xml.member "MaxCapacity" xml) Integer.parse);
          auto_pause =
            (Util.option_bind (Xml.member "AutoPause" xml) Boolean.parse);
          seconds_until_auto_pause =
            (Util.option_bind (Xml.member "SecondsUntilAutoPause" xml)
               Integer.parse);
          timeout_action =
            (Util.option_bind (Xml.member "TimeoutAction" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.min_capacity
                  (fun f ->
                     Ezxmlm.make_tag "MinCapacity" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.max_capacity
                 (fun f ->
                    Ezxmlm.make_tag "MaxCapacity" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.auto_pause
                (fun f ->
                   Ezxmlm.make_tag "AutoPause" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.seconds_until_auto_pause
               (fun f ->
                  Ezxmlm.make_tag "SecondsUntilAutoPause"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.timeout_action
              (fun f ->
                 Ezxmlm.make_tag "TimeoutAction" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Contains the scaling configuration of an Aurora Serverless DB cluster.</p> <p>For more information, see <a href=\"https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-serverless.html\">Using Amazon Aurora Serverless</a> in the <i>Amazon Aurora User Guide</i>.</p>"]
module EngineDefaults =
  struct
    type t =
      {
      d_b_parameter_group_family: String.t option
        [@ocaml.doc
          "<p>Specifies the name of the DB parameter group family that the engine default parameters apply to.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous EngineDefaults request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"];
      parameters: ParametersList.t
        [@ocaml.doc "<p>Contains a list of engine default parameters.</p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeEngineDefaultParameters</code> action. </p>"]
    let make ?d_b_parameter_group_family  ?marker  ?(parameters= [])  () =
      { d_b_parameter_group_family; marker; parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("parameters", (ParametersList.to_json v.parameters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.d_b_parameter_group_family
             (fun f -> ("d_b_parameter_group_family", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_parameter_group_family =
            (Util.option_bind (Xml.member "DBParameterGroupFamily" xml)
               String.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.d_b_parameter_group_family
                (fun f ->
                   Ezxmlm.make_tag "DBParameterGroupFamily"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Parameters"
                      ([], (ParametersList.to_xml [x])))) v.parameters))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeEngineDefaultParameters</code> action. </p>"]
module DBClusterEndpointList =
  struct
    type t = DBClusterEndpoint.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBClusterEndpoint.to_query v
    let to_headers v = Headers.to_headers_list DBClusterEndpoint.to_headers v
    let to_json v = `List (List.map DBClusterEndpoint.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterEndpoint.parse
           (Xml.members "DBClusterEndpointList" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBClusterEndpoint.to_xml x)))
        v
  end
module EventSubscriptionsList =
  struct
    type t = EventSubscription.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EventSubscription.to_query v
    let to_headers v = Headers.to_headers_list EventSubscription.to_headers v
    let to_json v = `List (List.map EventSubscription.to_json v)
    let parse xml =
      Util.option_all
        (List.map EventSubscription.parse
           (Xml.members "EventSubscription" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (EventSubscription.to_xml x)))
        v
  end
module OptionConfigurationList =
  struct
    type t = OptionConfiguration.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list OptionConfiguration.to_headers v
    let to_json v = `List (List.map OptionConfiguration.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionConfiguration.parse
           (Xml.members "OptionConfiguration" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (OptionConfiguration.to_xml x))) v
  end
module OptionNamesList =
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
module ReservedDBInstanceList =
  struct
    type t = ReservedDBInstance.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReservedDBInstance.to_query v
    let to_headers v =
      Headers.to_headers_list ReservedDBInstance.to_headers v
    let to_json v = `List (List.map ReservedDBInstance.to_json v)
    let parse xml =
      Util.option_all
        (List.map ReservedDBInstance.parse
           (Xml.members "ReservedDBInstance" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (ReservedDBInstance.to_xml x))) v
  end
module DBClusterSnapshotAttributesResult =
  struct
    type t =
      {
      d_b_cluster_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the manual DB cluster snapshot that the attributes apply to.</p>"];
      d_b_cluster_snapshot_attributes: DBClusterSnapshotAttributeList.t
        [@ocaml.doc
          "<p>The list of attributes and values for the manual DB cluster snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Contains the results of a successful call to the <code>DescribeDBClusterSnapshotAttributes</code> API action.</p> <p>Manual DB cluster snapshot attributes are used to authorize other AWS accounts to copy or restore a manual DB cluster snapshot. For more information, see the <code>ModifyDBClusterSnapshotAttribute</code> API action.</p>"]
    let make ?d_b_cluster_snapshot_identifier 
      ?(d_b_cluster_snapshot_attributes= [])  () =
      { d_b_cluster_snapshot_identifier; d_b_cluster_snapshot_attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_snapshot_attributes",
                (DBClusterSnapshotAttributeList.to_json
                   v.d_b_cluster_snapshot_attributes));
           Util.option_map v.d_b_cluster_snapshot_identifier
             (fun f ->
                ("d_b_cluster_snapshot_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot_identifier =
            (Util.option_bind (Xml.member "DBClusterSnapshotIdentifier" xml)
               String.parse);
          d_b_cluster_snapshot_attributes =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "DBClusterSnapshotAttributes" xml)
                  DBClusterSnapshotAttributeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.d_b_cluster_snapshot_identifier
               (fun f ->
                  Ezxmlm.make_tag "DBClusterSnapshotIdentifier"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusterSnapshotAttributes"
                      ([], (DBClusterSnapshotAttributeList.to_xml [x]))))
              v.d_b_cluster_snapshot_attributes))
  end[@@ocaml.doc
       "<p>Contains the results of a successful call to the <code>DescribeDBClusterSnapshotAttributes</code> API action.</p> <p>Manual DB cluster snapshot attributes are used to authorize other AWS accounts to copy or restore a manual DB cluster snapshot. For more information, see the <code>ModifyDBClusterSnapshotAttribute</code> API action.</p>"]
module PendingMaintenanceActions =
  struct
    type t = ResourcePendingMaintenanceActions.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ResourcePendingMaintenanceActions.to_query v
    let to_headers v =
      Headers.to_headers_list ResourcePendingMaintenanceActions.to_headers v
    let to_json v =
      `List (List.map ResourcePendingMaintenanceActions.to_json v)
    let parse xml =
      Util.option_all
        (List.map ResourcePendingMaintenanceActions.parse
           (Xml.members "ResourcePendingMaintenanceActions" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ResourcePendingMaintenanceActions.to_xml x))) v
  end
module DBSubnetGroups =
  struct
    type t = DBSubnetGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBSubnetGroup.to_query v
    let to_headers v = Headers.to_headers_list DBSubnetGroup.to_headers v
    let to_json v = `List (List.map DBSubnetGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBSubnetGroup.parse (Xml.members "DBSubnetGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBSubnetGroup.to_xml x))) v
  end
module TargetGroupList =
  struct
    type t = DBProxyTargetGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBProxyTargetGroup.to_query v
    let to_headers v =
      Headers.to_headers_list DBProxyTargetGroup.to_headers v
    let to_json v = `List (List.map DBProxyTargetGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBProxyTargetGroup.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (DBProxyTargetGroup.to_xml x))) v
  end
module TargetList =
  struct
    type t = DBProxyTarget.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBProxyTarget.to_query v
    let to_headers v = Headers.to_headers_list DBProxyTarget.to_headers v
    let to_json v = `List (List.map DBProxyTarget.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBProxyTarget.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBProxyTarget.to_xml x))) v
  end
module DBEngineVersionList =
  struct
    type t = DBEngineVersion.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBEngineVersion.to_query v
    let to_headers v = Headers.to_headers_list DBEngineVersion.to_headers v
    let to_json v = `List (List.map DBEngineVersion.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBEngineVersion.parse (Xml.members "DBEngineVersion" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBEngineVersion.to_xml x)))
        v
  end
module DBSnapshotList =
  struct
    type t = DBSnapshot.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBSnapshot.to_query v
    let to_headers v = Headers.to_headers_list DBSnapshot.to_headers v
    let to_json v = `List (List.map DBSnapshot.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBSnapshot.parse (Xml.members "DBSnapshot" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBSnapshot.to_xml x))) v
  end
module DBSnapshotAttributesResult =
  struct
    type t =
      {
      d_b_snapshot_identifier: String.t option
        [@ocaml.doc
          "<p>The identifier of the manual DB snapshot that the attributes apply to.</p>"];
      d_b_snapshot_attributes: DBSnapshotAttributeList.t
        [@ocaml.doc
          "<p>The list of attributes and values for the manual DB snapshot.</p>"]}
    [@@ocaml.doc
      "<p>Contains the results of a successful call to the <code>DescribeDBSnapshotAttributes</code> API action.</p> <p>Manual DB snapshot attributes are used to authorize other AWS accounts to copy or restore a manual DB snapshot. For more information, see the <code>ModifyDBSnapshotAttribute</code> API action.</p>"]
    let make ?d_b_snapshot_identifier  ?(d_b_snapshot_attributes= [])  () =
      { d_b_snapshot_identifier; d_b_snapshot_attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_snapshot_attributes",
                (DBSnapshotAttributeList.to_json v.d_b_snapshot_attributes));
           Util.option_map v.d_b_snapshot_identifier
             (fun f -> ("d_b_snapshot_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot_identifier =
            (Util.option_bind (Xml.member "DBSnapshotIdentifier" xml)
               String.parse);
          d_b_snapshot_attributes =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSnapshotAttributes" xml)
                  DBSnapshotAttributeList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.d_b_snapshot_identifier
               (fun f ->
                  Ezxmlm.make_tag "DBSnapshotIdentifier"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBSnapshotAttributes"
                      ([], (DBSnapshotAttributeList.to_xml [x]))))
              v.d_b_snapshot_attributes))
  end[@@ocaml.doc
       "<p>Contains the results of a successful call to the <code>DescribeDBSnapshotAttributes</code> API action.</p> <p>Manual DB snapshot attributes are used to authorize other AWS accounts to copy or restore a manual DB snapshot. For more information, see the <code>ModifyDBSnapshotAttribute</code> API action.</p>"]
module EventCategoriesMapList =
  struct
    type t = EventCategoriesMap.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EventCategoriesMap.to_query v
    let to_headers v =
      Headers.to_headers_list EventCategoriesMap.to_headers v
    let to_json v = `List (List.map EventCategoriesMap.to_json v)
    let parse xml =
      Util.option_all
        (List.map EventCategoriesMap.parse
           (Xml.members "EventCategoriesMap" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (EventCategoriesMap.to_xml x))) v
  end
module DBProxyList =
  struct
    type t = DBProxy.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBProxy.to_query v
    let to_headers v = Headers.to_headers_list DBProxy.to_headers v
    let to_json v = `List (List.map DBProxy.to_json v)
    let parse xml =
      Util.option_all (List.map DBProxy.parse (Xml.members "member" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (DBProxy.to_xml x))) v
  end
module DBInstanceList =
  struct
    type t = DBInstance.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBInstance.to_query v
    let to_headers v = Headers.to_headers_list DBInstance.to_headers v
    let to_json v = `List (List.map DBInstance.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBInstance.parse (Xml.members "DBInstance" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBInstance.to_xml x))) v
  end
module InstallationMediaList =
  struct
    type t = InstallationMedia.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstallationMedia.to_query v
    let to_headers v = Headers.to_headers_list InstallationMedia.to_headers v
    let to_json v = `List (List.map InstallationMedia.to_json v)
    let parse xml =
      Util.option_all
        (List.map InstallationMedia.parse
           (Xml.members "InstallationMedia" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (InstallationMedia.to_xml x)))
        v
  end
module AccountQuotaList =
  struct
    type t = AccountQuota.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AccountQuota.to_query v
    let to_headers v = Headers.to_headers_list AccountQuota.to_headers v
    let to_json v = `List (List.map AccountQuota.to_json v)
    let parse xml =
      Util.option_all
        (List.map AccountQuota.parse (Xml.members "AccountQuota" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (AccountQuota.to_xml x))) v
  end
module GlobalClusterList =
  struct
    type t = GlobalCluster.t list
    let make elems () = elems
    let to_query v = Query.to_query_list GlobalCluster.to_query v
    let to_headers v = Headers.to_headers_list GlobalCluster.to_headers v
    let to_json v = `List (List.map GlobalCluster.to_json v)
    let parse xml =
      Util.option_all
        (List.map GlobalCluster.parse (Xml.members "GlobalClusterMember" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (GlobalCluster.to_xml x))) v
  end
module DBInstanceAutomatedBackupList =
  struct
    type t = DBInstanceAutomatedBackup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBInstanceAutomatedBackup.to_query v
    let to_headers v =
      Headers.to_headers_list DBInstanceAutomatedBackup.to_headers v
    let to_json v = `List (List.map DBInstanceAutomatedBackup.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBInstanceAutomatedBackup.parse
           (Xml.members "DBInstanceAutomatedBackup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (DBInstanceAutomatedBackup.to_xml x))) v
  end
module DBClusterParameterGroupList =
  struct
    type t = DBClusterParameterGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBClusterParameterGroup.to_query v
    let to_headers v =
      Headers.to_headers_list DBClusterParameterGroup.to_headers v
    let to_json v = `List (List.map DBClusterParameterGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterParameterGroup.parse
           (Xml.members "DBClusterParameterGroup" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (DBClusterParameterGroup.to_xml x)))
        v
  end
module DescribeDBLogFilesList =
  struct
    type t = DescribeDBLogFilesDetails.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DescribeDBLogFilesDetails.to_query v
    let to_headers v =
      Headers.to_headers_list DescribeDBLogFilesDetails.to_headers v
    let to_json v = `List (List.map DescribeDBLogFilesDetails.to_json v)
    let parse xml =
      Util.option_all
        (List.map DescribeDBLogFilesDetails.parse
           (Xml.members "DescribeDBLogFilesDetails" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (DescribeDBLogFilesDetails.to_xml x))) v
  end
module EngineFamily =
  struct
    type t =
      | MYSQL 
    let str_to_t = [("MYSQL", MYSQL)]
    let t_to_str = [(MYSQL, "MYSQL")]
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
module UserAuthConfigList =
  struct
    type t = UserAuthConfig.t list
    let make elems () = elems
    let to_query v = Query.to_query_list UserAuthConfig.to_query v
    let to_headers v = Headers.to_headers_list UserAuthConfig.to_headers v
    let to_json v = `List (List.map UserAuthConfig.to_json v)
    let parse xml =
      Util.option_all
        (List.map UserAuthConfig.parse (Xml.members "member" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (UserAuthConfig.to_xml x))) v
  end
module DBParameterGroupList =
  struct
    type t = DBParameterGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBParameterGroup.to_query v
    let to_headers v = Headers.to_headers_list DBParameterGroup.to_headers v
    let to_json v = `List (List.map DBParameterGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBParameterGroup.parse (Xml.members "DBParameterGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBParameterGroup.to_xml x)))
        v
  end
module EventList =
  struct
    type t = Event.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Event.to_query v
    let to_headers v = Headers.to_headers_list Event.to_headers v
    let to_json v = `List (List.map Event.to_json v)
    let parse xml =
      Util.option_all (List.map Event.parse (Xml.members "Event" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Event.to_xml x))) v
  end
module CertificateList =
  struct
    type t = Certificate.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Certificate.to_query v
    let to_headers v = Headers.to_headers_list Certificate.to_headers v
    let to_json v = `List (List.map Certificate.to_json v)
    let parse xml =
      Util.option_all
        (List.map Certificate.parse (Xml.members "Certificate" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (Certificate.to_xml x))) v
  end
module OptionGroupsList =
  struct
    type t = OptionGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OptionGroup.to_query v
    let to_headers v = Headers.to_headers_list OptionGroup.to_headers v
    let to_json v = `List (List.map OptionGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map OptionGroup.parse (Xml.members "OptionGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (OptionGroup.to_xml x))) v
  end
module OrderableDBInstanceOptionsList =
  struct
    type t = OrderableDBInstanceOption.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OrderableDBInstanceOption.to_query v
    let to_headers v =
      Headers.to_headers_list OrderableDBInstanceOption.to_headers v
    let to_json v = `List (List.map OrderableDBInstanceOption.to_json v)
    let parse xml =
      Util.option_all
        (List.map OrderableDBInstanceOption.parse
           (Xml.members "OrderableDBInstanceOption" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (OrderableDBInstanceOption.to_xml x))) v
  end
module KeyList =
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
module SourceRegionList =
  struct
    type t = SourceRegion.t list
    let make elems () = elems
    let to_query v = Query.to_query_list SourceRegion.to_query v
    let to_headers v = Headers.to_headers_list SourceRegion.to_headers v
    let to_json v = `List (List.map SourceRegion.to_json v)
    let parse xml =
      Util.option_all
        (List.map SourceRegion.parse (Xml.members "SourceRegion" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (SourceRegion.to_xml x))) v
  end
module DBClusterSnapshotList =
  struct
    type t = DBClusterSnapshot.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBClusterSnapshot.to_query v
    let to_headers v = Headers.to_headers_list DBClusterSnapshot.to_headers v
    let to_json v = `List (List.map DBClusterSnapshot.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterSnapshot.parse
           (Xml.members "DBClusterSnapshot" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBClusterSnapshot.to_xml x)))
        v
  end
module ReservedDBInstancesOfferingList =
  struct
    type t = ReservedDBInstancesOffering.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ReservedDBInstancesOffering.to_query v
    let to_headers v =
      Headers.to_headers_list ReservedDBInstancesOffering.to_headers v
    let to_json v = `List (List.map ReservedDBInstancesOffering.to_json v)
    let parse xml =
      Util.option_all
        (List.map ReservedDBInstancesOffering.parse
           (Xml.members "ReservedDBInstancesOffering" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member"
             ([], (ReservedDBInstancesOffering.to_xml x))) v
  end
module DBClusterBacktrackList =
  struct
    type t = DBClusterBacktrack.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBClusterBacktrack.to_query v
    let to_headers v =
      Headers.to_headers_list DBClusterBacktrack.to_headers v
    let to_json v = `List (List.map DBClusterBacktrack.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBClusterBacktrack.parse
           (Xml.members "DBClusterBacktrack" xml))
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (DBClusterBacktrack.to_xml x))) v
  end
module DBClusterList =
  struct
    type t = DBCluster.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBCluster.to_query v
    let to_headers v = Headers.to_headers_list DBCluster.to_headers v
    let to_json v = `List (List.map DBCluster.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBCluster.parse (Xml.members "DBCluster" xml))
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (DBCluster.to_xml x)))
        v
  end
module DBSecurityGroups =
  struct
    type t = DBSecurityGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DBSecurityGroup.to_query v
    let to_headers v = Headers.to_headers_list DBSecurityGroup.to_headers v
    let to_json v = `List (List.map DBSecurityGroup.to_json v)
    let parse xml =
      Util.option_all
        (List.map DBSecurityGroup.parse (Xml.members "DBSecurityGroup" xml))
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (DBSecurityGroup.to_xml x)))
        v
  end
module ModifyDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module ModifyEventSubscriptionResult =
  struct
    type t = {
      event_subscription: EventSubscription.t option }
    let make ?event_subscription  () = { event_subscription }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.event_subscription
              (fun f -> ("event_subscription", (EventSubscription.to_json f)))])
    let parse xml =
      Some
        {
          event_subscription =
            (Util.option_bind (Xml.member "EventSubscription" xml)
               EventSubscription.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.event_subscription
              (fun f ->
                 Ezxmlm.make_tag "EventSubscription"
                   ([], (EventSubscription.to_xml f)))])
  end
module FailoverDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module CreateDBProxyResponse =
  struct
    type t =
      {
      d_b_proxy: DBProxy.t option
        [@ocaml.doc
          "<p>The <code>DBProxy</code> structure corresponding to the new proxy.</p>"]}
    let make ?d_b_proxy  () = { d_b_proxy }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_proxy
              (fun f -> ("d_b_proxy", (DBProxy.to_json f)))])
    let parse xml =
      Some
        {
          d_b_proxy =
            (Util.option_bind (Xml.member "DBProxy" xml) DBProxy.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_proxy
              (fun f -> Ezxmlm.make_tag "DBProxy" ([], (DBProxy.to_xml f)))])
  end
module OptionGroupOptionsMessage =
  struct
    type t =
      {
      option_group_options: OptionGroupOptionsList.t ;
      marker: String.t option
        [@ocaml.doc
          "<p>An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?(option_group_options= [])  ?marker  () =
      { option_group_options; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some
             ("option_group_options",
               (OptionGroupOptionsList.to_json v.option_group_options))])
    let parse xml =
      Some
        {
          option_group_options =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionGroupOptions" xml)
                  OptionGroupOptionsList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "OptionGroupOptions"
                       ([], (OptionGroupOptionsList.to_xml [x]))))
               v.option_group_options))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module StartDBInstanceResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module DeleteDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module StopActivityStreamResponse =
  struct
    type t =
      {
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier used for encrypting messages in the database activity stream.</p>"];
      kinesis_stream_name: String.t option
        [@ocaml.doc
          "<p>The name of the Amazon Kinesis data stream used for the database activity stream.</p>"];
      status: ActivityStreamStatus.t option
        [@ocaml.doc "<p>The status of the database activity stream.</p>"]}
    let make ?kms_key_id  ?kinesis_stream_name  ?status  () =
      { kms_key_id; kinesis_stream_name; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (ActivityStreamStatus.to_json f)));
           Util.option_map v.kinesis_stream_name
             (fun f -> ("kinesis_stream_name", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          kinesis_stream_name =
            (Util.option_bind (Xml.member "KinesisStreamName" xml)
               String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               ActivityStreamStatus.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.kms_key_id
                (fun f -> Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.kinesis_stream_name
               (fun f ->
                  Ezxmlm.make_tag "KinesisStreamName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (ActivityStreamStatus.to_xml f)))])
  end
module CreateDBSnapshotResult =
  struct
    type t = {
      d_b_snapshot: DBSnapshot.t option }
    let make ?d_b_snapshot  () = { d_b_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot
              (fun f -> ("d_b_snapshot", (DBSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot =
            (Util.option_bind (Xml.member "DBSnapshot" xml) DBSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshot" ([], (DBSnapshot.to_xml f)))])
  end
module CopyDBClusterParameterGroupResult =
  struct
    type t = {
      d_b_cluster_parameter_group: DBClusterParameterGroup.t option }
    let make ?d_b_cluster_parameter_group  () =
      { d_b_cluster_parameter_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_parameter_group
              (fun f ->
                 ("d_b_cluster_parameter_group",
                   (DBClusterParameterGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_parameter_group =
            (Util.option_bind (Xml.member "DBClusterParameterGroup" xml)
               DBClusterParameterGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_parameter_group
              (fun f ->
                 Ezxmlm.make_tag "DBClusterParameterGroup"
                   ([], (DBClusterParameterGroup.to_xml f)))])
  end
module DescribeValidDBInstanceModificationsResult =
  struct
    type t =
      {
      valid_d_b_instance_modifications_message:
        ValidDBInstanceModificationsMessage.t option }
    let make ?valid_d_b_instance_modifications_message  () =
      { valid_d_b_instance_modifications_message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.valid_d_b_instance_modifications_message
              (fun f ->
                 ("valid_d_b_instance_modifications_message",
                   (ValidDBInstanceModificationsMessage.to_json f)))])
    let parse xml =
      Some
        {
          valid_d_b_instance_modifications_message =
            (Util.option_bind
               (Xml.member "ValidDBInstanceModificationsMessage" xml)
               ValidDBInstanceModificationsMessage.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.valid_d_b_instance_modifications_message
              (fun f ->
                 Ezxmlm.make_tag "ValidDBInstanceModificationsMessage"
                   ([], (ValidDBInstanceModificationsMessage.to_xml f)))])
  end
module CreateDBInstanceReadReplicaResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module AddSourceIdentifierToSubscriptionResult =
  struct
    type t = {
      event_subscription: EventSubscription.t option }
    let make ?event_subscription  () = { event_subscription }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.event_subscription
              (fun f -> ("event_subscription", (EventSubscription.to_json f)))])
    let parse xml =
      Some
        {
          event_subscription =
            (Util.option_bind (Xml.member "EventSubscription" xml)
               EventSubscription.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.event_subscription
              (fun f ->
                 Ezxmlm.make_tag "EventSubscription"
                   ([], (EventSubscription.to_xml f)))])
  end
module DescribeAccountAttributesMessage =
  struct
    type t = unit[@@ocaml.doc "<p/>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end[@@ocaml.doc "<p/>"]
module TagListMessage =
  struct
    type t =
      {
      tag_list: TagList.t
        [@ocaml.doc
          "<p>List of tags returned by the ListTagsForResource operation.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?(tag_list= [])  () = { tag_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_list", (TagList.to_json v.tag_list))])
    let parse xml =
      Some
        {
          tag_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "TagList" xml) TagList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagList" ([], (TagList.to_xml [x]))))
              v.tag_list))
  end[@@ocaml.doc "<p/>"]
module CustomAvailabilityZoneMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>An optional pagination token provided by a previous <code>DescribeCustomAvailabilityZones</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      custom_availability_zones: CustomAvailabilityZoneList.t
        [@ocaml.doc
          "<p>The list of <a>CustomAvailabilityZone</a> objects for the AWS account.</p>"]}
    let make ?marker  ?(custom_availability_zones= [])  () =
      { marker; custom_availability_zones }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("custom_availability_zones",
                (CustomAvailabilityZoneList.to_json
                   v.custom_availability_zones));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          custom_availability_zones =
            (Util.of_option []
               (Util.option_bind (Xml.member "CustomAvailabilityZones" xml)
                  CustomAvailabilityZoneList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CustomAvailabilityZones"
                      ([], (CustomAvailabilityZoneList.to_xml [x]))))
              v.custom_availability_zones))
  end
module DeleteDBClusterSnapshotResult =
  struct
    type t = {
      d_b_cluster_snapshot: DBClusterSnapshot.t option }
    let make ?d_b_cluster_snapshot  () = { d_b_cluster_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_snapshot
              (fun f ->
                 ("d_b_cluster_snapshot", (DBClusterSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot =
            (Util.option_bind (Xml.member "DBClusterSnapshot" xml)
               DBClusterSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBClusterSnapshot"
                   ([], (DBClusterSnapshot.to_xml f)))])
  end
module CreateDBInstanceResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module DBClusterParameterGroupNameMessage =
  struct
    type t =
      {
      d_b_cluster_parameter_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the DB cluster parameter group.</p> <p>Constraints:</p> <ul> <li> <p>Must be 1 to 255 letters or numbers.</p> </li> <li> <p>First character must be a letter</p> </li> <li> <p>Can't end with a hyphen or contain two consecutive hyphens</p> </li> </ul> <note> <p>This value is stored as a lowercase string.</p> </note>"]}
    [@@ocaml.doc "<p/>"]
    let make ?d_b_cluster_parameter_group_name  () =
      { d_b_cluster_parameter_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_parameter_group_name
              (fun f ->
                 ("d_b_cluster_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_parameter_group_name =
            (Util.option_bind (Xml.member "DBClusterParameterGroupName" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_parameter_group_name
              (fun f ->
                 Ezxmlm.make_tag "DBClusterParameterGroupName"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p/>"]
module RemoveFromGlobalClusterResult =
  struct
    type t = {
      global_cluster: GlobalCluster.t option }
    let make ?global_cluster  () = { global_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.global_cluster
              (fun f -> ("global_cluster", (GlobalCluster.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster =
            (Util.option_bind (Xml.member "GlobalCluster" xml)
               GlobalCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.global_cluster
              (fun f ->
                 Ezxmlm.make_tag "GlobalCluster"
                   ([], (GlobalCluster.to_xml f)))])
  end
module CreateDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module DescribeEngineDefaultParametersResult =
  struct
    type t = {
      engine_defaults: EngineDefaults.t }
    let make ~engine_defaults  () = { engine_defaults }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("engine_defaults", (EngineDefaults.to_json v.engine_defaults))])
    let parse xml =
      Some
        {
          engine_defaults =
            (Xml.required "EngineDefaults"
               (Util.option_bind (Xml.member "EngineDefaults" xml)
                  EngineDefaults.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "EngineDefaults"
                 ([], (EngineDefaults.to_xml v.engine_defaults)))])
  end
module DBClusterEndpointMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeDBClusterEndpoints</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_cluster_endpoints: DBClusterEndpointList.t
        [@ocaml.doc
          "<p>Contains the details of the endpoints associated with the cluster and matching any filter conditions.</p>"]}
    let make ?marker  ?(d_b_cluster_endpoints= [])  () =
      { marker; d_b_cluster_endpoints }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_endpoints",
                (DBClusterEndpointList.to_json v.d_b_cluster_endpoints));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_cluster_endpoints =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusterEndpoints" xml)
                  DBClusterEndpointList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusterEndpoints"
                      ([], (DBClusterEndpointList.to_xml [x]))))
              v.d_b_cluster_endpoints))
  end
module EventSubscriptionsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous DescribeOrderableDBInstanceOptions request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      event_subscriptions_list: EventSubscriptionsList.t
        [@ocaml.doc "<p>A list of EventSubscriptions data types.</p>"]}
    [@@ocaml.doc
      "<p>Data returned by the <b>DescribeEventSubscriptions</b> action.</p>"]
    let make ?marker  ?(event_subscriptions_list= [])  () =
      { marker; event_subscriptions_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_subscriptions_list",
                (EventSubscriptionsList.to_json v.event_subscriptions_list));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          event_subscriptions_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "EventSubscriptionsList" xml)
                  EventSubscriptionsList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "EventSubscriptionsList"
                      ([], (EventSubscriptionsList.to_xml [x]))))
              v.event_subscriptions_list))
  end[@@ocaml.doc
       "<p>Data returned by the <b>DescribeEventSubscriptions</b> action.</p>"]
module ReservedDBInstanceMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      reserved_d_b_instances: ReservedDBInstanceList.t
        [@ocaml.doc "<p>A list of reserved DB instances.</p>"]}[@@ocaml.doc
                                                                 "<p> Contains the result of a successful invocation of the <code>DescribeReservedDBInstances</code> action. </p>"]
    let make ?marker  ?(reserved_d_b_instances= [])  () =
      { marker; reserved_d_b_instances }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_d_b_instances",
                (ReservedDBInstanceList.to_json v.reserved_d_b_instances));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          reserved_d_b_instances =
            (Util.of_option []
               (Util.option_bind (Xml.member "ReservedDBInstances" xml)
                  ReservedDBInstanceList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ReservedDBInstances"
                      ([], (ReservedDBInstanceList.to_xml [x]))))
              v.reserved_d_b_instances))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeReservedDBInstances</code> action. </p>"]
module DBParameterGroupDetails =
  struct
    type t =
      {
      parameters: ParametersList.t
        [@ocaml.doc "<p> A list of <code>Parameter</code> values. </p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBParameters</code> action. </p>"]
    let make ?(parameters= [])  ?marker  () = { parameters; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some ("parameters", (ParametersList.to_json v.parameters))])
    let parse xml =
      Some
        {
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Parameters"
                       ([], (ParametersList.to_xml [x])))) v.parameters))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBParameters</code> action. </p>"]
module DeleteGlobalClusterResult =
  struct
    type t = {
      global_cluster: GlobalCluster.t option }
    let make ?global_cluster  () = { global_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.global_cluster
              (fun f -> ("global_cluster", (GlobalCluster.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster =
            (Util.option_bind (Xml.member "GlobalCluster" xml)
               GlobalCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.global_cluster
              (fun f ->
                 Ezxmlm.make_tag "GlobalCluster"
                   ([], (GlobalCluster.to_xml f)))])
  end
module ApplyPendingMaintenanceActionResult =
  struct
    type t =
      {
      resource_pending_maintenance_actions:
        ResourcePendingMaintenanceActions.t option }
    let make ?resource_pending_maintenance_actions  () =
      { resource_pending_maintenance_actions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource_pending_maintenance_actions
              (fun f ->
                 ("resource_pending_maintenance_actions",
                   (ResourcePendingMaintenanceActions.to_json f)))])
    let parse xml =
      Some
        {
          resource_pending_maintenance_actions =
            (Util.option_bind
               (Xml.member "ResourcePendingMaintenanceActions" xml)
               ResourcePendingMaintenanceActions.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.resource_pending_maintenance_actions
              (fun f ->
                 Ezxmlm.make_tag "ResourcePendingMaintenanceActions"
                   ([], (ResourcePendingMaintenanceActions.to_xml f)))])
  end
module ModifyDBSubnetGroupResult =
  struct
    type t = {
      d_b_subnet_group: DBSubnetGroup.t option }
    let make ?d_b_subnet_group  () = { d_b_subnet_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_subnet_group
              (fun f -> ("d_b_subnet_group", (DBSubnetGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_subnet_group =
            (Util.option_bind (Xml.member "DBSubnetGroup" xml)
               DBSubnetGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_subnet_group
              (fun f ->
                 Ezxmlm.make_tag "DBSubnetGroup"
                   ([], (DBSubnetGroup.to_xml f)))])
  end
module CreateDBClusterSnapshotResult =
  struct
    type t = {
      d_b_cluster_snapshot: DBClusterSnapshot.t option }
    let make ?d_b_cluster_snapshot  () = { d_b_cluster_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_snapshot
              (fun f ->
                 ("d_b_cluster_snapshot", (DBClusterSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot =
            (Util.option_bind (Xml.member "DBClusterSnapshot" xml)
               DBClusterSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBClusterSnapshot"
                   ([], (DBClusterSnapshot.to_xml f)))])
  end
module ModifyDBProxyResponse =
  struct
    type t =
      {
      d_b_proxy: DBProxy.t option
        [@ocaml.doc
          "<p>The <code>DBProxy</code> object representing the new settings for the proxy.</p>"]}
    let make ?d_b_proxy  () = { d_b_proxy }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_proxy
              (fun f -> ("d_b_proxy", (DBProxy.to_json f)))])
    let parse xml =
      Some
        {
          d_b_proxy =
            (Util.option_bind (Xml.member "DBProxy" xml) DBProxy.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_proxy
              (fun f -> Ezxmlm.make_tag "DBProxy" ([], (DBProxy.to_xml f)))])
  end
module DeleteDBProxyResponse =
  struct
    type t =
      {
      d_b_proxy: DBProxy.t option
        [@ocaml.doc
          "<p>The data structure representing the details of the DB proxy that you delete.</p>"]}
    let make ?d_b_proxy  () = { d_b_proxy }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_proxy
              (fun f -> ("d_b_proxy", (DBProxy.to_json f)))])
    let parse xml =
      Some
        {
          d_b_proxy =
            (Util.option_bind (Xml.member "DBProxy" xml) DBProxy.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_proxy
              (fun f -> Ezxmlm.make_tag "DBProxy" ([], (DBProxy.to_xml f)))])
  end
module DescribeDBClusterSnapshotAttributesResult =
  struct
    type t =
      {
      d_b_cluster_snapshot_attributes_result:
        DBClusterSnapshotAttributesResult.t option }
    let make ?d_b_cluster_snapshot_attributes_result  () =
      { d_b_cluster_snapshot_attributes_result }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_snapshot_attributes_result
              (fun f ->
                 ("d_b_cluster_snapshot_attributes_result",
                   (DBClusterSnapshotAttributesResult.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot_attributes_result =
            (Util.option_bind
               (Xml.member "DBClusterSnapshotAttributesResult" xml)
               DBClusterSnapshotAttributesResult.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_snapshot_attributes_result
              (fun f ->
                 Ezxmlm.make_tag "DBClusterSnapshotAttributesResult"
                   ([], (DBClusterSnapshotAttributesResult.to_xml f)))])
  end
module PendingMaintenanceActionsMessage =
  struct
    type t =
      {
      pending_maintenance_actions: PendingMaintenanceActions.t
        [@ocaml.doc
          "<p>A list of the pending maintenance actions for the resource.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribePendingMaintenanceActions</code> request. If this parameter is specified, the response includes only records beyond the marker, up to a number of records specified by <code>MaxRecords</code>. </p>"]}
    [@@ocaml.doc
      "<p>Data returned from the <b>DescribePendingMaintenanceActions</b> action.</p>"]
    let make ?(pending_maintenance_actions= [])  ?marker  () =
      { pending_maintenance_actions; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some
             ("pending_maintenance_actions",
               (PendingMaintenanceActions.to_json
                  v.pending_maintenance_actions))])
    let parse xml =
      Some
        {
          pending_maintenance_actions =
            (Util.of_option []
               (Util.option_bind (Xml.member "PendingMaintenanceActions" xml)
                  PendingMaintenanceActions.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "PendingMaintenanceActions"
                       ([], (PendingMaintenanceActions.to_xml [x]))))
               v.pending_maintenance_actions))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Data returned from the <b>DescribePendingMaintenanceActions</b> action.</p>"]
module DBSubnetGroupMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_subnet_groups: DBSubnetGroups.t
        [@ocaml.doc
          "<p> A list of <code>DBSubnetGroup</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBSubnetGroups</code> action. </p>"]
    let make ?marker  ?(d_b_subnet_groups= [])  () =
      { marker; d_b_subnet_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_subnet_groups",
                (DBSubnetGroups.to_json v.d_b_subnet_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_subnet_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSubnetGroups" xml)
                  DBSubnetGroups.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBSubnetGroups"
                      ([], (DBSubnetGroups.to_xml [x])))) v.d_b_subnet_groups))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBSubnetGroups</code> action. </p>"]
module CreateDBParameterGroupResult =
  struct
    type t = {
      d_b_parameter_group: DBParameterGroup.t option }
    let make ?d_b_parameter_group  () = { d_b_parameter_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_parameter_group
              (fun f -> ("d_b_parameter_group", (DBParameterGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_parameter_group =
            (Util.option_bind (Xml.member "DBParameterGroup" xml)
               DBParameterGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_parameter_group
              (fun f ->
                 Ezxmlm.make_tag "DBParameterGroup"
                   ([], (DBParameterGroup.to_xml f)))])
  end
module DescribeDBProxyTargetGroupsResponse =
  struct
    type t =
      {
      target_groups: TargetGroupList.t
        [@ocaml.doc
          "<p>An arbitrary number of <code>DBProxyTargetGroup</code> objects, containing details of the corresponding target groups.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    let make ?(target_groups= [])  ?marker  () = { target_groups; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some ("target_groups", (TargetGroupList.to_json v.target_groups))])
    let parse xml =
      Some
        {
          target_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "TargetGroups" xml)
                  TargetGroupList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TargetGroups"
                       ([], (TargetGroupList.to_xml [x])))) v.target_groups))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end
module RestoreDBClusterFromS3Result =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module RegisterDBProxyTargetsResponse =
  struct
    type t =
      {
      d_b_proxy_targets: TargetList.t
        [@ocaml.doc
          "<p>One or more <code>DBProxyTarget</code> objects that are created when you register targets with a target group.</p>"]}
    let make ?(d_b_proxy_targets= [])  () = { d_b_proxy_targets }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_proxy_targets", (TargetList.to_json v.d_b_proxy_targets))])
    let parse xml =
      Some
        {
          d_b_proxy_targets =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBProxyTargets" xml)
                  TargetList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBProxyTargets"
                      ([], (TargetList.to_xml [x])))) v.d_b_proxy_targets))
  end
module DeleteDBInstanceAutomatedBackupResult =
  struct
    type t =
      {
      d_b_instance_automated_backup: DBInstanceAutomatedBackup.t option }
    let make ?d_b_instance_automated_backup  () =
      { d_b_instance_automated_backup }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance_automated_backup
              (fun f ->
                 ("d_b_instance_automated_backup",
                   (DBInstanceAutomatedBackup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance_automated_backup =
            (Util.option_bind (Xml.member "DBInstanceAutomatedBackup" xml)
               DBInstanceAutomatedBackup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance_automated_backup
              (fun f ->
                 Ezxmlm.make_tag "DBInstanceAutomatedBackup"
                   ([], (DBInstanceAutomatedBackup.to_xml f)))])
  end
module DBEngineVersionMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_engine_versions: DBEngineVersionList.t
        [@ocaml.doc
          "<p> A list of <code>DBEngineVersion</code> elements. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBEngineVersions</code> action. </p>"]
    let make ?marker  ?(d_b_engine_versions= [])  () =
      { marker; d_b_engine_versions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_engine_versions",
                (DBEngineVersionList.to_json v.d_b_engine_versions));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_engine_versions =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBEngineVersions" xml)
                  DBEngineVersionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBEngineVersions"
                      ([], (DBEngineVersionList.to_xml [x]))))
              v.d_b_engine_versions))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBEngineVersions</code> action. </p>"]
module CreateDBClusterParameterGroupResult =
  struct
    type t = {
      d_b_cluster_parameter_group: DBClusterParameterGroup.t option }
    let make ?d_b_cluster_parameter_group  () =
      { d_b_cluster_parameter_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_parameter_group
              (fun f ->
                 ("d_b_cluster_parameter_group",
                   (DBClusterParameterGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_parameter_group =
            (Util.option_bind (Xml.member "DBClusterParameterGroup" xml)
               DBClusterParameterGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_parameter_group
              (fun f ->
                 Ezxmlm.make_tag "DBClusterParameterGroup"
                   ([], (DBClusterParameterGroup.to_xml f)))])
  end
module DBSnapshotMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_snapshots: DBSnapshotList.t
        [@ocaml.doc "<p> A list of <code>DBSnapshot</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBSnapshots</code> action. </p>"]
    let make ?marker  ?(d_b_snapshots= [])  () = { marker; d_b_snapshots }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("d_b_snapshots", (DBSnapshotList.to_json v.d_b_snapshots));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_snapshots =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSnapshots" xml)
                  DBSnapshotList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBSnapshots"
                      ([], (DBSnapshotList.to_xml [x])))) v.d_b_snapshots))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBSnapshots</code> action. </p>"]
module DownloadDBLogFilePortionDetails =
  struct
    type t =
      {
      log_file_data: String.t option
        [@ocaml.doc "<p>Entries from the specified log file.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>A pagination token that can be used in a subsequent DownloadDBLogFilePortion request.</p>"];
      additional_data_pending: Boolean.t option
        [@ocaml.doc
          "<p>Boolean value that if true, indicates there is more data to be downloaded.</p>"]}
    [@@ocaml.doc
      "<p>This data type is used as a response element to <code>DownloadDBLogFilePortion</code>.</p>"]
    let make ?log_file_data  ?marker  ?additional_data_pending  () =
      { log_file_data; marker; additional_data_pending }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.additional_data_pending
              (fun f -> ("additional_data_pending", (Boolean.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.log_file_data
             (fun f -> ("log_file_data", (String.to_json f)))])
    let parse xml =
      Some
        {
          log_file_data =
            (Util.option_bind (Xml.member "LogFileData" xml) String.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          additional_data_pending =
            (Util.option_bind (Xml.member "AdditionalDataPending" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.log_file_data
                (fun f ->
                   Ezxmlm.make_tag "LogFileData" ([], (String.to_xml f)))])
            @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           [Util.option_map v.additional_data_pending
              (fun f ->
                 Ezxmlm.make_tag "AdditionalDataPending"
                   ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p>This data type is used as a response element to <code>DownloadDBLogFilePortion</code>.</p>"]
module CreateEventSubscriptionResult =
  struct
    type t = {
      event_subscription: EventSubscription.t option }
    let make ?event_subscription  () = { event_subscription }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.event_subscription
              (fun f -> ("event_subscription", (EventSubscription.to_json f)))])
    let parse xml =
      Some
        {
          event_subscription =
            (Util.option_bind (Xml.member "EventSubscription" xml)
               EventSubscription.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.event_subscription
              (fun f ->
                 Ezxmlm.make_tag "EventSubscription"
                   ([], (EventSubscription.to_xml f)))])
  end
module DescribeDBSnapshotAttributesResult =
  struct
    type t =
      {
      d_b_snapshot_attributes_result: DBSnapshotAttributesResult.t option }
    let make ?d_b_snapshot_attributes_result  () =
      { d_b_snapshot_attributes_result }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot_attributes_result
              (fun f ->
                 ("d_b_snapshot_attributes_result",
                   (DBSnapshotAttributesResult.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot_attributes_result =
            (Util.option_bind (Xml.member "DBSnapshotAttributesResult" xml)
               DBSnapshotAttributesResult.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_snapshot_attributes_result
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshotAttributesResult"
                   ([], (DBSnapshotAttributesResult.to_xml f)))])
  end
module EventCategoriesMessage =
  struct
    type t =
      {
      event_categories_map_list: EventCategoriesMapList.t
        [@ocaml.doc "<p>A list of EventCategoriesMap data types.</p>"]}
    [@@ocaml.doc
      "<p>Data returned from the <b>DescribeEventCategories</b> action.</p>"]
    let make ?(event_categories_map_list= [])  () =
      { event_categories_map_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_categories_map_list",
                (EventCategoriesMapList.to_json v.event_categories_map_list))])
    let parse xml =
      Some
        {
          event_categories_map_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "EventCategoriesMapList" xml)
                  EventCategoriesMapList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "EventCategoriesMapList"
                      ([], (EventCategoriesMapList.to_xml [x]))))
              v.event_categories_map_list))
  end[@@ocaml.doc
       "<p>Data returned from the <b>DescribeEventCategories</b> action.</p>"]
module DBClusterCapacityInfo =
  struct
    type t =
      {
      d_b_cluster_identifier: String.t option
        [@ocaml.doc
          "<p>A user-supplied DB cluster identifier. This identifier is the unique key that identifies a DB cluster. </p>"];
      pending_capacity: Integer.t option
        [@ocaml.doc
          "<p>A value that specifies the capacity that the DB cluster scales to next.</p>"];
      current_capacity: Integer.t option
        [@ocaml.doc "<p>The current capacity of the DB cluster.</p>"];
      seconds_before_timeout: Integer.t option
        [@ocaml.doc
          "<p>The number of seconds before a call to <code>ModifyCurrentDBClusterCapacity</code> times out.</p>"];
      timeout_action: String.t option
        [@ocaml.doc
          "<p>The timeout action of a call to <code>ModifyCurrentDBClusterCapacity</code>, either <code>ForceApplyCapacityChange</code> or <code>RollbackCapacityChange</code>.</p>"]}
    let make ?d_b_cluster_identifier  ?pending_capacity  ?current_capacity 
      ?seconds_before_timeout  ?timeout_action  () =
      {
        d_b_cluster_identifier;
        pending_capacity;
        current_capacity;
        seconds_before_timeout;
        timeout_action
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timeout_action
              (fun f -> ("timeout_action", (String.to_json f)));
           Util.option_map v.seconds_before_timeout
             (fun f -> ("seconds_before_timeout", (Integer.to_json f)));
           Util.option_map v.current_capacity
             (fun f -> ("current_capacity", (Integer.to_json f)));
           Util.option_map v.pending_capacity
             (fun f -> ("pending_capacity", (Integer.to_json f)));
           Util.option_map v.d_b_cluster_identifier
             (fun f -> ("d_b_cluster_identifier", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_identifier =
            (Util.option_bind (Xml.member "DBClusterIdentifier" xml)
               String.parse);
          pending_capacity =
            (Util.option_bind (Xml.member "PendingCapacity" xml)
               Integer.parse);
          current_capacity =
            (Util.option_bind (Xml.member "CurrentCapacity" xml)
               Integer.parse);
          seconds_before_timeout =
            (Util.option_bind (Xml.member "SecondsBeforeTimeout" xml)
               Integer.parse);
          timeout_action =
            (Util.option_bind (Xml.member "TimeoutAction" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.d_b_cluster_identifier
                  (fun f ->
                     Ezxmlm.make_tag "DBClusterIdentifier"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.pending_capacity
                 (fun f ->
                    Ezxmlm.make_tag "PendingCapacity"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.current_capacity
                (fun f ->
                   Ezxmlm.make_tag "CurrentCapacity" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.seconds_before_timeout
               (fun f ->
                  Ezxmlm.make_tag "SecondsBeforeTimeout"
                    ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.timeout_action
              (fun f ->
                 Ezxmlm.make_tag "TimeoutAction" ([], (String.to_xml f)))])
  end
module DescribeDBProxiesResponse =
  struct
    type t =
      {
      d_b_proxies: DBProxyList.t
        [@ocaml.doc
          "<p>A return value representing an arbitrary number of <code>DBProxy</code> data structures.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    let make ?(d_b_proxies= [])  ?marker  () = { d_b_proxies; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some ("d_b_proxies", (DBProxyList.to_json v.d_b_proxies))])
    let parse xml =
      Some
        {
          d_b_proxies =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBProxies" xml)
                  DBProxyList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DBProxies"
                       ([], (DBProxyList.to_xml [x])))) v.d_b_proxies))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end
module CopyDBClusterSnapshotResult =
  struct
    type t = {
      d_b_cluster_snapshot: DBClusterSnapshot.t option }
    let make ?d_b_cluster_snapshot  () = { d_b_cluster_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_snapshot
              (fun f ->
                 ("d_b_cluster_snapshot", (DBClusterSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot =
            (Util.option_bind (Xml.member "DBClusterSnapshot" xml)
               DBClusterSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBClusterSnapshot"
                   ([], (DBClusterSnapshot.to_xml f)))])
  end
module ModifyOptionGroupResult =
  struct
    type t = {
      option_group: OptionGroup.t option }
    let make ?option_group  () = { option_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.option_group
              (fun f -> ("option_group", (OptionGroup.to_json f)))])
    let parse xml =
      Some
        {
          option_group =
            (Util.option_bind (Xml.member "OptionGroup" xml)
               OptionGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.option_group
              (fun f ->
                 Ezxmlm.make_tag "OptionGroup" ([], (OptionGroup.to_xml f)))])
  end
module RestoreDBClusterFromSnapshotResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module RestoreDBInstanceFromDBSnapshotResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module StopDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module CreateCustomAvailabilityZoneResult =
  struct
    type t = {
      custom_availability_zone: CustomAvailabilityZone.t option }
    let make ?custom_availability_zone  () = { custom_availability_zone }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.custom_availability_zone
              (fun f ->
                 ("custom_availability_zone",
                   (CustomAvailabilityZone.to_json f)))])
    let parse xml =
      Some
        {
          custom_availability_zone =
            (Util.option_bind (Xml.member "CustomAvailabilityZone" xml)
               CustomAvailabilityZone.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.custom_availability_zone
              (fun f ->
                 Ezxmlm.make_tag "CustomAvailabilityZone"
                   ([], (CustomAvailabilityZone.to_xml f)))])
  end
module ModifyDBInstanceResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module DescribeEngineDefaultClusterParametersResult =
  struct
    type t = {
      engine_defaults: EngineDefaults.t option }
    let make ?engine_defaults  () = { engine_defaults }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.engine_defaults
              (fun f -> ("engine_defaults", (EngineDefaults.to_json f)))])
    let parse xml =
      Some
        {
          engine_defaults =
            (Util.option_bind (Xml.member "EngineDefaults" xml)
               EngineDefaults.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.engine_defaults
              (fun f ->
                 Ezxmlm.make_tag "EngineDefaults"
                   ([], (EngineDefaults.to_xml f)))])
  end
module DeleteEventSubscriptionResult =
  struct
    type t = {
      event_subscription: EventSubscription.t option }
    let make ?event_subscription  () = { event_subscription }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.event_subscription
              (fun f -> ("event_subscription", (EventSubscription.to_json f)))])
    let parse xml =
      Some
        {
          event_subscription =
            (Util.option_bind (Xml.member "EventSubscription" xml)
               EventSubscription.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.event_subscription
              (fun f ->
                 Ezxmlm.make_tag "EventSubscription"
                   ([], (EventSubscription.to_xml f)))])
  end
module DBInstanceMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"];
      d_b_instances: DBInstanceList.t
        [@ocaml.doc "<p> A list of <code>DBInstance</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBInstances</code> action. </p>"]
    let make ?marker  ?(d_b_instances= [])  () = { marker; d_b_instances }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("d_b_instances", (DBInstanceList.to_json v.d_b_instances));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_instances =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBInstances" xml)
                  DBInstanceList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBInstances"
                      ([], (DBInstanceList.to_xml [x])))) v.d_b_instances))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBInstances</code> action. </p>"]
module CopyDBSnapshotResult =
  struct
    type t = {
      d_b_snapshot: DBSnapshot.t option }
    let make ?d_b_snapshot  () = { d_b_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot
              (fun f -> ("d_b_snapshot", (DBSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot =
            (Util.option_bind (Xml.member "DBSnapshot" xml) DBSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshot" ([], (DBSnapshot.to_xml f)))])
  end
module ModifyGlobalClusterResult =
  struct
    type t = {
      global_cluster: GlobalCluster.t option }
    let make ?global_cluster  () = { global_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.global_cluster
              (fun f -> ("global_cluster", (GlobalCluster.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster =
            (Util.option_bind (Xml.member "GlobalCluster" xml)
               GlobalCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.global_cluster
              (fun f ->
                 Ezxmlm.make_tag "GlobalCluster"
                   ([], (GlobalCluster.to_xml f)))])
  end
module CreateOptionGroupResult =
  struct
    type t = {
      option_group: OptionGroup.t option }
    let make ?option_group  () = { option_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.option_group
              (fun f -> ("option_group", (OptionGroup.to_json f)))])
    let parse xml =
      Some
        {
          option_group =
            (Util.option_bind (Xml.member "OptionGroup" xml)
               OptionGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.option_group
              (fun f ->
                 Ezxmlm.make_tag "OptionGroup" ([], (OptionGroup.to_xml f)))])
  end
module InstallationMediaMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>An optional pagination token provided by a previous <a>DescribeInstallationMedia</a> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>.</p>"];
      installation_media: InstallationMediaList.t
        [@ocaml.doc
          "<p>The list of <a>InstallationMedia</a> objects for the AWS account.</p>"]}
    let make ?marker  ?(installation_media= [])  () =
      { marker; installation_media }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("installation_media",
                (InstallationMediaList.to_json v.installation_media));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          installation_media =
            (Util.of_option []
               (Util.option_bind (Xml.member "InstallationMedia" xml)
                  InstallationMediaList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "InstallationMedia"
                      ([], (InstallationMediaList.to_xml [x]))))
              v.installation_media))
  end
module CreateDBSecurityGroupResult =
  struct
    type t = {
      d_b_security_group: DBSecurityGroup.t option }
    let make ?d_b_security_group  () = { d_b_security_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_security_group
              (fun f -> ("d_b_security_group", (DBSecurityGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_security_group =
            (Util.option_bind (Xml.member "DBSecurityGroup" xml)
               DBSecurityGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_security_group
              (fun f ->
                 Ezxmlm.make_tag "DBSecurityGroup"
                   ([], (DBSecurityGroup.to_xml f)))])
  end
module AccountAttributesMessage =
  struct
    type t =
      {
      account_quotas: AccountQuotaList.t
        [@ocaml.doc
          "<p>A list of <code>AccountQuota</code> objects. Within this list, each quota has a name, a count of usage toward the quota maximum, and a maximum value for the quota.</p>"]}
    [@@ocaml.doc
      "<p>Data returned by the <b>DescribeAccountAttributes</b> action.</p>"]
    let make ?(account_quotas= [])  () = { account_quotas }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("account_quotas", (AccountQuotaList.to_json v.account_quotas))])
    let parse xml =
      Some
        {
          account_quotas =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccountQuotas" xml)
                  AccountQuotaList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AccountQuotas"
                      ([], (AccountQuotaList.to_xml [x])))) v.account_quotas))
  end[@@ocaml.doc
       "<p>Data returned by the <b>DescribeAccountAttributes</b> action.</p>"]
module GlobalClustersMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeGlobalClusters</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      global_clusters: GlobalClusterList.t
        [@ocaml.doc
          "<p> The list of global clusters returned by this request. </p>"]}
    let make ?marker  ?(global_clusters= [])  () =
      { marker; global_clusters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("global_clusters",
                (GlobalClusterList.to_json v.global_clusters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          global_clusters =
            (Util.of_option []
               (Util.option_bind (Xml.member "GlobalClusters" xml)
                  GlobalClusterList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "GlobalClusters"
                      ([], (GlobalClusterList.to_xml [x]))))
              v.global_clusters))
  end
module RestoreDBClusterToPointInTimeResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module DeregisterDBProxyTargetsResponse =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let parse xml = Some ()
    let to_xml v = Util.list_filter_opt []
  end
module RebootDBInstanceResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module DBInstanceAutomatedBackupMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"];
      d_b_instance_automated_backups: DBInstanceAutomatedBackupList.t
        [@ocaml.doc
          "<p> A list of <code>DBInstanceAutomatedBackup</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBInstanceAutomatedBackups</code> action. </p>"]
    let make ?marker  ?(d_b_instance_automated_backups= [])  () =
      { marker; d_b_instance_automated_backups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_instance_automated_backups",
                (DBInstanceAutomatedBackupList.to_json
                   v.d_b_instance_automated_backups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_instance_automated_backups =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "DBInstanceAutomatedBackups" xml)
                  DBInstanceAutomatedBackupList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBInstanceAutomatedBackups"
                      ([], (DBInstanceAutomatedBackupList.to_xml [x]))))
              v.d_b_instance_automated_backups))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBInstanceAutomatedBackups</code> action. </p>"]
module DeleteCustomAvailabilityZoneResult =
  struct
    type t = {
      custom_availability_zone: CustomAvailabilityZone.t option }
    let make ?custom_availability_zone  () = { custom_availability_zone }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.custom_availability_zone
              (fun f ->
                 ("custom_availability_zone",
                   (CustomAvailabilityZone.to_json f)))])
    let parse xml =
      Some
        {
          custom_availability_zone =
            (Util.option_bind (Xml.member "CustomAvailabilityZone" xml)
               CustomAvailabilityZone.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.custom_availability_zone
              (fun f ->
                 Ezxmlm.make_tag "CustomAvailabilityZone"
                   ([], (CustomAvailabilityZone.to_xml f)))])
  end
module StartActivityStreamResponse =
  struct
    type t =
      {
      kms_key_id: String.t option
        [@ocaml.doc
          "<p>The AWS KMS key identifier for encryption of messages in the database activity stream.</p>"];
      kinesis_stream_name: String.t option
        [@ocaml.doc
          "<p>The name of the Amazon Kinesis data stream to be used for the database activity stream.</p>"];
      status: ActivityStreamStatus.t option
        [@ocaml.doc "<p>The status of the database activity stream.</p>"];
      mode: ActivityStreamMode.t option
        [@ocaml.doc "<p>The mode of the database activity stream.</p>"];
      apply_immediately: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether or not the database activity stream will start as soon as possible, regardless of the maintenance window for the database.</p>"]}
    let make ?kms_key_id  ?kinesis_stream_name  ?status  ?mode 
      ?apply_immediately  () =
      { kms_key_id; kinesis_stream_name; status; mode; apply_immediately }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.apply_immediately
              (fun f -> ("apply_immediately", (Boolean.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ActivityStreamMode.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (ActivityStreamStatus.to_json f)));
           Util.option_map v.kinesis_stream_name
             (fun f -> ("kinesis_stream_name", (String.to_json f)));
           Util.option_map v.kms_key_id
             (fun f -> ("kms_key_id", (String.to_json f)))])
    let parse xml =
      Some
        {
          kms_key_id =
            (Util.option_bind (Xml.member "KmsKeyId" xml) String.parse);
          kinesis_stream_name =
            (Util.option_bind (Xml.member "KinesisStreamName" xml)
               String.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               ActivityStreamStatus.parse);
          mode =
            (Util.option_bind (Xml.member "Mode" xml)
               ActivityStreamMode.parse);
          apply_immediately =
            (Util.option_bind (Xml.member "ApplyImmediately" xml)
               Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.kms_key_id
                  (fun f ->
                     Ezxmlm.make_tag "KmsKeyId" ([], (String.to_xml f)))])
              @
              [Util.option_map v.kinesis_stream_name
                 (fun f ->
                    Ezxmlm.make_tag "KinesisStreamName"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.status
                (fun f ->
                   Ezxmlm.make_tag "Status"
                     ([], (ActivityStreamStatus.to_xml f)))])
            @
            [Util.option_map v.mode
               (fun f ->
                  Ezxmlm.make_tag "Mode" ([], (ActivityStreamMode.to_xml f)))])
           @
           [Util.option_map v.apply_immediately
              (fun f ->
                 Ezxmlm.make_tag "ApplyImmediately" ([], (Boolean.to_xml f)))])
  end
module ModifyDBClusterSnapshotAttributeResult =
  struct
    type t =
      {
      d_b_cluster_snapshot_attributes_result:
        DBClusterSnapshotAttributesResult.t option }
    let make ?d_b_cluster_snapshot_attributes_result  () =
      { d_b_cluster_snapshot_attributes_result }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster_snapshot_attributes_result
              (fun f ->
                 ("d_b_cluster_snapshot_attributes_result",
                   (DBClusterSnapshotAttributesResult.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster_snapshot_attributes_result =
            (Util.option_bind
               (Xml.member "DBClusterSnapshotAttributesResult" xml)
               DBClusterSnapshotAttributesResult.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster_snapshot_attributes_result
              (fun f ->
                 Ezxmlm.make_tag "DBClusterSnapshotAttributesResult"
                   ([], (DBClusterSnapshotAttributesResult.to_xml f)))])
  end
module DBClusterParameterGroupsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeDBClusterParameterGroups</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_cluster_parameter_groups: DBClusterParameterGroupList.t
        [@ocaml.doc "<p>A list of DB cluster parameter groups.</p>"]}
    [@@ocaml.doc "<p/>"]
    let make ?marker  ?(d_b_cluster_parameter_groups= [])  () =
      { marker; d_b_cluster_parameter_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_parameter_groups",
                (DBClusterParameterGroupList.to_json
                   v.d_b_cluster_parameter_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_cluster_parameter_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusterParameterGroups" xml)
                  DBClusterParameterGroupList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusterParameterGroups"
                      ([], (DBClusterParameterGroupList.to_xml [x]))))
              v.d_b_cluster_parameter_groups))
  end[@@ocaml.doc "<p/>"]
module RevokeDBSecurityGroupIngressResult =
  struct
    type t = {
      d_b_security_group: DBSecurityGroup.t option }
    let make ?d_b_security_group  () = { d_b_security_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_security_group
              (fun f -> ("d_b_security_group", (DBSecurityGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_security_group =
            (Util.option_bind (Xml.member "DBSecurityGroup" xml)
               DBSecurityGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_security_group
              (fun f ->
                 Ezxmlm.make_tag "DBSecurityGroup"
                   ([], (DBSecurityGroup.to_xml f)))])
  end
module DescribeDBLogFilesResponse =
  struct
    type t =
      {
      describe_d_b_log_files: DescribeDBLogFilesList.t
        [@ocaml.doc "<p>The DB log files returned.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>A pagination token that can be used in a subsequent DescribeDBLogFiles request.</p>"]}
    [@@ocaml.doc
      "<p> The response from a call to <code>DescribeDBLogFiles</code>. </p>"]
    let make ?(describe_d_b_log_files= [])  ?marker  () =
      { describe_d_b_log_files; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some
             ("describe_d_b_log_files",
               (DescribeDBLogFilesList.to_json v.describe_d_b_log_files))])
    let parse xml =
      Some
        {
          describe_d_b_log_files =
            (Util.of_option []
               (Util.option_bind (Xml.member "DescribeDBLogFiles" xml)
                  DescribeDBLogFilesList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DescribeDBLogFiles"
                       ([], (DescribeDBLogFilesList.to_xml [x]))))
               v.describe_d_b_log_files))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> The response from a call to <code>DescribeDBLogFiles</code>. </p>"]
module StopDBInstanceResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module PromoteReadReplicaDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module ModifyDBProxyTargetGroupResponse =
  struct
    type t =
      {
      d_b_proxy_target_group: DBProxyTargetGroup.t option
        [@ocaml.doc
          "<p>The settings of the modified <code>DBProxyTarget</code>.</p>"]}
    let make ?d_b_proxy_target_group  () = { d_b_proxy_target_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_proxy_target_group
              (fun f ->
                 ("d_b_proxy_target_group", (DBProxyTargetGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_proxy_target_group =
            (Util.option_bind (Xml.member "DBProxyTargetGroup" xml)
               DBProxyTargetGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_proxy_target_group
              (fun f ->
                 Ezxmlm.make_tag "DBProxyTargetGroup"
                   ([], (DBProxyTargetGroup.to_xml f)))])
  end
module DBClusterParameterGroupDetails =
  struct
    type t =
      {
      parameters: ParametersList.t
        [@ocaml.doc
          "<p>Provides a list of parameters for the DB cluster parameter group.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous DescribeDBClusterParameters request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"]}
    [@@ocaml.doc
      "<p>Provides details about a DB cluster parameter group including the parameters in the DB cluster parameter group.</p>"]
    let make ?(parameters= [])  ?marker  () = { parameters; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some ("parameters", (ParametersList.to_json v.parameters))])
    let parse xml =
      Some
        {
          parameters =
            (Util.of_option []
               (Util.option_bind (Xml.member "Parameters" xml)
                  ParametersList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Parameters"
                       ([], (ParametersList.to_xml [x])))) v.parameters))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Provides details about a DB cluster parameter group including the parameters in the DB cluster parameter group.</p>"]
module PromoteReadReplicaResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module CopyOptionGroupResult =
  struct
    type t = {
      option_group: OptionGroup.t option }
    let make ?option_group  () = { option_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.option_group
              (fun f -> ("option_group", (OptionGroup.to_json f)))])
    let parse xml =
      Some
        {
          option_group =
            (Util.option_bind (Xml.member "OptionGroup" xml)
               OptionGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.option_group
              (fun f ->
                 Ezxmlm.make_tag "OptionGroup" ([], (OptionGroup.to_xml f)))])
  end
module RemoveSourceIdentifierFromSubscriptionResult =
  struct
    type t = {
      event_subscription: EventSubscription.t option }
    let make ?event_subscription  () = { event_subscription }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.event_subscription
              (fun f -> ("event_subscription", (EventSubscription.to_json f)))])
    let parse xml =
      Some
        {
          event_subscription =
            (Util.option_bind (Xml.member "EventSubscription" xml)
               EventSubscription.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.event_subscription
              (fun f ->
                 Ezxmlm.make_tag "EventSubscription"
                   ([], (EventSubscription.to_xml f)))])
  end
module ModifyDBSnapshotResult =
  struct
    type t = {
      d_b_snapshot: DBSnapshot.t option }
    let make ?d_b_snapshot  () = { d_b_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot
              (fun f -> ("d_b_snapshot", (DBSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot =
            (Util.option_bind (Xml.member "DBSnapshot" xml) DBSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshot" ([], (DBSnapshot.to_xml f)))])
  end
module PurchaseReservedDBInstancesOfferingResult =
  struct
    type t = {
      reserved_d_b_instance: ReservedDBInstance.t option }
    let make ?reserved_d_b_instance  () = { reserved_d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reserved_d_b_instance
              (fun f ->
                 ("reserved_d_b_instance", (ReservedDBInstance.to_json f)))])
    let parse xml =
      Some
        {
          reserved_d_b_instance =
            (Util.option_bind (Xml.member "ReservedDBInstance" xml)
               ReservedDBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.reserved_d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "ReservedDBInstance"
                   ([], (ReservedDBInstance.to_xml f)))])
  end
module RestoreDBInstanceToPointInTimeResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module DBParameterGroupsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_parameter_groups: DBParameterGroupList.t
        [@ocaml.doc
          "<p> A list of <code>DBParameterGroup</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBParameterGroups</code> action. </p>"]
    let make ?marker  ?(d_b_parameter_groups= [])  () =
      { marker; d_b_parameter_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_parameter_groups",
                (DBParameterGroupList.to_json v.d_b_parameter_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_parameter_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBParameterGroups" xml)
                  DBParameterGroupList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBParameterGroups"
                      ([], (DBParameterGroupList.to_xml [x]))))
              v.d_b_parameter_groups))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBParameterGroups</code> action. </p>"]
module CreateGlobalClusterResult =
  struct
    type t = {
      global_cluster: GlobalCluster.t option }
    let make ?global_cluster  () = { global_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.global_cluster
              (fun f -> ("global_cluster", (GlobalCluster.to_json f)))])
    let parse xml =
      Some
        {
          global_cluster =
            (Util.option_bind (Xml.member "GlobalCluster" xml)
               GlobalCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.global_cluster
              (fun f ->
                 Ezxmlm.make_tag "GlobalCluster"
                   ([], (GlobalCluster.to_xml f)))])
  end
module RestoreDBInstanceFromS3Result =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module CopyDBParameterGroupResult =
  struct
    type t = {
      d_b_parameter_group: DBParameterGroup.t option }
    let make ?d_b_parameter_group  () = { d_b_parameter_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_parameter_group
              (fun f -> ("d_b_parameter_group", (DBParameterGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_parameter_group =
            (Util.option_bind (Xml.member "DBParameterGroup" xml)
               DBParameterGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_parameter_group
              (fun f ->
                 Ezxmlm.make_tag "DBParameterGroup"
                   ([], (DBParameterGroup.to_xml f)))])
  end
module EventsMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous Events request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"];
      events: EventList.t
        [@ocaml.doc "<p> A list of <code>Event</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeEvents</code> action. </p>"]
    let make ?marker  ?(events= [])  () = { marker; events }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("events", (EventList.to_json v.events));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          events =
            (Util.of_option []
               (Util.option_bind (Xml.member "Events" xml) EventList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Events" ([], (EventList.to_xml [x]))))
              v.events))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeEvents</code> action. </p>"]
module CertificateMessage =
  struct
    type t =
      {
      certificates: CertificateList.t
        [@ocaml.doc
          "<p>The list of <code>Certificate</code> objects for the AWS account.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeCertificates</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"]}
    [@@ocaml.doc
      "<p>Data returned by the <b>DescribeCertificates</b> action.</p>"]
    let make ?(certificates= [])  ?marker  () = { certificates; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some ("certificates", (CertificateList.to_json v.certificates))])
    let parse xml =
      Some
        {
          certificates =
            (Util.of_option []
               (Util.option_bind (Xml.member "Certificates" xml)
                  CertificateList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Certificates"
                       ([], (CertificateList.to_xml [x])))) v.certificates))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p>Data returned by the <b>DescribeCertificates</b> action.</p>"]
module AuthorizeDBSecurityGroupIngressResult =
  struct
    type t = {
      d_b_security_group: DBSecurityGroup.t option }
    let make ?d_b_security_group  () = { d_b_security_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_security_group
              (fun f -> ("d_b_security_group", (DBSecurityGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_security_group =
            (Util.option_bind (Xml.member "DBSecurityGroup" xml)
               DBSecurityGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_security_group
              (fun f ->
                 Ezxmlm.make_tag "DBSecurityGroup"
                   ([], (DBSecurityGroup.to_xml f)))])
  end
module OptionGroups =
  struct
    type t =
      {
      option_groups_list: OptionGroupsList.t
        [@ocaml.doc "<p>List of option groups.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p>An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    [@@ocaml.doc "<p>List of option groups.</p>"]
    let make ?(option_groups_list= [])  ?marker  () =
      { option_groups_list; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some
             ("option_groups_list",
               (OptionGroupsList.to_json v.option_groups_list))])
    let parse xml =
      Some
        {
          option_groups_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionGroupsList" xml)
                  OptionGroupsList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "OptionGroupsList"
                       ([], (OptionGroupsList.to_xml [x]))))
               v.option_groups_list))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p>List of option groups.</p>"]
module DeleteDBSnapshotResult =
  struct
    type t = {
      d_b_snapshot: DBSnapshot.t option }
    let make ?d_b_snapshot  () = { d_b_snapshot }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot
              (fun f -> ("d_b_snapshot", (DBSnapshot.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot =
            (Util.option_bind (Xml.member "DBSnapshot" xml) DBSnapshot.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_snapshot
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshot" ([], (DBSnapshot.to_xml f)))])
  end
module OrderableDBInstanceOptionsMessage =
  struct
    type t =
      {
      orderable_d_b_instance_options: OrderableDBInstanceOptionsList.t
        [@ocaml.doc
          "<p>An <code>OrderableDBInstanceOption</code> structure containing information about orderable options for the DB instance.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous OrderableDBInstanceOptions request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code> . </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeOrderableDBInstanceOptions</code> action. </p>"]
    let make ?(orderable_d_b_instance_options= [])  ?marker  () =
      { orderable_d_b_instance_options; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some
             ("orderable_d_b_instance_options",
               (OrderableDBInstanceOptionsList.to_json
                  v.orderable_d_b_instance_options))])
    let parse xml =
      Some
        {
          orderable_d_b_instance_options =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "OrderableDBInstanceOptions" xml)
                  OrderableDBInstanceOptionsList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "OrderableDBInstanceOptions"
                       ([], (OrderableDBInstanceOptionsList.to_xml [x]))))
               v.orderable_d_b_instance_options))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeOrderableDBInstanceOptions</code> action. </p>"]
module DeleteDBInstanceResult =
  struct
    type t = {
      d_b_instance: DBInstance.t option }
    let make ?d_b_instance  () = { d_b_instance }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_instance
              (fun f -> ("d_b_instance", (DBInstance.to_json f)))])
    let parse xml =
      Some
        {
          d_b_instance =
            (Util.option_bind (Xml.member "DBInstance" xml) DBInstance.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_instance
              (fun f ->
                 Ezxmlm.make_tag "DBInstance" ([], (DBInstance.to_xml f)))])
  end
module ModifyDBSnapshotAttributeResult =
  struct
    type t =
      {
      d_b_snapshot_attributes_result: DBSnapshotAttributesResult.t option }
    let make ?d_b_snapshot_attributes_result  () =
      { d_b_snapshot_attributes_result }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_snapshot_attributes_result
              (fun f ->
                 ("d_b_snapshot_attributes_result",
                   (DBSnapshotAttributesResult.to_json f)))])
    let parse xml =
      Some
        {
          d_b_snapshot_attributes_result =
            (Util.option_bind (Xml.member "DBSnapshotAttributesResult" xml)
               DBSnapshotAttributesResult.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_snapshot_attributes_result
              (fun f ->
                 Ezxmlm.make_tag "DBSnapshotAttributesResult"
                   ([], (DBSnapshotAttributesResult.to_xml f)))])
  end
module SourceRegionMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      source_regions: SourceRegionList.t
        [@ocaml.doc
          "<p>A list of SourceRegion instances that contains each source AWS Region that the current AWS Region can get a Read Replica or a DB snapshot from.</p>"]}
    [@@ocaml.doc
      "<p>Contains the result of a successful invocation of the <code>DescribeSourceRegions</code> action.</p>"]
    let make ?marker  ?(source_regions= [])  () = { marker; source_regions }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("source_regions", (SourceRegionList.to_json v.source_regions));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          source_regions =
            (Util.of_option []
               (Util.option_bind (Xml.member "SourceRegions" xml)
                  SourceRegionList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "SourceRegions"
                      ([], (SourceRegionList.to_xml [x])))) v.source_regions))
  end[@@ocaml.doc
       "<p>Contains the result of a successful invocation of the <code>DescribeSourceRegions</code> action.</p>"]
module DescribeDBProxyTargetsResponse =
  struct
    type t =
      {
      targets: TargetList.t
        [@ocaml.doc
          "<p>An arbitrary number of <code>DBProxyTarget</code> objects, containing details of the corresponding targets.</p>"];
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"]}
    let make ?(targets= [])  ?marker  () = { targets; marker }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.marker
              (fun f -> ("marker", (String.to_json f)));
           Some ("targets", (TargetList.to_json v.targets))])
    let parse xml =
      Some
        {
          targets =
            (Util.of_option []
               (Util.option_bind (Xml.member "Targets" xml) TargetList.parse));
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Targets" ([], (TargetList.to_xml [x]))))
               v.targets))
           @
           [Util.option_map v.marker
              (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
  end
module DBParameterGroupNameMessage =
  struct
    type t =
      {
      d_b_parameter_group_name: String.t option
        [@ocaml.doc "<p>Provides the name of the DB parameter group.</p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>ModifyDBParameterGroup</code> or <code>ResetDBParameterGroup</code> action. </p>"]
    let make ?d_b_parameter_group_name  () = { d_b_parameter_group_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_parameter_group_name
              (fun f -> ("d_b_parameter_group_name", (String.to_json f)))])
    let parse xml =
      Some
        {
          d_b_parameter_group_name =
            (Util.option_bind (Xml.member "DBParameterGroupName" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_parameter_group_name
              (fun f ->
                 Ezxmlm.make_tag "DBParameterGroupName"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>ModifyDBParameterGroup</code> or <code>ResetDBParameterGroup</code> action. </p>"]
module DBClusterSnapshotMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous <code>DescribeDBClusterSnapshots</code> request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_cluster_snapshots: DBClusterSnapshotList.t
        [@ocaml.doc
          "<p>Provides a list of DB cluster snapshots for the user.</p>"]}
    [@@ocaml.doc
      "<p> Provides a list of DB cluster snapshots for the user as the result of a call to the <code>DescribeDBClusterSnapshots</code> action. </p>"]
    let make ?marker  ?(d_b_cluster_snapshots= [])  () =
      { marker; d_b_cluster_snapshots }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_snapshots",
                (DBClusterSnapshotList.to_json v.d_b_cluster_snapshots));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_cluster_snapshots =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusterSnapshots" xml)
                  DBClusterSnapshotList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusterSnapshots"
                      ([], (DBClusterSnapshotList.to_xml [x]))))
              v.d_b_cluster_snapshots))
  end[@@ocaml.doc
       "<p> Provides a list of DB cluster snapshots for the user as the result of a call to the <code>DescribeDBClusterSnapshots</code> action. </p>"]
module StartDBClusterResult =
  struct
    type t = {
      d_b_cluster: DBCluster.t option }
    let make ?d_b_cluster  () = { d_b_cluster }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_cluster
              (fun f -> ("d_b_cluster", (DBCluster.to_json f)))])
    let parse xml =
      Some
        {
          d_b_cluster =
            (Util.option_bind (Xml.member "DBCluster" xml) DBCluster.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_cluster
              (fun f ->
                 Ezxmlm.make_tag "DBCluster" ([], (DBCluster.to_xml f)))])
  end
module ReservedDBInstancesOfferingMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      reserved_d_b_instances_offerings: ReservedDBInstancesOfferingList.t
        [@ocaml.doc "<p>A list of reserved DB instance offerings.</p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeReservedDBInstancesOfferings</code> action. </p>"]
    let make ?marker  ?(reserved_d_b_instances_offerings= [])  () =
      { marker; reserved_d_b_instances_offerings }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("reserved_d_b_instances_offerings",
                (ReservedDBInstancesOfferingList.to_json
                   v.reserved_d_b_instances_offerings));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          reserved_d_b_instances_offerings =
            (Util.of_option []
               (Util.option_bind
                  (Xml.member "ReservedDBInstancesOfferings" xml)
                  ReservedDBInstancesOfferingList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "ReservedDBInstancesOfferings"
                      ([], (ReservedDBInstancesOfferingList.to_xml [x]))))
              v.reserved_d_b_instances_offerings))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeReservedDBInstancesOfferings</code> action. </p>"]
module DBClusterBacktrackMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>A pagination token that can be used in a subsequent <code>DescribeDBClusterBacktracks</code> request.</p>"];
      d_b_cluster_backtracks: DBClusterBacktrackList.t
        [@ocaml.doc "<p>Contains a list of backtracks for the user.</p>"]}
    [@@ocaml.doc
      "<p>Contains the result of a successful invocation of the <code>DescribeDBClusterBacktracks</code> action.</p>"]
    let make ?marker  ?(d_b_cluster_backtracks= [])  () =
      { marker; d_b_cluster_backtracks }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_cluster_backtracks",
                (DBClusterBacktrackList.to_json v.d_b_cluster_backtracks));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_cluster_backtracks =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusterBacktracks" xml)
                  DBClusterBacktrackList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusterBacktracks"
                      ([], (DBClusterBacktrackList.to_xml [x]))))
              v.d_b_cluster_backtracks))
  end[@@ocaml.doc
       "<p>Contains the result of a successful invocation of the <code>DescribeDBClusterBacktracks</code> action.</p>"]
module DBClusterMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p>A pagination token that can be used in a subsequent DescribeDBClusters request.</p>"];
      d_b_clusters: DBClusterList.t
        [@ocaml.doc "<p>Contains a list of DB clusters for the user.</p>"]}
    [@@ocaml.doc
      "<p>Contains the result of a successful invocation of the <code>DescribeDBClusters</code> action.</p>"]
    let make ?marker  ?(d_b_clusters= [])  () = { marker; d_b_clusters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("d_b_clusters", (DBClusterList.to_json v.d_b_clusters));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_clusters =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBClusters" xml)
                  DBClusterList.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBClusters"
                      ([], (DBClusterList.to_xml [x])))) v.d_b_clusters))
  end[@@ocaml.doc
       "<p>Contains the result of a successful invocation of the <code>DescribeDBClusters</code> action.</p>"]
module CreateDBSubnetGroupResult =
  struct
    type t = {
      d_b_subnet_group: DBSubnetGroup.t option }
    let make ?d_b_subnet_group  () = { d_b_subnet_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.d_b_subnet_group
              (fun f -> ("d_b_subnet_group", (DBSubnetGroup.to_json f)))])
    let parse xml =
      Some
        {
          d_b_subnet_group =
            (Util.option_bind (Xml.member "DBSubnetGroup" xml)
               DBSubnetGroup.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.d_b_subnet_group
              (fun f ->
                 Ezxmlm.make_tag "DBSubnetGroup"
                   ([], (DBSubnetGroup.to_xml f)))])
  end
module DBSecurityGroupMessage =
  struct
    type t =
      {
      marker: String.t option
        [@ocaml.doc
          "<p> An optional pagination token provided by a previous request. If this parameter is specified, the response includes only records beyond the marker, up to the value specified by <code>MaxRecords</code>. </p>"];
      d_b_security_groups: DBSecurityGroups.t
        [@ocaml.doc
          "<p> A list of <code>DBSecurityGroup</code> instances. </p>"]}
    [@@ocaml.doc
      "<p> Contains the result of a successful invocation of the <code>DescribeDBSecurityGroups</code> action. </p>"]
    let make ?marker  ?(d_b_security_groups= [])  () =
      { marker; d_b_security_groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("d_b_security_groups",
                (DBSecurityGroups.to_json v.d_b_security_groups));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)))])
    let parse xml =
      Some
        {
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          d_b_security_groups =
            (Util.of_option []
               (Util.option_bind (Xml.member "DBSecurityGroups" xml)
                  DBSecurityGroups.parse))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.marker
               (fun f -> Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "DBSecurityGroups"
                      ([], (DBSecurityGroups.to_xml [x]))))
              v.d_b_security_groups))
  end[@@ocaml.doc
       "<p> Contains the result of a successful invocation of the <code>DescribeDBSecurityGroups</code> action. </p>"]