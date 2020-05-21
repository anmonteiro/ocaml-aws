open Aws
open Aws.BaseTypes
module ReplaceableAttribute =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "The name of the replaceable attribute."];
      value: String.t [@ocaml.doc "The value of the replaceable attribute."];
      replace: Boolean.t option
        [@ocaml.doc
          "A flag specifying whether or not to replace the attribute/value pair or to add a new attribute/value pair. The default setting is <code>false</code>."]}
    [@@ocaml.doc "<p></p>"]
    let make ~name  ~value  ?replace  () = { name; value; replace }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replace
              (fun f -> ("replace", (Boolean.to_json f)));
           Some ("value", (String.to_json v.value));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse));
          replace =
            (Util.option_bind (Xml.member "Replace" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
            @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
           @
           [Util.option_map v.replace
              (fun f -> Ezxmlm.make_tag "Replace" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc "<p></p>"]
module Attribute =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "The name of the attribute."];
      alternate_name_encoding: String.t option [@ocaml.doc "<p></p>"];
      value: String.t [@ocaml.doc "The value of the attribute."];
      alternate_value_encoding: String.t option [@ocaml.doc "<p></p>"]}
    [@@ocaml.doc "<p></p>"]
    let make ~name  ?alternate_name_encoding  ~value 
      ?alternate_value_encoding  () =
      { name; alternate_name_encoding; value; alternate_value_encoding }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.alternate_value_encoding
              (fun f -> ("alternate_value_encoding", (String.to_json f)));
           Some ("value", (String.to_json v.value));
           Util.option_map v.alternate_name_encoding
             (fun f -> ("alternate_name_encoding", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          alternate_name_encoding =
            (Util.option_bind (Xml.member "AlternateNameEncoding" xml)
               String.parse);
          value =
            (Xml.required "Value"
               (Util.option_bind (Xml.member "Value" xml) String.parse));
          alternate_value_encoding =
            (Util.option_bind (Xml.member "AlternateValueEncoding" xml)
               String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (((([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
             @
             [Util.option_map v.alternate_name_encoding
                (fun f ->
                   Ezxmlm.make_tag "AlternateNameEncoding"
                     ([], (String.to_xml f)))])
            @ [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
           @
           [Util.option_map v.alternate_value_encoding
              (fun f ->
                 Ezxmlm.make_tag "AlternateValueEncoding"
                   ([], (String.to_xml f)))])
  end[@@ocaml.doc "<p></p>"]
module ReplaceableAttributeList =
  struct
    type t = ReplaceableAttribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReplaceableAttribute.to_query v
    let to_headers v =
      Headers.to_headers_list ReplaceableAttribute.to_headers v
    let to_json v = `List (List.map ReplaceableAttribute.to_json v)
    let parse xml =
      Util.option_all (List.map ReplaceableAttribute.parse [xml])
    let to_xml v = List.concat (List.map ReplaceableAttribute.to_xml v)
  end
module AttributeList =
  struct
    type t = Attribute.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Attribute.to_query v
    let to_headers v = Headers.to_headers_list Attribute.to_headers v
    let to_json v = `List (List.map Attribute.to_json v)
    let parse xml = Util.option_all (List.map Attribute.parse [xml])
    let to_xml v = List.concat (List.map Attribute.to_xml v)
  end
module ReplaceableItem =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "The name of the replaceable item."];
      attributes: ReplaceableAttributeList.t
        [@ocaml.doc "The list of attributes for a replaceable item."]}
    [@@ocaml.doc "<p></p>"]
    let make ~name  ~attributes  () = { name; attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("attributes", (ReplaceableAttributeList.to_json v.attributes));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "ItemName"
               (Util.option_bind (Xml.member "ItemName" xml) String.parse));
          attributes =
            (Xml.required "Attributes" (ReplaceableAttributeList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "ItemName" ([], (String.to_xml v.name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Attributes"
                      ([], (ReplaceableAttributeList.to_xml [x]))))
              v.attributes))
  end[@@ocaml.doc "<p></p>"]
module DeletableItem =
  struct
    type t = {
      name: String.t ;
      attributes: AttributeList.t }
    let make ~name  ?(attributes= [])  () = { name; attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("attributes", (AttributeList.to_json v.attributes));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "ItemName"
               (Util.option_bind (Xml.member "ItemName" xml) String.parse));
          attributes = (Util.of_option [] (AttributeList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "ItemName" ([], (String.to_xml v.name)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Attributes"
                      ([], (AttributeList.to_xml [x])))) v.attributes))
  end
module Item =
  struct
    type t =
      {
      name: String.t [@ocaml.doc "The name of the item."];
      alternate_name_encoding: String.t option [@ocaml.doc "<p></p>"];
      attributes: AttributeList.t [@ocaml.doc "A list of attributes."]}
    [@@ocaml.doc "<p></p>"]
    let make ~name  ?alternate_name_encoding  ~attributes  () =
      { name; alternate_name_encoding; attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("attributes", (AttributeList.to_json v.attributes));
           Util.option_map v.alternate_name_encoding
             (fun f -> ("alternate_name_encoding", (String.to_json f)));
           Some ("name", (String.to_json v.name))])
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          alternate_name_encoding =
            (Util.option_bind (Xml.member "AlternateNameEncoding" xml)
               String.parse);
          attributes = (Xml.required "Attributes" (AttributeList.parse xml))
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
            @
            [Util.option_map v.alternate_name_encoding
               (fun f ->
                  Ezxmlm.make_tag "AlternateNameEncoding"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Attributes"
                      ([], (AttributeList.to_xml [x])))) v.attributes))
  end[@@ocaml.doc "<p></p>"]
module UpdateCondition =
  struct
    type t =
      {
      name: String.t option
        [@ocaml.doc
          "<p>The name of the attribute involved in the condition.</p>"];
      value: String.t option
        [@ocaml.doc
          "<p>The value of an attribute. This value can only be specified when the <code>Exists</code> parameter is equal to <code>true</code>.</p>"];
      exists: Boolean.t option
        [@ocaml.doc
          "<p>A value specifying whether or not the specified attribute must exist with the specified value in order for the update condition to be satisfied. Specify <code>true</code> if the attribute must exist for the update condition to be satisfied. Specify <code>false</code> if the attribute should not exist in order for the update condition to be satisfied.</p>"]}
    [@@ocaml.doc
      "<p> Specifies the conditions under which data should be updated. If an update condition is specified for a request, the data will only be updated if the condition is satisfied. For example, if an attribute with a specific name and value exists, or if a specific attribute doesn't exist. </p>"]
    let make ?name  ?value  ?exists  () = { name; value; exists }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.exists
              (fun f -> ("exists", (Boolean.to_json f)));
           Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse);
          exists = (Util.option_bind (Xml.member "Exists" xml) Boolean.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.name
                (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
            @
            [Util.option_map v.value
               (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
           @
           [Util.option_map v.exists
              (fun f -> Ezxmlm.make_tag "Exists" ([], (Boolean.to_xml f)))])
  end[@@ocaml.doc
       "<p> Specifies the conditions under which data should be updated. If an update condition is specified for a request, the data will only be updated if the condition is satisfied. For example, if an attribute with a specific name and value exists, or if a specific attribute doesn't exist. </p>"]
module ReplaceableItemList =
  struct
    type t = ReplaceableItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list ReplaceableItem.to_query v
    let to_headers v = Headers.to_headers_list ReplaceableItem.to_headers v
    let to_json v = `List (List.map ReplaceableItem.to_json v)
    let parse xml = Util.option_all (List.map ReplaceableItem.parse [xml])
    let to_xml v = List.concat (List.map ReplaceableItem.to_xml v)
  end
module AttributeNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module DeletableItemList =
  struct
    type t = DeletableItem.t list
    let make elems () = elems
    let to_query v = Query.to_query_list DeletableItem.to_query v
    let to_headers v = Headers.to_headers_list DeletableItem.to_headers v
    let to_json v = `List (List.map DeletableItem.to_json v)
    let parse xml = Util.option_all (List.map DeletableItem.parse [xml])
    let to_xml v = List.concat (List.map DeletableItem.to_xml v)
  end
module ItemList =
  struct
    type t = Item.t list
    let make elems () = elems
    let to_query v = Query.to_query_list Item.to_query v
    let to_headers v = Headers.to_headers_list Item.to_headers v
    let to_json v = `List (List.map Item.to_json v)
    let parse xml = Util.option_all (List.map Item.parse [xml])
    let to_xml v = List.concat (List.map Item.to_xml v)
  end
module DomainNameList =
  struct
    type t = String.t list
    let make elems () = elems
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_json v = `List (List.map String.to_json v)
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_xml v = List.concat (List.map String.to_xml v)
  end
module GetAttributesResult =
  struct
    type t =
      {
      attributes: AttributeList.t
        [@ocaml.doc "The list of attributes returned by the operation."]}
    let make ?(attributes= [])  () = { attributes }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("attributes", (AttributeList.to_json v.attributes))])
    let parse xml =
      Some { attributes = (Util.of_option [] (AttributeList.parse xml)) }
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Attributes"
                      ([], (AttributeList.to_xml [x])))) v.attributes))
  end
