open Aws
open Aws.BaseTypes
module PatchFilterKey =
  struct
    type t =
      | PATCH_SET 
      | PRODUCT 
      | PRODUCT_FAMILY 
      | CLASSIFICATION 
      | MSRC_SEVERITY 
      | PATCH_ID 
      | SECTION 
      | PRIORITY 
      | SEVERITY 
    let str_to_t =
      [("SEVERITY", SEVERITY);
      ("PRIORITY", PRIORITY);
      ("SECTION", SECTION);
      ("PATCH_ID", PATCH_ID);
      ("MSRC_SEVERITY", MSRC_SEVERITY);
      ("CLASSIFICATION", CLASSIFICATION);
      ("PRODUCT_FAMILY", PRODUCT_FAMILY);
      ("PRODUCT", PRODUCT);
      ("PATCH_SET", PATCH_SET)]
    let t_to_str =
      [(SEVERITY, "SEVERITY");
      (PRIORITY, "PRIORITY");
      (SECTION, "SECTION");
      (PATCH_ID, "PATCH_ID");
      (MSRC_SEVERITY, "MSRC_SEVERITY");
      (CLASSIFICATION, "CLASSIFICATION");
      (PRODUCT_FAMILY, "PRODUCT_FAMILY");
      (PRODUCT, "PRODUCT");
      (PATCH_SET, "PATCH_SET")]
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
module PatchFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InventoryFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InventoryQueryOperatorType =
  struct
    type t =
      | Equal 
      | NotEqual 
      | BeginWith 
      | LessThan 
      | GreaterThan 
      | Exists 
    let str_to_t =
      [("Exists", Exists);
      ("GreaterThan", GreaterThan);
      ("LessThan", LessThan);
      ("BeginWith", BeginWith);
      ("NotEqual", NotEqual);
      ("Equal", Equal)]
    let t_to_str =
      [(Exists, "Exists");
      (GreaterThan, "GreaterThan");
      (LessThan, "LessThan");
      (BeginWith, "BeginWith");
      (NotEqual, "NotEqual");
      (Equal, "Equal")]
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
module AutomationParameterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module TargetValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module OpsEntityItemEntry =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module PatchFilter =
  struct
    type t =
      {
      key: PatchFilterKey.t
        [@ocaml.doc
          "<p>The key for the filter.</p> <p>Run the <a>DescribePatchProperties</a> command to view lists of valid keys for each operating system type.</p>"];
      values: PatchFilterValueList.t
        [@ocaml.doc
          "<p>The value for the filter key.</p> <p>Run the <a>DescribePatchProperties</a> command to view lists of valid values for each key based on operating system type.</p>"]}
    [@@ocaml.doc
      "<p> Defines which patches should be included in a patch baseline.</p> <p>A patch filter consists of a key and a set of values. The filter key is a patch property. For example, the available filter keys for WINDOWS are PATCH_SET, PRODUCT, PRODUCT_FAMILY, CLASSIFICATION, and MSRC_SEVERITY. The filter values define a matching criterion for the patch property indicated by the key. For example, if the filter key is PRODUCT and the filter values are [\"Office 2013\", \"Office 2016\"], then the filter accepts all patches where product name is either \"Office 2013\" or \"Office 2016\". The filter values can be exact values for the patch property given as a key, or a wildcard (*), which matches all values.</p> <p>You can view lists of valid values for the patch properties by running the <code>DescribePatchProperties</code> command. For information about which patch properties can be used with each major operating system, see <a>DescribePatchProperties</a>.</p>"]
    let make ~key  ~values  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (PatchFilterValueList.to_json v.values));
           Some ("key", (PatchFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (PatchFilterKey.of_json (Util.of_option_exn (Json.lookup j "key")));
        values =
          (PatchFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p> Defines which patches should be included in a patch baseline.</p> <p>A patch filter consists of a key and a set of values. The filter key is a patch property. For example, the available filter keys for WINDOWS are PATCH_SET, PRODUCT, PRODUCT_FAMILY, CLASSIFICATION, and MSRC_SEVERITY. The filter values define a matching criterion for the patch property indicated by the key. For example, if the filter key is PRODUCT and the filter values are [\"Office 2013\", \"Office 2016\"], then the filter accepts all patches where product name is either \"Office 2013\" or \"Office 2016\". The filter values can be exact values for the patch property given as a key, or a wildcard (*), which matches all values.</p> <p>You can view lists of valid values for the patch properties by running the <code>DescribePatchProperties</code> command. For information about which patch properties can be used with each major operating system, see <a>DescribePatchProperties</a>.</p>"]
module InventoryItemEntry =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module ResourceDataSyncOrganizationalUnit =
  struct
    type t =
      {
      organizational_unit_id: String.t option
        [@ocaml.doc
          "<p>The AWS Organization unit ID data source for the sync.</p>"]}
    [@@ocaml.doc
      "<p>The AWS Organizations organizational unit data source for the sync.</p>"]
    let make ?organizational_unit_id  () = { organizational_unit_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.organizational_unit_id
              (fun f -> ("organizational_unit_id", (String.to_json f)))])
    let of_json j =
      {
        organizational_unit_id =
          (Util.option_map (Json.lookup j "organizational_unit_id")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>The AWS Organizations organizational unit data source for the sync.</p>"]
module NotificationEvent =
  struct
    type t =
      | All 
      | InProgress 
      | Success 
      | TimedOut 
      | Cancelled 
      | Failed 
    let str_to_t =
      [("Failed", Failed);
      ("Cancelled", Cancelled);
      ("TimedOut", TimedOut);
      ("Success", Success);
      ("InProgress", InProgress);
      ("All", All)]
    let t_to_str =
      [(Failed, "Failed");
      (Cancelled, "Cancelled");
      (TimedOut, "TimedOut");
      (Success, "Success");
      (InProgress, "InProgress");
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
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module TargetMapValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InventoryFilter =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>The name of the filter key.</p>"];
      values: InventoryFilterValueList.t
        [@ocaml.doc
          "<p>Inventory filter values. Example: inventory filter where instance IDs are specified as values Key=AWS:InstanceInformation.InstanceId,Values= i-a12b3c4d5e6g, i-1a2b3c4d5e6,Type=Equal </p>"];
      type_: InventoryQueryOperatorType.t option
        [@ocaml.doc
          "<p>The type of filter. Valid values include the following: \"Equal\"|\"NotEqual\"|\"BeginWith\"|\"LessThan\"|\"GreaterThan\"</p>"]}
    [@@ocaml.doc
      "<p>One or more filters. Use a filter to return a more specific list of results.</p>"]
    let make ~key  ~values  ?type_  () = { key; values; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (InventoryQueryOperatorType.to_json f)));
           Some ("values", (InventoryFilterValueList.to_json v.values));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        values =
          (InventoryFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")));
        type_ =
          (Util.option_map (Json.lookup j "type_")
             InventoryQueryOperatorType.of_json)
      }
  end[@@ocaml.doc
       "<p>One or more filters. Use a filter to return a more specific list of results.</p>"]
module AutomationParameterMap =
  struct
    type t = (String.t, AutomationParameterValueList.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string
        AutomationParameterValueList.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k),
                    (AutomationParameterValueList.to_json v))
                  :: acc) v [])
    let of_json j =
      Json.to_hashtbl String.of_string AutomationParameterValueList.of_json j
  end
module Accounts =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Regions =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Target =
  struct
    type t =
      {
      key: String.t option
        [@ocaml.doc
          "<p>User-defined criteria for sending commands that target instances that meet the criteria.</p>"];
      values: TargetValues.t
        [@ocaml.doc
          "<p>User-defined criteria that maps to <code>Key</code>. For example, if you specified <code>tag:ServerRole</code>, you could specify <code>value:WebServer</code> to run a command on instances that include Amazon EC2 tags of <code>ServerRole,WebServer</code>. </p>"]}
    [@@ocaml.doc
      "<p>An array of search criteria that targets instances using a Key,Value combination that you specify. </p> <p>Supported formats include the following.</p> <ul> <li> <p> <code>Key=InstanceIds,Values=<i>instance-id-1</i>,<i>instance-id-2</i>,<i>instance-id-3</i> </code> </p> </li> <li> <p> <code>Key=tag:<i>my-tag-key</i>,Values=<i>my-tag-value-1</i>,<i>my-tag-value-2</i> </code> </p> </li> <li> <p> <code>Key=tag-key,Values=<i>my-tag-key-1</i>,<i>my-tag-key-2</i> </code> </p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:Name,Values=<i>resource-group-name</i> </code> </p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:ResourceTypeFilters,Values=<i>resource-type-1</i>,<i>resource-type-2</i> </code> </p> </li> </ul> <p>For example:</p> <ul> <li> <p> <code>Key=InstanceIds,Values=i-02573cafcfEXAMPLE,i-0471e04240EXAMPLE,i-07782c72faEXAMPLE</code> </p> </li> <li> <p> <code>Key=tag:CostCenter,Values=CostCenter1,CostCenter2,CostCenter3</code> </p> </li> <li> <p> <code>Key=tag-key,Values=Name,Instance-Type,CostCenter</code> </p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:Name,Values=ProductionResourceGroup</code> </p> <p>This example demonstrates how to target all resources in the resource group <b>ProductionResourceGroup</b> in your maintenance window.</p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:ResourceTypeFilters,Values=<i>AWS::EC2::INSTANCE</i>,<i>AWS::EC2::VPC</i> </code> </p> <p>This example demonstrates how to target only Amazon EC2 instances and VPCs in your maintenance window.</p> </li> <li> <p>(State Manager association targets only) <code>Key=InstanceIds,Values=<i>*</i> </code> </p> <p>This example demonstrates how to target all managed instances in the AWS Region where the association was created.</p> </li> </ul> <p>For information about how to send commands that target instances using <code>Key,Value</code> parameters, see <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-targeting\">Using Targets and Rate Controls to Send Commands to a Fleet</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]
    let make ?key  ?(values= [])  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (TargetValues.to_json v.values));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        values =
          (TargetValues.of_json (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>An array of search criteria that targets instances using a Key,Value combination that you specify. </p> <p>Supported formats include the following.</p> <ul> <li> <p> <code>Key=InstanceIds,Values=<i>instance-id-1</i>,<i>instance-id-2</i>,<i>instance-id-3</i> </code> </p> </li> <li> <p> <code>Key=tag:<i>my-tag-key</i>,Values=<i>my-tag-value-1</i>,<i>my-tag-value-2</i> </code> </p> </li> <li> <p> <code>Key=tag-key,Values=<i>my-tag-key-1</i>,<i>my-tag-key-2</i> </code> </p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:Name,Values=<i>resource-group-name</i> </code> </p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:ResourceTypeFilters,Values=<i>resource-type-1</i>,<i>resource-type-2</i> </code> </p> </li> </ul> <p>For example:</p> <ul> <li> <p> <code>Key=InstanceIds,Values=i-02573cafcfEXAMPLE,i-0471e04240EXAMPLE,i-07782c72faEXAMPLE</code> </p> </li> <li> <p> <code>Key=tag:CostCenter,Values=CostCenter1,CostCenter2,CostCenter3</code> </p> </li> <li> <p> <code>Key=tag-key,Values=Name,Instance-Type,CostCenter</code> </p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:Name,Values=ProductionResourceGroup</code> </p> <p>This example demonstrates how to target all resources in the resource group <b>ProductionResourceGroup</b> in your maintenance window.</p> </li> <li> <p>(Maintenance window targets only) <code>Key=resource-groups:ResourceTypeFilters,Values=<i>AWS::EC2::INSTANCE</i>,<i>AWS::EC2::VPC</i> </code> </p> <p>This example demonstrates how to target only Amazon EC2 instances and VPCs in your maintenance window.</p> </li> <li> <p>(State Manager association targets only) <code>Key=InstanceIds,Values=<i>*</i> </code> </p> <p>This example demonstrates how to target all managed instances in the AWS Region where the association was created.</p> </li> </ul> <p>For information about how to send commands that target instances using <code>Key,Value</code> parameters, see <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-targeting\">Using Targets and Rate Controls to Send Commands to a Fleet</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]
module OpsEntityItemEntryList =
  struct
    type t = OpsEntityItemEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsEntityItemEntry.to_query v
    let to_headers v =
      Headers.to_headers_list OpsEntityItemEntry.to_headers v
    let to_json v = `List (List.map OpsEntityItemEntry.to_json v)
    let of_json j = Json.to_list OpsEntityItemEntry.of_json j
  end
module PatchFilterList =
  struct
    type t = PatchFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchFilter.to_query v
    let to_headers v = Headers.to_headers_list PatchFilter.to_headers v
    let to_json v = `List (List.map PatchFilter.to_json v)
    let of_json j = Json.to_list PatchFilter.of_json j
  end
module MaintenanceWindowTaskParameterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InventoryItemEntryList =
  struct
    type t = InventoryItemEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryItemEntry.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryItemEntry.to_headers v
    let to_json v = `List (List.map InventoryItemEntry.to_json v)
    let of_json j = Json.to_list InventoryItemEntry.of_json j
  end
module OpsItemDataType =
  struct
    type t =
      | SearchableString 
      | String 
    let str_to_t =
      [("String", String); ("SearchableString", SearchableString)]
    let t_to_str =
      [(String, "String"); (SearchableString, "SearchableString")]
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
module S3OutputLocation =
  struct
    type t =
      {
      output_s3_region: String.t option
        [@ocaml.doc
          "<p>(Deprecated) You can no longer specify this parameter. The system ignores it. Instead, Systems Manager automatically determines the Amazon S3 bucket region.</p>"];
      output_s3_bucket_name: String.t option
        [@ocaml.doc "<p>The name of the Amazon S3 bucket.</p>"];
      output_s3_key_prefix: String.t option
        [@ocaml.doc "<p>The Amazon S3 bucket subfolder.</p>"]}[@@ocaml.doc
                                                                "<p>An Amazon S3 bucket where you want to store the results of this request.</p>"]
    let make ?output_s3_region  ?output_s3_bucket_name  ?output_s3_key_prefix
       () = { output_s3_region; output_s3_bucket_name; output_s3_key_prefix }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_s3_key_prefix
              (fun f -> ("output_s3_key_prefix", (String.to_json f)));
           Util.option_map v.output_s3_bucket_name
             (fun f -> ("output_s3_bucket_name", (String.to_json f)));
           Util.option_map v.output_s3_region
             (fun f -> ("output_s3_region", (String.to_json f)))])
    let of_json j =
      {
        output_s3_region =
          (Util.option_map (Json.lookup j "output_s3_region") String.of_json);
        output_s3_bucket_name =
          (Util.option_map (Json.lookup j "output_s3_bucket_name")
             String.of_json);
        output_s3_key_prefix =
          (Util.option_map (Json.lookup j "output_s3_key_prefix")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>An Amazon S3 bucket where you want to store the results of this request.</p>"]
module ParameterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InventoryDeletionSummaryItem =
  struct
    type t =
      {
      version: String.t option
        [@ocaml.doc "<p>The inventory type version.</p>"];
      count: Integer.t option
        [@ocaml.doc "<p>A count of the number of deleted items.</p>"];
      remaining_count: Integer.t option
        [@ocaml.doc "<p>The remaining number of items to delete.</p>"]}
    [@@ocaml.doc
      "<p>Either a count, remaining count, or a version number in a delete inventory summary.</p>"]
    let make ?version  ?count  ?remaining_count  () =
      { version; count; remaining_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.remaining_count
              (fun f -> ("remaining_count", (Integer.to_json f)));
           Util.option_map v.count (fun f -> ("count", (Integer.to_json f)));
           Util.option_map v.version
             (fun f -> ("version", (String.to_json f)))])
    let of_json j =
      {
        version = (Util.option_map (Json.lookup j "version") String.of_json);
        count = (Util.option_map (Json.lookup j "count") Integer.of_json);
        remaining_count =
          (Util.option_map (Json.lookup j "remaining_count") Integer.of_json)
      }
  end[@@ocaml.doc
       "<p>Either a count, remaining count, or a version number in a delete inventory summary.</p>"]
module InventoryAttributeDataType =
  struct
    type t =
      | String 
      | Number 
    let str_to_t = [("number", Number); ("string", String)]
    let t_to_str = [(Number, "number"); (String, "string")]
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
module CommandPluginStatus =
  struct
    type t =
      | Pending 
      | InProgress 
      | Success 
      | TimedOut 
      | Cancelled 
      | Failed 
    let str_to_t =
      [("Failed", Failed);
      ("Cancelled", Cancelled);
      ("TimedOut", TimedOut);
      ("Success", Success);
      ("InProgress", InProgress);
      ("Pending", Pending)]
    let t_to_str =
      [(Failed, "Failed");
      (Cancelled, "Cancelled");
      (TimedOut, "TimedOut");
      (Success, "Success");
      (InProgress, "InProgress");
      (Pending, "Pending")]
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
module ResourceDataSyncOrganizationalUnitList =
  struct
    type t = ResourceDataSyncOrganizationalUnit.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ResourceDataSyncOrganizationalUnit.to_query v
    let to_headers v =
      Headers.to_headers_list ResourceDataSyncOrganizationalUnit.to_headers v
    let to_json v =
      `List (List.map ResourceDataSyncOrganizationalUnit.to_json v)
    let of_json j = Json.to_list ResourceDataSyncOrganizationalUnit.of_json j
  end
module ParameterInlinePolicy =
  struct
    type t =
      {
      policy_text: String.t option
        [@ocaml.doc "<p>The JSON text of the policy.</p>"];
      policy_type: String.t option
        [@ocaml.doc
          "<p>The type of policy. Parameter Store supports the following policy types: Expiration, ExpirationNotification, and NoChangeNotification. </p>"];
      policy_status: String.t option
        [@ocaml.doc
          "<p>The status of the policy. Policies report the following statuses: Pending (the policy has not been enforced or applied yet), Finished (the policy was applied), Failed (the policy was not applied), or InProgress (the policy is being applied now). </p>"]}
    [@@ocaml.doc "<p>One or more policies assigned to a parameter.</p>"]
    let make ?policy_text  ?policy_type  ?policy_status  () =
      { policy_text; policy_type; policy_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.policy_status
              (fun f -> ("policy_status", (String.to_json f)));
           Util.option_map v.policy_type
             (fun f -> ("policy_type", (String.to_json f)));
           Util.option_map v.policy_text
             (fun f -> ("policy_text", (String.to_json f)))])
    let of_json j =
      {
        policy_text =
          (Util.option_map (Json.lookup j "policy_text") String.of_json);
        policy_type =
          (Util.option_map (Json.lookup j "policy_type") String.of_json);
        policy_status =
          (Util.option_map (Json.lookup j "policy_status") String.of_json)
      }
  end[@@ocaml.doc "<p>One or more policies assigned to a parameter.</p>"]
module NotificationEventList =
  struct
    type t = NotificationEvent.t list
    let make elems () = elems
    let to_query v = Query.to_query_list NotificationEvent.to_query v
    let to_headers v = Headers.to_headers_list NotificationEvent.to_headers v
    let to_json v = `List (List.map NotificationEvent.to_json v)
    let of_json j = Json.to_list NotificationEvent.of_json j
  end
module NotificationType =
  struct
    type t =
      | Command 
      | Invocation 
    let str_to_t = [("Invocation", Invocation); ("Command", Command)]
    let t_to_str = [(Invocation, "Invocation"); (Command, "Command")]
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
module InstanceAssociationStatusAggregatedCount =
  struct
    type t = (String.t, Integer.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string Integer.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc -> ((String.to_string k), (Integer.to_json v)) :: acc)
           v [])
    let of_json j = Json.to_hashtbl String.of_string Integer.of_json j
  end
module TargetParameterList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module TargetMap =
  struct
    type t = (String.t, TargetMapValueList.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string TargetMapValueList.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k), (TargetMapValueList.to_json v)) ::
                  acc) v [])
    let of_json j =
      Json.to_hashtbl String.of_string TargetMapValueList.of_json j
  end
module DocumentRequires =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the required SSM document. The name can be an Amazon Resource Name (ARN).</p>"];
      version: String.t option
        [@ocaml.doc
          "<p>The document version required by the current document.</p>"]}
    [@@ocaml.doc "<p>An SSM document required by the current document.</p>"]
    let make ~name  ?version  () = { name; version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version
              (fun f -> ("version", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        version = (Util.option_map (Json.lookup j "version") String.of_json)
      }
  end[@@ocaml.doc "<p>An SSM document required by the current document.</p>"]
module PlatformType =
  struct
    type t =
      | Windows 
      | Linux 
    let str_to_t = [("Linux", Linux); ("Windows", Windows)]
    let t_to_str = [(Linux, "Linux"); (Windows, "Windows")]
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
module Tag =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>The name of the tag.</p>"];
      value: String.t [@ocaml.doc "<p>The value of the tag.</p>"]}[@@ocaml.doc
                                                                    "<p>Metadata that you assign to your AWS resources. Tags enable you to categorize your resources in different ways, for example, by purpose, owner, or environment. In Systems Manager, you can apply tags to documents, managed instances, maintenance windows, Parameter Store parameters, and patch baselines.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end[@@ocaml.doc
       "<p>Metadata that you assign to your AWS resources. Tags enable you to categorize your resources in different ways, for example, by purpose, owner, or environment. In Systems Manager, you can apply tags to documents, managed instances, maintenance windows, Parameter Store parameters, and patch baselines.</p>"]
module DocumentParameterType =
  struct
    type t =
      | String 
      | StringList 
    let str_to_t = [("StringList", StringList); ("String", String)]
    let t_to_str = [(StringList, "StringList"); (String, "String")]
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
module InventoryFilterList =
  struct
    type t = InventoryFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryFilter.to_query v
    let to_headers v = Headers.to_headers_list InventoryFilter.to_headers v
    let to_json v = `List (List.map InventoryFilter.to_json v)
    let of_json j = Json.to_list InventoryFilter.of_json j
  end
module AutomationExecutionStatus =
  struct
    type t =
      | Pending 
      | InProgress 
      | Waiting 
      | Success 
      | TimedOut 
      | Cancelling 
      | Cancelled 
      | Failed 
    let str_to_t =
      [("Failed", Failed);
      ("Cancelled", Cancelled);
      ("Cancelling", Cancelling);
      ("TimedOut", TimedOut);
      ("Success", Success);
      ("Waiting", Waiting);
      ("InProgress", InProgress);
      ("Pending", Pending)]
    let t_to_str =
      [(Failed, "Failed");
      (Cancelled, "Cancelled");
      (Cancelling, "Cancelling");
      (TimedOut, "TimedOut");
      (Success, "Success");
      (Waiting, "Waiting");
      (InProgress, "InProgress");
      (Pending, "Pending")]
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
module FailureDetails =
  struct
    type t =
      {
      failure_stage: String.t option
        [@ocaml.doc
          "<p>The stage of the Automation execution when the failure occurred. The stages include the following: InputValidation, PreVerification, Invocation, PostVerification.</p>"];
      failure_type: String.t option
        [@ocaml.doc
          "<p>The type of Automation failure. Failure types include the following: Action, Permission, Throttling, Verification, Internal.</p>"];
      details: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>Detailed information about the Automation step failure.</p>"]}
    [@@ocaml.doc "<p>Information about an Automation failure.</p>"]
    let make ?failure_stage  ?failure_type  ?details  () =
      { failure_stage; failure_type; details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (AutomationParameterMap.to_json f)));
           Util.option_map v.failure_type
             (fun f -> ("failure_type", (String.to_json f)));
           Util.option_map v.failure_stage
             (fun f -> ("failure_stage", (String.to_json f)))])
    let of_json j =
      {
        failure_stage =
          (Util.option_map (Json.lookup j "failure_stage") String.of_json);
        failure_type =
          (Util.option_map (Json.lookup j "failure_type") String.of_json);
        details =
          (Util.option_map (Json.lookup j "details")
             AutomationParameterMap.of_json)
      }
  end[@@ocaml.doc "<p>Information about an Automation failure.</p>"]
module NormalStringMap =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module TargetLocation =
  struct
    type t =
      {
      accounts: Accounts.t
        [@ocaml.doc
          "<p>The AWS accounts targeted by the current Automation execution.</p>"];
      regions: Regions.t
        [@ocaml.doc
          "<p>The AWS Regions targeted by the current Automation execution.</p>"];
      target_location_max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of AWS accounts and AWS regions allowed to run the Automation concurrently </p>"];
      target_location_max_errors: String.t option
        [@ocaml.doc
          "<p>The maximum number of errors allowed before the system stops queueing additional Automation executions for the currently running Automation. </p>"];
      execution_role_name: String.t option
        [@ocaml.doc
          "<p>The Automation execution role used by the currently running Automation.</p>"]}
    [@@ocaml.doc
      "<p>The combination of AWS Regions and accounts targeted by the current Automation execution.</p>"]
    let make ?(accounts= [])  ?(regions= []) 
      ?target_location_max_concurrency  ?target_location_max_errors 
      ?execution_role_name  () =
      {
        accounts;
        regions;
        target_location_max_concurrency;
        target_location_max_errors;
        execution_role_name
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.execution_role_name
              (fun f -> ("execution_role_name", (String.to_json f)));
           Util.option_map v.target_location_max_errors
             (fun f -> ("target_location_max_errors", (String.to_json f)));
           Util.option_map v.target_location_max_concurrency
             (fun f ->
                ("target_location_max_concurrency", (String.to_json f)));
           Some ("regions", (Regions.to_json v.regions));
           Some ("accounts", (Accounts.to_json v.accounts))])
    let of_json j =
      {
        accounts =
          (Accounts.of_json (Util.of_option_exn (Json.lookup j "accounts")));
        regions =
          (Regions.of_json (Util.of_option_exn (Json.lookup j "regions")));
        target_location_max_concurrency =
          (Util.option_map (Json.lookup j "target_location_max_concurrency")
             String.of_json);
        target_location_max_errors =
          (Util.option_map (Json.lookup j "target_location_max_errors")
             String.of_json);
        execution_role_name =
          (Util.option_map (Json.lookup j "execution_role_name")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>The combination of AWS Regions and accounts targeted by the current Automation execution.</p>"]
module Targets =
  struct
    type t = Target.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Target.to_query v
    let to_headers v = Headers.to_headers_list Target.to_headers v
    let to_json v = `List (List.map Target.to_json v)
    let of_json j = Json.to_list Target.of_json j
  end
module ValidNextStepList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module OpsEntityItem =
  struct
    type t =
      {
      capture_time: String.t option
        [@ocaml.doc "<p>The time OpsItem data was captured.</p>"];
      content: OpsEntityItemEntryList.t
        [@ocaml.doc
          "<p>The detailed data content for an OpsItem summaries result item.</p>"]}
    [@@ocaml.doc "<p>The OpsItem summaries result item.</p>"]
    let make ?capture_time  ?(content= [])  () = { capture_time; content }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("content", (OpsEntityItemEntryList.to_json v.content));
           Util.option_map v.capture_time
             (fun f -> ("capture_time", (String.to_json f)))])
    let of_json j =
      {
        capture_time =
          (Util.option_map (Json.lookup j "capture_time") String.of_json);
        content =
          (OpsEntityItemEntryList.of_json
             (Util.of_option_exn (Json.lookup j "content")))
      }
  end[@@ocaml.doc "<p>The OpsItem summaries result item.</p>"]
module PatchComplianceLevel =
  struct
    type t =
      | CRITICAL 
      | HIGH 
      | MEDIUM 
      | LOW 
      | INFORMATIONAL 
      | UNSPECIFIED 
    let str_to_t =
      [("UNSPECIFIED", UNSPECIFIED);
      ("INFORMATIONAL", INFORMATIONAL);
      ("LOW", LOW);
      ("MEDIUM", MEDIUM);
      ("HIGH", HIGH);
      ("CRITICAL", CRITICAL)]
    let t_to_str =
      [(UNSPECIFIED, "UNSPECIFIED");
      (INFORMATIONAL, "INFORMATIONAL");
      (LOW, "LOW");
      (MEDIUM, "MEDIUM");
      (HIGH, "HIGH");
      (CRITICAL, "CRITICAL")]
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
module PatchFilterGroup =
  struct
    type t =
      {
      patch_filters: PatchFilterList.t
        [@ocaml.doc
          "<p>The set of patch filters that make up the group.</p>"]}
    [@@ocaml.doc
      "<p>A set of patch filters, typically used for approval rules.</p>"]
    let make ~patch_filters  () = { patch_filters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("patch_filters", (PatchFilterList.to_json v.patch_filters))])
    let of_json j =
      {
        patch_filters =
          (PatchFilterList.of_json
             (Util.of_option_exn (Json.lookup j "patch_filters")))
      }
  end[@@ocaml.doc
       "<p>A set of patch filters, typically used for approval rules.</p>"]
module AssociationStatusAggregatedCount =
  struct
    type t = (String.t, Integer.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string Integer.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc -> ((String.to_string k), (Integer.to_json v)) :: acc)
           v [])
    let of_json j = Json.to_hashtbl String.of_string Integer.of_json j
  end
module MaintenanceWindowTaskParameterValueExpression =
  struct
    type t =
      {
      values: MaintenanceWindowTaskParameterValueList.t
        [@ocaml.doc
          "<p>This field contains an array of 0 or more strings, each 1 to 255 characters in length.</p>"]}
    [@@ocaml.doc "<p>Defines the values for a task parameter.</p>"]
    let make ?(values= [])  () = { values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("values",
                (MaintenanceWindowTaskParameterValueList.to_json v.values))])
    let of_json j =
      {
        values =
          (MaintenanceWindowTaskParameterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc "<p>Defines the values for a task parameter.</p>"]
module InventoryResultItem =
  struct
    type t =
      {
      type_name: String.t
        [@ocaml.doc "<p>The name of the inventory result item type.</p>"];
      schema_version: String.t
        [@ocaml.doc
          "<p>The schema version for the inventory result item/</p>"];
      capture_time: String.t option
        [@ocaml.doc "<p>The time inventory item data was captured.</p>"];
      content_hash: String.t option
        [@ocaml.doc
          "<p>MD5 hash of the inventory item type contents. The content hash is used to determine whether to update inventory information. The PutInventory API does not update the inventory item type contents if the MD5 hash has not changed since last update. </p>"];
      content: InventoryItemEntryList.t
        [@ocaml.doc
          "<p>Contains all the inventory data of the item type. Results include attribute names and values. </p>"]}
    [@@ocaml.doc "<p>The inventory result item.</p>"]
    let make ~type_name  ~schema_version  ?capture_time  ?content_hash 
      ~content  () =
      { type_name; schema_version; capture_time; content_hash; content }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("content", (InventoryItemEntryList.to_json v.content));
           Util.option_map v.content_hash
             (fun f -> ("content_hash", (String.to_json f)));
           Util.option_map v.capture_time
             (fun f -> ("capture_time", (String.to_json f)));
           Some ("schema_version", (String.to_json v.schema_version));
           Some ("type_name", (String.to_json v.type_name))])
    let of_json j =
      {
        type_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "type_name")));
        schema_version =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "schema_version")));
        capture_time =
          (Util.option_map (Json.lookup j "capture_time") String.of_json);
        content_hash =
          (Util.option_map (Json.lookup j "content_hash") String.of_json);
        content =
          (InventoryItemEntryList.of_json
             (Util.of_option_exn (Json.lookup j "content")))
      }
  end[@@ocaml.doc "<p>The inventory result item.</p>"]
module SeveritySummary =
  struct
    type t =
      {
      critical_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources or compliance items that have a severity level of critical. Critical severity is determined by the organization that published the compliance items.</p>"];
      high_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources or compliance items that have a severity level of high. High severity is determined by the organization that published the compliance items.</p>"];
      medium_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources or compliance items that have a severity level of medium. Medium severity is determined by the organization that published the compliance items.</p>"];
      low_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources or compliance items that have a severity level of low. Low severity is determined by the organization that published the compliance items.</p>"];
      informational_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources or compliance items that have a severity level of informational. Informational severity is determined by the organization that published the compliance items.</p>"];
      unspecified_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources or compliance items that have a severity level of unspecified. Unspecified severity is determined by the organization that published the compliance items.</p>"]}
    [@@ocaml.doc
      "<p>The number of managed instances found for each patch severity level defined in the request filter.</p>"]
    let make ?critical_count  ?high_count  ?medium_count  ?low_count 
      ?informational_count  ?unspecified_count  () =
      {
        critical_count;
        high_count;
        medium_count;
        low_count;
        informational_count;
        unspecified_count
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.unspecified_count
              (fun f -> ("unspecified_count", (Integer.to_json f)));
           Util.option_map v.informational_count
             (fun f -> ("informational_count", (Integer.to_json f)));
           Util.option_map v.low_count
             (fun f -> ("low_count", (Integer.to_json f)));
           Util.option_map v.medium_count
             (fun f -> ("medium_count", (Integer.to_json f)));
           Util.option_map v.high_count
             (fun f -> ("high_count", (Integer.to_json f)));
           Util.option_map v.critical_count
             (fun f -> ("critical_count", (Integer.to_json f)))])
    let of_json j =
      {
        critical_count =
          (Util.option_map (Json.lookup j "critical_count") Integer.of_json);
        high_count =
          (Util.option_map (Json.lookup j "high_count") Integer.of_json);
        medium_count =
          (Util.option_map (Json.lookup j "medium_count") Integer.of_json);
        low_count =
          (Util.option_map (Json.lookup j "low_count") Integer.of_json);
        informational_count =
          (Util.option_map (Json.lookup j "informational_count")
             Integer.of_json);
        unspecified_count =
          (Util.option_map (Json.lookup j "unspecified_count")
             Integer.of_json)
      }
  end[@@ocaml.doc
       "<p>The number of managed instances found for each patch severity level defined in the request filter.</p>"]
module OpsItemDataValue =
  struct
    type t =
      {
      value: String.t option
        [@ocaml.doc "<p>The value of the OperationalData key.</p>"];
      type_: OpsItemDataType.t option
        [@ocaml.doc
          "<p>The type of key-value pair. Valid types include <code>SearchableString</code> and <code>String</code>.</p>"]}
    [@@ocaml.doc
      "<p>An object that defines the value of the key and its type in the OperationalData map.</p>"]
    let make ?value  ?type_  () = { value; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (OpsItemDataType.to_json f)));
           Util.option_map v.value (fun f -> ("value", (String.to_json f)))])
    let of_json j =
      {
        value = (Util.option_map (Json.lookup j "value") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_") OpsItemDataType.of_json)
      }
  end[@@ocaml.doc
       "<p>An object that defines the value of the key and its type in the OperationalData map.</p>"]
module OpsFilterOperatorType =
  struct
    type t =
      | Equal 
      | NotEqual 
      | BeginWith 
      | LessThan 
      | GreaterThan 
      | Exists 
    let str_to_t =
      [("Exists", Exists);
      ("GreaterThan", GreaterThan);
      ("LessThan", LessThan);
      ("BeginWith", BeginWith);
      ("NotEqual", NotEqual);
      ("Equal", Equal)]
    let t_to_str =
      [(Exists, "Exists");
      (GreaterThan, "GreaterThan");
      (LessThan, "LessThan");
      (BeginWith, "BeginWith");
      (NotEqual, "NotEqual");
      (Equal, "Equal")]
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
module OpsFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PatchDeploymentStatus =
  struct
    type t =
      | APPROVED 
      | PENDING_APPROVAL 
      | EXPLICIT_APPROVED 
      | EXPLICIT_REJECTED 
    let str_to_t =
      [("EXPLICIT_REJECTED", EXPLICIT_REJECTED);
      ("EXPLICIT_APPROVED", EXPLICIT_APPROVED);
      ("PENDING_APPROVAL", PENDING_APPROVAL);
      ("APPROVED", APPROVED)]
    let t_to_str =
      [(EXPLICIT_REJECTED, "EXPLICIT_REJECTED");
      (EXPLICIT_APPROVED, "EXPLICIT_APPROVED");
      (PENDING_APPROVAL, "PENDING_APPROVAL");
      (APPROVED, "APPROVED")]
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
module AssociationStatusName =
  struct
    type t =
      | Pending 
      | Success 
      | Failed 
    let str_to_t =
      [("Failed", Failed); ("Success", Success); ("Pending", Pending)]
    let t_to_str =
      [(Failed, "Failed"); (Success, "Success"); (Pending, "Pending")]
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
module AssociationComplianceSeverity =
  struct
    type t =
      | CRITICAL 
      | HIGH 
      | MEDIUM 
      | LOW 
      | UNSPECIFIED 
    let str_to_t =
      [("UNSPECIFIED", UNSPECIFIED);
      ("LOW", LOW);
      ("MEDIUM", MEDIUM);
      ("HIGH", HIGH);
      ("CRITICAL", CRITICAL)]
    let t_to_str =
      [(UNSPECIFIED, "UNSPECIFIED");
      (LOW, "LOW");
      (MEDIUM, "MEDIUM");
      (HIGH, "HIGH");
      (CRITICAL, "CRITICAL")]
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
module InstanceAssociationOutputLocation =
  struct
    type t =
      {
      s3_location: S3OutputLocation.t option
        [@ocaml.doc
          "<p>An Amazon S3 bucket where you want to store the results of this request.</p>"]}
    [@@ocaml.doc
      "<p>An Amazon S3 bucket where you want to store the results of this request.</p>"]
    let make ?s3_location  () = { s3_location }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.s3_location
              (fun f -> ("s3_location", (S3OutputLocation.to_json f)))])
    let of_json j =
      {
        s3_location =
          (Util.option_map (Json.lookup j "s3_location")
             S3OutputLocation.of_json)
      }
  end[@@ocaml.doc
       "<p>An Amazon S3 bucket where you want to store the results of this request.</p>"]
module Parameters =
  struct
    type t = (String.t, ParameterValueList.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string ParameterValueList.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k), (ParameterValueList.to_json v)) ::
                  acc) v [])
    let of_json j =
      Json.to_hashtbl String.of_string ParameterValueList.of_json j
  end
module InventoryDeletionSummaryItems =
  struct
    type t = InventoryDeletionSummaryItem.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list InventoryDeletionSummaryItem.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryDeletionSummaryItem.to_headers v
    let to_json v = `List (List.map InventoryDeletionSummaryItem.to_json v)
    let of_json j = Json.to_list InventoryDeletionSummaryItem.of_json j
  end
module S3OutputUrl =
  struct
    type t =
      {
      output_url: String.t option
        [@ocaml.doc
          "<p>A URL for an Amazon S3 bucket where you want to store the results of this request.</p>"]}
    [@@ocaml.doc
      "<p>A URL for the Amazon S3 bucket where you want to store the results of this request.</p>"]
    let make ?output_url  () = { output_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_url
              (fun f -> ("output_url", (String.to_json f)))])
    let of_json j =
      {
        output_url =
          (Util.option_map (Json.lookup j "output_url") String.of_json)
      }
  end[@@ocaml.doc
       "<p>A URL for the Amazon S3 bucket where you want to store the results of this request.</p>"]
module InventoryItemAttribute =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc "<p>Name of the inventory item attribute.</p>"];
      data_type: InventoryAttributeDataType.t
        [@ocaml.doc "<p>The data type of the inventory item attribute. </p>"]}
    [@@ocaml.doc
      "<p>Attributes are the entries within the inventory item content. It contains name and value.</p>"]
    let make ~name  ~data_type  () = { name; data_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("data_type", (InventoryAttributeDataType.to_json v.data_type));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        data_type =
          (InventoryAttributeDataType.of_json
             (Util.of_option_exn (Json.lookup j "data_type")))
      }
  end[@@ocaml.doc
       "<p>Attributes are the entries within the inventory item content. It contains name and value.</p>"]
module CommandPlugin =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>The name of the plugin. Must be one of the following: aws:updateAgent, aws:domainjoin, aws:applications, aws:runPowerShellScript, aws:psmodule, aws:cloudWatch, aws:runShellScript, or aws:updateSSMAgent. </p>"];
      status: CommandPluginStatus.t option
        [@ocaml.doc
          "<p>The status of this plugin. You can run a document with multiple plugins.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>A detailed status of the plugin execution. StatusDetails includes more information than Status because it includes states resulting from error and concurrency control parameters. StatusDetails can show different results than Status. For more information about these statuses, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html\">Understanding Command Statuses</a> in the <i>AWS Systems Manager User Guide</i>. StatusDetails can be one of the following values:</p> <ul> <li> <p>Pending: The command has not been sent to the instance.</p> </li> <li> <p>In Progress: The command has been sent to the instance but has not reached a terminal state.</p> </li> <li> <p>Success: The execution of the command or plugin was successfully completed. This is a terminal state.</p> </li> <li> <p>Delivery Timed Out: The command was not delivered to the instance before the delivery timeout expired. Delivery timeouts do not count against the parent command's MaxErrors limit, but they do contribute to whether the parent command status is Success or Incomplete. This is a terminal state.</p> </li> <li> <p>Execution Timed Out: Command execution started on the instance, but the execution was not complete before the execution timeout expired. Execution timeouts count against the MaxErrors limit of the parent command. This is a terminal state.</p> </li> <li> <p>Failed: The command was not successful on the instance. For a plugin, this indicates that the result code was not zero. For a command invocation, this indicates that the result code for one or more plugins was not zero. Invocation failures count against the MaxErrors limit of the parent command. This is a terminal state.</p> </li> <li> <p>Canceled: The command was terminated before it was completed. This is a terminal state.</p> </li> <li> <p>Undeliverable: The command can't be delivered to the instance. The instance might not exist, or it might not be responding. Undeliverable invocations don't count against the parent command's MaxErrors limit, and they don't contribute to whether the parent command status is Success or Incomplete. This is a terminal state.</p> </li> <li> <p>Terminated: The parent command exceeded its MaxErrors limit and subsequent command invocations were canceled by the system. This is a terminal state.</p> </li> </ul>"];
      response_code: Integer.t option
        [@ocaml.doc
          "<p>A numeric response code generated after running the plugin. </p>"];
      response_start_date_time: DateTime.t option
        [@ocaml.doc "<p>The time the plugin started running. </p>"];
      response_finish_date_time: DateTime.t option
        [@ocaml.doc
          "<p>The time the plugin stopped running. Could stop prematurely if, for example, a cancel command was sent. </p>"];
      output: String.t option
        [@ocaml.doc "<p>Output of the plugin execution.</p>"];
      standard_output_url: String.t option
        [@ocaml.doc
          "<p>The URL for the complete text written by the plugin to stdout in Amazon S3. If the Amazon S3 bucket for the command was not specified, then this string is empty.</p>"];
      standard_error_url: String.t option
        [@ocaml.doc
          "<p>The URL for the complete text written by the plugin to stderr. If execution is not yet complete, then this string is empty.</p>"];
      output_s3_region: String.t option
        [@ocaml.doc
          "<p>(Deprecated) You can no longer specify this parameter. The system ignores it. Instead, Systems Manager automatically determines the Amazon S3 bucket region.</p>"];
      output_s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>The S3 bucket where the responses to the command executions should be stored. This was requested when issuing the command. For example, in the following response:</p> <p> test_folder/ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix/i-1234567876543/awsrunShellScript </p> <p>test_folder is the name of the Amazon S3 bucket;</p> <p> ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix is the name of the S3 prefix;</p> <p>i-1234567876543 is the instance ID;</p> <p>awsrunShellScript is the name of the plugin.</p>"];
      output_s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>The S3 directory path inside the bucket where the responses to the command executions should be stored. This was requested when issuing the command. For example, in the following response:</p> <p> test_folder/ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix/i-1234567876543/awsrunShellScript </p> <p>test_folder is the name of the Amazon S3 bucket;</p> <p> ab19cb99-a030-46dd-9dfc-8eSAMPLEPre-Fix is the name of the S3 prefix;</p> <p>i-1234567876543 is the instance ID;</p> <p>awsrunShellScript is the name of the plugin.</p>"]}
    [@@ocaml.doc "<p>Describes plugin details.</p>"]
    let make ?name  ?status  ?status_details  ?response_code 
      ?response_start_date_time  ?response_finish_date_time  ?output 
      ?standard_output_url  ?standard_error_url  ?output_s3_region 
      ?output_s3_bucket_name  ?output_s3_key_prefix  () =
      {
        name;
        status;
        status_details;
        response_code;
        response_start_date_time;
        response_finish_date_time;
        output;
        standard_output_url;
        standard_error_url;
        output_s3_region;
        output_s3_bucket_name;
        output_s3_key_prefix
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_s3_key_prefix
              (fun f -> ("output_s3_key_prefix", (String.to_json f)));
           Util.option_map v.output_s3_bucket_name
             (fun f -> ("output_s3_bucket_name", (String.to_json f)));
           Util.option_map v.output_s3_region
             (fun f -> ("output_s3_region", (String.to_json f)));
           Util.option_map v.standard_error_url
             (fun f -> ("standard_error_url", (String.to_json f)));
           Util.option_map v.standard_output_url
             (fun f -> ("standard_output_url", (String.to_json f)));
           Util.option_map v.output (fun f -> ("output", (String.to_json f)));
           Util.option_map v.response_finish_date_time
             (fun f -> ("response_finish_date_time", (DateTime.to_json f)));
           Util.option_map v.response_start_date_time
             (fun f -> ("response_start_date_time", (DateTime.to_json f)));
           Util.option_map v.response_code
             (fun f -> ("response_code", (Integer.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (CommandPluginStatus.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             CommandPluginStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        response_code =
          (Util.option_map (Json.lookup j "response_code") Integer.of_json);
        response_start_date_time =
          (Util.option_map (Json.lookup j "response_start_date_time")
             DateTime.of_json);
        response_finish_date_time =
          (Util.option_map (Json.lookup j "response_finish_date_time")
             DateTime.of_json);
        output = (Util.option_map (Json.lookup j "output") String.of_json);
        standard_output_url =
          (Util.option_map (Json.lookup j "standard_output_url")
             String.of_json);
        standard_error_url =
          (Util.option_map (Json.lookup j "standard_error_url")
             String.of_json);
        output_s3_region =
          (Util.option_map (Json.lookup j "output_s3_region") String.of_json);
        output_s3_bucket_name =
          (Util.option_map (Json.lookup j "output_s3_bucket_name")
             String.of_json);
        output_s3_key_prefix =
          (Util.option_map (Json.lookup j "output_s3_key_prefix")
             String.of_json)
      }
  end[@@ocaml.doc "<p>Describes plugin details.</p>"]
module ResourceDataSyncS3Format =
  struct
    type t =
      | JsonSerDe 
    let str_to_t = [("JsonSerDe", JsonSerDe)]
    let t_to_str = [(JsonSerDe, "JsonSerDe")]
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
module ResourceDataSyncAwsOrganizationsSource =
  struct
    type t =
      {
      organization_source_type: String.t
        [@ocaml.doc
          "<p>If an AWS Organization is present, this is either <code>OrganizationalUnits</code> or <code>EntireOrganization</code>. For <code>OrganizationalUnits</code>, the data is aggregated from a set of organization units. For <code>EntireOrganization</code>, the data is aggregated from the entire AWS Organization. </p>"];
      organizational_units: ResourceDataSyncOrganizationalUnitList.t
        [@ocaml.doc
          "<p>The AWS Organizations organization units included in the sync.</p>"]}
    [@@ocaml.doc
      "<p>Information about the AwsOrganizationsSource resource data sync source. A sync source of this type can synchronize data from AWS Organizations or, if an AWS Organization is not present, from multiple AWS Regions.</p>"]
    let make ~organization_source_type  ?(organizational_units= [])  () =
      { organization_source_type; organizational_units }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("organizational_units",
                (ResourceDataSyncOrganizationalUnitList.to_json
                   v.organizational_units));
           Some
             ("organization_source_type",
               (String.to_json v.organization_source_type))])
    let of_json j =
      {
        organization_source_type =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "organization_source_type")));
        organizational_units =
          (ResourceDataSyncOrganizationalUnitList.of_json
             (Util.of_option_exn (Json.lookup j "organizational_units")))
      }
  end[@@ocaml.doc
       "<p>Information about the AwsOrganizationsSource resource data sync source. A sync source of this type can synchronize data from AWS Organizations or, if an AWS Organization is not present, from multiple AWS Regions.</p>"]
module ResourceDataSyncSourceRegionList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module OperatingSystem =
  struct
    type t =
      | WINDOWS 
      | AMAZON_LINUX 
      | AMAZON_LINUX_2 
      | UBUNTU 
      | REDHAT_ENTERPRISE_LINUX 
      | SUSE 
      | CENTOS 
    let str_to_t =
      [("CENTOS", CENTOS);
      ("SUSE", SUSE);
      ("REDHAT_ENTERPRISE_LINUX", REDHAT_ENTERPRISE_LINUX);
      ("UBUNTU", UBUNTU);
      ("AMAZON_LINUX_2", AMAZON_LINUX_2);
      ("AMAZON_LINUX", AMAZON_LINUX);
      ("WINDOWS", WINDOWS)]
    let t_to_str =
      [(CENTOS, "CENTOS");
      (SUSE, "SUSE");
      (REDHAT_ENTERPRISE_LINUX, "REDHAT_ENTERPRISE_LINUX");
      (UBUNTU, "UBUNTU");
      (AMAZON_LINUX_2, "AMAZON_LINUX_2");
      (AMAZON_LINUX, "AMAZON_LINUX");
      (WINDOWS, "WINDOWS")]
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
module ComplianceQueryOperatorType =
  struct
    type t =
      | EQUAL 
      | NOT_EQUAL 
      | BEGIN_WITH 
      | LESS_THAN 
      | GREATER_THAN 
    let str_to_t =
      [("GREATER_THAN", GREATER_THAN);
      ("LESS_THAN", LESS_THAN);
      ("BEGIN_WITH", BEGIN_WITH);
      ("NOT_EQUAL", NOT_EQUAL);
      ("EQUAL", EQUAL)]
    let t_to_str =
      [(GREATER_THAN, "GREATER_THAN");
      (LESS_THAN, "LESS_THAN");
      (BEGIN_WITH, "BEGIN_WITH");
      (NOT_EQUAL, "NOT_EQUAL");
      (EQUAL, "EQUAL")]
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
module ComplianceStringFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ParameterPolicyList =
  struct
    type t = ParameterInlinePolicy.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParameterInlinePolicy.to_query v
    let to_headers v =
      Headers.to_headers_list ParameterInlinePolicy.to_headers v
    let to_json v = `List (List.map ParameterInlinePolicy.to_json v)
    let of_json j = Json.to_list ParameterInlinePolicy.of_json j
  end
module ParameterTier =
  struct
    type t =
      | Standard 
      | Advanced 
      | Intelligent_Tiering 
    let str_to_t =
      [("Intelligent-Tiering", Intelligent_Tiering);
      ("Advanced", Advanced);
      ("Standard", Standard)]
    let t_to_str =
      [(Intelligent_Tiering, "Intelligent-Tiering");
      (Advanced, "Advanced");
      (Standard, "Standard")]
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
module ParameterType =
  struct
    type t =
      | String 
      | StringList 
      | SecureString 
    let str_to_t =
      [("SecureString", SecureString);
      ("StringList", StringList);
      ("String", String)]
    let t_to_str =
      [(SecureString, "SecureString");
      (StringList, "StringList");
      (String, "String")]
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
module CloudWatchOutputConfig =
  struct
    type t =
      {
      cloud_watch_log_group_name: String.t option
        [@ocaml.doc
          "<p>The name of the CloudWatch log group where you want to send command output. If you don't specify a group name, Systems Manager automatically creates a log group for you. The log group uses the following naming format: aws/ssm/<i>SystemsManagerDocumentName</i>.</p>"];
      cloud_watch_output_enabled: Boolean.t option
        [@ocaml.doc
          "<p>Enables Systems Manager to send command output to CloudWatch Logs.</p>"]}
    [@@ocaml.doc
      "<p>Configuration options for sending command output to CloudWatch Logs.</p>"]
    let make ?cloud_watch_log_group_name  ?cloud_watch_output_enabled  () =
      { cloud_watch_log_group_name; cloud_watch_output_enabled }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_output_enabled
              (fun f -> ("cloud_watch_output_enabled", (Boolean.to_json f)));
           Util.option_map v.cloud_watch_log_group_name
             (fun f -> ("cloud_watch_log_group_name", (String.to_json f)))])
    let of_json j =
      {
        cloud_watch_log_group_name =
          (Util.option_map (Json.lookup j "cloud_watch_log_group_name")
             String.of_json);
        cloud_watch_output_enabled =
          (Util.option_map (Json.lookup j "cloud_watch_output_enabled")
             Boolean.of_json)
      }
  end[@@ocaml.doc
       "<p>Configuration options for sending command output to CloudWatch Logs.</p>"]
module DocumentHashType =
  struct
    type t =
      | Sha256 
      | Sha1 
    let str_to_t = [("Sha1", Sha1); ("Sha256", Sha256)]
    let t_to_str = [(Sha1, "Sha1"); (Sha256, "Sha256")]
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
module NotificationConfig =
  struct
    type t =
      {
      notification_arn: String.t option
        [@ocaml.doc
          "<p>An Amazon Resource Name (ARN) for an Amazon Simple Notification Service (Amazon SNS) topic. Run Command pushes notifications about command status changes to this topic.</p>"];
      notification_events: NotificationEventList.t
        [@ocaml.doc
          "<p>The different events for which you can receive notifications. These events include the following: All (events), InProgress, Success, TimedOut, Cancelled, Failed. To learn more about these events, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/monitoring-sns-notifications.html\">Configuring Amazon SNS Notifications for AWS Systems Manager</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      notification_type: NotificationType.t option
        [@ocaml.doc
          "<p>Command: Receive notification when the status of a command changes. Invocation: For commands sent to multiple instances, receive notification on a per-instance basis when the status of a command changes. </p>"]}
    [@@ocaml.doc "<p>Configurations for sending notifications.</p>"]
    let make ?notification_arn  ?(notification_events= []) 
      ?notification_type  () =
      { notification_arn; notification_events; notification_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.notification_type
              (fun f -> ("notification_type", (NotificationType.to_json f)));
           Some
             ("notification_events",
               (NotificationEventList.to_json v.notification_events));
           Util.option_map v.notification_arn
             (fun f -> ("notification_arn", (String.to_json f)))])
    let of_json j =
      {
        notification_arn =
          (Util.option_map (Json.lookup j "notification_arn") String.of_json);
        notification_events =
          (NotificationEventList.of_json
             (Util.of_option_exn (Json.lookup j "notification_events")));
        notification_type =
          (Util.option_map (Json.lookup j "notification_type")
             NotificationType.of_json)
      }
  end[@@ocaml.doc "<p>Configurations for sending notifications.</p>"]
module AssociationFilterKey =
  struct
    type t =
      | InstanceId 
      | Name 
      | AssociationId 
      | AssociationStatusName 
      | LastExecutedBefore 
      | LastExecutedAfter 
      | AssociationName 
    let str_to_t =
      [("AssociationName", AssociationName);
      ("LastExecutedAfter", LastExecutedAfter);
      ("LastExecutedBefore", LastExecutedBefore);
      ("AssociationStatusName", AssociationStatusName);
      ("AssociationId", AssociationId);
      ("Name", Name);
      ("InstanceId", InstanceId)]
    let t_to_str =
      [(AssociationName, "AssociationName");
      (LastExecutedAfter, "LastExecutedAfter");
      (LastExecutedBefore, "LastExecutedBefore");
      (AssociationStatusName, "AssociationStatusName");
      (AssociationId, "AssociationId");
      (Name, "Name");
      (InstanceId, "InstanceId")]
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
module ParameterLabelList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InstanceAggregatedAssociationOverview =
  struct
    type t =
      {
      detailed_status: String.t option
        [@ocaml.doc
          "<p>Detailed status information about the aggregated associations.</p>"];
      instance_association_status_aggregated_count:
        InstanceAssociationStatusAggregatedCount.t option
        [@ocaml.doc "<p>The number of associations for the instance(s).</p>"]}
    [@@ocaml.doc
      "<p>Status information about the aggregated associations.</p>"]
    let make ?detailed_status  ?instance_association_status_aggregated_count 
      () = { detailed_status; instance_association_status_aggregated_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.instance_association_status_aggregated_count
              (fun f ->
                 ("instance_association_status_aggregated_count",
                   (InstanceAssociationStatusAggregatedCount.to_json f)));
           Util.option_map v.detailed_status
             (fun f -> ("detailed_status", (String.to_json f)))])
    let of_json j =
      {
        detailed_status =
          (Util.option_map (Json.lookup j "detailed_status") String.of_json);
        instance_association_status_aggregated_count =
          (Util.option_map
             (Json.lookup j "instance_association_status_aggregated_count")
             InstanceAssociationStatusAggregatedCount.of_json)
      }
  end[@@ocaml.doc
       "<p>Status information about the aggregated associations.</p>"]
module PingStatus =
  struct
    type t =
      | Online 
      | ConnectionLost 
      | Inactive 
    let str_to_t =
      [("Inactive", Inactive);
      ("ConnectionLost", ConnectionLost);
      ("Online", Online)]
    let t_to_str =
      [(Inactive, "Inactive");
      (ConnectionLost, "ConnectionLost");
      (Online, "Online")]
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
module ResourceType =
  struct
    type t =
      | ManagedInstance 
      | Document 
      | EC2Instance 
    let str_to_t =
      [("EC2Instance", EC2Instance);
      ("Document", Document);
      ("ManagedInstance", ManagedInstance)]
    let t_to_str =
      [(EC2Instance, "EC2Instance");
      (Document, "Document");
      (ManagedInstance, "ManagedInstance")]
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
module DocumentFormat =
  struct
    type t =
      | YAML 
      | JSON 
      | TEXT 
    let str_to_t = [("TEXT", TEXT); ("JSON", JSON); ("YAML", YAML)]
    let t_to_str = [(TEXT, "TEXT"); (JSON, "JSON"); (YAML, "YAML")]
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
module DocumentStatus =
  struct
    type t =
      | Creating 
      | Active 
      | Updating 
      | Deleting 
      | Failed [@@ocaml.doc "<p>The status of a document.</p>"]
    let str_to_t =
      [("Failed", Failed);
      ("Deleting", Deleting);
      ("Updating", Updating);
      ("Active", Active);
      ("Creating", Creating)]
    let t_to_str =
      [(Failed, "Failed");
      (Deleting, "Deleting");
      (Updating, "Updating");
      (Active, "Active");
      (Creating, "Creating")]
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
  end[@@ocaml.doc "<p>The status of a document.</p>"]
module AssociationExecutionTargetsFilterKey =
  struct
    type t =
      | Status 
      | ResourceId 
      | ResourceType 
    let str_to_t =
      [("ResourceType", ResourceType);
      ("ResourceId", ResourceId);
      ("Status", Status)]
    let t_to_str =
      [(ResourceType, "ResourceType");
      (ResourceId, "ResourceId");
      (Status, "Status")]
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
module StepExecutionFilterKey =
  struct
    type t =
      | StartTimeBefore 
      | StartTimeAfter 
      | StepExecutionStatus 
      | StepExecutionId 
      | StepName 
      | Action 
    let str_to_t =
      [("Action", Action);
      ("StepName", StepName);
      ("StepExecutionId", StepExecutionId);
      ("StepExecutionStatus", StepExecutionStatus);
      ("StartTimeAfter", StartTimeAfter);
      ("StartTimeBefore", StartTimeBefore)]
    let t_to_str =
      [(Action, "Action");
      (StepName, "StepName");
      (StepExecutionId, "StepExecutionId");
      (StepExecutionStatus, "StepExecutionStatus");
      (StartTimeAfter, "StartTimeAfter");
      (StartTimeBefore, "StartTimeBefore")]
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
module StepExecutionFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AutomationType =
  struct
    type t =
      | CrossAccount 
      | Local 
    let str_to_t = [("Local", Local); ("CrossAccount", CrossAccount)]
    let t_to_str = [(Local, "Local"); (CrossAccount, "CrossAccount")]
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
module ExecutionMode =
  struct
    type t =
      | Auto 
      | Interactive 
    let str_to_t = [("Interactive", Interactive); ("Auto", Auto)]
    let t_to_str = [(Interactive, "Interactive"); (Auto, "Auto")]
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
module ResolvedTargets =
  struct
    type t =
      {
      parameter_values: TargetParameterList.t
        [@ocaml.doc
          "<p>A list of parameter values sent to targets that resolved during the Automation execution.</p>"];
      truncated: Boolean.t option
        [@ocaml.doc
          "<p>A boolean value indicating whether the resolved target list is truncated.</p>"]}
    [@@ocaml.doc
      "<p>Information about targets that resolved during the Automation execution.</p>"]
    let make ?(parameter_values= [])  ?truncated  () =
      { parameter_values; truncated }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.truncated
              (fun f -> ("truncated", (Boolean.to_json f)));
           Some
             ("parameter_values",
               (TargetParameterList.to_json v.parameter_values))])
    let of_json j =
      {
        parameter_values =
          (TargetParameterList.of_json
             (Util.of_option_exn (Json.lookup j "parameter_values")));
        truncated =
          (Util.option_map (Json.lookup j "truncated") Boolean.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about targets that resolved during the Automation execution.</p>"]
module TargetMaps =
  struct
    type t = TargetMap.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TargetMap.to_query v
    let to_headers v = Headers.to_headers_list TargetMap.to_headers v
    let to_json v = `List (List.map TargetMap.to_json v)
    let of_json j = Json.to_list TargetMap.of_json j
  end
module DocumentRequiresList =
  struct
    type t = DocumentRequires.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DocumentRequires.to_query v
    let to_headers v = Headers.to_headers_list DocumentRequires.to_headers v
    let to_json v = `List (List.map DocumentRequires.to_json v)
    let of_json j = Json.to_list DocumentRequires.of_json j
  end
module DocumentType =
  struct
    type t =
      | Command 
      | Policy 
      | Automation 
      | Session 
      | Package 
      | ApplicationConfiguration 
      | ApplicationConfigurationSchema 
      | DeploymentStrategy 
      | ChangeCalendar 
    let str_to_t =
      [("ChangeCalendar", ChangeCalendar);
      ("DeploymentStrategy", DeploymentStrategy);
      ("ApplicationConfigurationSchema", ApplicationConfigurationSchema);
      ("ApplicationConfiguration", ApplicationConfiguration);
      ("Package", Package);
      ("Session", Session);
      ("Automation", Automation);
      ("Policy", Policy);
      ("Command", Command)]
    let t_to_str =
      [(ChangeCalendar, "ChangeCalendar");
      (DeploymentStrategy, "DeploymentStrategy");
      (ApplicationConfigurationSchema, "ApplicationConfigurationSchema");
      (ApplicationConfiguration, "ApplicationConfiguration");
      (Package, "Package");
      (Session, "Session");
      (Automation, "Automation");
      (Policy, "Policy");
      (Command, "Command")]
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
module PlatformTypeList =
  struct
    type t = PlatformType.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PlatformType.to_query v
    let to_headers v = Headers.to_headers_list PlatformType.to_headers v
    let to_json v = `List (List.map PlatformType.to_json v)
    let of_json j = Json.to_list PlatformType.of_json j
  end
module TagList =
  struct
    type t = Tag.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_json v = `List (List.map Tag.to_json v)
    let of_json j = Json.to_list Tag.of_json j
  end
module InstanceInformationFilterKey =
  struct
    type t =
      | InstanceIds 
      | AgentVersion 
      | PingStatus 
      | PlatformTypes 
      | ActivationIds 
      | IamRole 
      | ResourceType 
      | AssociationStatus 
    let str_to_t =
      [("AssociationStatus", AssociationStatus);
      ("ResourceType", ResourceType);
      ("IamRole", IamRole);
      ("ActivationIds", ActivationIds);
      ("PlatformTypes", PlatformTypes);
      ("PingStatus", PingStatus);
      ("AgentVersion", AgentVersion);
      ("InstanceIds", InstanceIds)]
    let t_to_str =
      [(AssociationStatus, "AssociationStatus");
      (ResourceType, "ResourceType");
      (IamRole, "IamRole");
      (ActivationIds, "ActivationIds");
      (PlatformTypes, "PlatformTypes");
      (PingStatus, "PingStatus");
      (AgentVersion, "AgentVersion");
      (InstanceIds, "InstanceIds")]
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
module InstanceInformationFilterValueSet =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AttachmentInformation =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of the attachment.</p>"]}
    [@@ocaml.doc
      "<p>An attribute of an attachment, such as the attachment name.</p>"]
    let make ?name  () = { name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      { name = (Util.option_map (Json.lookup j "name") String.of_json) }
  end[@@ocaml.doc
       "<p>An attribute of an attachment, such as the attachment name.</p>"]
module DocumentParameter =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of the parameter.</p>"];
      type_: DocumentParameterType.t option
        [@ocaml.doc
          "<p>The type of parameter. The type can be either String or StringList.</p>"];
      description: String.t option
        [@ocaml.doc
          "<p>A description of what the parameter does, how to use it, the default value, and whether or not the parameter is optional.</p>"];
      default_value: String.t option
        [@ocaml.doc
          "<p>If specified, the default values for the parameters. Parameters without a default value are required. Parameters with a default value are optional.</p>"]}
    [@@ocaml.doc
      "<p>Parameters specified in a System Manager document that run on the server when the command is run. </p>"]
    let make ?name  ?type_  ?description  ?default_value  () =
      { name; type_; description; default_value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_value
              (fun f -> ("default_value", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (DocumentParameterType.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_")
             DocumentParameterType.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        default_value =
          (Util.option_map (Json.lookup j "default_value") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Parameters specified in a System Manager document that run on the server when the command is run. </p>"]
module InventoryGroup =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "<p>The name of the group.</p>"];
      filters: InventoryFilterList.t
        [@ocaml.doc
          "<p>Filters define the criteria for the group. The <code>matchingCount</code> field displays the number of resources that match the criteria. The <code>notMatchingCount</code> field displays the number of resources that don't match the criteria. </p>"]}
    [@@ocaml.doc
      "<p>A user-defined set of one or more filters on which to aggregate inventory data. Groups return a count of resources that match and don't match the specified criteria.</p>"]
    let make ~name  ~filters  () = { name; filters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filters", (InventoryFilterList.to_json v.filters));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        filters =
          (InventoryFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")))
      }
  end[@@ocaml.doc
       "<p>A user-defined set of one or more filters on which to aggregate inventory data. Groups return a count of resources that match and don't match the specified criteria.</p>"]
module StepExecution =
  struct
    type t =
      {
      step_name: String.t option
        [@ocaml.doc "<p>The name of this execution step.</p>"];
      action: String.t option
        [@ocaml.doc
          "<p>The action this step performs. The action determines the behavior of the step.</p>"];
      timeout_seconds: Long.t option
        [@ocaml.doc "<p>The timeout seconds of the step.</p>"];
      on_failure: String.t option
        [@ocaml.doc
          "<p>The action to take if the step fails. The default value is Abort.</p>"];
      max_attempts: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of tries to run the action of the step. The default value is 1.</p>"];
      execution_start_time: DateTime.t option
        [@ocaml.doc
          "<p>If a step has begun execution, this contains the time the step started. If the step is in Pending status, this field is not populated.</p>"];
      execution_end_time: DateTime.t option
        [@ocaml.doc
          "<p>If a step has finished execution, this contains the time the execution ended. If the step has not yet concluded, this field is not populated.</p>"];
      step_status: AutomationExecutionStatus.t option
        [@ocaml.doc
          "<p>The execution status for this step. Valid values include: Pending, InProgress, Success, Cancelled, Failed, and TimedOut.</p>"];
      response_code: String.t option
        [@ocaml.doc
          "<p>The response code returned by the execution of the step.</p>"];
      inputs: NormalStringMap.t option
        [@ocaml.doc
          "<p>Fully-resolved values passed into the step before execution.</p>"];
      outputs: AutomationParameterMap.t option
        [@ocaml.doc "<p>Returned values from the execution of the step.</p>"];
      response: String.t option
        [@ocaml.doc
          "<p>A message associated with the response code for an execution.</p>"];
      failure_message: String.t option
        [@ocaml.doc
          "<p>If a step failed, this message explains why the execution failed.</p>"];
      failure_details: FailureDetails.t option
        [@ocaml.doc "<p>Information about the Automation failure.</p>"];
      step_execution_id: String.t option
        [@ocaml.doc "<p>The unique ID of a step execution.</p>"];
      overridden_parameters: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>A user-specified list of parameters to override when running a step.</p>"];
      is_end: Boolean.t option
        [@ocaml.doc
          "<p>The flag which can be used to end automation no matter whether the step succeeds or fails.</p>"];
      next_step: String.t option
        [@ocaml.doc "<p>The next step after the step succeeds.</p>"];
      is_critical: Boolean.t option
        [@ocaml.doc
          "<p>The flag which can be used to help decide whether the failure of current step leads to the Automation failure.</p>"];
      valid_next_steps: ValidNextStepList.t
        [@ocaml.doc
          "<p>Strategies used when step fails, we support Continue and Abort. Abort will fail the automation when the step fails. Continue will ignore the failure of current step and allow automation to run the next step. With conditional branching, we add step:stepName to support the automation to go to another specific step.</p>"];
      targets: Targets.t
        [@ocaml.doc "<p>The targets for the step execution.</p>"];
      target_location: TargetLocation.t option
        [@ocaml.doc
          "<p>The combination of AWS Regions and accounts targeted by the current Automation execution.</p>"]}
    [@@ocaml.doc
      "<p>Detailed information about an the execution state of an Automation step.</p>"]
    let make ?step_name  ?action  ?timeout_seconds  ?on_failure 
      ?max_attempts  ?execution_start_time  ?execution_end_time  ?step_status
       ?response_code  ?inputs  ?outputs  ?response  ?failure_message 
      ?failure_details  ?step_execution_id  ?overridden_parameters  ?is_end 
      ?next_step  ?is_critical  ?(valid_next_steps= [])  ?(targets= []) 
      ?target_location  () =
      {
        step_name;
        action;
        timeout_seconds;
        on_failure;
        max_attempts;
        execution_start_time;
        execution_end_time;
        step_status;
        response_code;
        inputs;
        outputs;
        response;
        failure_message;
        failure_details;
        step_execution_id;
        overridden_parameters;
        is_end;
        next_step;
        is_critical;
        valid_next_steps;
        targets;
        target_location
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.target_location
              (fun f -> ("target_location", (TargetLocation.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Some
             ("valid_next_steps",
               (ValidNextStepList.to_json v.valid_next_steps));
           Util.option_map v.is_critical
             (fun f -> ("is_critical", (Boolean.to_json f)));
           Util.option_map v.next_step
             (fun f -> ("next_step", (String.to_json f)));
           Util.option_map v.is_end
             (fun f -> ("is_end", (Boolean.to_json f)));
           Util.option_map v.overridden_parameters
             (fun f ->
                ("overridden_parameters", (AutomationParameterMap.to_json f)));
           Util.option_map v.step_execution_id
             (fun f -> ("step_execution_id", (String.to_json f)));
           Util.option_map v.failure_details
             (fun f -> ("failure_details", (FailureDetails.to_json f)));
           Util.option_map v.failure_message
             (fun f -> ("failure_message", (String.to_json f)));
           Util.option_map v.response
             (fun f -> ("response", (String.to_json f)));
           Util.option_map v.outputs
             (fun f -> ("outputs", (AutomationParameterMap.to_json f)));
           Util.option_map v.inputs
             (fun f -> ("inputs", (NormalStringMap.to_json f)));
           Util.option_map v.response_code
             (fun f -> ("response_code", (String.to_json f)));
           Util.option_map v.step_status
             (fun f -> ("step_status", (AutomationExecutionStatus.to_json f)));
           Util.option_map v.execution_end_time
             (fun f -> ("execution_end_time", (DateTime.to_json f)));
           Util.option_map v.execution_start_time
             (fun f -> ("execution_start_time", (DateTime.to_json f)));
           Util.option_map v.max_attempts
             (fun f -> ("max_attempts", (Integer.to_json f)));
           Util.option_map v.on_failure
             (fun f -> ("on_failure", (String.to_json f)));
           Util.option_map v.timeout_seconds
             (fun f -> ("timeout_seconds", (Long.to_json f)));
           Util.option_map v.action (fun f -> ("action", (String.to_json f)));
           Util.option_map v.step_name
             (fun f -> ("step_name", (String.to_json f)))])
    let of_json j =
      {
        step_name =
          (Util.option_map (Json.lookup j "step_name") String.of_json);
        action = (Util.option_map (Json.lookup j "action") String.of_json);
        timeout_seconds =
          (Util.option_map (Json.lookup j "timeout_seconds") Long.of_json);
        on_failure =
          (Util.option_map (Json.lookup j "on_failure") String.of_json);
        max_attempts =
          (Util.option_map (Json.lookup j "max_attempts") Integer.of_json);
        execution_start_time =
          (Util.option_map (Json.lookup j "execution_start_time")
             DateTime.of_json);
        execution_end_time =
          (Util.option_map (Json.lookup j "execution_end_time")
             DateTime.of_json);
        step_status =
          (Util.option_map (Json.lookup j "step_status")
             AutomationExecutionStatus.of_json);
        response_code =
          (Util.option_map (Json.lookup j "response_code") String.of_json);
        inputs =
          (Util.option_map (Json.lookup j "inputs") NormalStringMap.of_json);
        outputs =
          (Util.option_map (Json.lookup j "outputs")
             AutomationParameterMap.of_json);
        response =
          (Util.option_map (Json.lookup j "response") String.of_json);
        failure_message =
          (Util.option_map (Json.lookup j "failure_message") String.of_json);
        failure_details =
          (Util.option_map (Json.lookup j "failure_details")
             FailureDetails.of_json);
        step_execution_id =
          (Util.option_map (Json.lookup j "step_execution_id") String.of_json);
        overridden_parameters =
          (Util.option_map (Json.lookup j "overridden_parameters")
             AutomationParameterMap.of_json);
        is_end = (Util.option_map (Json.lookup j "is_end") Boolean.of_json);
        next_step =
          (Util.option_map (Json.lookup j "next_step") String.of_json);
        is_critical =
          (Util.option_map (Json.lookup j "is_critical") Boolean.of_json);
        valid_next_steps =
          (ValidNextStepList.of_json
             (Util.of_option_exn (Json.lookup j "valid_next_steps")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        target_location =
          (Util.option_map (Json.lookup j "target_location")
             TargetLocation.of_json)
      }
  end[@@ocaml.doc
       "<p>Detailed information about an the execution state of an Automation step.</p>"]
module AssociationExecutionFilterKey =
  struct
    type t =
      | ExecutionId 
      | Status 
      | CreatedTime 
    let str_to_t =
      [("CreatedTime", CreatedTime);
      ("Status", Status);
      ("ExecutionId", ExecutionId)]
    let t_to_str =
      [(CreatedTime, "CreatedTime");
      (Status, "Status");
      (ExecutionId, "ExecutionId")]
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
module AssociationFilterOperatorType =
  struct
    type t =
      | EQUAL 
      | LESS_THAN 
      | GREATER_THAN 
    let str_to_t =
      [("GREATER_THAN", GREATER_THAN);
      ("LESS_THAN", LESS_THAN);
      ("EQUAL", EQUAL)]
    let t_to_str =
      [(GREATER_THAN, "GREATER_THAN");
      (LESS_THAN, "LESS_THAN");
      (EQUAL, "EQUAL")]
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
module OpsEntityItemMap =
  struct
    type t = (String.t, OpsEntityItem.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string OpsEntityItem.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc -> ((String.to_string k), (OpsEntityItem.to_json v))
                  :: acc) v [])
    let of_json j = Json.to_hashtbl String.of_string OpsEntityItem.of_json j
  end
module PatchOrchestratorFilterValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PatchRule =
  struct
    type t =
      {
      patch_filter_group: PatchFilterGroup.t
        [@ocaml.doc
          "<p>The patch filter group that defines the criteria for the rule.</p>"];
      compliance_level: PatchComplianceLevel.t option
        [@ocaml.doc
          "<p>A compliance severity level for all approved patches in a patch baseline. Valid compliance severity levels include the following: Unspecified, Critical, High, Medium, Low, and Informational.</p>"];
      approve_after_days: Integer.t
        [@ocaml.doc
          "<p>The number of days after the release date of each patch matched by the rule that the patch is marked as approved in the patch baseline. For example, a value of <code>7</code> means that patches are approved seven days after they are released. </p>"];
      enable_non_security: Boolean.t option
        [@ocaml.doc
          "<p>For instances identified by the approval rule filters, enables a patch baseline to apply non-security updates available in the specified repository. The default value is 'false'. Applies to Linux instances only.</p>"]}
    [@@ocaml.doc "<p>Defines an approval rule for a patch baseline.</p>"]
    let make ~patch_filter_group  ?compliance_level  ~approve_after_days 
      ?enable_non_security  () =
      {
        patch_filter_group;
        compliance_level;
        approve_after_days;
        enable_non_security
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.enable_non_security
              (fun f -> ("enable_non_security", (Boolean.to_json f)));
           Some
             ("approve_after_days", (Integer.to_json v.approve_after_days));
           Util.option_map v.compliance_level
             (fun f -> ("compliance_level", (PatchComplianceLevel.to_json f)));
           Some
             ("patch_filter_group",
               (PatchFilterGroup.to_json v.patch_filter_group))])
    let of_json j =
      {
        patch_filter_group =
          (PatchFilterGroup.of_json
             (Util.of_option_exn (Json.lookup j "patch_filter_group")));
        compliance_level =
          (Util.option_map (Json.lookup j "compliance_level")
             PatchComplianceLevel.of_json);
        approve_after_days =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "approve_after_days")));
        enable_non_security =
          (Util.option_map (Json.lookup j "enable_non_security")
             Boolean.of_json)
      }
  end[@@ocaml.doc "<p>Defines an approval rule for a patch baseline.</p>"]
module PatchSourceProductList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AssociationOverview =
  struct
    type t =
      {
      status: String.t option
        [@ocaml.doc
          "<p>The status of the association. Status can be: Pending, Success, or Failed.</p>"];
      detailed_status: String.t option
        [@ocaml.doc "<p>A detailed status of the association.</p>"];
      association_status_aggregated_count:
        AssociationStatusAggregatedCount.t option
        [@ocaml.doc
          "<p>Returns the number of targets for the association status. For example, if you created an association with two instances, and one of them was successful, this would return the count of instances by status.</p>"]}
    [@@ocaml.doc "<p>Information about the association.</p>"]
    let make ?status  ?detailed_status  ?association_status_aggregated_count 
      () = { status; detailed_status; association_status_aggregated_count }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_status_aggregated_count
              (fun f ->
                 ("association_status_aggregated_count",
                   (AssociationStatusAggregatedCount.to_json f)));
           Util.option_map v.detailed_status
             (fun f -> ("detailed_status", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)))])
    let of_json j =
      {
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        detailed_status =
          (Util.option_map (Json.lookup j "detailed_status") String.of_json);
        association_status_aggregated_count =
          (Util.option_map
             (Json.lookup j "association_status_aggregated_count")
             AssociationStatusAggregatedCount.of_json)
      }
  end[@@ocaml.doc "<p>Information about the association.</p>"]
module SessionManagerOutputUrl =
  struct
    type t =
      {
      s3_output_url: String.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"];
      cloud_watch_output_url: String.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"]}[@@ocaml.doc
                                                         "<p>Reserved for future use.</p>"]
    let make ?s3_output_url  ?cloud_watch_output_url  () =
      { s3_output_url; cloud_watch_output_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_output_url
              (fun f -> ("cloud_watch_output_url", (String.to_json f)));
           Util.option_map v.s3_output_url
             (fun f -> ("s3_output_url", (String.to_json f)))])
    let of_json j =
      {
        s3_output_url =
          (Util.option_map (Json.lookup j "s3_output_url") String.of_json);
        cloud_watch_output_url =
          (Util.option_map (Json.lookup j "cloud_watch_output_url")
             String.of_json)
      }
  end[@@ocaml.doc "<p>Reserved for future use.</p>"]
module SessionStatus =
  struct
    type t =
      | Connected 
      | Connecting 
      | Disconnected 
      | Terminated 
      | Terminating 
      | Failed 
    let str_to_t =
      [("Failed", Failed);
      ("Terminating", Terminating);
      ("Terminated", Terminated);
      ("Disconnected", Disconnected);
      ("Connecting", Connecting);
      ("Connected", Connected)]
    let t_to_str =
      [(Failed, "Failed");
      (Terminating, "Terminating");
      (Terminated, "Terminated");
      (Disconnected, "Disconnected");
      (Connecting, "Connecting");
      (Connected, "Connected")]
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
module ComplianceExecutionSummary =
  struct
    type t =
      {
      execution_time: DateTime.t
        [@ocaml.doc
          "<p>The time the execution ran as a datetime object that is saved in the following format: yyyy-MM-dd'T'HH:mm:ss'Z'.</p>"];
      execution_id: String.t option
        [@ocaml.doc
          "<p>An ID created by the system when <code>PutComplianceItems</code> was called. For example, <code>CommandID</code> is a valid execution ID. You can use this ID in subsequent calls.</p>"];
      execution_type: String.t option
        [@ocaml.doc
          "<p>The type of execution. For example, <code>Command</code> is a valid execution type.</p>"]}
    [@@ocaml.doc
      "<p>A summary of the call execution that includes an execution ID, the type of execution (for example, <code>Command</code>), and the date/time of the execution using a datetime object that is saved in the following format: yyyy-MM-dd'T'HH:mm:ss'Z'.</p>"]
    let make ~execution_time  ?execution_id  ?execution_type  () =
      { execution_time; execution_id; execution_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.execution_type
              (fun f -> ("execution_type", (String.to_json f)));
           Util.option_map v.execution_id
             (fun f -> ("execution_id", (String.to_json f)));
           Some ("execution_time", (DateTime.to_json v.execution_time))])
    let of_json j =
      {
        execution_time =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "execution_time")));
        execution_id =
          (Util.option_map (Json.lookup j "execution_id") String.of_json);
        execution_type =
          (Util.option_map (Json.lookup j "execution_type") String.of_json)
      }
  end[@@ocaml.doc
       "<p>A summary of the call execution that includes an execution ID, the type of execution (for example, <code>Command</code>), and the date/time of the execution using a datetime object that is saved in the following format: yyyy-MM-dd'T'HH:mm:ss'Z'.</p>"]
module ComplianceItemDetails =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module ComplianceSeverity =
  struct
    type t =
      | CRITICAL 
      | HIGH 
      | MEDIUM 
      | LOW 
      | INFORMATIONAL 
      | UNSPECIFIED 
    let str_to_t =
      [("UNSPECIFIED", UNSPECIFIED);
      ("INFORMATIONAL", INFORMATIONAL);
      ("LOW", LOW);
      ("MEDIUM", MEDIUM);
      ("HIGH", HIGH);
      ("CRITICAL", CRITICAL)]
    let t_to_str =
      [(UNSPECIFIED, "UNSPECIFIED");
      (INFORMATIONAL, "INFORMATIONAL");
      (LOW, "LOW");
      (MEDIUM, "MEDIUM");
      (HIGH, "HIGH");
      (CRITICAL, "CRITICAL")]
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
module ComplianceStatus =
  struct
    type t =
      | COMPLIANT 
      | NON_COMPLIANT 
    let str_to_t =
      [("NON_COMPLIANT", NON_COMPLIANT); ("COMPLIANT", COMPLIANT)]
    let t_to_str =
      [(NON_COMPLIANT, "NON_COMPLIANT"); (COMPLIANT, "COMPLIANT")]
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
module LoggingInfo =
  struct
    type t =
      {
      s3_bucket_name: String.t
        [@ocaml.doc
          "<p>The name of an Amazon S3 bucket where execution logs are stored .</p>"];
      s3_key_prefix: String.t option
        [@ocaml.doc "<p>(Optional) The Amazon S3 bucket subfolder. </p>"];
      s3_region: String.t
        [@ocaml.doc
          "<p>The region where the Amazon S3 bucket is located.</p>"]}
    [@@ocaml.doc
      "<p>Information about an Amazon S3 bucket to write instance-level logs to.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"]
    let make ~s3_bucket_name  ?s3_key_prefix  ~s3_region  () =
      { s3_bucket_name; s3_key_prefix; s3_region }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("s3_region", (String.to_json v.s3_region));
           Util.option_map v.s3_key_prefix
             (fun f -> ("s3_key_prefix", (String.to_json f)));
           Some ("s3_bucket_name", (String.to_json v.s3_bucket_name))])
    let of_json j =
      {
        s3_bucket_name =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "s3_bucket_name")));
        s3_key_prefix =
          (Util.option_map (Json.lookup j "s3_key_prefix") String.of_json);
        s3_region =
          (String.of_json (Util.of_option_exn (Json.lookup j "s3_region")))
      }
  end[@@ocaml.doc
       "<p>Information about an Amazon S3 bucket to write instance-level logs to.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"]
module MaintenanceWindowTaskParameters =
  struct
    type t =
      (String.t, MaintenanceWindowTaskParameterValueExpression.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string
        MaintenanceWindowTaskParameterValueExpression.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k),
                    (MaintenanceWindowTaskParameterValueExpression.to_json v))
                  :: acc) v [])
    let of_json j =
      Json.to_hashtbl String.of_string
        MaintenanceWindowTaskParameterValueExpression.of_json j
  end
module MaintenanceWindowTaskType =
  struct
    type t =
      | RUN_COMMAND 
      | AUTOMATION 
      | STEP_FUNCTIONS 
      | LAMBDA 
    let str_to_t =
      [("LAMBDA", LAMBDA);
      ("STEP_FUNCTIONS", STEP_FUNCTIONS);
      ("AUTOMATION", AUTOMATION);
      ("RUN_COMMAND", RUN_COMMAND)]
    let t_to_str =
      [(LAMBDA, "LAMBDA");
      (STEP_FUNCTIONS, "STEP_FUNCTIONS");
      (AUTOMATION, "AUTOMATION");
      (RUN_COMMAND, "RUN_COMMAND")]
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
module CommandFilterKey =
  struct
    type t =
      | InvokedAfter 
      | InvokedBefore 
      | Status 
      | ExecutionStage 
      | DocumentName 
    let str_to_t =
      [("DocumentName", DocumentName);
      ("ExecutionStage", ExecutionStage);
      ("Status", Status);
      ("InvokedBefore", InvokedBefore);
      ("InvokedAfter", InvokedAfter)]
    let t_to_str =
      [(DocumentName, "DocumentName");
      (ExecutionStage, "ExecutionStage");
      (Status, "Status");
      (InvokedBefore, "InvokedBefore");
      (InvokedAfter, "InvokedAfter")]
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
module InventoryResultItemMap =
  struct
    type t = (String.t, InventoryResultItem.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string InventoryResultItem.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k), (InventoryResultItem.to_json v)) ::
                  acc) v [])
    let of_json j =
      Json.to_hashtbl String.of_string InventoryResultItem.of_json j
  end
module MaintenanceWindowFilterValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CompliantSummary =
  struct
    type t =
      {
      compliant_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of resources that are compliant.</p>"];
      severity_summary: SeveritySummary.t option
        [@ocaml.doc
          "<p>A summary of the compliance severity by compliance type.</p>"]}
    [@@ocaml.doc
      "<p>A summary of resources that are compliant. The summary is organized according to the resource count for each compliance type.</p>"]
    let make ?compliant_count  ?severity_summary  () =
      { compliant_count; severity_summary }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.severity_summary
              (fun f -> ("severity_summary", (SeveritySummary.to_json f)));
           Util.option_map v.compliant_count
             (fun f -> ("compliant_count", (Integer.to_json f)))])
    let of_json j =
      {
        compliant_count =
          (Util.option_map (Json.lookup j "compliant_count") Integer.of_json);
        severity_summary =
          (Util.option_map (Json.lookup j "severity_summary")
             SeveritySummary.of_json)
      }
  end[@@ocaml.doc
       "<p>A summary of resources that are compliant. The summary is organized according to the resource count for each compliance type.</p>"]
module NonCompliantSummary =
  struct
    type t =
      {
      non_compliant_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of compliance items that are not compliant.</p>"];
      severity_summary: SeveritySummary.t option
        [@ocaml.doc
          "<p>A summary of the non-compliance severity by compliance type</p>"]}
    [@@ocaml.doc
      "<p>A summary of resources that are not compliant. The summary is organized according to resource type.</p>"]
    let make ?non_compliant_count  ?severity_summary  () =
      { non_compliant_count; severity_summary }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.severity_summary
              (fun f -> ("severity_summary", (SeveritySummary.to_json f)));
           Util.option_map v.non_compliant_count
             (fun f -> ("non_compliant_count", (Integer.to_json f)))])
    let of_json j =
      {
        non_compliant_count =
          (Util.option_map (Json.lookup j "non_compliant_count")
             Integer.of_json);
        severity_summary =
          (Util.option_map (Json.lookup j "severity_summary")
             SeveritySummary.of_json)
      }
  end[@@ocaml.doc
       "<p>A summary of resources that are not compliant. The summary is organized according to resource type.</p>"]
module InstancePatchStateFilterValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module InstancePatchStateOperatorType =
  struct
    type t =
      | Equal 
      | NotEqual 
      | LessThan 
      | GreaterThan 
    let str_to_t =
      [("GreaterThan", GreaterThan);
      ("LessThan", LessThan);
      ("NotEqual", NotEqual);
      ("Equal", Equal)]
    let t_to_str =
      [(GreaterThan, "GreaterThan");
      (LessThan, "LessThan");
      (NotEqual, "NotEqual");
      (Equal, "Equal")]
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
module OutputSource =
  struct
    type t =
      {
      output_source_id: String.t option
        [@ocaml.doc
          "<p>The ID of the output source, for example the URL of an Amazon S3 bucket.</p>"];
      output_source_type: String.t option
        [@ocaml.doc
          "<p>The type of source where the association execution details are stored, for example, Amazon S3.</p>"]}
    [@@ocaml.doc
      "<p>Information about the source where the association execution details are stored.</p>"]
    let make ?output_source_id  ?output_source_type  () =
      { output_source_id; output_source_type }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_source_type
              (fun f -> ("output_source_type", (String.to_json f)));
           Util.option_map v.output_source_id
             (fun f -> ("output_source_id", (String.to_json f)))])
    let of_json j =
      {
        output_source_id =
          (Util.option_map (Json.lookup j "output_source_id") String.of_json);
        output_source_type =
          (Util.option_map (Json.lookup j "output_source_type")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about the source where the association execution details are stored.</p>"]
module PatchOperationType =
  struct
    type t =
      | Scan 
      | Install 
    let str_to_t = [("Install", Install); ("Scan", Scan)]
    let t_to_str = [(Install, "Install"); (Scan, "Scan")]
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
module RebootOption =
  struct
    type t =
      | RebootIfNeeded 
      | NoReboot 
    let str_to_t =
      [("NoReboot", NoReboot); ("RebootIfNeeded", RebootIfNeeded)]
    let t_to_str =
      [(NoReboot, "NoReboot"); (RebootIfNeeded, "RebootIfNeeded")]
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
module AutomationExecutionFilterKey =
  struct
    type t =
      | DocumentNamePrefix 
      | ExecutionStatus 
      | ExecutionId 
      | ParentExecutionId 
      | CurrentAction 
      | StartTimeBefore 
      | StartTimeAfter 
      | AutomationType 
      | TagKey 
    let str_to_t =
      [("TagKey", TagKey);
      ("AutomationType", AutomationType);
      ("StartTimeAfter", StartTimeAfter);
      ("StartTimeBefore", StartTimeBefore);
      ("CurrentAction", CurrentAction);
      ("ParentExecutionId", ParentExecutionId);
      ("ExecutionId", ExecutionId);
      ("ExecutionStatus", ExecutionStatus);
      ("DocumentNamePrefix", DocumentNamePrefix)]
    let t_to_str =
      [(TagKey, "TagKey");
      (AutomationType, "AutomationType");
      (StartTimeAfter, "StartTimeAfter");
      (StartTimeBefore, "StartTimeBefore");
      (CurrentAction, "CurrentAction");
      (ParentExecutionId, "ParentExecutionId");
      (ExecutionId, "ExecutionId");
      (ExecutionStatus, "ExecutionStatus");
      (DocumentNamePrefix, "DocumentNamePrefix")]
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
module AutomationExecutionFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CommandStatus =
  struct
    type t =
      | Pending 
      | InProgress 
      | Success 
      | Cancelled 
      | Failed 
      | TimedOut 
      | Cancelling 
    let str_to_t =
      [("Cancelling", Cancelling);
      ("TimedOut", TimedOut);
      ("Failed", Failed);
      ("Cancelled", Cancelled);
      ("Success", Success);
      ("InProgress", InProgress);
      ("Pending", Pending)]
    let t_to_str =
      [(Cancelling, "Cancelling");
      (TimedOut, "TimedOut");
      (Failed, "Failed");
      (Cancelled, "Cancelled");
      (Success, "Success");
      (InProgress, "InProgress");
      (Pending, "Pending")]
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
module InstanceIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module MaintenanceWindowResourceType =
  struct
    type t =
      | INSTANCE 
      | RESOURCE_GROUP 
    let str_to_t =
      [("RESOURCE_GROUP", RESOURCE_GROUP); ("INSTANCE", INSTANCE)]
    let t_to_str =
      [(RESOURCE_GROUP, "RESOURCE_GROUP"); (INSTANCE, "INSTANCE")]
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
module OpsItemOperationalData =
  struct
    type t = (String.t, OpsItemDataValue.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string OpsItemDataValue.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k), (OpsItemDataValue.to_json v)) :: acc)
           v [])
    let of_json j =
      Json.to_hashtbl String.of_string OpsItemDataValue.of_json j
  end
module OpsItemStatus =
  struct
    type t =
      | Open 
      | InProgress 
      | Resolved 
    let str_to_t =
      [("Resolved", Resolved); ("InProgress", InProgress); ("Open", Open)]
    let t_to_str =
      [(Resolved, "Resolved"); (InProgress, "InProgress"); (Open, "Open")]
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
module OpsFilter =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>The name of the filter.</p>"];
      values: OpsFilterValueList.t [@ocaml.doc "<p>The filter value.</p>"];
      type_: OpsFilterOperatorType.t option
        [@ocaml.doc "<p>The type of filter.</p>"]}[@@ocaml.doc
                                                    "<p>A filter for viewing OpsItem summaries.</p>"]
    let make ~key  ~values  ?type_  () = { key; values; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (OpsFilterOperatorType.to_json f)));
           Some ("values", (OpsFilterValueList.to_json v.values));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        values =
          (OpsFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")));
        type_ =
          (Util.option_map (Json.lookup j "type_")
             OpsFilterOperatorType.of_json)
      }
  end[@@ocaml.doc "<p>A filter for viewing OpsItem summaries.</p>"]
module PatchComplianceDataState =
  struct
    type t =
      | INSTALLED 
      | INSTALLED_OTHER 
      | INSTALLED_PENDING_REBOOT 
      | INSTALLED_REJECTED 
      | MISSING 
      | NOT_APPLICABLE 
      | FAILED 
    let str_to_t =
      [("FAILED", FAILED);
      ("NOT_APPLICABLE", NOT_APPLICABLE);
      ("MISSING", MISSING);
      ("INSTALLED_REJECTED", INSTALLED_REJECTED);
      ("INSTALLED_PENDING_REBOOT", INSTALLED_PENDING_REBOOT);
      ("INSTALLED_OTHER", INSTALLED_OTHER);
      ("INSTALLED", INSTALLED)]
    let t_to_str =
      [(FAILED, "FAILED");
      (NOT_APPLICABLE, "NOT_APPLICABLE");
      (MISSING, "MISSING");
      (INSTALLED_REJECTED, "INSTALLED_REJECTED");
      (INSTALLED_PENDING_REBOOT, "INSTALLED_PENDING_REBOOT");
      (INSTALLED_OTHER, "INSTALLED_OTHER");
      (INSTALLED, "INSTALLED")]
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
module DocumentFilterKey =
  struct
    type t =
      | Name 
      | Owner 
      | PlatformTypes 
      | DocumentType 
    let str_to_t =
      [("DocumentType", DocumentType);
      ("PlatformTypes", PlatformTypes);
      ("Owner", Owner);
      ("Name", Name)]
    let t_to_str =
      [(DocumentType, "DocumentType");
      (PlatformTypes, "PlatformTypes");
      (Owner, "Owner");
      (Name, "Name")]
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
module DocumentKeyValuesFilterValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module Patch =
  struct
    type t =
      {
      id: String.t option
        [@ocaml.doc
          "<p>The ID of the patch (this is different than the Microsoft Knowledge Base ID).</p>"];
      release_date: DateTime.t option
        [@ocaml.doc "<p>The date the patch was released.</p>"];
      title: String.t option [@ocaml.doc "<p>The title of the patch.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the patch.</p>"];
      content_url: String.t option
        [@ocaml.doc
          "<p>The URL where more information can be obtained about the patch.</p>"];
      vendor: String.t option
        [@ocaml.doc "<p>The name of the vendor providing the patch.</p>"];
      product_family: String.t option
        [@ocaml.doc
          "<p>The product family the patch is applicable for (for example, Windows).</p>"];
      product: String.t option
        [@ocaml.doc
          "<p>The specific product the patch is applicable for (for example, WindowsServer2016).</p>"];
      classification: String.t option
        [@ocaml.doc
          "<p>The classification of the patch (for example, SecurityUpdates, Updates, CriticalUpdates).</p>"];
      msrc_severity: String.t option
        [@ocaml.doc
          "<p>The severity of the patch (for example Critical, Important, Moderate).</p>"];
      kb_number: String.t option
        [@ocaml.doc "<p>The Microsoft Knowledge Base ID of the patch.</p>"];
      msrc_number: String.t option
        [@ocaml.doc
          "<p>The ID of the MSRC bulletin the patch is related to.</p>"];
      language: String.t option
        [@ocaml.doc
          "<p>The language of the patch if it's language-specific.</p>"]}
    [@@ocaml.doc "<p>Represents metadata about a patch.</p>"]
    let make ?id  ?release_date  ?title  ?description  ?content_url  ?vendor 
      ?product_family  ?product  ?classification  ?msrc_severity  ?kb_number 
      ?msrc_number  ?language  () =
      {
        id;
        release_date;
        title;
        description;
        content_url;
        vendor;
        product_family;
        product;
        classification;
        msrc_severity;
        kb_number;
        msrc_number;
        language
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.language
              (fun f -> ("language", (String.to_json f)));
           Util.option_map v.msrc_number
             (fun f -> ("msrc_number", (String.to_json f)));
           Util.option_map v.kb_number
             (fun f -> ("kb_number", (String.to_json f)));
           Util.option_map v.msrc_severity
             (fun f -> ("msrc_severity", (String.to_json f)));
           Util.option_map v.classification
             (fun f -> ("classification", (String.to_json f)));
           Util.option_map v.product
             (fun f -> ("product", (String.to_json f)));
           Util.option_map v.product_family
             (fun f -> ("product_family", (String.to_json f)));
           Util.option_map v.vendor (fun f -> ("vendor", (String.to_json f)));
           Util.option_map v.content_url
             (fun f -> ("content_url", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.title (fun f -> ("title", (String.to_json f)));
           Util.option_map v.release_date
             (fun f -> ("release_date", (DateTime.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        release_date =
          (Util.option_map (Json.lookup j "release_date") DateTime.of_json);
        title = (Util.option_map (Json.lookup j "title") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        content_url =
          (Util.option_map (Json.lookup j "content_url") String.of_json);
        vendor = (Util.option_map (Json.lookup j "vendor") String.of_json);
        product_family =
          (Util.option_map (Json.lookup j "product_family") String.of_json);
        product = (Util.option_map (Json.lookup j "product") String.of_json);
        classification =
          (Util.option_map (Json.lookup j "classification") String.of_json);
        msrc_severity =
          (Util.option_map (Json.lookup j "msrc_severity") String.of_json);
        kb_number =
          (Util.option_map (Json.lookup j "kb_number") String.of_json);
        msrc_number =
          (Util.option_map (Json.lookup j "msrc_number") String.of_json);
        language =
          (Util.option_map (Json.lookup j "language") String.of_json)
      }
  end[@@ocaml.doc "<p>Represents metadata about a patch.</p>"]
module PatchStatus =
  struct
    type t =
      {
      deployment_status: PatchDeploymentStatus.t option
        [@ocaml.doc
          "<p>The approval status of a patch (APPROVED, PENDING_APPROVAL, EXPLICIT_APPROVED, EXPLICIT_REJECTED).</p>"];
      compliance_level: PatchComplianceLevel.t option
        [@ocaml.doc "<p>The compliance severity level for a patch.</p>"];
      approval_date: DateTime.t option
        [@ocaml.doc
          "<p>The date the patch was approved (or will be approved if the status is PENDING_APPROVAL).</p>"]}
    [@@ocaml.doc "<p>Information about the approval status of a patch.</p>"]
    let make ?deployment_status  ?compliance_level  ?approval_date  () =
      { deployment_status; compliance_level; approval_date }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.approval_date
              (fun f -> ("approval_date", (DateTime.to_json f)));
           Util.option_map v.compliance_level
             (fun f -> ("compliance_level", (PatchComplianceLevel.to_json f)));
           Util.option_map v.deployment_status
             (fun f ->
                ("deployment_status", (PatchDeploymentStatus.to_json f)))])
    let of_json j =
      {
        deployment_status =
          (Util.option_map (Json.lookup j "deployment_status")
             PatchDeploymentStatus.of_json);
        compliance_level =
          (Util.option_map (Json.lookup j "compliance_level")
             PatchComplianceLevel.of_json);
        approval_date =
          (Util.option_map (Json.lookup j "approval_date") DateTime.of_json)
      }
  end[@@ocaml.doc "<p>Information about the approval status of a patch.</p>"]
module AssociationStatus =
  struct
    type t =
      {
      date: DateTime.t
        [@ocaml.doc "<p>The date when the status changed.</p>"];
      name: AssociationStatusName.t [@ocaml.doc "<p>The status.</p>"];
      message: String.t [@ocaml.doc "<p>The reason for the status.</p>"];
      additional_info: String.t option
        [@ocaml.doc "<p>A user-defined string.</p>"]}[@@ocaml.doc
                                                       "<p>Describes an association status.</p>"]
    let make ~date  ~name  ~message  ?additional_info  () =
      { date; name; message; additional_info }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.additional_info
              (fun f -> ("additional_info", (String.to_json f)));
           Some ("message", (String.to_json v.message));
           Some ("name", (AssociationStatusName.to_json v.name));
           Some ("date", (DateTime.to_json v.date))])
    let of_json j =
      {
        date = (DateTime.of_json (Util.of_option_exn (Json.lookup j "date")));
        name =
          (AssociationStatusName.of_json
             (Util.of_option_exn (Json.lookup j "name")));
        message =
          (String.of_json (Util.of_option_exn (Json.lookup j "message")));
        additional_info =
          (Util.option_map (Json.lookup j "additional_info") String.of_json)
      }
  end[@@ocaml.doc "<p>Describes an association status.</p>"]
module CreateAssociationBatchRequestEntry =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name of the SSM document that contains the configuration information for the instance. You can specify Command or Automation documents.</p> <p>You can specify AWS-predefined documents, documents you created, or a document that is shared with you from another account.</p> <p>For SSM documents that are shared with you from other AWS accounts, you must specify the complete SSM document ARN, in the following format:</p> <p> <code>arn:aws:ssm:<i>region</i>:<i>account-id</i>:document/<i>document-name</i> </code> </p> <p>For example:</p> <p> <code>arn:aws:ssm:us-east-2:12345678912:document/My-Shared-Document</code> </p> <p>For AWS-predefined documents and SSM documents you created in your account, you only need to specify the document name. For example, <code>AWS-ApplyPatchBaseline</code> or <code>My-Document</code>.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance. </p>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>A description of the parameters for a document. </p>"];
      automation_target_parameter_name: String.t option
        [@ocaml.doc
          "<p>Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version.</p>"];
      targets: Targets.t
        [@ocaml.doc "<p>The instances targeted by the request.</p>"];
      schedule_expression: String.t option
        [@ocaml.doc
          "<p>A cron expression that specifies a schedule when the association runs.</p>"];
      output_location: InstanceAssociationOutputLocation.t option
        [@ocaml.doc
          "<p>An Amazon S3 bucket where you want to store the results of this request.</p>"];
      association_name: String.t option
        [@ocaml.doc "<p>Specify a descriptive name for the association.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify either an absolute number of errors, for example 10, or a percentage of the target set, for example 10%. If you specify 3, for example, the system stops sending requests when the fourth error is received. If you specify 0, then the system stops sending requests after the first error is returned. If you run an association on 50 instances and set MaxError to 10%, then the system stops sending the request when the sixth error is received.</p> <p>Executions that are already running an association when MaxErrors is reached are allowed to complete, but some of these executions may fail as well. If you need to ensure that there won't be more than max-errors failed executions, set MaxConcurrency to 1 so that executions proceed one at a time.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%. The default value is 100%, which means all targets run the association at the same time.</p> <p>If a new instance starts and attempts to run an association while Systems Manager is running MaxConcurrency associations, the association is allowed to run. During the next association interval, the new instance will process its association within the limit specified for MaxConcurrency.</p>"];
      compliance_severity: AssociationComplianceSeverity.t option
        [@ocaml.doc
          "<p>The severity level to assign to the association.</p>"]}
    [@@ocaml.doc
      "<p>Describes the association of a Systems Manager SSM document and an instance.</p>"]
    let make ~name  ?instance_id  ?parameters 
      ?automation_target_parameter_name  ?document_version  ?(targets= []) 
      ?schedule_expression  ?output_location  ?association_name  ?max_errors 
      ?max_concurrency  ?compliance_severity  () =
      {
        name;
        instance_id;
        parameters;
        automation_target_parameter_name;
        document_version;
        targets;
        schedule_expression;
        output_location;
        association_name;
        max_errors;
        max_concurrency;
        compliance_severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.compliance_severity
              (fun f ->
                 ("compliance_severity",
                   (AssociationComplianceSeverity.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.association_name
             (fun f -> ("association_name", (String.to_json f)));
           Util.option_map v.output_location
             (fun f ->
                ("output_location",
                  (InstanceAssociationOutputLocation.to_json f)));
           Util.option_map v.schedule_expression
             (fun f -> ("schedule_expression", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.automation_target_parameter_name
             (fun f ->
                ("automation_target_parameter_name", (String.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        automation_target_parameter_name =
          (Util.option_map (Json.lookup j "automation_target_parameter_name")
             String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        schedule_expression =
          (Util.option_map (Json.lookup j "schedule_expression")
             String.of_json);
        output_location =
          (Util.option_map (Json.lookup j "output_location")
             InstanceAssociationOutputLocation.of_json);
        association_name =
          (Util.option_map (Json.lookup j "association_name") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        compliance_severity =
          (Util.option_map (Json.lookup j "compliance_severity")
             AssociationComplianceSeverity.of_json)
      }
  end[@@ocaml.doc
       "<p>Describes the association of a Systems Manager SSM document and an instance.</p>"]
module Fault =
  struct
    type t =
      | Client 
      | Server 
      | Unknown 
    let str_to_t =
      [("Unknown", Unknown); ("Server", Server); ("Client", Client)]
    let t_to_str =
      [(Unknown, "Unknown"); (Server, "Server"); (Client, "Client")]
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
module OpsItemNotification =
  struct
    type t =
      {
      arn: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an SNS topic where notifications are sent when this OpsItem is edited or changed.</p>"]}
    [@@ocaml.doc "<p>A notification about the OpsItem.</p>"]
    let make ?arn  () = { arn }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.arn (fun f -> ("arn", (String.to_json f)))])
    let of_json j =
      { arn = (Util.option_map (Json.lookup j "arn") String.of_json) }
  end[@@ocaml.doc "<p>A notification about the OpsItem.</p>"]
module RelatedOpsItem =
  struct
    type t =
      {
      ops_item_id: String.t
        [@ocaml.doc
          "<p>The ID of an OpsItem related to the current OpsItem.</p>"]}
    [@@ocaml.doc
      "<p>An OpsItems that shares something in common with the current OpsItem. For example, related OpsItems can include OpsItems with similar error messages, impacted resources, or statuses for the impacted resource.</p>"]
    let make ~ops_item_id  () = { ops_item_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("ops_item_id", (String.to_json v.ops_item_id))])
    let of_json j =
      {
        ops_item_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "ops_item_id")))
      }
  end[@@ocaml.doc
       "<p>An OpsItems that shares something in common with the current OpsItem. For example, related OpsItems can include OpsItems with similar error messages, impacted resources, or statuses for the impacted resource.</p>"]
module InventoryDeletionStatus =
  struct
    type t =
      | InProgress 
      | Complete 
    let str_to_t = [("Complete", Complete); ("InProgress", InProgress)]
    let t_to_str = [(Complete, "Complete"); (InProgress, "InProgress")]
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
module InventoryDeletionSummary =
  struct
    type t =
      {
      total_count: Integer.t option
        [@ocaml.doc
          "<p>The total number of items to delete. This count does not change during the delete operation.</p>"];
      remaining_count: Integer.t option
        [@ocaml.doc "<p>Remaining number of items to delete.</p>"];
      summary_items: InventoryDeletionSummaryItems.t
        [@ocaml.doc
          "<p>A list of counts and versions for deleted items.</p>"]}
    [@@ocaml.doc "<p>Information about the delete operation.</p>"]
    let make ?total_count  ?remaining_count  ?(summary_items= [])  () =
      { total_count; remaining_count; summary_items }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("summary_items",
                (InventoryDeletionSummaryItems.to_json v.summary_items));
           Util.option_map v.remaining_count
             (fun f -> ("remaining_count", (Integer.to_json f)));
           Util.option_map v.total_count
             (fun f -> ("total_count", (Integer.to_json f)))])
    let of_json j =
      {
        total_count =
          (Util.option_map (Json.lookup j "total_count") Integer.of_json);
        remaining_count =
          (Util.option_map (Json.lookup j "remaining_count") Integer.of_json);
        summary_items =
          (InventoryDeletionSummaryItems.of_json
             (Util.of_option_exn (Json.lookup j "summary_items")))
      }
  end[@@ocaml.doc "<p>Information about the delete operation.</p>"]
module SessionFilterKey =
  struct
    type t =
      | InvokedAfter 
      | InvokedBefore 
      | Target 
      | Owner 
      | Status 
    let str_to_t =
      [("Status", Status);
      ("Owner", Owner);
      ("Target", Target);
      ("InvokedBefore", InvokedBefore);
      ("InvokedAfter", InvokedAfter)]
    let t_to_str =
      [(Status, "Status");
      (Owner, "Owner");
      (Target, "Target");
      (InvokedBefore, "InvokedBefore");
      (InvokedAfter, "InvokedAfter")]
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
module InstanceAssociationOutputUrl =
  struct
    type t =
      {
      s3_output_url: S3OutputUrl.t option
        [@ocaml.doc
          "<p>The URL of Amazon S3 bucket where you want to store the results of this request.</p>"]}
    [@@ocaml.doc
      "<p>The URL of Amazon S3 bucket where you want to store the results of this request.</p>"]
    let make ?s3_output_url  () = { s3_output_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.s3_output_url
              (fun f -> ("s3_output_url", (S3OutputUrl.to_json f)))])
    let of_json j =
      {
        s3_output_url =
          (Util.option_map (Json.lookup j "s3_output_url")
             S3OutputUrl.of_json)
      }
  end[@@ocaml.doc
       "<p>The URL of Amazon S3 bucket where you want to store the results of this request.</p>"]
module InventoryItemAttributeList =
  struct
    type t = InventoryItemAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryItemAttribute.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryItemAttribute.to_headers v
    let to_json v = `List (List.map InventoryItemAttribute.to_json v)
    let of_json j = Json.to_list InventoryItemAttribute.of_json j
  end
module MaintenanceWindowExecutionStatus =
  struct
    type t =
      | PENDING 
      | IN_PROGRESS 
      | SUCCESS 
      | FAILED 
      | TIMED_OUT 
      | CANCELLING 
      | CANCELLED 
      | SKIPPED_OVERLAPPING 
    let str_to_t =
      [("SKIPPED_OVERLAPPING", SKIPPED_OVERLAPPING);
      ("CANCELLED", CANCELLED);
      ("CANCELLING", CANCELLING);
      ("TIMED_OUT", TIMED_OUT);
      ("FAILED", FAILED);
      ("SUCCESS", SUCCESS);
      ("IN_PROGRESS", IN_PROGRESS);
      ("PENDING", PENDING)]
    let t_to_str =
      [(SKIPPED_OVERLAPPING, "SKIPPED_OVERLAPPING");
      (CANCELLED, "CANCELLED");
      (CANCELLING, "CANCELLING");
      (TIMED_OUT, "TIMED_OUT");
      (FAILED, "FAILED");
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
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ParameterStringFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AttachmentsSourceKey =
  struct
    type t =
      | SourceUrl 
      | S3FileUrl 
      | AttachmentReference 
    let str_to_t =
      [("AttachmentReference", AttachmentReference);
      ("S3FileUrl", S3FileUrl);
      ("SourceUrl", SourceUrl)]
    let t_to_str =
      [(AttachmentReference, "AttachmentReference");
      (S3FileUrl, "S3FileUrl");
      (SourceUrl, "SourceUrl")]
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
module AttachmentsSourceValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module DescribeActivationsFilterKeys =
  struct
    type t =
      | ActivationIds 
      | DefaultInstanceName 
      | IamRole 
    let str_to_t =
      [("IamRole", IamRole);
      ("DefaultInstanceName", DefaultInstanceName);
      ("ActivationIds", ActivationIds)]
    let t_to_str =
      [(IamRole, "IamRole");
      (DefaultInstanceName, "DefaultInstanceName");
      (ActivationIds, "ActivationIds")]
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
module StringList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module CommandInvocationStatus =
  struct
    type t =
      | Pending 
      | InProgress 
      | Delayed 
      | Success 
      | Cancelled 
      | TimedOut 
      | Failed 
      | Cancelling 
    let str_to_t =
      [("Cancelling", Cancelling);
      ("Failed", Failed);
      ("TimedOut", TimedOut);
      ("Cancelled", Cancelled);
      ("Success", Success);
      ("Delayed", Delayed);
      ("InProgress", InProgress);
      ("Pending", Pending)]
    let t_to_str =
      [(Cancelling, "Cancelling");
      (Failed, "Failed");
      (TimedOut, "TimedOut");
      (Cancelled, "Cancelled");
      (Success, "Success");
      (Delayed, "Delayed");
      (InProgress, "InProgress");
      (Pending, "Pending")]
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
module CommandPluginList =
  struct
    type t = CommandPlugin.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CommandPlugin.to_query v
    let to_headers v = Headers.to_headers_list CommandPlugin.to_headers v
    let to_json v = `List (List.map CommandPlugin.to_json v)
    let of_json j = Json.to_list CommandPlugin.of_json j
  end
module InventoryItemContentContext =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module OpsItemFilterKey =
  struct
    type t =
      | Status 
      | CreatedBy 
      | Source 
      | Priority 
      | Title 
      | OpsItemId 
      | CreatedTime 
      | LastModifiedTime 
      | OperationalData 
      | OperationalDataKey 
      | OperationalDataValue 
      | ResourceId 
      | AutomationId 
      | Category 
      | Severity 
    let str_to_t =
      [("Severity", Severity);
      ("Category", Category);
      ("AutomationId", AutomationId);
      ("ResourceId", ResourceId);
      ("OperationalDataValue", OperationalDataValue);
      ("OperationalDataKey", OperationalDataKey);
      ("OperationalData", OperationalData);
      ("LastModifiedTime", LastModifiedTime);
      ("CreatedTime", CreatedTime);
      ("OpsItemId", OpsItemId);
      ("Title", Title);
      ("Priority", Priority);
      ("Source", Source);
      ("CreatedBy", CreatedBy);
      ("Status", Status)]
    let t_to_str =
      [(Severity, "Severity");
      (Category, "Category");
      (AutomationId, "AutomationId");
      (ResourceId, "ResourceId");
      (OperationalDataValue, "OperationalDataValue");
      (OperationalDataKey, "OperationalDataKey");
      (OperationalData, "OperationalData");
      (LastModifiedTime, "LastModifiedTime");
      (CreatedTime, "CreatedTime");
      (OpsItemId, "OpsItemId");
      (Title, "Title");
      (Priority, "Priority");
      (Source, "Source");
      (CreatedBy, "CreatedBy");
      (Status, "Status")]
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
module OpsItemFilterOperator =
  struct
    type t =
      | Equal 
      | Contains 
      | GreaterThan 
      | LessThan 
    let str_to_t =
      [("LessThan", LessThan);
      ("GreaterThan", GreaterThan);
      ("Contains", Contains);
      ("Equal", Equal)]
    let t_to_str =
      [(LessThan, "LessThan");
      (GreaterThan, "GreaterThan");
      (Contains, "Contains");
      (Equal, "Equal")]
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
module OpsItemFilterValues =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AttachmentHashType =
  struct
    type t =
      | Sha256 
    let str_to_t = [("Sha256", Sha256)]
    let t_to_str = [(Sha256, "Sha256")]
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
module LastResourceDataSyncStatus =
  struct
    type t =
      | Successful 
      | Failed 
      | InProgress 
    let str_to_t =
      [("InProgress", InProgress);
      ("Failed", Failed);
      ("Successful", Successful)]
    let t_to_str =
      [(InProgress, "InProgress");
      (Failed, "Failed");
      (Successful, "Successful")]
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
module ResourceDataSyncS3Destination =
  struct
    type t =
      {
      bucket_name: String.t
        [@ocaml.doc
          "<p>The name of the Amazon S3 bucket where the aggregated data is stored.</p>"];
      prefix: String.t option
        [@ocaml.doc "<p>An Amazon S3 prefix for the bucket.</p>"];
      sync_format: ResourceDataSyncS3Format.t
        [@ocaml.doc
          "<p>A supported sync format. The following format is currently supported: JsonSerDe</p>"];
      region: String.t
        [@ocaml.doc
          "<p>The AWS Region with the Amazon S3 bucket targeted by the Resource Data Sync.</p>"];
      a_w_s_k_m_s_key_a_r_n: String.t option
        [@ocaml.doc
          "<p>The ARN of an encryption key for a destination in Amazon S3. Must belong to the same Region as the destination Amazon S3 bucket.</p>"]}
    [@@ocaml.doc
      "<p>Information about the target Amazon S3 bucket for the Resource Data Sync.</p>"]
    let make ~bucket_name  ?prefix  ~sync_format  ~region 
      ?a_w_s_k_m_s_key_a_r_n  () =
      { bucket_name; prefix; sync_format; region; a_w_s_k_m_s_key_a_r_n }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.a_w_s_k_m_s_key_a_r_n
              (fun f -> ("a_w_s_k_m_s_key_a_r_n", (String.to_json f)));
           Some ("region", (String.to_json v.region));
           Some
             ("sync_format",
               (ResourceDataSyncS3Format.to_json v.sync_format));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Some ("bucket_name", (String.to_json v.bucket_name))])
    let of_json j =
      {
        bucket_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket_name")));
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        sync_format =
          (ResourceDataSyncS3Format.of_json
             (Util.of_option_exn (Json.lookup j "sync_format")));
        region =
          (String.of_json (Util.of_option_exn (Json.lookup j "region")));
        a_w_s_k_m_s_key_a_r_n =
          (Util.option_map (Json.lookup j "a_w_s_k_m_s_key_a_r_n")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about the target Amazon S3 bucket for the Resource Data Sync.</p>"]
module ResourceDataSyncSourceWithState =
  struct
    type t =
      {
      source_type: String.t option
        [@ocaml.doc
          "<p>The type of data source for the resource data sync. <code>SourceType</code> is either <code>AwsOrganizations</code> (if an organization is present in AWS Organizations) or <code>singleAccountMultiRegions</code>.</p>"];
      aws_organizations_source:
        ResourceDataSyncAwsOrganizationsSource.t option
        [@ocaml.doc
          "<p>The field name in <code>SyncSource</code> for the <code>ResourceDataSyncAwsOrganizationsSource</code> type.</p>"];
      source_regions: ResourceDataSyncSourceRegionList.t
        [@ocaml.doc
          "<p>The <code>SyncSource</code> AWS Regions included in the resource data sync.</p>"];
      include_future_regions: Boolean.t option
        [@ocaml.doc
          "<p>Whether to automatically synchronize and aggregate data from new AWS Regions when those Regions come online.</p>"];
      state: String.t option
        [@ocaml.doc
          "<p>The data type name for including resource data sync state. There are four sync states:</p> <p> <code>OrganizationNotExists</code>: Your organization doesn't exist.</p> <p> <code>NoPermissions</code>: The system can't locate the service-linked role. This role is automatically created when a user creates a resource data sync in Explorer.</p> <p> <code>InvalidOrganizationalUnit</code>: You specified or selected an invalid unit in the resource data sync configuration.</p> <p> <code>TrustedAccessDisabled</code>: You disabled Systems Manager access in the organization in AWS Organizations.</p>"]}
    [@@ocaml.doc
      "<p>The data type name for including resource data sync state. There are four sync states:</p> <p> <code>OrganizationNotExists</code> (Your organization doesn't exist)</p> <p> <code>NoPermissions</code> (The system can't locate the service-linked role. This role is automatically created when a user creates a resource data sync in Explorer.)</p> <p> <code>InvalidOrganizationalUnit</code> (You specified or selected an invalid unit in the resource data sync configuration.)</p> <p> <code>TrustedAccessDisabled</code> (You disabled Systems Manager access in the organization in AWS Organizations.)</p>"]
    let make ?source_type  ?aws_organizations_source  ?(source_regions= []) 
      ?include_future_regions  ?state  () =
      {
        source_type;
        aws_organizations_source;
        source_regions;
        include_future_regions;
        state
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.state (fun f -> ("state", (String.to_json f)));
           Util.option_map v.include_future_regions
             (fun f -> ("include_future_regions", (Boolean.to_json f)));
           Some
             ("source_regions",
               (ResourceDataSyncSourceRegionList.to_json v.source_regions));
           Util.option_map v.aws_organizations_source
             (fun f ->
                ("aws_organizations_source",
                  (ResourceDataSyncAwsOrganizationsSource.to_json f)));
           Util.option_map v.source_type
             (fun f -> ("source_type", (String.to_json f)))])
    let of_json j =
      {
        source_type =
          (Util.option_map (Json.lookup j "source_type") String.of_json);
        aws_organizations_source =
          (Util.option_map (Json.lookup j "aws_organizations_source")
             ResourceDataSyncAwsOrganizationsSource.of_json);
        source_regions =
          (ResourceDataSyncSourceRegionList.of_json
             (Util.of_option_exn (Json.lookup j "source_regions")));
        include_future_regions =
          (Util.option_map (Json.lookup j "include_future_regions")
             Boolean.of_json);
        state = (Util.option_map (Json.lookup j "state") String.of_json)
      }
  end[@@ocaml.doc
       "<p>The data type name for including resource data sync state. There are four sync states:</p> <p> <code>OrganizationNotExists</code> (Your organization doesn't exist)</p> <p> <code>NoPermissions</code> (The system can't locate the service-linked role. This role is automatically created when a user creates a resource data sync in Explorer.)</p> <p> <code>InvalidOrganizationalUnit</code> (You specified or selected an invalid unit in the resource data sync configuration.)</p> <p> <code>TrustedAccessDisabled</code> (You disabled Systems Manager access in the organization in AWS Organizations.)</p>"]
module ParametersFilterKey =
  struct
    type t =
      | Name 
      | Type 
      | KeyId 
    let str_to_t = [("KeyId", KeyId); ("Type", Type); ("Name", Name)]
    let t_to_str = [(KeyId, "KeyId"); (Type, "Type"); (Name, "Name")]
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
module ParametersFilterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PatchBaselineIdentity =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the patch baseline.</p>"];
      baseline_name: String.t option
        [@ocaml.doc "<p>The name of the patch baseline.</p>"];
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>Defines the operating system the patch baseline applies to. The Default value is WINDOWS. </p>"];
      baseline_description: String.t option
        [@ocaml.doc "<p>The description of the patch baseline.</p>"];
      default_baseline: Boolean.t option
        [@ocaml.doc
          "<p>Whether this is the default baseline. Note that Systems Manager supports creating multiple default patch baselines. For example, you can create a default patch baseline for each operating system.</p>"]}
    [@@ocaml.doc
      "<p>Defines the basic information about a patch baseline.</p>"]
    let make ?baseline_id  ?baseline_name  ?operating_system 
      ?baseline_description  ?default_baseline  () =
      {
        baseline_id;
        baseline_name;
        operating_system;
        baseline_description;
        default_baseline
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_baseline
              (fun f -> ("default_baseline", (Boolean.to_json f)));
           Util.option_map v.baseline_description
             (fun f -> ("baseline_description", (String.to_json f)));
           Util.option_map v.operating_system
             (fun f -> ("operating_system", (OperatingSystem.to_json f)));
           Util.option_map v.baseline_name
             (fun f -> ("baseline_name", (String.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        baseline_name =
          (Util.option_map (Json.lookup j "baseline_name") String.of_json);
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json);
        baseline_description =
          (Util.option_map (Json.lookup j "baseline_description")
             String.of_json);
        default_baseline =
          (Util.option_map (Json.lookup j "default_baseline") Boolean.of_json)
      }
  end[@@ocaml.doc
       "<p>Defines the basic information about a patch baseline.</p>"]
module ComplianceStringFilter =
  struct
    type t =
      {
      key: String.t option [@ocaml.doc "<p>The name of the filter.</p>"];
      values: ComplianceStringFilterValueList.t
        [@ocaml.doc "<p>The value for which to search.</p>"];
      type_: ComplianceQueryOperatorType.t option
        [@ocaml.doc
          "<p>The type of comparison that should be performed for the value: Equal, NotEqual, BeginWith, LessThan, or GreaterThan.</p>"]}
    [@@ocaml.doc
      "<p>One or more filters. Use a filter to return a more specific list of results.</p>"]
    let make ?key  ?(values= [])  ?type_  () = { key; values; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (ComplianceQueryOperatorType.to_json f)));
           Some
             ("values", (ComplianceStringFilterValueList.to_json v.values));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        values =
          (ComplianceStringFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")));
        type_ =
          (Util.option_map (Json.lookup j "type_")
             ComplianceQueryOperatorType.of_json)
      }
  end[@@ocaml.doc
       "<p>One or more filters. Use a filter to return a more specific list of results.</p>"]
module ParameterMetadata =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The parameter name.</p>"];
      type_: ParameterType.t option
        [@ocaml.doc
          "<p>The type of parameter. Valid parameter types include the following: String, String list, Secure string.</p>"];
      key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the query key used for this parameter.</p>"];
      last_modified_date: DateTime.t option
        [@ocaml.doc "<p>Date the parameter was last changed or updated.</p>"];
      last_modified_user: String.t option
        [@ocaml.doc
          "<p>Amazon Resource Name (ARN) of the AWS user who last changed the parameter.</p>"];
      description: String.t option
        [@ocaml.doc "<p>Description of the parameter actions.</p>"];
      allowed_pattern: String.t option
        [@ocaml.doc
          "<p>A parameter name can include only the following letters and symbols.</p> <p>a-zA-Z0-9_.-</p>"];
      version: Long.t option [@ocaml.doc "<p>The parameter version.</p>"];
      tier: ParameterTier.t option [@ocaml.doc "<p>The parameter tier.</p>"];
      policies: ParameterPolicyList.t
        [@ocaml.doc "<p>A list of policies associated with a parameter.</p>"]}
    [@@ocaml.doc
      "<p>Metadata includes information like the ARN of the last user and the date/time the parameter was last used.</p>"]
    let make ?name  ?type_  ?key_id  ?last_modified_date  ?last_modified_user
       ?description  ?allowed_pattern  ?version  ?tier  ?(policies= [])  () =
      {
        name;
        type_;
        key_id;
        last_modified_date;
        last_modified_user;
        description;
        allowed_pattern;
        version;
        tier;
        policies
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("policies", (ParameterPolicyList.to_json v.policies));
           Util.option_map v.tier
             (fun f -> ("tier", (ParameterTier.to_json f)));
           Util.option_map v.version (fun f -> ("version", (Long.to_json f)));
           Util.option_map v.allowed_pattern
             (fun f -> ("allowed_pattern", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.last_modified_user
             (fun f -> ("last_modified_user", (String.to_json f)));
           Util.option_map v.last_modified_date
             (fun f -> ("last_modified_date", (DateTime.to_json f)));
           Util.option_map v.key_id (fun f -> ("key_id", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (ParameterType.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_") ParameterType.of_json);
        key_id = (Util.option_map (Json.lookup j "key_id") String.of_json);
        last_modified_date =
          (Util.option_map (Json.lookup j "last_modified_date")
             DateTime.of_json);
        last_modified_user =
          (Util.option_map (Json.lookup j "last_modified_user")
             String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        allowed_pattern =
          (Util.option_map (Json.lookup j "allowed_pattern") String.of_json);
        version = (Util.option_map (Json.lookup j "version") Long.of_json);
        tier = (Util.option_map (Json.lookup j "tier") ParameterTier.of_json);
        policies =
          (ParameterPolicyList.of_json
             (Util.of_option_exn (Json.lookup j "policies")))
      }
  end[@@ocaml.doc
       "<p>Metadata includes information like the ARN of the last user and the date/time the parameter was last used.</p>"]
module MaintenanceWindowAutomationParameters =
  struct
    type t =
      {
      document_version: String.t option
        [@ocaml.doc
          "<p>The version of an Automation document to use during task execution.</p>"];
      parameters: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>The parameters for the AUTOMATION task.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For AUTOMATION task types, Systems Manager ignores any values specified for these parameters.</p> </note>"]}
    [@@ocaml.doc "<p>The parameters for an AUTOMATION task type.</p>"]
    let make ?document_version  ?parameters  () =
      { document_version; parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameters
              (fun f -> ("parameters", (AutomationParameterMap.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)))])
    let of_json j =
      {
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters")
             AutomationParameterMap.of_json)
      }
  end[@@ocaml.doc "<p>The parameters for an AUTOMATION task type.</p>"]
module MaintenanceWindowLambdaParameters =
  struct
    type t =
      {
      client_context: String.t option
        [@ocaml.doc
          "<p>Pass client-specific information to the Lambda function that you are invoking. You can then process the client information in your Lambda function as you choose through the context variable.</p>"];
      qualifier: String.t option
        [@ocaml.doc
          "<p>(Optional) Specify a Lambda function version or alias name. If you specify a function version, the action uses the qualified function ARN to invoke a specific Lambda function. If you specify an alias name, the action uses the alias ARN to invoke the Lambda function version to which the alias points.</p>"];
      payload: Blob.t option
        [@ocaml.doc
          "<p>JSON to provide to your Lambda function as input.</p>"]}
    [@@ocaml.doc
      "<p>The parameters for a LAMBDA task type.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For Lambda tasks, Systems Manager ignores any values specified for TaskParameters and LoggingInfo.</p> </note>"]
    let make ?client_context  ?qualifier  ?payload  () =
      { client_context; qualifier; payload }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payload
              (fun f -> ("payload", (Blob.to_json f)));
           Util.option_map v.qualifier
             (fun f -> ("qualifier", (String.to_json f)));
           Util.option_map v.client_context
             (fun f -> ("client_context", (String.to_json f)))])
    let of_json j =
      {
        client_context =
          (Util.option_map (Json.lookup j "client_context") String.of_json);
        qualifier =
          (Util.option_map (Json.lookup j "qualifier") String.of_json);
        payload = (Util.option_map (Json.lookup j "payload") Blob.of_json)
      }
  end[@@ocaml.doc
       "<p>The parameters for a LAMBDA task type.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For Lambda tasks, Systems Manager ignores any values specified for TaskParameters and LoggingInfo.</p> </note>"]
module MaintenanceWindowRunCommandParameters =
  struct
    type t =
      {
      comment: String.t option
        [@ocaml.doc "<p>Information about the commands to run.</p>"];
      cloud_watch_output_config: CloudWatchOutputConfig.t option ;
      document_hash: String.t option
        [@ocaml.doc
          "<p>The SHA-256 or SHA-1 hash created by the system when the document was created. SHA-1 hashes have been deprecated.</p>"];
      document_hash_type: DocumentHashType.t option
        [@ocaml.doc
          "<p>SHA-256 or SHA-1. SHA-1 hashes have been deprecated.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The SSM document version to use in the request. You can specify $DEFAULT, $LATEST, or a specific version number. If you run commands by using the AWS CLI, then you must escape the first two options by using a backslash. If you specify a version number, then you don't need to use the backslash. For example:</p> <p>--document-version \"\\$DEFAULT\"</p> <p>--document-version \"\\$LATEST\"</p> <p>--document-version \"3\"</p>"];
      notification_config: NotificationConfig.t option
        [@ocaml.doc
          "<p>Configurations for sending notifications about command status changes on a per-instance basis.</p>"];
      output_s3_bucket_name: String.t option
        [@ocaml.doc "<p>The name of the Amazon S3 bucket.</p>"];
      output_s3_key_prefix: String.t option
        [@ocaml.doc "<p>The Amazon S3 bucket subfolder.</p>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>The parameters for the RUN_COMMAND task execution.</p>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks.</p>"];
      timeout_seconds: Integer.t option
        [@ocaml.doc
          "<p>If this time is reached and the command has not already started running, it doesn't run.</p>"]}
    [@@ocaml.doc
      "<p>The parameters for a RUN_COMMAND task type.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For Run Command tasks, Systems Manager uses specified values for <code>TaskParameters</code> and <code>LoggingInfo</code> only if no values are specified for <code>TaskInvocationParameters</code>. </p> </note>"]
    let make ?comment  ?cloud_watch_output_config  ?document_hash 
      ?document_hash_type  ?document_version  ?notification_config 
      ?output_s3_bucket_name  ?output_s3_key_prefix  ?parameters 
      ?service_role_arn  ?timeout_seconds  () =
      {
        comment;
        cloud_watch_output_config;
        document_hash;
        document_hash_type;
        document_version;
        notification_config;
        output_s3_bucket_name;
        output_s3_key_prefix;
        parameters;
        service_role_arn;
        timeout_seconds
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timeout_seconds
              (fun f -> ("timeout_seconds", (Integer.to_json f)));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.output_s3_key_prefix
             (fun f -> ("output_s3_key_prefix", (String.to_json f)));
           Util.option_map v.output_s3_bucket_name
             (fun f -> ("output_s3_bucket_name", (String.to_json f)));
           Util.option_map v.notification_config
             (fun f ->
                ("notification_config", (NotificationConfig.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.document_hash_type
             (fun f -> ("document_hash_type", (DocumentHashType.to_json f)));
           Util.option_map v.document_hash
             (fun f -> ("document_hash", (String.to_json f)));
           Util.option_map v.cloud_watch_output_config
             (fun f ->
                ("cloud_watch_output_config",
                  (CloudWatchOutputConfig.to_json f)));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)))])
    let of_json j =
      {
        comment = (Util.option_map (Json.lookup j "comment") String.of_json);
        cloud_watch_output_config =
          (Util.option_map (Json.lookup j "cloud_watch_output_config")
             CloudWatchOutputConfig.of_json);
        document_hash =
          (Util.option_map (Json.lookup j "document_hash") String.of_json);
        document_hash_type =
          (Util.option_map (Json.lookup j "document_hash_type")
             DocumentHashType.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        notification_config =
          (Util.option_map (Json.lookup j "notification_config")
             NotificationConfig.of_json);
        output_s3_bucket_name =
          (Util.option_map (Json.lookup j "output_s3_bucket_name")
             String.of_json);
        output_s3_key_prefix =
          (Util.option_map (Json.lookup j "output_s3_key_prefix")
             String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        timeout_seconds =
          (Util.option_map (Json.lookup j "timeout_seconds") Integer.of_json)
      }
  end[@@ocaml.doc
       "<p>The parameters for a RUN_COMMAND task type.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For Run Command tasks, Systems Manager uses specified values for <code>TaskParameters</code> and <code>LoggingInfo</code> only if no values are specified for <code>TaskInvocationParameters</code>. </p> </note>"]
module MaintenanceWindowStepFunctionsParameters =
  struct
    type t =
      {
      input: String.t option
        [@ocaml.doc "<p>The inputs for the STEP_FUNCTIONS task.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the STEP_FUNCTIONS task.</p>"]}[@@ocaml.doc
                                                                    "<p>The parameters for a STEP_FUNCTIONS task.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For Step Functions tasks, Systems Manager ignores any values specified for <code>TaskParameters</code> and <code>LoggingInfo</code>.</p> </note>"]
    let make ?input  ?name  () = { input; name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.input (fun f -> ("input", (String.to_json f)))])
    let of_json j =
      {
        input = (Util.option_map (Json.lookup j "input") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>The parameters for a STEP_FUNCTIONS task.</p> <p>For information about specifying and updating task parameters, see <a>RegisterTaskWithMaintenanceWindow</a> and <a>UpdateMaintenanceWindowTask</a>.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> <p>For Step Functions tasks, Systems Manager ignores any values specified for <code>TaskParameters</code> and <code>LoggingInfo</code>.</p> </note>"]
module ScheduledWindowExecution =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the maintenance window to be run.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the maintenance window to be run.</p>"];
      execution_time: String.t option
        [@ocaml.doc
          "<p>The time, in ISO-8601 Extended format, that the maintenance window is scheduled to be run.</p>"]}
    [@@ocaml.doc
      "<p>Information about a scheduled execution for a maintenance window.</p>"]
    let make ?window_id  ?name  ?execution_time  () =
      { window_id; name; execution_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.execution_time
              (fun f -> ("execution_time", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        execution_time =
          (Util.option_map (Json.lookup j "execution_time") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about a scheduled execution for a maintenance window.</p>"]
module AssociationFilter =
  struct
    type t =
      {
      key: AssociationFilterKey.t
        [@ocaml.doc "<p>The name of the filter.</p>"];
      value: String.t [@ocaml.doc "<p>The filter value.</p>"]}[@@ocaml.doc
                                                                "<p>Describes a filter.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (AssociationFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (AssociationFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end[@@ocaml.doc "<p>Describes a filter.</p>"]
module ParameterHistory =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of the parameter.</p>"];
      type_: ParameterType.t option
        [@ocaml.doc "<p>The type of parameter used.</p>"];
      key_id: String.t option
        [@ocaml.doc
          "<p>The ID of the query key used for this parameter.</p>"];
      last_modified_date: DateTime.t option
        [@ocaml.doc "<p>Date the parameter was last changed or updated.</p>"];
      last_modified_user: String.t option
        [@ocaml.doc
          "<p>Amazon Resource Name (ARN) of the AWS user who last changed the parameter.</p>"];
      description: String.t option
        [@ocaml.doc "<p>Information about the parameter.</p>"];
      value: String.t option [@ocaml.doc "<p>The parameter value.</p>"];
      allowed_pattern: String.t option
        [@ocaml.doc
          "<p>Parameter names can include the following letters and symbols.</p> <p>a-zA-Z0-9_.-</p>"];
      version: Long.t option [@ocaml.doc "<p>The parameter version.</p>"];
      labels: ParameterLabelList.t
        [@ocaml.doc "<p>Labels assigned to the parameter version.</p>"];
      tier: ParameterTier.t option [@ocaml.doc "<p>The parameter tier.</p>"];
      policies: ParameterPolicyList.t
        [@ocaml.doc
          "<p>Information about the policies assigned to a parameter.</p> <p> <a href=\"https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-policies.html\">Working with Parameter Policies</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]}
    [@@ocaml.doc "<p>Information about parameter usage.</p>"]
    let make ?name  ?type_  ?key_id  ?last_modified_date  ?last_modified_user
       ?description  ?value  ?allowed_pattern  ?version  ?(labels= [])  ?tier
       ?(policies= [])  () =
      {
        name;
        type_;
        key_id;
        last_modified_date;
        last_modified_user;
        description;
        value;
        allowed_pattern;
        version;
        labels;
        tier;
        policies
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("policies", (ParameterPolicyList.to_json v.policies));
           Util.option_map v.tier
             (fun f -> ("tier", (ParameterTier.to_json f)));
           Some ("labels", (ParameterLabelList.to_json v.labels));
           Util.option_map v.version (fun f -> ("version", (Long.to_json f)));
           Util.option_map v.allowed_pattern
             (fun f -> ("allowed_pattern", (String.to_json f)));
           Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.last_modified_user
             (fun f -> ("last_modified_user", (String.to_json f)));
           Util.option_map v.last_modified_date
             (fun f -> ("last_modified_date", (DateTime.to_json f)));
           Util.option_map v.key_id (fun f -> ("key_id", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (ParameterType.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_") ParameterType.of_json);
        key_id = (Util.option_map (Json.lookup j "key_id") String.of_json);
        last_modified_date =
          (Util.option_map (Json.lookup j "last_modified_date")
             DateTime.of_json);
        last_modified_user =
          (Util.option_map (Json.lookup j "last_modified_user")
             String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        value = (Util.option_map (Json.lookup j "value") String.of_json);
        allowed_pattern =
          (Util.option_map (Json.lookup j "allowed_pattern") String.of_json);
        version = (Util.option_map (Json.lookup j "version") Long.of_json);
        labels =
          (ParameterLabelList.of_json
             (Util.of_option_exn (Json.lookup j "labels")));
        tier = (Util.option_map (Json.lookup j "tier") ParameterTier.of_json);
        policies =
          (ParameterPolicyList.of_json
             (Util.of_option_exn (Json.lookup j "policies")))
      }
  end[@@ocaml.doc "<p>Information about parameter usage.</p>"]
module InstanceInformation =
  struct
    type t =
      {
      instance_id: String.t option [@ocaml.doc "<p>The instance ID. </p>"];
      ping_status: PingStatus.t option
        [@ocaml.doc "<p>Connection status of SSM Agent. </p>"];
      last_ping_date_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time when agent last pinged Systems Manager service. </p>"];
      agent_version: String.t option
        [@ocaml.doc
          "<p>The version of SSM Agent running on your Linux instance. </p>"];
      is_latest_version: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the latest version of SSM Agent is running on your Linux Managed Instance. This field does not indicate whether or not the latest version is installed on Windows managed instances, because some older versions of Windows Server use the EC2Config service to process SSM requests.</p>"];
      platform_type: PlatformType.t option
        [@ocaml.doc "<p>The operating system platform type. </p>"];
      platform_name: String.t option
        [@ocaml.doc
          "<p>The name of the operating system platform running on your instance. </p>"];
      platform_version: String.t option
        [@ocaml.doc
          "<p>The version of the OS platform running on your instance. </p>"];
      activation_id: String.t option
        [@ocaml.doc
          "<p>The activation ID created by Systems Manager when the server or VM was registered.</p>"];
      iam_role: String.t option
        [@ocaml.doc
          "<p>The Amazon Identity and Access Management (IAM) role assigned to the on-premises Systems Manager managed instances. This call does not return the IAM role for Amazon EC2 instances. </p>"];
      registration_date: DateTime.t option
        [@ocaml.doc
          "<p>The date the server or VM was registered with AWS as a managed instance.</p>"];
      resource_type: ResourceType.t option
        [@ocaml.doc
          "<p>The type of instance. Instances are either EC2 instances or managed instances. </p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the managed instance.</p>"];
      i_p_address: String.t option
        [@ocaml.doc "<p>The IP address of the managed instance.</p>"];
      computer_name: String.t option
        [@ocaml.doc
          "<p>The fully qualified host name of the managed instance.</p>"];
      association_status: String.t option
        [@ocaml.doc "<p>The status of the association.</p>"];
      last_association_execution_date: DateTime.t option
        [@ocaml.doc "<p>The date the association was last run.</p>"];
      last_successful_association_execution_date: DateTime.t option
        [@ocaml.doc
          "<p>The last date the association was successfully run.</p>"];
      association_overview: InstanceAggregatedAssociationOverview.t option
        [@ocaml.doc "<p>Information about the association.</p>"]}[@@ocaml.doc
                                                                   "<p>Describes a filter for a specific list of instances. </p>"]
    let make ?instance_id  ?ping_status  ?last_ping_date_time  ?agent_version
       ?is_latest_version  ?platform_type  ?platform_name  ?platform_version 
      ?activation_id  ?iam_role  ?registration_date  ?resource_type  ?name 
      ?i_p_address  ?computer_name  ?association_status 
      ?last_association_execution_date 
      ?last_successful_association_execution_date  ?association_overview  ()
      =
      {
        instance_id;
        ping_status;
        last_ping_date_time;
        agent_version;
        is_latest_version;
        platform_type;
        platform_name;
        platform_version;
        activation_id;
        iam_role;
        registration_date;
        resource_type;
        name;
        i_p_address;
        computer_name;
        association_status;
        last_association_execution_date;
        last_successful_association_execution_date;
        association_overview
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_overview
              (fun f ->
                 ("association_overview",
                   (InstanceAggregatedAssociationOverview.to_json f)));
           Util.option_map v.last_successful_association_execution_date
             (fun f ->
                ("last_successful_association_execution_date",
                  (DateTime.to_json f)));
           Util.option_map v.last_association_execution_date
             (fun f ->
                ("last_association_execution_date", (DateTime.to_json f)));
           Util.option_map v.association_status
             (fun f -> ("association_status", (String.to_json f)));
           Util.option_map v.computer_name
             (fun f -> ("computer_name", (String.to_json f)));
           Util.option_map v.i_p_address
             (fun f -> ("i_p_address", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (ResourceType.to_json f)));
           Util.option_map v.registration_date
             (fun f -> ("registration_date", (DateTime.to_json f)));
           Util.option_map v.iam_role
             (fun f -> ("iam_role", (String.to_json f)));
           Util.option_map v.activation_id
             (fun f -> ("activation_id", (String.to_json f)));
           Util.option_map v.platform_version
             (fun f -> ("platform_version", (String.to_json f)));
           Util.option_map v.platform_name
             (fun f -> ("platform_name", (String.to_json f)));
           Util.option_map v.platform_type
             (fun f -> ("platform_type", (PlatformType.to_json f)));
           Util.option_map v.is_latest_version
             (fun f -> ("is_latest_version", (Boolean.to_json f)));
           Util.option_map v.agent_version
             (fun f -> ("agent_version", (String.to_json f)));
           Util.option_map v.last_ping_date_time
             (fun f -> ("last_ping_date_time", (DateTime.to_json f)));
           Util.option_map v.ping_status
             (fun f -> ("ping_status", (PingStatus.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)))])
    let of_json j =
      {
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        ping_status =
          (Util.option_map (Json.lookup j "ping_status") PingStatus.of_json);
        last_ping_date_time =
          (Util.option_map (Json.lookup j "last_ping_date_time")
             DateTime.of_json);
        agent_version =
          (Util.option_map (Json.lookup j "agent_version") String.of_json);
        is_latest_version =
          (Util.option_map (Json.lookup j "is_latest_version")
             Boolean.of_json);
        platform_type =
          (Util.option_map (Json.lookup j "platform_type")
             PlatformType.of_json);
        platform_name =
          (Util.option_map (Json.lookup j "platform_name") String.of_json);
        platform_version =
          (Util.option_map (Json.lookup j "platform_version") String.of_json);
        activation_id =
          (Util.option_map (Json.lookup j "activation_id") String.of_json);
        iam_role =
          (Util.option_map (Json.lookup j "iam_role") String.of_json);
        registration_date =
          (Util.option_map (Json.lookup j "registration_date")
             DateTime.of_json);
        resource_type =
          (Util.option_map (Json.lookup j "resource_type")
             ResourceType.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        i_p_address =
          (Util.option_map (Json.lookup j "i_p_address") String.of_json);
        computer_name =
          (Util.option_map (Json.lookup j "computer_name") String.of_json);
        association_status =
          (Util.option_map (Json.lookup j "association_status")
             String.of_json);
        last_association_execution_date =
          (Util.option_map (Json.lookup j "last_association_execution_date")
             DateTime.of_json);
        last_successful_association_execution_date =
          (Util.option_map
             (Json.lookup j "last_successful_association_execution_date")
             DateTime.of_json);
        association_overview =
          (Util.option_map (Json.lookup j "association_overview")
             InstanceAggregatedAssociationOverview.of_json)
      }
  end[@@ocaml.doc
       "<p>Describes a filter for a specific list of instances. </p>"]
module DocumentVersionInfo =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The document name.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>The version of the artifact associated with the document. For example, \"Release 12, Update 6\". This value is unique across all versions of a document, and cannot be changed.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date the document was created.</p>"];
      is_default_version: Boolean.t option
        [@ocaml.doc
          "<p>An identifier for the default version of the document.</p>"];
      document_format: DocumentFormat.t option
        [@ocaml.doc "<p>The document format, either JSON or YAML.</p>"];
      status: DocumentStatus.t option
        [@ocaml.doc
          "<p>The status of the Systems Manager document, such as <code>Creating</code>, <code>Active</code>, <code>Failed</code>, and <code>Deleting</code>.</p>"];
      status_information: String.t option
        [@ocaml.doc
          "<p>A message returned by AWS Systems Manager that explains the <code>Status</code> value. For example, a <code>Failed</code> status might be explained by the <code>StatusInformation</code> message, \"The specified S3 bucket does not exist. Verify that the URL of the S3 bucket is correct.\"</p>"]}
    [@@ocaml.doc "<p>Version information about the document.</p>"]
    let make ?name  ?document_version  ?version_name  ?created_date 
      ?is_default_version  ?document_format  ?status  ?status_information  ()
      =
      {
        name;
        document_version;
        version_name;
        created_date;
        is_default_version;
        document_format;
        status;
        status_information
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status_information
              (fun f -> ("status_information", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (DocumentStatus.to_json f)));
           Util.option_map v.document_format
             (fun f -> ("document_format", (DocumentFormat.to_json f)));
           Util.option_map v.is_default_version
             (fun f -> ("is_default_version", (Boolean.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.version_name
             (fun f -> ("version_name", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        is_default_version =
          (Util.option_map (Json.lookup j "is_default_version")
             Boolean.of_json);
        document_format =
          (Util.option_map (Json.lookup j "document_format")
             DocumentFormat.of_json);
        status =
          (Util.option_map (Json.lookup j "status") DocumentStatus.of_json);
        status_information =
          (Util.option_map (Json.lookup j "status_information")
             String.of_json)
      }
  end[@@ocaml.doc "<p>Version information about the document.</p>"]
module AssociationExecutionTargetsFilter =
  struct
    type t =
      {
      key: AssociationExecutionTargetsFilterKey.t
        [@ocaml.doc "<p>The key value used in the request.</p>"];
      value: String.t [@ocaml.doc "<p>The value specified for the key.</p>"]}
    [@@ocaml.doc "<p>Filters for the association execution.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (AssociationExecutionTargetsFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (AssociationExecutionTargetsFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end[@@ocaml.doc "<p>Filters for the association execution.</p>"]
module StepExecutionFilter =
  struct
    type t =
      {
      key: StepExecutionFilterKey.t
        [@ocaml.doc
          "<p>One or more keys to limit the results. Valid filter keys include the following: StepName, Action, StepExecutionId, StepExecutionStatus, StartTimeBefore, StartTimeAfter.</p>"];
      values: StepExecutionFilterValueList.t
        [@ocaml.doc "<p>The values of the filter key.</p>"]}[@@ocaml.doc
                                                              "<p>A filter to limit the amount of step execution information returned by the call.</p>"]
    let make ~key  ~values  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (StepExecutionFilterValueList.to_json v.values));
           Some ("key", (StepExecutionFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (StepExecutionFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        values =
          (StepExecutionFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>A filter to limit the amount of step execution information returned by the call.</p>"]
module AutomationExecutionMetadata =
  struct
    type t =
      {
      automation_execution_id: String.t option
        [@ocaml.doc "<p>The execution ID.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The name of the Automation document used during execution.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version used during the execution.</p>"];
      automation_execution_status: AutomationExecutionStatus.t option
        [@ocaml.doc
          "<p>The status of the execution. Valid values include: Running, Succeeded, Failed, Timed out, or Cancelled.</p>"];
      execution_start_time: DateTime.t option
        [@ocaml.doc "<p>The time the execution started.&gt;</p>"];
      execution_end_time: DateTime.t option
        [@ocaml.doc
          "<p>The time the execution finished. This is not populated if the execution is still in progress.</p>"];
      executed_by: String.t option
        [@ocaml.doc
          "<p>The IAM role ARN of the user who ran the Automation.</p>"];
      log_file: String.t option
        [@ocaml.doc
          "<p>An Amazon S3 bucket where execution information is stored.</p>"];
      outputs: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>The list of execution outputs as defined in the Automation document.</p>"];
      mode: ExecutionMode.t option
        [@ocaml.doc "<p>The Automation execution mode.</p>"];
      parent_automation_execution_id: String.t option
        [@ocaml.doc "<p>The ExecutionId of the parent Automation.</p>"];
      current_step_name: String.t option
        [@ocaml.doc "<p>The name of the step that is currently running.</p>"];
      current_action: String.t option
        [@ocaml.doc
          "<p>The action of the step that is currently running.</p>"];
      failure_message: String.t option
        [@ocaml.doc
          "<p>The list of execution outputs as defined in the Automation document.</p>"];
      target_parameter_name: String.t option
        [@ocaml.doc
          "<p>The list of execution outputs as defined in the Automation document.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets defined by the user when starting the Automation.</p>"];
      target_maps: TargetMaps.t
        [@ocaml.doc
          "<p>The specified key-value mapping of document parameters to target resources.</p>"];
      resolved_targets: ResolvedTargets.t option
        [@ocaml.doc
          "<p>A list of targets that resolved during the execution.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The MaxConcurrency value specified by the user when starting the Automation.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The MaxErrors value specified by the user when starting the Automation.</p>"];
      target: String.t option
        [@ocaml.doc
          "<p>The list of execution outputs as defined in the Automation document.</p>"];
      automation_type: AutomationType.t option
        [@ocaml.doc
          "<p>Use this filter with <a>DescribeAutomationExecutions</a>. Specify either Local or CrossAccount. CrossAccount is an Automation that runs in multiple AWS Regions and accounts. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-automation-multiple-accounts-and-regions.html\">Executing Automations in Multiple AWS Regions and Accounts</a> in the <i>AWS Systems Manager User Guide</i>. </p>"]}
    [@@ocaml.doc "<p>Details about a specific Automation execution.</p>"]
    let make ?automation_execution_id  ?document_name  ?document_version 
      ?automation_execution_status  ?execution_start_time 
      ?execution_end_time  ?executed_by  ?log_file  ?outputs  ?mode 
      ?parent_automation_execution_id  ?current_step_name  ?current_action 
      ?failure_message  ?target_parameter_name  ?(targets= []) 
      ?(target_maps= [])  ?resolved_targets  ?max_concurrency  ?max_errors 
      ?target  ?automation_type  () =
      {
        automation_execution_id;
        document_name;
        document_version;
        automation_execution_status;
        execution_start_time;
        execution_end_time;
        executed_by;
        log_file;
        outputs;
        mode;
        parent_automation_execution_id;
        current_step_name;
        current_action;
        failure_message;
        target_parameter_name;
        targets;
        target_maps;
        resolved_targets;
        max_concurrency;
        max_errors;
        target;
        automation_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.automation_type
              (fun f -> ("automation_type", (AutomationType.to_json f)));
           Util.option_map v.target (fun f -> ("target", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.resolved_targets
             (fun f -> ("resolved_targets", (ResolvedTargets.to_json f)));
           Some ("target_maps", (TargetMaps.to_json v.target_maps));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.target_parameter_name
             (fun f -> ("target_parameter_name", (String.to_json f)));
           Util.option_map v.failure_message
             (fun f -> ("failure_message", (String.to_json f)));
           Util.option_map v.current_action
             (fun f -> ("current_action", (String.to_json f)));
           Util.option_map v.current_step_name
             (fun f -> ("current_step_name", (String.to_json f)));
           Util.option_map v.parent_automation_execution_id
             (fun f -> ("parent_automation_execution_id", (String.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ExecutionMode.to_json f)));
           Util.option_map v.outputs
             (fun f -> ("outputs", (AutomationParameterMap.to_json f)));
           Util.option_map v.log_file
             (fun f -> ("log_file", (String.to_json f)));
           Util.option_map v.executed_by
             (fun f -> ("executed_by", (String.to_json f)));
           Util.option_map v.execution_end_time
             (fun f -> ("execution_end_time", (DateTime.to_json f)));
           Util.option_map v.execution_start_time
             (fun f -> ("execution_start_time", (DateTime.to_json f)));
           Util.option_map v.automation_execution_status
             (fun f ->
                ("automation_execution_status",
                  (AutomationExecutionStatus.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Util.option_map v.automation_execution_id
             (fun f -> ("automation_execution_id", (String.to_json f)))])
    let of_json j =
      {
        automation_execution_id =
          (Util.option_map (Json.lookup j "automation_execution_id")
             String.of_json);
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        automation_execution_status =
          (Util.option_map (Json.lookup j "automation_execution_status")
             AutomationExecutionStatus.of_json);
        execution_start_time =
          (Util.option_map (Json.lookup j "execution_start_time")
             DateTime.of_json);
        execution_end_time =
          (Util.option_map (Json.lookup j "execution_end_time")
             DateTime.of_json);
        executed_by =
          (Util.option_map (Json.lookup j "executed_by") String.of_json);
        log_file =
          (Util.option_map (Json.lookup j "log_file") String.of_json);
        outputs =
          (Util.option_map (Json.lookup j "outputs")
             AutomationParameterMap.of_json);
        mode = (Util.option_map (Json.lookup j "mode") ExecutionMode.of_json);
        parent_automation_execution_id =
          (Util.option_map (Json.lookup j "parent_automation_execution_id")
             String.of_json);
        current_step_name =
          (Util.option_map (Json.lookup j "current_step_name") String.of_json);
        current_action =
          (Util.option_map (Json.lookup j "current_action") String.of_json);
        failure_message =
          (Util.option_map (Json.lookup j "failure_message") String.of_json);
        target_parameter_name =
          (Util.option_map (Json.lookup j "target_parameter_name")
             String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        target_maps =
          (TargetMaps.of_json
             (Util.of_option_exn (Json.lookup j "target_maps")));
        resolved_targets =
          (Util.option_map (Json.lookup j "resolved_targets")
             ResolvedTargets.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        target = (Util.option_map (Json.lookup j "target") String.of_json);
        automation_type =
          (Util.option_map (Json.lookup j "automation_type")
             AutomationType.of_json)
      }
  end[@@ocaml.doc "<p>Details about a specific Automation execution.</p>"]
module DocumentIdentifier =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      owner: String.t option
        [@ocaml.doc "<p>The AWS user account that created the document.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>An optional field specifying the version of the artifact associated with the document. For example, \"Release 12, Update 6\". This value is unique across all versions of a document, and cannot be changed.</p>"];
      platform_types: PlatformTypeList.t
        [@ocaml.doc "<p>The operating system platform. </p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version.</p>"];
      document_type: DocumentType.t option
        [@ocaml.doc "<p>The document type.</p>"];
      schema_version: String.t option
        [@ocaml.doc "<p>The schema version.</p>"];
      document_format: DocumentFormat.t option
        [@ocaml.doc "<p>The document format, either JSON or YAML.</p>"];
      target_type: String.t option
        [@ocaml.doc
          "<p>The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\">AWS Resource Types Reference</a> in the <i>AWS CloudFormation User Guide</i>. </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The tags, or metadata, that have been applied to the document.</p>"];
      requires: DocumentRequiresList.t
        [@ocaml.doc
          "<p>A list of SSM documents required by a document. For example, an <code>ApplicationConfiguration</code> document requires an <code>ApplicationConfigurationSchema</code> document.</p>"]}
    [@@ocaml.doc "<p>Describes the name of a Systems Manager document.</p>"]
    let make ?name  ?owner  ?version_name  ?(platform_types= []) 
      ?document_version  ?document_type  ?schema_version  ?document_format 
      ?target_type  ?(tags= [])  ?(requires= [])  () =
      {
        name;
        owner;
        version_name;
        platform_types;
        document_version;
        document_type;
        schema_version;
        document_format;
        target_type;
        tags;
        requires
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("requires", (DocumentRequiresList.to_json v.requires));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.target_type
             (fun f -> ("target_type", (String.to_json f)));
           Util.option_map v.document_format
             (fun f -> ("document_format", (DocumentFormat.to_json f)));
           Util.option_map v.schema_version
             (fun f -> ("schema_version", (String.to_json f)));
           Util.option_map v.document_type
             (fun f -> ("document_type", (DocumentType.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Some
             ("platform_types", (PlatformTypeList.to_json v.platform_types));
           Util.option_map v.version_name
             (fun f -> ("version_name", (String.to_json f)));
           Util.option_map v.owner (fun f -> ("owner", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        owner = (Util.option_map (Json.lookup j "owner") String.of_json);
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        platform_types =
          (PlatformTypeList.of_json
             (Util.of_option_exn (Json.lookup j "platform_types")));
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        document_type =
          (Util.option_map (Json.lookup j "document_type")
             DocumentType.of_json);
        schema_version =
          (Util.option_map (Json.lookup j "schema_version") String.of_json);
        document_format =
          (Util.option_map (Json.lookup j "document_format")
             DocumentFormat.of_json);
        target_type =
          (Util.option_map (Json.lookup j "target_type") String.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")));
        requires =
          (DocumentRequiresList.of_json
             (Util.of_option_exn (Json.lookup j "requires")))
      }
  end[@@ocaml.doc "<p>Describes the name of a Systems Manager document.</p>"]
module InstanceInformationFilter =
  struct
    type t =
      {
      key: InstanceInformationFilterKey.t
        [@ocaml.doc "<p>The name of the filter. </p>"];
      value_set: InstanceInformationFilterValueSet.t
        [@ocaml.doc "<p>The filter values.</p>"]}[@@ocaml.doc
                                                   "<p>Describes a filter for a specific list of instances. You can filter instances information by using tags. You specify tags by using a key-value mapping.</p> <p>Use this action instead of the <a>DescribeInstanceInformationRequest$InstanceInformationFilterList</a> method. The <code>InstanceInformationFilterList</code> method is a legacy method and does not support tags. </p>"]
    let make ~key  ~value_set  () = { key; value_set }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("value_set",
                (InstanceInformationFilterValueSet.to_json v.value_set));
           Some ("key", (InstanceInformationFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (InstanceInformationFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value_set =
          (InstanceInformationFilterValueSet.of_json
             (Util.of_option_exn (Json.lookup j "value_set")))
      }
  end[@@ocaml.doc
       "<p>Describes a filter for a specific list of instances. You can filter instances information by using tags. You specify tags by using a key-value mapping.</p> <p>Use this action instead of the <a>DescribeInstanceInformationRequest$InstanceInformationFilterList</a> method. The <code>InstanceInformationFilterList</code> method is a legacy method and does not support tags. </p>"]
module InstanceInformationStringFilter =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>The filter key name to describe your instances. For example:</p> <p>\"InstanceIds\"|\"AgentVersion\"|\"PingStatus\"|\"PlatformTypes\"|\"ActivationIds\"|\"IamRole\"|\"ResourceType\"|\"AssociationStatus\"|\"Tag Key\"</p>"];
      values: InstanceInformationFilterValueSet.t
        [@ocaml.doc "<p>The filter values.</p>"]}[@@ocaml.doc
                                                   "<p>The filters to describe or get information about your managed instances.</p>"]
    let make ~key  ~values  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("values",
                (InstanceInformationFilterValueSet.to_json v.values));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        values =
          (InstanceInformationFilterValueSet.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>The filters to describe or get information about your managed instances.</p>"]
module AttachmentInformationList =
  struct
    type t = AttachmentInformation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AttachmentInformation.to_query v
    let to_headers v =
      Headers.to_headers_list AttachmentInformation.to_headers v
    let to_json v = `List (List.map AttachmentInformation.to_json v)
    let of_json j = Json.to_list AttachmentInformation.of_json j
  end
module DocumentParameterList =
  struct
    type t = DocumentParameter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DocumentParameter.to_query v
    let to_headers v = Headers.to_headers_list DocumentParameter.to_headers v
    let to_json v = `List (List.map DocumentParameter.to_json v)
    let of_json j = Json.to_list DocumentParameter.of_json j
  end
module InventoryGroupList =
  struct
    type t = InventoryGroup.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryGroup.to_query v
    let to_headers v = Headers.to_headers_list InventoryGroup.to_headers v
    let to_json v = `List (List.map InventoryGroup.to_json v)
    let of_json j = Json.to_list InventoryGroup.of_json j
  end
module ResultAttribute =
  struct
    type t =
      {
      type_name: String.t
        [@ocaml.doc
          "<p>Name of the inventory item type. Valid value: AWS:InstanceInformation. Default Value: AWS:InstanceInformation.</p>"]}
    [@@ocaml.doc "<p>The inventory item result attribute.</p>"]
    let make ~type_name  () = { type_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("type_name", (String.to_json v.type_name))])
    let of_json j =
      {
        type_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "type_name")))
      }
  end[@@ocaml.doc "<p>The inventory item result attribute.</p>"]
module ProgressCounters =
  struct
    type t =
      {
      total_steps: Integer.t option
        [@ocaml.doc
          "<p>The total number of steps run in all specified AWS Regions and accounts for the current Automation execution.</p>"];
      success_steps: Integer.t option
        [@ocaml.doc
          "<p>The total number of steps that successfully completed in all specified AWS Regions and accounts for the current Automation execution.</p>"];
      failed_steps: Integer.t option
        [@ocaml.doc
          "<p>The total number of steps that failed to run in all specified AWS Regions and accounts for the current Automation execution.</p>"];
      cancelled_steps: Integer.t option
        [@ocaml.doc
          "<p>The total number of steps that the system cancelled in all specified AWS Regions and accounts for the current Automation execution.</p>"];
      timed_out_steps: Integer.t option
        [@ocaml.doc
          "<p>The total number of steps that timed out in all specified AWS Regions and accounts for the current Automation execution.</p>"]}
    [@@ocaml.doc
      "<p>An aggregate of step execution statuses displayed in the AWS Console for a multi-Region and multi-account Automation execution.</p>"]
    let make ?total_steps  ?success_steps  ?failed_steps  ?cancelled_steps 
      ?timed_out_steps  () =
      {
        total_steps;
        success_steps;
        failed_steps;
        cancelled_steps;
        timed_out_steps
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timed_out_steps
              (fun f -> ("timed_out_steps", (Integer.to_json f)));
           Util.option_map v.cancelled_steps
             (fun f -> ("cancelled_steps", (Integer.to_json f)));
           Util.option_map v.failed_steps
             (fun f -> ("failed_steps", (Integer.to_json f)));
           Util.option_map v.success_steps
             (fun f -> ("success_steps", (Integer.to_json f)));
           Util.option_map v.total_steps
             (fun f -> ("total_steps", (Integer.to_json f)))])
    let of_json j =
      {
        total_steps =
          (Util.option_map (Json.lookup j "total_steps") Integer.of_json);
        success_steps =
          (Util.option_map (Json.lookup j "success_steps") Integer.of_json);
        failed_steps =
          (Util.option_map (Json.lookup j "failed_steps") Integer.of_json);
        cancelled_steps =
          (Util.option_map (Json.lookup j "cancelled_steps") Integer.of_json);
        timed_out_steps =
          (Util.option_map (Json.lookup j "timed_out_steps") Integer.of_json)
      }
  end[@@ocaml.doc
       "<p>An aggregate of step execution statuses displayed in the AWS Console for a multi-Region and multi-account Automation execution.</p>"]
module StepExecutionList =
  struct
    type t = StepExecution.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StepExecution.to_query v
    let to_headers v = Headers.to_headers_list StepExecution.to_headers v
    let to_json v = `List (List.map StepExecution.to_json v)
    let of_json j = Json.to_list StepExecution.of_json j
  end
module TargetLocations =
  struct
    type t = TargetLocation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list TargetLocation.to_query v
    let to_headers v = Headers.to_headers_list TargetLocation.to_headers v
    let to_json v = `List (List.map TargetLocation.to_json v)
    let of_json j = Json.to_list TargetLocation.of_json j
  end
module AssociationExecutionFilter =
  struct
    type t =
      {
      key: AssociationExecutionFilterKey.t
        [@ocaml.doc "<p>The key value used in the request.</p>"];
      value: String.t [@ocaml.doc "<p>The value specified for the key.</p>"];
      type_: AssociationFilterOperatorType.t
        [@ocaml.doc "<p>The filter type specified in the request.</p>"]}
    [@@ocaml.doc "<p>Filters used in the request.</p>"]
    let make ~key  ~value  ~type_  () = { key; value; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("type_", (AssociationFilterOperatorType.to_json v.type_));
           Some ("value", (String.to_json v.value));
           Some ("key", (AssociationExecutionFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (AssociationExecutionFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")));
        type_ =
          (AssociationFilterOperatorType.of_json
             (Util.of_option_exn (Json.lookup j "type_")))
      }
  end[@@ocaml.doc "<p>Filters used in the request.</p>"]
module OpsEntity =
  struct
    type t =
      {
      id: String.t option [@ocaml.doc "<p>The query ID.</p>"];
      data: OpsEntityItemMap.t option
        [@ocaml.doc "<p>The data returned by the query.</p>"]}[@@ocaml.doc
                                                                "<p>The result of the query.</p>"]
    let make ?id  ?data  () = { id; data }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.data
              (fun f -> ("data", (OpsEntityItemMap.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        data =
          (Util.option_map (Json.lookup j "data") OpsEntityItemMap.of_json)
      }
  end[@@ocaml.doc "<p>The result of the query.</p>"]
module PatchOrchestratorFilter =
  struct
    type t =
      {
      key: String.t option [@ocaml.doc "<p>The key for the filter.</p>"];
      values: PatchOrchestratorFilterValues.t
        [@ocaml.doc "<p>The value for the filter.</p>"]}[@@ocaml.doc
                                                          "<p>Defines a filter used in Patch Manager APIs.</p>"]
    let make ?key  ?(values= [])  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (PatchOrchestratorFilterValues.to_json v.values));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        values =
          (PatchOrchestratorFilterValues.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc "<p>Defines a filter used in Patch Manager APIs.</p>"]
module PatchRuleList =
  struct
    type t = PatchRule.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchRule.to_query v
    let to_headers v = Headers.to_headers_list PatchRule.to_headers v
    let to_json v = `List (List.map PatchRule.to_json v)
    let of_json j = Json.to_list PatchRule.of_json j
  end
module PatchSource =
  struct
    type t =
      {
      name: String.t
        [@ocaml.doc
          "<p>The name specified to identify the patch source.</p>"];
      products: PatchSourceProductList.t
        [@ocaml.doc
          "<p>The specific operating system versions a patch repository applies to, such as \"Ubuntu16.04\", \"AmazonLinux2016.09\", \"RedhatEnterpriseLinux7.2\" or \"Suse12.7\". For lists of supported product values, see <a>PatchFilter</a>.</p>"];
      configuration: String.t
        [@ocaml.doc
          "<p>The value of the yum repo configuration. For example:</p> <p> <code>[main]</code> </p> <p> <code>cachedir=/var/cache/yum/$basesearch$releasever</code> </p> <p> <code>keepcache=0</code> </p> <p> <code>debuglevel=2</code> </p>"]}
    [@@ocaml.doc
      "<p>Information about the patches to use to update the instances, including target operating systems and source repository. Applies to Linux instances only.</p>"]
    let make ~name  ~products  ~configuration  () =
      { name; products; configuration }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("configuration", (String.to_json v.configuration));
           Some ("products", (PatchSourceProductList.to_json v.products));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        products =
          (PatchSourceProductList.of_json
             (Util.of_option_exn (Json.lookup j "products")));
        configuration =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "configuration")))
      }
  end[@@ocaml.doc
       "<p>Information about the patches to use to update the instances, including target operating systems and source repository. Applies to Linux instances only.</p>"]
module Association =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance.</p>"];
      association_id: String.t option
        [@ocaml.doc
          "<p>The ID created by the system when you create an association. An association is a binding between a document and a set of targets with a schedule.</p>"];
      association_version: String.t option
        [@ocaml.doc "<p>The association version.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The version of the document used in the association.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The instances targeted by the request to create an association. </p>"];
      last_execution_date: DateTime.t option
        [@ocaml.doc "<p>The date on which the association was last run.</p>"];
      overview: AssociationOverview.t option
        [@ocaml.doc "<p>Information about the association.</p>"];
      schedule_expression: String.t option
        [@ocaml.doc
          "<p>A cron expression that specifies a schedule when the association runs.</p>"];
      association_name: String.t option
        [@ocaml.doc "<p>The association name.</p>"]}[@@ocaml.doc
                                                      "<p>Describes an association of a Systems Manager document and an instance.</p>"]
    let make ?name  ?instance_id  ?association_id  ?association_version 
      ?document_version  ?(targets= [])  ?last_execution_date  ?overview 
      ?schedule_expression  ?association_name  () =
      {
        name;
        instance_id;
        association_id;
        association_version;
        document_version;
        targets;
        last_execution_date;
        overview;
        schedule_expression;
        association_name
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_name
              (fun f -> ("association_name", (String.to_json f)));
           Util.option_map v.schedule_expression
             (fun f -> ("schedule_expression", (String.to_json f)));
           Util.option_map v.overview
             (fun f -> ("overview", (AssociationOverview.to_json f)));
           Util.option_map v.last_execution_date
             (fun f -> ("last_execution_date", (DateTime.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.association_version
             (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        last_execution_date =
          (Util.option_map (Json.lookup j "last_execution_date")
             DateTime.of_json);
        overview =
          (Util.option_map (Json.lookup j "overview")
             AssociationOverview.of_json);
        schedule_expression =
          (Util.option_map (Json.lookup j "schedule_expression")
             String.of_json);
        association_name =
          (Util.option_map (Json.lookup j "association_name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Describes an association of a Systems Manager document and an instance.</p>"]
module Session =
  struct
    type t =
      {
      session_id: String.t option
        [@ocaml.doc "<p>The ID of the session.</p>"];
      target: String.t option
        [@ocaml.doc
          "<p>The instance that the Session Manager session connected to.</p>"];
      status: SessionStatus.t option
        [@ocaml.doc
          "<p>The status of the session. For example, \"Connected\" or \"Terminated\".</p>"];
      start_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, when the session began.</p>"];
      end_date: DateTime.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, when the session was terminated.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The name of the Session Manager SSM document used to define the parameters and plugin settings for the session. For example, <code>SSM-SessionManagerRunShell</code>.</p>"];
      owner: String.t option
        [@ocaml.doc
          "<p>The ID of the AWS user account that started the session.</p>"];
      details: String.t option [@ocaml.doc "<p>Reserved for future use.</p>"];
      output_url: SessionManagerOutputUrl.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"]}[@@ocaml.doc
                                                         "<p>Information about a Session Manager connection to an instance.</p>"]
    let make ?session_id  ?target  ?status  ?start_date  ?end_date 
      ?document_name  ?owner  ?details  ?output_url  () =
      {
        session_id;
        target;
        status;
        start_date;
        end_date;
        document_name;
        owner;
        details;
        output_url
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_url
              (fun f -> ("output_url", (SessionManagerOutputUrl.to_json f)));
           Util.option_map v.details
             (fun f -> ("details", (String.to_json f)));
           Util.option_map v.owner (fun f -> ("owner", (String.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (DateTime.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (DateTime.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (SessionStatus.to_json f)));
           Util.option_map v.target (fun f -> ("target", (String.to_json f)));
           Util.option_map v.session_id
             (fun f -> ("session_id", (String.to_json f)))])
    let of_json j =
      {
        session_id =
          (Util.option_map (Json.lookup j "session_id") String.of_json);
        target = (Util.option_map (Json.lookup j "target") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status") SessionStatus.of_json);
        start_date =
          (Util.option_map (Json.lookup j "start_date") DateTime.of_json);
        end_date =
          (Util.option_map (Json.lookup j "end_date") DateTime.of_json);
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        owner = (Util.option_map (Json.lookup j "owner") String.of_json);
        details = (Util.option_map (Json.lookup j "details") String.of_json);
        output_url =
          (Util.option_map (Json.lookup j "output_url")
             SessionManagerOutputUrl.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about a Session Manager connection to an instance.</p>"]
module Activation =
  struct
    type t =
      {
      activation_id: String.t option
        [@ocaml.doc
          "<p>The ID created by Systems Manager when you submitted the activation.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A user defined description of the activation.</p>"];
      default_instance_name: String.t option
        [@ocaml.doc
          "<p>A name for the managed instance when it is created.</p>"];
      iam_role: String.t option
        [@ocaml.doc
          "<p>The Amazon Identity and Access Management (IAM) role to assign to the managed instance.</p>"];
      registration_limit: Integer.t option
        [@ocaml.doc
          "<p>The maximum number of managed instances that can be registered using this activation.</p>"];
      registrations_count: Integer.t option
        [@ocaml.doc
          "<p>The number of managed instances already registered with this activation.</p>"];
      expiration_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when this activation can no longer be used to register managed instances.</p>"];
      expired: Boolean.t option
        [@ocaml.doc "<p>Whether or not the activation is expired.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date the activation was created.</p>"];
      tags: TagList.t [@ocaml.doc "<p>Tags assigned to the activation.</p>"]}
    [@@ocaml.doc
      "<p>An activation registers one or more on-premises servers or virtual machines (VMs) with AWS so that you can configure those servers or VMs using Run Command. A server or VM that has been registered with AWS is called a managed instance.</p>"]
    let make ?activation_id  ?description  ?default_instance_name  ?iam_role 
      ?registration_limit  ?registrations_count  ?expiration_date  ?expired 
      ?created_date  ?(tags= [])  () =
      {
        activation_id;
        description;
        default_instance_name;
        iam_role;
        registration_limit;
        registrations_count;
        expiration_date;
        expired;
        created_date;
        tags
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.expired
             (fun f -> ("expired", (Boolean.to_json f)));
           Util.option_map v.expiration_date
             (fun f -> ("expiration_date", (DateTime.to_json f)));
           Util.option_map v.registrations_count
             (fun f -> ("registrations_count", (Integer.to_json f)));
           Util.option_map v.registration_limit
             (fun f -> ("registration_limit", (Integer.to_json f)));
           Util.option_map v.iam_role
             (fun f -> ("iam_role", (String.to_json f)));
           Util.option_map v.default_instance_name
             (fun f -> ("default_instance_name", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.activation_id
             (fun f -> ("activation_id", (String.to_json f)))])
    let of_json j =
      {
        activation_id =
          (Util.option_map (Json.lookup j "activation_id") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        default_instance_name =
          (Util.option_map (Json.lookup j "default_instance_name")
             String.of_json);
        iam_role =
          (Util.option_map (Json.lookup j "iam_role") String.of_json);
        registration_limit =
          (Util.option_map (Json.lookup j "registration_limit")
             Integer.of_json);
        registrations_count =
          (Util.option_map (Json.lookup j "registrations_count")
             Integer.of_json);
        expiration_date =
          (Util.option_map (Json.lookup j "expiration_date") DateTime.of_json);
        expired = (Util.option_map (Json.lookup j "expired") Boolean.of_json);
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end[@@ocaml.doc
       "<p>An activation registers one or more on-premises servers or virtual machines (VMs) with AWS so that you can configure those servers or VMs using Run Command. A server or VM that has been registered with AWS is called a managed instance.</p>"]
module ComplianceItem =
  struct
    type t =
      {
      compliance_type: String.t option
        [@ocaml.doc
          "<p>The compliance type. For example, Association (for a State Manager association), Patch, or Custom:<code>string</code> are all valid compliance types.</p>"];
      resource_type: String.t option
        [@ocaml.doc
          "<p>The type of resource. <code>ManagedInstance</code> is currently the only supported resource type.</p>"];
      resource_id: String.t option
        [@ocaml.doc
          "<p>An ID for the resource. For a managed instance, this is the instance ID.</p>"];
      id: String.t option
        [@ocaml.doc
          "<p>An ID for the compliance item. For example, if the compliance item is a Windows patch, the ID could be the number of the KB article; for example: KB4010320.</p>"];
      title: String.t option
        [@ocaml.doc
          "<p>A title for the compliance item. For example, if the compliance item is a Windows patch, the title could be the title of the KB article for the patch; for example: Security Update for Active Directory Federation Services.</p>"];
      status: ComplianceStatus.t option
        [@ocaml.doc
          "<p>The status of the compliance item. An item is either COMPLIANT or NON_COMPLIANT.</p>"];
      severity: ComplianceSeverity.t option
        [@ocaml.doc
          "<p>The severity of the compliance status. Severity can be one of the following: Critical, High, Medium, Low, Informational, Unspecified.</p>"];
      execution_summary: ComplianceExecutionSummary.t option
        [@ocaml.doc
          "<p>A summary for the compliance item. The summary includes an execution ID, the execution type (for example, command), and the execution time.</p>"];
      details: ComplianceItemDetails.t option
        [@ocaml.doc
          "<p>A \"Key\": \"Value\" tag combination for the compliance item.</p>"]}
    [@@ocaml.doc
      "<p>Information about the compliance as defined by the resource type. For example, for a patch resource type, <code>Items</code> includes information about the PatchSeverity, Classification, etc.</p>"]
    let make ?compliance_type  ?resource_type  ?resource_id  ?id  ?title 
      ?status  ?severity  ?execution_summary  ?details  () =
      {
        compliance_type;
        resource_type;
        resource_id;
        id;
        title;
        status;
        severity;
        execution_summary;
        details
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (ComplianceItemDetails.to_json f)));
           Util.option_map v.execution_summary
             (fun f ->
                ("execution_summary", (ComplianceExecutionSummary.to_json f)));
           Util.option_map v.severity
             (fun f -> ("severity", (ComplianceSeverity.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (ComplianceStatus.to_json f)));
           Util.option_map v.title (fun f -> ("title", (String.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)));
           Util.option_map v.resource_id
             (fun f -> ("resource_id", (String.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)));
           Util.option_map v.compliance_type
             (fun f -> ("compliance_type", (String.to_json f)))])
    let of_json j =
      {
        compliance_type =
          (Util.option_map (Json.lookup j "compliance_type") String.of_json);
        resource_type =
          (Util.option_map (Json.lookup j "resource_type") String.of_json);
        resource_id =
          (Util.option_map (Json.lookup j "resource_id") String.of_json);
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        title = (Util.option_map (Json.lookup j "title") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status") ComplianceStatus.of_json);
        severity =
          (Util.option_map (Json.lookup j "severity")
             ComplianceSeverity.of_json);
        execution_summary =
          (Util.option_map (Json.lookup j "execution_summary")
             ComplianceExecutionSummary.of_json);
        details =
          (Util.option_map (Json.lookup j "details")
             ComplianceItemDetails.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about the compliance as defined by the resource type. For example, for a patch resource type, <code>Items</code> includes information about the PatchSeverity, Classification, etc.</p>"]
module MaintenanceWindowTask =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window where the task is registered.</p>"];
      window_task_id: String.t option [@ocaml.doc "<p>The task ID.</p>"];
      task_arn: String.t option
        [@ocaml.doc
          "<p>The resource that the task uses during execution. For RUN_COMMAND and AUTOMATION task types, <code>TaskArn</code> is the Systems Manager document name or ARN. For LAMBDA tasks, it's the function name or ARN. For STEP_FUNCTIONS tasks, it's the state machine ARN.</p>"];
      type_: MaintenanceWindowTaskType.t option
        [@ocaml.doc
          "<p>The type of task. The type can be one of the following: RUN_COMMAND, AUTOMATION, LAMBDA, or STEP_FUNCTIONS.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets (either instances or tags). Instances are specified using Key=instanceids,Values=&lt;instanceid1&gt;,&lt;instanceid2&gt;. Tags are specified using Key=&lt;tag name&gt;,Values=&lt;tag value&gt;.</p>"];
      task_parameters: MaintenanceWindowTaskParameters.t option
        [@ocaml.doc
          "<p>The parameters that should be passed to the task when it is run.</p> <note> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The priority of the task in the maintenance window. The lower the number, the higher the priority. Tasks that have the same priority are scheduled in parallel.</p>"];
      logging_info: LoggingInfo.t option
        [@ocaml.doc
          "<p>Information about an Amazon S3 bucket to write task-level logs to.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets this task can be run for, in parallel.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The maximum number of errors allowed before this task stops being scheduled.</p>"];
      name: String.t option [@ocaml.doc "<p>The task name.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the task.</p>"]}[@@ocaml.doc
                                                           "<p>Information about a task defined for a maintenance window.</p>"]
    let make ?window_id  ?window_task_id  ?task_arn  ?type_  ?(targets= []) 
      ?task_parameters  ?priority  ?logging_info  ?service_role_arn 
      ?max_concurrency  ?max_errors  ?name  ?description  () =
      {
        window_id;
        window_task_id;
        task_arn;
        type_;
        targets;
        task_parameters;
        priority;
        logging_info;
        service_role_arn;
        max_concurrency;
        max_errors;
        name;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Util.option_map v.logging_info
             (fun f -> ("logging_info", (LoggingInfo.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Util.option_map v.task_parameters
             (fun f ->
                ("task_parameters",
                  (MaintenanceWindowTaskParameters.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.type_
             (fun f -> ("type_", (MaintenanceWindowTaskType.to_json f)));
           Util.option_map v.task_arn
             (fun f -> ("task_arn", (String.to_json f)));
           Util.option_map v.window_task_id
             (fun f -> ("window_task_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_task_id =
          (Util.option_map (Json.lookup j "window_task_id") String.of_json);
        task_arn =
          (Util.option_map (Json.lookup j "task_arn") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_")
             MaintenanceWindowTaskType.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        task_parameters =
          (Util.option_map (Json.lookup j "task_parameters")
             MaintenanceWindowTaskParameters.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        logging_info =
          (Util.option_map (Json.lookup j "logging_info") LoggingInfo.of_json);
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about a task defined for a maintenance window.</p>"]
module CommandFilter =
  struct
    type t =
      {
      key: CommandFilterKey.t [@ocaml.doc "<p>The name of the filter.</p>"];
      value: String.t
        [@ocaml.doc
          "<p>The filter value. Valid values for each filter key are as follows:</p> <ul> <li> <p> <b>InvokedAfter</b>: Specify a timestamp to limit your results. For example, specify <code>2018-07-07T00:00:00Z</code> to see a list of command executions occurring July 7, 2018, and later.</p> </li> <li> <p> <b>InvokedBefore</b>: Specify a timestamp to limit your results. For example, specify <code>2018-07-07T00:00:00Z</code> to see a list of command executions from before July 7, 2018.</p> </li> <li> <p> <b>Status</b>: Specify a valid command status to see a list of all command executions with that status. Status values you can specify include:</p> <ul> <li> <p> <code>Pending</code> </p> </li> <li> <p> <code>InProgress</code> </p> </li> <li> <p> <code>Success</code> </p> </li> <li> <p> <code>Cancelled</code> </p> </li> <li> <p> <code>Failed</code> </p> </li> <li> <p> <code>TimedOut</code> </p> </li> <li> <p> <code>Cancelling</code> </p> </li> </ul> </li> <li> <p> <b>DocumentName</b>: Specify name of the SSM document for which you want to see command execution results. For example, specify <code>AWS-RunPatchBaseline</code> to see command executions that used this SSM document to perform security patching operations on instances. </p> </li> <li> <p> <b>ExecutionStage</b>: Specify one of the following values:</p> <ul> <li> <p> <code>Executing</code>: Returns a list of command executions that are currently still running.</p> </li> <li> <p> <code>Complete</code>: Returns a list of command executions that have already completed. </p> </li> </ul> </li> </ul>"]}
    [@@ocaml.doc "<p>Describes a command filter.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (CommandFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (CommandFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end[@@ocaml.doc "<p>Describes a command filter.</p>"]
module InventoryResultEntity =
  struct
    type t =
      {
      id: String.t option
        [@ocaml.doc
          "<p>ID of the inventory result entity. For example, for managed instance inventory the result will be the managed instance ID. For EC2 instance inventory, the result will be the instance ID. </p>"];
      data: InventoryResultItemMap.t option
        [@ocaml.doc
          "<p>The data section in the inventory result entity JSON.</p>"]}
    [@@ocaml.doc "<p>Inventory query results.</p>"]
    let make ?id  ?data  () = { id; data }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.data
              (fun f -> ("data", (InventoryResultItemMap.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        data =
          (Util.option_map (Json.lookup j "data")
             InventoryResultItemMap.of_json)
      }
  end[@@ocaml.doc "<p>Inventory query results.</p>"]
module InstanceAssociation =
  struct
    type t =
      {
      association_id: String.t option
        [@ocaml.doc "<p>The association ID.</p>"];
      instance_id: String.t option [@ocaml.doc "<p>The instance ID.</p>"];
      content: String.t option
        [@ocaml.doc
          "<p>The content of the association document for the instance(s).</p>"];
      association_version: String.t option
        [@ocaml.doc
          "<p>Version information for the association on the instance.</p>"]}
    [@@ocaml.doc
      "<p>One or more association documents on the instance. </p>"]
    let make ?association_id  ?instance_id  ?content  ?association_version 
      () = { association_id; instance_id; content; association_version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_version
              (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.content
             (fun f -> ("content", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)))])
    let of_json j =
      {
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        content = (Util.option_map (Json.lookup j "content") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>One or more association documents on the instance. </p>"]
module PatchPropertyEntry =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module MaintenanceWindowFilter =
  struct
    type t =
      {
      key: String.t option [@ocaml.doc "<p>The name of the filter.</p>"];
      values: MaintenanceWindowFilterValues.t
        [@ocaml.doc "<p>The filter values.</p>"]}[@@ocaml.doc
                                                   "<p>Filter used in the request. Supported filter keys are Name and Enabled.</p>"]
    let make ?key  ?(values= [])  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (MaintenanceWindowFilterValues.to_json v.values));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        values =
          (MaintenanceWindowFilterValues.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>Filter used in the request. Supported filter keys are Name and Enabled.</p>"]
module ResourceComplianceSummaryItem =
  struct
    type t =
      {
      compliance_type: String.t option
        [@ocaml.doc "<p>The compliance type.</p>"];
      resource_type: String.t option [@ocaml.doc "<p>The resource type.</p>"];
      resource_id: String.t option [@ocaml.doc "<p>The resource ID.</p>"];
      status: ComplianceStatus.t option
        [@ocaml.doc "<p>The compliance status for the resource.</p>"];
      overall_severity: ComplianceSeverity.t option
        [@ocaml.doc
          "<p>The highest severity item found for the resource. The resource is compliant for this item.</p>"];
      execution_summary: ComplianceExecutionSummary.t option
        [@ocaml.doc "<p>Information about the execution.</p>"];
      compliant_summary: CompliantSummary.t option
        [@ocaml.doc
          "<p>A list of items that are compliant for the resource.</p>"];
      non_compliant_summary: NonCompliantSummary.t option
        [@ocaml.doc
          "<p>A list of items that aren't compliant for the resource.</p>"]}
    [@@ocaml.doc
      "<p>Compliance summary information for a specific resource. </p>"]
    let make ?compliance_type  ?resource_type  ?resource_id  ?status 
      ?overall_severity  ?execution_summary  ?compliant_summary 
      ?non_compliant_summary  () =
      {
        compliance_type;
        resource_type;
        resource_id;
        status;
        overall_severity;
        execution_summary;
        compliant_summary;
        non_compliant_summary
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.non_compliant_summary
              (fun f ->
                 ("non_compliant_summary", (NonCompliantSummary.to_json f)));
           Util.option_map v.compliant_summary
             (fun f -> ("compliant_summary", (CompliantSummary.to_json f)));
           Util.option_map v.execution_summary
             (fun f ->
                ("execution_summary", (ComplianceExecutionSummary.to_json f)));
           Util.option_map v.overall_severity
             (fun f -> ("overall_severity", (ComplianceSeverity.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (ComplianceStatus.to_json f)));
           Util.option_map v.resource_id
             (fun f -> ("resource_id", (String.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)));
           Util.option_map v.compliance_type
             (fun f -> ("compliance_type", (String.to_json f)))])
    let of_json j =
      {
        compliance_type =
          (Util.option_map (Json.lookup j "compliance_type") String.of_json);
        resource_type =
          (Util.option_map (Json.lookup j "resource_type") String.of_json);
        resource_id =
          (Util.option_map (Json.lookup j "resource_id") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status") ComplianceStatus.of_json);
        overall_severity =
          (Util.option_map (Json.lookup j "overall_severity")
             ComplianceSeverity.of_json);
        execution_summary =
          (Util.option_map (Json.lookup j "execution_summary")
             ComplianceExecutionSummary.of_json);
        compliant_summary =
          (Util.option_map (Json.lookup j "compliant_summary")
             CompliantSummary.of_json);
        non_compliant_summary =
          (Util.option_map (Json.lookup j "non_compliant_summary")
             NonCompliantSummary.of_json)
      }
  end[@@ocaml.doc
       "<p>Compliance summary information for a specific resource. </p>"]
module InstancePatchStateFilter =
  struct
    type t =
      {
      key: String.t
        [@ocaml.doc
          "<p>The key for the filter. Supported values are FailedCount, InstalledCount, InstalledOtherCount, MissingCount and NotApplicableCount.</p>"];
      values: InstancePatchStateFilterValues.t
        [@ocaml.doc
          "<p>The value for the filter, must be an integer greater than or equal to 0.</p>"];
      type_: InstancePatchStateOperatorType.t
        [@ocaml.doc
          "<p>The type of comparison that should be performed for the value: Equal, NotEqual, LessThan or GreaterThan.</p>"]}
    [@@ocaml.doc
      "<p>Defines a filter used in DescribeInstancePatchStatesForPatchGroup used to scope down the information returned by the API.</p>"]
    let make ~key  ~values  ~type_  () = { key; values; type_ }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("type_", (InstancePatchStateOperatorType.to_json v.type_));
           Some ("values", (InstancePatchStateFilterValues.to_json v.values));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        values =
          (InstancePatchStateFilterValues.of_json
             (Util.of_option_exn (Json.lookup j "values")));
        type_ =
          (InstancePatchStateOperatorType.of_json
             (Util.of_option_exn (Json.lookup j "type_")))
      }
  end[@@ocaml.doc
       "<p>Defines a filter used in DescribeInstancePatchStatesForPatchGroup used to scope down the information returned by the API.</p>"]
module AssociationExecutionTarget =
  struct
    type t =
      {
      association_id: String.t option
        [@ocaml.doc "<p>The association ID.</p>"];
      association_version: String.t option
        [@ocaml.doc "<p>The association version.</p>"];
      execution_id: String.t option [@ocaml.doc "<p>The execution ID.</p>"];
      resource_id: String.t option
        [@ocaml.doc
          "<p>The resource ID, for example, the instance ID where the association ran.</p>"];
      resource_type: String.t option
        [@ocaml.doc "<p>The resource type, for example, instance.</p>"];
      status: String.t option
        [@ocaml.doc "<p>The association execution status.</p>"];
      detailed_status: String.t option
        [@ocaml.doc
          "<p>Detailed information about the execution status.</p>"];
      last_execution_date: DateTime.t option
        [@ocaml.doc "<p>The date of the last execution.</p>"];
      output_source: OutputSource.t option
        [@ocaml.doc
          "<p>The location where the association details are saved.</p>"]}
    [@@ocaml.doc
      "<p>Includes information about the specified association execution.</p>"]
    let make ?association_id  ?association_version  ?execution_id 
      ?resource_id  ?resource_type  ?status  ?detailed_status 
      ?last_execution_date  ?output_source  () =
      {
        association_id;
        association_version;
        execution_id;
        resource_id;
        resource_type;
        status;
        detailed_status;
        last_execution_date;
        output_source
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_source
              (fun f -> ("output_source", (OutputSource.to_json f)));
           Util.option_map v.last_execution_date
             (fun f -> ("last_execution_date", (DateTime.to_json f)));
           Util.option_map v.detailed_status
             (fun f -> ("detailed_status", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.resource_type
             (fun f -> ("resource_type", (String.to_json f)));
           Util.option_map v.resource_id
             (fun f -> ("resource_id", (String.to_json f)));
           Util.option_map v.execution_id
             (fun f -> ("execution_id", (String.to_json f)));
           Util.option_map v.association_version
             (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)))])
    let of_json j =
      {
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json);
        execution_id =
          (Util.option_map (Json.lookup j "execution_id") String.of_json);
        resource_id =
          (Util.option_map (Json.lookup j "resource_id") String.of_json);
        resource_type =
          (Util.option_map (Json.lookup j "resource_type") String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        detailed_status =
          (Util.option_map (Json.lookup j "detailed_status") String.of_json);
        last_execution_date =
          (Util.option_map (Json.lookup j "last_execution_date")
             DateTime.of_json);
        output_source =
          (Util.option_map (Json.lookup j "output_source")
             OutputSource.of_json)
      }
  end[@@ocaml.doc
       "<p>Includes information about the specified association execution.</p>"]
module AssociationExecution =
  struct
    type t =
      {
      association_id: String.t option
        [@ocaml.doc "<p>The association ID.</p>"];
      association_version: String.t option
        [@ocaml.doc "<p>The association version.</p>"];
      execution_id: String.t option
        [@ocaml.doc "<p>The execution ID for the association.</p>"];
      status: String.t option
        [@ocaml.doc "<p>The status of the association execution.</p>"];
      detailed_status: String.t option
        [@ocaml.doc
          "<p>Detailed status information about the execution.</p>"];
      created_time: DateTime.t option
        [@ocaml.doc "<p>The time the execution started.</p>"];
      last_execution_date: DateTime.t option
        [@ocaml.doc "<p>The date of the last execution.</p>"];
      resource_count_by_status: String.t option
        [@ocaml.doc
          "<p>An aggregate status of the resources in the execution based on the status type.</p>"]}
    [@@ocaml.doc
      "<p>Includes information about the specified association.</p>"]
    let make ?association_id  ?association_version  ?execution_id  ?status 
      ?detailed_status  ?created_time  ?last_execution_date 
      ?resource_count_by_status  () =
      {
        association_id;
        association_version;
        execution_id;
        status;
        detailed_status;
        created_time;
        last_execution_date;
        resource_count_by_status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.resource_count_by_status
              (fun f -> ("resource_count_by_status", (String.to_json f)));
           Util.option_map v.last_execution_date
             (fun f -> ("last_execution_date", (DateTime.to_json f)));
           Util.option_map v.created_time
             (fun f -> ("created_time", (DateTime.to_json f)));
           Util.option_map v.detailed_status
             (fun f -> ("detailed_status", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.execution_id
             (fun f -> ("execution_id", (String.to_json f)));
           Util.option_map v.association_version
             (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)))])
    let of_json j =
      {
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json);
        execution_id =
          (Util.option_map (Json.lookup j "execution_id") String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        detailed_status =
          (Util.option_map (Json.lookup j "detailed_status") String.of_json);
        created_time =
          (Util.option_map (Json.lookup j "created_time") DateTime.of_json);
        last_execution_date =
          (Util.option_map (Json.lookup j "last_execution_date")
             DateTime.of_json);
        resource_count_by_status =
          (Util.option_map (Json.lookup j "resource_count_by_status")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>Includes information about the specified association.</p>"]
module Parameter =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of the parameter.</p>"];
      type_: ParameterType.t option
        [@ocaml.doc
          "<p>The type of parameter. Valid values include the following: String, String list, Secure string.</p>"];
      value: String.t option [@ocaml.doc "<p>The parameter value.</p>"];
      version: Long.t option [@ocaml.doc "<p>The parameter version.</p>"];
      selector: String.t option
        [@ocaml.doc
          "<p>Either the version number or the label used to retrieve the parameter value. Specify selectors by using one of the following formats:</p> <p>parameter_name:version</p> <p>parameter_name:label</p>"];
      source_result: String.t option
        [@ocaml.doc
          "<p>Applies to parameters that reference information in other AWS services. SourceResult is the raw result or response from the source.</p>"];
      last_modified_date: DateTime.t option
        [@ocaml.doc
          "<p>Date the parameter was last changed or updated and the parameter version was created.</p>"];
      a_r_n: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the parameter.</p>"]}
    [@@ocaml.doc
      "<p>An Amazon EC2 Systems Manager parameter in Parameter Store.</p>"]
    let make ?name  ?type_  ?value  ?version  ?selector  ?source_result 
      ?last_modified_date  ?a_r_n  () =
      {
        name;
        type_;
        value;
        version;
        selector;
        source_result;
        last_modified_date;
        a_r_n
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.a_r_n (fun f -> ("a_r_n", (String.to_json f)));
           Util.option_map v.last_modified_date
             (fun f -> ("last_modified_date", (DateTime.to_json f)));
           Util.option_map v.source_result
             (fun f -> ("source_result", (String.to_json f)));
           Util.option_map v.selector
             (fun f -> ("selector", (String.to_json f)));
           Util.option_map v.version (fun f -> ("version", (Long.to_json f)));
           Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (ParameterType.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_") ParameterType.of_json);
        value = (Util.option_map (Json.lookup j "value") String.of_json);
        version = (Util.option_map (Json.lookup j "version") Long.of_json);
        selector =
          (Util.option_map (Json.lookup j "selector") String.of_json);
        source_result =
          (Util.option_map (Json.lookup j "source_result") String.of_json);
        last_modified_date =
          (Util.option_map (Json.lookup j "last_modified_date")
             DateTime.of_json);
        a_r_n = (Util.option_map (Json.lookup j "a_r_n") String.of_json)
      }
  end[@@ocaml.doc
       "<p>An Amazon EC2 Systems Manager parameter in Parameter Store.</p>"]
module InstancePatchState =
  struct
    type t =
      {
      instance_id: String.t
        [@ocaml.doc
          "<p>The ID of the managed instance the high-level patch compliance information was collected for.</p>"];
      patch_group: String.t
        [@ocaml.doc
          "<p>The name of the patch group the managed instance belongs to.</p>"];
      baseline_id: String.t
        [@ocaml.doc
          "<p>The ID of the patch baseline used to patch the instance.</p>"];
      snapshot_id: String.t option
        [@ocaml.doc
          "<p>The ID of the patch baseline snapshot used during the patching operation when this compliance data was collected.</p>"];
      install_override_list: String.t option
        [@ocaml.doc
          "<p>An https URL or an Amazon S3 path-style URL to a list of patches to be installed. This patch installation list, which you maintain in an Amazon S3 bucket in YAML format and specify in the SSM document <code>AWS-RunPatchBaseline</code>, overrides the patches specified by the default patch baseline.</p> <p>For more information about the <code>InstallOverrideList</code> parameter, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-about-aws-runpatchbaseline.html\">About the SSM Document AWS-RunPatchBaseline</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      owner_information: String.t option
        [@ocaml.doc
          "<p>Placeholder information. This field will always be empty in the current release of the service.</p>"];
      installed_count: Integer.t option
        [@ocaml.doc
          "<p>The number of patches from the patch baseline that are installed on the instance.</p>"];
      installed_other_count: Integer.t option
        [@ocaml.doc
          "<p>The number of patches not specified in the patch baseline that are installed on the instance.</p>"];
      installed_pending_reboot_count: Integer.t option
        [@ocaml.doc "<p>Reserved for future use.</p>"];
      installed_rejected_count: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with patches installed that are specified in a RejectedPatches list. Patches with a status of <i>InstalledRejected</i> were typically installed before they were added to a RejectedPatches list.</p> <note> <p>If ALLOW_AS_DEPENDENCY is the specified option for RejectedPatchesAction, the value of InstalledRejectedCount will always be 0 (zero).</p> </note>"];
      missing_count: Integer.t option
        [@ocaml.doc
          "<p>The number of patches from the patch baseline that are applicable for the instance but aren't currently installed.</p>"];
      failed_count: Integer.t option
        [@ocaml.doc
          "<p>The number of patches from the patch baseline that were attempted to be installed during the last patching operation, but failed to install.</p>"];
      unreported_not_applicable_count: Integer.t option
        [@ocaml.doc
          "<p>The number of patches beyond the supported limit of <code>NotApplicableCount</code> that are not reported by name to Systems Manager Inventory.</p>"];
      not_applicable_count: Integer.t option
        [@ocaml.doc
          "<p>The number of patches from the patch baseline that aren't applicable for the instance and therefore aren't installed on the instance. This number may be truncated if the list of patch names is very large. The number of patches beyond this limit are reported in <code>UnreportedNotApplicableCount</code>.</p>"];
      operation_start_time: DateTime.t
        [@ocaml.doc
          "<p>The time the most recent patching operation was started on the instance.</p>"];
      operation_end_time: DateTime.t
        [@ocaml.doc
          "<p>The time the most recent patching operation completed on the instance.</p>"];
      operation: PatchOperationType.t
        [@ocaml.doc
          "<p>The type of patching operation that was performed: SCAN (assess patch compliance state) or INSTALL (install missing patches).</p>"];
      last_no_reboot_install_operation_time: DateTime.t option
        [@ocaml.doc "<p>Reserved for future use. </p>"];
      reboot_option: RebootOption.t option
        [@ocaml.doc "<p>Reserved for future use. </p>"]}[@@ocaml.doc
                                                          "<p>Defines the high-level patch compliance state for a managed instance, providing information about the number of installed, missing, not applicable, and failed patches along with metadata about the operation when this information was gathered for the instance.</p>"]
    let make ~instance_id  ~patch_group  ~baseline_id  ?snapshot_id 
      ?install_override_list  ?owner_information  ?installed_count 
      ?installed_other_count  ?installed_pending_reboot_count 
      ?installed_rejected_count  ?missing_count  ?failed_count 
      ?unreported_not_applicable_count  ?not_applicable_count 
      ~operation_start_time  ~operation_end_time  ~operation 
      ?last_no_reboot_install_operation_time  ?reboot_option  () =
      {
        instance_id;
        patch_group;
        baseline_id;
        snapshot_id;
        install_override_list;
        owner_information;
        installed_count;
        installed_other_count;
        installed_pending_reboot_count;
        installed_rejected_count;
        missing_count;
        failed_count;
        unreported_not_applicable_count;
        not_applicable_count;
        operation_start_time;
        operation_end_time;
        operation;
        last_no_reboot_install_operation_time;
        reboot_option
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.reboot_option
              (fun f -> ("reboot_option", (RebootOption.to_json f)));
           Util.option_map v.last_no_reboot_install_operation_time
             (fun f ->
                ("last_no_reboot_install_operation_time",
                  (DateTime.to_json f)));
           Some ("operation", (PatchOperationType.to_json v.operation));
           Some
             ("operation_end_time", (DateTime.to_json v.operation_end_time));
           Some
             ("operation_start_time",
               (DateTime.to_json v.operation_start_time));
           Util.option_map v.not_applicable_count
             (fun f -> ("not_applicable_count", (Integer.to_json f)));
           Util.option_map v.unreported_not_applicable_count
             (fun f ->
                ("unreported_not_applicable_count", (Integer.to_json f)));
           Util.option_map v.failed_count
             (fun f -> ("failed_count", (Integer.to_json f)));
           Util.option_map v.missing_count
             (fun f -> ("missing_count", (Integer.to_json f)));
           Util.option_map v.installed_rejected_count
             (fun f -> ("installed_rejected_count", (Integer.to_json f)));
           Util.option_map v.installed_pending_reboot_count
             (fun f ->
                ("installed_pending_reboot_count", (Integer.to_json f)));
           Util.option_map v.installed_other_count
             (fun f -> ("installed_other_count", (Integer.to_json f)));
           Util.option_map v.installed_count
             (fun f -> ("installed_count", (Integer.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Util.option_map v.install_override_list
             (fun f -> ("install_override_list", (String.to_json f)));
           Util.option_map v.snapshot_id
             (fun f -> ("snapshot_id", (String.to_json f)));
           Some ("baseline_id", (String.to_json v.baseline_id));
           Some ("patch_group", (String.to_json v.patch_group));
           Some ("instance_id", (String.to_json v.instance_id))])
    let of_json j =
      {
        instance_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "instance_id")));
        patch_group =
          (String.of_json (Util.of_option_exn (Json.lookup j "patch_group")));
        baseline_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "baseline_id")));
        snapshot_id =
          (Util.option_map (Json.lookup j "snapshot_id") String.of_json);
        install_override_list =
          (Util.option_map (Json.lookup j "install_override_list")
             String.of_json);
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        installed_count =
          (Util.option_map (Json.lookup j "installed_count") Integer.of_json);
        installed_other_count =
          (Util.option_map (Json.lookup j "installed_other_count")
             Integer.of_json);
        installed_pending_reboot_count =
          (Util.option_map (Json.lookup j "installed_pending_reboot_count")
             Integer.of_json);
        installed_rejected_count =
          (Util.option_map (Json.lookup j "installed_rejected_count")
             Integer.of_json);
        missing_count =
          (Util.option_map (Json.lookup j "missing_count") Integer.of_json);
        failed_count =
          (Util.option_map (Json.lookup j "failed_count") Integer.of_json);
        unreported_not_applicable_count =
          (Util.option_map (Json.lookup j "unreported_not_applicable_count")
             Integer.of_json);
        not_applicable_count =
          (Util.option_map (Json.lookup j "not_applicable_count")
             Integer.of_json);
        operation_start_time =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "operation_start_time")));
        operation_end_time =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "operation_end_time")));
        operation =
          (PatchOperationType.of_json
             (Util.of_option_exn (Json.lookup j "operation")));
        last_no_reboot_install_operation_time =
          (Util.option_map
             (Json.lookup j "last_no_reboot_install_operation_time")
             DateTime.of_json);
        reboot_option =
          (Util.option_map (Json.lookup j "reboot_option")
             RebootOption.of_json)
      }
  end[@@ocaml.doc
       "<p>Defines the high-level patch compliance state for a managed instance, providing information about the number of installed, missing, not applicable, and failed patches along with metadata about the operation when this information was gathered for the instance.</p>"]
module AutomationExecutionFilter =
  struct
    type t =
      {
      key: AutomationExecutionFilterKey.t
        [@ocaml.doc
          "<p>One or more keys to limit the results. Valid filter keys include the following: DocumentNamePrefix, ExecutionStatus, ExecutionId, ParentExecutionId, CurrentAction, StartTimeBefore, StartTimeAfter.</p>"];
      values: AutomationExecutionFilterValueList.t
        [@ocaml.doc
          "<p>The values used to limit the execution information associated with the filter's key.</p>"]}
    [@@ocaml.doc
      "<p>A filter used to match specific automation executions. This is used to limit the scope of Automation execution information returned.</p>"]
    let make ~key  ~values  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("values",
                (AutomationExecutionFilterValueList.to_json v.values));
           Some ("key", (AutomationExecutionFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (AutomationExecutionFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        values =
          (AutomationExecutionFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>A filter used to match specific automation executions. This is used to limit the scope of Automation execution information returned.</p>"]
module Command =
  struct
    type t =
      {
      command_id: String.t option
        [@ocaml.doc "<p>A unique identifier for this command.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The name of the document requested for execution.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The SSM document version.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>User-specified information about the command, such as a brief description of what the command should do.</p>"];
      expires_after: DateTime.t option
        [@ocaml.doc
          "<p>If this time is reached and the command has not already started running, it will not run. Calculated based on the ExpiresAfter user input provided as part of the SendCommand API.</p>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>The parameter values to be inserted in the document when running the command.</p>"];
      instance_ids: InstanceIdList.t
        [@ocaml.doc
          "<p>The instance IDs against which this command was requested.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>An array of search criteria that targets instances using a Key,Value combination that you specify. Targets is required if you don't provide one or more instance IDs in the call.</p>"];
      requested_date_time: DateTime.t option
        [@ocaml.doc "<p>The date and time the command was requested.</p>"];
      status: CommandStatus.t option
        [@ocaml.doc "<p>The status of the command.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>A detailed status of the command execution. StatusDetails includes more information than Status because it includes states resulting from error and concurrency control parameters. StatusDetails can show different results than Status. For more information about these statuses, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html\">Understanding Command Statuses</a> in the <i>AWS Systems Manager User Guide</i>. StatusDetails can be one of the following values:</p> <ul> <li> <p>Pending: The command has not been sent to any instances.</p> </li> <li> <p>In Progress: The command has been sent to at least one instance but has not reached a final state on all instances.</p> </li> <li> <p>Success: The command successfully ran on all invocations. This is a terminal state.</p> </li> <li> <p>Delivery Timed Out: The value of MaxErrors or more command invocations shows a status of Delivery Timed Out. This is a terminal state.</p> </li> <li> <p>Execution Timed Out: The value of MaxErrors or more command invocations shows a status of Execution Timed Out. This is a terminal state.</p> </li> <li> <p>Failed: The value of MaxErrors or more command invocations shows a status of Failed. This is a terminal state.</p> </li> <li> <p>Incomplete: The command was attempted on all instances and one or more invocations does not have a value of Success but not enough invocations failed for the status to be Failed. This is a terminal state.</p> </li> <li> <p>Canceled: The command was terminated before it was completed. This is a terminal state.</p> </li> <li> <p>Rate Exceeded: The number of instances targeted by the command exceeded the account limit for pending invocations. The system has canceled the command before running it on any instance. This is a terminal state.</p> </li> </ul>"];
      output_s3_region: String.t option
        [@ocaml.doc
          "<p>(Deprecated) You can no longer specify this parameter. The system ignores it. Instead, Systems Manager automatically determines the Amazon S3 bucket region.</p>"];
      output_s3_bucket_name: String.t option
        [@ocaml.doc
          "<p>The S3 bucket where the responses to the command executions should be stored. This was requested when issuing the command.</p>"];
      output_s3_key_prefix: String.t option
        [@ocaml.doc
          "<p>The S3 directory path inside the bucket where the responses to the command executions should be stored. This was requested when issuing the command.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of instances that are allowed to run the command at the same time. You can specify a number of instances, such as 10, or a percentage of instances, such as 10%. The default value is 50. For more information about how to use MaxConcurrency, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html\">Running Commands Using Systems Manager Run Command</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The maximum number of errors allowed before the system stops sending the command to additional targets. You can specify a number of errors, such as 10, or a percentage or errors, such as 10%. The default value is 0. For more information about how to use MaxErrors, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/run-command.html\">Running Commands Using Systems Manager Run Command</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      target_count: Integer.t option
        [@ocaml.doc "<p>The number of targets for the command.</p>"];
      completed_count: Integer.t option
        [@ocaml.doc
          "<p>The number of targets for which the command invocation reached a terminal state. Terminal states include the following: Success, Failed, Execution Timed Out, Delivery Timed Out, Canceled, Terminated, or Undeliverable.</p>"];
      error_count: Integer.t option
        [@ocaml.doc
          "<p>The number of targets for which the status is Failed or Execution Timed Out.</p>"];
      delivery_timed_out_count: Integer.t option
        [@ocaml.doc
          "<p>The number of targets for which the status is Delivery Timed Out.</p>"];
      service_role: String.t option
        [@ocaml.doc
          "<p>The IAM service role that Run Command uses to act on your behalf when sending notifications about command status changes. </p>"];
      notification_config: NotificationConfig.t option
        [@ocaml.doc
          "<p>Configurations for sending notifications about command status changes. </p>"];
      cloud_watch_output_config: CloudWatchOutputConfig.t option
        [@ocaml.doc
          "<p>CloudWatch Logs information where you want Systems Manager to send the command output.</p>"]}
    [@@ocaml.doc "<p>Describes a command request.</p>"]
    let make ?command_id  ?document_name  ?document_version  ?comment 
      ?expires_after  ?parameters  ?(instance_ids= [])  ?(targets= []) 
      ?requested_date_time  ?status  ?status_details  ?output_s3_region 
      ?output_s3_bucket_name  ?output_s3_key_prefix  ?max_concurrency 
      ?max_errors  ?target_count  ?completed_count  ?error_count 
      ?delivery_timed_out_count  ?service_role  ?notification_config 
      ?cloud_watch_output_config  () =
      {
        command_id;
        document_name;
        document_version;
        comment;
        expires_after;
        parameters;
        instance_ids;
        targets;
        requested_date_time;
        status;
        status_details;
        output_s3_region;
        output_s3_bucket_name;
        output_s3_key_prefix;
        max_concurrency;
        max_errors;
        target_count;
        completed_count;
        error_count;
        delivery_timed_out_count;
        service_role;
        notification_config;
        cloud_watch_output_config
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_output_config
              (fun f ->
                 ("cloud_watch_output_config",
                   (CloudWatchOutputConfig.to_json f)));
           Util.option_map v.notification_config
             (fun f ->
                ("notification_config", (NotificationConfig.to_json f)));
           Util.option_map v.service_role
             (fun f -> ("service_role", (String.to_json f)));
           Util.option_map v.delivery_timed_out_count
             (fun f -> ("delivery_timed_out_count", (Integer.to_json f)));
           Util.option_map v.error_count
             (fun f -> ("error_count", (Integer.to_json f)));
           Util.option_map v.completed_count
             (fun f -> ("completed_count", (Integer.to_json f)));
           Util.option_map v.target_count
             (fun f -> ("target_count", (Integer.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.output_s3_key_prefix
             (fun f -> ("output_s3_key_prefix", (String.to_json f)));
           Util.option_map v.output_s3_bucket_name
             (fun f -> ("output_s3_bucket_name", (String.to_json f)));
           Util.option_map v.output_s3_region
             (fun f -> ("output_s3_region", (String.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (CommandStatus.to_json f)));
           Util.option_map v.requested_date_time
             (fun f -> ("requested_date_time", (DateTime.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Some ("instance_ids", (InstanceIdList.to_json v.instance_ids));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.expires_after
             (fun f -> ("expires_after", (DateTime.to_json f)));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Util.option_map v.command_id
             (fun f -> ("command_id", (String.to_json f)))])
    let of_json j =
      {
        command_id =
          (Util.option_map (Json.lookup j "command_id") String.of_json);
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        comment = (Util.option_map (Json.lookup j "comment") String.of_json);
        expires_after =
          (Util.option_map (Json.lookup j "expires_after") DateTime.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        instance_ids =
          (InstanceIdList.of_json
             (Util.of_option_exn (Json.lookup j "instance_ids")));
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        requested_date_time =
          (Util.option_map (Json.lookup j "requested_date_time")
             DateTime.of_json);
        status =
          (Util.option_map (Json.lookup j "status") CommandStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        output_s3_region =
          (Util.option_map (Json.lookup j "output_s3_region") String.of_json);
        output_s3_bucket_name =
          (Util.option_map (Json.lookup j "output_s3_bucket_name")
             String.of_json);
        output_s3_key_prefix =
          (Util.option_map (Json.lookup j "output_s3_key_prefix")
             String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        target_count =
          (Util.option_map (Json.lookup j "target_count") Integer.of_json);
        completed_count =
          (Util.option_map (Json.lookup j "completed_count") Integer.of_json);
        error_count =
          (Util.option_map (Json.lookup j "error_count") Integer.of_json);
        delivery_timed_out_count =
          (Util.option_map (Json.lookup j "delivery_timed_out_count")
             Integer.of_json);
        service_role =
          (Util.option_map (Json.lookup j "service_role") String.of_json);
        notification_config =
          (Util.option_map (Json.lookup j "notification_config")
             NotificationConfig.of_json);
        cloud_watch_output_config =
          (Util.option_map (Json.lookup j "cloud_watch_output_config")
             CloudWatchOutputConfig.of_json)
      }
  end[@@ocaml.doc "<p>Describes a command request.</p>"]
module MaintenanceWindowTarget =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window to register the target with.</p>"];
      window_target_id: String.t option
        [@ocaml.doc "<p>The ID of the target.</p>"];
      resource_type: MaintenanceWindowResourceType.t option
        [@ocaml.doc
          "<p>The type of target that is being registered with the maintenance window.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets, either instances or tags.</p> <p>Specify instances using the following format:</p> <p> <code>Key=instanceids,Values=&lt;instanceid1&gt;,&lt;instanceid2&gt;</code> </p> <p>Tags are specified using the following format:</p> <p> <code>Key=&lt;tag name&gt;,Values=&lt;tag value&gt;</code>.</p>"];
      owner_information: String.t option
        [@ocaml.doc
          "<p>A user-provided value that will be included in any CloudWatch events that are raised while running tasks for these targets in this maintenance window.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name for the maintenance window target.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description for the target.</p>"]}[@@ocaml.doc
                                                              "<p>The target registered with the maintenance window.</p>"]
    let make ?window_id  ?window_target_id  ?resource_type  ?(targets= []) 
      ?owner_information  ?name  ?description  () =
      {
        window_id;
        window_target_id;
        resource_type;
        targets;
        owner_information;
        name;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.resource_type
             (fun f ->
                ("resource_type", (MaintenanceWindowResourceType.to_json f)));
           Util.option_map v.window_target_id
             (fun f -> ("window_target_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_target_id =
          (Util.option_map (Json.lookup j "window_target_id") String.of_json);
        resource_type =
          (Util.option_map (Json.lookup j "resource_type")
             MaintenanceWindowResourceType.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json)
      }
  end[@@ocaml.doc
       "<p>The target registered with the maintenance window.</p>"]
module OpsItemSummary =
  struct
    type t =
      {
      created_by: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM entity that created the OpsItem.</p>"];
      created_time: DateTime.t option
        [@ocaml.doc "<p>The date and time the OpsItem was created.</p>"];
      last_modified_by: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the IAM entity that created the OpsItem.</p>"];
      last_modified_time: DateTime.t option
        [@ocaml.doc "<p>The date and time the OpsItem was last updated.</p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The importance of this OpsItem in relation to other OpsItems in the system.</p>"];
      source: String.t option
        [@ocaml.doc "<p>The impacted AWS resource.</p>"];
      status: OpsItemStatus.t option
        [@ocaml.doc
          "<p>The OpsItem status. Status can be <code>Open</code>, <code>In Progress</code>, or <code>Resolved</code>.</p>"];
      ops_item_id: String.t option
        [@ocaml.doc "<p>The ID of the OpsItem.</p>"];
      title: String.t option
        [@ocaml.doc
          "<p>A short heading that describes the nature of the OpsItem and the impacted resource.</p>"];
      operational_data: OpsItemOperationalData.t option
        [@ocaml.doc
          "<p>Operational data is custom data that provides useful reference details about the OpsItem. </p>"];
      category: String.t option
        [@ocaml.doc "<p>A list of OpsItems by category.</p>"];
      severity: String.t option
        [@ocaml.doc "<p>A list of OpsItems by severity.</p>"]}[@@ocaml.doc
                                                                "<p>A count of OpsItems.</p>"]
    let make ?created_by  ?created_time  ?last_modified_by 
      ?last_modified_time  ?priority  ?source  ?status  ?ops_item_id  ?title 
      ?operational_data  ?category  ?severity  () =
      {
        created_by;
        created_time;
        last_modified_by;
        last_modified_time;
        priority;
        source;
        status;
        ops_item_id;
        title;
        operational_data;
        category;
        severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.severity
              (fun f -> ("severity", (String.to_json f)));
           Util.option_map v.category
             (fun f -> ("category", (String.to_json f)));
           Util.option_map v.operational_data
             (fun f ->
                ("operational_data", (OpsItemOperationalData.to_json f)));
           Util.option_map v.title (fun f -> ("title", (String.to_json f)));
           Util.option_map v.ops_item_id
             (fun f -> ("ops_item_id", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (OpsItemStatus.to_json f)));
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Util.option_map v.last_modified_time
             (fun f -> ("last_modified_time", (DateTime.to_json f)));
           Util.option_map v.last_modified_by
             (fun f -> ("last_modified_by", (String.to_json f)));
           Util.option_map v.created_time
             (fun f -> ("created_time", (DateTime.to_json f)));
           Util.option_map v.created_by
             (fun f -> ("created_by", (String.to_json f)))])
    let of_json j =
      {
        created_by =
          (Util.option_map (Json.lookup j "created_by") String.of_json);
        created_time =
          (Util.option_map (Json.lookup j "created_time") DateTime.of_json);
        last_modified_by =
          (Util.option_map (Json.lookup j "last_modified_by") String.of_json);
        last_modified_time =
          (Util.option_map (Json.lookup j "last_modified_time")
             DateTime.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        source = (Util.option_map (Json.lookup j "source") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status") OpsItemStatus.of_json);
        ops_item_id =
          (Util.option_map (Json.lookup j "ops_item_id") String.of_json);
        title = (Util.option_map (Json.lookup j "title") String.of_json);
        operational_data =
          (Util.option_map (Json.lookup j "operational_data")
             OpsItemOperationalData.of_json);
        category =
          (Util.option_map (Json.lookup j "category") String.of_json);
        severity =
          (Util.option_map (Json.lookup j "severity") String.of_json)
      }
  end[@@ocaml.doc "<p>A count of OpsItems.</p>"]
module OpsAggregatorValueMap =
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
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module OpsFilterList =
  struct
    type t = OpsFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsFilter.to_query v
    let to_headers v = Headers.to_headers_list OpsFilter.to_headers v
    let to_json v = `List (List.map OpsFilter.to_json v)
    let of_json j = Json.to_list OpsFilter.of_json j
  end
module OpsResultAttribute =
  struct
    type t =
      {
      type_name: String.t
        [@ocaml.doc
          "<p>Name of the data type. Valid value: AWS:OpsItem, AWS:EC2InstanceInformation, AWS:OpsItemTrendline, or AWS:ComplianceSummary.</p>"]}
    [@@ocaml.doc "<p>The OpsItem data type to return.</p>"]
    let make ~type_name  () = { type_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("type_name", (String.to_json v.type_name))])
    let of_json j =
      {
        type_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "type_name")))
      }
  end[@@ocaml.doc "<p>The OpsItem data type to return.</p>"]
module PatchComplianceData =
  struct
    type t =
      {
      title: String.t [@ocaml.doc "<p>The title of the patch.</p>"];
      k_b_id: String.t
        [@ocaml.doc "<p>The operating system-specific ID of the patch.</p>"];
      classification: String.t
        [@ocaml.doc
          "<p>The classification of the patch (for example, SecurityUpdates, Updates, CriticalUpdates).</p>"];
      severity: String.t
        [@ocaml.doc
          "<p>The severity of the patch (for example, Critical, Important, Moderate).</p>"];
      state: PatchComplianceDataState.t
        [@ocaml.doc
          "<p>The state of the patch on the instance, such as INSTALLED or FAILED.</p> <p>For descriptions of each patch state, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-compliance-about.html#sysman-compliance-monitor-patch\">About Patch Compliance</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      installed_time: DateTime.t
        [@ocaml.doc
          "<p>The date/time the patch was installed on the instance. Note that not all operating systems provide this level of information.</p>"]}
    [@@ocaml.doc
      "<p>Information about the state of a patch on a particular instance as it relates to the patch baseline used to patch the instance.</p>"]
    let make ~title  ~k_b_id  ~classification  ~severity  ~state 
      ~installed_time  () =
      { title; k_b_id; classification; severity; state; installed_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("installed_time", (DateTime.to_json v.installed_time));
           Some ("state", (PatchComplianceDataState.to_json v.state));
           Some ("severity", (String.to_json v.severity));
           Some ("classification", (String.to_json v.classification));
           Some ("k_b_id", (String.to_json v.k_b_id));
           Some ("title", (String.to_json v.title))])
    let of_json j =
      {
        title = (String.of_json (Util.of_option_exn (Json.lookup j "title")));
        k_b_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "k_b_id")));
        classification =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "classification")));
        severity =
          (String.of_json (Util.of_option_exn (Json.lookup j "severity")));
        state =
          (PatchComplianceDataState.of_json
             (Util.of_option_exn (Json.lookup j "state")));
        installed_time =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "installed_time")))
      }
  end[@@ocaml.doc
       "<p>Information about the state of a patch on a particular instance as it relates to the patch baseline used to patch the instance.</p>"]
module DocumentFilter =
  struct
    type t =
      {
      key: DocumentFilterKey.t [@ocaml.doc "<p>The name of the filter.</p>"];
      value: String.t [@ocaml.doc "<p>The value of the filter.</p>"]}
    [@@ocaml.doc "<p>Describes a filter.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (DocumentFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (DocumentFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end[@@ocaml.doc "<p>Describes a filter.</p>"]
module DocumentKeyValuesFilter =
  struct
    type t =
      {
      key: String.t option [@ocaml.doc "<p>The name of the filter key.</p>"];
      values: DocumentKeyValuesFilterValues.t
        [@ocaml.doc "<p>The value for the filter key.</p>"]}[@@ocaml.doc
                                                              "<p>One or more filters. Use a filter to return a more specific list of documents.</p> <p>For keys, you can specify one or more tags that have been applied to a document. </p> <p>Other valid values include Owner, Name, PlatformTypes, and DocumentType.</p> <p>Note that only one Owner can be specified in a request. For example: <code>Key=Owner,Values=Self</code>.</p> <p>If you use Name as a key, you can use a name prefix to return a list of documents. For example, in the AWS CLI, to return a list of all documents that begin with <code>Te</code>, run the following command:</p> <p> <code>aws ssm list-documents --filters Key=Name,Values=Te</code> </p> <p>If you specify more than two keys, only documents that are identified by all the tags are returned in the results. If you specify more than two values for a key, documents that are identified by any of the values are returned in the results.</p> <p>To specify a custom key and value pair, use the format <code>Key=tag:[tagName],Values=[valueName]</code>.</p> <p>For example, if you created a Key called region and are using the AWS CLI to call the <code>list-documents</code> command: </p> <p> <code>aws ssm list-documents --filters Key=tag:region,Values=east,west Key=Owner,Values=Self</code> </p>"]
    let make ?key  ?(values= [])  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (DocumentKeyValuesFilterValues.to_json v.values));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        values =
          (DocumentKeyValuesFilterValues.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>One or more filters. Use a filter to return a more specific list of documents.</p> <p>For keys, you can specify one or more tags that have been applied to a document. </p> <p>Other valid values include Owner, Name, PlatformTypes, and DocumentType.</p> <p>Note that only one Owner can be specified in a request. For example: <code>Key=Owner,Values=Self</code>.</p> <p>If you use Name as a key, you can use a name prefix to return a list of documents. For example, in the AWS CLI, to return a list of all documents that begin with <code>Te</code>, run the following command:</p> <p> <code>aws ssm list-documents --filters Key=Name,Values=Te</code> </p> <p>If you specify more than two keys, only documents that are identified by all the tags are returned in the results. If you specify more than two values for a key, documents that are identified by any of the values are returned in the results.</p> <p>To specify a custom key and value pair, use the format <code>Key=tag:[tagName],Values=[valueName]</code>.</p> <p>For example, if you created a Key called region and are using the AWS CLI to call the <code>list-documents</code> command: </p> <p> <code>aws ssm list-documents --filters Key=tag:region,Values=east,west Key=Owner,Values=Self</code> </p>"]
module AssociationVersionInfo =
  struct
    type t =
      {
      association_id: String.t option
        [@ocaml.doc
          "<p>The ID created by the system when the association was created.</p>"];
      association_version: String.t option
        [@ocaml.doc "<p>The association version.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date the association version was created.</p>"];
      name: String.t option
        [@ocaml.doc
          "<p>The name specified when the association was created.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The version of a Systems Manager document used when the association version was created.</p>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>Parameters specified when the association version was created.</p>"];
      targets: Targets.t
        [@ocaml.doc
          "<p>The targets specified for the association when the association version was created. </p>"];
      schedule_expression: String.t option
        [@ocaml.doc
          "<p>The cron or rate schedule specified for the association when the association version was created.</p>"];
      output_location: InstanceAssociationOutputLocation.t option
        [@ocaml.doc
          "<p>The location in Amazon S3 specified for the association when the association version was created.</p>"];
      association_name: String.t option
        [@ocaml.doc
          "<p>The name specified for the association version when the association version was created.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify either an absolute number of errors, for example 10, or a percentage of the target set, for example 10%. If you specify 3, for example, the system stops sending requests when the fourth error is received. If you specify 0, then the system stops sending requests after the first error is returned. If you run an association on 50 instances and set MaxError to 10%, then the system stops sending the request when the sixth error is received.</p> <p>Executions that are already running an association when MaxErrors is reached are allowed to complete, but some of these executions may fail as well. If you need to ensure that there won't be more than max-errors failed executions, set MaxConcurrency to 1 so that executions proceed one at a time.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%. The default value is 100%, which means all targets run the association at the same time.</p> <p>If a new instance starts and attempts to run an association while Systems Manager is running MaxConcurrency associations, the association is allowed to run. During the next association interval, the new instance will process its association within the limit specified for MaxConcurrency.</p>"];
      compliance_severity: AssociationComplianceSeverity.t option
        [@ocaml.doc
          "<p>The severity level that is assigned to the association.</p>"]}
    [@@ocaml.doc "<p>Information about the association version.</p>"]
    let make ?association_id  ?association_version  ?created_date  ?name 
      ?document_version  ?parameters  ?(targets= [])  ?schedule_expression 
      ?output_location  ?association_name  ?max_errors  ?max_concurrency 
      ?compliance_severity  () =
      {
        association_id;
        association_version;
        created_date;
        name;
        document_version;
        parameters;
        targets;
        schedule_expression;
        output_location;
        association_name;
        max_errors;
        max_concurrency;
        compliance_severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.compliance_severity
              (fun f ->
                 ("compliance_severity",
                   (AssociationComplianceSeverity.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.association_name
             (fun f -> ("association_name", (String.to_json f)));
           Util.option_map v.output_location
             (fun f ->
                ("output_location",
                  (InstanceAssociationOutputLocation.to_json f)));
           Util.option_map v.schedule_expression
             (fun f -> ("schedule_expression", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.association_version
             (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)))])
    let of_json j =
      {
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json);
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        schedule_expression =
          (Util.option_map (Json.lookup j "schedule_expression")
             String.of_json);
        output_location =
          (Util.option_map (Json.lookup j "output_location")
             InstanceAssociationOutputLocation.of_json);
        association_name =
          (Util.option_map (Json.lookup j "association_name") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        compliance_severity =
          (Util.option_map (Json.lookup j "compliance_severity")
             AssociationComplianceSeverity.of_json)
      }
  end[@@ocaml.doc "<p>Information about the association version.</p>"]
module ComplianceSummaryItem =
  struct
    type t =
      {
      compliance_type: String.t option
        [@ocaml.doc
          "<p>The type of compliance item. For example, the compliance type can be Association, Patch, or Custom:string.</p>"];
      compliant_summary: CompliantSummary.t option
        [@ocaml.doc
          "<p>A list of COMPLIANT items for the specified compliance type.</p>"];
      non_compliant_summary: NonCompliantSummary.t option
        [@ocaml.doc
          "<p>A list of NON_COMPLIANT items for the specified compliance type.</p>"]}
    [@@ocaml.doc
      "<p>A summary of compliance information by compliance type.</p>"]
    let make ?compliance_type  ?compliant_summary  ?non_compliant_summary  ()
      = { compliance_type; compliant_summary; non_compliant_summary }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.non_compliant_summary
              (fun f ->
                 ("non_compliant_summary", (NonCompliantSummary.to_json f)));
           Util.option_map v.compliant_summary
             (fun f -> ("compliant_summary", (CompliantSummary.to_json f)));
           Util.option_map v.compliance_type
             (fun f -> ("compliance_type", (String.to_json f)))])
    let of_json j =
      {
        compliance_type =
          (Util.option_map (Json.lookup j "compliance_type") String.of_json);
        compliant_summary =
          (Util.option_map (Json.lookup j "compliant_summary")
             CompliantSummary.of_json);
        non_compliant_summary =
          (Util.option_map (Json.lookup j "non_compliant_summary")
             NonCompliantSummary.of_json)
      }
  end[@@ocaml.doc
       "<p>A summary of compliance information by compliance type.</p>"]
module SessionManagerParameterValueList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module EffectivePatch =
  struct
    type t =
      {
      patch: Patch.t option
        [@ocaml.doc
          "<p>Provides metadata for a patch, including information such as the KB ID, severity, classification and a URL for where more information can be obtained about the patch.</p>"];
      patch_status: PatchStatus.t option
        [@ocaml.doc
          "<p>The status of the patch in a patch baseline. This includes information about whether the patch is currently approved, due to be approved by a rule, explicitly approved, or explicitly rejected and the date the patch was or will be approved.</p>"]}
    [@@ocaml.doc
      "<p>The EffectivePatch structure defines metadata about a patch along with the approval state of the patch in a particular patch baseline. The approval state includes information about whether the patch is currently approved, due to be approved by a rule, explicitly approved, or explicitly rejected and the date the patch was or will be approved.</p>"]
    let make ?patch  ?patch_status  () = { patch; patch_status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.patch_status
              (fun f -> ("patch_status", (PatchStatus.to_json f)));
           Util.option_map v.patch (fun f -> ("patch", (Patch.to_json f)))])
    let of_json j =
      {
        patch = (Util.option_map (Json.lookup j "patch") Patch.of_json);
        patch_status =
          (Util.option_map (Json.lookup j "patch_status") PatchStatus.of_json)
      }
  end[@@ocaml.doc
       "<p>The EffectivePatch structure defines metadata about a patch along with the approval state of the patch in a particular patch baseline. The approval state includes information about whether the patch is currently approved, due to be approved by a rule, explicitly approved, or explicitly rejected and the date the patch was or will be approved.</p>"]
module AssociationDescription =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance.</p>"];
      association_version: String.t option
        [@ocaml.doc "<p>The association version.</p>"];
      date: DateTime.t option
        [@ocaml.doc "<p>The date when the association was made.</p>"];
      last_update_association_date: DateTime.t option
        [@ocaml.doc "<p>The date when the association was last updated.</p>"];
      status: AssociationStatus.t option
        [@ocaml.doc "<p>The association status.</p>"];
      overview: AssociationOverview.t option
        [@ocaml.doc "<p>Information about the association.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version.</p>"];
      automation_target_parameter_name: String.t option
        [@ocaml.doc
          "<p>Specify the target for the association. This target is required for associations that use an Automation document and target resources by using rate controls.</p>"];
      parameters: Parameters.t option
        [@ocaml.doc
          "<p>A description of the parameters for a document. </p>"];
      association_id: String.t option
        [@ocaml.doc "<p>The association ID.</p>"];
      targets: Targets.t
        [@ocaml.doc "<p>The instances targeted by the request. </p>"];
      schedule_expression: String.t option
        [@ocaml.doc
          "<p>A cron expression that specifies a schedule when the association runs.</p>"];
      output_location: InstanceAssociationOutputLocation.t option
        [@ocaml.doc
          "<p>An Amazon S3 bucket where you want to store the output details of the request.</p>"];
      last_execution_date: DateTime.t option
        [@ocaml.doc "<p>The date on which the association was last run.</p>"];
      last_successful_execution_date: DateTime.t option
        [@ocaml.doc
          "<p>The last date on which the association was successfully run.</p>"];
      association_name: String.t option
        [@ocaml.doc "<p>The association name.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The number of errors that are allowed before the system stops sending requests to run the association on additional targets. You can specify either an absolute number of errors, for example 10, or a percentage of the target set, for example 10%. If you specify 3, for example, the system stops sending requests when the fourth error is received. If you specify 0, then the system stops sending requests after the first error is returned. If you run an association on 50 instances and set MaxError to 10%, then the system stops sending the request when the sixth error is received.</p> <p>Executions that are already running an association when MaxErrors is reached are allowed to complete, but some of these executions may fail as well. If you need to ensure that there won't be more than max-errors failed executions, set MaxConcurrency to 1 so that executions proceed one at a time.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets allowed to run the association at the same time. You can specify a number, for example 10, or a percentage of the target set, for example 10%. The default value is 100%, which means all targets run the association at the same time.</p> <p>If a new instance starts and attempts to run an association while Systems Manager is running MaxConcurrency associations, the association is allowed to run. During the next association interval, the new instance will process its association within the limit specified for MaxConcurrency.</p>"];
      compliance_severity: AssociationComplianceSeverity.t option
        [@ocaml.doc
          "<p>The severity level that is assigned to the association.</p>"]}
    [@@ocaml.doc "<p>Describes the parameters for a document.</p>"]
    let make ?name  ?instance_id  ?association_version  ?date 
      ?last_update_association_date  ?status  ?overview  ?document_version 
      ?automation_target_parameter_name  ?parameters  ?association_id 
      ?(targets= [])  ?schedule_expression  ?output_location 
      ?last_execution_date  ?last_successful_execution_date 
      ?association_name  ?max_errors  ?max_concurrency  ?compliance_severity 
      () =
      {
        name;
        instance_id;
        association_version;
        date;
        last_update_association_date;
        status;
        overview;
        document_version;
        automation_target_parameter_name;
        parameters;
        association_id;
        targets;
        schedule_expression;
        output_location;
        last_execution_date;
        last_successful_execution_date;
        association_name;
        max_errors;
        max_concurrency;
        compliance_severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.compliance_severity
              (fun f ->
                 ("compliance_severity",
                   (AssociationComplianceSeverity.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.association_name
             (fun f -> ("association_name", (String.to_json f)));
           Util.option_map v.last_successful_execution_date
             (fun f ->
                ("last_successful_execution_date", (DateTime.to_json f)));
           Util.option_map v.last_execution_date
             (fun f -> ("last_execution_date", (DateTime.to_json f)));
           Util.option_map v.output_location
             (fun f ->
                ("output_location",
                  (InstanceAssociationOutputLocation.to_json f)));
           Util.option_map v.schedule_expression
             (fun f -> ("schedule_expression", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (Parameters.to_json f)));
           Util.option_map v.automation_target_parameter_name
             (fun f ->
                ("automation_target_parameter_name", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.overview
             (fun f -> ("overview", (AssociationOverview.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (AssociationStatus.to_json f)));
           Util.option_map v.last_update_association_date
             (fun f -> ("last_update_association_date", (DateTime.to_json f)));
           Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)));
           Util.option_map v.association_version
             (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json);
        date = (Util.option_map (Json.lookup j "date") DateTime.of_json);
        last_update_association_date =
          (Util.option_map (Json.lookup j "last_update_association_date")
             DateTime.of_json);
        status =
          (Util.option_map (Json.lookup j "status") AssociationStatus.of_json);
        overview =
          (Util.option_map (Json.lookup j "overview")
             AssociationOverview.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        automation_target_parameter_name =
          (Util.option_map (Json.lookup j "automation_target_parameter_name")
             String.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") Parameters.of_json);
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        schedule_expression =
          (Util.option_map (Json.lookup j "schedule_expression")
             String.of_json);
        output_location =
          (Util.option_map (Json.lookup j "output_location")
             InstanceAssociationOutputLocation.of_json);
        last_execution_date =
          (Util.option_map (Json.lookup j "last_execution_date")
             DateTime.of_json);
        last_successful_execution_date =
          (Util.option_map (Json.lookup j "last_successful_execution_date")
             DateTime.of_json);
        association_name =
          (Util.option_map (Json.lookup j "association_name") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        compliance_severity =
          (Util.option_map (Json.lookup j "compliance_severity")
             AssociationComplianceSeverity.of_json)
      }
  end[@@ocaml.doc "<p>Describes the parameters for a document.</p>"]
module FailedCreateAssociation =
  struct
    type t =
      {
      entry: CreateAssociationBatchRequestEntry.t option
        [@ocaml.doc "<p>The association.</p>"];
      message: String.t option
        [@ocaml.doc "<p>A description of the failure.</p>"];
      fault: Fault.t option [@ocaml.doc "<p>The source of the failure.</p>"]}
    [@@ocaml.doc "<p>Describes a failed association.</p>"]
    let make ?entry  ?message  ?fault  () = { entry; message; fault }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.fault (fun f -> ("fault", (Fault.to_json f)));
           Util.option_map v.message
             (fun f -> ("message", (String.to_json f)));
           Util.option_map v.entry
             (fun f ->
                ("entry", (CreateAssociationBatchRequestEntry.to_json f)))])
    let of_json j =
      {
        entry =
          (Util.option_map (Json.lookup j "entry")
             CreateAssociationBatchRequestEntry.of_json);
        message = (Util.option_map (Json.lookup j "message") String.of_json);
        fault = (Util.option_map (Json.lookup j "fault") Fault.of_json)
      }
  end[@@ocaml.doc "<p>Describes a failed association.</p>"]
module ComplianceItemEntry =
  struct
    type t =
      {
      id: String.t option
        [@ocaml.doc
          "<p>The compliance item ID. For example, if the compliance item is a Windows patch, the ID could be the number of the KB article.</p>"];
      title: String.t option
        [@ocaml.doc
          "<p>The title of the compliance item. For example, if the compliance item is a Windows patch, the title could be the title of the KB article for the patch; for example: Security Update for Active Directory Federation Services. </p>"];
      severity: ComplianceSeverity.t
        [@ocaml.doc
          "<p>The severity of the compliance status. Severity can be one of the following: Critical, High, Medium, Low, Informational, Unspecified.</p>"];
      status: ComplianceStatus.t
        [@ocaml.doc
          "<p>The status of the compliance item. An item is either COMPLIANT or NON_COMPLIANT.</p>"];
      details: ComplianceItemDetails.t option
        [@ocaml.doc
          "<p>A \"Key\": \"Value\" tag combination for the compliance item.</p>"]}
    [@@ocaml.doc "<p>Information about a compliance item.</p>"]
    let make ?id  ?title  ~severity  ~status  ?details  () =
      { id; title; severity; status; details }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (ComplianceItemDetails.to_json f)));
           Some ("status", (ComplianceStatus.to_json v.status));
           Some ("severity", (ComplianceSeverity.to_json v.severity));
           Util.option_map v.title (fun f -> ("title", (String.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        title = (Util.option_map (Json.lookup j "title") String.of_json);
        severity =
          (ComplianceSeverity.of_json
             (Util.of_option_exn (Json.lookup j "severity")));
        status =
          (ComplianceStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")));
        details =
          (Util.option_map (Json.lookup j "details")
             ComplianceItemDetails.of_json)
      }
  end[@@ocaml.doc "<p>Information about a compliance item.</p>"]
module OpsItemNotifications =
  struct
    type t = OpsItemNotification.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsItemNotification.to_query v
    let to_headers v =
      Headers.to_headers_list OpsItemNotification.to_headers v
    let to_json v = `List (List.map OpsItemNotification.to_json v)
    let of_json j = Json.to_list OpsItemNotification.of_json j
  end
module RelatedOpsItems =
  struct
    type t = RelatedOpsItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list RelatedOpsItem.to_query v
    let to_headers v = Headers.to_headers_list RelatedOpsItem.to_headers v
    let to_json v = `List (List.map RelatedOpsItem.to_json v)
    let of_json j = Json.to_list RelatedOpsItem.of_json j
  end
module InventoryDeletionStatusItem =
  struct
    type t =
      {
      deletion_id: String.t option
        [@ocaml.doc
          "<p>The deletion ID returned by the <code>DeleteInventory</code> action.</p>"];
      type_name: String.t option
        [@ocaml.doc "<p>The name of the inventory data type.</p>"];
      deletion_start_time: DateTime.t option
        [@ocaml.doc
          "<p>The UTC timestamp when the delete operation started.</p>"];
      last_status: InventoryDeletionStatus.t option
        [@ocaml.doc
          "<p>The status of the operation. Possible values are InProgress and Complete.</p>"];
      last_status_message: String.t option
        [@ocaml.doc "<p>Information about the status.</p>"];
      deletion_summary: InventoryDeletionSummary.t option
        [@ocaml.doc
          "<p>Information about the delete operation. For more information about this summary, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-custom.html#sysman-inventory-delete\">Understanding the Delete Inventory Summary</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      last_status_update_time: DateTime.t option
        [@ocaml.doc
          "<p>The UTC timestamp of when the last status report.</p>"]}
    [@@ocaml.doc
      "<p>Status information returned by the <code>DeleteInventory</code> action.</p>"]
    let make ?deletion_id  ?type_name  ?deletion_start_time  ?last_status 
      ?last_status_message  ?deletion_summary  ?last_status_update_time  () =
      {
        deletion_id;
        type_name;
        deletion_start_time;
        last_status;
        last_status_message;
        deletion_summary;
        last_status_update_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_status_update_time
              (fun f -> ("last_status_update_time", (DateTime.to_json f)));
           Util.option_map v.deletion_summary
             (fun f ->
                ("deletion_summary", (InventoryDeletionSummary.to_json f)));
           Util.option_map v.last_status_message
             (fun f -> ("last_status_message", (String.to_json f)));
           Util.option_map v.last_status
             (fun f -> ("last_status", (InventoryDeletionStatus.to_json f)));
           Util.option_map v.deletion_start_time
             (fun f -> ("deletion_start_time", (DateTime.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.deletion_id
             (fun f -> ("deletion_id", (String.to_json f)))])
    let of_json j =
      {
        deletion_id =
          (Util.option_map (Json.lookup j "deletion_id") String.of_json);
        type_name =
          (Util.option_map (Json.lookup j "type_name") String.of_json);
        deletion_start_time =
          (Util.option_map (Json.lookup j "deletion_start_time")
             DateTime.of_json);
        last_status =
          (Util.option_map (Json.lookup j "last_status")
             InventoryDeletionStatus.of_json);
        last_status_message =
          (Util.option_map (Json.lookup j "last_status_message")
             String.of_json);
        deletion_summary =
          (Util.option_map (Json.lookup j "deletion_summary")
             InventoryDeletionSummary.of_json);
        last_status_update_time =
          (Util.option_map (Json.lookup j "last_status_update_time")
             DateTime.of_json)
      }
  end[@@ocaml.doc
       "<p>Status information returned by the <code>DeleteInventory</code> action.</p>"]
module SessionFilter =
  struct
    type t =
      {
      key: SessionFilterKey.t [@ocaml.doc "<p>The name of the filter.</p>"];
      value: String.t
        [@ocaml.doc
          "<p>The filter value. Valid values for each filter key are as follows:</p> <ul> <li> <p>InvokedAfter: Specify a timestamp to limit your results. For example, specify 2018-08-29T00:00:00Z to see sessions that started August 29, 2018, and later.</p> </li> <li> <p>InvokedBefore: Specify a timestamp to limit your results. For example, specify 2018-08-29T00:00:00Z to see sessions that started before August 29, 2018.</p> </li> <li> <p>Target: Specify an instance to which session connections have been made.</p> </li> <li> <p>Owner: Specify an AWS user account to see a list of sessions started by that user.</p> </li> <li> <p>Status: Specify a valid session status to see a list of all sessions with that status. Status values you can specify include:</p> <ul> <li> <p>Connected</p> </li> <li> <p>Connecting</p> </li> <li> <p>Disconnected</p> </li> <li> <p>Terminated</p> </li> <li> <p>Terminating</p> </li> <li> <p>Failed</p> </li> </ul> </li> </ul>"]}
    [@@ocaml.doc
      "<p>Describes a filter for Session Manager information.</p>"]
    let make ~key  ~value  () = { key; value }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("value", (String.to_json v.value));
           Some ("key", (SessionFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (SessionFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        value = (String.of_json (Util.of_option_exn (Json.lookup j "value")))
      }
  end[@@ocaml.doc
       "<p>Describes a filter for Session Manager information.</p>"]
module InstanceAssociationStatusInfo =
  struct
    type t =
      {
      association_id: String.t option
        [@ocaml.doc "<p>The association ID.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the association.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The association document versions.</p>"];
      association_version: String.t option
        [@ocaml.doc
          "<p>The version of the association applied to the instance.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The instance ID where the association was created.</p>"];
      execution_date: DateTime.t option
        [@ocaml.doc "<p>The date the instance association ran. </p>"];
      status: String.t option
        [@ocaml.doc
          "<p>Status information about the instance association.</p>"];
      detailed_status: String.t option
        [@ocaml.doc
          "<p>Detailed status information about the instance association.</p>"];
      execution_summary: String.t option
        [@ocaml.doc
          "<p>Summary information about association execution.</p>"];
      error_code: String.t option
        [@ocaml.doc
          "<p>An error code returned by the request to create the association.</p>"];
      output_url: InstanceAssociationOutputUrl.t option
        [@ocaml.doc
          "<p>A URL for an Amazon S3 bucket where you want to store the results of this request.</p>"];
      association_name: String.t option
        [@ocaml.doc
          "<p>The name of the association applied to the instance.</p>"]}
    [@@ocaml.doc "<p>Status information about the instance association.</p>"]
    let make ?association_id  ?name  ?document_version  ?association_version 
      ?instance_id  ?execution_date  ?status  ?detailed_status 
      ?execution_summary  ?error_code  ?output_url  ?association_name  () =
      {
        association_id;
        name;
        document_version;
        association_version;
        instance_id;
        execution_date;
        status;
        detailed_status;
        execution_summary;
        error_code;
        output_url;
        association_name
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_name
              (fun f -> ("association_name", (String.to_json f)));
           Util.option_map v.output_url
             (fun f ->
                ("output_url", (InstanceAssociationOutputUrl.to_json f)));
           Util.option_map v.error_code
             (fun f -> ("error_code", (String.to_json f)));
           Util.option_map v.execution_summary
             (fun f -> ("execution_summary", (String.to_json f)));
           Util.option_map v.detailed_status
             (fun f -> ("detailed_status", (String.to_json f)));
           Util.option_map v.status (fun f -> ("status", (String.to_json f)));
           Util.option_map v.execution_date
             (fun f -> ("execution_date", (DateTime.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.association_version
             (fun f -> ("association_version", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.association_id
             (fun f -> ("association_id", (String.to_json f)))])
    let of_json j =
      {
        association_id =
          (Util.option_map (Json.lookup j "association_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        association_version =
          (Util.option_map (Json.lookup j "association_version")
             String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        execution_date =
          (Util.option_map (Json.lookup j "execution_date") DateTime.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json);
        detailed_status =
          (Util.option_map (Json.lookup j "detailed_status") String.of_json);
        execution_summary =
          (Util.option_map (Json.lookup j "execution_summary") String.of_json);
        error_code =
          (Util.option_map (Json.lookup j "error_code") String.of_json);
        output_url =
          (Util.option_map (Json.lookup j "output_url")
             InstanceAssociationOutputUrl.of_json);
        association_name =
          (Util.option_map (Json.lookup j "association_name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Status information about the instance association.</p>"]
module InventoryItemSchema =
  struct
    type t =
      {
      type_name: String.t
        [@ocaml.doc
          "<p>The name of the inventory type. Default inventory item type names start with AWS. Custom inventory type names will start with Custom. Default inventory item types include the following: AWS:AWSComponent, AWS:Application, AWS:InstanceInformation, AWS:Network, and AWS:WindowsUpdate.</p>"];
      version: String.t option
        [@ocaml.doc "<p>The schema version for the inventory item.</p>"];
      attributes: InventoryItemAttributeList.t
        [@ocaml.doc
          "<p>The schema attributes for inventory. This contains data type and attribute name.</p>"];
      display_name: String.t option
        [@ocaml.doc
          "<p>The alias name of the inventory type. The alias name is used for display purposes.</p>"]}
    [@@ocaml.doc
      "<p>The inventory item schema definition. Users can use this to compose inventory query filters.</p>"]
    let make ~type_name  ?version  ~attributes  ?display_name  () =
      { type_name; version; attributes; display_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.display_name
              (fun f -> ("display_name", (String.to_json f)));
           Some
             ("attributes",
               (InventoryItemAttributeList.to_json v.attributes));
           Util.option_map v.version
             (fun f -> ("version", (String.to_json f)));
           Some ("type_name", (String.to_json v.type_name))])
    let of_json j =
      {
        type_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "type_name")));
        version = (Util.option_map (Json.lookup j "version") String.of_json);
        attributes =
          (InventoryItemAttributeList.of_json
             (Util.of_option_exn (Json.lookup j "attributes")));
        display_name =
          (Util.option_map (Json.lookup j "display_name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>The inventory item schema definition. Users can use this to compose inventory query filters.</p>"]
module MaintenanceWindowExecutionTaskIdentity =
  struct
    type t =
      {
      window_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window execution that ran the task.</p>"];
      task_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the specific task execution in the maintenance window execution.</p>"];
      status: MaintenanceWindowExecutionStatus.t option
        [@ocaml.doc "<p>The status of the task execution.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>The details explaining the status of the task execution. Only available for certain status values.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc "<p>The time the task execution started.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc "<p>The time the task execution finished.</p>"];
      task_arn: String.t option
        [@ocaml.doc "<p>The ARN of the task that ran.</p>"];
      task_type: MaintenanceWindowTaskType.t option
        [@ocaml.doc "<p>The type of task that ran.</p>"]}[@@ocaml.doc
                                                           "<p>Information about a task execution performed as part of a maintenance window execution.</p>"]
    let make ?window_execution_id  ?task_execution_id  ?status 
      ?status_details  ?start_time  ?end_time  ?task_arn  ?task_type  () =
      {
        window_execution_id;
        task_execution_id;
        status;
        status_details;
        start_time;
        end_time;
        task_arn;
        task_type
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.task_type
              (fun f -> ("task_type", (MaintenanceWindowTaskType.to_json f)));
           Util.option_map v.task_arn
             (fun f -> ("task_arn", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f ->
                ("status", (MaintenanceWindowExecutionStatus.to_json f)));
           Util.option_map v.task_execution_id
             (fun f -> ("task_execution_id", (String.to_json f)));
           Util.option_map v.window_execution_id
             (fun f -> ("window_execution_id", (String.to_json f)))])
    let of_json j =
      {
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json);
        task_execution_id =
          (Util.option_map (Json.lookup j "task_execution_id") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             MaintenanceWindowExecutionStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        task_arn =
          (Util.option_map (Json.lookup j "task_arn") String.of_json);
        task_type =
          (Util.option_map (Json.lookup j "task_type")
             MaintenanceWindowTaskType.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about a task execution performed as part of a maintenance window execution.</p>"]
module MaintenanceWindowIdentity =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the maintenance window.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the maintenance window.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the maintenance window.</p>"];
      enabled: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the maintenance window is enabled.</p>"];
      duration: Integer.t option
        [@ocaml.doc
          "<p>The duration of the maintenance window in hours.</p>"];
      cutoff: Integer.t option
        [@ocaml.doc
          "<p>The number of hours before the end of the maintenance window that Systems Manager stops scheduling new tasks for execution.</p>"];
      schedule: String.t option
        [@ocaml.doc
          "<p>The schedule of the maintenance window in the form of a cron or rate expression.</p>"];
      schedule_timezone: String.t option
        [@ocaml.doc
          "<p>The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format.</p>"];
      end_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become inactive.</p>"];
      start_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become active.</p>"];
      next_execution_time: String.t option
        [@ocaml.doc
          "<p>The next time the maintenance window will actually run, taking into account any specified times for the maintenance window to become active or inactive.</p>"]}
    [@@ocaml.doc "<p>Information about the maintenance window.</p>"]
    let make ?window_id  ?name  ?description  ?enabled  ?duration  ?cutoff 
      ?schedule  ?schedule_timezone  ?end_date  ?start_date 
      ?next_execution_time  () =
      {
        window_id;
        name;
        description;
        enabled;
        duration;
        cutoff;
        schedule;
        schedule_timezone;
        end_date;
        start_date;
        next_execution_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_execution_time
              (fun f -> ("next_execution_time", (String.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (String.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (String.to_json f)));
           Util.option_map v.schedule_timezone
             (fun f -> ("schedule_timezone", (String.to_json f)));
           Util.option_map v.schedule
             (fun f -> ("schedule", (String.to_json f)));
           Util.option_map v.cutoff
             (fun f -> ("cutoff", (Integer.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.enabled
             (fun f -> ("enabled", (Boolean.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        enabled = (Util.option_map (Json.lookup j "enabled") Boolean.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        cutoff = (Util.option_map (Json.lookup j "cutoff") Integer.of_json);
        schedule =
          (Util.option_map (Json.lookup j "schedule") String.of_json);
        schedule_timezone =
          (Util.option_map (Json.lookup j "schedule_timezone") String.of_json);
        end_date =
          (Util.option_map (Json.lookup j "end_date") String.of_json);
        start_date =
          (Util.option_map (Json.lookup j "start_date") String.of_json);
        next_execution_time =
          (Util.option_map (Json.lookup j "next_execution_time")
             String.of_json)
      }
  end[@@ocaml.doc "<p>Information about the maintenance window.</p>"]
module ParameterStringFilter =
  struct
    type t =
      {
      key: String.t [@ocaml.doc "<p>The name of the filter.</p>"];
      option: String.t option
        [@ocaml.doc
          "<p>For all filters used with <a>DescribeParameters</a>, valid options include <code>Equals</code> and <code>BeginsWith</code>. The <code>Name</code> filter additionally supports the <code>Contains</code> option. (Exception: For filters using the key <code>Path</code>, valid options include <code>Recursive</code> and <code>OneLevel</code>.)</p> <p>For filters used with <a>GetParametersByPath</a>, valid options include <code>Equals</code> and <code>BeginsWith</code>. (Exception: For filters using the key <code>Label</code>, the only valid option is <code>Equals</code>.)</p>"];
      values: ParameterStringFilterValueList.t
        [@ocaml.doc "<p>The value you want to search for.</p>"]}[@@ocaml.doc
                                                                  "<p>One or more filters. Use a filter to return a more specific list of results.</p> <important> <p>The <code>ParameterStringFilter</code> object is used by the <a>DescribeParameters</a> and <a>GetParametersByPath</a> API actions. However, not all of the pattern values listed for <code>Key</code> can be used with both actions.</p> <p>For <code>DescribeActions</code>, all of the listed patterns are valid, with the exception of <code>Label</code>.</p> <p>For <code>GetParametersByPath</code>, the following patterns listed for <code>Key</code> are not valid: <code>Name</code>, <code>Path</code>, and <code>Tier</code>.</p> <p>For examples of CLI commands demonstrating valid parameter filter constructions, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-search.html\">Searching for Systems Manager Parameters</a> in the <i>AWS Systems Manager User Guide</i>.</p> </important>"]
    let make ~key  ?option  ?(values= [])  () = { key; option; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("values", (ParameterStringFilterValueList.to_json v.values));
           Util.option_map v.option (fun f -> ("option", (String.to_json f)));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        option = (Util.option_map (Json.lookup j "option") String.of_json);
        values =
          (ParameterStringFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>One or more filters. Use a filter to return a more specific list of results.</p> <important> <p>The <code>ParameterStringFilter</code> object is used by the <a>DescribeParameters</a> and <a>GetParametersByPath</a> API actions. However, not all of the pattern values listed for <code>Key</code> can be used with both actions.</p> <p>For <code>DescribeActions</code>, all of the listed patterns are valid, with the exception of <code>Label</code>.</p> <p>For <code>GetParametersByPath</code>, the following patterns listed for <code>Key</code> are not valid: <code>Name</code>, <code>Path</code>, and <code>Tier</code>.</p> <p>For examples of CLI commands demonstrating valid parameter filter constructions, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-search.html\">Searching for Systems Manager Parameters</a> in the <i>AWS Systems Manager User Guide</i>.</p> </important>"]
module AttachmentsSource =
  struct
    type t =
      {
      key: AttachmentsSourceKey.t option
        [@ocaml.doc
          "<p>The key of a key-value pair that identifies the location of an attachment to a document.</p>"];
      values: AttachmentsSourceValues.t
        [@ocaml.doc
          "<p>The value of a key-value pair that identifies the location of an attachment to a document. The format for <b>Value</b> depends on the type of key you specify.</p> <ul> <li> <p>For the key <i>SourceUrl</i>, the value is an S3 bucket location. For example:</p> <p> <code>\"Values\": [ \"s3://my-bucket/my-folder\" ]</code> </p> </li> <li> <p>For the key <i>S3FileUrl</i>, the value is a file in an S3 bucket. For example:</p> <p> <code>\"Values\": [ \"s3://my-bucket/my-folder/my-file.py\" ]</code> </p> </li> <li> <p>For the key <i>AttachmentReference</i>, the value is constructed from the name of another SSM document in your account, a version number of that document, and a file attached to that document version that you want to reuse. For example:</p> <p> <code>\"Values\": [ \"MyOtherDocument/3/my-other-file.py\" ]</code> </p> <p>However, if the SSM document is shared with you from another account, the full SSM document ARN must be specified instead of the document name only. For example:</p> <p> <code>\"Values\": [ \"arn:aws:ssm:us-east-2:111122223333:document/OtherAccountDocument/3/their-file.py\" ]</code> </p> </li> </ul>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the document attachment file.</p>"]}
    [@@ocaml.doc
      "<p>Identifying information about a document attachment, including the file name and a key-value pair that identifies the location of an attachment to a document.</p>"]
    let make ?key  ?(values= [])  ?name  () = { key; values; name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Some ("values", (AttachmentsSourceValues.to_json v.values));
           Util.option_map v.key
             (fun f -> ("key", (AttachmentsSourceKey.to_json f)))])
    let of_json j =
      {
        key =
          (Util.option_map (Json.lookup j "key") AttachmentsSourceKey.of_json);
        values =
          (AttachmentsSourceValues.of_json
             (Util.of_option_exn (Json.lookup j "values")));
        name = (Util.option_map (Json.lookup j "name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Identifying information about a document attachment, including the file name and a key-value pair that identifies the location of an attachment to a document.</p>"]
module AccountSharingInfo =
  struct
    type t =
      {
      account_id: String.t option
        [@ocaml.doc
          "<p>The AWS account ID where the current document is shared.</p>"];
      shared_document_version: String.t option
        [@ocaml.doc
          "<p>The version of the current document shared with the account.</p>"]}
    [@@ocaml.doc
      "<p>Information includes the AWS account ID where the current document is shared and the version shared with that account.</p>"]
    let make ?account_id  ?shared_document_version  () =
      { account_id; shared_document_version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.shared_document_version
              (fun f -> ("shared_document_version", (String.to_json f)));
           Util.option_map v.account_id
             (fun f -> ("account_id", (String.to_json f)))])
    let of_json j =
      {
        account_id =
          (Util.option_map (Json.lookup j "account_id") String.of_json);
        shared_document_version =
          (Util.option_map (Json.lookup j "shared_document_version")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information includes the AWS account ID where the current document is shared and the version shared with that account.</p>"]
module MaintenanceWindowExecutionTaskInvocationIdentity =
  struct
    type t =
      {
      window_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window execution that ran the task.</p>"];
      task_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the specific task execution in the maintenance window execution.</p>"];
      invocation_id: String.t option
        [@ocaml.doc "<p>The ID of the task invocation.</p>"];
      execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the action performed in the service that actually handled the task invocation. If the task type is RUN_COMMAND, this value is the command ID.</p>"];
      task_type: MaintenanceWindowTaskType.t option
        [@ocaml.doc "<p>The task type.</p>"];
      parameters: String.t option
        [@ocaml.doc
          "<p>The parameters that were provided for the invocation when it was run.</p>"];
      status: MaintenanceWindowExecutionStatus.t option
        [@ocaml.doc "<p>The status of the task invocation.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>The details explaining the status of the task invocation. Only available for certain Status values. </p>"];
      start_time: DateTime.t option
        [@ocaml.doc "<p>The time the invocation started.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc "<p>The time the invocation finished.</p>"];
      owner_information: String.t option
        [@ocaml.doc
          "<p>User-provided value that was specified when the target was registered with the maintenance window. This was also included in any CloudWatch events raised during the task invocation.</p>"];
      window_target_id: String.t option
        [@ocaml.doc
          "<p>The ID of the target definition in this maintenance window the invocation was performed for.</p>"]}
    [@@ocaml.doc
      "<p>Describes the information about a task invocation for a particular target as part of a task execution performed as part of a maintenance window execution.</p>"]
    let make ?window_execution_id  ?task_execution_id  ?invocation_id 
      ?execution_id  ?task_type  ?parameters  ?status  ?status_details 
      ?start_time  ?end_time  ?owner_information  ?window_target_id  () =
      {
        window_execution_id;
        task_execution_id;
        invocation_id;
        execution_id;
        task_type;
        parameters;
        status;
        status_details;
        start_time;
        end_time;
        owner_information;
        window_target_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_target_id
              (fun f -> ("window_target_id", (String.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f ->
                ("status", (MaintenanceWindowExecutionStatus.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (String.to_json f)));
           Util.option_map v.task_type
             (fun f -> ("task_type", (MaintenanceWindowTaskType.to_json f)));
           Util.option_map v.execution_id
             (fun f -> ("execution_id", (String.to_json f)));
           Util.option_map v.invocation_id
             (fun f -> ("invocation_id", (String.to_json f)));
           Util.option_map v.task_execution_id
             (fun f -> ("task_execution_id", (String.to_json f)));
           Util.option_map v.window_execution_id
             (fun f -> ("window_execution_id", (String.to_json f)))])
    let of_json j =
      {
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json);
        task_execution_id =
          (Util.option_map (Json.lookup j "task_execution_id") String.of_json);
        invocation_id =
          (Util.option_map (Json.lookup j "invocation_id") String.of_json);
        execution_id =
          (Util.option_map (Json.lookup j "execution_id") String.of_json);
        task_type =
          (Util.option_map (Json.lookup j "task_type")
             MaintenanceWindowTaskType.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             MaintenanceWindowExecutionStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        window_target_id =
          (Util.option_map (Json.lookup j "window_target_id") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Describes the information about a task invocation for a particular target as part of a task execution performed as part of a maintenance window execution.</p>"]
module MaintenanceWindowIdentityForTarget =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the maintenance window.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the maintenance window.</p>"]}[@@ocaml.doc
                                                                    "<p>The maintenance window to which the specified target belongs.</p>"]
    let make ?window_id  ?name  () = { window_id; name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json)
      }
  end[@@ocaml.doc
       "<p>The maintenance window to which the specified target belongs.</p>"]
module DescribeActivationsFilter =
  struct
    type t =
      {
      filter_key: DescribeActivationsFilterKeys.t option
        [@ocaml.doc "<p>The name of the filter.</p>"];
      filter_values: StringList.t [@ocaml.doc "<p>The filter values.</p>"]}
    [@@ocaml.doc "<p>Filter for the DescribeActivation API.</p>"]
    let make ?filter_key  ?(filter_values= [])  () =
      { filter_key; filter_values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filter_values", (StringList.to_json v.filter_values));
           Util.option_map v.filter_key
             (fun f ->
                ("filter_key", (DescribeActivationsFilterKeys.to_json f)))])
    let of_json j =
      {
        filter_key =
          (Util.option_map (Json.lookup j "filter_key")
             DescribeActivationsFilterKeys.of_json);
        filter_values =
          (StringList.of_json
             (Util.of_option_exn (Json.lookup j "filter_values")))
      }
  end[@@ocaml.doc "<p>Filter for the DescribeActivation API.</p>"]
module CommandInvocation =
  struct
    type t =
      {
      command_id: String.t option
        [@ocaml.doc
          "<p>The command against which this invocation was requested.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The instance ID in which this invocation was requested.</p>"];
      instance_name: String.t option
        [@ocaml.doc
          "<p>The name of the invocation target. For Amazon EC2 instances this is the value for the aws:Name tag. For on-premises instances, this is the name of the instance.</p>"];
      comment: String.t option
        [@ocaml.doc
          "<p>User-specified information about the command, such as a brief description of what the command should do.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The document name that was requested for execution.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The SSM document version.</p>"];
      requested_date_time: DateTime.t option
        [@ocaml.doc
          "<p>The time and date the request was sent to this instance.</p>"];
      status: CommandInvocationStatus.t option
        [@ocaml.doc
          "<p>Whether or not the invocation succeeded, failed, or is pending.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>A detailed status of the command execution for each invocation (each instance targeted by the command). StatusDetails includes more information than Status because it includes states resulting from error and concurrency control parameters. StatusDetails can show different results than Status. For more information about these statuses, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html\">Understanding Command Statuses</a> in the <i>AWS Systems Manager User Guide</i>. StatusDetails can be one of the following values:</p> <ul> <li> <p>Pending: The command has not been sent to the instance.</p> </li> <li> <p>In Progress: The command has been sent to the instance but has not reached a terminal state.</p> </li> <li> <p>Success: The execution of the command or plugin was successfully completed. This is a terminal state.</p> </li> <li> <p>Delivery Timed Out: The command was not delivered to the instance before the delivery timeout expired. Delivery timeouts do not count against the parent command's MaxErrors limit, but they do contribute to whether the parent command status is Success or Incomplete. This is a terminal state.</p> </li> <li> <p>Execution Timed Out: Command execution started on the instance, but the execution was not complete before the execution timeout expired. Execution timeouts count against the MaxErrors limit of the parent command. This is a terminal state.</p> </li> <li> <p>Failed: The command was not successful on the instance. For a plugin, this indicates that the result code was not zero. For a command invocation, this indicates that the result code for one or more plugins was not zero. Invocation failures count against the MaxErrors limit of the parent command. This is a terminal state.</p> </li> <li> <p>Canceled: The command was terminated before it was completed. This is a terminal state.</p> </li> <li> <p>Undeliverable: The command can't be delivered to the instance. The instance might not exist or might not be responding. Undeliverable invocations don't count against the parent command's MaxErrors limit and don't contribute to whether the parent command status is Success or Incomplete. This is a terminal state.</p> </li> <li> <p>Terminated: The parent command exceeded its MaxErrors limit and subsequent command invocations were canceled by the system. This is a terminal state.</p> </li> </ul>"];
      trace_output: String.t option
        [@ocaml.doc "<p> Gets the trace output sent by the agent. </p>"];
      standard_output_url: String.t option
        [@ocaml.doc
          "<p>The URL to the plugin's StdOut file in Amazon S3, if the Amazon S3 bucket was defined for the parent command. For an invocation, StandardOutputUrl is populated if there is just one plugin defined for the command, and the Amazon S3 bucket was defined for the command.</p>"];
      standard_error_url: String.t option
        [@ocaml.doc
          "<p>The URL to the plugin's StdErr file in Amazon S3, if the Amazon S3 bucket was defined for the parent command. For an invocation, StandardErrorUrl is populated if there is just one plugin defined for the command, and the Amazon S3 bucket was defined for the command.</p>"];
      command_plugins: CommandPluginList.t ;
      service_role: String.t option
        [@ocaml.doc
          "<p>The IAM service role that Run Command uses to act on your behalf when sending notifications about command status changes on a per instance basis.</p>"];
      notification_config: NotificationConfig.t option
        [@ocaml.doc
          "<p>Configurations for sending notifications about command status changes on a per instance basis.</p>"];
      cloud_watch_output_config: CloudWatchOutputConfig.t option
        [@ocaml.doc
          "<p>CloudWatch Logs information where you want Systems Manager to send the command output.</p>"]}
    [@@ocaml.doc
      "<p>An invocation is copy of a command sent to a specific instance. A command can apply to one or more instances. A command invocation applies to one instance. For example, if a user runs SendCommand against three instances, then a command invocation is created for each requested instance ID. A command invocation returns status and detail information about a command you ran. </p>"]
    let make ?command_id  ?instance_id  ?instance_name  ?comment 
      ?document_name  ?document_version  ?requested_date_time  ?status 
      ?status_details  ?trace_output  ?standard_output_url 
      ?standard_error_url  ?(command_plugins= [])  ?service_role 
      ?notification_config  ?cloud_watch_output_config  () =
      {
        command_id;
        instance_id;
        instance_name;
        comment;
        document_name;
        document_version;
        requested_date_time;
        status;
        status_details;
        trace_output;
        standard_output_url;
        standard_error_url;
        command_plugins;
        service_role;
        notification_config;
        cloud_watch_output_config
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_output_config
              (fun f ->
                 ("cloud_watch_output_config",
                   (CloudWatchOutputConfig.to_json f)));
           Util.option_map v.notification_config
             (fun f ->
                ("notification_config", (NotificationConfig.to_json f)));
           Util.option_map v.service_role
             (fun f -> ("service_role", (String.to_json f)));
           Some
             ("command_plugins",
               (CommandPluginList.to_json v.command_plugins));
           Util.option_map v.standard_error_url
             (fun f -> ("standard_error_url", (String.to_json f)));
           Util.option_map v.standard_output_url
             (fun f -> ("standard_output_url", (String.to_json f)));
           Util.option_map v.trace_output
             (fun f -> ("trace_output", (String.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (CommandInvocationStatus.to_json f)));
           Util.option_map v.requested_date_time
             (fun f -> ("requested_date_time", (DateTime.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)));
           Util.option_map v.instance_name
             (fun f -> ("instance_name", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.command_id
             (fun f -> ("command_id", (String.to_json f)))])
    let of_json j =
      {
        command_id =
          (Util.option_map (Json.lookup j "command_id") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        instance_name =
          (Util.option_map (Json.lookup j "instance_name") String.of_json);
        comment = (Util.option_map (Json.lookup j "comment") String.of_json);
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        requested_date_time =
          (Util.option_map (Json.lookup j "requested_date_time")
             DateTime.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             CommandInvocationStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        trace_output =
          (Util.option_map (Json.lookup j "trace_output") String.of_json);
        standard_output_url =
          (Util.option_map (Json.lookup j "standard_output_url")
             String.of_json);
        standard_error_url =
          (Util.option_map (Json.lookup j "standard_error_url")
             String.of_json);
        command_plugins =
          (CommandPluginList.of_json
             (Util.of_option_exn (Json.lookup j "command_plugins")));
        service_role =
          (Util.option_map (Json.lookup j "service_role") String.of_json);
        notification_config =
          (Util.option_map (Json.lookup j "notification_config")
             NotificationConfig.of_json);
        cloud_watch_output_config =
          (Util.option_map (Json.lookup j "cloud_watch_output_config")
             CloudWatchOutputConfig.of_json)
      }
  end[@@ocaml.doc
       "<p>An invocation is copy of a command sent to a specific instance. A command can apply to one or more instances. A command invocation applies to one instance. For example, if a user runs SendCommand against three instances, then a command invocation is created for each requested instance ID. A command invocation returns status and detail information about a command you ran. </p>"]
module InventoryItem =
  struct
    type t =
      {
      type_name: String.t
        [@ocaml.doc
          "<p>The name of the inventory type. Default inventory item type names start with AWS. Custom inventory type names will start with Custom. Default inventory item types include the following: AWS:AWSComponent, AWS:Application, AWS:InstanceInformation, AWS:Network, and AWS:WindowsUpdate.</p>"];
      schema_version: String.t
        [@ocaml.doc "<p>The schema version for the inventory item.</p>"];
      capture_time: String.t
        [@ocaml.doc
          "<p>The time the inventory information was collected.</p>"];
      content_hash: String.t option
        [@ocaml.doc
          "<p>MD5 hash of the inventory item type contents. The content hash is used to determine whether to update inventory information. The PutInventory API does not update the inventory item type contents if the MD5 hash has not changed since last update. </p>"];
      content: InventoryItemEntryList.t
        [@ocaml.doc "<p>The inventory data of the inventory type.</p>"];
      context: InventoryItemContentContext.t option
        [@ocaml.doc
          "<p>A map of associated properties for a specified inventory type. For example, with this attribute, you can specify the <code>ExecutionId</code>, <code>ExecutionType</code>, <code>ComplianceType</code> properties of the <code>AWS:ComplianceItem</code> type.</p>"]}
    [@@ocaml.doc
      "<p>Information collected from managed instances based on your inventory policy document</p>"]
    let make ~type_name  ~schema_version  ~capture_time  ?content_hash 
      ?(content= [])  ?context  () =
      {
        type_name;
        schema_version;
        capture_time;
        content_hash;
        content;
        context
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.context
              (fun f -> ("context", (InventoryItemContentContext.to_json f)));
           Some ("content", (InventoryItemEntryList.to_json v.content));
           Util.option_map v.content_hash
             (fun f -> ("content_hash", (String.to_json f)));
           Some ("capture_time", (String.to_json v.capture_time));
           Some ("schema_version", (String.to_json v.schema_version));
           Some ("type_name", (String.to_json v.type_name))])
    let of_json j =
      {
        type_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "type_name")));
        schema_version =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "schema_version")));
        capture_time =
          (String.of_json (Util.of_option_exn (Json.lookup j "capture_time")));
        content_hash =
          (Util.option_map (Json.lookup j "content_hash") String.of_json);
        content =
          (InventoryItemEntryList.of_json
             (Util.of_option_exn (Json.lookup j "content")));
        context =
          (Util.option_map (Json.lookup j "context")
             InventoryItemContentContext.of_json)
      }
  end[@@ocaml.doc
       "<p>Information collected from managed instances based on your inventory policy document</p>"]
module OpsItemFilter =
  struct
    type t =
      {
      key: OpsItemFilterKey.t [@ocaml.doc "<p>The name of the filter.</p>"];
      values: OpsItemFilterValues.t [@ocaml.doc "<p>The filter value.</p>"];
      operator: OpsItemFilterOperator.t
        [@ocaml.doc "<p>The operator used by the filter call.</p>"]}[@@ocaml.doc
                                                                    "<p>Describes an OpsItem filter.</p>"]
    let make ~key  ~values  ~operator  () = { key; values; operator }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("operator", (OpsItemFilterOperator.to_json v.operator));
           Some ("values", (OpsItemFilterValues.to_json v.values));
           Some ("key", (OpsItemFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (OpsItemFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        values =
          (OpsItemFilterValues.of_json
             (Util.of_option_exn (Json.lookup j "values")));
        operator =
          (OpsItemFilterOperator.of_json
             (Util.of_option_exn (Json.lookup j "operator")))
      }
  end[@@ocaml.doc "<p>Describes an OpsItem filter.</p>"]
module AttachmentContent =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of an attachment.</p>"];
      size: Long.t option
        [@ocaml.doc "<p>The size of an attachment in bytes.</p>"];
      hash: String.t option
        [@ocaml.doc
          "<p>The cryptographic hash value of the document content.</p>"];
      hash_type: AttachmentHashType.t option
        [@ocaml.doc
          "<p>The hash algorithm used to calculate the hash value.</p>"];
      url: String.t option
        [@ocaml.doc "<p>The URL location of the attachment content.</p>"]}
    [@@ocaml.doc
      "<p>A structure that includes attributes that describe a document attachment.</p>"]
    let make ?name  ?size  ?hash  ?hash_type  ?url  () =
      { name; size; hash; hash_type; url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.url (fun f -> ("url", (String.to_json f)));
           Util.option_map v.hash_type
             (fun f -> ("hash_type", (AttachmentHashType.to_json f)));
           Util.option_map v.hash (fun f -> ("hash", (String.to_json f)));
           Util.option_map v.size (fun f -> ("size", (Long.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        size = (Util.option_map (Json.lookup j "size") Long.of_json);
        hash = (Util.option_map (Json.lookup j "hash") String.of_json);
        hash_type =
          (Util.option_map (Json.lookup j "hash_type")
             AttachmentHashType.of_json);
        url = (Util.option_map (Json.lookup j "url") String.of_json)
      }
  end[@@ocaml.doc
       "<p>A structure that includes attributes that describe a document attachment.</p>"]
module ResourceDataSyncItem =
  struct
    type t =
      {
      sync_name: String.t option
        [@ocaml.doc "<p>The name of the Resource Data Sync.</p>"];
      sync_type: String.t option
        [@ocaml.doc
          "<p>The type of resource data sync. If <code>SyncType</code> is <code>SyncToDestination</code>, then the resource data sync synchronizes data to an Amazon S3 bucket. If the <code>SyncType</code> is <code>SyncFromSource</code> then the resource data sync synchronizes data from AWS Organizations or from multiple AWS Regions.</p>"];
      sync_source: ResourceDataSyncSourceWithState.t option
        [@ocaml.doc
          "<p>Information about the source where the data was synchronized. </p>"];
      s3_destination: ResourceDataSyncS3Destination.t option
        [@ocaml.doc
          "<p>Configuration information for the target Amazon S3 bucket.</p>"];
      last_sync_time: DateTime.t option
        [@ocaml.doc
          "<p>The last time the configuration attempted to sync (UTC).</p>"];
      last_successful_sync_time: DateTime.t option
        [@ocaml.doc
          "<p>The last time the sync operations returned a status of <code>SUCCESSFUL</code> (UTC).</p>"];
      sync_last_modified_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time the resource data sync was changed. </p>"];
      last_status: LastResourceDataSyncStatus.t option
        [@ocaml.doc "<p>The status reported by the last sync.</p>"];
      sync_created_time: DateTime.t option
        [@ocaml.doc
          "<p>The date and time the configuration was created (UTC).</p>"];
      last_sync_status_message: String.t option
        [@ocaml.doc
          "<p>The status message details reported by the last sync.</p>"]}
    [@@ocaml.doc
      "<p>Information about a Resource Data Sync configuration, including its current status and last successful sync.</p>"]
    let make ?sync_name  ?sync_type  ?sync_source  ?s3_destination 
      ?last_sync_time  ?last_successful_sync_time  ?sync_last_modified_time 
      ?last_status  ?sync_created_time  ?last_sync_status_message  () =
      {
        sync_name;
        sync_type;
        sync_source;
        s3_destination;
        last_sync_time;
        last_successful_sync_time;
        sync_last_modified_time;
        last_status;
        sync_created_time;
        last_sync_status_message
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_sync_status_message
              (fun f -> ("last_sync_status_message", (String.to_json f)));
           Util.option_map v.sync_created_time
             (fun f -> ("sync_created_time", (DateTime.to_json f)));
           Util.option_map v.last_status
             (fun f ->
                ("last_status", (LastResourceDataSyncStatus.to_json f)));
           Util.option_map v.sync_last_modified_time
             (fun f -> ("sync_last_modified_time", (DateTime.to_json f)));
           Util.option_map v.last_successful_sync_time
             (fun f -> ("last_successful_sync_time", (DateTime.to_json f)));
           Util.option_map v.last_sync_time
             (fun f -> ("last_sync_time", (DateTime.to_json f)));
           Util.option_map v.s3_destination
             (fun f ->
                ("s3_destination", (ResourceDataSyncS3Destination.to_json f)));
           Util.option_map v.sync_source
             (fun f ->
                ("sync_source", (ResourceDataSyncSourceWithState.to_json f)));
           Util.option_map v.sync_type
             (fun f -> ("sync_type", (String.to_json f)));
           Util.option_map v.sync_name
             (fun f -> ("sync_name", (String.to_json f)))])
    let of_json j =
      {
        sync_name =
          (Util.option_map (Json.lookup j "sync_name") String.of_json);
        sync_type =
          (Util.option_map (Json.lookup j "sync_type") String.of_json);
        sync_source =
          (Util.option_map (Json.lookup j "sync_source")
             ResourceDataSyncSourceWithState.of_json);
        s3_destination =
          (Util.option_map (Json.lookup j "s3_destination")
             ResourceDataSyncS3Destination.of_json);
        last_sync_time =
          (Util.option_map (Json.lookup j "last_sync_time") DateTime.of_json);
        last_successful_sync_time =
          (Util.option_map (Json.lookup j "last_successful_sync_time")
             DateTime.of_json);
        sync_last_modified_time =
          (Util.option_map (Json.lookup j "sync_last_modified_time")
             DateTime.of_json);
        last_status =
          (Util.option_map (Json.lookup j "last_status")
             LastResourceDataSyncStatus.of_json);
        sync_created_time =
          (Util.option_map (Json.lookup j "sync_created_time")
             DateTime.of_json);
        last_sync_status_message =
          (Util.option_map (Json.lookup j "last_sync_status_message")
             String.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about a Resource Data Sync configuration, including its current status and last successful sync.</p>"]
module MaintenanceWindowExecution =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the maintenance window.</p>"];
      window_execution_id: String.t option
        [@ocaml.doc "<p>The ID of the maintenance window execution.</p>"];
      status: MaintenanceWindowExecutionStatus.t option
        [@ocaml.doc "<p>The status of the execution.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>The details explaining the Status. Only available for certain status values.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc "<p>The time the execution started.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc "<p>The time the execution finished.</p>"]}[@@ocaml.doc
                                                                 "<p>Describes the information about an execution of a maintenance window. </p>"]
    let make ?window_id  ?window_execution_id  ?status  ?status_details 
      ?start_time  ?end_time  () =
      {
        window_id;
        window_execution_id;
        status;
        status_details;
        start_time;
        end_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_time
              (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f ->
                ("status", (MaintenanceWindowExecutionStatus.to_json f)));
           Util.option_map v.window_execution_id
             (fun f -> ("window_execution_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             MaintenanceWindowExecutionStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json)
      }
  end[@@ocaml.doc
       "<p>Describes the information about an execution of a maintenance window. </p>"]
module ParametersFilter =
  struct
    type t =
      {
      key: ParametersFilterKey.t
        [@ocaml.doc "<p>The name of the filter.</p>"];
      values: ParametersFilterValueList.t
        [@ocaml.doc "<p>The filter values.</p>"]}[@@ocaml.doc
                                                   "<p>This data type is deprecated. Instead, use <a>ParameterStringFilter</a>.</p>"]
    let make ~key  ~values  () = { key; values }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("values", (ParametersFilterValueList.to_json v.values));
           Some ("key", (ParametersFilterKey.to_json v.key))])
    let of_json j =
      {
        key =
          (ParametersFilterKey.of_json
             (Util.of_option_exn (Json.lookup j "key")));
        values =
          (ParametersFilterValueList.of_json
             (Util.of_option_exn (Json.lookup j "values")))
      }
  end[@@ocaml.doc
       "<p>This data type is deprecated. Instead, use <a>ParameterStringFilter</a>.</p>"]
module PatchGroupPatchBaselineMapping =
  struct
    type t =
      {
      patch_group: String.t option
        [@ocaml.doc
          "<p>The name of the patch group registered with the patch baseline.</p>"];
      baseline_identity: PatchBaselineIdentity.t option
        [@ocaml.doc
          "<p>The patch baseline the patch group is registered with.</p>"]}
    [@@ocaml.doc
      "<p>The mapping between a patch group and the patch baseline the patch group is registered with.</p>"]
    let make ?patch_group  ?baseline_identity  () =
      { patch_group; baseline_identity }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.baseline_identity
              (fun f ->
                 ("baseline_identity", (PatchBaselineIdentity.to_json f)));
           Util.option_map v.patch_group
             (fun f -> ("patch_group", (String.to_json f)))])
    let of_json j =
      {
        patch_group =
          (Util.option_map (Json.lookup j "patch_group") String.of_json);
        baseline_identity =
          (Util.option_map (Json.lookup j "baseline_identity")
             PatchBaselineIdentity.of_json)
      }
  end[@@ocaml.doc
       "<p>The mapping between a patch group and the patch baseline the patch group is registered with.</p>"]
module ComplianceStringFilterList =
  struct
    type t = ComplianceStringFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ComplianceStringFilter.to_query v
    let to_headers v =
      Headers.to_headers_list ComplianceStringFilter.to_headers v
    let to_json v = `List (List.map ComplianceStringFilter.to_json v)
    let of_json j = Json.to_list ComplianceStringFilter.of_json j
  end
module ParameterMetadataList =
  struct
    type t = ParameterMetadata.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParameterMetadata.to_query v
    let to_headers v = Headers.to_headers_list ParameterMetadata.to_headers v
    let to_json v = `List (List.map ParameterMetadata.to_json v)
    let of_json j = Json.to_list ParameterMetadata.of_json j
  end
module PatchBaselineIdentityList =
  struct
    type t = PatchBaselineIdentity.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchBaselineIdentity.to_query v
    let to_headers v =
      Headers.to_headers_list PatchBaselineIdentity.to_headers v
    let to_json v = `List (List.map PatchBaselineIdentity.to_json v)
    let of_json j = Json.to_list PatchBaselineIdentity.of_json j
  end
module MaintenanceWindowTaskInvocationParameters =
  struct
    type t =
      {
      run_command: MaintenanceWindowRunCommandParameters.t option
        [@ocaml.doc "<p>The parameters for a RUN_COMMAND task type.</p>"];
      automation: MaintenanceWindowAutomationParameters.t option
        [@ocaml.doc "<p>The parameters for an AUTOMATION task type.</p>"];
      step_functions: MaintenanceWindowStepFunctionsParameters.t option
        [@ocaml.doc "<p>The parameters for a STEP_FUNCTIONS task type.</p>"];
      lambda: MaintenanceWindowLambdaParameters.t option
        [@ocaml.doc "<p>The parameters for a LAMBDA task type.</p>"]}
    [@@ocaml.doc "<p>The parameters for task execution.</p>"]
    let make ?run_command  ?automation  ?step_functions  ?lambda  () =
      { run_command; automation; step_functions; lambda }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.lambda
              (fun f ->
                 ("lambda", (MaintenanceWindowLambdaParameters.to_json f)));
           Util.option_map v.step_functions
             (fun f ->
                ("step_functions",
                  (MaintenanceWindowStepFunctionsParameters.to_json f)));
           Util.option_map v.automation
             (fun f ->
                ("automation",
                  (MaintenanceWindowAutomationParameters.to_json f)));
           Util.option_map v.run_command
             (fun f ->
                ("run_command",
                  (MaintenanceWindowRunCommandParameters.to_json f)))])
    let of_json j =
      {
        run_command =
          (Util.option_map (Json.lookup j "run_command")
             MaintenanceWindowRunCommandParameters.of_json);
        automation =
          (Util.option_map (Json.lookup j "automation")
             MaintenanceWindowAutomationParameters.of_json);
        step_functions =
          (Util.option_map (Json.lookup j "step_functions")
             MaintenanceWindowStepFunctionsParameters.of_json);
        lambda =
          (Util.option_map (Json.lookup j "lambda")
             MaintenanceWindowLambdaParameters.of_json)
      }
  end[@@ocaml.doc "<p>The parameters for task execution.</p>"]
module ScheduledWindowExecutionList =
  struct
    type t = ScheduledWindowExecution.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ScheduledWindowExecution.to_query v
    let to_headers v =
      Headers.to_headers_list ScheduledWindowExecution.to_headers v
    let to_json v = `List (List.map ScheduledWindowExecution.to_json v)
    let of_json j = Json.to_list ScheduledWindowExecution.of_json j
  end
module AssociationFilterList =
  struct
    type t = AssociationFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AssociationFilter.to_query v
    let to_headers v = Headers.to_headers_list AssociationFilter.to_headers v
    let to_json v = `List (List.map AssociationFilter.to_json v)
    let of_json j = Json.to_list AssociationFilter.of_json j
  end
module MaintenanceWindowExecutionTaskIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ParameterHistoryList =
  struct
    type t = ParameterHistory.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParameterHistory.to_query v
    let to_headers v = Headers.to_headers_list ParameterHistory.to_headers v
    let to_json v = `List (List.map ParameterHistory.to_json v)
    let of_json j = Json.to_list ParameterHistory.of_json j
  end
module InstanceInformationList =
  struct
    type t = InstanceInformation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstanceInformation.to_query v
    let to_headers v =
      Headers.to_headers_list InstanceInformation.to_headers v
    let to_json v = `List (List.map InstanceInformation.to_json v)
    let of_json j = Json.to_list InstanceInformation.of_json j
  end
module DocumentVersionList =
  struct
    type t = DocumentVersionInfo.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DocumentVersionInfo.to_query v
    let to_headers v =
      Headers.to_headers_list DocumentVersionInfo.to_headers v
    let to_json v = `List (List.map DocumentVersionInfo.to_json v)
    let of_json j = Json.to_list DocumentVersionInfo.of_json j
  end
module AssociationExecutionTargetsFilterList =
  struct
    type t = AssociationExecutionTargetsFilter.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list AssociationExecutionTargetsFilter.to_query v
    let to_headers v =
      Headers.to_headers_list AssociationExecutionTargetsFilter.to_headers v
    let to_json v =
      `List (List.map AssociationExecutionTargetsFilter.to_json v)
    let of_json j = Json.to_list AssociationExecutionTargetsFilter.of_json j
  end
module StepExecutionFilterList =
  struct
    type t = StepExecutionFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list StepExecutionFilter.to_query v
    let to_headers v =
      Headers.to_headers_list StepExecutionFilter.to_headers v
    let to_json v = `List (List.map StepExecutionFilter.to_json v)
    let of_json j = Json.to_list StepExecutionFilter.of_json j
  end
module ServiceSetting =
  struct
    type t =
      {
      setting_id: String.t option
        [@ocaml.doc "<p>The ID of the service setting.</p>"];
      setting_value: String.t option
        [@ocaml.doc "<p>The value of the service setting.</p>"];
      last_modified_date: DateTime.t option
        [@ocaml.doc "<p>The last time the service setting was modified.</p>"];
      last_modified_user: String.t option
        [@ocaml.doc
          "<p>The ARN of the last modified user. This field is populated only if the setting value was overwritten.</p>"];
      a_r_n: String.t option
        [@ocaml.doc "<p>The ARN of the service setting.</p>"];
      status: String.t option
        [@ocaml.doc
          "<p>The status of the service setting. The value can be Default, Customized or PendingUpdate.</p> <ul> <li> <p>Default: The current setting uses a default value provisioned by the AWS service team.</p> </li> <li> <p>Customized: The current setting use a custom value specified by the customer.</p> </li> <li> <p>PendingUpdate: The current setting uses a default or custom value, but a setting change request is pending approval.</p> </li> </ul>"]}
    [@@ocaml.doc
      "<p>The service setting data structure.</p> <p> <code>ServiceSetting</code> is an account-level setting for an AWS service. This setting defines how a user interacts with or uses a service or a feature of a service. For example, if an AWS service charges money to the account based on feature or service usage, then the AWS service team might create a default setting of \"false\". This means the user can't use this feature unless they change the setting to \"true\" and intentionally opt in for a paid feature.</p> <p>Services map a <code>SettingId</code> object to a setting value. AWS services teams define the default value for a <code>SettingId</code>. You can't create a new <code>SettingId</code>, but you can overwrite the default value if you have the <code>ssm:UpdateServiceSetting</code> permission for the setting. Use the <a>UpdateServiceSetting</a> API action to change the default setting. Or, use the <a>ResetServiceSetting</a> to change the value back to the original value defined by the AWS service team.</p>"]
    let make ?setting_id  ?setting_value  ?last_modified_date 
      ?last_modified_user  ?a_r_n  ?status  () =
      {
        setting_id;
        setting_value;
        last_modified_date;
        last_modified_user;
        a_r_n;
        status
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (String.to_json f)));
           Util.option_map v.a_r_n (fun f -> ("a_r_n", (String.to_json f)));
           Util.option_map v.last_modified_user
             (fun f -> ("last_modified_user", (String.to_json f)));
           Util.option_map v.last_modified_date
             (fun f -> ("last_modified_date", (DateTime.to_json f)));
           Util.option_map v.setting_value
             (fun f -> ("setting_value", (String.to_json f)));
           Util.option_map v.setting_id
             (fun f -> ("setting_id", (String.to_json f)))])
    let of_json j =
      {
        setting_id =
          (Util.option_map (Json.lookup j "setting_id") String.of_json);
        setting_value =
          (Util.option_map (Json.lookup j "setting_value") String.of_json);
        last_modified_date =
          (Util.option_map (Json.lookup j "last_modified_date")
             DateTime.of_json);
        last_modified_user =
          (Util.option_map (Json.lookup j "last_modified_user")
             String.of_json);
        a_r_n = (Util.option_map (Json.lookup j "a_r_n") String.of_json);
        status = (Util.option_map (Json.lookup j "status") String.of_json)
      }
  end[@@ocaml.doc
       "<p>The service setting data structure.</p> <p> <code>ServiceSetting</code> is an account-level setting for an AWS service. This setting defines how a user interacts with or uses a service or a feature of a service. For example, if an AWS service charges money to the account based on feature or service usage, then the AWS service team might create a default setting of \"false\". This means the user can't use this feature unless they change the setting to \"true\" and intentionally opt in for a paid feature.</p> <p>Services map a <code>SettingId</code> object to a setting value. AWS services teams define the default value for a <code>SettingId</code>. You can't create a new <code>SettingId</code>, but you can overwrite the default value if you have the <code>ssm:UpdateServiceSetting</code> permission for the setting. Use the <a>UpdateServiceSetting</a> API action to change the default setting. Or, use the <a>ResetServiceSetting</a> to change the value back to the original value defined by the AWS service team.</p>"]
module AutomationExecutionMetadataList =
  struct
    type t = AutomationExecutionMetadata.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list AutomationExecutionMetadata.to_query v
    let to_headers v =
      Headers.to_headers_list AutomationExecutionMetadata.to_headers v
    let to_json v = `List (List.map AutomationExecutionMetadata.to_json v)
    let of_json j = Json.to_list AutomationExecutionMetadata.of_json j
  end
module DocumentIdentifierList =
  struct
    type t = DocumentIdentifier.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DocumentIdentifier.to_query v
    let to_headers v =
      Headers.to_headers_list DocumentIdentifier.to_headers v
    let to_json v = `List (List.map DocumentIdentifier.to_json v)
    let of_json j = Json.to_list DocumentIdentifier.of_json j
  end
module InventorySchemaDeleteOption =
  struct
    type t =
      | DisableSchema 
      | DeleteSchema 
    let str_to_t =
      [("DeleteSchema", DeleteSchema); ("DisableSchema", DisableSchema)]
    let t_to_str =
      [(DeleteSchema, "DeleteSchema"); (DisableSchema, "DisableSchema")]
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
module SignalType =
  struct
    type t =
      | Approve 
      | Reject 
      | StartStep 
      | StopStep 
      | Resume 
    let str_to_t =
      [("Resume", Resume);
      ("StopStep", StopStep);
      ("StartStep", StartStep);
      ("Reject", Reject);
      ("Approve", Approve)]
    let t_to_str =
      [(Resume, "Resume");
      (StopStep, "StopStep");
      (StartStep, "StartStep");
      (Reject, "Reject");
      (Approve, "Approve")]
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
module InstanceInformationFilterList =
  struct
    type t = InstanceInformationFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstanceInformationFilter.to_query v
    let to_headers v =
      Headers.to_headers_list InstanceInformationFilter.to_headers v
    let to_json v = `List (List.map InstanceInformationFilter.to_json v)
    let of_json j = Json.to_list InstanceInformationFilter.of_json j
  end
module InstanceInformationStringFilterList =
  struct
    type t = InstanceInformationStringFilter.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list InstanceInformationStringFilter.to_query v
    let to_headers v =
      Headers.to_headers_list InstanceInformationStringFilter.to_headers v
    let to_json v =
      `List (List.map InstanceInformationStringFilter.to_json v)
    let of_json j = Json.to_list InstanceInformationStringFilter.of_json j
  end
module DocumentDescription =
  struct
    type t =
      {
      sha1: String.t option
        [@ocaml.doc
          "<p>The SHA1 hash of the document, which you can use for verification.</p>"];
      hash: String.t option
        [@ocaml.doc
          "<p>The Sha256 or Sha1 hash created by the system when the document was created. </p> <note> <p>Sha1 hashes have been deprecated.</p> </note>"];
      hash_type: DocumentHashType.t option
        [@ocaml.doc
          "<p>The hash type of the document. Valid values include <code>Sha256</code> or <code>Sha1</code>.</p> <note> <p>Sha1 hashes have been deprecated.</p> </note>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>The version of the artifact associated with the document.</p>"];
      owner: String.t option
        [@ocaml.doc "<p>The AWS user account that created the document.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date when the document was created.</p>"];
      status: DocumentStatus.t option
        [@ocaml.doc "<p>The status of the Systems Manager document.</p>"];
      status_information: String.t option
        [@ocaml.doc
          "<p>A message returned by AWS Systems Manager that explains the <code>Status</code> value. For example, a <code>Failed</code> status might be explained by the <code>StatusInformation</code> message, \"The specified S3 bucket does not exist. Verify that the URL of the S3 bucket is correct.\"</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the document. </p>"];
      parameters: DocumentParameterList.t
        [@ocaml.doc "<p>A description of the parameters for a document.</p>"];
      platform_types: PlatformTypeList.t
        [@ocaml.doc
          "<p>The list of OS platforms compatible with this Systems Manager document. </p>"];
      document_type: DocumentType.t option
        [@ocaml.doc "<p>The type of document.</p>"];
      schema_version: String.t option
        [@ocaml.doc "<p>The schema version.</p>"];
      latest_version: String.t option
        [@ocaml.doc "<p>The latest version of the document.</p>"];
      default_version: String.t option
        [@ocaml.doc "<p>The default version.</p>"];
      document_format: DocumentFormat.t option
        [@ocaml.doc "<p>The document format, either JSON or YAML.</p>"];
      target_type: String.t option
        [@ocaml.doc
          "<p>The target type which defines the kinds of resources the document can run on. For example, /AWS::EC2::Instance. For a list of valid resource types, see <a href=\"http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html\">AWS Resource Types Reference</a> in the <i>AWS CloudFormation User Guide</i>. </p>"];
      tags: TagList.t
        [@ocaml.doc
          "<p>The tags, or metadata, that have been applied to the document.</p>"];
      attachments_information: AttachmentInformationList.t
        [@ocaml.doc
          "<p>Details about the document attachments, including names, locations, sizes, etc.</p>"];
      requires: DocumentRequiresList.t
        [@ocaml.doc
          "<p>A list of SSM documents required by a document. For example, an <code>ApplicationConfiguration</code> document requires an <code>ApplicationConfigurationSchema</code> document.</p>"]}
    [@@ocaml.doc "<p>Describes a Systems Manager document. </p>"]
    let make ?sha1  ?hash  ?hash_type  ?name  ?version_name  ?owner 
      ?created_date  ?status  ?status_information  ?document_version 
      ?description  ?(parameters= [])  ?(platform_types= [])  ?document_type 
      ?schema_version  ?latest_version  ?default_version  ?document_format 
      ?target_type  ?(tags= [])  ?(attachments_information= [])  ?(requires=
      [])  () =
      {
        sha1;
        hash;
        hash_type;
        name;
        version_name;
        owner;
        created_date;
        status;
        status_information;
        document_version;
        description;
        parameters;
        platform_types;
        document_type;
        schema_version;
        latest_version;
        default_version;
        document_format;
        target_type;
        tags;
        attachments_information;
        requires
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("requires", (DocumentRequiresList.to_json v.requires));
           Some
             ("attachments_information",
               (AttachmentInformationList.to_json v.attachments_information));
           Some ("tags", (TagList.to_json v.tags));
           Util.option_map v.target_type
             (fun f -> ("target_type", (String.to_json f)));
           Util.option_map v.document_format
             (fun f -> ("document_format", (DocumentFormat.to_json f)));
           Util.option_map v.default_version
             (fun f -> ("default_version", (String.to_json f)));
           Util.option_map v.latest_version
             (fun f -> ("latest_version", (String.to_json f)));
           Util.option_map v.schema_version
             (fun f -> ("schema_version", (String.to_json f)));
           Util.option_map v.document_type
             (fun f -> ("document_type", (DocumentType.to_json f)));
           Some
             ("platform_types", (PlatformTypeList.to_json v.platform_types));
           Some ("parameters", (DocumentParameterList.to_json v.parameters));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.status_information
             (fun f -> ("status_information", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (DocumentStatus.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.owner (fun f -> ("owner", (String.to_json f)));
           Util.option_map v.version_name
             (fun f -> ("version_name", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.hash_type
             (fun f -> ("hash_type", (DocumentHashType.to_json f)));
           Util.option_map v.hash (fun f -> ("hash", (String.to_json f)));
           Util.option_map v.sha1 (fun f -> ("sha1", (String.to_json f)))])
    let of_json j =
      {
        sha1 = (Util.option_map (Json.lookup j "sha1") String.of_json);
        hash = (Util.option_map (Json.lookup j "hash") String.of_json);
        hash_type =
          (Util.option_map (Json.lookup j "hash_type")
             DocumentHashType.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        owner = (Util.option_map (Json.lookup j "owner") String.of_json);
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        status =
          (Util.option_map (Json.lookup j "status") DocumentStatus.of_json);
        status_information =
          (Util.option_map (Json.lookup j "status_information")
             String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        parameters =
          (DocumentParameterList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        platform_types =
          (PlatformTypeList.of_json
             (Util.of_option_exn (Json.lookup j "platform_types")));
        document_type =
          (Util.option_map (Json.lookup j "document_type")
             DocumentType.of_json);
        schema_version =
          (Util.option_map (Json.lookup j "schema_version") String.of_json);
        latest_version =
          (Util.option_map (Json.lookup j "latest_version") String.of_json);
        default_version =
          (Util.option_map (Json.lookup j "default_version") String.of_json);
        document_format =
          (Util.option_map (Json.lookup j "document_format")
             DocumentFormat.of_json);
        target_type =
          (Util.option_map (Json.lookup j "target_type") String.of_json);
        tags = (TagList.of_json (Util.of_option_exn (Json.lookup j "tags")));
        attachments_information =
          (AttachmentInformationList.of_json
             (Util.of_option_exn (Json.lookup j "attachments_information")));
        requires =
          (DocumentRequiresList.of_json
             (Util.of_option_exn (Json.lookup j "requires")))
      }
  end[@@ocaml.doc "<p>Describes a Systems Manager document. </p>"]
module ResourceDataSyncSource =
  struct
    type t =
      {
      source_type: String.t
        [@ocaml.doc
          "<p>The type of data source for the resource data sync. <code>SourceType</code> is either <code>AwsOrganizations</code> (if an organization is present in AWS Organizations) or <code>singleAccountMultiRegions</code>.</p>"];
      aws_organizations_source:
        ResourceDataSyncAwsOrganizationsSource.t option
        [@ocaml.doc
          "<p>The field name in <code>SyncSource</code> for the <code>ResourceDataSyncAwsOrganizationsSource</code> type.</p>"];
      source_regions: ResourceDataSyncSourceRegionList.t
        [@ocaml.doc
          "<p>The <code>SyncSource</code> AWS Regions included in the resource data sync.</p>"];
      include_future_regions: Boolean.t option
        [@ocaml.doc
          "<p>Whether to automatically synchronize and aggregate data from new AWS Regions when those Regions come online.</p>"]}
    [@@ocaml.doc
      "<p>Information about the source of the data included in the resource data sync.</p>"]
    let make ~source_type  ?aws_organizations_source  ~source_regions 
      ?include_future_regions  () =
      {
        source_type;
        aws_organizations_source;
        source_regions;
        include_future_regions
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.include_future_regions
              (fun f -> ("include_future_regions", (Boolean.to_json f)));
           Some
             ("source_regions",
               (ResourceDataSyncSourceRegionList.to_json v.source_regions));
           Util.option_map v.aws_organizations_source
             (fun f ->
                ("aws_organizations_source",
                  (ResourceDataSyncAwsOrganizationsSource.to_json f)));
           Some ("source_type", (String.to_json v.source_type))])
    let of_json j =
      {
        source_type =
          (String.of_json (Util.of_option_exn (Json.lookup j "source_type")));
        aws_organizations_source =
          (Util.option_map (Json.lookup j "aws_organizations_source")
             ResourceDataSyncAwsOrganizationsSource.of_json);
        source_regions =
          (ResourceDataSyncSourceRegionList.of_json
             (Util.of_option_exn (Json.lookup j "source_regions")));
        include_future_regions =
          (Util.option_map (Json.lookup j "include_future_regions")
             Boolean.of_json)
      }
  end[@@ocaml.doc
       "<p>Information about the source of the data included in the resource data sync.</p>"]
module rec
  InventoryAggregator:sig
                        type t =
                          {
                          expression: String.t option ;
                          aggregators: InventoryAggregatorList.t ;
                          groups: InventoryGroupList.t }[@@ocaml.doc
                                                          "<p>Specifies the inventory type and attribute for the aggregation execution.</p>"]
                        val make :
                          ?expression:String.t ->
                            ?aggregators:InventoryAggregatorList.t ->
                              ?groups:InventoryGroupList.t -> unit -> t
                        val to_query : t -> Aws.Query.t
                        val to_headers : t -> Aws.Headers.t
                        val to_json : t -> Aws.Json.t
                        val of_json : Aws.Json.t -> t
                      end =
  struct
    type t =
      {
      expression: String.t option
        [@ocaml.doc
          "<p>The inventory type and attribute name for aggregation.</p>"];
      aggregators: InventoryAggregatorList.t
        [@ocaml.doc
          "<p>Nested aggregators to further refine aggregation for an inventory type.</p>"];
      groups: InventoryGroupList.t
        [@ocaml.doc
          "<p>A user-defined set of one or more filters on which to aggregate inventory data. Groups return a count of resources that match and don't match the specified criteria.</p>"]}
    [@@ocaml.doc
      "<p>Specifies the inventory type and attribute for the aggregation execution.</p>"]
    let make ?expression  ?(aggregators= [])  ?(groups= [])  () =
      { expression; aggregators; groups }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("groups", (InventoryGroupList.to_json v.groups));
           Some
             ("aggregators", (InventoryAggregatorList.to_json v.aggregators));
           Util.option_map v.expression
             (fun f -> ("expression", (String.to_json f)))])
    let of_json j =
      {
        expression =
          (Util.option_map (Json.lookup j "expression") String.of_json);
        aggregators =
          (InventoryAggregatorList.of_json
             (Util.of_option_exn (Json.lookup j "aggregators")));
        groups =
          (InventoryGroupList.of_json
             (Util.of_option_exn (Json.lookup j "groups")))
      }
  end[@@ocaml.doc
       "<p>Specifies the inventory type and attribute for the aggregation execution.</p>"]
 and
  InventoryAggregatorList:sig
                            type t = InventoryAggregator.t list
                            val make : t -> unit -> t
                            val to_query : t -> Aws.Query.t
                            val to_headers : t -> Aws.Headers.t
                            val to_json : t -> Aws.Json.t
                            val of_json : Aws.Json.t -> t
                          end =
  struct
    type t = InventoryAggregator.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryAggregator.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryAggregator.to_headers v
    let to_json v = `List (List.map InventoryAggregator.to_json v)
    let of_json j = Json.to_list InventoryAggregator.of_json j
  end
module ResultAttributeList =
  struct
    type t = ResultAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResultAttribute.to_query v
    let to_headers v = Headers.to_headers_list ResultAttribute.to_headers v
    let to_json v = `List (List.map ResultAttribute.to_json v)
    let of_json j = Json.to_list ResultAttribute.of_json j
  end
module AutomationExecution =
  struct
    type t =
      {
      automation_execution_id: String.t option
        [@ocaml.doc "<p>The execution ID.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The name of the Automation document used during the execution.</p>"];
      document_version: String.t option
        [@ocaml.doc
          "<p>The version of the document to use during execution.</p>"];
      execution_start_time: DateTime.t option
        [@ocaml.doc "<p>The time the execution started.</p>"];
      execution_end_time: DateTime.t option
        [@ocaml.doc "<p>The time the execution finished.</p>"];
      automation_execution_status: AutomationExecutionStatus.t option
        [@ocaml.doc "<p>The execution status of the Automation.</p>"];
      step_executions: StepExecutionList.t
        [@ocaml.doc
          "<p>A list of details about the current state of all steps that comprise an execution. An Automation document contains a list of steps that are run in order.</p>"];
      step_executions_truncated: Boolean.t option
        [@ocaml.doc
          "<p>A boolean value that indicates if the response contains the full list of the Automation step executions. If true, use the DescribeAutomationStepExecutions API action to get the full list of step executions.</p>"];
      parameters: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>The key-value map of execution parameters, which were supplied when calling StartAutomationExecution.</p>"];
      outputs: AutomationParameterMap.t option
        [@ocaml.doc
          "<p>The list of execution outputs as defined in the automation document.</p>"];
      failure_message: String.t option
        [@ocaml.doc
          "<p>A message describing why an execution has failed, if the status is set to Failed.</p>"];
      mode: ExecutionMode.t option
        [@ocaml.doc "<p>The automation execution mode.</p>"];
      parent_automation_execution_id: String.t option
        [@ocaml.doc
          "<p>The AutomationExecutionId of the parent automation.</p>"];
      executed_by: String.t option
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of the user who ran the automation.</p>"];
      current_step_name: String.t option
        [@ocaml.doc "<p>The name of the step that is currently running.</p>"];
      current_action: String.t option
        [@ocaml.doc
          "<p>The action of the step that is currently running.</p>"];
      target_parameter_name: String.t option
        [@ocaml.doc "<p>The parameter name.</p>"];
      targets: Targets.t [@ocaml.doc "<p>The specified targets.</p>"];
      target_maps: TargetMaps.t
        [@ocaml.doc
          "<p>The specified key-value mapping of document parameters to target resources.</p>"];
      resolved_targets: ResolvedTargets.t option
        [@ocaml.doc
          "<p>A list of resolved targets in the rate control execution.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The MaxConcurrency value specified by the user when the execution started.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The MaxErrors value specified by the user when the execution started.</p>"];
      target: String.t option
        [@ocaml.doc "<p>The target of the execution.</p>"];
      target_locations: TargetLocations.t
        [@ocaml.doc
          "<p>The combination of AWS Regions and/or AWS accounts where you want to run the Automation.</p>"];
      progress_counters: ProgressCounters.t option
        [@ocaml.doc
          "<p>An aggregate of step execution statuses displayed in the AWS Console for a multi-Region and multi-account Automation execution.</p>"]}
    [@@ocaml.doc
      "<p>Detailed information about the current state of an individual Automation execution.</p>"]
    let make ?automation_execution_id  ?document_name  ?document_version 
      ?execution_start_time  ?execution_end_time 
      ?automation_execution_status  ?(step_executions= []) 
      ?step_executions_truncated  ?parameters  ?outputs  ?failure_message 
      ?mode  ?parent_automation_execution_id  ?executed_by 
      ?current_step_name  ?current_action  ?target_parameter_name  ?(targets=
      [])  ?(target_maps= [])  ?resolved_targets  ?max_concurrency 
      ?max_errors  ?target  ?(target_locations= [])  ?progress_counters  () =
      {
        automation_execution_id;
        document_name;
        document_version;
        execution_start_time;
        execution_end_time;
        automation_execution_status;
        step_executions;
        step_executions_truncated;
        parameters;
        outputs;
        failure_message;
        mode;
        parent_automation_execution_id;
        executed_by;
        current_step_name;
        current_action;
        target_parameter_name;
        targets;
        target_maps;
        resolved_targets;
        max_concurrency;
        max_errors;
        target;
        target_locations;
        progress_counters
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.progress_counters
              (fun f -> ("progress_counters", (ProgressCounters.to_json f)));
           Some
             ("target_locations",
               (TargetLocations.to_json v.target_locations));
           Util.option_map v.target (fun f -> ("target", (String.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.resolved_targets
             (fun f -> ("resolved_targets", (ResolvedTargets.to_json f)));
           Some ("target_maps", (TargetMaps.to_json v.target_maps));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.target_parameter_name
             (fun f -> ("target_parameter_name", (String.to_json f)));
           Util.option_map v.current_action
             (fun f -> ("current_action", (String.to_json f)));
           Util.option_map v.current_step_name
             (fun f -> ("current_step_name", (String.to_json f)));
           Util.option_map v.executed_by
             (fun f -> ("executed_by", (String.to_json f)));
           Util.option_map v.parent_automation_execution_id
             (fun f -> ("parent_automation_execution_id", (String.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ExecutionMode.to_json f)));
           Util.option_map v.failure_message
             (fun f -> ("failure_message", (String.to_json f)));
           Util.option_map v.outputs
             (fun f -> ("outputs", (AutomationParameterMap.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (AutomationParameterMap.to_json f)));
           Util.option_map v.step_executions_truncated
             (fun f -> ("step_executions_truncated", (Boolean.to_json f)));
           Some
             ("step_executions",
               (StepExecutionList.to_json v.step_executions));
           Util.option_map v.automation_execution_status
             (fun f ->
                ("automation_execution_status",
                  (AutomationExecutionStatus.to_json f)));
           Util.option_map v.execution_end_time
             (fun f -> ("execution_end_time", (DateTime.to_json f)));
           Util.option_map v.execution_start_time
             (fun f -> ("execution_start_time", (DateTime.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Util.option_map v.automation_execution_id
             (fun f -> ("automation_execution_id", (String.to_json f)))])
    let of_json j =
      {
        automation_execution_id =
          (Util.option_map (Json.lookup j "automation_execution_id")
             String.of_json);
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        execution_start_time =
          (Util.option_map (Json.lookup j "execution_start_time")
             DateTime.of_json);
        execution_end_time =
          (Util.option_map (Json.lookup j "execution_end_time")
             DateTime.of_json);
        automation_execution_status =
          (Util.option_map (Json.lookup j "automation_execution_status")
             AutomationExecutionStatus.of_json);
        step_executions =
          (StepExecutionList.of_json
             (Util.of_option_exn (Json.lookup j "step_executions")));
        step_executions_truncated =
          (Util.option_map (Json.lookup j "step_executions_truncated")
             Boolean.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters")
             AutomationParameterMap.of_json);
        outputs =
          (Util.option_map (Json.lookup j "outputs")
             AutomationParameterMap.of_json);
        failure_message =
          (Util.option_map (Json.lookup j "failure_message") String.of_json);
        mode = (Util.option_map (Json.lookup j "mode") ExecutionMode.of_json);
        parent_automation_execution_id =
          (Util.option_map (Json.lookup j "parent_automation_execution_id")
             String.of_json);
        executed_by =
          (Util.option_map (Json.lookup j "executed_by") String.of_json);
        current_step_name =
          (Util.option_map (Json.lookup j "current_step_name") String.of_json);
        current_action =
          (Util.option_map (Json.lookup j "current_action") String.of_json);
        target_parameter_name =
          (Util.option_map (Json.lookup j "target_parameter_name")
             String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        target_maps =
          (TargetMaps.of_json
             (Util.of_option_exn (Json.lookup j "target_maps")));
        resolved_targets =
          (Util.option_map (Json.lookup j "resolved_targets")
             ResolvedTargets.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        target = (Util.option_map (Json.lookup j "target") String.of_json);
        target_locations =
          (TargetLocations.of_json
             (Util.of_option_exn (Json.lookup j "target_locations")));
        progress_counters =
          (Util.option_map (Json.lookup j "progress_counters")
             ProgressCounters.of_json)
      }
  end[@@ocaml.doc
       "<p>Detailed information about the current state of an individual Automation execution.</p>"]
module DocumentDefaultVersionDescription =
  struct
    type t =
      {
      name: String.t option [@ocaml.doc "<p>The name of the document.</p>"];
      default_version: String.t option
        [@ocaml.doc "<p>The default version of the document.</p>"];
      default_version_name: String.t option
        [@ocaml.doc
          "<p>The default version of the artifact associated with the document.</p>"]}
    [@@ocaml.doc "<p>A default version of a document.</p>"]
    let make ?name  ?default_version  ?default_version_name  () =
      { name; default_version; default_version_name }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_version_name
              (fun f -> ("default_version_name", (String.to_json f)));
           Util.option_map v.default_version
             (fun f -> ("default_version", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        default_version =
          (Util.option_map (Json.lookup j "default_version") String.of_json);
        default_version_name =
          (Util.option_map (Json.lookup j "default_version_name")
             String.of_json)
      }
  end[@@ocaml.doc "<p>A default version of a document.</p>"]
module PatchProperty =
  struct
    type t =
      | PRODUCT 
      | PRODUCT_FAMILY 
      | CLASSIFICATION 
      | MSRC_SEVERITY 
      | PRIORITY 
      | SEVERITY 
    let str_to_t =
      [("SEVERITY", SEVERITY);
      ("PRIORITY", PRIORITY);
      ("MSRC_SEVERITY", MSRC_SEVERITY);
      ("CLASSIFICATION", CLASSIFICATION);
      ("PRODUCT_FAMILY", PRODUCT_FAMILY);
      ("PRODUCT", PRODUCT)]
    let t_to_str =
      [(SEVERITY, "SEVERITY");
      (PRIORITY, "PRIORITY");
      (MSRC_SEVERITY, "MSRC_SEVERITY");
      (CLASSIFICATION, "CLASSIFICATION");
      (PRODUCT_FAMILY, "PRODUCT_FAMILY");
      (PRODUCT, "PRODUCT")]
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
module PatchSet =
  struct
    type t =
      | OS 
      | APPLICATION 
    let str_to_t = [("APPLICATION", APPLICATION); ("OS", OS)]
    let t_to_str = [(APPLICATION, "APPLICATION"); (OS, "OS")]
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
module AssociationExecutionFilterList =
  struct
    type t = AssociationExecutionFilter.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list AssociationExecutionFilter.to_query v
    let to_headers v =
      Headers.to_headers_list AssociationExecutionFilter.to_headers v
    let to_json v = `List (List.map AssociationExecutionFilter.to_json v)
    let of_json j = Json.to_list AssociationExecutionFilter.of_json j
  end
module KeyList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ResourceTypeForTagging =
  struct
    type t =
      | Document 
      | ManagedInstance 
      | MaintenanceWindow 
      | Parameter 
      | PatchBaseline 
      | OpsItem 
    let str_to_t =
      [("OpsItem", OpsItem);
      ("PatchBaseline", PatchBaseline);
      ("Parameter", Parameter);
      ("MaintenanceWindow", MaintenanceWindow);
      ("ManagedInstance", ManagedInstance);
      ("Document", Document)]
    let t_to_str =
      [(OpsItem, "OpsItem");
      (PatchBaseline, "PatchBaseline");
      (Parameter, "Parameter");
      (MaintenanceWindow, "MaintenanceWindow");
      (ManagedInstance, "ManagedInstance");
      (Document, "Document")]
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
module OpsEntityList =
  struct
    type t = OpsEntity.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsEntity.to_query v
    let to_headers v = Headers.to_headers_list OpsEntity.to_headers v
    let to_json v = `List (List.map OpsEntity.to_json v)
    let of_json j = Json.to_list OpsEntity.of_json j
  end
module OpsItemOpsDataKeysList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PatchOrchestratorFilterList =
  struct
    type t = PatchOrchestratorFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchOrchestratorFilter.to_query v
    let to_headers v =
      Headers.to_headers_list PatchOrchestratorFilter.to_headers v
    let to_json v = `List (List.map PatchOrchestratorFilter.to_json v)
    let of_json j = Json.to_list PatchOrchestratorFilter.of_json j
  end
module PatchAction =
  struct
    type t =
      | ALLOW_AS_DEPENDENCY 
      | BLOCK 
    let str_to_t =
      [("BLOCK", BLOCK); ("ALLOW_AS_DEPENDENCY", ALLOW_AS_DEPENDENCY)]
    let t_to_str =
      [(BLOCK, "BLOCK"); (ALLOW_AS_DEPENDENCY, "ALLOW_AS_DEPENDENCY")]
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
module PatchIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PatchRuleGroup =
  struct
    type t =
      {
      patch_rules: PatchRuleList.t
        [@ocaml.doc "<p>The rules that make up the rule group.</p>"]}
    [@@ocaml.doc
      "<p>A set of rules defining the approval rules for a patch baseline.</p>"]
    let make ~patch_rules  () = { patch_rules }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("patch_rules", (PatchRuleList.to_json v.patch_rules))])
    let of_json j =
      {
        patch_rules =
          (PatchRuleList.of_json
             (Util.of_option_exn (Json.lookup j "patch_rules")))
      }
  end[@@ocaml.doc
       "<p>A set of rules defining the approval rules for a patch baseline.</p>"]
module PatchSourceList =
  struct
    type t = PatchSource.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchSource.to_query v
    let to_headers v = Headers.to_headers_list PatchSource.to_headers v
    let to_json v = `List (List.map PatchSource.to_json v)
    let of_json j = Json.to_list PatchSource.of_json j
  end
module AssociationList =
  struct
    type t = Association.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Association.to_query v
    let to_headers v = Headers.to_headers_list Association.to_headers v
    let to_json v = `List (List.map Association.to_json v)
    let of_json j = Json.to_list Association.of_json j
  end
module SessionList =
  struct
    type t = Session.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Session.to_query v
    let to_headers v = Headers.to_headers_list Session.to_headers v
    let to_json v = `List (List.map Session.to_json v)
    let of_json j = Json.to_list Session.of_json j
  end
module ActivationList =
  struct
    type t = Activation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Activation.to_query v
    let to_headers v = Headers.to_headers_list Activation.to_headers v
    let to_json v = `List (List.map Activation.to_json v)
    let of_json j = Json.to_list Activation.of_json j
  end
module ComplianceItemList =
  struct
    type t = ComplianceItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ComplianceItem.to_query v
    let to_headers v = Headers.to_headers_list ComplianceItem.to_headers v
    let to_json v = `List (List.map ComplianceItem.to_json v)
    let of_json j = Json.to_list ComplianceItem.of_json j
  end
module MaintenanceWindowTaskList =
  struct
    type t = MaintenanceWindowTask.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MaintenanceWindowTask.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowTask.to_headers v
    let to_json v = `List (List.map MaintenanceWindowTask.to_json v)
    let of_json j = Json.to_list MaintenanceWindowTask.of_json j
  end
module CommandFilterList =
  struct
    type t = CommandFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CommandFilter.to_query v
    let to_headers v = Headers.to_headers_list CommandFilter.to_headers v
    let to_json v = `List (List.map CommandFilter.to_json v)
    let of_json j = Json.to_list CommandFilter.of_json j
  end
module InventoryResultEntityList =
  struct
    type t = InventoryResultEntity.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryResultEntity.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryResultEntity.to_headers v
    let to_json v = `List (List.map InventoryResultEntity.to_json v)
    let of_json j = Json.to_list InventoryResultEntity.of_json j
  end
module InstanceAssociationList =
  struct
    type t = InstanceAssociation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstanceAssociation.to_query v
    let to_headers v =
      Headers.to_headers_list InstanceAssociation.to_headers v
    let to_json v = `List (List.map InstanceAssociation.to_json v)
    let of_json j = Json.to_list InstanceAssociation.of_json j
  end
module PatchPropertiesList =
  struct
    type t = PatchPropertyEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchPropertyEntry.to_query v
    let to_headers v =
      Headers.to_headers_list PatchPropertyEntry.to_headers v
    let to_json v = `List (List.map PatchPropertyEntry.to_json v)
    let of_json j = Json.to_list PatchPropertyEntry.of_json j
  end
module AssociationIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module MaintenanceWindowFilterList =
  struct
    type t = MaintenanceWindowFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MaintenanceWindowFilter.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowFilter.to_headers v
    let to_json v = `List (List.map MaintenanceWindowFilter.to_json v)
    let of_json j = Json.to_list MaintenanceWindowFilter.of_json j
  end
module ResourceComplianceSummaryItemList =
  struct
    type t = ResourceComplianceSummaryItem.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list ResourceComplianceSummaryItem.to_query v
    let to_headers v =
      Headers.to_headers_list ResourceComplianceSummaryItem.to_headers v
    let to_json v = `List (List.map ResourceComplianceSummaryItem.to_json v)
    let of_json j = Json.to_list ResourceComplianceSummaryItem.of_json j
  end
module InstancePatchStateFilterList =
  struct
    type t = InstancePatchStateFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstancePatchStateFilter.to_query v
    let to_headers v =
      Headers.to_headers_list InstancePatchStateFilter.to_headers v
    let to_json v = `List (List.map InstancePatchStateFilter.to_json v)
    let of_json j = Json.to_list InstancePatchStateFilter.of_json j
  end
module CreateAssociationBatchRequestEntries =
  struct
    type t = CreateAssociationBatchRequestEntry.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list CreateAssociationBatchRequestEntry.to_query v
    let to_headers v =
      Headers.to_headers_list CreateAssociationBatchRequestEntry.to_headers v
    let to_json v =
      `List (List.map CreateAssociationBatchRequestEntry.to_json v)
    let of_json j = Json.to_list CreateAssociationBatchRequestEntry.of_json j
  end
module AssociationExecutionTargetsList =
  struct
    type t = AssociationExecutionTarget.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list AssociationExecutionTarget.to_query v
    let to_headers v =
      Headers.to_headers_list AssociationExecutionTarget.to_headers v
    let to_json v = `List (List.map AssociationExecutionTarget.to_json v)
    let of_json j = Json.to_list AssociationExecutionTarget.of_json j
  end
module AssociationExecutionsList =
  struct
    type t = AssociationExecution.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AssociationExecution.to_query v
    let to_headers v =
      Headers.to_headers_list AssociationExecution.to_headers v
    let to_json v = `List (List.map AssociationExecution.to_json v)
    let of_json j = Json.to_list AssociationExecution.of_json j
  end
module ParameterList =
  struct
    type t = Parameter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Parameter.to_query v
    let to_headers v = Headers.to_headers_list Parameter.to_headers v
    let to_json v = `List (List.map Parameter.to_json v)
    let of_json j = Json.to_list Parameter.of_json j
  end
module InstancePatchStatesList =
  struct
    type t = InstancePatchState.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstancePatchState.to_query v
    let to_headers v =
      Headers.to_headers_list InstancePatchState.to_headers v
    let to_json v = `List (List.map InstancePatchState.to_json v)
    let of_json j = Json.to_list InstancePatchState.of_json j
  end
module AutomationExecutionFilterList =
  struct
    type t = AutomationExecutionFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AutomationExecutionFilter.to_query v
    let to_headers v =
      Headers.to_headers_list AutomationExecutionFilter.to_headers v
    let to_json v = `List (List.map AutomationExecutionFilter.to_json v)
    let of_json j = Json.to_list AutomationExecutionFilter.of_json j
  end
module CommandList =
  struct
    type t = Command.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Command.to_query v
    let to_headers v = Headers.to_headers_list Command.to_headers v
    let to_json v = `List (List.map Command.to_json v)
    let of_json j = Json.to_list Command.of_json j
  end
module MaintenanceWindowTargetList =
  struct
    type t = MaintenanceWindowTarget.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MaintenanceWindowTarget.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowTarget.to_headers v
    let to_json v = `List (List.map MaintenanceWindowTarget.to_json v)
    let of_json j = Json.to_list MaintenanceWindowTarget.of_json j
  end
module OpsItemSummaries =
  struct
    type t = OpsItemSummary.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsItemSummary.to_query v
    let to_headers v = Headers.to_headers_list OpsItemSummary.to_headers v
    let to_json v = `List (List.map OpsItemSummary.to_json v)
    let of_json j = Json.to_list OpsItemSummary.of_json j
  end
module rec
  OpsAggregator:sig
                  type t =
                    {
                    aggregator_type: String.t option ;
                    type_name: String.t option ;
                    attribute_name: String.t option ;
                    values: OpsAggregatorValueMap.t option ;
                    filters: OpsFilterList.t ;
                    aggregators: OpsAggregatorList.t }[@@ocaml.doc
                                                        "<p>One or more aggregators for viewing counts of OpsItems using different dimensions such as <code>Source</code>, <code>CreatedTime</code>, or <code>Source and CreatedTime</code>, to name a few.</p>"]
                  val make :
                    ?aggregator_type:String.t ->
                      ?type_name:String.t ->
                        ?attribute_name:String.t ->
                          ?values:OpsAggregatorValueMap.t ->
                            ?filters:OpsFilterList.t ->
                              ?aggregators:OpsAggregatorList.t -> unit -> t
                  val to_query : t -> Aws.Query.t
                  val to_headers : t -> Aws.Headers.t
                  val to_json : t -> Aws.Json.t
                  val of_json : Aws.Json.t -> t
                end =
  struct
    type t =
      {
      aggregator_type: String.t option
        [@ocaml.doc
          "<p>Either a Range or Count aggregator for limiting an OpsItem summary.</p>"];
      type_name: String.t option
        [@ocaml.doc
          "<p>The data type name to use for viewing counts of OpsItems.</p>"];
      attribute_name: String.t option
        [@ocaml.doc
          "<p>The name of an OpsItem attribute on which to limit the count of OpsItems.</p>"];
      values: OpsAggregatorValueMap.t option
        [@ocaml.doc "<p>The aggregator value.</p>"];
      filters: OpsFilterList.t [@ocaml.doc "<p>The aggregator filters.</p>"];
      aggregators: OpsAggregatorList.t
        [@ocaml.doc
          "<p>A nested aggregator for viewing counts of OpsItems.</p>"]}
    [@@ocaml.doc
      "<p>One or more aggregators for viewing counts of OpsItems using different dimensions such as <code>Source</code>, <code>CreatedTime</code>, or <code>Source and CreatedTime</code>, to name a few.</p>"]
    let make ?aggregator_type  ?type_name  ?attribute_name  ?values 
      ?(filters= [])  ?(aggregators= [])  () =
      {
        aggregator_type;
        type_name;
        attribute_name;
        values;
        filters;
        aggregators
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("aggregators", (OpsAggregatorList.to_json v.aggregators));
           Some ("filters", (OpsFilterList.to_json v.filters));
           Util.option_map v.values
             (fun f -> ("values", (OpsAggregatorValueMap.to_json f)));
           Util.option_map v.attribute_name
             (fun f -> ("attribute_name", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.aggregator_type
             (fun f -> ("aggregator_type", (String.to_json f)))])
    let of_json j =
      {
        aggregator_type =
          (Util.option_map (Json.lookup j "aggregator_type") String.of_json);
        type_name =
          (Util.option_map (Json.lookup j "type_name") String.of_json);
        attribute_name =
          (Util.option_map (Json.lookup j "attribute_name") String.of_json);
        values =
          (Util.option_map (Json.lookup j "values")
             OpsAggregatorValueMap.of_json);
        filters =
          (OpsFilterList.of_json
             (Util.of_option_exn (Json.lookup j "filters")));
        aggregators =
          (OpsAggregatorList.of_json
             (Util.of_option_exn (Json.lookup j "aggregators")))
      }
  end[@@ocaml.doc
       "<p>One or more aggregators for viewing counts of OpsItems using different dimensions such as <code>Source</code>, <code>CreatedTime</code>, or <code>Source and CreatedTime</code>, to name a few.</p>"]
 and
  OpsAggregatorList:sig
                      type t = OpsAggregator.t list
                      val make : t -> unit -> t
                      val to_query : t -> Aws.Query.t
                      val to_headers : t -> Aws.Headers.t
                      val to_json : t -> Aws.Json.t
                      val of_json : Aws.Json.t -> t
                    end =
  struct
    type t = OpsAggregator.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsAggregator.to_query v
    let to_headers v = Headers.to_headers_list OpsAggregator.to_headers v
    let to_json v = `List (List.map OpsAggregator.to_json v)
    let of_json j = Json.to_list OpsAggregator.of_json j
  end
module OpsResultAttributeList =
  struct
    type t = OpsResultAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsResultAttribute.to_query v
    let to_headers v =
      Headers.to_headers_list OpsResultAttribute.to_headers v
    let to_json v = `List (List.map OpsResultAttribute.to_json v)
    let of_json j = Json.to_list OpsResultAttribute.of_json j
  end
module PatchComplianceDataList =
  struct
    type t = PatchComplianceData.t list
    let make elems () = elems
    let to_query v = Query.to_query_list PatchComplianceData.to_query v
    let to_headers v =
      Headers.to_headers_list PatchComplianceData.to_headers v
    let to_json v = `List (List.map PatchComplianceData.to_json v)
    let of_json j = Json.to_list PatchComplianceData.of_json j
  end
module PatchList =
  struct
    type t = Patch.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Patch.to_query v
    let to_headers v = Headers.to_headers_list Patch.to_headers v
    let to_json v = `List (List.map Patch.to_json v)
    let of_json j = Json.to_list Patch.of_json j
  end
module CalendarState =
  struct
    type t =
      | OPEN 
      | CLOSED 
    let str_to_t = [("CLOSED", CLOSED); ("OPEN", OPEN)]
    let t_to_str = [(CLOSED, "CLOSED"); (OPEN, "OPEN")]
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
module DocumentFilterList =
  struct
    type t = DocumentFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DocumentFilter.to_query v
    let to_headers v = Headers.to_headers_list DocumentFilter.to_headers v
    let to_json v = `List (List.map DocumentFilter.to_json v)
    let of_json j = Json.to_list DocumentFilter.of_json j
  end
module DocumentKeyValuesFilterList =
  struct
    type t = DocumentKeyValuesFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DocumentKeyValuesFilter.to_query v
    let to_headers v =
      Headers.to_headers_list DocumentKeyValuesFilter.to_headers v
    let to_json v = `List (List.map DocumentKeyValuesFilter.to_json v)
    let of_json j = Json.to_list DocumentKeyValuesFilter.of_json j
  end
module AssociationVersionList =
  struct
    type t = AssociationVersionInfo.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AssociationVersionInfo.to_query v
    let to_headers v =
      Headers.to_headers_list AssociationVersionInfo.to_headers v
    let to_json v = `List (List.map AssociationVersionInfo.to_json v)
    let of_json j = Json.to_list AssociationVersionInfo.of_json j
  end
module ComplianceSummaryItemList =
  struct
    type t = ComplianceSummaryItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ComplianceSummaryItem.to_query v
    let to_headers v =
      Headers.to_headers_list ComplianceSummaryItem.to_headers v
    let to_json v = `List (List.map ComplianceSummaryItem.to_json v)
    let of_json j = Json.to_list ComplianceSummaryItem.of_json j
  end
module CalendarNameOrARNList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module SessionManagerParameters =
  struct
    type t = (String.t, SessionManagerParameterValueList.t) Hashtbl.t
    let make elems () = elems
    let to_query v =
      Query.to_query_hashtbl String.to_string
        SessionManagerParameterValueList.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc ->
                  ((String.to_string k),
                    (SessionManagerParameterValueList.to_json v))
                  :: acc) v [])
    let of_json j =
      Json.to_hashtbl String.of_string
        SessionManagerParameterValueList.of_json j
  end
module EffectivePatchList =
  struct
    type t = EffectivePatch.t list
    let make elems () = elems
    let to_query v = Query.to_query_list EffectivePatch.to_query v
    let to_headers v = Headers.to_headers_list EffectivePatch.to_headers v
    let to_json v = `List (List.map EffectivePatch.to_json v)
    let of_json j = Json.to_list EffectivePatch.of_json j
  end
module AssociationDescriptionList =
  struct
    type t = AssociationDescription.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AssociationDescription.to_query v
    let to_headers v =
      Headers.to_headers_list AssociationDescription.to_headers v
    let to_json v = `List (List.map AssociationDescription.to_json v)
    let of_json j = Json.to_list AssociationDescription.of_json j
  end
module FailedCreateAssociationList =
  struct
    type t = FailedCreateAssociation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list FailedCreateAssociation.to_query v
    let to_headers v =
      Headers.to_headers_list FailedCreateAssociation.to_headers v
    let to_json v = `List (List.map FailedCreateAssociation.to_json v)
    let of_json j = Json.to_list FailedCreateAssociation.of_json j
  end
module ComplianceItemEntryList =
  struct
    type t = ComplianceItemEntry.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ComplianceItemEntry.to_query v
    let to_headers v =
      Headers.to_headers_list ComplianceItemEntry.to_headers v
    let to_json v = `List (List.map ComplianceItemEntry.to_json v)
    let of_json j = Json.to_list ComplianceItemEntry.of_json j
  end
module MaintenanceWindowTaskParametersList =
  struct
    type t = MaintenanceWindowTaskParameters.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list MaintenanceWindowTaskParameters.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowTaskParameters.to_headers v
    let to_json v =
      `List (List.map MaintenanceWindowTaskParameters.to_json v)
    let of_json j = Json.to_list MaintenanceWindowTaskParameters.of_json j
  end
module OpsItem =
  struct
    type t =
      {
      created_by: String.t option
        [@ocaml.doc
          "<p>The ARN of the AWS account that created the OpsItem.</p>"];
      created_time: DateTime.t option
        [@ocaml.doc "<p>The date and time the OpsItem was created.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The OpsItem description.</p>"];
      last_modified_by: String.t option
        [@ocaml.doc
          "<p>The ARN of the AWS account that last updated the OpsItem.</p>"];
      last_modified_time: DateTime.t option
        [@ocaml.doc "<p>The date and time the OpsItem was last updated.</p>"];
      notifications: OpsItemNotifications.t
        [@ocaml.doc
          "<p>The Amazon Resource Name (ARN) of an SNS topic where notifications are sent when this OpsItem is edited or changed.</p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The importance of this OpsItem in relation to other OpsItems in the system.</p>"];
      related_ops_items: RelatedOpsItems.t
        [@ocaml.doc
          "<p>One or more OpsItems that share something in common with the current OpsItem. For example, related OpsItems can include OpsItems with similar error messages, impacted resources, or statuses for the impacted resource.</p>"];
      status: OpsItemStatus.t option
        [@ocaml.doc
          "<p>The OpsItem status. Status can be <code>Open</code>, <code>In Progress</code>, or <code>Resolved</code>. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-working-with-OpsItems-editing-details.html\">Editing OpsItem Details</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      ops_item_id: String.t option
        [@ocaml.doc "<p>The ID of the OpsItem.</p>"];
      version: String.t option
        [@ocaml.doc
          "<p>The version of this OpsItem. Each time the OpsItem is edited the version number increments by one.</p>"];
      title: String.t option
        [@ocaml.doc
          "<p>A short heading that describes the nature of the OpsItem and the impacted resource.</p>"];
      source: String.t option
        [@ocaml.doc
          "<p>The origin of the OpsItem, such as Amazon EC2 or AWS Systems Manager. The impacted resource is a subset of source.</p>"];
      operational_data: OpsItemOperationalData.t option
        [@ocaml.doc
          "<p>Operational data is custom data that provides useful reference details about the OpsItem. For example, you can specify log files, error strings, license keys, troubleshooting tips, or other relevant data. You enter operational data as key-value pairs. The key has a maximum length of 128 characters. The value has a maximum size of 20 KB.</p> <important> <p>Operational data keys <i>can't</i> begin with the following: amazon, aws, amzn, ssm, /amazon, /aws, /amzn, /ssm.</p> </important> <p>You can choose to make the data searchable by other users in the account or you can restrict search access. Searchable data means that all users with access to the OpsItem Overview page (as provided by the <a>DescribeOpsItems</a> API action) can view and search on the specified data. Operational data that is not searchable is only viewable by users who have access to the OpsItem (as provided by the <a>GetOpsItem</a> API action).</p> <p>Use the <code>/aws/resources</code> key in OperationalData to specify a related resource in the request. Use the <code>/aws/automations</code> key in OperationalData to associate an Automation runbook with the OpsItem. To view AWS CLI example commands that use these keys, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-creating-OpsItems.html#OpsCenter-manually-create-OpsItems\">Creating OpsItems Manually</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      category: String.t option
        [@ocaml.doc
          "<p>An OpsItem category. Category options include: Availability, Cost, Performance, Recovery, Security.</p>"];
      severity: String.t option
        [@ocaml.doc
          "<p>The severity of the OpsItem. Severity options range from 1 to 4.</p>"]}
    [@@ocaml.doc
      "<p>Operations engineers and IT professionals use OpsCenter to view, investigate, and remediate operational issues impacting the performance and health of their AWS resources. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html\">AWS Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>. </p>"]
    let make ?created_by  ?created_time  ?description  ?last_modified_by 
      ?last_modified_time  ?(notifications= [])  ?priority 
      ?(related_ops_items= [])  ?status  ?ops_item_id  ?version  ?title 
      ?source  ?operational_data  ?category  ?severity  () =
      {
        created_by;
        created_time;
        description;
        last_modified_by;
        last_modified_time;
        notifications;
        priority;
        related_ops_items;
        status;
        ops_item_id;
        version;
        title;
        source;
        operational_data;
        category;
        severity
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.severity
              (fun f -> ("severity", (String.to_json f)));
           Util.option_map v.category
             (fun f -> ("category", (String.to_json f)));
           Util.option_map v.operational_data
             (fun f ->
                ("operational_data", (OpsItemOperationalData.to_json f)));
           Util.option_map v.source (fun f -> ("source", (String.to_json f)));
           Util.option_map v.title (fun f -> ("title", (String.to_json f)));
           Util.option_map v.version
             (fun f -> ("version", (String.to_json f)));
           Util.option_map v.ops_item_id
             (fun f -> ("ops_item_id", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (OpsItemStatus.to_json f)));
           Some
             ("related_ops_items",
               (RelatedOpsItems.to_json v.related_ops_items));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Some
             ("notifications",
               (OpsItemNotifications.to_json v.notifications));
           Util.option_map v.last_modified_time
             (fun f -> ("last_modified_time", (DateTime.to_json f)));
           Util.option_map v.last_modified_by
             (fun f -> ("last_modified_by", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.created_time
             (fun f -> ("created_time", (DateTime.to_json f)));
           Util.option_map v.created_by
             (fun f -> ("created_by", (String.to_json f)))])
    let of_json j =
      {
        created_by =
          (Util.option_map (Json.lookup j "created_by") String.of_json);
        created_time =
          (Util.option_map (Json.lookup j "created_time") DateTime.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        last_modified_by =
          (Util.option_map (Json.lookup j "last_modified_by") String.of_json);
        last_modified_time =
          (Util.option_map (Json.lookup j "last_modified_time")
             DateTime.of_json);
        notifications =
          (OpsItemNotifications.of_json
             (Util.of_option_exn (Json.lookup j "notifications")));
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        related_ops_items =
          (RelatedOpsItems.of_json
             (Util.of_option_exn (Json.lookup j "related_ops_items")));
        status =
          (Util.option_map (Json.lookup j "status") OpsItemStatus.of_json);
        ops_item_id =
          (Util.option_map (Json.lookup j "ops_item_id") String.of_json);
        version = (Util.option_map (Json.lookup j "version") String.of_json);
        title = (Util.option_map (Json.lookup j "title") String.of_json);
        source = (Util.option_map (Json.lookup j "source") String.of_json);
        operational_data =
          (Util.option_map (Json.lookup j "operational_data")
             OpsItemOperationalData.of_json);
        category =
          (Util.option_map (Json.lookup j "category") String.of_json);
        severity =
          (Util.option_map (Json.lookup j "severity") String.of_json)
      }
  end[@@ocaml.doc
       "<p>Operations engineers and IT professionals use OpsCenter to view, investigate, and remediate operational issues impacting the performance and health of their AWS resources. For more information, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html\">AWS Systems Manager OpsCenter</a> in the <i>AWS Systems Manager User Guide</i>. </p>"]
module InventoryDeletionsList =
  struct
    type t = InventoryDeletionStatusItem.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list InventoryDeletionStatusItem.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryDeletionStatusItem.to_headers v
    let to_json v = `List (List.map InventoryDeletionStatusItem.to_json v)
    let of_json j = Json.to_list InventoryDeletionStatusItem.of_json j
  end
module DocumentPermissionType =
  struct
    type t =
      | Share 
    let str_to_t = [("Share", Share)]
    let t_to_str = [(Share, "Share")]
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
module SessionFilterList =
  struct
    type t = SessionFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list SessionFilter.to_query v
    let to_headers v = Headers.to_headers_list SessionFilter.to_headers v
    let to_json v = `List (List.map SessionFilter.to_json v)
    let of_json j = Json.to_list SessionFilter.of_json j
  end
module SessionState =
  struct
    type t =
      | Active 
      | History 
    let str_to_t = [("History", History); ("Active", Active)]
    let t_to_str = [(History, "History"); (Active, "Active")]
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
module InstanceAssociationStatusInfos =
  struct
    type t = InstanceAssociationStatusInfo.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list InstanceAssociationStatusInfo.to_query v
    let to_headers v =
      Headers.to_headers_list InstanceAssociationStatusInfo.to_headers v
    let to_json v = `List (List.map InstanceAssociationStatusInfo.to_json v)
    let of_json j = Json.to_list InstanceAssociationStatusInfo.of_json j
  end
module InventoryItemSchemaResultList =
  struct
    type t = InventoryItemSchema.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryItemSchema.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryItemSchema.to_headers v
    let to_json v = `List (List.map InventoryItemSchema.to_json v)
    let of_json j = Json.to_list InventoryItemSchema.of_json j
  end
module MaintenanceWindowExecutionTaskIdentityList =
  struct
    type t = MaintenanceWindowExecutionTaskIdentity.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list MaintenanceWindowExecutionTaskIdentity.to_query v
    let to_headers v =
      Headers.to_headers_list
        MaintenanceWindowExecutionTaskIdentity.to_headers v
    let to_json v =
      `List (List.map MaintenanceWindowExecutionTaskIdentity.to_json v)
    let of_json j =
      Json.to_list MaintenanceWindowExecutionTaskIdentity.of_json j
  end
module MaintenanceWindowIdentityList =
  struct
    type t = MaintenanceWindowIdentity.t list
    let make elems () = elems
    let to_query v = Query.to_query_list MaintenanceWindowIdentity.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowIdentity.to_headers v
    let to_json v = `List (List.map MaintenanceWindowIdentity.to_json v)
    let of_json j = Json.to_list MaintenanceWindowIdentity.of_json j
  end
module ParameterStringFilterList =
  struct
    type t = ParameterStringFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParameterStringFilter.to_query v
    let to_headers v =
      Headers.to_headers_list ParameterStringFilter.to_headers v
    let to_json v = `List (List.map ParameterStringFilter.to_json v)
    let of_json j = Json.to_list ParameterStringFilter.of_json j
  end
module ConnectionStatus =
  struct
    type t =
      | Connected 
      | NotConnected 
    let str_to_t = [("NotConnected", NotConnected); ("Connected", Connected)]
    let t_to_str = [(NotConnected, "NotConnected"); (Connected, "Connected")]
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
module AttachmentsSourceList =
  struct
    type t = AttachmentsSource.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AttachmentsSource.to_query v
    let to_headers v = Headers.to_headers_list AttachmentsSource.to_headers v
    let to_json v = `List (List.map AttachmentsSource.to_json v)
    let of_json j = Json.to_list AttachmentsSource.of_json j
  end
module ParameterNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ComplianceResourceIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ComplianceResourceTypeList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AccountIdList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AccountSharingInfoList =
  struct
    type t = AccountSharingInfo.t list[@@ocaml.doc
                                        "<p>A list of of AWS accounts where the current document is shared and the version shared with each account.</p>"]
    let make elems () = elems
    let to_query v = Query.to_query_list AccountSharingInfo.to_query v
    let to_headers v =
      Headers.to_headers_list AccountSharingInfo.to_headers v
    let to_json v = `List (List.map AccountSharingInfo.to_json v)
    let of_json j = Json.to_list AccountSharingInfo.of_json j
  end[@@ocaml.doc
       "<p>A list of of AWS accounts where the current document is shared and the version shared with each account.</p>"]
module MaintenanceWindowExecutionTaskInvocationIdentityList =
  struct
    type t = MaintenanceWindowExecutionTaskInvocationIdentity.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list
        MaintenanceWindowExecutionTaskInvocationIdentity.to_query v
    let to_headers v =
      Headers.to_headers_list
        MaintenanceWindowExecutionTaskInvocationIdentity.to_headers v
    let to_json v =
      `List
        (List.map MaintenanceWindowExecutionTaskInvocationIdentity.to_json v)
    let of_json j =
      Json.to_list MaintenanceWindowExecutionTaskInvocationIdentity.of_json j
  end
module MaintenanceWindowsForTargetList =
  struct
    type t = MaintenanceWindowIdentityForTarget.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list MaintenanceWindowIdentityForTarget.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowIdentityForTarget.to_headers v
    let to_json v =
      `List (List.map MaintenanceWindowIdentityForTarget.to_json v)
    let of_json j = Json.to_list MaintenanceWindowIdentityForTarget.of_json j
  end
module DescribeActivationsFilterList =
  struct
    type t = DescribeActivationsFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DescribeActivationsFilter.to_query v
    let to_headers v =
      Headers.to_headers_list DescribeActivationsFilter.to_headers v
    let to_json v = `List (List.map DescribeActivationsFilter.to_json v)
    let of_json j = Json.to_list DescribeActivationsFilter.of_json j
  end
module InstancePatchStateList =
  struct
    type t = InstancePatchState.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InstancePatchState.to_query v
    let to_headers v =
      Headers.to_headers_list InstancePatchState.to_headers v
    let to_json v = `List (List.map InstancePatchState.to_json v)
    let of_json j = Json.to_list InstancePatchState.of_json j
  end
module CommandInvocationList =
  struct
    type t = CommandInvocation.t list
    let make elems () = elems
    let to_query v = Query.to_query_list CommandInvocation.to_query v
    let to_headers v = Headers.to_headers_list CommandInvocation.to_headers v
    let to_json v = `List (List.map CommandInvocation.to_json v)
    let of_json j = Json.to_list CommandInvocation.of_json j
  end
module StopType =
  struct
    type t =
      | Complete 
      | Cancel 
    let str_to_t = [("Cancel", Cancel); ("Complete", Complete)]
    let t_to_str = [(Cancel, "Cancel"); (Complete, "Complete")]
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
module InventoryItemList =
  struct
    type t = InventoryItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list InventoryItem.to_query v
    let to_headers v = Headers.to_headers_list InventoryItem.to_headers v
    let to_json v = `List (List.map InventoryItem.to_json v)
    let of_json j = Json.to_list InventoryItem.of_json j
  end
module OpsItemFilters =
  struct
    type t = OpsItemFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list OpsItemFilter.to_query v
    let to_headers v = Headers.to_headers_list OpsItemFilter.to_headers v
    let to_json v = `List (List.map OpsItemFilter.to_json v)
    let of_json j = Json.to_list OpsItemFilter.of_json j
  end
module PatchGroupList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AttachmentContentList =
  struct
    type t = AttachmentContent.t list
    let make elems () = elems
    let to_query v = Query.to_query_list AttachmentContent.to_query v
    let to_headers v = Headers.to_headers_list AttachmentContent.to_headers v
    let to_json v = `List (List.map AttachmentContent.to_json v)
    let of_json j = Json.to_list AttachmentContent.of_json j
  end
module ResourceDataSyncItemList =
  struct
    type t = ResourceDataSyncItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ResourceDataSyncItem.to_query v
    let to_headers v =
      Headers.to_headers_list ResourceDataSyncItem.to_headers v
    let to_json v = `List (List.map ResourceDataSyncItem.to_json v)
    let of_json j = Json.to_list ResourceDataSyncItem.of_json j
  end
module MaintenanceWindowExecutionList =
  struct
    type t = MaintenanceWindowExecution.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list MaintenanceWindowExecution.to_query v
    let to_headers v =
      Headers.to_headers_list MaintenanceWindowExecution.to_headers v
    let to_json v = `List (List.map MaintenanceWindowExecution.to_json v)
    let of_json j = Json.to_list MaintenanceWindowExecution.of_json j
  end
module ParametersFilterList =
  struct
    type t = ParametersFilter.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ParametersFilter.to_query v
    let to_headers v = Headers.to_headers_list ParametersFilter.to_headers v
    let to_json v = `List (List.map ParametersFilter.to_json v)
    let of_json j = Json.to_list ParametersFilter.of_json j
  end
module PatchGroupPatchBaselineMappingList =
  struct
    type t = PatchGroupPatchBaselineMapping.t list
    let make elems () = elems
    let to_query v =
      Query.to_query_list PatchGroupPatchBaselineMapping.to_query v
    let to_headers v =
      Headers.to_headers_list PatchGroupPatchBaselineMapping.to_headers v
    let to_json v = `List (List.map PatchGroupPatchBaselineMapping.to_json v)
    let of_json j = Json.to_list PatchGroupPatchBaselineMapping.of_json j
  end
module PutComplianceItemsResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module GetParameterResult =
  struct
    type t =
      {
      parameter: Parameter.t option
        [@ocaml.doc "<p>Information about a parameter.</p>"]}
    let make ?parameter  () = { parameter }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameter
              (fun f -> ("parameter", (Parameter.to_json f)))])
    let of_json j =
      {
        parameter =
          (Util.option_map (Json.lookup j "parameter") Parameter.of_json)
      }
  end
module DescribeParametersResult =
  struct
    type t =
      {
      parameters: ParameterMetadataList.t
        [@ocaml.doc "<p>Parameters returned by the request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(parameters= [])  ?next_token  () = { parameters; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("parameters", (ParameterMetadataList.to_json v.parameters))])
    let of_json j =
      {
        parameters =
          (ParameterMetadataList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribePatchBaselinesResult =
  struct
    type t =
      {
      baseline_identities: PatchBaselineIdentityList.t
        [@ocaml.doc "<p>An array of PatchBaselineIdentity elements.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(baseline_identities= [])  ?next_token  () =
      { baseline_identities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("baseline_identities",
               (PatchBaselineIdentityList.to_json v.baseline_identities))])
    let of_json j =
      {
        baseline_identities =
          (PatchBaselineIdentityList.of_json
             (Util.of_option_exn (Json.lookup j "baseline_identities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module UpdateMaintenanceWindowTaskResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window that was updated.</p>"];
      window_task_id: String.t option
        [@ocaml.doc
          "<p>The task ID of the maintenance window that was updated.</p>"];
      targets: Targets.t [@ocaml.doc "<p>The updated target values.</p>"];
      task_arn: String.t option
        [@ocaml.doc "<p>The updated task ARN value.</p>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks.</p>"];
      task_parameters: MaintenanceWindowTaskParameters.t option
        [@ocaml.doc
          "<p>The updated parameter values.</p> <note> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      task_invocation_parameters:
        MaintenanceWindowTaskInvocationParameters.t option
        [@ocaml.doc "<p>The updated parameter values.</p>"];
      priority: Integer.t option
        [@ocaml.doc "<p>The updated priority value.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc "<p>The updated MaxConcurrency value.</p>"];
      max_errors: String.t option
        [@ocaml.doc "<p>The updated MaxErrors value.</p>"];
      logging_info: LoggingInfo.t option
        [@ocaml.doc
          "<p>The updated logging information in Amazon S3.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      name: String.t option [@ocaml.doc "<p>The updated task name.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The updated task description.</p>"]}
    let make ?window_id  ?window_task_id  ?(targets= [])  ?task_arn 
      ?service_role_arn  ?task_parameters  ?task_invocation_parameters 
      ?priority  ?max_concurrency  ?max_errors  ?logging_info  ?name 
      ?description  () =
      {
        window_id;
        window_task_id;
        targets;
        task_arn;
        service_role_arn;
        task_parameters;
        task_invocation_parameters;
        priority;
        max_concurrency;
        max_errors;
        logging_info;
        name;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.logging_info
             (fun f -> ("logging_info", (LoggingInfo.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Util.option_map v.task_invocation_parameters
             (fun f ->
                ("task_invocation_parameters",
                  (MaintenanceWindowTaskInvocationParameters.to_json f)));
           Util.option_map v.task_parameters
             (fun f ->
                ("task_parameters",
                  (MaintenanceWindowTaskParameters.to_json f)));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Util.option_map v.task_arn
             (fun f -> ("task_arn", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.window_task_id
             (fun f -> ("window_task_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_task_id =
          (Util.option_map (Json.lookup j "window_task_id") String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        task_arn =
          (Util.option_map (Json.lookup j "task_arn") String.of_json);
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        task_parameters =
          (Util.option_map (Json.lookup j "task_parameters")
             MaintenanceWindowTaskParameters.of_json);
        task_invocation_parameters =
          (Util.option_map (Json.lookup j "task_invocation_parameters")
             MaintenanceWindowTaskInvocationParameters.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        logging_info =
          (Util.option_map (Json.lookup j "logging_info") LoggingInfo.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json)
      }
  end
module DescribeMaintenanceWindowScheduleResult =
  struct
    type t =
      {
      scheduled_window_executions: ScheduledWindowExecutionList.t
        [@ocaml.doc
          "<p>Information about maintenance window executions scheduled for the specified time range.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You use this token in the next call.)</p>"]}
    let make ?(scheduled_window_executions= [])  ?next_token  () =
      { scheduled_window_executions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("scheduled_window_executions",
               (ScheduledWindowExecutionList.to_json
                  v.scheduled_window_executions))])
    let of_json j =
      {
        scheduled_window_executions =
          (ScheduledWindowExecutionList.of_json
             (Util.of_option_exn
                (Json.lookup j "scheduled_window_executions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetMaintenanceWindowExecutionResult =
  struct
    type t =
      {
      window_execution_id: String.t option
        [@ocaml.doc "<p>The ID of the maintenance window execution.</p>"];
      task_ids: MaintenanceWindowExecutionTaskIdList.t
        [@ocaml.doc
          "<p>The ID of the task executions from the maintenance window execution.</p>"];
      status: MaintenanceWindowExecutionStatus.t option
        [@ocaml.doc "<p>The status of the maintenance window execution.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>The details explaining the Status. Only available for certain status values.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The time the maintenance window started running.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The time the maintenance window finished running.</p>"]}
    let make ?window_execution_id  ?(task_ids= [])  ?status  ?status_details 
      ?start_time  ?end_time  () =
      {
        window_execution_id;
        task_ids;
        status;
        status_details;
        start_time;
        end_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_time
              (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f ->
                ("status", (MaintenanceWindowExecutionStatus.to_json f)));
           Some
             ("task_ids",
               (MaintenanceWindowExecutionTaskIdList.to_json v.task_ids));
           Util.option_map v.window_execution_id
             (fun f -> ("window_execution_id", (String.to_json f)))])
    let of_json j =
      {
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json);
        task_ids =
          (MaintenanceWindowExecutionTaskIdList.of_json
             (Util.of_option_exn (Json.lookup j "task_ids")));
        status =
          (Util.option_map (Json.lookup j "status")
             MaintenanceWindowExecutionStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json)
      }
  end
module GetParameterHistoryResult =
  struct
    type t =
      {
      parameters: ParameterHistoryList.t
        [@ocaml.doc "<p>A list of parameters returned by the request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(parameters= [])  ?next_token  () = { parameters; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("parameters", (ParameterHistoryList.to_json v.parameters))])
    let of_json j =
      {
        parameters =
          (ParameterHistoryList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribePatchGroupStateResult =
  struct
    type t =
      {
      instances: Integer.t option
        [@ocaml.doc "<p>The number of instances in the patch group.</p>"];
      instances_with_installed_patches: Integer.t option
        [@ocaml.doc "<p>The number of instances with installed patches.</p>"];
      instances_with_installed_other_patches: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with patches installed that aren't defined in the patch baseline.</p>"];
      instances_with_installed_pending_reboot_patches: Integer.t option
        [@ocaml.doc "<p>Reserved for future use. </p>"];
      instances_with_installed_rejected_patches: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with patches installed that are specified in a RejectedPatches list. Patches with a status of <i>INSTALLED_REJECTED</i> were typically installed before they were added to a RejectedPatches list.</p> <note> <p>If ALLOW_AS_DEPENDENCY is the specified option for RejectedPatchesAction, the value of InstancesWithInstalledRejectedPatches will always be 0 (zero).</p> </note>"];
      instances_with_missing_patches: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with missing patches from the patch baseline.</p>"];
      instances_with_failed_patches: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with patches from the patch baseline that failed to install.</p>"];
      instances_with_not_applicable_patches: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with patches that aren't applicable.</p>"];
      instances_with_unreported_not_applicable_patches: Integer.t option
        [@ocaml.doc
          "<p>The number of instances with <code>NotApplicable</code> patches beyond the supported limit, which are not reported by name to Systems Manager Inventory.</p>"]}
    let make ?instances  ?instances_with_installed_patches 
      ?instances_with_installed_other_patches 
      ?instances_with_installed_pending_reboot_patches 
      ?instances_with_installed_rejected_patches 
      ?instances_with_missing_patches  ?instances_with_failed_patches 
      ?instances_with_not_applicable_patches 
      ?instances_with_unreported_not_applicable_patches  () =
      {
        instances;
        instances_with_installed_patches;
        instances_with_installed_other_patches;
        instances_with_installed_pending_reboot_patches;
        instances_with_installed_rejected_patches;
        instances_with_missing_patches;
        instances_with_failed_patches;
        instances_with_not_applicable_patches;
        instances_with_unreported_not_applicable_patches
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map
              v.instances_with_unreported_not_applicable_patches
              (fun f ->
                 ("instances_with_unreported_not_applicable_patches",
                   (Integer.to_json f)));
           Util.option_map v.instances_with_not_applicable_patches
             (fun f ->
                ("instances_with_not_applicable_patches",
                  (Integer.to_json f)));
           Util.option_map v.instances_with_failed_patches
             (fun f -> ("instances_with_failed_patches", (Integer.to_json f)));
           Util.option_map v.instances_with_missing_patches
             (fun f ->
                ("instances_with_missing_patches", (Integer.to_json f)));
           Util.option_map v.instances_with_installed_rejected_patches
             (fun f ->
                ("instances_with_installed_rejected_patches",
                  (Integer.to_json f)));
           Util.option_map v.instances_with_installed_pending_reboot_patches
             (fun f ->
                ("instances_with_installed_pending_reboot_patches",
                  (Integer.to_json f)));
           Util.option_map v.instances_with_installed_other_patches
             (fun f ->
                ("instances_with_installed_other_patches",
                  (Integer.to_json f)));
           Util.option_map v.instances_with_installed_patches
             (fun f ->
                ("instances_with_installed_patches", (Integer.to_json f)));
           Util.option_map v.instances
             (fun f -> ("instances", (Integer.to_json f)))])
    let of_json j =
      {
        instances =
          (Util.option_map (Json.lookup j "instances") Integer.of_json);
        instances_with_installed_patches =
          (Util.option_map (Json.lookup j "instances_with_installed_patches")
             Integer.of_json);
        instances_with_installed_other_patches =
          (Util.option_map
             (Json.lookup j "instances_with_installed_other_patches")
             Integer.of_json);
        instances_with_installed_pending_reboot_patches =
          (Util.option_map
             (Json.lookup j "instances_with_installed_pending_reboot_patches")
             Integer.of_json);
        instances_with_installed_rejected_patches =
          (Util.option_map
             (Json.lookup j "instances_with_installed_rejected_patches")
             Integer.of_json);
        instances_with_missing_patches =
          (Util.option_map (Json.lookup j "instances_with_missing_patches")
             Integer.of_json);
        instances_with_failed_patches =
          (Util.option_map (Json.lookup j "instances_with_failed_patches")
             Integer.of_json);
        instances_with_not_applicable_patches =
          (Util.option_map
             (Json.lookup j "instances_with_not_applicable_patches")
             Integer.of_json);
        instances_with_unreported_not_applicable_patches =
          (Util.option_map
             (Json.lookup j
                "instances_with_unreported_not_applicable_patches")
             Integer.of_json)
      }
  end
module DescribeInstanceInformationResult =
  struct
    type t =
      {
      instance_information_list: InstanceInformationList.t
        [@ocaml.doc "<p>The instance information list.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty. </p>"]}
    let make ?(instance_information_list= [])  ?next_token  () =
      { instance_information_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("instance_information_list",
               (InstanceInformationList.to_json v.instance_information_list))])
    let of_json j =
      {
        instance_information_list =
          (InstanceInformationList.of_json
             (Util.of_option_exn (Json.lookup j "instance_information_list")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ListDocumentVersionsResult =
  struct
    type t =
      {
      document_versions: DocumentVersionList.t
        [@ocaml.doc "<p>The document versions.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(document_versions= [])  ?next_token  () =
      { document_versions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("document_versions",
               (DocumentVersionList.to_json v.document_versions))])
    let of_json j =
      {
        document_versions =
          (DocumentVersionList.of_json
             (Util.of_option_exn (Json.lookup j "document_versions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetMaintenanceWindowExecutionTaskInvocationResult =
  struct
    type t =
      {
      window_execution_id: String.t option
        [@ocaml.doc "<p>The maintenance window execution ID.</p>"];
      task_execution_id: String.t option
        [@ocaml.doc "<p>The task execution ID.</p>"];
      invocation_id: String.t option [@ocaml.doc "<p>The invocation ID.</p>"];
      execution_id: String.t option [@ocaml.doc "<p>The execution ID.</p>"];
      task_type: MaintenanceWindowTaskType.t option
        [@ocaml.doc
          "<p>Retrieves the task type for a maintenance window. Task types include the following: LAMBDA, STEP_FUNCTIONS, AUTOMATION, RUN_COMMAND.</p>"];
      parameters: String.t option
        [@ocaml.doc
          "<p>The parameters used at the time that the task ran.</p>"];
      status: MaintenanceWindowExecutionStatus.t option
        [@ocaml.doc "<p>The task status for an invocation.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>The details explaining the status. Details are only available for certain status values.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc
          "<p>The time that the task started running on the target.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc
          "<p>The time that the task finished running on the target.</p>"];
      owner_information: String.t option
        [@ocaml.doc
          "<p>User-provided value to be included in any CloudWatch events raised while running tasks for these targets in this maintenance window. </p>"];
      window_target_id: String.t option
        [@ocaml.doc "<p>The maintenance window target ID.</p>"]}
    let make ?window_execution_id  ?task_execution_id  ?invocation_id 
      ?execution_id  ?task_type  ?parameters  ?status  ?status_details 
      ?start_time  ?end_time  ?owner_information  ?window_target_id  () =
      {
        window_execution_id;
        task_execution_id;
        invocation_id;
        execution_id;
        task_type;
        parameters;
        status;
        status_details;
        start_time;
        end_time;
        owner_information;
        window_target_id
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_target_id
              (fun f -> ("window_target_id", (String.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Util.option_map v.end_time
             (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f ->
                ("status", (MaintenanceWindowExecutionStatus.to_json f)));
           Util.option_map v.parameters
             (fun f -> ("parameters", (String.to_json f)));
           Util.option_map v.task_type
             (fun f -> ("task_type", (MaintenanceWindowTaskType.to_json f)));
           Util.option_map v.execution_id
             (fun f -> ("execution_id", (String.to_json f)));
           Util.option_map v.invocation_id
             (fun f -> ("invocation_id", (String.to_json f)));
           Util.option_map v.task_execution_id
             (fun f -> ("task_execution_id", (String.to_json f)));
           Util.option_map v.window_execution_id
             (fun f -> ("window_execution_id", (String.to_json f)))])
    let of_json j =
      {
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json);
        task_execution_id =
          (Util.option_map (Json.lookup j "task_execution_id") String.of_json);
        invocation_id =
          (Util.option_map (Json.lookup j "invocation_id") String.of_json);
        execution_id =
          (Util.option_map (Json.lookup j "execution_id") String.of_json);
        task_type =
          (Util.option_map (Json.lookup j "task_type")
             MaintenanceWindowTaskType.of_json);
        parameters =
          (Util.option_map (Json.lookup j "parameters") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             MaintenanceWindowExecutionStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json);
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        window_target_id =
          (Util.option_map (Json.lookup j "window_target_id") String.of_json)
      }
  end
module UpdateMaintenanceWindowTargetResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc
          "<p>The maintenance window ID specified in the update request.</p>"];
      window_target_id: String.t option
        [@ocaml.doc "<p>The target ID specified in the update request.</p>"];
      targets: Targets.t [@ocaml.doc "<p>The updated targets.</p>"];
      owner_information: String.t option
        [@ocaml.doc "<p>The updated owner.</p>"];
      name: String.t option [@ocaml.doc "<p>The updated name.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The updated description.</p>"]}
    let make ?window_id  ?window_target_id  ?(targets= []) 
      ?owner_information  ?name  ?description  () =
      {
        window_id;
        window_target_id;
        targets;
        owner_information;
        name;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.owner_information
             (fun f -> ("owner_information", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.window_target_id
             (fun f -> ("window_target_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_target_id =
          (Util.option_map (Json.lookup j "window_target_id") String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        owner_information =
          (Util.option_map (Json.lookup j "owner_information") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json)
      }
  end
module GetServiceSettingResult =
  struct
    type t =
      {
      service_setting: ServiceSetting.t option
        [@ocaml.doc
          "<p>The query result of the current service setting.</p>"]}
    [@@ocaml.doc
      "<p>The query result body of the GetServiceSetting API action.</p>"]
    let make ?service_setting  () = { service_setting }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.service_setting
              (fun f -> ("service_setting", (ServiceSetting.to_json f)))])
    let of_json j =
      {
        service_setting =
          (Util.option_map (Json.lookup j "service_setting")
             ServiceSetting.of_json)
      }
  end[@@ocaml.doc
       "<p>The query result body of the GetServiceSetting API action.</p>"]
module DeleteResourceDataSyncResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeAssociationResult =
  struct
    type t =
      {
      association_description: AssociationDescription.t option
        [@ocaml.doc "<p>Information about the association.</p>"]}
    let make ?association_description  () = { association_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_description
              (fun f ->
                 ("association_description",
                   (AssociationDescription.to_json f)))])
    let of_json j =
      {
        association_description =
          (Util.option_map (Json.lookup j "association_description")
             AssociationDescription.of_json)
      }
  end
module DescribeAutomationExecutionsResult =
  struct
    type t =
      {
      automation_execution_metadata_list: AutomationExecutionMetadataList.t
        [@ocaml.doc
          "<p>The list of details about each automation execution which has occurred which matches the filter specification, if any.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(automation_execution_metadata_list= [])  ?next_token  () =
      { automation_execution_metadata_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("automation_execution_metadata_list",
               (AutomationExecutionMetadataList.to_json
                  v.automation_execution_metadata_list))])
    let of_json j =
      {
        automation_execution_metadata_list =
          (AutomationExecutionMetadataList.of_json
             (Util.of_option_exn
                (Json.lookup j "automation_execution_metadata_list")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ListDocumentsResult =
  struct
    type t =
      {
      document_identifiers: DocumentIdentifierList.t
        [@ocaml.doc "<p>The names of the Systems Manager documents.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(document_identifiers= [])  ?next_token  () =
      { document_identifiers; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("document_identifiers",
               (DocumentIdentifierList.to_json v.document_identifiers))])
    let of_json j =
      {
        document_identifiers =
          (DocumentIdentifierList.of_json
             (Util.of_option_exn (Json.lookup j "document_identifiers")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module AddTagsToResourceResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module StartAssociationsOnceResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module UpdateMaintenanceWindowResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the created maintenance window.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the maintenance window.</p>"];
      description: String.t option
        [@ocaml.doc "<p>An optional description of the update.</p>"];
      start_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become active. The maintenance window will not run before this specified time.</p>"];
      end_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become inactive. The maintenance window will not run after this specified time.</p>"];
      schedule: String.t option
        [@ocaml.doc
          "<p>The schedule of the maintenance window in the form of a cron or rate expression.</p>"];
      schedule_timezone: String.t option
        [@ocaml.doc
          "<p>The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. For example: \"America/Los_Angeles\", \"etc/UTC\", or \"Asia/Seoul\". For more information, see the <a href=\"https://www.iana.org/time-zones\">Time Zone Database</a> on the IANA website.</p>"];
      duration: Integer.t option
        [@ocaml.doc
          "<p>The duration of the maintenance window in hours.</p>"];
      cutoff: Integer.t option
        [@ocaml.doc
          "<p>The number of hours before the end of the maintenance window that Systems Manager stops scheduling new tasks for execution.</p>"];
      allow_unassociated_targets: Boolean.t option
        [@ocaml.doc
          "<p>Whether targets must be registered with the maintenance window before tasks can be defined for those targets.</p>"];
      enabled: Boolean.t option
        [@ocaml.doc "<p>Whether the maintenance window is enabled.</p>"]}
    let make ?window_id  ?name  ?description  ?start_date  ?end_date 
      ?schedule  ?schedule_timezone  ?duration  ?cutoff 
      ?allow_unassociated_targets  ?enabled  () =
      {
        window_id;
        name;
        description;
        start_date;
        end_date;
        schedule;
        schedule_timezone;
        duration;
        cutoff;
        allow_unassociated_targets;
        enabled
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.enabled
              (fun f -> ("enabled", (Boolean.to_json f)));
           Util.option_map v.allow_unassociated_targets
             (fun f -> ("allow_unassociated_targets", (Boolean.to_json f)));
           Util.option_map v.cutoff
             (fun f -> ("cutoff", (Integer.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.schedule_timezone
             (fun f -> ("schedule_timezone", (String.to_json f)));
           Util.option_map v.schedule
             (fun f -> ("schedule", (String.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (String.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        start_date =
          (Util.option_map (Json.lookup j "start_date") String.of_json);
        end_date =
          (Util.option_map (Json.lookup j "end_date") String.of_json);
        schedule =
          (Util.option_map (Json.lookup j "schedule") String.of_json);
        schedule_timezone =
          (Util.option_map (Json.lookup j "schedule_timezone") String.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        cutoff = (Util.option_map (Json.lookup j "cutoff") Integer.of_json);
        allow_unassociated_targets =
          (Util.option_map (Json.lookup j "allow_unassociated_targets")
             Boolean.of_json);
        enabled = (Util.option_map (Json.lookup j "enabled") Boolean.of_json)
      }
  end
module DeleteActivationResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateDocumentResult =
  struct
    type t =
      {
      document_description: DocumentDescription.t option
        [@ocaml.doc "<p>Information about the Systems Manager document.</p>"]}
    let make ?document_description  () = { document_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.document_description
              (fun f ->
                 ("document_description", (DocumentDescription.to_json f)))])
    let of_json j =
      {
        document_description =
          (Util.option_map (Json.lookup j "document_description")
             DocumentDescription.of_json)
      }
  end
module DeleteDocumentResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateAssociationResult =
  struct
    type t =
      {
      association_description: AssociationDescription.t option
        [@ocaml.doc "<p>Information about the association.</p>"]}
    let make ?association_description  () = { association_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_description
              (fun f ->
                 ("association_description",
                   (AssociationDescription.to_json f)))])
    let of_json j =
      {
        association_description =
          (Util.option_map (Json.lookup j "association_description")
             AssociationDescription.of_json)
      }
  end
module DeregisterTaskFromMaintenanceWindowResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window the task was removed from.</p>"];
      window_task_id: String.t option
        [@ocaml.doc
          "<p>The ID of the task removed from the maintenance window.</p>"]}
    let make ?window_id  ?window_task_id  () = { window_id; window_task_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_task_id
              (fun f -> ("window_task_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_task_id =
          (Util.option_map (Json.lookup j "window_task_id") String.of_json)
      }
  end
module GetAutomationExecutionResult =
  struct
    type t =
      {
      automation_execution: AutomationExecution.t option
        [@ocaml.doc
          "<p>Detailed information about the current state of an automation execution.</p>"]}
    let make ?automation_execution  () = { automation_execution }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.automation_execution
              (fun f ->
                 ("automation_execution", (AutomationExecution.to_json f)))])
    let of_json j =
      {
        automation_execution =
          (Util.option_map (Json.lookup j "automation_execution")
             AutomationExecution.of_json)
      }
  end
module UpdateManagedInstanceRoleResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module UpdateDocumentDefaultVersionResult =
  struct
    type t =
      {
      description: DocumentDefaultVersionDescription.t option
        [@ocaml.doc
          "<p>The description of a custom document that you want to set as the default version.</p>"]}
    let make ?description  () = { description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f ->
                 ("description",
                   (DocumentDefaultVersionDescription.to_json f)))])
    let of_json j =
      {
        description =
          (Util.option_map (Json.lookup j "description")
             DocumentDefaultVersionDescription.of_json)
      }
  end
module ResumeSessionResponse =
  struct
    type t =
      {
      session_id: String.t option
        [@ocaml.doc "<p>The ID of the session.</p>"];
      token_value: String.t option
        [@ocaml.doc
          "<p>An encrypted token value containing session and caller information. Used to authenticate the connection to the instance.</p>"];
      stream_url: String.t option
        [@ocaml.doc
          "<p>A URL back to SSM Agent on the instance that the Session Manager client uses to send commands and receive output from the instance. Format: <code>wss://ssmmessages.<b>region</b>.amazonaws.com/v1/data-channel/<b>session-id</b>?stream=(input|output)</code>.</p> <p> <b>region</b> represents the Region identifier for an AWS Region supported by AWS Systems Manager, such as <code>us-east-2</code> for the US East (Ohio) Region. For a list of supported <b>region</b> values, see the <b>Region</b> column in <a href=\"http://docs.aws.amazon.com/general/latest/gr/ssm.html#ssm_region\">Systems Manager Service Endpoints</a> in the <i>AWS General Reference</i>.</p> <p> <b>session-id</b> represents the ID of a Session Manager session, such as <code>1a2b3c4dEXAMPLE</code>.</p>"]}
    let make ?session_id  ?token_value  ?stream_url  () =
      { session_id; token_value; stream_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stream_url
              (fun f -> ("stream_url", (String.to_json f)));
           Util.option_map v.token_value
             (fun f -> ("token_value", (String.to_json f)));
           Util.option_map v.session_id
             (fun f -> ("session_id", (String.to_json f)))])
    let of_json j =
      {
        session_id =
          (Util.option_map (Json.lookup j "session_id") String.of_json);
        token_value =
          (Util.option_map (Json.lookup j "token_value") String.of_json);
        stream_url =
          (Util.option_map (Json.lookup j "stream_url") String.of_json)
      }
  end
module GetOpsSummaryResult =
  struct
    type t =
      {
      entities: OpsEntityList.t
        [@ocaml.doc "<p>The list of aggregated and filtered OpsItems.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(entities= [])  ?next_token  () = { entities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("entities", (OpsEntityList.to_json v.entities))])
    let of_json j =
      {
        entities =
          (OpsEntityList.of_json
             (Util.of_option_exn (Json.lookup j "entities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module CreateActivationResult =
  struct
    type t =
      {
      activation_id: String.t option
        [@ocaml.doc
          "<p>The ID number generated by the system when it processed the activation. The activation ID functions like a user name.</p>"];
      activation_code: String.t option
        [@ocaml.doc
          "<p>The code the system generates when it processes the activation. The activation code functions like a password to validate the activation ID. </p>"]}
    let make ?activation_id  ?activation_code  () =
      { activation_id; activation_code }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.activation_code
              (fun f -> ("activation_code", (String.to_json f)));
           Util.option_map v.activation_id
             (fun f -> ("activation_id", (String.to_json f)))])
    let of_json j =
      {
        activation_id =
          (Util.option_map (Json.lookup j "activation_id") String.of_json);
        activation_code =
          (Util.option_map (Json.lookup j "activation_code") String.of_json)
      }
  end
module RegisterTaskWithMaintenanceWindowResult =
  struct
    type t =
      {
      window_task_id: String.t option
        [@ocaml.doc "<p>The ID of the task in the maintenance window.</p>"]}
    let make ?window_task_id  () = { window_task_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_task_id
              (fun f -> ("window_task_id", (String.to_json f)))])
    let of_json j =
      {
        window_task_id =
          (Util.option_map (Json.lookup j "window_task_id") String.of_json)
      }
  end
module TerminateSessionResponse =
  struct
    type t =
      {
      session_id: String.t option
        [@ocaml.doc "<p>The ID of the session that has been terminated.</p>"]}
    let make ?session_id  () = { session_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.session_id
              (fun f -> ("session_id", (String.to_json f)))])
    let of_json j =
      {
        session_id =
          (Util.option_map (Json.lookup j "session_id") String.of_json)
      }
  end
module CancelMaintenanceWindowExecutionResult =
  struct
    type t =
      {
      window_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window execution that has been stopped.</p>"]}
    let make ?window_execution_id  () = { window_execution_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_execution_id
              (fun f -> ("window_execution_id", (String.to_json f)))])
    let of_json j =
      {
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json)
      }
  end
module UpdateAssociationResult =
  struct
    type t =
      {
      association_description: AssociationDescription.t option
        [@ocaml.doc
          "<p>The description of the association that was updated.</p>"]}
    let make ?association_description  () = { association_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_description
              (fun f ->
                 ("association_description",
                   (AssociationDescription.to_json f)))])
    let of_json j =
      {
        association_description =
          (Util.option_map (Json.lookup j "association_description")
             AssociationDescription.of_json)
      }
  end
module RegisterPatchBaselineForPatchGroupResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc
          "<p>The ID of the patch baseline the patch group was registered with.</p>"];
      patch_group: String.t option
        [@ocaml.doc
          "<p>The name of the patch group registered with the patch baseline.</p>"]}
    let make ?baseline_id  ?patch_group  () = { baseline_id; patch_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.patch_group
              (fun f -> ("patch_group", (String.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        patch_group =
          (Util.option_map (Json.lookup j "patch_group") String.of_json)
      }
  end
module ListAssociationsResult =
  struct
    type t =
      {
      associations: AssociationList.t [@ocaml.doc "<p>The associations.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(associations= [])  ?next_token  () =
      { associations; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("associations", (AssociationList.to_json v.associations))])
    let of_json j =
      {
        associations =
          (AssociationList.of_json
             (Util.of_option_exn (Json.lookup j "associations")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module OpsItemParameterNamesList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module PutInventoryResult =
  struct
    type t =
      {
      message: String.t option
        [@ocaml.doc "<p>Information about the request.</p>"]}
    let make ?message  () = { message }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)))])
    let of_json j =
      { message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module CancelCommandResult =
  struct
    type t = unit[@@ocaml.doc
                   "<p>Whether or not the command was successfully canceled. There is no guarantee that a request can be canceled.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>Whether or not the command was successfully canceled. There is no guarantee that a request can be canceled.</p>"]
module DescribeSessionsResponse =
  struct
    type t =
      {
      sessions: SessionList.t
        [@ocaml.doc
          "<p>A list of sessions meeting the request parameters.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ?(sessions= [])  ?next_token  () = { sessions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("sessions", (SessionList.to_json v.sessions))])
    let of_json j =
      {
        sessions =
          (SessionList.of_json
             (Util.of_option_exn (Json.lookup j "sessions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module UpdateDocumentResult =
  struct
    type t =
      {
      document_description: DocumentDescription.t option
        [@ocaml.doc "<p>A description of the document that was updated.</p>"]}
    let make ?document_description  () = { document_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.document_description
              (fun f ->
                 ("document_description", (DocumentDescription.to_json f)))])
    let of_json j =
      {
        document_description =
          (Util.option_map (Json.lookup j "document_description")
             DocumentDescription.of_json)
      }
  end
module DescribeActivationsResult =
  struct
    type t =
      {
      activation_list: ActivationList.t
        [@ocaml.doc "<p>A list of activations for your AWS account.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results. </p>"]}
    let make ?(activation_list= [])  ?next_token  () =
      { activation_list; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("activation_list", (ActivationList.to_json v.activation_list))])
    let of_json j =
      {
        activation_list =
          (ActivationList.of_json
             (Util.of_option_exn (Json.lookup j "activation_list")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ListComplianceItemsResult =
  struct
    type t =
      {
      compliance_items: ComplianceItemList.t
        [@ocaml.doc
          "<p>A list of compliance information for the specified resource ID. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(compliance_items= [])  ?next_token  () =
      { compliance_items; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("compliance_items",
               (ComplianceItemList.to_json v.compliance_items))])
    let of_json j =
      {
        compliance_items =
          (ComplianceItemList.of_json
             (Util.of_option_exn (Json.lookup j "compliance_items")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeMaintenanceWindowTasksResult =
  struct
    type t =
      {
      tasks: MaintenanceWindowTaskList.t
        [@ocaml.doc
          "<p>Information about the tasks in the maintenance window.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(tasks= [])  ?next_token  () = { tasks; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("tasks", (MaintenanceWindowTaskList.to_json v.tasks))])
    let of_json j =
      {
        tasks =
          (MaintenanceWindowTaskList.of_json
             (Util.of_option_exn (Json.lookup j "tasks")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetInventoryResult =
  struct
    type t =
      {
      entities: InventoryResultEntityList.t
        [@ocaml.doc
          "<p>Collection of inventory entities such as a collection of instance inventory. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(entities= [])  ?next_token  () = { entities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("entities", (InventoryResultEntityList.to_json v.entities))])
    let of_json j =
      {
        entities =
          (InventoryResultEntityList.of_json
             (Util.of_option_exn (Json.lookup j "entities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module UpdateResourceDataSyncResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeEffectiveInstanceAssociationsResult =
  struct
    type t =
      {
      associations: InstanceAssociationList.t
        [@ocaml.doc "<p>The associations for the requested instance.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(associations= [])  ?next_token  () =
      { associations; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("associations",
               (InstanceAssociationList.to_json v.associations))])
    let of_json j =
      {
        associations =
          (InstanceAssociationList.of_json
             (Util.of_option_exn (Json.lookup j "associations")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribePatchPropertiesResult =
  struct
    type t =
      {
      properties: PatchPropertiesList.t
        [@ocaml.doc
          "<p>A list of the properties for patches matching the filter request parameters.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You use this token in the next call.)</p>"]}
    let make ?(properties= [])  ?next_token  () = { properties; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("properties", (PatchPropertiesList.to_json v.properties))])
    let of_json j =
      {
        properties =
          (PatchPropertiesList.of_json
             (Util.of_option_exn (Json.lookup j "properties")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeDocumentResult =
  struct
    type t =
      {
      document: DocumentDescription.t option
        [@ocaml.doc "<p>Information about the Systems Manager document.</p>"]}
    let make ?document  () = { document }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.document
              (fun f -> ("document", (DocumentDescription.to_json f)))])
    let of_json j =
      {
        document =
          (Util.option_map (Json.lookup j "document")
             DocumentDescription.of_json)
      }
  end
module CreateMaintenanceWindowResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the created maintenance window.</p>"]}
    let make ?window_id  () = { window_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_id
              (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json)
      }
  end
module ListResourceComplianceSummariesResult =
  struct
    type t =
      {
      resource_compliance_summary_items: ResourceComplianceSummaryItemList.t
        [@ocaml.doc
          "<p>A summary count for specified or targeted managed instances. Summary count includes information about compliant and non-compliant State Manager associations, patch status, or custom items according to the filter criteria that you specify. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(resource_compliance_summary_items= [])  ?next_token  () =
      { resource_compliance_summary_items; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("resource_compliance_summary_items",
               (ResourceComplianceSummaryItemList.to_json
                  v.resource_compliance_summary_items))])
    let of_json j =
      {
        resource_compliance_summary_items =
          (ResourceComplianceSummaryItemList.of_json
             (Util.of_option_exn
                (Json.lookup j "resource_compliance_summary_items")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DeleteMaintenanceWindowResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the deleted maintenance window.</p>"]}
    let make ?window_id  () = { window_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_id
              (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json)
      }
  end
module DeregisterTargetFromMaintenanceWindowResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window the target was removed from.</p>"];
      window_target_id: String.t option
        [@ocaml.doc "<p>The ID of the removed target definition.</p>"]}
    let make ?window_id  ?window_target_id  () =
      { window_id; window_target_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_target_id
              (fun f -> ("window_target_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_target_id =
          (Util.option_map (Json.lookup j "window_target_id") String.of_json)
      }
  end
module DescribeAssociationExecutionTargetsResult =
  struct
    type t =
      {
      association_execution_targets: AssociationExecutionTargetsList.t
        [@ocaml.doc "<p>Information about the execution.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(association_execution_targets= [])  ?next_token  () =
      { association_execution_targets; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("association_execution_targets",
               (AssociationExecutionTargetsList.to_json
                  v.association_execution_targets))])
    let of_json j =
      {
        association_execution_targets =
          (AssociationExecutionTargetsList.of_json
             (Util.of_option_exn
                (Json.lookup j "association_execution_targets")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeAssociationExecutionsResult =
  struct
    type t =
      {
      association_executions: AssociationExecutionsList.t
        [@ocaml.doc
          "<p>A list of the executions for the specified association ID.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(association_executions= [])  ?next_token  () =
      { association_executions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("association_executions",
               (AssociationExecutionsList.to_json v.association_executions))])
    let of_json j =
      {
        association_executions =
          (AssociationExecutionsList.of_json
             (Util.of_option_exn (Json.lookup j "association_executions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module UpdateServiceSettingResult =
  struct
    type t = unit[@@ocaml.doc
                   "<p>The result body of the UpdateServiceSetting API action.</p>"]
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end[@@ocaml.doc
       "<p>The result body of the UpdateServiceSetting API action.</p>"]
module GetParametersByPathResult =
  struct
    type t =
      {
      parameters: ParameterList.t
        [@ocaml.doc
          "<p>A list of parameters found in the specified hierarchy.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(parameters= [])  ?next_token  () = { parameters; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("parameters", (ParameterList.to_json v.parameters))])
    let of_json j =
      {
        parameters =
          (ParameterList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeInstancePatchStatesForPatchGroupResult =
  struct
    type t =
      {
      instance_patch_states: InstancePatchStatesList.t
        [@ocaml.doc
          "<p>The high-level patch state for the requested instances. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(instance_patch_states= [])  ?next_token  () =
      { instance_patch_states; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("instance_patch_states",
               (InstancePatchStatesList.to_json v.instance_patch_states))])
    let of_json j =
      {
        instance_patch_states =
          (InstancePatchStatesList.of_json
             (Util.of_option_exn (Json.lookup j "instance_patch_states")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ListCommandsResult =
  struct
    type t =
      {
      commands: CommandList.t
        [@ocaml.doc
          "<p>(Optional) The list of commands requested by the user. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>(Optional) The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ?(commands= [])  ?next_token  () = { commands; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("commands", (CommandList.to_json v.commands))])
    let of_json j =
      {
        commands =
          (CommandList.of_json
             (Util.of_option_exn (Json.lookup j "commands")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DeregisterManagedInstanceResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateResourceDataSyncResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module UpdateAssociationStatusResult =
  struct
    type t =
      {
      association_description: AssociationDescription.t option
        [@ocaml.doc "<p>Information about the association.</p>"]}
    let make ?association_description  () = { association_description }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.association_description
              (fun f ->
                 ("association_description",
                   (AssociationDescription.to_json f)))])
    let of_json j =
      {
        association_description =
          (Util.option_map (Json.lookup j "association_description")
             AssociationDescription.of_json)
      }
  end
module DescribeMaintenanceWindowTargetsResult =
  struct
    type t =
      {
      targets: MaintenanceWindowTargetList.t
        [@ocaml.doc
          "<p>Information about the targets in the maintenance window.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(targets= [])  ?next_token  () = { targets; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("targets", (MaintenanceWindowTargetList.to_json v.targets))])
    let of_json j =
      {
        targets =
          (MaintenanceWindowTargetList.of_json
             (Util.of_option_exn (Json.lookup j "targets")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeOpsItemsResponse =
  struct
    type t =
      {
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"];
      ops_item_summaries: OpsItemSummaries.t
        [@ocaml.doc "<p>A list of OpsItems.</p>"]}
    let make ?next_token  ?(ops_item_summaries= [])  () =
      { next_token; ops_item_summaries }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("ops_item_summaries",
                (OpsItemSummaries.to_json v.ops_item_summaries));
           Util.option_map v.next_token
             (fun f -> ("next_token", (String.to_json f)))])
    let of_json j =
      {
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json);
        ops_item_summaries =
          (OpsItemSummaries.of_json
             (Util.of_option_exn (Json.lookup j "ops_item_summaries")))
      }
  end
module UpdatePatchBaselineResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the deleted patch baseline.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the patch baseline.</p>"];
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>The operating system rule used by the updated patch baseline.</p>"];
      global_filters: PatchFilterGroup.t option
        [@ocaml.doc
          "<p>A set of global filters used to exclude patches from the baseline.</p>"];
      approval_rules: PatchRuleGroup.t option
        [@ocaml.doc
          "<p>A set of rules used to include patches in the baseline.</p>"];
      approved_patches: PatchIdList.t
        [@ocaml.doc
          "<p>A list of explicitly approved patches for the baseline.</p>"];
      approved_patches_compliance_level: PatchComplianceLevel.t option
        [@ocaml.doc
          "<p>The compliance severity level assigned to the patch baseline after the update completed.</p>"];
      approved_patches_enable_non_security: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the list of approved patches includes non-security updates that should be applied to the instances. The default value is 'false'. Applies to Linux instances only.</p>"];
      rejected_patches: PatchIdList.t
        [@ocaml.doc
          "<p>A list of explicitly rejected patches for the baseline.</p>"];
      rejected_patches_action: PatchAction.t option
        [@ocaml.doc
          "<p>The action specified to take on patches included in the RejectedPatches list. A patch can be allowed only if it is a dependency of another package, or blocked entirely along with packages that include it as a dependency.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date when the patch baseline was created.</p>"];
      modified_date: DateTime.t option
        [@ocaml.doc
          "<p>The date when the patch baseline was last modified.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the Patch Baseline.</p>"];
      sources: PatchSourceList.t
        [@ocaml.doc
          "<p>Information about the patches to use to update the instances, including target operating systems and source repositories. Applies to Linux instances only.</p>"]}
    let make ?baseline_id  ?name  ?operating_system  ?global_filters 
      ?approval_rules  ?(approved_patches= []) 
      ?approved_patches_compliance_level 
      ?approved_patches_enable_non_security  ?(rejected_patches= []) 
      ?rejected_patches_action  ?created_date  ?modified_date  ?description 
      ?(sources= [])  () =
      {
        baseline_id;
        name;
        operating_system;
        global_filters;
        approval_rules;
        approved_patches;
        approved_patches_compliance_level;
        approved_patches_enable_non_security;
        rejected_patches;
        rejected_patches_action;
        created_date;
        modified_date;
        description;
        sources
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("sources", (PatchSourceList.to_json v.sources));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.modified_date
             (fun f -> ("modified_date", (DateTime.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.rejected_patches_action
             (fun f -> ("rejected_patches_action", (PatchAction.to_json f)));
           Some
             ("rejected_patches", (PatchIdList.to_json v.rejected_patches));
           Util.option_map v.approved_patches_enable_non_security
             (fun f ->
                ("approved_patches_enable_non_security", (Boolean.to_json f)));
           Util.option_map v.approved_patches_compliance_level
             (fun f ->
                ("approved_patches_compliance_level",
                  (PatchComplianceLevel.to_json f)));
           Some
             ("approved_patches", (PatchIdList.to_json v.approved_patches));
           Util.option_map v.approval_rules
             (fun f -> ("approval_rules", (PatchRuleGroup.to_json f)));
           Util.option_map v.global_filters
             (fun f -> ("global_filters", (PatchFilterGroup.to_json f)));
           Util.option_map v.operating_system
             (fun f -> ("operating_system", (OperatingSystem.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json);
        global_filters =
          (Util.option_map (Json.lookup j "global_filters")
             PatchFilterGroup.of_json);
        approval_rules =
          (Util.option_map (Json.lookup j "approval_rules")
             PatchRuleGroup.of_json);
        approved_patches =
          (PatchIdList.of_json
             (Util.of_option_exn (Json.lookup j "approved_patches")));
        approved_patches_compliance_level =
          (Util.option_map
             (Json.lookup j "approved_patches_compliance_level")
             PatchComplianceLevel.of_json);
        approved_patches_enable_non_security =
          (Util.option_map
             (Json.lookup j "approved_patches_enable_non_security")
             Boolean.of_json);
        rejected_patches =
          (PatchIdList.of_json
             (Util.of_option_exn (Json.lookup j "rejected_patches")));
        rejected_patches_action =
          (Util.option_map (Json.lookup j "rejected_patches_action")
             PatchAction.of_json);
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        modified_date =
          (Util.option_map (Json.lookup j "modified_date") DateTime.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        sources =
          (PatchSourceList.of_json
             (Util.of_option_exn (Json.lookup j "sources")))
      }
  end
module SendAutomationSignalResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeAutomationStepExecutionsResult =
  struct
    type t =
      {
      step_executions: StepExecutionList.t
        [@ocaml.doc
          "<p>A list of details about the current state of all steps that make up an execution.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(step_executions= [])  ?next_token  () =
      { step_executions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("step_executions",
               (StepExecutionList.to_json v.step_executions))])
    let of_json j =
      {
        step_executions =
          (StepExecutionList.of_json
             (Util.of_option_exn (Json.lookup j "step_executions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetMaintenanceWindowTaskResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The retrieved maintenance window ID.</p>"];
      window_task_id: String.t option
        [@ocaml.doc "<p>The retrieved maintenance window task ID.</p>"];
      targets: Targets.t
        [@ocaml.doc "<p>The targets where the task should run.</p>"];
      task_arn: String.t option
        [@ocaml.doc
          "<p>The resource that the task used during execution. For RUN_COMMAND and AUTOMATION task types, the TaskArn is the Systems Manager Document name/ARN. For LAMBDA tasks, the value is the function name/ARN. For STEP_FUNCTIONS tasks, the value is the state machine ARN.</p>"];
      service_role_arn: String.t option
        [@ocaml.doc
          "<p>The ARN of the IAM service role to use to publish Amazon Simple Notification Service (Amazon SNS) notifications for maintenance window Run Command tasks.</p>"];
      task_type: MaintenanceWindowTaskType.t option
        [@ocaml.doc "<p>The type of task to run.</p>"];
      task_parameters: MaintenanceWindowTaskParameters.t option
        [@ocaml.doc
          "<p>The parameters to pass to the task when it runs.</p> <note> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      task_invocation_parameters:
        MaintenanceWindowTaskInvocationParameters.t option
        [@ocaml.doc
          "<p>The parameters to pass to the task when it runs.</p>"];
      priority: Integer.t option
        [@ocaml.doc
          "<p>The priority of the task when it runs. The lower the number, the higher the priority. Tasks that have the same priority are scheduled in parallel.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The maximum number of targets allowed to run this task in parallel.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The maximum number of errors allowed before the task stops being scheduled.</p>"];
      logging_info: LoggingInfo.t option
        [@ocaml.doc
          "<p>The location in Amazon S3 where the task results are logged.</p> <note> <p> <code>LoggingInfo</code> has been deprecated. To specify an S3 bucket to contain logs, instead use the <code>OutputS3BucketName</code> and <code>OutputS3KeyPrefix</code> options in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note>"];
      name: String.t option [@ocaml.doc "<p>The retrieved task name.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The retrieved task description.</p>"]}
    let make ?window_id  ?window_task_id  ?(targets= [])  ?task_arn 
      ?service_role_arn  ?task_type  ?task_parameters 
      ?task_invocation_parameters  ?priority  ?max_concurrency  ?max_errors 
      ?logging_info  ?name  ?description  () =
      {
        window_id;
        window_task_id;
        targets;
        task_arn;
        service_role_arn;
        task_type;
        task_parameters;
        task_invocation_parameters;
        priority;
        max_concurrency;
        max_errors;
        logging_info;
        name;
        description
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.description
              (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.logging_info
             (fun f -> ("logging_info", (LoggingInfo.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Util.option_map v.task_invocation_parameters
             (fun f ->
                ("task_invocation_parameters",
                  (MaintenanceWindowTaskInvocationParameters.to_json f)));
           Util.option_map v.task_parameters
             (fun f ->
                ("task_parameters",
                  (MaintenanceWindowTaskParameters.to_json f)));
           Util.option_map v.task_type
             (fun f -> ("task_type", (MaintenanceWindowTaskType.to_json f)));
           Util.option_map v.service_role_arn
             (fun f -> ("service_role_arn", (String.to_json f)));
           Util.option_map v.task_arn
             (fun f -> ("task_arn", (String.to_json f)));
           Some ("targets", (Targets.to_json v.targets));
           Util.option_map v.window_task_id
             (fun f -> ("window_task_id", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        window_task_id =
          (Util.option_map (Json.lookup j "window_task_id") String.of_json);
        targets =
          (Targets.of_json (Util.of_option_exn (Json.lookup j "targets")));
        task_arn =
          (Util.option_map (Json.lookup j "task_arn") String.of_json);
        service_role_arn =
          (Util.option_map (Json.lookup j "service_role_arn") String.of_json);
        task_type =
          (Util.option_map (Json.lookup j "task_type")
             MaintenanceWindowTaskType.of_json);
        task_parameters =
          (Util.option_map (Json.lookup j "task_parameters")
             MaintenanceWindowTaskParameters.of_json);
        task_invocation_parameters =
          (Util.option_map (Json.lookup j "task_invocation_parameters")
             MaintenanceWindowTaskInvocationParameters.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        logging_info =
          (Util.option_map (Json.lookup j "logging_info") LoggingInfo.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json)
      }
  end
module DescribeInstancePatchesResult =
  struct
    type t =
      {
      patches: PatchComplianceDataList.t
        [@ocaml.doc
          "<p>Each entry in the array is a structure containing:</p> <p>Title (string)</p> <p>KBId (string)</p> <p>Classification (string)</p> <p>Severity (string)</p> <p>State (string, such as \"INSTALLED\" or \"FAILED\")</p> <p>InstalledTime (DateTime)</p> <p>InstalledBy (string)</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(patches= [])  ?next_token  () = { patches; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("patches", (PatchComplianceDataList.to_json v.patches))])
    let of_json j =
      {
        patches =
          (PatchComplianceDataList.of_json
             (Util.of_option_exn (Json.lookup j "patches")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetPatchBaselineForPatchGroupResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc
          "<p>The ID of the patch baseline that should be used for the patch group.</p>"];
      patch_group: String.t option
        [@ocaml.doc "<p>The name of the patch group.</p>"];
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>The operating system rule specified for patch groups using the patch baseline.</p>"]}
    let make ?baseline_id  ?patch_group  ?operating_system  () =
      { baseline_id; patch_group; operating_system }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operating_system
              (fun f -> ("operating_system", (OperatingSystem.to_json f)));
           Util.option_map v.patch_group
             (fun f -> ("patch_group", (String.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        patch_group =
          (Util.option_map (Json.lookup j "patch_group") String.of_json);
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json)
      }
  end
module DescribeAvailablePatchesResult =
  struct
    type t =
      {
      patches: PatchList.t
        [@ocaml.doc
          "<p>An array of patches. Each entry in the array is a patch structure.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(patches= [])  ?next_token  () = { patches; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("patches", (PatchList.to_json v.patches))])
    let of_json j =
      {
        patches =
          (PatchList.of_json (Util.of_option_exn (Json.lookup j "patches")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetCalendarStateResponse =
  struct
    type t =
      {
      state: CalendarState.t option
        [@ocaml.doc
          "<p>The state of the calendar. An <code>OPEN</code> calendar indicates that actions are allowed to proceed, and a <code>CLOSED</code> calendar indicates that actions are not allowed to proceed.</p>"];
      at_time: String.t option
        [@ocaml.doc
          "<p>The time, as an <a href=\"https://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a> string, that you specified in your command. If you did not specify a time, <code>GetCalendarState</code> uses the current time.</p>"];
      next_transition_time: String.t option
        [@ocaml.doc
          "<p>The time, as an <a href=\"https://en.wikipedia.org/wiki/ISO_8601\">ISO 8601</a> string, that the calendar state will change. If the current calendar state is <code>OPEN</code>, <code>NextTransitionTime</code> indicates when the calendar state changes to <code>CLOSED</code>, and vice-versa.</p>"]}
    let make ?state  ?at_time  ?next_transition_time  () =
      { state; at_time; next_transition_time }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_transition_time
              (fun f -> ("next_transition_time", (String.to_json f)));
           Util.option_map v.at_time
             (fun f -> ("at_time", (String.to_json f)));
           Util.option_map v.state
             (fun f -> ("state", (CalendarState.to_json f)))])
    let of_json j =
      {
        state =
          (Util.option_map (Json.lookup j "state") CalendarState.of_json);
        at_time = (Util.option_map (Json.lookup j "at_time") String.of_json);
        next_transition_time =
          (Util.option_map (Json.lookup j "next_transition_time")
             String.of_json)
      }
  end
module StartSessionResponse =
  struct
    type t =
      {
      session_id: String.t option
        [@ocaml.doc "<p>The ID of the session.</p>"];
      token_value: String.t option
        [@ocaml.doc
          "<p>An encrypted token value containing session and caller information. Used to authenticate the connection to the instance.</p>"];
      stream_url: String.t option
        [@ocaml.doc
          "<p>A URL back to SSM Agent on the instance that the Session Manager client uses to send commands and receive output from the instance. Format: <code>wss://ssmmessages.<b>region</b>.amazonaws.com/v1/data-channel/<b>session-id</b>?stream=(input|output)</code> </p> <p> <b>region</b> represents the Region identifier for an AWS Region supported by AWS Systems Manager, such as <code>us-east-2</code> for the US East (Ohio) Region. For a list of supported <b>region</b> values, see the <b>Region</b> column in <a href=\"http://docs.aws.amazon.com/general/latest/gr/ssm.html#ssm_region\">Systems Manager Service Endpoints</a> in the <i>AWS General Reference</i>.</p> <p> <b>session-id</b> represents the ID of a Session Manager session, such as <code>1a2b3c4dEXAMPLE</code>.</p>"]}
    let make ?session_id  ?token_value  ?stream_url  () =
      { session_id; token_value; stream_url }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.stream_url
              (fun f -> ("stream_url", (String.to_json f)));
           Util.option_map v.token_value
             (fun f -> ("token_value", (String.to_json f)));
           Util.option_map v.session_id
             (fun f -> ("session_id", (String.to_json f)))])
    let of_json j =
      {
        session_id =
          (Util.option_map (Json.lookup j "session_id") String.of_json);
        token_value =
          (Util.option_map (Json.lookup j "token_value") String.of_json);
        stream_url =
          (Util.option_map (Json.lookup j "stream_url") String.of_json)
      }
  end
module DeletePatchBaselineResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the deleted patch baseline.</p>"]}
    let make ?baseline_id  () = { baseline_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.baseline_id
              (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json)
      }
  end
module UpdateOpsItemResponse =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateOpsItemResponse =
  struct
    type t =
      {
      ops_item_id: String.t option
        [@ocaml.doc "<p>The ID of the OpsItem.</p>"]}
    let make ?ops_item_id  () = { ops_item_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.ops_item_id
              (fun f -> ("ops_item_id", (String.to_json f)))])
    let of_json j =
      {
        ops_item_id =
          (Util.option_map (Json.lookup j "ops_item_id") String.of_json)
      }
  end
module LabelParameterVersionResult =
  struct
    type t =
      {
      invalid_labels: ParameterLabelList.t
        [@ocaml.doc
          "<p>The label does not meet the requirements. For information about parameter label requirements, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-labels.html\">Labeling Parameters</a> in the <i>AWS Systems Manager User Guide</i>.</p>"];
      parameter_version: Long.t option
        [@ocaml.doc
          "<p>The version of the parameter that has been labeled.</p>"]}
    let make ?(invalid_labels= [])  ?parameter_version  () =
      { invalid_labels; parameter_version }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parameter_version
              (fun f -> ("parameter_version", (Long.to_json f)));
           Some
             ("invalid_labels",
               (ParameterLabelList.to_json v.invalid_labels))])
    let of_json j =
      {
        invalid_labels =
          (ParameterLabelList.of_json
             (Util.of_option_exn (Json.lookup j "invalid_labels")));
        parameter_version =
          (Util.option_map (Json.lookup j "parameter_version") Long.of_json)
      }
  end
module DeleteInventoryResult =
  struct
    type t =
      {
      deletion_id: String.t option
        [@ocaml.doc
          "<p>Every <code>DeleteInventory</code> action is assigned a unique ID. This option returns a unique ID. You can use this ID to query the status of a delete operation. This option is useful for ensuring that a delete operation has completed before you begin other actions. </p>"];
      type_name: String.t option
        [@ocaml.doc
          "<p>The name of the inventory data type specified in the request.</p>"];
      deletion_summary: InventoryDeletionSummary.t option
        [@ocaml.doc
          "<p>A summary of the delete operation. For more information about this summary, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-inventory-delete.html#sysman-inventory-delete-summary\">Understanding the Delete Inventory Summary</a> in the <i>AWS Systems Manager User Guide</i>.</p>"]}
    let make ?deletion_id  ?type_name  ?deletion_summary  () =
      { deletion_id; type_name; deletion_summary }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.deletion_summary
              (fun f ->
                 ("deletion_summary", (InventoryDeletionSummary.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)));
           Util.option_map v.deletion_id
             (fun f -> ("deletion_id", (String.to_json f)))])
    let of_json j =
      {
        deletion_id =
          (Util.option_map (Json.lookup j "deletion_id") String.of_json);
        type_name =
          (Util.option_map (Json.lookup j "type_name") String.of_json);
        deletion_summary =
          (Util.option_map (Json.lookup j "deletion_summary")
             InventoryDeletionSummary.of_json)
      }
  end
module PutParameterResult =
  struct
    type t =
      {
      version: Long.t option
        [@ocaml.doc
          "<p>The new version number of a parameter. If you edit a parameter value, Parameter Store automatically creates a new version and assigns this new version a unique ID. You can reference a parameter version ID in API actions or in Systems Manager documents (SSM documents). By default, if you don't specify a specific version, the system returns the latest parameter value when a parameter is called.</p>"];
      tier: ParameterTier.t option
        [@ocaml.doc "<p>The tier assigned to the parameter.</p>"]}
    let make ?version  ?tier  () = { version; tier }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.tier
              (fun f -> ("tier", (ParameterTier.to_json f)));
           Util.option_map v.version (fun f -> ("version", (Long.to_json f)))])
    let of_json j =
      {
        version = (Util.option_map (Json.lookup j "version") Long.of_json);
        tier = (Util.option_map (Json.lookup j "tier") ParameterTier.of_json)
      }
  end
module ListAssociationVersionsResult =
  struct
    type t =
      {
      association_versions: AssociationVersionList.t
        [@ocaml.doc
          "<p>Information about all versions of the association for the specified association ID.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(association_versions= [])  ?next_token  () =
      { association_versions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("association_versions",
               (AssociationVersionList.to_json v.association_versions))])
    let of_json j =
      {
        association_versions =
          (AssociationVersionList.of_json
             (Util.of_option_exn (Json.lookup j "association_versions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module RegisterTargetWithMaintenanceWindowResult =
  struct
    type t =
      {
      window_target_id: String.t option
        [@ocaml.doc
          "<p>The ID of the target definition in this maintenance window.</p>"]}
    let make ?window_target_id  () = { window_target_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.window_target_id
              (fun f -> ("window_target_id", (String.to_json f)))])
    let of_json j =
      {
        window_target_id =
          (Util.option_map (Json.lookup j "window_target_id") String.of_json)
      }
  end
module CreatePatchBaselineResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the created patch baseline.</p>"]}
    let make ?baseline_id  () = { baseline_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.baseline_id
              (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json)
      }
  end
module ListComplianceSummariesResult =
  struct
    type t =
      {
      compliance_summary_items: ComplianceSummaryItemList.t
        [@ocaml.doc
          "<p>A list of compliant and non-compliant summary counts based on compliance types. For example, this call returns State Manager associations, patches, or custom compliance types according to the filter criteria that you specified.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(compliance_summary_items= [])  ?next_token  () =
      { compliance_summary_items; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("compliance_summary_items",
               (ComplianceSummaryItemList.to_json v.compliance_summary_items))])
    let of_json j =
      {
        compliance_summary_items =
          (ComplianceSummaryItemList.of_json
             (Util.of_option_exn (Json.lookup j "compliance_summary_items")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeEffectivePatchesForPatchBaselineResult =
  struct
    type t =
      {
      effective_patches: EffectivePatchList.t
        [@ocaml.doc "<p>An array of patches and patch status.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(effective_patches= [])  ?next_token  () =
      { effective_patches; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("effective_patches",
               (EffectivePatchList.to_json v.effective_patches))])
    let of_json j =
      {
        effective_patches =
          (EffectivePatchList.of_json
             (Util.of_option_exn (Json.lookup j "effective_patches")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module CreateAssociationBatchResult =
  struct
    type t =
      {
      successful: AssociationDescriptionList.t
        [@ocaml.doc
          "<p>Information about the associations that succeeded.</p>"];
      failed: FailedCreateAssociationList.t
        [@ocaml.doc "<p>Information about the associations that failed.</p>"]}
    let make ?(successful= [])  ?(failed= [])  () = { successful; failed }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("failed", (FailedCreateAssociationList.to_json v.failed));
           Some
             ("successful",
               (AssociationDescriptionList.to_json v.successful))])
    let of_json j =
      {
        successful =
          (AssociationDescriptionList.of_json
             (Util.of_option_exn (Json.lookup j "successful")));
        failed =
          (FailedCreateAssociationList.of_json
             (Util.of_option_exn (Json.lookup j "failed")))
      }
  end
module GetDeployablePatchSnapshotForInstanceResult =
  struct
    type t =
      {
      instance_id: String.t option
        [@ocaml.doc "<p>The ID of the instance.</p>"];
      snapshot_id: String.t option
        [@ocaml.doc "<p>The user-defined snapshot ID.</p>"];
      snapshot_download_url: String.t option
        [@ocaml.doc
          "<p>A pre-signed Amazon S3 URL that can be used to download the patch snapshot.</p>"];
      product: String.t option
        [@ocaml.doc
          "<p>Returns the specific operating system (for example Windows Server 2012 or Amazon Linux 2015.09) on the instance for the specified patch snapshot.</p>"]}
    let make ?instance_id  ?snapshot_id  ?snapshot_download_url  ?product  ()
      = { instance_id; snapshot_id; snapshot_download_url; product }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.product
              (fun f -> ("product", (String.to_json f)));
           Util.option_map v.snapshot_download_url
             (fun f -> ("snapshot_download_url", (String.to_json f)));
           Util.option_map v.snapshot_id
             (fun f -> ("snapshot_id", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)))])
    let of_json j =
      {
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        snapshot_id =
          (Util.option_map (Json.lookup j "snapshot_id") String.of_json);
        snapshot_download_url =
          (Util.option_map (Json.lookup j "snapshot_download_url")
             String.of_json);
        product = (Util.option_map (Json.lookup j "product") String.of_json)
      }
  end
module GetMaintenanceWindowExecutionTaskResult =
  struct
    type t =
      {
      window_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the maintenance window execution that includes the task.</p>"];
      task_execution_id: String.t option
        [@ocaml.doc
          "<p>The ID of the specific task execution in the maintenance window task that was retrieved.</p>"];
      task_arn: String.t option
        [@ocaml.doc "<p>The ARN of the task that ran.</p>"];
      service_role: String.t option
        [@ocaml.doc
          "<p>The role that was assumed when running the task.</p>"];
      type_: MaintenanceWindowTaskType.t option
        [@ocaml.doc "<p>The type of task that was run.</p>"];
      task_parameters: MaintenanceWindowTaskParametersList.t
        [@ocaml.doc
          "<p>The parameters passed to the task when it was run.</p> <note> <p> <code>TaskParameters</code> has been deprecated. To specify parameters to pass to a task when it runs, instead use the <code>Parameters</code> option in the <code>TaskInvocationParameters</code> structure. For information about how Systems Manager handles these options for the supported maintenance window task types, see <a>MaintenanceWindowTaskInvocationParameters</a>.</p> </note> <p>The map has the following format:</p> <p>Key: string, between 1 and 255 characters</p> <p>Value: an array of strings, each string is between 1 and 255 characters</p>"];
      priority: Integer.t option
        [@ocaml.doc "<p>The priority of the task.</p>"];
      max_concurrency: String.t option
        [@ocaml.doc
          "<p>The defined maximum number of task executions that could be run in parallel.</p>"];
      max_errors: String.t option
        [@ocaml.doc
          "<p>The defined maximum number of task execution errors allowed before scheduling of the task execution would have been stopped.</p>"];
      status: MaintenanceWindowExecutionStatus.t option
        [@ocaml.doc "<p>The status of the task.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>The details explaining the Status. Only available for certain status values.</p>"];
      start_time: DateTime.t option
        [@ocaml.doc "<p>The time the task execution started.</p>"];
      end_time: DateTime.t option
        [@ocaml.doc "<p>The time the task execution completed.</p>"]}
    let make ?window_execution_id  ?task_execution_id  ?task_arn 
      ?service_role  ?type_  ?(task_parameters= [])  ?priority 
      ?max_concurrency  ?max_errors  ?status  ?status_details  ?start_time 
      ?end_time  () =
      {
        window_execution_id;
        task_execution_id;
        task_arn;
        service_role;
        type_;
        task_parameters;
        priority;
        max_concurrency;
        max_errors;
        status;
        status_details;
        start_time;
        end_time
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_time
              (fun f -> ("end_time", (DateTime.to_json f)));
           Util.option_map v.start_time
             (fun f -> ("start_time", (DateTime.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f ->
                ("status", (MaintenanceWindowExecutionStatus.to_json f)));
           Util.option_map v.max_errors
             (fun f -> ("max_errors", (String.to_json f)));
           Util.option_map v.max_concurrency
             (fun f -> ("max_concurrency", (String.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Some
             ("task_parameters",
               (MaintenanceWindowTaskParametersList.to_json v.task_parameters));
           Util.option_map v.type_
             (fun f -> ("type_", (MaintenanceWindowTaskType.to_json f)));
           Util.option_map v.service_role
             (fun f -> ("service_role", (String.to_json f)));
           Util.option_map v.task_arn
             (fun f -> ("task_arn", (String.to_json f)));
           Util.option_map v.task_execution_id
             (fun f -> ("task_execution_id", (String.to_json f)));
           Util.option_map v.window_execution_id
             (fun f -> ("window_execution_id", (String.to_json f)))])
    let of_json j =
      {
        window_execution_id =
          (Util.option_map (Json.lookup j "window_execution_id")
             String.of_json);
        task_execution_id =
          (Util.option_map (Json.lookup j "task_execution_id") String.of_json);
        task_arn =
          (Util.option_map (Json.lookup j "task_arn") String.of_json);
        service_role =
          (Util.option_map (Json.lookup j "service_role") String.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_")
             MaintenanceWindowTaskType.of_json);
        task_parameters =
          (MaintenanceWindowTaskParametersList.of_json
             (Util.of_option_exn (Json.lookup j "task_parameters")));
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        max_concurrency =
          (Util.option_map (Json.lookup j "max_concurrency") String.of_json);
        max_errors =
          (Util.option_map (Json.lookup j "max_errors") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             MaintenanceWindowExecutionStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        start_time =
          (Util.option_map (Json.lookup j "start_time") DateTime.of_json);
        end_time =
          (Util.option_map (Json.lookup j "end_time") DateTime.of_json)
      }
  end
module GetOpsItemResponse =
  struct
    type t = {
      ops_item: OpsItem.t option [@ocaml.doc "<p>The OpsItem.</p>"]}
    let make ?ops_item  () = { ops_item }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.ops_item
              (fun f -> ("ops_item", (OpsItem.to_json f)))])
    let of_json j =
      {
        ops_item =
          (Util.option_map (Json.lookup j "ops_item") OpsItem.of_json)
      }
  end
module DescribeInventoryDeletionsResult =
  struct
    type t =
      {
      inventory_deletions: InventoryDeletionsList.t
        [@ocaml.doc "<p>A list of status items for deleted inventory.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(inventory_deletions= [])  ?next_token  () =
      { inventory_deletions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("inventory_deletions",
               (InventoryDeletionsList.to_json v.inventory_deletions))])
    let of_json j =
      {
        inventory_deletions =
          (InventoryDeletionsList.of_json
             (Util.of_option_exn (Json.lookup j "inventory_deletions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeInstanceAssociationsStatusResult =
  struct
    type t =
      {
      instance_association_status_infos: InstanceAssociationStatusInfos.t
        [@ocaml.doc "<p>Status information about the association.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(instance_association_status_infos= [])  ?next_token  () =
      { instance_association_status_infos; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("instance_association_status_infos",
               (InstanceAssociationStatusInfos.to_json
                  v.instance_association_status_infos))])
    let of_json j =
      {
        instance_association_status_infos =
          (InstanceAssociationStatusInfos.of_json
             (Util.of_option_exn
                (Json.lookup j "instance_association_status_infos")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetInventorySchemaResult =
  struct
    type t =
      {
      schemas: InventoryItemSchemaResultList.t
        [@ocaml.doc "<p>Inventory schemas returned by the request.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(schemas= [])  ?next_token  () = { schemas; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("schemas", (InventoryItemSchemaResultList.to_json v.schemas))])
    let of_json j =
      {
        schemas =
          (InventoryItemSchemaResultList.of_json
             (Util.of_option_exn (Json.lookup j "schemas")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeMaintenanceWindowExecutionTasksResult =
  struct
    type t =
      {
      window_execution_task_identities:
        MaintenanceWindowExecutionTaskIdentityList.t
        [@ocaml.doc "<p>Information about the task executions.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(window_execution_task_identities= [])  ?next_token  () =
      { window_execution_task_identities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("window_execution_task_identities",
               (MaintenanceWindowExecutionTaskIdentityList.to_json
                  v.window_execution_task_identities))])
    let of_json j =
      {
        window_execution_task_identities =
          (MaintenanceWindowExecutionTaskIdentityList.of_json
             (Util.of_option_exn
                (Json.lookup j "window_execution_task_identities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeMaintenanceWindowsResult =
  struct
    type t =
      {
      window_identities: MaintenanceWindowIdentityList.t
        [@ocaml.doc "<p>Information about the maintenance windows.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(window_identities= [])  ?next_token  () =
      { window_identities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("window_identities",
               (MaintenanceWindowIdentityList.to_json v.window_identities))])
    let of_json j =
      {
        window_identities =
          (MaintenanceWindowIdentityList.of_json
             (Util.of_option_exn (Json.lookup j "window_identities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetConnectionStatusResponse =
  struct
    type t =
      {
      target: String.t option
        [@ocaml.doc
          "<p>The ID of the instance to check connection status. </p>"];
      status: ConnectionStatus.t option
        [@ocaml.doc
          "<p>The status of the connection to the instance. For example, 'Connected' or 'Not Connected'.</p>"]}
    let make ?target  ?status  () = { target; status }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (ConnectionStatus.to_json f)));
           Util.option_map v.target (fun f -> ("target", (String.to_json f)))])
    let of_json j =
      {
        target = (Util.option_map (Json.lookup j "target") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status") ConnectionStatus.of_json)
      }
  end
module SendCommandResult =
  struct
    type t =
      {
      command: Command.t option
        [@ocaml.doc
          "<p>The request as it was received by Systems Manager. Also provides the command ID which can be used future references to this request.</p>"]}
    let make ?command  () = { command }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.command
              (fun f -> ("command", (Command.to_json f)))])
    let of_json j =
      { command = (Util.option_map (Json.lookup j "command") Command.of_json)
      }
  end
module ModifyDocumentPermissionResponse =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module StartAutomationExecutionResult =
  struct
    type t =
      {
      automation_execution_id: String.t option
        [@ocaml.doc
          "<p>The unique ID of a newly scheduled automation execution.</p>"]}
    let make ?automation_execution_id  () = { automation_execution_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.automation_execution_id
              (fun f -> ("automation_execution_id", (String.to_json f)))])
    let of_json j =
      {
        automation_execution_id =
          (Util.option_map (Json.lookup j "automation_execution_id")
             String.of_json)
      }
  end
module DescribeDocumentPermissionResponse =
  struct
    type t =
      {
      account_ids: AccountIdList.t
        [@ocaml.doc
          "<p>The account IDs that have permission to use this document. The ID can be either an AWS account or <i>All</i>.</p>"];
      account_sharing_info_list: AccountSharingInfoList.t
        [@ocaml.doc
          "<p>A list of of AWS accounts where the current document is shared and the version shared with each account.</p>"]}
    let make ?(account_ids= [])  ?(account_sharing_info_list= [])  () =
      { account_ids; account_sharing_info_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("account_sharing_info_list",
                (AccountSharingInfoList.to_json v.account_sharing_info_list));
           Some ("account_ids", (AccountIdList.to_json v.account_ids))])
    let of_json j =
      {
        account_ids =
          (AccountIdList.of_json
             (Util.of_option_exn (Json.lookup j "account_ids")));
        account_sharing_info_list =
          (AccountSharingInfoList.of_json
             (Util.of_option_exn (Json.lookup j "account_sharing_info_list")))
      }
  end
module ListInventoryEntriesResult =
  struct
    type t =
      {
      type_name: String.t option
        [@ocaml.doc
          "<p>The type of inventory item returned by the request.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The instance ID targeted by the request to query inventory information.</p>"];
      schema_version: String.t option
        [@ocaml.doc
          "<p>The inventory schema version used by the instance(s).</p>"];
      capture_time: String.t option
        [@ocaml.doc
          "<p>The time that inventory information was collected for the instance(s).</p>"];
      entries: InventoryItemEntryList.t
        [@ocaml.doc "<p>A list of inventory items on the instance(s).</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?type_name  ?instance_id  ?schema_version  ?capture_time 
      ?(entries= [])  ?next_token  () =
      {
        type_name;
        instance_id;
        schema_version;
        capture_time;
        entries;
        next_token
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("entries", (InventoryItemEntryList.to_json v.entries));
           Util.option_map v.capture_time
             (fun f -> ("capture_time", (String.to_json f)));
           Util.option_map v.schema_version
             (fun f -> ("schema_version", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.type_name
             (fun f -> ("type_name", (String.to_json f)))])
    let of_json j =
      {
        type_name =
          (Util.option_map (Json.lookup j "type_name") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        schema_version =
          (Util.option_map (Json.lookup j "schema_version") String.of_json);
        capture_time =
          (Util.option_map (Json.lookup j "capture_time") String.of_json);
        entries =
          (InventoryItemEntryList.of_json
             (Util.of_option_exn (Json.lookup j "entries")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module ListTagsForResourceResult =
  struct
    type t = {
      tag_list: TagList.t [@ocaml.doc "<p>A list of tags.</p>"]}
    let make ?(tag_list= [])  () = { tag_list }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_list", (TagList.to_json v.tag_list))])
    let of_json j =
      {
        tag_list =
          (TagList.of_json (Util.of_option_exn (Json.lookup j "tag_list")))
      }
  end
module DescribeMaintenanceWindowExecutionTaskInvocationsResult =
  struct
    type t =
      {
      window_execution_task_invocation_identities:
        MaintenanceWindowExecutionTaskInvocationIdentityList.t
        [@ocaml.doc
          "<p>Information about the task invocation results per invocation.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(window_execution_task_invocation_identities= [])  ?next_token 
      () = { window_execution_task_invocation_identities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("window_execution_task_invocation_identities",
               (MaintenanceWindowExecutionTaskInvocationIdentityList.to_json
                  v.window_execution_task_invocation_identities))])
    let of_json j =
      {
        window_execution_task_invocation_identities =
          (MaintenanceWindowExecutionTaskInvocationIdentityList.of_json
             (Util.of_option_exn
                (Json.lookup j "window_execution_task_invocation_identities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DescribeMaintenanceWindowsForTargetResult =
  struct
    type t =
      {
      window_identities: MaintenanceWindowsForTargetList.t
        [@ocaml.doc
          "<p>Information about the maintenance window targets and tasks an instance is associated with.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. (You use this token in the next call.)</p>"]}
    let make ?(window_identities= [])  ?next_token  () =
      { window_identities; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("window_identities",
               (MaintenanceWindowsForTargetList.to_json v.window_identities))])
    let of_json j =
      {
        window_identities =
          (MaintenanceWindowsForTargetList.of_json
             (Util.of_option_exn (Json.lookup j "window_identities")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DeregisterPatchBaselineForPatchGroupResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc
          "<p>The ID of the patch baseline the patch group was deregistered from.</p>"];
      patch_group: String.t option
        [@ocaml.doc
          "<p>The name of the patch group deregistered from the patch baseline.</p>"]}
    let make ?baseline_id  ?patch_group  () = { baseline_id; patch_group }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.patch_group
              (fun f -> ("patch_group", (String.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        patch_group =
          (Util.option_map (Json.lookup j "patch_group") String.of_json)
      }
  end
module StopAutomationExecutionResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DescribeInstancePatchStatesResult =
  struct
    type t =
      {
      instance_patch_states: InstancePatchStateList.t
        [@ocaml.doc
          "<p>The high-level patch state for the requested instances.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(instance_patch_states= [])  ?next_token  () =
      { instance_patch_states; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("instance_patch_states",
               (InstancePatchStateList.to_json v.instance_patch_states))])
    let of_json j =
      {
        instance_patch_states =
          (InstancePatchStateList.of_json
             (Util.of_option_exn (Json.lookup j "instance_patch_states")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module DeleteParameterResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ListCommandInvocationsResult =
  struct
    type t =
      {
      command_invocations: CommandInvocationList.t
        [@ocaml.doc "<p>(Optional) A list of all invocations. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>(Optional) The token for the next set of items to return. (You received this token from a previous call.)</p>"]}
    let make ?(command_invocations= [])  ?next_token  () =
      { command_invocations; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("command_invocations",
               (CommandInvocationList.to_json v.command_invocations))])
    let of_json j =
      {
        command_invocations =
          (CommandInvocationList.of_json
             (Util.of_option_exn (Json.lookup j "command_invocations")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module RemoveTagsFromResourceResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ResetServiceSettingResult =
  struct
    type t =
      {
      service_setting: ServiceSetting.t option
        [@ocaml.doc
          "<p>The current, effective service setting after calling the ResetServiceSetting API action.</p>"]}
    [@@ocaml.doc
      "<p>The result body of the ResetServiceSetting API action.</p>"]
    let make ?service_setting  () = { service_setting }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.service_setting
              (fun f -> ("service_setting", (ServiceSetting.to_json f)))])
    let of_json j =
      {
        service_setting =
          (Util.option_map (Json.lookup j "service_setting")
             ServiceSetting.of_json)
      }
  end[@@ocaml.doc
       "<p>The result body of the ResetServiceSetting API action.</p>"]
module DeleteAssociationResult =
  struct
    type t = unit
    let make () = ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module RegisterDefaultPatchBaselineResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the default patch baseline.</p>"]}
    let make ?baseline_id  () = { baseline_id }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.baseline_id
              (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json)
      }
  end
module DeleteParametersResult =
  struct
    type t =
      {
      deleted_parameters: ParameterNameList.t
        [@ocaml.doc "<p>The names of the deleted parameters.</p>"];
      invalid_parameters: ParameterNameList.t
        [@ocaml.doc
          "<p>The names of parameters that weren't deleted because the parameters are not valid.</p>"]}
    let make ?(deleted_parameters= [])  ?(invalid_parameters= [])  () =
      { deleted_parameters; invalid_parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("invalid_parameters",
                (ParameterNameList.to_json v.invalid_parameters));
           Some
             ("deleted_parameters",
               (ParameterNameList.to_json v.deleted_parameters))])
    let of_json j =
      {
        deleted_parameters =
          (ParameterNameList.of_json
             (Util.of_option_exn (Json.lookup j "deleted_parameters")));
        invalid_parameters =
          (ParameterNameList.of_json
             (Util.of_option_exn (Json.lookup j "invalid_parameters")))
      }
  end
module GetPatchBaselineResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the retrieved patch baseline.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the patch baseline.</p>"];
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>Returns the operating system specified for the patch baseline.</p>"];
      global_filters: PatchFilterGroup.t option
        [@ocaml.doc
          "<p>A set of global filters used to exclude patches from the baseline.</p>"];
      approval_rules: PatchRuleGroup.t option
        [@ocaml.doc
          "<p>A set of rules used to include patches in the baseline.</p>"];
      approved_patches: PatchIdList.t
        [@ocaml.doc
          "<p>A list of explicitly approved patches for the baseline.</p>"];
      approved_patches_compliance_level: PatchComplianceLevel.t option
        [@ocaml.doc
          "<p>Returns the specified compliance severity level for approved patches in the patch baseline.</p>"];
      approved_patches_enable_non_security: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the list of approved patches includes non-security updates that should be applied to the instances. The default value is 'false'. Applies to Linux instances only.</p>"];
      rejected_patches: PatchIdList.t
        [@ocaml.doc
          "<p>A list of explicitly rejected patches for the baseline.</p>"];
      rejected_patches_action: PatchAction.t option
        [@ocaml.doc
          "<p>The action specified to take on patches included in the RejectedPatches list. A patch can be allowed only if it is a dependency of another package, or blocked entirely along with packages that include it as a dependency.</p>"];
      patch_groups: PatchGroupList.t
        [@ocaml.doc "<p>Patch groups included in the patch baseline.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date the patch baseline was created.</p>"];
      modified_date: DateTime.t option
        [@ocaml.doc "<p>The date the patch baseline was last modified.</p>"];
      description: String.t option
        [@ocaml.doc "<p>A description of the patch baseline.</p>"];
      sources: PatchSourceList.t
        [@ocaml.doc
          "<p>Information about the patches to use to update the instances, including target operating systems and source repositories. Applies to Linux instances only.</p>"]}
    let make ?baseline_id  ?name  ?operating_system  ?global_filters 
      ?approval_rules  ?(approved_patches= []) 
      ?approved_patches_compliance_level 
      ?approved_patches_enable_non_security  ?(rejected_patches= []) 
      ?rejected_patches_action  ?(patch_groups= [])  ?created_date 
      ?modified_date  ?description  ?(sources= [])  () =
      {
        baseline_id;
        name;
        operating_system;
        global_filters;
        approval_rules;
        approved_patches;
        approved_patches_compliance_level;
        approved_patches_enable_non_security;
        rejected_patches;
        rejected_patches_action;
        patch_groups;
        created_date;
        modified_date;
        description;
        sources
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("sources", (PatchSourceList.to_json v.sources));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.modified_date
             (fun f -> ("modified_date", (DateTime.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Some ("patch_groups", (PatchGroupList.to_json v.patch_groups));
           Util.option_map v.rejected_patches_action
             (fun f -> ("rejected_patches_action", (PatchAction.to_json f)));
           Some
             ("rejected_patches", (PatchIdList.to_json v.rejected_patches));
           Util.option_map v.approved_patches_enable_non_security
             (fun f ->
                ("approved_patches_enable_non_security", (Boolean.to_json f)));
           Util.option_map v.approved_patches_compliance_level
             (fun f ->
                ("approved_patches_compliance_level",
                  (PatchComplianceLevel.to_json f)));
           Some
             ("approved_patches", (PatchIdList.to_json v.approved_patches));
           Util.option_map v.approval_rules
             (fun f -> ("approval_rules", (PatchRuleGroup.to_json f)));
           Util.option_map v.global_filters
             (fun f -> ("global_filters", (PatchFilterGroup.to_json f)));
           Util.option_map v.operating_system
             (fun f -> ("operating_system", (OperatingSystem.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json);
        global_filters =
          (Util.option_map (Json.lookup j "global_filters")
             PatchFilterGroup.of_json);
        approval_rules =
          (Util.option_map (Json.lookup j "approval_rules")
             PatchRuleGroup.of_json);
        approved_patches =
          (PatchIdList.of_json
             (Util.of_option_exn (Json.lookup j "approved_patches")));
        approved_patches_compliance_level =
          (Util.option_map
             (Json.lookup j "approved_patches_compliance_level")
             PatchComplianceLevel.of_json);
        approved_patches_enable_non_security =
          (Util.option_map
             (Json.lookup j "approved_patches_enable_non_security")
             Boolean.of_json);
        rejected_patches =
          (PatchIdList.of_json
             (Util.of_option_exn (Json.lookup j "rejected_patches")));
        rejected_patches_action =
          (Util.option_map (Json.lookup j "rejected_patches_action")
             PatchAction.of_json);
        patch_groups =
          (PatchGroupList.of_json
             (Util.of_option_exn (Json.lookup j "patch_groups")));
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        modified_date =
          (Util.option_map (Json.lookup j "modified_date") DateTime.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        sources =
          (PatchSourceList.of_json
             (Util.of_option_exn (Json.lookup j "sources")))
      }
  end
module GetDocumentResult =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc "<p>The name of the Systems Manager document.</p>"];
      version_name: String.t option
        [@ocaml.doc
          "<p>The version of the artifact associated with the document. For example, \"Release 12, Update 6\". This value is unique across all versions of a document, and cannot be changed.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The document version.</p>"];
      status: DocumentStatus.t option
        [@ocaml.doc
          "<p>The status of the Systems Manager document, such as <code>Creating</code>, <code>Active</code>, <code>Updating</code>, <code>Failed</code>, and <code>Deleting</code>.</p>"];
      status_information: String.t option
        [@ocaml.doc
          "<p>A message returned by AWS Systems Manager that explains the <code>Status</code> value. For example, a <code>Failed</code> status might be explained by the <code>StatusInformation</code> message, \"The specified S3 bucket does not exist. Verify that the URL of the S3 bucket is correct.\"</p>"];
      content: String.t option
        [@ocaml.doc "<p>The contents of the Systems Manager document.</p>"];
      document_type: DocumentType.t option
        [@ocaml.doc "<p>The document type.</p>"];
      document_format: DocumentFormat.t option
        [@ocaml.doc "<p>The document format, either JSON or YAML.</p>"];
      requires: DocumentRequiresList.t
        [@ocaml.doc
          "<p>A list of SSM documents required by a document. For example, an <code>ApplicationConfiguration</code> document requires an <code>ApplicationConfigurationSchema</code> document.</p>"];
      attachments_content: AttachmentContentList.t
        [@ocaml.doc
          "<p>A description of the document attachments, including names, locations, sizes, etc.</p>"]}
    let make ?name  ?version_name  ?document_version  ?status 
      ?status_information  ?content  ?document_type  ?document_format 
      ?(requires= [])  ?(attachments_content= [])  () =
      {
        name;
        version_name;
        document_version;
        status;
        status_information;
        content;
        document_type;
        document_format;
        requires;
        attachments_content
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("attachments_content",
                (AttachmentContentList.to_json v.attachments_content));
           Some ("requires", (DocumentRequiresList.to_json v.requires));
           Util.option_map v.document_format
             (fun f -> ("document_format", (DocumentFormat.to_json f)));
           Util.option_map v.document_type
             (fun f -> ("document_type", (DocumentType.to_json f)));
           Util.option_map v.content
             (fun f -> ("content", (String.to_json f)));
           Util.option_map v.status_information
             (fun f -> ("status_information", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (DocumentStatus.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.version_name
             (fun f -> ("version_name", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        version_name =
          (Util.option_map (Json.lookup j "version_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        status =
          (Util.option_map (Json.lookup j "status") DocumentStatus.of_json);
        status_information =
          (Util.option_map (Json.lookup j "status_information")
             String.of_json);
        content = (Util.option_map (Json.lookup j "content") String.of_json);
        document_type =
          (Util.option_map (Json.lookup j "document_type")
             DocumentType.of_json);
        document_format =
          (Util.option_map (Json.lookup j "document_format")
             DocumentFormat.of_json);
        requires =
          (DocumentRequiresList.of_json
             (Util.of_option_exn (Json.lookup j "requires")));
        attachments_content =
          (AttachmentContentList.of_json
             (Util.of_option_exn (Json.lookup j "attachments_content")))
      }
  end
module ListResourceDataSyncResult =
  struct
    type t =
      {
      resource_data_sync_items: ResourceDataSyncItemList.t
        [@ocaml.doc
          "<p>A list of your current Resource Data Sync configurations and their statuses.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token for the next set of items to return. Use this token to get the next set of results.</p>"]}
    let make ?(resource_data_sync_items= [])  ?next_token  () =
      { resource_data_sync_items; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("resource_data_sync_items",
               (ResourceDataSyncItemList.to_json v.resource_data_sync_items))])
    let of_json j =
      {
        resource_data_sync_items =
          (ResourceDataSyncItemList.of_json
             (Util.of_option_exn (Json.lookup j "resource_data_sync_items")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetParametersResult =
  struct
    type t =
      {
      parameters: ParameterList.t
        [@ocaml.doc "<p>A list of details for a parameter.</p>"];
      invalid_parameters: ParameterNameList.t
        [@ocaml.doc
          "<p>A list of parameters that are not formatted correctly or do not run during an execution.</p>"]}
    let make ?(parameters= [])  ?(invalid_parameters= [])  () =
      { parameters; invalid_parameters }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("invalid_parameters",
                (ParameterNameList.to_json v.invalid_parameters));
           Some ("parameters", (ParameterList.to_json v.parameters))])
    let of_json j =
      {
        parameters =
          (ParameterList.of_json
             (Util.of_option_exn (Json.lookup j "parameters")));
        invalid_parameters =
          (ParameterNameList.of_json
             (Util.of_option_exn (Json.lookup j "invalid_parameters")))
      }
  end
module GetMaintenanceWindowResult =
  struct
    type t =
      {
      window_id: String.t option
        [@ocaml.doc "<p>The ID of the created maintenance window.</p>"];
      name: String.t option
        [@ocaml.doc "<p>The name of the maintenance window.</p>"];
      description: String.t option
        [@ocaml.doc "<p>The description of the maintenance window.</p>"];
      start_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become active. The maintenance window will not run before this specified time.</p>"];
      end_date: String.t option
        [@ocaml.doc
          "<p>The date and time, in ISO-8601 Extended format, for when the maintenance window is scheduled to become inactive. The maintenance window will not run after this specified time.</p>"];
      schedule: String.t option
        [@ocaml.doc
          "<p>The schedule of the maintenance window in the form of a cron or rate expression.</p>"];
      schedule_timezone: String.t option
        [@ocaml.doc
          "<p>The time zone that the scheduled maintenance window executions are based on, in Internet Assigned Numbers Authority (IANA) format. For example: \"America/Los_Angeles\", \"etc/UTC\", or \"Asia/Seoul\". For more information, see the <a href=\"https://www.iana.org/time-zones\">Time Zone Database</a> on the IANA website.</p>"];
      next_execution_time: String.t option
        [@ocaml.doc
          "<p>The next time the maintenance window will actually run, taking into account any specified times for the maintenance window to become active or inactive.</p>"];
      duration: Integer.t option
        [@ocaml.doc
          "<p>The duration of the maintenance window in hours.</p>"];
      cutoff: Integer.t option
        [@ocaml.doc
          "<p>The number of hours before the end of the maintenance window that Systems Manager stops scheduling new tasks for execution.</p>"];
      allow_unassociated_targets: Boolean.t option
        [@ocaml.doc
          "<p>Whether targets must be registered with the maintenance window before tasks can be defined for those targets.</p>"];
      enabled: Boolean.t option
        [@ocaml.doc
          "<p>Indicates whether the maintenance window is enabled.</p>"];
      created_date: DateTime.t option
        [@ocaml.doc "<p>The date the maintenance window was created.</p>"];
      modified_date: DateTime.t option
        [@ocaml.doc
          "<p>The date the maintenance window was last modified.</p>"]}
    let make ?window_id  ?name  ?description  ?start_date  ?end_date 
      ?schedule  ?schedule_timezone  ?next_execution_time  ?duration  ?cutoff
       ?allow_unassociated_targets  ?enabled  ?created_date  ?modified_date 
      () =
      {
        window_id;
        name;
        description;
        start_date;
        end_date;
        schedule;
        schedule_timezone;
        next_execution_time;
        duration;
        cutoff;
        allow_unassociated_targets;
        enabled;
        created_date;
        modified_date
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.modified_date
              (fun f -> ("modified_date", (DateTime.to_json f)));
           Util.option_map v.created_date
             (fun f -> ("created_date", (DateTime.to_json f)));
           Util.option_map v.enabled
             (fun f -> ("enabled", (Boolean.to_json f)));
           Util.option_map v.allow_unassociated_targets
             (fun f -> ("allow_unassociated_targets", (Boolean.to_json f)));
           Util.option_map v.cutoff
             (fun f -> ("cutoff", (Integer.to_json f)));
           Util.option_map v.duration
             (fun f -> ("duration", (Integer.to_json f)));
           Util.option_map v.next_execution_time
             (fun f -> ("next_execution_time", (String.to_json f)));
           Util.option_map v.schedule_timezone
             (fun f -> ("schedule_timezone", (String.to_json f)));
           Util.option_map v.schedule
             (fun f -> ("schedule", (String.to_json f)));
           Util.option_map v.end_date
             (fun f -> ("end_date", (String.to_json f)));
           Util.option_map v.start_date
             (fun f -> ("start_date", (String.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Util.option_map v.window_id
             (fun f -> ("window_id", (String.to_json f)))])
    let of_json j =
      {
        window_id =
          (Util.option_map (Json.lookup j "window_id") String.of_json);
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        start_date =
          (Util.option_map (Json.lookup j "start_date") String.of_json);
        end_date =
          (Util.option_map (Json.lookup j "end_date") String.of_json);
        schedule =
          (Util.option_map (Json.lookup j "schedule") String.of_json);
        schedule_timezone =
          (Util.option_map (Json.lookup j "schedule_timezone") String.of_json);
        next_execution_time =
          (Util.option_map (Json.lookup j "next_execution_time")
             String.of_json);
        duration =
          (Util.option_map (Json.lookup j "duration") Integer.of_json);
        cutoff = (Util.option_map (Json.lookup j "cutoff") Integer.of_json);
        allow_unassociated_targets =
          (Util.option_map (Json.lookup j "allow_unassociated_targets")
             Boolean.of_json);
        enabled = (Util.option_map (Json.lookup j "enabled") Boolean.of_json);
        created_date =
          (Util.option_map (Json.lookup j "created_date") DateTime.of_json);
        modified_date =
          (Util.option_map (Json.lookup j "modified_date") DateTime.of_json)
      }
  end
module DescribeMaintenanceWindowExecutionsResult =
  struct
    type t =
      {
      window_executions: MaintenanceWindowExecutionList.t
        [@ocaml.doc
          "<p>Information about the maintenance window executions.</p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(window_executions= [])  ?next_token  () =
      { window_executions; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("window_executions",
               (MaintenanceWindowExecutionList.to_json v.window_executions))])
    let of_json j =
      {
        window_executions =
          (MaintenanceWindowExecutionList.of_json
             (Util.of_option_exn (Json.lookup j "window_executions")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetCommandInvocationResult =
  struct
    type t =
      {
      command_id: String.t option
        [@ocaml.doc "<p>The parent command ID of the invocation plugin.</p>"];
      instance_id: String.t option
        [@ocaml.doc
          "<p>The ID of the managed instance targeted by the command. A managed instance can be an Amazon EC2 instance or an instance in your hybrid environment that is configured for Systems Manager.</p>"];
      comment: String.t option
        [@ocaml.doc "<p>The comment text for the command.</p>"];
      document_name: String.t option
        [@ocaml.doc
          "<p>The name of the document that was run. For example, AWS-RunShellScript.</p>"];
      document_version: String.t option
        [@ocaml.doc "<p>The SSM document version used in the request.</p>"];
      plugin_name: String.t option
        [@ocaml.doc
          "<p>The name of the plugin for which you want detailed results. For example, aws:RunShellScript is a plugin.</p>"];
      response_code: Integer.t option
        [@ocaml.doc
          "<p>The error level response code for the plugin script. If the response code is -1, then the command has not started running on the instance, or it was not received by the instance.</p>"];
      execution_start_date_time: String.t option
        [@ocaml.doc
          "<p>The date and time the plugin started running. Date and time are written in ISO 8601 format. For example, June 7, 2017 is represented as 2017-06-7. The following sample AWS CLI command uses the <code>InvokedBefore</code> filter.</p> <p> <code>aws ssm list-commands --filters key=InvokedBefore,value=2017-06-07T00:00:00Z</code> </p> <p>If the plugin has not started to run, the string is empty.</p>"];
      execution_elapsed_time: String.t option
        [@ocaml.doc "<p>Duration since ExecutionStartDateTime.</p>"];
      execution_end_date_time: String.t option
        [@ocaml.doc
          "<p>The date and time the plugin was finished running. Date and time are written in ISO 8601 format. For example, June 7, 2017 is represented as 2017-06-7. The following sample AWS CLI command uses the <code>InvokedAfter</code> filter.</p> <p> <code>aws ssm list-commands --filters key=InvokedAfter,value=2017-06-07T00:00:00Z</code> </p> <p>If the plugin has not started to run, the string is empty.</p>"];
      status: CommandInvocationStatus.t option
        [@ocaml.doc
          "<p>The status of this invocation plugin. This status can be different than StatusDetails.</p>"];
      status_details: String.t option
        [@ocaml.doc
          "<p>A detailed status of the command execution for an invocation. StatusDetails includes more information than Status because it includes states resulting from error and concurrency control parameters. StatusDetails can show different results than Status. For more information about these statuses, see <a href=\"http://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html\">Understanding Command Statuses</a> in the <i>AWS Systems Manager User Guide</i>. StatusDetails can be one of the following values:</p> <ul> <li> <p>Pending: The command has not been sent to the instance.</p> </li> <li> <p>In Progress: The command has been sent to the instance but has not reached a terminal state.</p> </li> <li> <p>Delayed: The system attempted to send the command to the target, but the target was not available. The instance might not be available because of network issues, the instance was stopped, etc. The system will try to deliver the command again.</p> </li> <li> <p>Success: The command or plugin was run successfully. This is a terminal state.</p> </li> <li> <p>Delivery Timed Out: The command was not delivered to the instance before the delivery timeout expired. Delivery timeouts do not count against the parent command's MaxErrors limit, but they do contribute to whether the parent command status is Success or Incomplete. This is a terminal state.</p> </li> <li> <p>Execution Timed Out: The command started to run on the instance, but the execution was not complete before the timeout expired. Execution timeouts count against the MaxErrors limit of the parent command. This is a terminal state.</p> </li> <li> <p>Failed: The command wasn't run successfully on the instance. For a plugin, this indicates that the result code was not zero. For a command invocation, this indicates that the result code for one or more plugins was not zero. Invocation failures count against the MaxErrors limit of the parent command. This is a terminal state.</p> </li> <li> <p>Canceled: The command was terminated before it was completed. This is a terminal state.</p> </li> <li> <p>Undeliverable: The command can't be delivered to the instance. The instance might not exist or might not be responding. Undeliverable invocations don't count against the parent command's MaxErrors limit and don't contribute to whether the parent command status is Success or Incomplete. This is a terminal state.</p> </li> <li> <p>Terminated: The parent command exceeded its MaxErrors limit and subsequent command invocations were canceled by the system. This is a terminal state.</p> </li> </ul>"];
      standard_output_content: String.t option
        [@ocaml.doc
          "<p>The first 24,000 characters written by the plugin to stdout. If the command has not finished running, if ExecutionStatus is neither Succeeded nor Failed, then this string is empty.</p>"];
      standard_output_url: String.t option
        [@ocaml.doc
          "<p>The URL for the complete text written by the plugin to stdout in Amazon S3. If an Amazon S3 bucket was not specified, then this string is empty.</p>"];
      standard_error_content: String.t option
        [@ocaml.doc
          "<p>The first 8,000 characters written by the plugin to stderr. If the command has not finished running, then this string is empty.</p>"];
      standard_error_url: String.t option
        [@ocaml.doc
          "<p>The URL for the complete text written by the plugin to stderr. If the command has not finished running, then this string is empty.</p>"];
      cloud_watch_output_config: CloudWatchOutputConfig.t option
        [@ocaml.doc
          "<p>CloudWatch Logs information where Systems Manager sent the command output.</p>"]}
    let make ?command_id  ?instance_id  ?comment  ?document_name 
      ?document_version  ?plugin_name  ?response_code 
      ?execution_start_date_time  ?execution_elapsed_time 
      ?execution_end_date_time  ?status  ?status_details 
      ?standard_output_content  ?standard_output_url  ?standard_error_content
       ?standard_error_url  ?cloud_watch_output_config  () =
      {
        command_id;
        instance_id;
        comment;
        document_name;
        document_version;
        plugin_name;
        response_code;
        execution_start_date_time;
        execution_elapsed_time;
        execution_end_date_time;
        status;
        status_details;
        standard_output_content;
        standard_output_url;
        standard_error_content;
        standard_error_url;
        cloud_watch_output_config
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_watch_output_config
              (fun f ->
                 ("cloud_watch_output_config",
                   (CloudWatchOutputConfig.to_json f)));
           Util.option_map v.standard_error_url
             (fun f -> ("standard_error_url", (String.to_json f)));
           Util.option_map v.standard_error_content
             (fun f -> ("standard_error_content", (String.to_json f)));
           Util.option_map v.standard_output_url
             (fun f -> ("standard_output_url", (String.to_json f)));
           Util.option_map v.standard_output_content
             (fun f -> ("standard_output_content", (String.to_json f)));
           Util.option_map v.status_details
             (fun f -> ("status_details", (String.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (CommandInvocationStatus.to_json f)));
           Util.option_map v.execution_end_date_time
             (fun f -> ("execution_end_date_time", (String.to_json f)));
           Util.option_map v.execution_elapsed_time
             (fun f -> ("execution_elapsed_time", (String.to_json f)));
           Util.option_map v.execution_start_date_time
             (fun f -> ("execution_start_date_time", (String.to_json f)));
           Util.option_map v.response_code
             (fun f -> ("response_code", (Integer.to_json f)));
           Util.option_map v.plugin_name
             (fun f -> ("plugin_name", (String.to_json f)));
           Util.option_map v.document_version
             (fun f -> ("document_version", (String.to_json f)));
           Util.option_map v.document_name
             (fun f -> ("document_name", (String.to_json f)));
           Util.option_map v.comment
             (fun f -> ("comment", (String.to_json f)));
           Util.option_map v.instance_id
             (fun f -> ("instance_id", (String.to_json f)));
           Util.option_map v.command_id
             (fun f -> ("command_id", (String.to_json f)))])
    let of_json j =
      {
        command_id =
          (Util.option_map (Json.lookup j "command_id") String.of_json);
        instance_id =
          (Util.option_map (Json.lookup j "instance_id") String.of_json);
        comment = (Util.option_map (Json.lookup j "comment") String.of_json);
        document_name =
          (Util.option_map (Json.lookup j "document_name") String.of_json);
        document_version =
          (Util.option_map (Json.lookup j "document_version") String.of_json);
        plugin_name =
          (Util.option_map (Json.lookup j "plugin_name") String.of_json);
        response_code =
          (Util.option_map (Json.lookup j "response_code") Integer.of_json);
        execution_start_date_time =
          (Util.option_map (Json.lookup j "execution_start_date_time")
             String.of_json);
        execution_elapsed_time =
          (Util.option_map (Json.lookup j "execution_elapsed_time")
             String.of_json);
        execution_end_date_time =
          (Util.option_map (Json.lookup j "execution_end_date_time")
             String.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             CommandInvocationStatus.of_json);
        status_details =
          (Util.option_map (Json.lookup j "status_details") String.of_json);
        standard_output_content =
          (Util.option_map (Json.lookup j "standard_output_content")
             String.of_json);
        standard_output_url =
          (Util.option_map (Json.lookup j "standard_output_url")
             String.of_json);
        standard_error_content =
          (Util.option_map (Json.lookup j "standard_error_content")
             String.of_json);
        standard_error_url =
          (Util.option_map (Json.lookup j "standard_error_url")
             String.of_json);
        cloud_watch_output_config =
          (Util.option_map (Json.lookup j "cloud_watch_output_config")
             CloudWatchOutputConfig.of_json)
      }
  end
module DescribePatchGroupsResult =
  struct
    type t =
      {
      mappings: PatchGroupPatchBaselineMappingList.t
        [@ocaml.doc
          "<p>Each entry in the array contains:</p> <p>PatchGroup: string (between 1 and 256 characters, Regex: ^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-@]*)$)</p> <p>PatchBaselineIdentity: A PatchBaselineIdentity element. </p>"];
      next_token: String.t option
        [@ocaml.doc
          "<p>The token to use when requesting the next set of items. If there are no additional items to return, the string is empty.</p>"]}
    let make ?(mappings= [])  ?next_token  () = { mappings; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some
             ("mappings",
               (PatchGroupPatchBaselineMappingList.to_json v.mappings))])
    let of_json j =
      {
        mappings =
          (PatchGroupPatchBaselineMappingList.of_json
             (Util.of_option_exn (Json.lookup j "mappings")));
        next_token =
          (Util.option_map (Json.lookup j "next_token") String.of_json)
      }
  end
module GetDefaultPatchBaselineResult =
  struct
    type t =
      {
      baseline_id: String.t option
        [@ocaml.doc "<p>The ID of the default patch baseline.</p>"];
      operating_system: OperatingSystem.t option
        [@ocaml.doc
          "<p>The operating system for the returned patch baseline. </p>"]}
    let make ?baseline_id  ?operating_system  () =
      { baseline_id; operating_system }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.operating_system
              (fun f -> ("operating_system", (OperatingSystem.to_json f)));
           Util.option_map v.baseline_id
             (fun f -> ("baseline_id", (String.to_json f)))])
    let of_json j =
      {
        baseline_id =
          (Util.option_map (Json.lookup j "baseline_id") String.of_json);
        operating_system =
          (Util.option_map (Json.lookup j "operating_system")
             OperatingSystem.of_json)
      }
  end