module SelectResult =
  struct
    type t =
      {
      items: ItemList.t
        [@ocaml.doc "A list of items that match the select expression."];
      next_token: String.t option
        [@ocaml.doc
          "An opaque token indicating that more items than <code>MaxNumberOfItems</code> were matched, the response size exceeded 1 megabyte, or the execution time exceeded 5 seconds."]}
    let make ?(items= [])  ?next_token  () = { items; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("items", (ItemList.to_json v.items))])
    let parse xml =
      Some
        {
          items = (Util.of_option [] (ItemList.parse xml));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Items" ([], (ItemList.to_xml [x]))))
               v.items))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end
module DomainMetadataResult =
  struct
    type t =
      {
      item_count: Integer.t option
        [@ocaml.doc "The number of all items in the domain."];
      item_names_size_bytes: Long.t option
        [@ocaml.doc
          "The total size of all item names in the domain, in bytes."];
      attribute_name_count: Integer.t option
        [@ocaml.doc "The number of unique attribute names in the domain."];
      attribute_names_size_bytes: Long.t option
        [@ocaml.doc
          "The total size of all unique attribute names in the domain, in bytes."];
      attribute_value_count: Integer.t option
        [@ocaml.doc
          "The number of all attribute name/value pairs in the domain."];
      attribute_values_size_bytes: Long.t option
        [@ocaml.doc
          "The total size of all attribute values in the domain, in bytes."];
      timestamp: Integer.t option
        [@ocaml.doc
          "The data and time when metadata was calculated, in Epoch (UNIX) seconds."]}
    let make ?item_count  ?item_names_size_bytes  ?attribute_name_count 
      ?attribute_names_size_bytes  ?attribute_value_count 
      ?attribute_values_size_bytes  ?timestamp  () =
      {
        item_count;
        item_names_size_bytes;
        attribute_name_count;
        attribute_names_size_bytes;
        attribute_value_count;
        attribute_values_size_bytes;
        timestamp
      }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.timestamp
              (fun f -> ("timestamp", (Integer.to_json f)));
           Util.option_map v.attribute_values_size_bytes
             (fun f -> ("attribute_values_size_bytes", (Long.to_json f)));
           Util.option_map v.attribute_value_count
             (fun f -> ("attribute_value_count", (Integer.to_json f)));
           Util.option_map v.attribute_names_size_bytes
             (fun f -> ("attribute_names_size_bytes", (Long.to_json f)));
           Util.option_map v.attribute_name_count
             (fun f -> ("attribute_name_count", (Integer.to_json f)));
           Util.option_map v.item_names_size_bytes
             (fun f -> ("item_names_size_bytes", (Long.to_json f)));
           Util.option_map v.item_count
             (fun f -> ("item_count", (Integer.to_json f)))])
    let parse xml =
      Some
        {
          item_count =
            (Util.option_bind (Xml.member "ItemCount" xml) Integer.parse);
          item_names_size_bytes =
            (Util.option_bind (Xml.member "ItemNamesSizeBytes" xml)
               Long.parse);
          attribute_name_count =
            (Util.option_bind (Xml.member "AttributeNameCount" xml)
               Integer.parse);
          attribute_names_size_bytes =
            (Util.option_bind (Xml.member "AttributeNamesSizeBytes" xml)
               Long.parse);
          attribute_value_count =
            (Util.option_bind (Xml.member "AttributeValueCount" xml)
               Integer.parse);
          attribute_values_size_bytes =
            (Util.option_bind (Xml.member "AttributeValuesSizeBytes" xml)
               Long.parse);
          timestamp =
            (Util.option_bind (Xml.member "Timestamp" xml) Integer.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.item_count
                    (fun f ->
                       Ezxmlm.make_tag "ItemCount" ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.item_names_size_bytes
                   (fun f ->
                      Ezxmlm.make_tag "ItemNamesSizeBytes"
                        ([], (Long.to_xml f)))])
               @
               [Util.option_map v.attribute_name_count
                  (fun f ->
                     Ezxmlm.make_tag "AttributeNameCount"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.attribute_names_size_bytes
                 (fun f ->
                    Ezxmlm.make_tag "AttributeNamesSizeBytes"
                      ([], (Long.to_xml f)))])
             @
             [Util.option_map v.attribute_value_count
                (fun f ->
                   Ezxmlm.make_tag "AttributeValueCount"
                     ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.attribute_values_size_bytes
               (fun f ->
                  Ezxmlm.make_tag "AttributeValuesSizeBytes"
                    ([], (Long.to_xml f)))])
           @
           [Util.option_map v.timestamp
              (fun f -> Ezxmlm.make_tag "Timestamp" ([], (Integer.to_xml f)))])
  end
module ListDomainsResult =
  struct
    type t =
      {
      domain_names: DomainNameList.t
        [@ocaml.doc "A list of domain names that match the expression."];
      next_token: String.t option
        [@ocaml.doc
          "An opaque token indicating that there are more domains than the specified <code>MaxNumberOfDomains</code> still available."]}
    let make ?(domain_names= [])  ?next_token  () =
      { domain_names; next_token }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_token
              (fun f -> ("next_token", (String.to_json f)));
           Some ("domain_names", (DomainNameList.to_json v.domain_names))])
    let parse xml =
      Some
        {
          domain_names = (Util.of_option [] (DomainNameList.parse xml));
          next_token =
            (Util.option_bind (Xml.member "NextToken" xml) String.parse)
        }
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "DomainNames"
                       ([], (DomainNameList.to_xml [x])))) v.domain_names))
           @
           [Util.option_map v.next_token
              (fun f -> Ezxmlm.make_tag "NextToken" ([], (String.to_xml f)))])
  end