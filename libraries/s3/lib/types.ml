open Aws
open Aws.BaseTypes
open CalendarLib
type calendar = Calendar.t
module FilterRuleName =
  struct
    type t =
      | Prefix 
      | Suffix 
    let str_to_t = [("suffix", Suffix); ("prefix", Prefix)]
    let t_to_str = [(Suffix, "suffix"); (Prefix, "prefix")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Tag =
  struct
    type t = {
      key: String.t ;
      value: String.t }
    let make ~key  ~value  () = { key; value }
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
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Some (Ezxmlm.make_tag "Value" ([], (String.to_xml v.value)))])
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
  end
module AnalyticsS3ExportFileFormat =
  struct
    type t =
      | CSV 
    let str_to_t = [("CSV", CSV)]
    let t_to_str = [(CSV, "CSV")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Type =
  struct
    type t =
      | CanonicalUser 
      | AmazonCustomerByEmail 
      | Group 
    let str_to_t =
      [("Group", Group);
      ("AmazonCustomerByEmail", AmazonCustomerByEmail);
      ("CanonicalUser", CanonicalUser)]
    let t_to_str =
      [(Group, "Group");
      (AmazonCustomerByEmail, "AmazonCustomerByEmail");
      (CanonicalUser, "CanonicalUser")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module FilterRule =
  struct
    type t = {
      name: FilterRuleName.t option ;
      value: String.t option }
    let make ?name  ?value  () = { name; value }
    let parse xml =
      Some
        {
          name =
            (Util.option_bind (Xml.member "Name" xml) FilterRuleName.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.name
               (fun f ->
                  Ezxmlm.make_tag "Name" ([], (FilterRuleName.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name
             (fun f -> ("name", (FilterRuleName.to_json f)))])
    let of_json j =
      {
        name =
          (Util.option_map (Json.lookup j "name") FilterRuleName.of_json);
        value = (Util.option_map (Json.lookup j "value") String.of_json)
      }
  end
module OwnerOverride =
  struct
    type t =
      | Destination 
    let str_to_t = [("Destination", Destination)]
    let t_to_str = [(Destination, "Destination")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module MetricsStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ReplicationTimeValue =
  struct
    type t = {
      minutes: Integer.t option }
    let make ?minutes  () = { minutes }
    let parse xml =
      Some
        {
          minutes =
            (Util.option_bind (Xml.member "Minutes" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.minutes
              (fun f -> Ezxmlm.make_tag "Minutes" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.minutes
              (fun f -> ("minutes", (Integer.to_json f)))])
    let of_json j =
      { minutes = (Util.option_map (Json.lookup j "minutes") Integer.of_json)
      }
  end
module ReplicationTimeStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module TagSet =
  struct
    type t = Tag.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Tag.parse (Xml.members "Tag" xml))
    let to_query v = Query.to_query_list Tag.to_query v
    let to_headers v = Headers.to_headers_list Tag.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Tag.to_xml x))) v
    let to_json v = `List (List.map Tag.to_json v)
    let of_json j = Json.to_list Tag.of_json j
  end
module SseKmsEncryptedObjectsStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module AnalyticsS3BucketDestination =
  struct
    type t =
      {
      format: AnalyticsS3ExportFileFormat.t ;
      bucket_account_id: String.t option ;
      bucket: String.t ;
      prefix: String.t option }
    let make ~format  ?bucket_account_id  ~bucket  ?prefix  () =
      { format; bucket_account_id; bucket; prefix }
    let parse xml =
      Some
        {
          format =
            (Xml.required "Format"
               (Util.option_bind (Xml.member "Format" xml)
                  AnalyticsS3ExportFileFormat.parse));
          bucket_account_id =
            (Util.option_bind (Xml.member "BucketAccountId" xml) String.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "Format"
                    ([], (AnalyticsS3ExportFileFormat.to_xml v.format)))])
             @
             [Util.option_map v.bucket_account_id
                (fun f ->
                   Ezxmlm.make_tag "BucketAccountId" ([], (String.to_xml f)))])
            @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.prefix
              (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> ("prefix", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.bucket_account_id
             (fun f -> ("bucket_account_id", (String.to_json f)));
           Some ("format", (AnalyticsS3ExportFileFormat.to_json v.format))])
    let of_json j =
      {
        format =
          (AnalyticsS3ExportFileFormat.of_json
             (Util.of_option_exn (Json.lookup j "format")));
        bucket_account_id =
          (Util.option_map (Json.lookup j "bucket_account_id") String.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json)
      }
  end
module Grantee =
  struct
    type t =
      {
      display_name: String.t option ;
      email_address: String.t option ;
      i_d: String.t option ;
      type_: Type.t ;
      u_r_i: String.t option }
    let make ?display_name  ?email_address  ?i_d  ~type_  ?u_r_i  () =
      { display_name; email_address; i_d; type_; u_r_i }
    let parse xml =
      Some
        {
          display_name =
            (Util.option_bind (Xml.member "DisplayName" xml) String.parse);
          email_address =
            (Util.option_bind (Xml.member "EmailAddress" xml) String.parse);
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse);
          type_ =
            (Xml.required "xsi:type"
               (Util.option_bind (Xml.member "xsi:type" xml) Type.parse));
          u_r_i = (Util.option_bind (Xml.member "URI" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.display_name
                  (fun f ->
                     Ezxmlm.make_tag "DisplayName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.email_address
                 (fun f ->
                    Ezxmlm.make_tag "EmailAddress" ([], (String.to_xml f)))])
             @
             [Util.option_map v.i_d
                (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
            @ [Some (Ezxmlm.make_tag "xsi:type" ([], (Type.to_xml v.type_)))])
           @
           [Util.option_map v.u_r_i
              (fun f -> Ezxmlm.make_tag "URI" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.u_r_i (fun f -> ("u_r_i", (String.to_json f)));
           Some ("type_", (Type.to_json v.type_));
           Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)));
           Util.option_map v.email_address
             (fun f -> ("email_address", (String.to_json f)));
           Util.option_map v.display_name
             (fun f -> ("display_name", (String.to_json f)))])
    let of_json j =
      {
        display_name =
          (Util.option_map (Json.lookup j "display_name") String.of_json);
        email_address =
          (Util.option_map (Json.lookup j "email_address") String.of_json);
        i_d = (Util.option_map (Json.lookup j "i_d") String.of_json);
        type_ = (Type.of_json (Util.of_option_exn (Json.lookup j "type_")));
        u_r_i = (Util.option_map (Json.lookup j "u_r_i") String.of_json)
      }
  end
module Permission =
  struct
    type t =
      | FULL_CONTROL 
      | WRITE 
      | WRITE_ACP 
      | READ 
      | READ_ACP 
    let str_to_t =
      [("READ_ACP", READ_ACP);
      ("READ", READ);
      ("WRITE_ACP", WRITE_ACP);
      ("WRITE", WRITE);
      ("FULL_CONTROL", FULL_CONTROL)]
    let t_to_str =
      [(READ_ACP, "READ_ACP");
      (READ, "READ");
      (WRITE_ACP, "WRITE_ACP");
      (WRITE, "WRITE");
      (FULL_CONTROL, "FULL_CONTROL")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module SSEKMS =
  struct
    type t = {
      key_id: String.t }
    let make ~key_id  () = { key_id }
    let parse xml =
      Some
        {
          key_id =
            (Xml.required "KeyId"
               (Util.option_bind (Xml.member "KeyId" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "KeyId" ([], (String.to_xml v.key_id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("key_id", (String.to_json v.key_id))])
    let of_json j =
      {
        key_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "key_id")))
      }
  end
module SSES3 =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module TransitionStorageClass =
  struct
    type t =
      | GLACIER 
      | STANDARD_IA 
      | ONEZONE_IA 
      | INTELLIGENT_TIERING 
      | DEEP_ARCHIVE 
    let str_to_t =
      [("DEEP_ARCHIVE", DEEP_ARCHIVE);
      ("INTELLIGENT_TIERING", INTELLIGENT_TIERING);
      ("ONEZONE_IA", ONEZONE_IA);
      ("STANDARD_IA", STANDARD_IA);
      ("GLACIER", GLACIER)]
    let t_to_str =
      [(DEEP_ARCHIVE, "DEEP_ARCHIVE");
      (INTELLIGENT_TIERING, "INTELLIGENT_TIERING");
      (ONEZONE_IA, "ONEZONE_IA");
      (STANDARD_IA, "STANDARD_IA");
      (GLACIER, "GLACIER")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module FilterRuleList =
  struct
    type t = FilterRule.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map FilterRule.parse [xml])
    let to_query v = Query.to_query_list FilterRule.to_query v
    let to_headers v = Headers.to_headers_list FilterRule.to_headers v
    let to_xml v = List.concat (List.map FilterRule.to_xml v)
    let to_json v = `List (List.map FilterRule.to_json v)
    let of_json j = Json.to_list FilterRule.of_json j
  end
module DeleteMarkerReplicationStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module AccessControlTranslation =
  struct
    type t = {
      owner: OwnerOverride.t }
    let make ~owner  () = { owner }
    let parse xml =
      Some
        {
          owner =
            (Xml.required "Owner"
               (Util.option_bind (Xml.member "Owner" xml) OwnerOverride.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Owner" ([], (OwnerOverride.to_xml v.owner)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("owner", (OwnerOverride.to_json v.owner))])
    let of_json j =
      {
        owner =
          (OwnerOverride.of_json (Util.of_option_exn (Json.lookup j "owner")))
      }
  end
module EncryptionConfiguration =
  struct
    type t = {
      replica_kms_key_i_d: String.t option }
    let make ?replica_kms_key_i_d  () = { replica_kms_key_i_d }
    let parse xml =
      Some
        {
          replica_kms_key_i_d =
            (Util.option_bind (Xml.member "ReplicaKmsKeyID" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replica_kms_key_i_d
              (fun f ->
                 Ezxmlm.make_tag "ReplicaKmsKeyID" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replica_kms_key_i_d
              (fun f -> ("replica_kms_key_i_d", (String.to_json f)))])
    let of_json j =
      {
        replica_kms_key_i_d =
          (Util.option_map (Json.lookup j "replica_kms_key_i_d")
             String.of_json)
      }
  end
module Metrics =
  struct
    type t =
      {
      status: MetricsStatus.t ;
      event_threshold: ReplicationTimeValue.t }
    let make ~status  ~event_threshold  () = { status; event_threshold }
    let parse xml =
      Some
        {
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  MetricsStatus.parse));
          event_threshold =
            (Xml.required "EventThreshold"
               (Util.option_bind (Xml.member "EventThreshold" xml)
                  ReplicationTimeValue.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Status"
                  ([], (MetricsStatus.to_xml v.status)))])
           @
           [Some
              (Ezxmlm.make_tag "EventThreshold"
                 ([], (ReplicationTimeValue.to_xml v.event_threshold)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("event_threshold",
                (ReplicationTimeValue.to_json v.event_threshold));
           Some ("status", (MetricsStatus.to_json v.status))])
    let of_json j =
      {
        status =
          (MetricsStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")));
        event_threshold =
          (ReplicationTimeValue.of_json
             (Util.of_option_exn (Json.lookup j "event_threshold")))
      }
  end
module ReplicationTime =
  struct
    type t = {
      status: ReplicationTimeStatus.t ;
      time: ReplicationTimeValue.t }
    let make ~status  ~time  () = { status; time }
    let parse xml =
      Some
        {
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ReplicationTimeStatus.parse));
          time =
            (Xml.required "Time"
               (Util.option_bind (Xml.member "Time" xml)
                  ReplicationTimeValue.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "Status"
                  ([], (ReplicationTimeStatus.to_xml v.status)))])
           @
           [Some
              (Ezxmlm.make_tag "Time"
                 ([], (ReplicationTimeValue.to_xml v.time)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("time", (ReplicationTimeValue.to_json v.time));
           Some ("status", (ReplicationTimeStatus.to_json v.status))])
    let of_json j =
      {
        status =
          (ReplicationTimeStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")));
        time =
          (ReplicationTimeValue.of_json
             (Util.of_option_exn (Json.lookup j "time")))
      }
  end
module StorageClass =
  struct
    type t =
      | STANDARD 
      | REDUCED_REDUNDANCY 
      | STANDARD_IA 
      | ONEZONE_IA 
      | INTELLIGENT_TIERING 
      | GLACIER 
      | DEEP_ARCHIVE 
    let str_to_t =
      [("DEEP_ARCHIVE", DEEP_ARCHIVE);
      ("GLACIER", GLACIER);
      ("INTELLIGENT_TIERING", INTELLIGENT_TIERING);
      ("ONEZONE_IA", ONEZONE_IA);
      ("STANDARD_IA", STANDARD_IA);
      ("REDUCED_REDUNDANCY", REDUCED_REDUNDANCY);
      ("STANDARD", STANDARD)]
    let t_to_str =
      [(DEEP_ARCHIVE, "DEEP_ARCHIVE");
      (GLACIER, "GLACIER");
      (INTELLIGENT_TIERING, "INTELLIGENT_TIERING");
      (ONEZONE_IA, "ONEZONE_IA");
      (STANDARD_IA, "STANDARD_IA");
      (REDUCED_REDUNDANCY, "REDUCED_REDUNDANCY");
      (STANDARD, "STANDARD")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ExistingObjectReplicationStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ReplicationRuleAndOperator =
  struct
    type t = {
      prefix: String.t option ;
      tags: TagSet.t }
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tag" ([], (TagSet.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tags = (TagSet.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module SseKmsEncryptedObjects =
  struct
    type t = {
      status: SseKmsEncryptedObjectsStatus.t }
    let make ~status  () = { status }
    let parse xml =
      Some
        {
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  SseKmsEncryptedObjectsStatus.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Status"
                 ([], (SseKmsEncryptedObjectsStatus.to_xml v.status)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("status", (SseKmsEncryptedObjectsStatus.to_json v.status))])
    let of_json j =
      {
        status =
          (SseKmsEncryptedObjectsStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")))
      }
  end
module ServerSideEncryption =
  struct
    type t =
      | AES256 
      | Aws_kms 
    let str_to_t = [("aws:kms", Aws_kms); ("AES256", AES256)]
    let t_to_str = [(Aws_kms, "aws:kms"); (AES256, "AES256")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module AnalyticsExportDestination =
  struct
    type t = {
      s3_bucket_destination: AnalyticsS3BucketDestination.t }
    let make ~s3_bucket_destination  () = { s3_bucket_destination }
    let parse xml =
      Some
        {
          s3_bucket_destination =
            (Xml.required "S3BucketDestination"
               (Util.option_bind (Xml.member "S3BucketDestination" xml)
                  AnalyticsS3BucketDestination.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "S3BucketDestination"
                 ([],
                   (AnalyticsS3BucketDestination.to_xml
                      v.s3_bucket_destination)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("s3_bucket_destination",
                (AnalyticsS3BucketDestination.to_json v.s3_bucket_destination))])
    let of_json j =
      {
        s3_bucket_destination =
          (AnalyticsS3BucketDestination.of_json
             (Util.of_option_exn (Json.lookup j "s3_bucket_destination")))
      }
  end
module StorageClassAnalysisSchemaVersion =
  struct
    type t =
      | V_1 
    let str_to_t = [("V_1", V_1)]
    let t_to_str = [(V_1, "V_1")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Grant =
  struct
    type t = {
      grantee: Grantee.t option ;
      permission: Permission.t option }
    let make ?grantee  ?permission  () = { grantee; permission }
    let parse xml =
      Some
        {
          grantee =
            (Util.option_bind (Xml.member "Grantee" xml) Grantee.parse);
          permission =
            (Util.option_bind (Xml.member "Permission" xml) Permission.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.grantee
               (fun f -> Ezxmlm.make_tag "Grantee" ([], (Grantee.to_xml f)))])
           @
           [Util.option_map v.permission
              (fun f ->
                 Ezxmlm.make_tag "Permission" ([], (Permission.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.permission
              (fun f -> ("permission", (Permission.to_json f)));
           Util.option_map v.grantee
             (fun f -> ("grantee", (Grantee.to_json f)))])
    let of_json j =
      {
        grantee = (Util.option_map (Json.lookup j "grantee") Grantee.of_json);
        permission =
          (Util.option_map (Json.lookup j "permission") Permission.of_json)
      }
  end
module MetadataEntry =
  struct
    type t = {
      name: String.t option ;
      value: String.t option }
    let make ?name  ?value  () = { name; value }
    let parse xml =
      Some
        {
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          value = (Util.option_bind (Xml.member "Value" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.name
               (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
           @
           [Util.option_map v.value
              (fun f -> Ezxmlm.make_tag "Value" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.value (fun f -> ("value", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)))])
    let of_json j =
      {
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        value = (Util.option_map (Json.lookup j "value") String.of_json)
      }
  end
module FileHeaderInfo =
  struct
    type t =
      | USE 
      | IGNORE 
      | NONE 
    let str_to_t = [("NONE", NONE); ("IGNORE", IGNORE); ("USE", USE)]
    let t_to_str = [(NONE, "NONE"); (IGNORE, "IGNORE"); (USE, "USE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module JSONType =
  struct
    type t =
      | DOCUMENT 
      | LINES 
    let str_to_t = [("LINES", LINES); ("DOCUMENT", DOCUMENT)]
    let t_to_str = [(LINES, "LINES"); (DOCUMENT, "DOCUMENT")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module QuoteFields =
  struct
    type t =
      | ALWAYS 
      | ASNEEDED 
    let str_to_t = [("ASNEEDED", ASNEEDED); ("ALWAYS", ALWAYS)]
    let t_to_str = [(ASNEEDED, "ASNEEDED"); (ALWAYS, "ALWAYS")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module InventoryEncryption =
  struct
    type t = {
      s_s_e_s3: SSES3.t option ;
      s_s_e_k_m_s: SSEKMS.t option }
    let make ?s_s_e_s3  ?s_s_e_k_m_s  () = { s_s_e_s3; s_s_e_k_m_s }
    let parse xml =
      Some
        {
          s_s_e_s3 = (Util.option_bind (Xml.member "SSE-S3" xml) SSES3.parse);
          s_s_e_k_m_s =
            (Util.option_bind (Xml.member "SSE-KMS" xml) SSEKMS.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.s_s_e_s3
               (fun f -> Ezxmlm.make_tag "SSE-S3" ([], (SSES3.to_xml f)))])
           @
           [Util.option_map v.s_s_e_k_m_s
              (fun f -> Ezxmlm.make_tag "SSE-KMS" ([], (SSEKMS.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.s_s_e_k_m_s
              (fun f -> ("s_s_e_k_m_s", (SSEKMS.to_json f)));
           Util.option_map v.s_s_e_s3
             (fun f -> ("s_s_e_s3", (SSES3.to_json f)))])
    let of_json j =
      {
        s_s_e_s3 = (Util.option_map (Json.lookup j "s_s_e_s3") SSES3.of_json);
        s_s_e_k_m_s =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s") SSEKMS.of_json)
      }
  end
module InventoryFormat =
  struct
    type t =
      | CSV 
      | ORC 
      | Parquet 
    let str_to_t = [("Parquet", Parquet); ("ORC", ORC); ("CSV", CSV)]
    let t_to_str = [(Parquet, "Parquet"); (ORC, "ORC"); (CSV, "CSV")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Protocol =
  struct
    type t =
      | Http 
      | Https 
    let str_to_t = [("https", Https); ("http", Http)]
    let t_to_str = [(Https, "https"); (Http, "http")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module BucketLogsPermission =
  struct
    type t =
      | FULL_CONTROL 
      | READ 
      | WRITE 
    let str_to_t =
      [("WRITE", WRITE); ("READ", READ); ("FULL_CONTROL", FULL_CONTROL)]
    let t_to_str =
      [(WRITE, "WRITE"); (READ, "READ"); (FULL_CONTROL, "FULL_CONTROL")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module LifecycleRuleAndOperator =
  struct
    type t = {
      prefix: String.t option ;
      tags: TagSet.t }
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tag" ([], (TagSet.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tags = (TagSet.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module NoncurrentVersionTransition =
  struct
    type t =
      {
      noncurrent_days: Integer.t ;
      storage_class: TransitionStorageClass.t }
    let make ~noncurrent_days  ~storage_class  () =
      { noncurrent_days; storage_class }
    let parse xml =
      Some
        {
          noncurrent_days =
            (Xml.required "NoncurrentDays"
               (Util.option_bind (Xml.member "NoncurrentDays" xml)
                  Integer.parse));
          storage_class =
            (Xml.required "StorageClass"
               (Util.option_bind (Xml.member "StorageClass" xml)
                  TransitionStorageClass.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "NoncurrentDays"
                  ([], (Integer.to_xml v.noncurrent_days)))])
           @
           [Some
              (Ezxmlm.make_tag "StorageClass"
                 ([], (TransitionStorageClass.to_xml v.storage_class)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("storage_class",
                (TransitionStorageClass.to_json v.storage_class));
           Some ("noncurrent_days", (Integer.to_json v.noncurrent_days))])
    let of_json j =
      {
        noncurrent_days =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "noncurrent_days")));
        storage_class =
          (TransitionStorageClass.of_json
             (Util.of_option_exn (Json.lookup j "storage_class")))
      }
  end
module Transition =
  struct
    type t =
      {
      date: DateTime.t option ;
      days: Integer.t option ;
      storage_class: TransitionStorageClass.t option }
    let make ?date  ?days  ?storage_class  () = { date; days; storage_class }
    let parse xml =
      Some
        {
          date = (Util.option_bind (Xml.member "Date" xml) DateTime.parse);
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               TransitionStorageClass.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.date
                (fun f -> Ezxmlm.make_tag "Date" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.days
               (fun f -> Ezxmlm.make_tag "Days" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.storage_class
              (fun f ->
                 Ezxmlm.make_tag "StorageClass"
                   ([], (TransitionStorageClass.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.storage_class
              (fun f -> ("storage_class", (TransitionStorageClass.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)));
           Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)))])
    let of_json j =
      {
        date = (Util.option_map (Json.lookup j "date") DateTime.of_json);
        days = (Util.option_map (Json.lookup j "days") Integer.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             TransitionStorageClass.of_json)
      }
  end
module Event =
  struct
    type t =
      | S3_ReducedRedundancyLostObject 
      | S3_ObjectCreated__ 
      | S3_ObjectCreated_Put 
      | S3_ObjectCreated_Post 
      | S3_ObjectCreated_Copy 
      | S3_ObjectCreated_CompleteMultipartUpload 
      | S3_ObjectRemoved__ 
      | S3_ObjectRemoved_Delete 
      | S3_ObjectRemoved_DeleteMarkerCreated 
      | S3_ObjectRestore__ 
      | S3_ObjectRestore_Post 
      | S3_ObjectRestore_Completed 
      | S3_Replication__ 
      | S3_Replication_OperationFailedReplication 
      | S3_Replication_OperationNotTracked 
      | S3_Replication_OperationMissedThreshold 
      | S3_Replication_OperationReplicatedAfterThreshold 
    let str_to_t =
      [("s3:Replication:OperationReplicatedAfterThreshold",
         S3_Replication_OperationReplicatedAfterThreshold);
      ("s3:Replication:OperationMissedThreshold",
        S3_Replication_OperationMissedThreshold);
      ("s3:Replication:OperationNotTracked",
        S3_Replication_OperationNotTracked);
      ("s3:Replication:OperationFailedReplication",
        S3_Replication_OperationFailedReplication);
      ("s3:Replication:*", S3_Replication__);
      ("s3:ObjectRestore:Completed", S3_ObjectRestore_Completed);
      ("s3:ObjectRestore:Post", S3_ObjectRestore_Post);
      ("s3:ObjectRestore:*", S3_ObjectRestore__);
      ("s3:ObjectRemoved:DeleteMarkerCreated",
        S3_ObjectRemoved_DeleteMarkerCreated);
      ("s3:ObjectRemoved:Delete", S3_ObjectRemoved_Delete);
      ("s3:ObjectRemoved:*", S3_ObjectRemoved__);
      ("s3:ObjectCreated:CompleteMultipartUpload",
        S3_ObjectCreated_CompleteMultipartUpload);
      ("s3:ObjectCreated:Copy", S3_ObjectCreated_Copy);
      ("s3:ObjectCreated:Post", S3_ObjectCreated_Post);
      ("s3:ObjectCreated:Put", S3_ObjectCreated_Put);
      ("s3:ObjectCreated:*", S3_ObjectCreated__);
      ("s3:ReducedRedundancyLostObject", S3_ReducedRedundancyLostObject)]
    let t_to_str =
      [(S3_Replication_OperationReplicatedAfterThreshold,
         "s3:Replication:OperationReplicatedAfterThreshold");
      (S3_Replication_OperationMissedThreshold,
        "s3:Replication:OperationMissedThreshold");
      (S3_Replication_OperationNotTracked,
        "s3:Replication:OperationNotTracked");
      (S3_Replication_OperationFailedReplication,
        "s3:Replication:OperationFailedReplication");
      (S3_Replication__, "s3:Replication:*");
      (S3_ObjectRestore_Completed, "s3:ObjectRestore:Completed");
      (S3_ObjectRestore_Post, "s3:ObjectRestore:Post");
      (S3_ObjectRestore__, "s3:ObjectRestore:*");
      (S3_ObjectRemoved_DeleteMarkerCreated,
        "s3:ObjectRemoved:DeleteMarkerCreated");
      (S3_ObjectRemoved_Delete, "s3:ObjectRemoved:Delete");
      (S3_ObjectRemoved__, "s3:ObjectRemoved:*");
      (S3_ObjectCreated_CompleteMultipartUpload,
        "s3:ObjectCreated:CompleteMultipartUpload");
      (S3_ObjectCreated_Copy, "s3:ObjectCreated:Copy");
      (S3_ObjectCreated_Post, "s3:ObjectCreated:Post");
      (S3_ObjectCreated_Put, "s3:ObjectCreated:Put");
      (S3_ObjectCreated__, "s3:ObjectCreated:*");
      (S3_ReducedRedundancyLostObject, "s3:ReducedRedundancyLostObject")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module S3KeyFilter =
  struct
    type t = {
      filter_rules: FilterRuleList.t }
    let make ?(filter_rules= [])  () = { filter_rules }
    let parse xml =
      Some { filter_rules = (Util.of_option [] (FilterRuleList.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "FilterRule"
                      ([], (FilterRuleList.to_xml [x])))) v.filter_rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("filter_rules", (FilterRuleList.to_json v.filter_rules))])
    let of_json j =
      {
        filter_rules =
          (FilterRuleList.of_json
             (Util.of_option_exn (Json.lookup j "filter_rules")))
      }
  end
module DeleteMarkerReplication =
  struct
    type t = {
      status: DeleteMarkerReplicationStatus.t option }
    let make ?status  () = { status }
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               DeleteMarkerReplicationStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (DeleteMarkerReplicationStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (DeleteMarkerReplicationStatus.to_json f)))])
    let of_json j =
      {
        status =
          (Util.option_map (Json.lookup j "status")
             DeleteMarkerReplicationStatus.of_json)
      }
  end
module Destination =
  struct
    type t =
      {
      bucket: String.t ;
      account: String.t option ;
      storage_class: StorageClass.t option ;
      access_control_translation: AccessControlTranslation.t option ;
      encryption_configuration: EncryptionConfiguration.t option ;
      replication_time: ReplicationTime.t option ;
      metrics: Metrics.t option }
    let make ~bucket  ?account  ?storage_class  ?access_control_translation 
      ?encryption_configuration  ?replication_time  ?metrics  () =
      {
        bucket;
        account;
        storage_class;
        access_control_translation;
        encryption_configuration;
        replication_time;
        metrics
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          account =
            (Util.option_bind (Xml.member "Account" xml) String.parse);
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               StorageClass.parse);
          access_control_translation =
            (Util.option_bind (Xml.member "AccessControlTranslation" xml)
               AccessControlTranslation.parse);
          encryption_configuration =
            (Util.option_bind (Xml.member "EncryptionConfiguration" xml)
               EncryptionConfiguration.parse);
          replication_time =
            (Util.option_bind (Xml.member "ReplicationTime" xml)
               ReplicationTime.parse);
          metrics =
            (Util.option_bind (Xml.member "Metrics" xml) Metrics.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @
                [Util.option_map v.account
                   (fun f ->
                      Ezxmlm.make_tag "Account" ([], (String.to_xml f)))])
               @
               [Util.option_map v.storage_class
                  (fun f ->
                     Ezxmlm.make_tag "StorageClass"
                       ([], (StorageClass.to_xml f)))])
              @
              [Util.option_map v.access_control_translation
                 (fun f ->
                    Ezxmlm.make_tag "AccessControlTranslation"
                      ([], (AccessControlTranslation.to_xml f)))])
             @
             [Util.option_map v.encryption_configuration
                (fun f ->
                   Ezxmlm.make_tag "EncryptionConfiguration"
                     ([], (EncryptionConfiguration.to_xml f)))])
            @
            [Util.option_map v.replication_time
               (fun f ->
                  Ezxmlm.make_tag "ReplicationTime"
                    ([], (ReplicationTime.to_xml f)))])
           @
           [Util.option_map v.metrics
              (fun f -> Ezxmlm.make_tag "Metrics" ([], (Metrics.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metrics
              (fun f -> ("metrics", (Metrics.to_json f)));
           Util.option_map v.replication_time
             (fun f -> ("replication_time", (ReplicationTime.to_json f)));
           Util.option_map v.encryption_configuration
             (fun f ->
                ("encryption_configuration",
                  (EncryptionConfiguration.to_json f)));
           Util.option_map v.access_control_translation
             (fun f ->
                ("access_control_translation",
                  (AccessControlTranslation.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.account
             (fun f -> ("account", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        account = (Util.option_map (Json.lookup j "account") String.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        access_control_translation =
          (Util.option_map (Json.lookup j "access_control_translation")
             AccessControlTranslation.of_json);
        encryption_configuration =
          (Util.option_map (Json.lookup j "encryption_configuration")
             EncryptionConfiguration.of_json);
        replication_time =
          (Util.option_map (Json.lookup j "replication_time")
             ReplicationTime.of_json);
        metrics = (Util.option_map (Json.lookup j "metrics") Metrics.of_json)
      }
  end
module ExistingObjectReplication =
  struct
    type t = {
      status: ExistingObjectReplicationStatus.t }
    let make ~status  () = { status }
    let parse xml =
      Some
        {
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ExistingObjectReplicationStatus.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Status"
                 ([], (ExistingObjectReplicationStatus.to_xml v.status)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("status", (ExistingObjectReplicationStatus.to_json v.status))])
    let of_json j =
      {
        status =
          (ExistingObjectReplicationStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")))
      }
  end
module ReplicationRuleFilter =
  struct
    type t =
      {
      prefix: String.t option ;
      tag: Tag.t option ;
      and_: ReplicationRuleAndOperator.t option }
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml)
               ReplicationRuleAndOperator.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.prefix
                (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
            @
            [Util.option_map v.tag
               (fun f -> Ezxmlm.make_tag "Tag" ([], (Tag.to_xml f)))])
           @
           [Util.option_map v.and_
              (fun f ->
                 Ezxmlm.make_tag "And"
                   ([], (ReplicationRuleAndOperator.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (ReplicationRuleAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tag = (Util.option_map (Json.lookup j "tag") Tag.of_json);
        and_ =
          (Util.option_map (Json.lookup j "and_")
             ReplicationRuleAndOperator.of_json)
      }
  end
module ReplicationRuleStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module SourceSelectionCriteria =
  struct
    type t = {
      sse_kms_encrypted_objects: SseKmsEncryptedObjects.t option }
    let make ?sse_kms_encrypted_objects  () = { sse_kms_encrypted_objects }
    let parse xml =
      Some
        {
          sse_kms_encrypted_objects =
            (Util.option_bind (Xml.member "SseKmsEncryptedObjects" xml)
               SseKmsEncryptedObjects.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.sse_kms_encrypted_objects
              (fun f ->
                 Ezxmlm.make_tag "SseKmsEncryptedObjects"
                   ([], (SseKmsEncryptedObjects.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.sse_kms_encrypted_objects
              (fun f ->
                 ("sse_kms_encrypted_objects",
                   (SseKmsEncryptedObjects.to_json f)))])
    let of_json j =
      {
        sse_kms_encrypted_objects =
          (Util.option_map (Json.lookup j "sse_kms_encrypted_objects")
             SseKmsEncryptedObjects.of_json)
      }
  end
module ServerSideEncryptionByDefault =
  struct
    type t =
      {
      s_s_e_algorithm: ServerSideEncryption.t ;
      k_m_s_master_key_i_d: String.t option }
    let make ~s_s_e_algorithm  ?k_m_s_master_key_i_d  () =
      { s_s_e_algorithm; k_m_s_master_key_i_d }
    let parse xml =
      Some
        {
          s_s_e_algorithm =
            (Xml.required "SSEAlgorithm"
               (Util.option_bind (Xml.member "SSEAlgorithm" xml)
                  ServerSideEncryption.parse));
          k_m_s_master_key_i_d =
            (Util.option_bind (Xml.member "KMSMasterKeyID" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "SSEAlgorithm"
                  ([], (ServerSideEncryption.to_xml v.s_s_e_algorithm)))])
           @
           [Util.option_map v.k_m_s_master_key_i_d
              (fun f ->
                 Ezxmlm.make_tag "KMSMasterKeyID" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.k_m_s_master_key_i_d
              (fun f -> ("k_m_s_master_key_i_d", (String.to_json f)));
           Some
             ("s_s_e_algorithm",
               (ServerSideEncryption.to_json v.s_s_e_algorithm))])
    let of_json j =
      {
        s_s_e_algorithm =
          (ServerSideEncryption.of_json
             (Util.of_option_exn (Json.lookup j "s_s_e_algorithm")));
        k_m_s_master_key_i_d =
          (Util.option_map (Json.lookup j "k_m_s_master_key_i_d")
             String.of_json)
      }
  end
module AbortIncompleteMultipartUpload =
  struct
    type t = {
      days_after_initiation: Integer.t option }
    let make ?days_after_initiation  () = { days_after_initiation }
    let parse xml =
      Some
        {
          days_after_initiation =
            (Util.option_bind (Xml.member "DaysAfterInitiation" xml)
               Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.days_after_initiation
              (fun f ->
                 Ezxmlm.make_tag "DaysAfterInitiation"
                   ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.days_after_initiation
              (fun f -> ("days_after_initiation", (Integer.to_json f)))])
    let of_json j =
      {
        days_after_initiation =
          (Util.option_map (Json.lookup j "days_after_initiation")
             Integer.of_json)
      }
  end
module ExpirationStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module LifecycleExpiration =
  struct
    type t =
      {
      date: DateTime.t option ;
      days: Integer.t option ;
      expired_object_delete_marker: Boolean.t option }
    let make ?date  ?days  ?expired_object_delete_marker  () =
      { date; days; expired_object_delete_marker }
    let parse xml =
      Some
        {
          date = (Util.option_bind (Xml.member "Date" xml) DateTime.parse);
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          expired_object_delete_marker =
            (Util.option_bind (Xml.member "ExpiredObjectDeleteMarker" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.date
                (fun f -> Ezxmlm.make_tag "Date" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.days
               (fun f -> Ezxmlm.make_tag "Days" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.expired_object_delete_marker
              (fun f ->
                 Ezxmlm.make_tag "ExpiredObjectDeleteMarker"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.expired_object_delete_marker
              (fun f -> ("expired_object_delete_marker", (Boolean.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)));
           Util.option_map v.date (fun f -> ("date", (DateTime.to_json f)))])
    let of_json j =
      {
        date = (Util.option_map (Json.lookup j "date") DateTime.of_json);
        days = (Util.option_map (Json.lookup j "days") Integer.of_json);
        expired_object_delete_marker =
          (Util.option_map (Json.lookup j "expired_object_delete_marker")
             Boolean.of_json)
      }
  end
module NoncurrentVersionExpiration =
  struct
    type t = {
      noncurrent_days: Integer.t }
    let make ~noncurrent_days  () = { noncurrent_days }
    let parse xml =
      Some
        {
          noncurrent_days =
            (Xml.required "NoncurrentDays"
               (Util.option_bind (Xml.member "NoncurrentDays" xml)
                  Integer.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "NoncurrentDays"
                 ([], (Integer.to_xml v.noncurrent_days)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("noncurrent_days", (Integer.to_json v.noncurrent_days))])
    let of_json j =
      {
        noncurrent_days =
          (Integer.of_json
             (Util.of_option_exn (Json.lookup j "noncurrent_days")))
      }
  end
module AnalyticsAndOperator =
  struct
    type t = {
      prefix: String.t option ;
      tags: TagSet.t }
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tag" ([], (TagSet.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tags = (TagSet.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module StorageClassAnalysisDataExport =
  struct
    type t =
      {
      output_schema_version: StorageClassAnalysisSchemaVersion.t ;
      destination: AnalyticsExportDestination.t }
    let make ~output_schema_version  ~destination  () =
      { output_schema_version; destination }
    let parse xml =
      Some
        {
          output_schema_version =
            (Xml.required "OutputSchemaVersion"
               (Util.option_bind (Xml.member "OutputSchemaVersion" xml)
                  StorageClassAnalysisSchemaVersion.parse));
          destination =
            (Xml.required "Destination"
               (Util.option_bind (Xml.member "Destination" xml)
                  AnalyticsExportDestination.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "OutputSchemaVersion"
                  ([],
                    (StorageClassAnalysisSchemaVersion.to_xml
                       v.output_schema_version)))])
           @
           [Some
              (Ezxmlm.make_tag "Destination"
                 ([], (AnalyticsExportDestination.to_xml v.destination)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("destination",
                (AnalyticsExportDestination.to_json v.destination));
           Some
             ("output_schema_version",
               (StorageClassAnalysisSchemaVersion.to_json
                  v.output_schema_version))])
    let of_json j =
      {
        output_schema_version =
          (StorageClassAnalysisSchemaVersion.of_json
             (Util.of_option_exn (Json.lookup j "output_schema_version")));
        destination =
          (AnalyticsExportDestination.of_json
             (Util.of_option_exn (Json.lookup j "destination")))
      }
  end
module Encryption =
  struct
    type t =
      {
      encryption_type: ServerSideEncryption.t ;
      k_m_s_key_id: String.t option ;
      k_m_s_context: String.t option }
    let make ~encryption_type  ?k_m_s_key_id  ?k_m_s_context  () =
      { encryption_type; k_m_s_key_id; k_m_s_context }
    let parse xml =
      Some
        {
          encryption_type =
            (Xml.required "EncryptionType"
               (Util.option_bind (Xml.member "EncryptionType" xml)
                  ServerSideEncryption.parse));
          k_m_s_key_id =
            (Util.option_bind (Xml.member "KMSKeyId" xml) String.parse);
          k_m_s_context =
            (Util.option_bind (Xml.member "KMSContext" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "EncryptionType"
                   ([], (ServerSideEncryption.to_xml v.encryption_type)))])
            @
            [Util.option_map v.k_m_s_key_id
               (fun f -> Ezxmlm.make_tag "KMSKeyId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.k_m_s_context
              (fun f -> Ezxmlm.make_tag "KMSContext" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.k_m_s_context
              (fun f -> ("k_m_s_context", (String.to_json f)));
           Util.option_map v.k_m_s_key_id
             (fun f -> ("k_m_s_key_id", (String.to_json f)));
           Some
             ("encryption_type",
               (ServerSideEncryption.to_json v.encryption_type))])
    let of_json j =
      {
        encryption_type =
          (ServerSideEncryption.of_json
             (Util.of_option_exn (Json.lookup j "encryption_type")));
        k_m_s_key_id =
          (Util.option_map (Json.lookup j "k_m_s_key_id") String.of_json);
        k_m_s_context =
          (Util.option_map (Json.lookup j "k_m_s_context") String.of_json)
      }
  end
module Grants =
  struct
    type t = Grant.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Grant.parse (Xml.members "Grant" xml))
    let to_query v = Query.to_query_list Grant.to_query v
    let to_headers v = Headers.to_headers_list Grant.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Grant.to_xml x))) v
    let to_json v = `List (List.map Grant.to_json v)
    let of_json j = Json.to_list Grant.of_json j
  end
module ObjectCannedACL =
  struct
    type t =
      | Private 
      | Public_read 
      | Public_read_write 
      | Authenticated_read 
      | Aws_exec_read 
      | Bucket_owner_read 
      | Bucket_owner_full_control 
    let str_to_t =
      [("bucket-owner-full-control", Bucket_owner_full_control);
      ("bucket-owner-read", Bucket_owner_read);
      ("aws-exec-read", Aws_exec_read);
      ("authenticated-read", Authenticated_read);
      ("public-read-write", Public_read_write);
      ("public-read", Public_read);
      ("private", Private)]
    let t_to_str =
      [(Bucket_owner_full_control, "bucket-owner-full-control");
      (Bucket_owner_read, "bucket-owner-read");
      (Aws_exec_read, "aws-exec-read");
      (Authenticated_read, "authenticated-read");
      (Public_read_write, "public-read-write");
      (Public_read, "public-read");
      (Private, "private")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Tagging =
  struct
    type t = {
      tag_set: TagSet.t }
    let make ~tag_set  () = { tag_set }
    let parse xml =
      Some
        {
          tag_set =
            (Xml.required "TagSet"
               (Util.option_bind (Xml.member "TagSet" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagSet" ([], (TagSet.to_xml [x]))))
              v.tag_set))
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("tag_set", (TagSet.to_json v.tag_set))])
    let of_json j =
      {
        tag_set =
          (TagSet.of_json (Util.of_option_exn (Json.lookup j "tag_set")))
      }
  end
module UserMetadata =
  struct
    type t = MetadataEntry.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map MetadataEntry.parse (Xml.members "MetadataEntry" xml))
    let to_query v = Query.to_query_list MetadataEntry.to_query v
    let to_headers v = Headers.to_headers_list MetadataEntry.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (MetadataEntry.to_xml x))) v
    let to_json v = `List (List.map MetadataEntry.to_json v)
    let of_json j = Json.to_list MetadataEntry.of_json j
  end
module CSVInput =
  struct
    type t =
      {
      file_header_info: FileHeaderInfo.t option ;
      comments: String.t option ;
      quote_escape_character: String.t option ;
      record_delimiter: String.t option ;
      field_delimiter: String.t option ;
      quote_character: String.t option ;
      allow_quoted_record_delimiter: Boolean.t option }
    let make ?file_header_info  ?comments  ?quote_escape_character 
      ?record_delimiter  ?field_delimiter  ?quote_character 
      ?allow_quoted_record_delimiter  () =
      {
        file_header_info;
        comments;
        quote_escape_character;
        record_delimiter;
        field_delimiter;
        quote_character;
        allow_quoted_record_delimiter
      }
    let parse xml =
      Some
        {
          file_header_info =
            (Util.option_bind (Xml.member "FileHeaderInfo" xml)
               FileHeaderInfo.parse);
          comments =
            (Util.option_bind (Xml.member "Comments" xml) String.parse);
          quote_escape_character =
            (Util.option_bind (Xml.member "QuoteEscapeCharacter" xml)
               String.parse);
          record_delimiter =
            (Util.option_bind (Xml.member "RecordDelimiter" xml) String.parse);
          field_delimiter =
            (Util.option_bind (Xml.member "FieldDelimiter" xml) String.parse);
          quote_character =
            (Util.option_bind (Xml.member "QuoteCharacter" xml) String.parse);
          allow_quoted_record_delimiter =
            (Util.option_bind (Xml.member "AllowQuotedRecordDelimiter" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.file_header_info
                    (fun f ->
                       Ezxmlm.make_tag "FileHeaderInfo"
                         ([], (FileHeaderInfo.to_xml f)))])
                @
                [Util.option_map v.comments
                   (fun f ->
                      Ezxmlm.make_tag "Comments" ([], (String.to_xml f)))])
               @
               [Util.option_map v.quote_escape_character
                  (fun f ->
                     Ezxmlm.make_tag "QuoteEscapeCharacter"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.record_delimiter
                 (fun f ->
                    Ezxmlm.make_tag "RecordDelimiter" ([], (String.to_xml f)))])
             @
             [Util.option_map v.field_delimiter
                (fun f ->
                   Ezxmlm.make_tag "FieldDelimiter" ([], (String.to_xml f)))])
            @
            [Util.option_map v.quote_character
               (fun f ->
                  Ezxmlm.make_tag "QuoteCharacter" ([], (String.to_xml f)))])
           @
           [Util.option_map v.allow_quoted_record_delimiter
              (fun f ->
                 Ezxmlm.make_tag "AllowQuotedRecordDelimiter"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.allow_quoted_record_delimiter
              (fun f ->
                 ("allow_quoted_record_delimiter", (Boolean.to_json f)));
           Util.option_map v.quote_character
             (fun f -> ("quote_character", (String.to_json f)));
           Util.option_map v.field_delimiter
             (fun f -> ("field_delimiter", (String.to_json f)));
           Util.option_map v.record_delimiter
             (fun f -> ("record_delimiter", (String.to_json f)));
           Util.option_map v.quote_escape_character
             (fun f -> ("quote_escape_character", (String.to_json f)));
           Util.option_map v.comments
             (fun f -> ("comments", (String.to_json f)));
           Util.option_map v.file_header_info
             (fun f -> ("file_header_info", (FileHeaderInfo.to_json f)))])
    let of_json j =
      {
        file_header_info =
          (Util.option_map (Json.lookup j "file_header_info")
             FileHeaderInfo.of_json);
        comments =
          (Util.option_map (Json.lookup j "comments") String.of_json);
        quote_escape_character =
          (Util.option_map (Json.lookup j "quote_escape_character")
             String.of_json);
        record_delimiter =
          (Util.option_map (Json.lookup j "record_delimiter") String.of_json);
        field_delimiter =
          (Util.option_map (Json.lookup j "field_delimiter") String.of_json);
        quote_character =
          (Util.option_map (Json.lookup j "quote_character") String.of_json);
        allow_quoted_record_delimiter =
          (Util.option_map (Json.lookup j "allow_quoted_record_delimiter")
             Boolean.of_json)
      }
  end
module CompressionType =
  struct
    type t =
      | NONE 
      | GZIP 
      | BZIP2 
    let str_to_t = [("BZIP2", BZIP2); ("GZIP", GZIP); ("NONE", NONE)]
    let t_to_str = [(BZIP2, "BZIP2"); (GZIP, "GZIP"); (NONE, "NONE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module JSONInput =
  struct
    type t = {
      type_: JSONType.t option }
    let make ?type_  () = { type_ }
    let parse xml =
      Some
        { type_ = (Util.option_bind (Xml.member "Type" xml) JSONType.parse) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.type_
              (fun f -> Ezxmlm.make_tag "Type" ([], (JSONType.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.type_
              (fun f -> ("type_", (JSONType.to_json f)))])
    let of_json j =
      { type_ = (Util.option_map (Json.lookup j "type_") JSONType.of_json) }
  end
module ParquetInput =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CSVOutput =
  struct
    type t =
      {
      quote_fields: QuoteFields.t option ;
      quote_escape_character: String.t option ;
      record_delimiter: String.t option ;
      field_delimiter: String.t option ;
      quote_character: String.t option }
    let make ?quote_fields  ?quote_escape_character  ?record_delimiter 
      ?field_delimiter  ?quote_character  () =
      {
        quote_fields;
        quote_escape_character;
        record_delimiter;
        field_delimiter;
        quote_character
      }
    let parse xml =
      Some
        {
          quote_fields =
            (Util.option_bind (Xml.member "QuoteFields" xml)
               QuoteFields.parse);
          quote_escape_character =
            (Util.option_bind (Xml.member "QuoteEscapeCharacter" xml)
               String.parse);
          record_delimiter =
            (Util.option_bind (Xml.member "RecordDelimiter" xml) String.parse);
          field_delimiter =
            (Util.option_bind (Xml.member "FieldDelimiter" xml) String.parse);
          quote_character =
            (Util.option_bind (Xml.member "QuoteCharacter" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.quote_fields
                  (fun f ->
                     Ezxmlm.make_tag "QuoteFields"
                       ([], (QuoteFields.to_xml f)))])
              @
              [Util.option_map v.quote_escape_character
                 (fun f ->
                    Ezxmlm.make_tag "QuoteEscapeCharacter"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.record_delimiter
                (fun f ->
                   Ezxmlm.make_tag "RecordDelimiter" ([], (String.to_xml f)))])
            @
            [Util.option_map v.field_delimiter
               (fun f ->
                  Ezxmlm.make_tag "FieldDelimiter" ([], (String.to_xml f)))])
           @
           [Util.option_map v.quote_character
              (fun f ->
                 Ezxmlm.make_tag "QuoteCharacter" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.quote_character
              (fun f -> ("quote_character", (String.to_json f)));
           Util.option_map v.field_delimiter
             (fun f -> ("field_delimiter", (String.to_json f)));
           Util.option_map v.record_delimiter
             (fun f -> ("record_delimiter", (String.to_json f)));
           Util.option_map v.quote_escape_character
             (fun f -> ("quote_escape_character", (String.to_json f)));
           Util.option_map v.quote_fields
             (fun f -> ("quote_fields", (QuoteFields.to_json f)))])
    let of_json j =
      {
        quote_fields =
          (Util.option_map (Json.lookup j "quote_fields") QuoteFields.of_json);
        quote_escape_character =
          (Util.option_map (Json.lookup j "quote_escape_character")
             String.of_json);
        record_delimiter =
          (Util.option_map (Json.lookup j "record_delimiter") String.of_json);
        field_delimiter =
          (Util.option_map (Json.lookup j "field_delimiter") String.of_json);
        quote_character =
          (Util.option_map (Json.lookup j "quote_character") String.of_json)
      }
  end
module JSONOutput =
  struct
    type t = {
      record_delimiter: String.t option }
    let make ?record_delimiter  () = { record_delimiter }
    let parse xml =
      Some
        {
          record_delimiter =
            (Util.option_bind (Xml.member "RecordDelimiter" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.record_delimiter
              (fun f ->
                 Ezxmlm.make_tag "RecordDelimiter" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.record_delimiter
              (fun f -> ("record_delimiter", (String.to_json f)))])
    let of_json j =
      {
        record_delimiter =
          (Util.option_map (Json.lookup j "record_delimiter") String.of_json)
      }
  end
module ObjectLockRetentionMode =
  struct
    type t =
      | GOVERNANCE 
      | COMPLIANCE 
    let str_to_t = [("COMPLIANCE", COMPLIANCE); ("GOVERNANCE", GOVERNANCE)]
    let t_to_str = [(COMPLIANCE, "COMPLIANCE"); (GOVERNANCE, "GOVERNANCE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module InventoryS3BucketDestination =
  struct
    type t =
      {
      account_id: String.t option ;
      bucket: String.t ;
      format: InventoryFormat.t ;
      prefix: String.t option ;
      encryption: InventoryEncryption.t option }
    let make ?account_id  ~bucket  ~format  ?prefix  ?encryption  () =
      { account_id; bucket; format; prefix; encryption }
    let parse xml =
      Some
        {
          account_id =
            (Util.option_bind (Xml.member "AccountId" xml) String.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          format =
            (Xml.required "Format"
               (Util.option_bind (Xml.member "Format" xml)
                  InventoryFormat.parse));
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          encryption =
            (Util.option_bind (Xml.member "Encryption" xml)
               InventoryEncryption.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.account_id
                  (fun f ->
                     Ezxmlm.make_tag "AccountId" ([], (String.to_xml f)))])
              @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @
             [Some
                (Ezxmlm.make_tag "Format"
                   ([], (InventoryFormat.to_xml v.format)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.encryption
              (fun f ->
                 Ezxmlm.make_tag "Encryption"
                   ([], (InventoryEncryption.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.encryption
              (fun f -> ("encryption", (InventoryEncryption.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Some ("format", (InventoryFormat.to_json v.format));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.account_id
             (fun f -> ("account_id", (String.to_json f)))])
    let of_json j =
      {
        account_id =
          (Util.option_map (Json.lookup j "account_id") String.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        format =
          (InventoryFormat.of_json
             (Util.of_option_exn (Json.lookup j "format")));
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        encryption =
          (Util.option_map (Json.lookup j "encryption")
             InventoryEncryption.of_json)
      }
  end
module InventoryOptionalField =
  struct
    type t =
      | Size 
      | LastModifiedDate 
      | StorageClass 
      | ETag 
      | IsMultipartUploaded 
      | ReplicationStatus 
      | EncryptionStatus 
      | ObjectLockRetainUntilDate 
      | ObjectLockMode 
      | ObjectLockLegalHoldStatus 
      | IntelligentTieringAccessTier 
    let str_to_t =
      [("IntelligentTieringAccessTier", IntelligentTieringAccessTier);
      ("ObjectLockLegalHoldStatus", ObjectLockLegalHoldStatus);
      ("ObjectLockMode", ObjectLockMode);
      ("ObjectLockRetainUntilDate", ObjectLockRetainUntilDate);
      ("EncryptionStatus", EncryptionStatus);
      ("ReplicationStatus", ReplicationStatus);
      ("IsMultipartUploaded", IsMultipartUploaded);
      ("ETag", ETag);
      ("StorageClass", StorageClass);
      ("LastModifiedDate", LastModifiedDate);
      ("Size", Size)]
    let t_to_str =
      [(IntelligentTieringAccessTier, "IntelligentTieringAccessTier");
      (ObjectLockLegalHoldStatus, "ObjectLockLegalHoldStatus");
      (ObjectLockMode, "ObjectLockMode");
      (ObjectLockRetainUntilDate, "ObjectLockRetainUntilDate");
      (EncryptionStatus, "EncryptionStatus");
      (ReplicationStatus, "ReplicationStatus");
      (IsMultipartUploaded, "IsMultipartUploaded");
      (ETag, "ETag");
      (StorageClass, "StorageClass");
      (LastModifiedDate, "LastModifiedDate");
      (Size, "Size")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module InventoryFrequency =
  struct
    type t =
      | Daily 
      | Weekly 
    let str_to_t = [("Weekly", Weekly); ("Daily", Daily)]
    let t_to_str = [(Weekly, "Weekly"); (Daily, "Daily")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Condition =
  struct
    type t =
      {
      http_error_code_returned_equals: String.t option ;
      key_prefix_equals: String.t option }
    let make ?http_error_code_returned_equals  ?key_prefix_equals  () =
      { http_error_code_returned_equals; key_prefix_equals }
    let parse xml =
      Some
        {
          http_error_code_returned_equals =
            (Util.option_bind (Xml.member "HttpErrorCodeReturnedEquals" xml)
               String.parse);
          key_prefix_equals =
            (Util.option_bind (Xml.member "KeyPrefixEquals" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.http_error_code_returned_equals
               (fun f ->
                  Ezxmlm.make_tag "HttpErrorCodeReturnedEquals"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.key_prefix_equals
              (fun f ->
                 Ezxmlm.make_tag "KeyPrefixEquals" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.key_prefix_equals
              (fun f -> ("key_prefix_equals", (String.to_json f)));
           Util.option_map v.http_error_code_returned_equals
             (fun f ->
                ("http_error_code_returned_equals", (String.to_json f)))])
    let of_json j =
      {
        http_error_code_returned_equals =
          (Util.option_map (Json.lookup j "http_error_code_returned_equals")
             String.of_json);
        key_prefix_equals =
          (Util.option_map (Json.lookup j "key_prefix_equals") String.of_json)
      }
  end
module Redirect =
  struct
    type t =
      {
      host_name: String.t option ;
      http_redirect_code: String.t option ;
      protocol: Protocol.t option ;
      replace_key_prefix_with: String.t option ;
      replace_key_with: String.t option }
    let make ?host_name  ?http_redirect_code  ?protocol 
      ?replace_key_prefix_with  ?replace_key_with  () =
      {
        host_name;
        http_redirect_code;
        protocol;
        replace_key_prefix_with;
        replace_key_with
      }
    let parse xml =
      Some
        {
          host_name =
            (Util.option_bind (Xml.member "HostName" xml) String.parse);
          http_redirect_code =
            (Util.option_bind (Xml.member "HttpRedirectCode" xml)
               String.parse);
          protocol =
            (Util.option_bind (Xml.member "Protocol" xml) Protocol.parse);
          replace_key_prefix_with =
            (Util.option_bind (Xml.member "ReplaceKeyPrefixWith" xml)
               String.parse);
          replace_key_with =
            (Util.option_bind (Xml.member "ReplaceKeyWith" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.host_name
                  (fun f ->
                     Ezxmlm.make_tag "HostName" ([], (String.to_xml f)))])
              @
              [Util.option_map v.http_redirect_code
                 (fun f ->
                    Ezxmlm.make_tag "HttpRedirectCode"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.protocol
                (fun f ->
                   Ezxmlm.make_tag "Protocol" ([], (Protocol.to_xml f)))])
            @
            [Util.option_map v.replace_key_prefix_with
               (fun f ->
                  Ezxmlm.make_tag "ReplaceKeyPrefixWith"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.replace_key_with
              (fun f ->
                 Ezxmlm.make_tag "ReplaceKeyWith" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replace_key_with
              (fun f -> ("replace_key_with", (String.to_json f)));
           Util.option_map v.replace_key_prefix_with
             (fun f -> ("replace_key_prefix_with", (String.to_json f)));
           Util.option_map v.protocol
             (fun f -> ("protocol", (Protocol.to_json f)));
           Util.option_map v.http_redirect_code
             (fun f -> ("http_redirect_code", (String.to_json f)));
           Util.option_map v.host_name
             (fun f -> ("host_name", (String.to_json f)))])
    let of_json j =
      {
        host_name =
          (Util.option_map (Json.lookup j "host_name") String.of_json);
        http_redirect_code =
          (Util.option_map (Json.lookup j "http_redirect_code")
             String.of_json);
        protocol =
          (Util.option_map (Json.lookup j "protocol") Protocol.of_json);
        replace_key_prefix_with =
          (Util.option_map (Json.lookup j "replace_key_prefix_with")
             String.of_json);
        replace_key_with =
          (Util.option_map (Json.lookup j "replace_key_with") String.of_json)
      }
  end
module AllowedHeaders =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v = List.concat (List.map String.to_xml v)
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AllowedMethods =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v = List.concat (List.map String.to_xml v)
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module AllowedOrigins =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v = List.concat (List.map String.to_xml v)
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module ExposeHeaders =
  struct
    type t = String.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map String.parse [xml])
    let to_query v = Query.to_query_list String.to_query v
    let to_headers v = Headers.to_headers_list String.to_headers v
    let to_xml v = List.concat (List.map String.to_xml v)
    let to_json v = `List (List.map String.to_json v)
    let of_json j = Json.to_list String.of_json j
  end
module MetricsAndOperator =
  struct
    type t = {
      prefix: String.t option ;
      tags: TagSet.t }
    let make ?prefix  ?(tags= [])  () = { prefix; tags }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tags =
            (Util.of_option []
               (Util.option_bind (Xml.member "Tag" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Tag" ([], (TagSet.to_xml [x]))))
              v.tags))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tags", (TagSet.to_json v.tags));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tags = (TagSet.of_json (Util.of_option_exn (Json.lookup j "tags")))
      }
  end
module TargetGrant =
  struct
    type t =
      {
      grantee: Grantee.t option ;
      permission: BucketLogsPermission.t option }
    let make ?grantee  ?permission  () = { grantee; permission }
    let parse xml =
      Some
        {
          grantee =
            (Util.option_bind (Xml.member "Grantee" xml) Grantee.parse);
          permission =
            (Util.option_bind (Xml.member "Permission" xml)
               BucketLogsPermission.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.grantee
               (fun f -> Ezxmlm.make_tag "Grantee" ([], (Grantee.to_xml f)))])
           @
           [Util.option_map v.permission
              (fun f ->
                 Ezxmlm.make_tag "Permission"
                   ([], (BucketLogsPermission.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.permission
              (fun f -> ("permission", (BucketLogsPermission.to_json f)));
           Util.option_map v.grantee
             (fun f -> ("grantee", (Grantee.to_json f)))])
    let of_json j =
      {
        grantee = (Util.option_map (Json.lookup j "grantee") Grantee.of_json);
        permission =
          (Util.option_map (Json.lookup j "permission")
             BucketLogsPermission.of_json)
      }
  end
module LifecycleRuleFilter =
  struct
    type t =
      {
      prefix: String.t option ;
      tag: Tag.t option ;
      and_: LifecycleRuleAndOperator.t option }
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml)
               LifecycleRuleAndOperator.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.prefix
                (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
            @
            [Util.option_map v.tag
               (fun f -> Ezxmlm.make_tag "Tag" ([], (Tag.to_xml f)))])
           @
           [Util.option_map v.and_
              (fun f ->
                 Ezxmlm.make_tag "And"
                   ([], (LifecycleRuleAndOperator.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (LifecycleRuleAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tag = (Util.option_map (Json.lookup j "tag") Tag.of_json);
        and_ =
          (Util.option_map (Json.lookup j "and_")
             LifecycleRuleAndOperator.of_json)
      }
  end
module NoncurrentVersionTransitionList =
  struct
    type t = NoncurrentVersionTransition.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map NoncurrentVersionTransition.parse [xml])
    let to_query v =
      Query.to_query_list NoncurrentVersionTransition.to_query v
    let to_headers v =
      Headers.to_headers_list NoncurrentVersionTransition.to_headers v
    let to_xml v =
      List.concat (List.map NoncurrentVersionTransition.to_xml v)
    let to_json v = `List (List.map NoncurrentVersionTransition.to_json v)
    let of_json j = Json.to_list NoncurrentVersionTransition.of_json j
  end
module TransitionList =
  struct
    type t = Transition.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map Transition.parse [xml])
    let to_query v = Query.to_query_list Transition.to_query v
    let to_headers v = Headers.to_headers_list Transition.to_headers v
    let to_xml v = List.concat (List.map Transition.to_xml v)
    let to_json v = `List (List.map Transition.to_json v)
    let of_json j = Json.to_list Transition.of_json j
  end
module EventList =
  struct
    type t = Event.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map Event.parse [xml])
    let to_query v = Query.to_query_list Event.to_query v
    let to_headers v = Headers.to_headers_list Event.to_headers v
    let to_xml v = List.concat (List.map Event.to_xml v)
    let to_json v = `List (List.map Event.to_json v)
    let of_json j = Json.to_list Event.of_json j
  end
module NotificationConfigurationFilter =
  struct
    type t = {
      key: S3KeyFilter.t option }
    let make ?key  () = { key }
    let parse xml =
      Some
        { key = (Util.option_bind (Xml.member "S3Key" xml) S3KeyFilter.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.key
              (fun f -> Ezxmlm.make_tag "S3Key" ([], (S3KeyFilter.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.key (fun f -> ("key", (S3KeyFilter.to_json f)))])
    let of_json j =
      { key = (Util.option_map (Json.lookup j "key") S3KeyFilter.of_json) }
  end
module ObjectStorageClass =
  struct
    type t =
      | STANDARD 
      | REDUCED_REDUNDANCY 
      | GLACIER 
      | STANDARD_IA 
      | ONEZONE_IA 
      | INTELLIGENT_TIERING 
      | DEEP_ARCHIVE 
    let str_to_t =
      [("DEEP_ARCHIVE", DEEP_ARCHIVE);
      ("INTELLIGENT_TIERING", INTELLIGENT_TIERING);
      ("ONEZONE_IA", ONEZONE_IA);
      ("STANDARD_IA", STANDARD_IA);
      ("GLACIER", GLACIER);
      ("REDUCED_REDUNDANCY", REDUCED_REDUNDANCY);
      ("STANDARD", STANDARD)]
    let t_to_str =
      [(DEEP_ARCHIVE, "DEEP_ARCHIVE");
      (INTELLIGENT_TIERING, "INTELLIGENT_TIERING");
      (ONEZONE_IA, "ONEZONE_IA");
      (STANDARD_IA, "STANDARD_IA");
      (GLACIER, "GLACIER");
      (REDUCED_REDUNDANCY, "REDUCED_REDUNDANCY");
      (STANDARD, "STANDARD")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Owner =
  struct
    type t = {
      display_name: String.t option ;
      i_d: String.t option }
    let make ?display_name  ?i_d  () = { display_name; i_d }
    let parse xml =
      Some
        {
          display_name =
            (Util.option_bind (Xml.member "DisplayName" xml) String.parse);
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.display_name
               (fun f ->
                  Ezxmlm.make_tag "DisplayName" ([], (String.to_xml f)))])
           @
           [Util.option_map v.i_d
              (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)));
           Util.option_map v.display_name
             (fun f -> ("display_name", (String.to_json f)))])
    let of_json j =
      {
        display_name =
          (Util.option_map (Json.lookup j "display_name") String.of_json);
        i_d = (Util.option_map (Json.lookup j "i_d") String.of_json)
      }
  end
module ReplicationRule =
  struct
    type t =
      {
      i_d: String.t option ;
      priority: Integer.t option ;
      prefix: String.t option ;
      filter: ReplicationRuleFilter.t option ;
      status: ReplicationRuleStatus.t ;
      source_selection_criteria: SourceSelectionCriteria.t option ;
      existing_object_replication: ExistingObjectReplication.t option ;
      destination: Destination.t ;
      delete_marker_replication: DeleteMarkerReplication.t option }
    let make ?i_d  ?priority  ?prefix  ?filter  ~status 
      ?source_selection_criteria  ?existing_object_replication  ~destination 
      ?delete_marker_replication  () =
      {
        i_d;
        priority;
        prefix;
        filter;
        status;
        source_selection_criteria;
        existing_object_replication;
        destination;
        delete_marker_replication
      }
    let parse xml =
      Some
        {
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse);
          priority =
            (Util.option_bind (Xml.member "Priority" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          filter =
            (Util.option_bind (Xml.member "Filter" xml)
               ReplicationRuleFilter.parse);
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ReplicationRuleStatus.parse));
          source_selection_criteria =
            (Util.option_bind (Xml.member "SourceSelectionCriteria" xml)
               SourceSelectionCriteria.parse);
          existing_object_replication =
            (Util.option_bind (Xml.member "ExistingObjectReplication" xml)
               ExistingObjectReplication.parse);
          destination =
            (Xml.required "Destination"
               (Util.option_bind (Xml.member "Destination" xml)
                  Destination.parse));
          delete_marker_replication =
            (Util.option_bind (Xml.member "DeleteMarkerReplication" xml)
               DeleteMarkerReplication.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.i_d
                      (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.priority
                     (fun f ->
                        Ezxmlm.make_tag "Priority" ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.prefix
                    (fun f ->
                       Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
                @
                [Util.option_map v.filter
                   (fun f ->
                      Ezxmlm.make_tag "Filter"
                        ([], (ReplicationRuleFilter.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "Status"
                     ([], (ReplicationRuleStatus.to_xml v.status)))])
              @
              [Util.option_map v.source_selection_criteria
                 (fun f ->
                    Ezxmlm.make_tag "SourceSelectionCriteria"
                      ([], (SourceSelectionCriteria.to_xml f)))])
             @
             [Util.option_map v.existing_object_replication
                (fun f ->
                   Ezxmlm.make_tag "ExistingObjectReplication"
                     ([], (ExistingObjectReplication.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "Destination"
                  ([], (Destination.to_xml v.destination)))])
           @
           [Util.option_map v.delete_marker_replication
              (fun f ->
                 Ezxmlm.make_tag "DeleteMarkerReplication"
                   ([], (DeleteMarkerReplication.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.delete_marker_replication
              (fun f ->
                 ("delete_marker_replication",
                   (DeleteMarkerReplication.to_json f)));
           Some ("destination", (Destination.to_json v.destination));
           Util.option_map v.existing_object_replication
             (fun f ->
                ("existing_object_replication",
                  (ExistingObjectReplication.to_json f)));
           Util.option_map v.source_selection_criteria
             (fun f ->
                ("source_selection_criteria",
                  (SourceSelectionCriteria.to_json f)));
           Some ("status", (ReplicationRuleStatus.to_json v.status));
           Util.option_map v.filter
             (fun f -> ("filter", (ReplicationRuleFilter.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.priority
             (fun f -> ("priority", (Integer.to_json f)));
           Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)))])
    let of_json j =
      {
        i_d = (Util.option_map (Json.lookup j "i_d") String.of_json);
        priority =
          (Util.option_map (Json.lookup j "priority") Integer.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        filter =
          (Util.option_map (Json.lookup j "filter")
             ReplicationRuleFilter.of_json);
        status =
          (ReplicationRuleStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")));
        source_selection_criteria =
          (Util.option_map (Json.lookup j "source_selection_criteria")
             SourceSelectionCriteria.of_json);
        existing_object_replication =
          (Util.option_map (Json.lookup j "existing_object_replication")
             ExistingObjectReplication.of_json);
        destination =
          (Destination.of_json
             (Util.of_option_exn (Json.lookup j "destination")));
        delete_marker_replication =
          (Util.option_map (Json.lookup j "delete_marker_replication")
             DeleteMarkerReplication.of_json)
      }
  end
module ServerSideEncryptionRule =
  struct
    type t =
      {
      apply_server_side_encryption_by_default:
        ServerSideEncryptionByDefault.t option }
    let make ?apply_server_side_encryption_by_default  () =
      { apply_server_side_encryption_by_default }
    let parse xml =
      Some
        {
          apply_server_side_encryption_by_default =
            (Util.option_bind
               (Xml.member "ApplyServerSideEncryptionByDefault" xml)
               ServerSideEncryptionByDefault.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.apply_server_side_encryption_by_default
              (fun f ->
                 Ezxmlm.make_tag "ApplyServerSideEncryptionByDefault"
                   ([], (ServerSideEncryptionByDefault.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.apply_server_side_encryption_by_default
              (fun f ->
                 ("apply_server_side_encryption_by_default",
                   (ServerSideEncryptionByDefault.to_json f)))])
    let of_json j =
      {
        apply_server_side_encryption_by_default =
          (Util.option_map
             (Json.lookup j "apply_server_side_encryption_by_default")
             ServerSideEncryptionByDefault.of_json)
      }
  end
module Rule =
  struct
    type t =
      {
      expiration: LifecycleExpiration.t option ;
      i_d: String.t option ;
      prefix: String.t ;
      status: ExpirationStatus.t ;
      transition: Transition.t option ;
      noncurrent_version_transition: NoncurrentVersionTransition.t option ;
      noncurrent_version_expiration: NoncurrentVersionExpiration.t option ;
      abort_incomplete_multipart_upload:
        AbortIncompleteMultipartUpload.t option }
    let make ?expiration  ?i_d  ~prefix  ~status  ?transition 
      ?noncurrent_version_transition  ?noncurrent_version_expiration 
      ?abort_incomplete_multipart_upload  () =
      {
        expiration;
        i_d;
        prefix;
        status;
        transition;
        noncurrent_version_transition;
        noncurrent_version_expiration;
        abort_incomplete_multipart_upload
      }
    let parse xml =
      Some
        {
          expiration =
            (Util.option_bind (Xml.member "Expiration" xml)
               LifecycleExpiration.parse);
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse);
          prefix =
            (Xml.required "Prefix"
               (Util.option_bind (Xml.member "Prefix" xml) String.parse));
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ExpirationStatus.parse));
          transition =
            (Util.option_bind (Xml.member "Transition" xml) Transition.parse);
          noncurrent_version_transition =
            (Util.option_bind (Xml.member "NoncurrentVersionTransition" xml)
               NoncurrentVersionTransition.parse);
          noncurrent_version_expiration =
            (Util.option_bind (Xml.member "NoncurrentVersionExpiration" xml)
               NoncurrentVersionExpiration.parse);
          abort_incomplete_multipart_upload =
            (Util.option_bind
               (Xml.member "AbortIncompleteMultipartUpload" xml)
               AbortIncompleteMultipartUpload.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.expiration
                     (fun f ->
                        Ezxmlm.make_tag "Expiration"
                          ([], (LifecycleExpiration.to_xml f)))])
                 @
                 [Util.option_map v.i_d
                    (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
                @
                [Some
                   (Ezxmlm.make_tag "Prefix" ([], (String.to_xml v.prefix)))])
               @
               [Some
                  (Ezxmlm.make_tag "Status"
                     ([], (ExpirationStatus.to_xml v.status)))])
              @
              [Util.option_map v.transition
                 (fun f ->
                    Ezxmlm.make_tag "Transition" ([], (Transition.to_xml f)))])
             @
             [Util.option_map v.noncurrent_version_transition
                (fun f ->
                   Ezxmlm.make_tag "NoncurrentVersionTransition"
                     ([], (NoncurrentVersionTransition.to_xml f)))])
            @
            [Util.option_map v.noncurrent_version_expiration
               (fun f ->
                  Ezxmlm.make_tag "NoncurrentVersionExpiration"
                    ([], (NoncurrentVersionExpiration.to_xml f)))])
           @
           [Util.option_map v.abort_incomplete_multipart_upload
              (fun f ->
                 Ezxmlm.make_tag "AbortIncompleteMultipartUpload"
                   ([], (AbortIncompleteMultipartUpload.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.abort_incomplete_multipart_upload
              (fun f ->
                 ("abort_incomplete_multipart_upload",
                   (AbortIncompleteMultipartUpload.to_json f)));
           Util.option_map v.noncurrent_version_expiration
             (fun f ->
                ("noncurrent_version_expiration",
                  (NoncurrentVersionExpiration.to_json f)));
           Util.option_map v.noncurrent_version_transition
             (fun f ->
                ("noncurrent_version_transition",
                  (NoncurrentVersionTransition.to_json f)));
           Util.option_map v.transition
             (fun f -> ("transition", (Transition.to_json f)));
           Some ("status", (ExpirationStatus.to_json v.status));
           Some ("prefix", (String.to_json v.prefix));
           Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (LifecycleExpiration.to_json f)))])
    let of_json j =
      {
        expiration =
          (Util.option_map (Json.lookup j "expiration")
             LifecycleExpiration.of_json);
        i_d = (Util.option_map (Json.lookup j "i_d") String.of_json);
        prefix =
          (String.of_json (Util.of_option_exn (Json.lookup j "prefix")));
        status =
          (ExpirationStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")));
        transition =
          (Util.option_map (Json.lookup j "transition") Transition.of_json);
        noncurrent_version_transition =
          (Util.option_map (Json.lookup j "noncurrent_version_transition")
             NoncurrentVersionTransition.of_json);
        noncurrent_version_expiration =
          (Util.option_map (Json.lookup j "noncurrent_version_expiration")
             NoncurrentVersionExpiration.of_json);
        abort_incomplete_multipart_upload =
          (Util.option_map
             (Json.lookup j "abort_incomplete_multipart_upload")
             AbortIncompleteMultipartUpload.of_json)
      }
  end
module AnalyticsFilter =
  struct
    type t =
      {
      prefix: String.t option ;
      tag: Tag.t option ;
      and_: AnalyticsAndOperator.t option }
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml)
               AnalyticsAndOperator.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.prefix
                (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
            @
            [Util.option_map v.tag
               (fun f -> Ezxmlm.make_tag "Tag" ([], (Tag.to_xml f)))])
           @
           [Util.option_map v.and_
              (fun f ->
                 Ezxmlm.make_tag "And" ([], (AnalyticsAndOperator.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (AnalyticsAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tag = (Util.option_map (Json.lookup j "tag") Tag.of_json);
        and_ =
          (Util.option_map (Json.lookup j "and_")
             AnalyticsAndOperator.of_json)
      }
  end
module StorageClassAnalysis =
  struct
    type t = {
      data_export: StorageClassAnalysisDataExport.t option }
    let make ?data_export  () = { data_export }
    let parse xml =
      Some
        {
          data_export =
            (Util.option_bind (Xml.member "DataExport" xml)
               StorageClassAnalysisDataExport.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.data_export
              (fun f ->
                 Ezxmlm.make_tag "DataExport"
                   ([], (StorageClassAnalysisDataExport.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.data_export
              (fun f ->
                 ("data_export", (StorageClassAnalysisDataExport.to_json f)))])
    let of_json j =
      {
        data_export =
          (Util.option_map (Json.lookup j "data_export")
             StorageClassAnalysisDataExport.of_json)
      }
  end
module Tier =
  struct
    type t =
      | Standard 
      | Bulk 
      | Expedited 
    let str_to_t =
      [("Expedited", Expedited); ("Bulk", Bulk); ("Standard", Standard)]
    let t_to_str =
      [(Expedited, "Expedited"); (Bulk, "Bulk"); (Standard, "Standard")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module S3Location =
  struct
    type t =
      {
      bucket_name: String.t ;
      prefix: String.t ;
      encryption: Encryption.t option ;
      canned_a_c_l: ObjectCannedACL.t option ;
      access_control_list: Grants.t ;
      tagging: Tagging.t option ;
      user_metadata: UserMetadata.t ;
      storage_class: StorageClass.t option }
    let make ~bucket_name  ~prefix  ?encryption  ?canned_a_c_l 
      ?(access_control_list= [])  ?tagging  ?(user_metadata= []) 
      ?storage_class  () =
      {
        bucket_name;
        prefix;
        encryption;
        canned_a_c_l;
        access_control_list;
        tagging;
        user_metadata;
        storage_class
      }
    let parse xml =
      Some
        {
          bucket_name =
            (Xml.required "BucketName"
               (Util.option_bind (Xml.member "BucketName" xml) String.parse));
          prefix =
            (Xml.required "Prefix"
               (Util.option_bind (Xml.member "Prefix" xml) String.parse));
          encryption =
            (Util.option_bind (Xml.member "Encryption" xml) Encryption.parse);
          canned_a_c_l =
            (Util.option_bind (Xml.member "CannedACL" xml)
               ObjectCannedACL.parse);
          access_control_list =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccessControlList" xml)
                  Grants.parse));
          tagging =
            (Util.option_bind (Xml.member "Tagging" xml) Tagging.parse);
          user_metadata =
            (Util.of_option []
               (Util.option_bind (Xml.member "UserMetadata" xml)
                  UserMetadata.parse));
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               StorageClass.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Some
                     (Ezxmlm.make_tag "BucketName"
                        ([], (String.to_xml v.bucket_name)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "Prefix" ([], (String.to_xml v.prefix)))])
                @
                [Util.option_map v.encryption
                   (fun f ->
                      Ezxmlm.make_tag "Encryption"
                        ([], (Encryption.to_xml f)))])
               @
               [Util.option_map v.canned_a_c_l
                  (fun f ->
                     Ezxmlm.make_tag "CannedACL"
                       ([], (ObjectCannedACL.to_xml f)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "AccessControlList"
                         ([], (Grants.to_xml [x])))) v.access_control_list))
             @
             [Util.option_map v.tagging
                (fun f -> Ezxmlm.make_tag "Tagging" ([], (Tagging.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "UserMetadata"
                       ([], (UserMetadata.to_xml [x])))) v.user_metadata))
           @
           [Util.option_map v.storage_class
              (fun f ->
                 Ezxmlm.make_tag "StorageClass" ([], (StorageClass.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.storage_class
              (fun f -> ("storage_class", (StorageClass.to_json f)));
           Some ("user_metadata", (UserMetadata.to_json v.user_metadata));
           Util.option_map v.tagging
             (fun f -> ("tagging", (Tagging.to_json f)));
           Some
             ("access_control_list", (Grants.to_json v.access_control_list));
           Util.option_map v.canned_a_c_l
             (fun f -> ("canned_a_c_l", (ObjectCannedACL.to_json f)));
           Util.option_map v.encryption
             (fun f -> ("encryption", (Encryption.to_json f)));
           Some ("prefix", (String.to_json v.prefix));
           Some ("bucket_name", (String.to_json v.bucket_name))])
    let of_json j =
      {
        bucket_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket_name")));
        prefix =
          (String.of_json (Util.of_option_exn (Json.lookup j "prefix")));
        encryption =
          (Util.option_map (Json.lookup j "encryption") Encryption.of_json);
        canned_a_c_l =
          (Util.option_map (Json.lookup j "canned_a_c_l")
             ObjectCannedACL.of_json);
        access_control_list =
          (Grants.of_json
             (Util.of_option_exn (Json.lookup j "access_control_list")));
        tagging = (Util.option_map (Json.lookup j "tagging") Tagging.of_json);
        user_metadata =
          (UserMetadata.of_json
             (Util.of_option_exn (Json.lookup j "user_metadata")));
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json)
      }
  end
module ExpressionType =
  struct
    type t =
      | SQL 
    let str_to_t = [("SQL", SQL)]
    let t_to_str = [(SQL, "SQL")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module InputSerialization =
  struct
    type t =
      {
      c_s_v: CSVInput.t option ;
      compression_type: CompressionType.t option ;
      j_s_o_n: JSONInput.t option ;
      parquet: ParquetInput.t option }
    let make ?c_s_v  ?compression_type  ?j_s_o_n  ?parquet  () =
      { c_s_v; compression_type; j_s_o_n; parquet }
    let parse xml =
      Some
        {
          c_s_v = (Util.option_bind (Xml.member "CSV" xml) CSVInput.parse);
          compression_type =
            (Util.option_bind (Xml.member "CompressionType" xml)
               CompressionType.parse);
          j_s_o_n =
            (Util.option_bind (Xml.member "JSON" xml) JSONInput.parse);
          parquet =
            (Util.option_bind (Xml.member "Parquet" xml) ParquetInput.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.c_s_v
                 (fun f -> Ezxmlm.make_tag "CSV" ([], (CSVInput.to_xml f)))])
             @
             [Util.option_map v.compression_type
                (fun f ->
                   Ezxmlm.make_tag "CompressionType"
                     ([], (CompressionType.to_xml f)))])
            @
            [Util.option_map v.j_s_o_n
               (fun f -> Ezxmlm.make_tag "JSON" ([], (JSONInput.to_xml f)))])
           @
           [Util.option_map v.parquet
              (fun f ->
                 Ezxmlm.make_tag "Parquet" ([], (ParquetInput.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.parquet
              (fun f -> ("parquet", (ParquetInput.to_json f)));
           Util.option_map v.j_s_o_n
             (fun f -> ("j_s_o_n", (JSONInput.to_json f)));
           Util.option_map v.compression_type
             (fun f -> ("compression_type", (CompressionType.to_json f)));
           Util.option_map v.c_s_v (fun f -> ("c_s_v", (CSVInput.to_json f)))])
    let of_json j =
      {
        c_s_v = (Util.option_map (Json.lookup j "c_s_v") CSVInput.of_json);
        compression_type =
          (Util.option_map (Json.lookup j "compression_type")
             CompressionType.of_json);
        j_s_o_n =
          (Util.option_map (Json.lookup j "j_s_o_n") JSONInput.of_json);
        parquet =
          (Util.option_map (Json.lookup j "parquet") ParquetInput.of_json)
      }
  end
module OutputSerialization =
  struct
    type t = {
      c_s_v: CSVOutput.t option ;
      j_s_o_n: JSONOutput.t option }
    let make ?c_s_v  ?j_s_o_n  () = { c_s_v; j_s_o_n }
    let parse xml =
      Some
        {
          c_s_v = (Util.option_bind (Xml.member "CSV" xml) CSVOutput.parse);
          j_s_o_n =
            (Util.option_bind (Xml.member "JSON" xml) JSONOutput.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.c_s_v
               (fun f -> Ezxmlm.make_tag "CSV" ([], (CSVOutput.to_xml f)))])
           @
           [Util.option_map v.j_s_o_n
              (fun f -> Ezxmlm.make_tag "JSON" ([], (JSONOutput.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.j_s_o_n
              (fun f -> ("j_s_o_n", (JSONOutput.to_json f)));
           Util.option_map v.c_s_v
             (fun f -> ("c_s_v", (CSVOutput.to_json f)))])
    let of_json j =
      {
        c_s_v = (Util.option_map (Json.lookup j "c_s_v") CSVOutput.of_json);
        j_s_o_n =
          (Util.option_map (Json.lookup j "j_s_o_n") JSONOutput.of_json)
      }
  end
module ObjectVersionStorageClass =
  struct
    type t =
      | STANDARD 
    let str_to_t = [("STANDARD", STANDARD)]
    let t_to_str = [(STANDARD, "STANDARD")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module DefaultRetention =
  struct
    type t =
      {
      mode: ObjectLockRetentionMode.t option ;
      days: Integer.t option ;
      years: Integer.t option }
    let make ?mode  ?days  ?years  () = { mode; days; years }
    let parse xml =
      Some
        {
          mode =
            (Util.option_bind (Xml.member "Mode" xml)
               ObjectLockRetentionMode.parse);
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          years = (Util.option_bind (Xml.member "Years" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.mode
                (fun f ->
                   Ezxmlm.make_tag "Mode"
                     ([], (ObjectLockRetentionMode.to_xml f)))])
            @
            [Util.option_map v.days
               (fun f -> Ezxmlm.make_tag "Days" ([], (Integer.to_xml f)))])
           @
           [Util.option_map v.years
              (fun f -> Ezxmlm.make_tag "Years" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.years (fun f -> ("years", (Integer.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ObjectLockRetentionMode.to_json f)))])
    let of_json j =
      {
        mode =
          (Util.option_map (Json.lookup j "mode")
             ObjectLockRetentionMode.of_json);
        days = (Util.option_map (Json.lookup j "days") Integer.of_json);
        years = (Util.option_map (Json.lookup j "years") Integer.of_json)
      }
  end
module ObjectIdentifier =
  struct
    type t = {
      key: String.t ;
      version_id: String.t option }
    let make ~key  ?version_id  () = { key; version_id }
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))]) @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json)
      }
  end
module InventoryDestination =
  struct
    type t = {
      s3_bucket_destination: InventoryS3BucketDestination.t }
    let make ~s3_bucket_destination  () = { s3_bucket_destination }
    let parse xml =
      Some
        {
          s3_bucket_destination =
            (Xml.required "S3BucketDestination"
               (Util.option_bind (Xml.member "S3BucketDestination" xml)
                  InventoryS3BucketDestination.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "S3BucketDestination"
                 ([],
                   (InventoryS3BucketDestination.to_xml
                      v.s3_bucket_destination)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("s3_bucket_destination",
                (InventoryS3BucketDestination.to_json v.s3_bucket_destination))])
    let of_json j =
      {
        s3_bucket_destination =
          (InventoryS3BucketDestination.of_json
             (Util.of_option_exn (Json.lookup j "s3_bucket_destination")))
      }
  end
module InventoryFilter =
  struct
    type t = {
      prefix: String.t }
    let make ~prefix  () = { prefix }
    let parse xml =
      Some
        {
          prefix =
            (Xml.required "Prefix"
               (Util.option_bind (Xml.member "Prefix" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Prefix" ([], (String.to_xml v.prefix)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("prefix", (String.to_json v.prefix))])
    let of_json j =
      {
        prefix =
          (String.of_json (Util.of_option_exn (Json.lookup j "prefix")))
      }
  end
module InventoryIncludedObjectVersions =
  struct
    type t =
      | All 
      | Current 
    let str_to_t = [("Current", Current); ("All", All)]
    let t_to_str = [(Current, "Current"); (All, "All")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module InventoryOptionalFields =
  struct
    type t = InventoryOptionalField.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map InventoryOptionalField.parse (Xml.members "Field" xml))
    let to_query v = Query.to_query_list InventoryOptionalField.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryOptionalField.to_headers v
    let to_xml v =
      List.map
        (fun x ->
           Ezxmlm.make_tag "member" ([], (InventoryOptionalField.to_xml x)))
        v
    let to_json v = `List (List.map InventoryOptionalField.to_json v)
    let of_json j = Json.to_list InventoryOptionalField.of_json j
  end
module InventorySchedule =
  struct
    type t = {
      frequency: InventoryFrequency.t }
    let make ~frequency  () = { frequency }
    let parse xml =
      Some
        {
          frequency =
            (Xml.required "Frequency"
               (Util.option_bind (Xml.member "Frequency" xml)
                  InventoryFrequency.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some
              (Ezxmlm.make_tag "Frequency"
                 ([], (InventoryFrequency.to_xml v.frequency)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("frequency", (InventoryFrequency.to_json v.frequency))])
    let of_json j =
      {
        frequency =
          (InventoryFrequency.of_json
             (Util.of_option_exn (Json.lookup j "frequency")))
      }
  end
module RoutingRule =
  struct
    type t = {
      condition: Condition.t option ;
      redirect: Redirect.t }
    let make ?condition  ~redirect  () = { condition; redirect }
    let parse xml =
      Some
        {
          condition =
            (Util.option_bind (Xml.member "Condition" xml) Condition.parse);
          redirect =
            (Xml.required "Redirect"
               (Util.option_bind (Xml.member "Redirect" xml) Redirect.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.condition
               (fun f ->
                  Ezxmlm.make_tag "Condition" ([], (Condition.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "Redirect" ([], (Redirect.to_xml v.redirect)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("redirect", (Redirect.to_json v.redirect));
           Util.option_map v.condition
             (fun f -> ("condition", (Condition.to_json f)))])
    let of_json j =
      {
        condition =
          (Util.option_map (Json.lookup j "condition") Condition.of_json);
        redirect =
          (Redirect.of_json (Util.of_option_exn (Json.lookup j "redirect")))
      }
  end
module CORSRule =
  struct
    type t =
      {
      allowed_headers: AllowedHeaders.t ;
      allowed_methods: AllowedMethods.t ;
      allowed_origins: AllowedOrigins.t ;
      expose_headers: ExposeHeaders.t ;
      max_age_seconds: Integer.t option }
    let make ?(allowed_headers= [])  ~allowed_methods  ~allowed_origins 
      ?(expose_headers= [])  ?max_age_seconds  () =
      {
        allowed_headers;
        allowed_methods;
        allowed_origins;
        expose_headers;
        max_age_seconds
      }
    let parse xml =
      Some
        {
          allowed_headers = (Util.of_option [] (AllowedHeaders.parse xml));
          allowed_methods =
            (Xml.required "AllowedMethod" (AllowedMethods.parse xml));
          allowed_origins =
            (Xml.required "AllowedOrigin" (AllowedOrigins.parse xml));
          expose_headers = (Util.of_option [] (ExposeHeaders.parse xml));
          max_age_seconds =
            (Util.option_bind (Xml.member "MaxAgeSeconds" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               (List.map
                  (fun x ->
                     Some
                       (Ezxmlm.make_tag "AllowedHeader"
                          ([], (AllowedHeaders.to_xml [x]))))
                  v.allowed_headers))
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "AllowedMethod"
                         ([], (AllowedMethods.to_xml [x]))))
                 v.allowed_methods))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "AllowedOrigin"
                        ([], (AllowedOrigins.to_xml [x])))) v.allowed_origins))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "ExposeHeader"
                       ([], (ExposeHeaders.to_xml [x])))) v.expose_headers))
           @
           [Util.option_map v.max_age_seconds
              (fun f ->
                 Ezxmlm.make_tag "MaxAgeSeconds" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.max_age_seconds
              (fun f -> ("max_age_seconds", (Integer.to_json f)));
           Some ("expose_headers", (ExposeHeaders.to_json v.expose_headers));
           Some
             ("allowed_origins", (AllowedOrigins.to_json v.allowed_origins));
           Some
             ("allowed_methods", (AllowedMethods.to_json v.allowed_methods));
           Some
             ("allowed_headers", (AllowedHeaders.to_json v.allowed_headers))])
    let of_json j =
      {
        allowed_headers =
          (AllowedHeaders.of_json
             (Util.of_option_exn (Json.lookup j "allowed_headers")));
        allowed_methods =
          (AllowedMethods.of_json
             (Util.of_option_exn (Json.lookup j "allowed_methods")));
        allowed_origins =
          (AllowedOrigins.of_json
             (Util.of_option_exn (Json.lookup j "allowed_origins")));
        expose_headers =
          (ExposeHeaders.of_json
             (Util.of_option_exn (Json.lookup j "expose_headers")));
        max_age_seconds =
          (Util.option_map (Json.lookup j "max_age_seconds") Integer.of_json)
      }
  end
module MetricsFilter =
  struct
    type t =
      {
      prefix: String.t option ;
      tag: Tag.t option ;
      and_: MetricsAndOperator.t option }
    let make ?prefix  ?tag  ?and_  () = { prefix; tag; and_ }
    let parse xml =
      Some
        {
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          tag = (Util.option_bind (Xml.member "Tag" xml) Tag.parse);
          and_ =
            (Util.option_bind (Xml.member "And" xml) MetricsAndOperator.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.prefix
                (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
            @
            [Util.option_map v.tag
               (fun f -> Ezxmlm.make_tag "Tag" ([], (Tag.to_xml f)))])
           @
           [Util.option_map v.and_
              (fun f ->
                 Ezxmlm.make_tag "And" ([], (MetricsAndOperator.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.and_
              (fun f -> ("and_", (MetricsAndOperator.to_json f)));
           Util.option_map v.tag (fun f -> ("tag", (Tag.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      {
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        tag = (Util.option_map (Json.lookup j "tag") Tag.of_json);
        and_ =
          (Util.option_map (Json.lookup j "and_") MetricsAndOperator.of_json)
      }
  end
module TargetGrants =
  struct
    type t = TargetGrant.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map TargetGrant.parse (Xml.members "Grant" xml))
    let to_query v = Query.to_query_list TargetGrant.to_query v
    let to_headers v = Headers.to_headers_list TargetGrant.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (TargetGrant.to_xml x))) v
    let to_json v = `List (List.map TargetGrant.to_json v)
    let of_json j = Json.to_list TargetGrant.of_json j
  end
module CompletedPart =
  struct
    type t = {
      e_tag: String.t ;
      part_number: Integer.t }
    let make ~e_tag  ~part_number  () = { e_tag; part_number }
    let parse xml =
      Some
        {
          e_tag =
            (Xml.required "ETag"
               (Util.option_bind (Xml.member "ETag" xml) String.parse));
          part_number =
            (Xml.required "PartNumber"
               (Util.option_bind (Xml.member "PartNumber" xml) Integer.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "ETag" ([], (String.to_xml v.e_tag)))])
           @
           [Some
              (Ezxmlm.make_tag "PartNumber"
                 ([], (Integer.to_xml v.part_number)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("part_number", (Integer.to_json v.part_number));
           Some ("e_tag", (String.to_json v.e_tag))])
    let of_json j =
      {
        e_tag = (String.of_json (Util.of_option_exn (Json.lookup j "e_tag")));
        part_number =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "part_number")))
      }
  end
module Progress =
  struct
    type t =
      {
      bytes_scanned: Long.t option ;
      bytes_processed: Long.t option ;
      bytes_returned: Long.t option }
    let make ?bytes_scanned  ?bytes_processed  ?bytes_returned  () =
      { bytes_scanned; bytes_processed; bytes_returned }
    let parse xml =
      Some
        {
          bytes_scanned =
            (Util.option_bind (Xml.member "BytesScanned" xml) Long.parse);
          bytes_processed =
            (Util.option_bind (Xml.member "BytesProcessed" xml) Long.parse);
          bytes_returned =
            (Util.option_bind (Xml.member "BytesReturned" xml) Long.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.bytes_scanned
                (fun f ->
                   Ezxmlm.make_tag "BytesScanned" ([], (Long.to_xml f)))])
            @
            [Util.option_map v.bytes_processed
               (fun f ->
                  Ezxmlm.make_tag "BytesProcessed" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.bytes_returned
              (fun f -> Ezxmlm.make_tag "BytesReturned" ([], (Long.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.bytes_returned
              (fun f -> ("bytes_returned", (Long.to_json f)));
           Util.option_map v.bytes_processed
             (fun f -> ("bytes_processed", (Long.to_json f)));
           Util.option_map v.bytes_scanned
             (fun f -> ("bytes_scanned", (Long.to_json f)))])
    let of_json j =
      {
        bytes_scanned =
          (Util.option_map (Json.lookup j "bytes_scanned") Long.of_json);
        bytes_processed =
          (Util.option_map (Json.lookup j "bytes_processed") Long.of_json);
        bytes_returned =
          (Util.option_map (Json.lookup j "bytes_returned") Long.of_json)
      }
  end
module Stats =
  struct
    type t =
      {
      bytes_scanned: Long.t option ;
      bytes_processed: Long.t option ;
      bytes_returned: Long.t option }
    let make ?bytes_scanned  ?bytes_processed  ?bytes_returned  () =
      { bytes_scanned; bytes_processed; bytes_returned }
    let parse xml =
      Some
        {
          bytes_scanned =
            (Util.option_bind (Xml.member "BytesScanned" xml) Long.parse);
          bytes_processed =
            (Util.option_bind (Xml.member "BytesProcessed" xml) Long.parse);
          bytes_returned =
            (Util.option_bind (Xml.member "BytesReturned" xml) Long.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.bytes_scanned
                (fun f ->
                   Ezxmlm.make_tag "BytesScanned" ([], (Long.to_xml f)))])
            @
            [Util.option_map v.bytes_processed
               (fun f ->
                  Ezxmlm.make_tag "BytesProcessed" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.bytes_returned
              (fun f -> Ezxmlm.make_tag "BytesReturned" ([], (Long.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.bytes_returned
              (fun f -> ("bytes_returned", (Long.to_json f)));
           Util.option_map v.bytes_processed
             (fun f -> ("bytes_processed", (Long.to_json f)));
           Util.option_map v.bytes_scanned
             (fun f -> ("bytes_scanned", (Long.to_json f)))])
    let of_json j =
      {
        bytes_scanned =
          (Util.option_map (Json.lookup j "bytes_scanned") Long.of_json);
        bytes_processed =
          (Util.option_map (Json.lookup j "bytes_processed") Long.of_json);
        bytes_returned =
          (Util.option_map (Json.lookup j "bytes_returned") Long.of_json)
      }
  end
module LifecycleRule =
  struct
    type t =
      {
      expiration: LifecycleExpiration.t option ;
      i_d: String.t option ;
      prefix: String.t option ;
      filter: LifecycleRuleFilter.t option ;
      status: ExpirationStatus.t ;
      transitions: TransitionList.t ;
      noncurrent_version_transitions: NoncurrentVersionTransitionList.t ;
      noncurrent_version_expiration: NoncurrentVersionExpiration.t option ;
      abort_incomplete_multipart_upload:
        AbortIncompleteMultipartUpload.t option }
    let make ?expiration  ?i_d  ?prefix  ?filter  ~status  ?(transitions= [])
       ?(noncurrent_version_transitions= [])  ?noncurrent_version_expiration 
      ?abort_incomplete_multipart_upload  () =
      {
        expiration;
        i_d;
        prefix;
        filter;
        status;
        transitions;
        noncurrent_version_transitions;
        noncurrent_version_expiration;
        abort_incomplete_multipart_upload
      }
    let parse xml =
      Some
        {
          expiration =
            (Util.option_bind (Xml.member "Expiration" xml)
               LifecycleExpiration.parse);
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse);
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          filter =
            (Util.option_bind (Xml.member "Filter" xml)
               LifecycleRuleFilter.parse);
          status =
            (Xml.required "Status"
               (Util.option_bind (Xml.member "Status" xml)
                  ExpirationStatus.parse));
          transitions = (Util.of_option [] (TransitionList.parse xml));
          noncurrent_version_transitions =
            (Util.of_option [] (NoncurrentVersionTransitionList.parse xml));
          noncurrent_version_expiration =
            (Util.option_bind (Xml.member "NoncurrentVersionExpiration" xml)
               NoncurrentVersionExpiration.parse);
          abort_incomplete_multipart_upload =
            (Util.option_bind
               (Xml.member "AbortIncompleteMultipartUpload" xml)
               AbortIncompleteMultipartUpload.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.expiration
                      (fun f ->
                         Ezxmlm.make_tag "Expiration"
                           ([], (LifecycleExpiration.to_xml f)))])
                  @
                  [Util.option_map v.i_d
                     (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.prefix
                    (fun f ->
                       Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
                @
                [Util.option_map v.filter
                   (fun f ->
                      Ezxmlm.make_tag "Filter"
                        ([], (LifecycleRuleFilter.to_xml f)))])
               @
               [Some
                  (Ezxmlm.make_tag "Status"
                     ([], (ExpirationStatus.to_xml v.status)))])
              @
              (List.map
                 (fun x ->
                    Some
                      (Ezxmlm.make_tag "Transition"
                         ([], (TransitionList.to_xml [x])))) v.transitions))
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "NoncurrentVersionTransition"
                        ([], (NoncurrentVersionTransitionList.to_xml [x]))))
                v.noncurrent_version_transitions))
            @
            [Util.option_map v.noncurrent_version_expiration
               (fun f ->
                  Ezxmlm.make_tag "NoncurrentVersionExpiration"
                    ([], (NoncurrentVersionExpiration.to_xml f)))])
           @
           [Util.option_map v.abort_incomplete_multipart_upload
              (fun f ->
                 Ezxmlm.make_tag "AbortIncompleteMultipartUpload"
                   ([], (AbortIncompleteMultipartUpload.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.abort_incomplete_multipart_upload
              (fun f ->
                 ("abort_incomplete_multipart_upload",
                   (AbortIncompleteMultipartUpload.to_json f)));
           Util.option_map v.noncurrent_version_expiration
             (fun f ->
                ("noncurrent_version_expiration",
                  (NoncurrentVersionExpiration.to_json f)));
           Some
             ("noncurrent_version_transitions",
               (NoncurrentVersionTransitionList.to_json
                  v.noncurrent_version_transitions));
           Some ("transitions", (TransitionList.to_json v.transitions));
           Some ("status", (ExpirationStatus.to_json v.status));
           Util.option_map v.filter
             (fun f -> ("filter", (LifecycleRuleFilter.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (LifecycleExpiration.to_json f)))])
    let of_json j =
      {
        expiration =
          (Util.option_map (Json.lookup j "expiration")
             LifecycleExpiration.of_json);
        i_d = (Util.option_map (Json.lookup j "i_d") String.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        filter =
          (Util.option_map (Json.lookup j "filter")
             LifecycleRuleFilter.of_json);
        status =
          (ExpirationStatus.of_json
             (Util.of_option_exn (Json.lookup j "status")));
        transitions =
          (TransitionList.of_json
             (Util.of_option_exn (Json.lookup j "transitions")));
        noncurrent_version_transitions =
          (NoncurrentVersionTransitionList.of_json
             (Util.of_option_exn
                (Json.lookup j "noncurrent_version_transitions")));
        noncurrent_version_expiration =
          (Util.option_map (Json.lookup j "noncurrent_version_expiration")
             NoncurrentVersionExpiration.of_json);
        abort_incomplete_multipart_upload =
          (Util.option_map
             (Json.lookup j "abort_incomplete_multipart_upload")
             AbortIncompleteMultipartUpload.of_json)
      }
  end
module Initiator =
  struct
    type t = {
      i_d: String.t option ;
      display_name: String.t option }
    let make ?i_d  ?display_name  () = { i_d; display_name }
    let parse xml =
      Some
        {
          i_d = (Util.option_bind (Xml.member "ID" xml) String.parse);
          display_name =
            (Util.option_bind (Xml.member "DisplayName" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.i_d
               (fun f -> Ezxmlm.make_tag "ID" ([], (String.to_xml f)))])
           @
           [Util.option_map v.display_name
              (fun f -> Ezxmlm.make_tag "DisplayName" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.display_name
              (fun f -> ("display_name", (String.to_json f)));
           Util.option_map v.i_d (fun f -> ("i_d", (String.to_json f)))])
    let of_json j =
      {
        i_d = (Util.option_map (Json.lookup j "i_d") String.of_json);
        display_name =
          (Util.option_map (Json.lookup j "display_name") String.of_json)
      }
  end
module LambdaFunctionConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      lambda_function_arn: String.t ;
      events: EventList.t ;
      filter: NotificationConfigurationFilter.t option }
    let make ?id  ~lambda_function_arn  ~events  ?filter  () =
      { id; lambda_function_arn; events; filter }
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          lambda_function_arn =
            (Xml.required "CloudFunction"
               (Util.option_bind (Xml.member "CloudFunction" xml)
                  String.parse));
          events = (Xml.required "Event" (EventList.parse xml));
          filter =
            (Util.option_bind (Xml.member "Filter" xml)
               NotificationConfigurationFilter.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.id
                 (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "CloudFunction"
                   ([], (String.to_xml v.lambda_function_arn)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Event" ([], (EventList.to_xml [x]))))
               v.events))
           @
           [Util.option_map v.filter
              (fun f ->
                 Ezxmlm.make_tag "Filter"
                   ([], (NotificationConfigurationFilter.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f ->
                 ("filter", (NotificationConfigurationFilter.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Some
             ("lambda_function_arn", (String.to_json v.lambda_function_arn));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        lambda_function_arn =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "lambda_function_arn")));
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")));
        filter =
          (Util.option_map (Json.lookup j "filter")
             NotificationConfigurationFilter.of_json)
      }
  end
module QueueConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      queue_arn: String.t ;
      events: EventList.t ;
      filter: NotificationConfigurationFilter.t option }
    let make ?id  ~queue_arn  ~events  ?filter  () =
      { id; queue_arn; events; filter }
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          queue_arn =
            (Xml.required "Queue"
               (Util.option_bind (Xml.member "Queue" xml) String.parse));
          events = (Xml.required "Event" (EventList.parse xml));
          filter =
            (Util.option_bind (Xml.member "Filter" xml)
               NotificationConfigurationFilter.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.id
                 (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "Queue" ([], (String.to_xml v.queue_arn)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Event" ([], (EventList.to_xml [x]))))
               v.events))
           @
           [Util.option_map v.filter
              (fun f ->
                 Ezxmlm.make_tag "Filter"
                   ([], (NotificationConfigurationFilter.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f ->
                 ("filter", (NotificationConfigurationFilter.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Some ("queue_arn", (String.to_json v.queue_arn));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        queue_arn =
          (String.of_json (Util.of_option_exn (Json.lookup j "queue_arn")));
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")));
        filter =
          (Util.option_map (Json.lookup j "filter")
             NotificationConfigurationFilter.of_json)
      }
  end
module TopicConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      topic_arn: String.t ;
      events: EventList.t ;
      filter: NotificationConfigurationFilter.t option }
    let make ?id  ~topic_arn  ~events  ?filter  () =
      { id; topic_arn; events; filter }
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          topic_arn =
            (Xml.required "Topic"
               (Util.option_bind (Xml.member "Topic" xml) String.parse));
          events = (Xml.required "Event" (EventList.parse xml));
          filter =
            (Util.option_bind (Xml.member "Filter" xml)
               NotificationConfigurationFilter.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.id
                 (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "Topic" ([], (String.to_xml v.topic_arn)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Event" ([], (EventList.to_xml [x]))))
               v.events))
           @
           [Util.option_map v.filter
              (fun f ->
                 Ezxmlm.make_tag "Filter"
                   ([], (NotificationConfigurationFilter.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f ->
                 ("filter", (NotificationConfigurationFilter.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Some ("topic_arn", (String.to_json v.topic_arn));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        topic_arn =
          (String.of_json (Util.of_option_exn (Json.lookup j "topic_arn")));
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")));
        filter =
          (Util.option_map (Json.lookup j "filter")
             NotificationConfigurationFilter.of_json)
      }
  end
module CommonPrefix =
  struct
    type t = {
      prefix: String.t option }
    let make ?prefix  () = { prefix }
    let parse xml =
      Some
        { prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.prefix
              (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> ("prefix", (String.to_json f)))])
    let of_json j =
      { prefix = (Util.option_map (Json.lookup j "prefix") String.of_json) }
  end
module Object =
  struct
    type t =
      {
      key: String.t ;
      last_modified: DateTime.t ;
      e_tag: String.t ;
      size: Integer.t ;
      storage_class: ObjectStorageClass.t ;
      owner: Owner.t option }
    let make ~key  ~last_modified  ~e_tag  ~size  ~storage_class  ?owner  ()
      = { key; last_modified; e_tag; size; storage_class; owner }
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          last_modified =
            (Xml.required "LastModified"
               (Util.option_bind (Xml.member "LastModified" xml)
                  DateTime.parse));
          e_tag =
            (Xml.required "ETag"
               (Util.option_bind (Xml.member "ETag" xml) String.parse));
          size =
            (Xml.required "Size"
               (Util.option_bind (Xml.member "Size" xml) Integer.parse));
          storage_class =
            (Xml.required "StorageClass"
               (Util.option_bind (Xml.member "StorageClass" xml)
                  ObjectStorageClass.parse));
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
               @
               [Some
                  (Ezxmlm.make_tag "LastModified"
                     ([], (DateTime.to_xml v.last_modified)))])
              @ [Some (Ezxmlm.make_tag "ETag" ([], (String.to_xml v.e_tag)))])
             @ [Some (Ezxmlm.make_tag "Size" ([], (Integer.to_xml v.size)))])
            @
            [Some
               (Ezxmlm.make_tag "StorageClass"
                  ([], (ObjectStorageClass.to_xml v.storage_class)))])
           @
           [Util.option_map v.owner
              (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Some
             ("storage_class", (ObjectStorageClass.to_json v.storage_class));
           Some ("size", (Integer.to_json v.size));
           Some ("e_tag", (String.to_json v.e_tag));
           Some ("last_modified", (DateTime.to_json v.last_modified));
           Some ("key", (String.to_json v.key))])
    let of_json j =
      {
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        last_modified =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "last_modified")));
        e_tag = (String.of_json (Util.of_option_exn (Json.lookup j "e_tag")));
        size = (Integer.of_json (Util.of_option_exn (Json.lookup j "size")));
        storage_class =
          (ObjectStorageClass.of_json
             (Util.of_option_exn (Json.lookup j "storage_class")));
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json)
      }
  end
module ReplicationRules =
  struct
    type t = ReplicationRule.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map ReplicationRule.parse [xml])
    let to_query v = Query.to_query_list ReplicationRule.to_query v
    let to_headers v = Headers.to_headers_list ReplicationRule.to_headers v
    let to_xml v = List.concat (List.map ReplicationRule.to_xml v)
    let to_json v = `List (List.map ReplicationRule.to_json v)
    let of_json j = Json.to_list ReplicationRule.of_json j
  end
module ServerSideEncryptionRules =
  struct
    type t = ServerSideEncryptionRule.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map ServerSideEncryptionRule.parse [xml])
    let to_query v = Query.to_query_list ServerSideEncryptionRule.to_query v
    let to_headers v =
      Headers.to_headers_list ServerSideEncryptionRule.to_headers v
    let to_xml v = List.concat (List.map ServerSideEncryptionRule.to_xml v)
    let to_json v = `List (List.map ServerSideEncryptionRule.to_json v)
    let of_json j = Json.to_list ServerSideEncryptionRule.of_json j
  end
module Rules =
  struct
    type t = Rule.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map Rule.parse [xml])
    let to_query v = Query.to_query_list Rule.to_query v
    let to_headers v = Headers.to_headers_list Rule.to_headers v
    let to_xml v = List.concat (List.map Rule.to_xml v)
    let to_json v = `List (List.map Rule.to_json v)
    let of_json j = Json.to_list Rule.of_json j
  end
module AnalyticsConfiguration =
  struct
    type t =
      {
      id: String.t ;
      filter: AnalyticsFilter.t option ;
      storage_class_analysis: StorageClassAnalysis.t }
    let make ~id  ?filter  ~storage_class_analysis  () =
      { id; filter; storage_class_analysis }
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          filter =
            (Util.option_bind (Xml.member "Filter" xml) AnalyticsFilter.parse);
          storage_class_analysis =
            (Xml.required "StorageClassAnalysis"
               (Util.option_bind (Xml.member "StorageClassAnalysis" xml)
                  StorageClassAnalysis.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
            [Util.option_map v.filter
               (fun f ->
                  Ezxmlm.make_tag "Filter" ([], (AnalyticsFilter.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "StorageClassAnalysis"
                 ([], (StorageClassAnalysis.to_xml v.storage_class_analysis)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("storage_class_analysis",
                (StorageClassAnalysis.to_json v.storage_class_analysis));
           Util.option_map v.filter
             (fun f -> ("filter", (AnalyticsFilter.to_json f)));
           Some ("id", (String.to_json v.id))])
    let of_json j =
      {
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")));
        filter =
          (Util.option_map (Json.lookup j "filter") AnalyticsFilter.of_json);
        storage_class_analysis =
          (StorageClassAnalysis.of_json
             (Util.of_option_exn (Json.lookup j "storage_class_analysis")))
      }
  end
module GlacierJobParameters =
  struct
    type t = {
      tier: Tier.t }
    let make ~tier  () = { tier }
    let parse xml =
      Some
        {
          tier =
            (Xml.required "Tier"
               (Util.option_bind (Xml.member "Tier" xml) Tier.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Tier" ([], (Tier.to_xml v.tier)))])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("tier", (Tier.to_json v.tier))])
    let of_json j =
      { tier = (Tier.of_json (Util.of_option_exn (Json.lookup j "tier"))) }
  end
module OutputLocation =
  struct
    type t = {
      s3: S3Location.t option }
    let make ?s3  () = { s3 }
    let parse xml =
      Some { s3 = (Util.option_bind (Xml.member "S3" xml) S3Location.parse) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.s3
              (fun f -> Ezxmlm.make_tag "S3" ([], (S3Location.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.s3 (fun f -> ("s3", (S3Location.to_json f)))])
    let of_json j =
      { s3 = (Util.option_map (Json.lookup j "s3") S3Location.of_json) }
  end
module RestoreRequestType =
  struct
    type t =
      | SELECT 
    let str_to_t = [("SELECT", SELECT)]
    let t_to_str = [(SELECT, "SELECT")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module SelectParameters =
  struct
    type t =
      {
      input_serialization: InputSerialization.t ;
      expression_type: ExpressionType.t ;
      expression: String.t ;
      output_serialization: OutputSerialization.t }
    let make ~input_serialization  ~expression_type  ~expression 
      ~output_serialization  () =
      {
        input_serialization;
        expression_type;
        expression;
        output_serialization
      }
    let parse xml =
      Some
        {
          input_serialization =
            (Xml.required "InputSerialization"
               (Util.option_bind (Xml.member "InputSerialization" xml)
                  InputSerialization.parse));
          expression_type =
            (Xml.required "ExpressionType"
               (Util.option_bind (Xml.member "ExpressionType" xml)
                  ExpressionType.parse));
          expression =
            (Xml.required "Expression"
               (Util.option_bind (Xml.member "Expression" xml) String.parse));
          output_serialization =
            (Xml.required "OutputSerialization"
               (Util.option_bind (Xml.member "OutputSerialization" xml)
                  OutputSerialization.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some
                 (Ezxmlm.make_tag "InputSerialization"
                    ([], (InputSerialization.to_xml v.input_serialization)))])
             @
             [Some
                (Ezxmlm.make_tag "ExpressionType"
                   ([], (ExpressionType.to_xml v.expression_type)))])
            @
            [Some
               (Ezxmlm.make_tag "Expression"
                  ([], (String.to_xml v.expression)))])
           @
           [Some
              (Ezxmlm.make_tag "OutputSerialization"
                 ([], (OutputSerialization.to_xml v.output_serialization)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("output_serialization",
                (OutputSerialization.to_json v.output_serialization));
           Some ("expression", (String.to_json v.expression));
           Some
             ("expression_type", (ExpressionType.to_json v.expression_type));
           Some
             ("input_serialization",
               (InputSerialization.to_json v.input_serialization))])
    let of_json j =
      {
        input_serialization =
          (InputSerialization.of_json
             (Util.of_option_exn (Json.lookup j "input_serialization")));
        expression_type =
          (ExpressionType.of_json
             (Util.of_option_exn (Json.lookup j "expression_type")));
        expression =
          (String.of_json (Util.of_option_exn (Json.lookup j "expression")));
        output_serialization =
          (OutputSerialization.of_json
             (Util.of_option_exn (Json.lookup j "output_serialization")))
      }
  end
module DeleteMarkerEntry =
  struct
    type t =
      {
      owner: Owner.t option ;
      key: String.t option ;
      version_id: String.t option ;
      is_latest: Boolean.t option ;
      last_modified: DateTime.t option }
    let make ?owner  ?key  ?version_id  ?is_latest  ?last_modified  () =
      { owner; key; version_id; is_latest; last_modified }
    let parse xml =
      Some
        {
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse);
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse);
          is_latest =
            (Util.option_bind (Xml.member "IsLatest" xml) Boolean.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.owner
                  (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
              @
              [Util.option_map v.key
                 (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.is_latest
               (fun f -> Ezxmlm.make_tag "IsLatest" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.last_modified
              (fun f ->
                 Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_modified
              (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.is_latest
             (fun f -> ("is_latest", (Boolean.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)))])
    let of_json j =
      {
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json);
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        is_latest =
          (Util.option_map (Json.lookup j "is_latest") Boolean.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json)
      }
  end
module ObjectVersion =
  struct
    type t =
      {
      e_tag: String.t option ;
      size: Integer.t option ;
      storage_class: ObjectVersionStorageClass.t option ;
      key: String.t option ;
      version_id: String.t option ;
      is_latest: Boolean.t option ;
      last_modified: DateTime.t option ;
      owner: Owner.t option }
    let make ?e_tag  ?size  ?storage_class  ?key  ?version_id  ?is_latest 
      ?last_modified  ?owner  () =
      {
        e_tag;
        size;
        storage_class;
        key;
        version_id;
        is_latest;
        last_modified;
        owner
      }
    let parse xml =
      Some
        {
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          size = (Util.option_bind (Xml.member "Size" xml) Integer.parse);
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               ObjectVersionStorageClass.parse);
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse);
          is_latest =
            (Util.option_bind (Xml.member "IsLatest" xml) Boolean.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse);
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((([] @
                  [Util.option_map v.e_tag
                     (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.size
                    (fun f -> Ezxmlm.make_tag "Size" ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.storage_class
                   (fun f ->
                      Ezxmlm.make_tag "StorageClass"
                        ([], (ObjectVersionStorageClass.to_xml f)))])
               @
               [Util.option_map v.key
                  (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
              @
              [Util.option_map v.version_id
                 (fun f ->
                    Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
             @
             [Util.option_map v.is_latest
                (fun f -> Ezxmlm.make_tag "IsLatest" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.last_modified
               (fun f ->
                  Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.owner
              (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Util.option_map v.last_modified
             (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.is_latest
             (fun f -> ("is_latest", (Boolean.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)));
           Util.option_map v.storage_class
             (fun f ->
                ("storage_class", (ObjectVersionStorageClass.to_json f)));
           Util.option_map v.size (fun f -> ("size", (Integer.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)))])
    let of_json j =
      {
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        size = (Util.option_map (Json.lookup j "size") Integer.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             ObjectVersionStorageClass.of_json);
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        is_latest =
          (Util.option_map (Json.lookup j "is_latest") Boolean.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json);
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json)
      }
  end
module BucketVersioningStatus =
  struct
    type t =
      | Enabled 
      | Suspended 
    let str_to_t = [("Suspended", Suspended); ("Enabled", Enabled)]
    let t_to_str = [(Suspended, "Suspended"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module MFADelete =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Payer =
  struct
    type t =
      | Requester 
      | BucketOwner 
    let str_to_t = [("BucketOwner", BucketOwner); ("Requester", Requester)]
    let t_to_str = [(BucketOwner, "BucketOwner"); (Requester, "Requester")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ObjectLockEnabled =
  struct
    type t =
      | Enabled 
    let str_to_t = [("Enabled", Enabled)]
    let t_to_str = [(Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ObjectLockRule =
  struct
    type t = {
      default_retention: DefaultRetention.t option }
    let make ?default_retention  () = { default_retention }
    let parse xml =
      Some
        {
          default_retention =
            (Util.option_bind (Xml.member "DefaultRetention" xml)
               DefaultRetention.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.default_retention
              (fun f ->
                 Ezxmlm.make_tag "DefaultRetention"
                   ([], (DefaultRetention.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.default_retention
              (fun f -> ("default_retention", (DefaultRetention.to_json f)))])
    let of_json j =
      {
        default_retention =
          (Util.option_map (Json.lookup j "default_retention")
             DefaultRetention.of_json)
      }
  end
module ObjectIdentifierList =
  struct
    type t = ObjectIdentifier.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map ObjectIdentifier.parse [xml])
    let to_query v = Query.to_query_list ObjectIdentifier.to_query v
    let to_headers v = Headers.to_headers_list ObjectIdentifier.to_headers v
    let to_xml v = List.concat (List.map ObjectIdentifier.to_xml v)
    let to_json v = `List (List.map ObjectIdentifier.to_json v)
    let of_json j = Json.to_list ObjectIdentifier.of_json j
  end
module InventoryConfiguration =
  struct
    type t =
      {
      destination: InventoryDestination.t ;
      is_enabled: Boolean.t ;
      filter: InventoryFilter.t option ;
      id: String.t ;
      included_object_versions: InventoryIncludedObjectVersions.t ;
      optional_fields: InventoryOptionalFields.t ;
      schedule: InventorySchedule.t }
    let make ~destination  ~is_enabled  ?filter  ~id 
      ~included_object_versions  ?(optional_fields= [])  ~schedule  () =
      {
        destination;
        is_enabled;
        filter;
        id;
        included_object_versions;
        optional_fields;
        schedule
      }
    let parse xml =
      Some
        {
          destination =
            (Xml.required "Destination"
               (Util.option_bind (Xml.member "Destination" xml)
                  InventoryDestination.parse));
          is_enabled =
            (Xml.required "IsEnabled"
               (Util.option_bind (Xml.member "IsEnabled" xml) Boolean.parse));
          filter =
            (Util.option_bind (Xml.member "Filter" xml) InventoryFilter.parse);
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          included_object_versions =
            (Xml.required "IncludedObjectVersions"
               (Util.option_bind (Xml.member "IncludedObjectVersions" xml)
                  InventoryIncludedObjectVersions.parse));
          optional_fields =
            (Util.of_option []
               (Util.option_bind (Xml.member "OptionalFields" xml)
                  InventoryOptionalFields.parse));
          schedule =
            (Xml.required "Schedule"
               (Util.option_bind (Xml.member "Schedule" xml)
                  InventorySchedule.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Destination"
                       ([], (InventoryDestination.to_xml v.destination)))])
                @
                [Some
                   (Ezxmlm.make_tag "IsEnabled"
                      ([], (Boolean.to_xml v.is_enabled)))])
               @
               [Util.option_map v.filter
                  (fun f ->
                     Ezxmlm.make_tag "Filter"
                       ([], (InventoryFilter.to_xml f)))])
              @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))])
             @
             [Some
                (Ezxmlm.make_tag "IncludedObjectVersions"
                   ([],
                     (InventoryIncludedObjectVersions.to_xml
                        v.included_object_versions)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "OptionalFields"
                       ([], (InventoryOptionalFields.to_xml [x]))))
               v.optional_fields))
           @
           [Some
              (Ezxmlm.make_tag "Schedule"
                 ([], (InventorySchedule.to_xml v.schedule)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("schedule", (InventorySchedule.to_json v.schedule));
           Some
             ("optional_fields",
               (InventoryOptionalFields.to_json v.optional_fields));
           Some
             ("included_object_versions",
               (InventoryIncludedObjectVersions.to_json
                  v.included_object_versions));
           Some ("id", (String.to_json v.id));
           Util.option_map v.filter
             (fun f -> ("filter", (InventoryFilter.to_json f)));
           Some ("is_enabled", (Boolean.to_json v.is_enabled));
           Some ("destination", (InventoryDestination.to_json v.destination))])
    let of_json j =
      {
        destination =
          (InventoryDestination.of_json
             (Util.of_option_exn (Json.lookup j "destination")));
        is_enabled =
          (Boolean.of_json (Util.of_option_exn (Json.lookup j "is_enabled")));
        filter =
          (Util.option_map (Json.lookup j "filter") InventoryFilter.of_json);
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")));
        included_object_versions =
          (InventoryIncludedObjectVersions.of_json
             (Util.of_option_exn (Json.lookup j "included_object_versions")));
        optional_fields =
          (InventoryOptionalFields.of_json
             (Util.of_option_exn (Json.lookup j "optional_fields")));
        schedule =
          (InventorySchedule.of_json
             (Util.of_option_exn (Json.lookup j "schedule")))
      }
  end
module ErrorDocument =
  struct
    type t = {
      key: String.t }
    let make ~key  () = { key }
    let parse xml =
      Some
        {
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("key", (String.to_json v.key))])
    let of_json j =
      { key = (String.of_json (Util.of_option_exn (Json.lookup j "key"))) }
  end
module IndexDocument =
  struct
    type t = {
      suffix: String.t }
    let make ~suffix  () = { suffix }
    let parse xml =
      Some
        {
          suffix =
            (Xml.required "Suffix"
               (Util.option_bind (Xml.member "Suffix" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Suffix" ([], (String.to_xml v.suffix)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("suffix", (String.to_json v.suffix))])
    let of_json j =
      {
        suffix =
          (String.of_json (Util.of_option_exn (Json.lookup j "suffix")))
      }
  end
module RedirectAllRequestsTo =
  struct
    type t = {
      host_name: String.t ;
      protocol: Protocol.t option }
    let make ~host_name  ?protocol  () = { host_name; protocol }
    let parse xml =
      Some
        {
          host_name =
            (Xml.required "HostName"
               (Util.option_bind (Xml.member "HostName" xml) String.parse));
          protocol =
            (Util.option_bind (Xml.member "Protocol" xml) Protocol.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some
               (Ezxmlm.make_tag "HostName" ([], (String.to_xml v.host_name)))])
           @
           [Util.option_map v.protocol
              (fun f -> Ezxmlm.make_tag "Protocol" ([], (Protocol.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.protocol
              (fun f -> ("protocol", (Protocol.to_json f)));
           Some ("host_name", (String.to_json v.host_name))])
    let of_json j =
      {
        host_name =
          (String.of_json (Util.of_option_exn (Json.lookup j "host_name")));
        protocol =
          (Util.option_map (Json.lookup j "protocol") Protocol.of_json)
      }
  end
module RoutingRules =
  struct
    type t = RoutingRule.t list
    let make elems () = elems
    let parse xml =
      Util.option_all
        (List.map RoutingRule.parse (Xml.members "RoutingRule" xml))
    let to_query v = Query.to_query_list RoutingRule.to_query v
    let to_headers v = Headers.to_headers_list RoutingRule.to_headers v
    let to_xml v =
      List.map
        (fun x -> Ezxmlm.make_tag "member" ([], (RoutingRule.to_xml x))) v
    let to_json v = `List (List.map RoutingRule.to_json v)
    let of_json j = Json.to_list RoutingRule.of_json j
  end
module CORSRules =
  struct
    type t = CORSRule.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map CORSRule.parse [xml])
    let to_query v = Query.to_query_list CORSRule.to_query v
    let to_headers v = Headers.to_headers_list CORSRule.to_headers v
    let to_xml v = List.concat (List.map CORSRule.to_xml v)
    let to_json v = `List (List.map CORSRule.to_json v)
    let of_json j = Json.to_list CORSRule.of_json j
  end
module ObjectLockLegalHoldStatus =
  struct
    type t =
      | ON 
      | OFF 
    let str_to_t = [("OFF", OFF); ("ON", ON)]
    let t_to_str = [(OFF, "OFF"); (ON, "ON")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module BucketAccelerateStatus =
  struct
    type t =
      | Enabled 
      | Suspended 
    let str_to_t = [("Suspended", Suspended); ("Enabled", Enabled)]
    let t_to_str = [(Suspended, "Suspended"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module MetricsConfiguration =
  struct
    type t = {
      id: String.t ;
      filter: MetricsFilter.t option }
    let make ~id  ?filter  () = { id; filter }
    let parse xml =
      Some
        {
          id =
            (Xml.required "Id"
               (Util.option_bind (Xml.member "Id" xml) String.parse));
          filter =
            (Util.option_bind (Xml.member "Filter" xml) MetricsFilter.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Id" ([], (String.to_xml v.id)))]) @
           [Util.option_map v.filter
              (fun f ->
                 Ezxmlm.make_tag "Filter" ([], (MetricsFilter.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.filter
              (fun f -> ("filter", (MetricsFilter.to_json f)));
           Some ("id", (String.to_json v.id))])
    let of_json j =
      {
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")));
        filter =
          (Util.option_map (Json.lookup j "filter") MetricsFilter.of_json)
      }
  end
module BucketLocationConstraint =
  struct
    type t =
      | EU 
      | Eu_west_1 
      | Us_west_1 
      | Us_west_2 
      | Ap_south_1 
      | Ap_southeast_1 
      | Ap_southeast_2 
      | Ap_northeast_1 
      | Sa_east_1 
      | Cn_north_1 
      | Eu_central_1 
    let str_to_t =
      [("eu-central-1", Eu_central_1);
      ("cn-north-1", Cn_north_1);
      ("sa-east-1", Sa_east_1);
      ("ap-northeast-1", Ap_northeast_1);
      ("ap-southeast-2", Ap_southeast_2);
      ("ap-southeast-1", Ap_southeast_1);
      ("ap-south-1", Ap_south_1);
      ("us-west-2", Us_west_2);
      ("us-west-1", Us_west_1);
      ("eu-west-1", Eu_west_1);
      ("EU", EU)]
    let t_to_str =
      [(Eu_central_1, "eu-central-1");
      (Cn_north_1, "cn-north-1");
      (Sa_east_1, "sa-east-1");
      (Ap_northeast_1, "ap-northeast-1");
      (Ap_southeast_2, "ap-southeast-2");
      (Ap_southeast_1, "ap-southeast-1");
      (Ap_south_1, "ap-south-1");
      (Us_west_2, "us-west-2");
      (Us_west_1, "us-west-1");
      (Eu_west_1, "eu-west-1");
      (EU, "EU")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module LoggingEnabled =
  struct
    type t =
      {
      target_bucket: String.t ;
      target_grants: TargetGrants.t ;
      target_prefix: String.t }
    let make ~target_bucket  ?(target_grants= [])  ~target_prefix  () =
      { target_bucket; target_grants; target_prefix }
    let parse xml =
      Some
        {
          target_bucket =
            (Xml.required "TargetBucket"
               (Util.option_bind (Xml.member "TargetBucket" xml) String.parse));
          target_grants =
            (Util.of_option []
               (Util.option_bind (Xml.member "TargetGrants" xml)
                  TargetGrants.parse));
          target_prefix =
            (Xml.required "TargetPrefix"
               (Util.option_bind (Xml.member "TargetPrefix" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some
                (Ezxmlm.make_tag "TargetBucket"
                   ([], (String.to_xml v.target_bucket)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "TargetGrants"
                       ([], (TargetGrants.to_xml [x])))) v.target_grants))
           @
           [Some
              (Ezxmlm.make_tag "TargetPrefix"
                 ([], (String.to_xml v.target_prefix)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("target_prefix", (String.to_json v.target_prefix));
           Some ("target_grants", (TargetGrants.to_json v.target_grants));
           Some ("target_bucket", (String.to_json v.target_bucket))])
    let of_json j =
      {
        target_bucket =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "target_bucket")));
        target_grants =
          (TargetGrants.of_json
             (Util.of_option_exn (Json.lookup j "target_grants")));
        target_prefix =
          (String.of_json
             (Util.of_option_exn (Json.lookup j "target_prefix")))
      }
  end
module CompletedPartList =
  struct
    type t = CompletedPart.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map CompletedPart.parse [xml])
    let to_query v = Query.to_query_list CompletedPart.to_query v
    let to_headers v = Headers.to_headers_list CompletedPart.to_headers v
    let to_xml v = List.concat (List.map CompletedPart.to_xml v)
    let to_json v = `List (List.map CompletedPart.to_json v)
    let of_json j = Json.to_list CompletedPart.of_json j
  end
module Bucket =
  struct
    type t = {
      name: String.t ;
      creation_date: DateTime.t }
    let make ~name  ~creation_date  () = { name; creation_date }
    let parse xml =
      Some
        {
          name =
            (Xml.required "Name"
               (Util.option_bind (Xml.member "Name" xml) String.parse));
          creation_date =
            (Xml.required "CreationDate"
               (Util.option_bind (Xml.member "CreationDate" xml)
                  DateTime.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Name" ([], (String.to_xml v.name)))])
           @
           [Some
              (Ezxmlm.make_tag "CreationDate"
                 ([], (DateTime.to_xml v.creation_date)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("creation_date", (DateTime.to_json v.creation_date));
           Some ("name", (String.to_json v.name))])
    let of_json j =
      {
        name = (String.of_json (Util.of_option_exn (Json.lookup j "name")));
        creation_date =
          (DateTime.of_json
             (Util.of_option_exn (Json.lookup j "creation_date")))
      }
  end
module CloudFunctionConfiguration =
  struct
    type t =
      {
      id: String.t option ;
      event: Event.t option ;
      events: EventList.t ;
      cloud_function: String.t option ;
      invocation_role: String.t option }
    let make ?id  ?event  ?(events= [])  ?cloud_function  ?invocation_role 
      () = { id; event; events; cloud_function; invocation_role }
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          event = (Util.option_bind (Xml.member "Event" xml) Event.parse);
          events = (Util.of_option [] (EventList.parse xml));
          cloud_function =
            (Util.option_bind (Xml.member "CloudFunction" xml) String.parse);
          invocation_role =
            (Util.option_bind (Xml.member "InvocationRole" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.id
                  (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
              @
              [Util.option_map v.event
                 (fun f -> Ezxmlm.make_tag "Event" ([], (Event.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Event" ([], (EventList.to_xml [x]))))
                v.events))
            @
            [Util.option_map v.cloud_function
               (fun f ->
                  Ezxmlm.make_tag "CloudFunction" ([], (String.to_xml f)))])
           @
           [Util.option_map v.invocation_role
              (fun f ->
                 Ezxmlm.make_tag "InvocationRole" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.invocation_role
              (fun f -> ("invocation_role", (String.to_json f)));
           Util.option_map v.cloud_function
             (fun f -> ("cloud_function", (String.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Util.option_map v.event (fun f -> ("event", (Event.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        event = (Util.option_map (Json.lookup j "event") Event.of_json);
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")));
        cloud_function =
          (Util.option_map (Json.lookup j "cloud_function") String.of_json);
        invocation_role =
          (Util.option_map (Json.lookup j "invocation_role") String.of_json)
      }
  end
module QueueConfigurationDeprecated =
  struct
    type t =
      {
      id: String.t option ;
      event: Event.t option ;
      events: EventList.t ;
      queue: String.t option }
    let make ?id  ?event  ?(events= [])  ?queue  () =
      { id; event; events; queue }
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          event = (Util.option_bind (Xml.member "Event" xml) Event.parse);
          events = (Util.of_option [] (EventList.parse xml));
          queue = (Util.option_bind (Xml.member "Queue" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.id
                 (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
             @
             [Util.option_map v.event
                (fun f -> Ezxmlm.make_tag "Event" ([], (Event.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Event" ([], (EventList.to_xml [x]))))
               v.events))
           @
           [Util.option_map v.queue
              (fun f -> Ezxmlm.make_tag "Queue" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.queue (fun f -> ("queue", (String.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Util.option_map v.event (fun f -> ("event", (Event.to_json f)));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        event = (Util.option_map (Json.lookup j "event") Event.of_json);
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")));
        queue = (Util.option_map (Json.lookup j "queue") String.of_json)
      }
  end
module TopicConfigurationDeprecated =
  struct
    type t =
      {
      id: String.t option ;
      events: EventList.t ;
      event: Event.t option ;
      topic: String.t option }
    let make ?id  ?(events= [])  ?event  ?topic  () =
      { id; events; event; topic }
    let parse xml =
      Some
        {
          id = (Util.option_bind (Xml.member "Id" xml) String.parse);
          events = (Util.of_option [] (EventList.parse xml));
          event = (Util.option_bind (Xml.member "Event" xml) Event.parse);
          topic = (Util.option_bind (Xml.member "Topic" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.id
                 (fun f -> Ezxmlm.make_tag "Id" ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Event" ([], (EventList.to_xml [x]))))
                v.events))
            @
            [Util.option_map v.event
               (fun f -> Ezxmlm.make_tag "Event" ([], (Event.to_xml f)))])
           @
           [Util.option_map v.topic
              (fun f -> Ezxmlm.make_tag "Topic" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.topic (fun f -> ("topic", (String.to_json f)));
           Util.option_map v.event (fun f -> ("event", (Event.to_json f)));
           Some ("events", (EventList.to_json v.events));
           Util.option_map v.id (fun f -> ("id", (String.to_json f)))])
    let of_json j =
      {
        id = (Util.option_map (Json.lookup j "id") String.of_json);
        events =
          (EventList.of_json (Util.of_option_exn (Json.lookup j "events")));
        event = (Util.option_map (Json.lookup j "event") Event.of_json);
        topic = (Util.option_map (Json.lookup j "topic") String.of_json)
      }
  end
module ContinuationEvent =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module EndEvent =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ProgressEvent =
  struct
    type t = {
      details: Progress.t option }
    let make ?details  () = { details }
    let parse xml =
      Some
        {
          details =
            (Util.option_bind (Xml.member "Details" xml) Progress.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.details
              (fun f -> Ezxmlm.make_tag "Details" ([], (Progress.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (Progress.to_json f)))])
    let of_json j =
      {
        details =
          (Util.option_map (Json.lookup j "details") Progress.of_json)
      }
  end
module RecordsEvent =
  struct
    type t = {
      payload: Blob.t option }
    let make ?payload  () = { payload }
    let parse xml =
      Some
        { payload = (Util.option_bind (Xml.member "Payload" xml) Blob.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.payload
              (fun f -> Ezxmlm.make_tag "Payload" ([], (Blob.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payload
              (fun f -> ("payload", (Blob.to_json f)))])
    let of_json j =
      { payload = (Util.option_map (Json.lookup j "payload") Blob.of_json) }
  end
module StatsEvent =
  struct
    type t = {
      details: Stats.t option }
    let make ?details  () = { details }
    let parse xml =
      Some
        { details = (Util.option_bind (Xml.member "Details" xml) Stats.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.details
              (fun f -> Ezxmlm.make_tag "Details" ([], (Stats.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.details
              (fun f -> ("details", (Stats.to_json f)))])
    let of_json j =
      { details = (Util.option_map (Json.lookup j "details") Stats.of_json) }
  end
module DeletedObject =
  struct
    type t =
      {
      key: String.t option ;
      version_id: String.t option ;
      delete_marker: Boolean.t option ;
      delete_marker_version_id: String.t option }
    let make ?key  ?version_id  ?delete_marker  ?delete_marker_version_id  ()
      = { key; version_id; delete_marker; delete_marker_version_id }
    let parse xml =
      Some
        {
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse);
          delete_marker =
            (Util.option_bind (Xml.member "DeleteMarker" xml) Boolean.parse);
          delete_marker_version_id =
            (Util.option_bind (Xml.member "DeleteMarkerVersionId" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.key
                 (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.delete_marker
               (fun f ->
                  Ezxmlm.make_tag "DeleteMarker" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.delete_marker_version_id
              (fun f ->
                 Ezxmlm.make_tag "DeleteMarkerVersionId"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.delete_marker_version_id
              (fun f -> ("delete_marker_version_id", (String.to_json f)));
           Util.option_map v.delete_marker
             (fun f -> ("delete_marker", (Boolean.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        delete_marker =
          (Util.option_map (Json.lookup j "delete_marker") Boolean.of_json);
        delete_marker_version_id =
          (Util.option_map (Json.lookup j "delete_marker_version_id")
             String.of_json)
      }
  end
module Error =
  struct
    type t =
      {
      key: String.t option ;
      version_id: String.t option ;
      code: String.t option ;
      message: String.t option }
    let make ?key  ?version_id  ?code  ?message  () =
      { key; version_id; code; message }
    let parse xml =
      Some
        {
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "VersionId" xml) String.parse);
          code = (Util.option_bind (Xml.member "Code" xml) String.parse);
          message =
            (Util.option_bind (Xml.member "Message" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.key
                 (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "VersionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.code
               (fun f -> Ezxmlm.make_tag "Code" ([], (String.to_xml f)))])
           @
           [Util.option_map v.message
              (fun f -> Ezxmlm.make_tag "Message" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.message
              (fun f -> ("message", (String.to_json f)));
           Util.option_map v.code (fun f -> ("code", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)))])
    let of_json j =
      {
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        code = (Util.option_map (Json.lookup j "code") String.of_json);
        message = (Util.option_map (Json.lookup j "message") String.of_json)
      }
  end
module LifecycleRules =
  struct
    type t = LifecycleRule.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map LifecycleRule.parse [xml])
    let to_query v = Query.to_query_list LifecycleRule.to_query v
    let to_headers v = Headers.to_headers_list LifecycleRule.to_headers v
    let to_xml v = List.concat (List.map LifecycleRule.to_xml v)
    let to_json v = `List (List.map LifecycleRule.to_json v)
    let of_json j = Json.to_list LifecycleRule.of_json j
  end
module Part =
  struct
    type t =
      {
      part_number: Integer.t option ;
      last_modified: DateTime.t option ;
      e_tag: String.t option ;
      size: Integer.t option }
    let make ?part_number  ?last_modified  ?e_tag  ?size  () =
      { part_number; last_modified; e_tag; size }
    let parse xml =
      Some
        {
          part_number =
            (Util.option_bind (Xml.member "PartNumber" xml) Integer.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse);
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          size = (Util.option_bind (Xml.member "Size" xml) Integer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.part_number
                 (fun f ->
                    Ezxmlm.make_tag "PartNumber" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.last_modified
                (fun f ->
                   Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
            @
            [Util.option_map v.e_tag
               (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
           @
           [Util.option_map v.size
              (fun f -> Ezxmlm.make_tag "Size" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.size (fun f -> ("size", (Integer.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.last_modified
             (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.part_number
             (fun f -> ("part_number", (Integer.to_json f)))])
    let of_json j =
      {
        part_number =
          (Util.option_map (Json.lookup j "part_number") Integer.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json);
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        size = (Util.option_map (Json.lookup j "size") Integer.of_json)
      }
  end
module MultipartUpload =
  struct
    type t =
      {
      upload_id: String.t option ;
      key: String.t option ;
      initiated: DateTime.t option ;
      storage_class: StorageClass.t option ;
      owner: Owner.t option ;
      initiator: Initiator.t option }
    let make ?upload_id  ?key  ?initiated  ?storage_class  ?owner  ?initiator
       () = { upload_id; key; initiated; storage_class; owner; initiator }
    let parse xml =
      Some
        {
          upload_id =
            (Util.option_bind (Xml.member "UploadId" xml) String.parse);
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          initiated =
            (Util.option_bind (Xml.member "Initiated" xml) DateTime.parse);
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               StorageClass.parse);
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse);
          initiator =
            (Util.option_bind (Xml.member "Initiator" xml) Initiator.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.upload_id
                   (fun f ->
                      Ezxmlm.make_tag "UploadId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.key
                  (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
              @
              [Util.option_map v.initiated
                 (fun f ->
                    Ezxmlm.make_tag "Initiated" ([], (DateTime.to_xml f)))])
             @
             [Util.option_map v.storage_class
                (fun f ->
                   Ezxmlm.make_tag "StorageClass"
                     ([], (StorageClass.to_xml f)))])
            @
            [Util.option_map v.owner
               (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
           @
           [Util.option_map v.initiator
              (fun f ->
                 Ezxmlm.make_tag "Initiator" ([], (Initiator.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.initiator
              (fun f -> ("initiator", (Initiator.to_json f)));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.initiated
             (fun f -> ("initiated", (DateTime.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)));
           Util.option_map v.upload_id
             (fun f -> ("upload_id", (String.to_json f)))])
    let of_json j =
      {
        upload_id =
          (Util.option_map (Json.lookup j "upload_id") String.of_json);
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        initiated =
          (Util.option_map (Json.lookup j "initiated") DateTime.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json);
        initiator =
          (Util.option_map (Json.lookup j "initiator") Initiator.of_json)
      }
  end
module LambdaFunctionConfigurationList =
  struct
    type t = LambdaFunctionConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map LambdaFunctionConfiguration.parse [xml])
    let to_query v =
      Query.to_query_list LambdaFunctionConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list LambdaFunctionConfiguration.to_headers v
    let to_xml v =
      List.concat (List.map LambdaFunctionConfiguration.to_xml v)
    let to_json v = `List (List.map LambdaFunctionConfiguration.to_json v)
    let of_json j = Json.to_list LambdaFunctionConfiguration.of_json j
  end
module QueueConfigurationList =
  struct
    type t = QueueConfiguration.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map QueueConfiguration.parse [xml])
    let to_query v = Query.to_query_list QueueConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list QueueConfiguration.to_headers v
    let to_xml v = List.concat (List.map QueueConfiguration.to_xml v)
    let to_json v = `List (List.map QueueConfiguration.to_json v)
    let of_json j = Json.to_list QueueConfiguration.of_json j
  end
module TopicConfigurationList =
  struct
    type t = TopicConfiguration.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map TopicConfiguration.parse [xml])
    let to_query v = Query.to_query_list TopicConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list TopicConfiguration.to_headers v
    let to_xml v = List.concat (List.map TopicConfiguration.to_xml v)
    let to_json v = `List (List.map TopicConfiguration.to_json v)
    let of_json j = Json.to_list TopicConfiguration.of_json j
  end
module CommonPrefixList =
  struct
    type t = CommonPrefix.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map CommonPrefix.parse [xml])
    let to_query v = Query.to_query_list CommonPrefix.to_query v
    let to_headers v = Headers.to_headers_list CommonPrefix.to_headers v
    let to_xml v = List.concat (List.map CommonPrefix.to_xml v)
    let to_json v = `List (List.map CommonPrefix.to_json v)
    let of_json j = Json.to_list CommonPrefix.of_json j
  end
module EncodingType =
  struct
    type t =
      | Url 
    let str_to_t = [("url", Url)]
    let t_to_str = [(Url, "url")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ObjectList =
  struct
    type t = Object.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map Object.parse [xml])
    let to_query v = Query.to_query_list Object.to_query v
    let to_headers v = Headers.to_headers_list Object.to_headers v
    let to_xml v = List.concat (List.map Object.to_xml v)
    let to_json v = `List (List.map Object.to_json v)
    let of_json j = Json.to_list Object.of_json j
  end
module RequestPayer =
  struct
    type t =
      | Requester 
    let str_to_t = [("requester", Requester)]
    let t_to_str = [(Requester, "requester")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module RequestCharged =
  struct
    type t =
      | Requester 
    let str_to_t = [("requester", Requester)]
    let t_to_str = [(Requester, "requester")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module PolicyStatus =
  struct
    type t = {
      is_public: Boolean.t option }
    let make ?is_public  () = { is_public }
    let parse xml =
      Some
        {
          is_public =
            (Util.option_bind (Xml.member "IsPublic" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.is_public
              (fun f -> Ezxmlm.make_tag "IsPublic" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.is_public
              (fun f -> ("is_public", (Boolean.to_json f)))])
    let of_json j =
      {
        is_public =
          (Util.option_map (Json.lookup j "is_public") Boolean.of_json)
      }
  end
module ReplicationConfiguration =
  struct
    type t = {
      role: String.t ;
      rules: ReplicationRules.t }
    let make ~role  ~rules  () = { role; rules }
    let parse xml =
      Some
        {
          role =
            (Xml.required "Role"
               (Util.option_bind (Xml.member "Role" xml) String.parse));
          rules = (Xml.required "Rule" (ReplicationRules.parse xml))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @ [Some (Ezxmlm.make_tag "Role" ([], (String.to_xml v.role)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule"
                      ([], (ReplicationRules.to_xml [x])))) v.rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (ReplicationRules.to_json v.rules));
           Some ("role", (String.to_json v.role))])
    let of_json j =
      {
        role = (String.of_json (Util.of_option_exn (Json.lookup j "role")));
        rules =
          (ReplicationRules.of_json
             (Util.of_option_exn (Json.lookup j "rules")))
      }
  end
module ServerSideEncryptionConfiguration =
  struct
    type t = {
      rules: ServerSideEncryptionRules.t }
    let make ~rules  () = { rules }
    let parse xml =
      Some
        { rules = (Xml.required "Rule" (ServerSideEncryptionRules.parse xml))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule"
                      ([], (ServerSideEncryptionRules.to_xml [x])))) v.rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (ServerSideEncryptionRules.to_json v.rules))])
    let of_json j =
      {
        rules =
          (ServerSideEncryptionRules.of_json
             (Util.of_option_exn (Json.lookup j "rules")))
      }
  end
module LifecycleConfiguration =
  struct
    type t = {
      rules: Rules.t }
    let make ~rules  () = { rules }
    let parse xml = Some { rules = (Xml.required "Rule" (Rules.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Rule" ([], (Rules.to_xml [x]))))
              v.rules))
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("rules", (Rules.to_json v.rules))])
    let of_json j =
      { rules = (Rules.of_json (Util.of_option_exn (Json.lookup j "rules")))
      }
  end
module AnalyticsConfigurationList =
  struct
    type t = AnalyticsConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map AnalyticsConfiguration.parse [xml])
    let to_query v = Query.to_query_list AnalyticsConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list AnalyticsConfiguration.to_headers v
    let to_xml v = List.concat (List.map AnalyticsConfiguration.to_xml v)
    let to_json v = `List (List.map AnalyticsConfiguration.to_json v)
    let of_json j = Json.to_list AnalyticsConfiguration.of_json j
  end
module RestoreRequest =
  struct
    type t =
      {
      days: Integer.t option ;
      glacier_job_parameters: GlacierJobParameters.t option ;
      type_: RestoreRequestType.t option ;
      tier: Tier.t option ;
      description: String.t option ;
      select_parameters: SelectParameters.t option ;
      output_location: OutputLocation.t option }
    let make ?days  ?glacier_job_parameters  ?type_  ?tier  ?description 
      ?select_parameters  ?output_location  () =
      {
        days;
        glacier_job_parameters;
        type_;
        tier;
        description;
        select_parameters;
        output_location
      }
    let parse xml =
      Some
        {
          days = (Util.option_bind (Xml.member "Days" xml) Integer.parse);
          glacier_job_parameters =
            (Util.option_bind (Xml.member "GlacierJobParameters" xml)
               GlacierJobParameters.parse);
          type_ =
            (Util.option_bind (Xml.member "Type" xml)
               RestoreRequestType.parse);
          tier = (Util.option_bind (Xml.member "Tier" xml) Tier.parse);
          description =
            (Util.option_bind (Xml.member "Description" xml) String.parse);
          select_parameters =
            (Util.option_bind (Xml.member "SelectParameters" xml)
               SelectParameters.parse);
          output_location =
            (Util.option_bind (Xml.member "OutputLocation" xml)
               OutputLocation.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.days
                    (fun f -> Ezxmlm.make_tag "Days" ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.glacier_job_parameters
                   (fun f ->
                      Ezxmlm.make_tag "GlacierJobParameters"
                        ([], (GlacierJobParameters.to_xml f)))])
               @
               [Util.option_map v.type_
                  (fun f ->
                     Ezxmlm.make_tag "Type"
                       ([], (RestoreRequestType.to_xml f)))])
              @
              [Util.option_map v.tier
                 (fun f -> Ezxmlm.make_tag "Tier" ([], (Tier.to_xml f)))])
             @
             [Util.option_map v.description
                (fun f ->
                   Ezxmlm.make_tag "Description" ([], (String.to_xml f)))])
            @
            [Util.option_map v.select_parameters
               (fun f ->
                  Ezxmlm.make_tag "SelectParameters"
                    ([], (SelectParameters.to_xml f)))])
           @
           [Util.option_map v.output_location
              (fun f ->
                 Ezxmlm.make_tag "OutputLocation"
                   ([], (OutputLocation.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.output_location
              (fun f -> ("output_location", (OutputLocation.to_json f)));
           Util.option_map v.select_parameters
             (fun f -> ("select_parameters", (SelectParameters.to_json f)));
           Util.option_map v.description
             (fun f -> ("description", (String.to_json f)));
           Util.option_map v.tier (fun f -> ("tier", (Tier.to_json f)));
           Util.option_map v.type_
             (fun f -> ("type_", (RestoreRequestType.to_json f)));
           Util.option_map v.glacier_job_parameters
             (fun f ->
                ("glacier_job_parameters", (GlacierJobParameters.to_json f)));
           Util.option_map v.days (fun f -> ("days", (Integer.to_json f)))])
    let of_json j =
      {
        days = (Util.option_map (Json.lookup j "days") Integer.of_json);
        glacier_job_parameters =
          (Util.option_map (Json.lookup j "glacier_job_parameters")
             GlacierJobParameters.of_json);
        type_ =
          (Util.option_map (Json.lookup j "type_") RestoreRequestType.of_json);
        tier = (Util.option_map (Json.lookup j "tier") Tier.of_json);
        description =
          (Util.option_map (Json.lookup j "description") String.of_json);
        select_parameters =
          (Util.option_map (Json.lookup j "select_parameters")
             SelectParameters.of_json);
        output_location =
          (Util.option_map (Json.lookup j "output_location")
             OutputLocation.of_json)
      }
  end
module DeleteMarkers =
  struct
    type t = DeleteMarkerEntry.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map DeleteMarkerEntry.parse [xml])
    let to_query v = Query.to_query_list DeleteMarkerEntry.to_query v
    let to_headers v = Headers.to_headers_list DeleteMarkerEntry.to_headers v
    let to_xml v = List.concat (List.map DeleteMarkerEntry.to_xml v)
    let to_json v = `List (List.map DeleteMarkerEntry.to_json v)
    let of_json j = Json.to_list DeleteMarkerEntry.of_json j
  end
module ObjectVersionList =
  struct
    type t = ObjectVersion.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map ObjectVersion.parse [xml])
    let to_query v = Query.to_query_list ObjectVersion.to_query v
    let to_headers v = Headers.to_headers_list ObjectVersion.to_headers v
    let to_xml v = List.concat (List.map ObjectVersion.to_xml v)
    let to_json v = `List (List.map ObjectVersion.to_json v)
    let of_json j = Json.to_list ObjectVersion.of_json j
  end
module VersioningConfiguration =
  struct
    type t =
      {
      m_f_a_delete: MFADelete.t option ;
      status: BucketVersioningStatus.t option }
    let make ?m_f_a_delete  ?status  () = { m_f_a_delete; status }
    let parse xml =
      Some
        {
          m_f_a_delete =
            (Util.option_bind (Xml.member "MfaDelete" xml) MFADelete.parse);
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketVersioningStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.m_f_a_delete
               (fun f ->
                  Ezxmlm.make_tag "MfaDelete" ([], (MFADelete.to_xml f)))])
           @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (BucketVersioningStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (BucketVersioningStatus.to_json f)));
           Util.option_map v.m_f_a_delete
             (fun f -> ("m_f_a_delete", (MFADelete.to_json f)))])
    let of_json j =
      {
        m_f_a_delete =
          (Util.option_map (Json.lookup j "m_f_a_delete") MFADelete.of_json);
        status =
          (Util.option_map (Json.lookup j "status")
             BucketVersioningStatus.of_json)
      }
  end
module RequestPaymentConfiguration =
  struct
    type t = {
      payer: Payer.t }
    let make ~payer  () = { payer }
    let parse xml =
      Some
        {
          payer =
            (Xml.required "Payer"
               (Util.option_bind (Xml.member "Payer" xml) Payer.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @ [Some (Ezxmlm.make_tag "Payer" ([], (Payer.to_xml v.payer)))])
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("payer", (Payer.to_json v.payer))])
    let of_json j =
      { payer = (Payer.of_json (Util.of_option_exn (Json.lookup j "payer")))
      }
  end
module ObjectLockConfiguration =
  struct
    type t =
      {
      object_lock_enabled: ObjectLockEnabled.t option ;
      rule: ObjectLockRule.t option }
    let make ?object_lock_enabled  ?rule  () = { object_lock_enabled; rule }
    let parse xml =
      Some
        {
          object_lock_enabled =
            (Util.option_bind (Xml.member "ObjectLockEnabled" xml)
               ObjectLockEnabled.parse);
          rule =
            (Util.option_bind (Xml.member "Rule" xml) ObjectLockRule.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.object_lock_enabled
               (fun f ->
                  Ezxmlm.make_tag "ObjectLockEnabled"
                    ([], (ObjectLockEnabled.to_xml f)))])
           @
           [Util.option_map v.rule
              (fun f ->
                 Ezxmlm.make_tag "Rule" ([], (ObjectLockRule.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.rule
              (fun f -> ("rule", (ObjectLockRule.to_json f)));
           Util.option_map v.object_lock_enabled
             (fun f -> ("object_lock_enabled", (ObjectLockEnabled.to_json f)))])
    let of_json j =
      {
        object_lock_enabled =
          (Util.option_map (Json.lookup j "object_lock_enabled")
             ObjectLockEnabled.of_json);
        rule =
          (Util.option_map (Json.lookup j "rule") ObjectLockRule.of_json)
      }
  end
module Delete =
  struct
    type t = {
      objects: ObjectIdentifierList.t ;
      quiet: Boolean.t option }
    let make ~objects  ?quiet  () = { objects; quiet }
    let parse xml =
      Some
        {
          objects = (Xml.required "Object" (ObjectIdentifierList.parse xml));
          quiet = (Util.option_bind (Xml.member "Quiet" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "Object"
                       ([], (ObjectIdentifierList.to_xml [x])))) v.objects))
           @
           [Util.option_map v.quiet
              (fun f -> Ezxmlm.make_tag "Quiet" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.quiet (fun f -> ("quiet", (Boolean.to_json f)));
           Some ("objects", (ObjectIdentifierList.to_json v.objects))])
    let of_json j =
      {
        objects =
          (ObjectIdentifierList.of_json
             (Util.of_option_exn (Json.lookup j "objects")));
        quiet = (Util.option_map (Json.lookup j "quiet") Boolean.of_json)
      }
  end
module InventoryConfigurationList =
  struct
    type t = InventoryConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map InventoryConfiguration.parse [xml])
    let to_query v = Query.to_query_list InventoryConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list InventoryConfiguration.to_headers v
    let to_xml v = List.concat (List.map InventoryConfiguration.to_xml v)
    let to_json v = `List (List.map InventoryConfiguration.to_json v)
    let of_json j = Json.to_list InventoryConfiguration.of_json j
  end
module MFADeleteStatus =
  struct
    type t =
      | Enabled 
      | Disabled 
    let str_to_t = [("Disabled", Disabled); ("Enabled", Enabled)]
    let t_to_str = [(Disabled, "Disabled"); (Enabled, "Enabled")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module Metadata =
  struct
    type t = (String.t, String.t) Hashtbl.t
    let make elems () = elems
    let parse xml = None
    let to_query v =
      Query.to_query_hashtbl String.to_string String.to_query v
    let to_headers v = Headers.to_headers_hashtbl String.to_headers v
    let to_xml v = []
    let to_json v =
      `Assoc
        (Hashtbl.fold
           (fun k ->
              fun v ->
                fun acc -> ((String.to_string k), (String.to_json v)) :: acc)
           v [])
    let of_json j = Json.to_hashtbl String.of_string String.of_json j
  end
module MetadataDirective =
  struct
    type t =
      | COPY 
      | REPLACE 
    let str_to_t = [("REPLACE", REPLACE); ("COPY", COPY)]
    let t_to_str = [(REPLACE, "REPLACE"); (COPY, "COPY")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ObjectLockMode =
  struct
    type t =
      | GOVERNANCE 
      | COMPLIANCE 
    let str_to_t = [("COMPLIANCE", COMPLIANCE); ("GOVERNANCE", GOVERNANCE)]
    let t_to_str = [(COMPLIANCE, "COMPLIANCE"); (GOVERNANCE, "GOVERNANCE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module TaggingDirective =
  struct
    type t =
      | COPY 
      | REPLACE 
    let str_to_t = [("REPLACE", REPLACE); ("COPY", COPY)]
    let t_to_str = [(REPLACE, "REPLACE"); (COPY, "COPY")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module WebsiteConfiguration =
  struct
    type t =
      {
      error_document: ErrorDocument.t option ;
      index_document: IndexDocument.t option ;
      redirect_all_requests_to: RedirectAllRequestsTo.t option ;
      routing_rules: RoutingRules.t }
    let make ?error_document  ?index_document  ?redirect_all_requests_to 
      ?(routing_rules= [])  () =
      {
        error_document;
        index_document;
        redirect_all_requests_to;
        routing_rules
      }
    let parse xml =
      Some
        {
          error_document =
            (Util.option_bind (Xml.member "ErrorDocument" xml)
               ErrorDocument.parse);
          index_document =
            (Util.option_bind (Xml.member "IndexDocument" xml)
               IndexDocument.parse);
          redirect_all_requests_to =
            (Util.option_bind (Xml.member "RedirectAllRequestsTo" xml)
               RedirectAllRequestsTo.parse);
          routing_rules =
            (Util.of_option []
               (Util.option_bind (Xml.member "RoutingRules" xml)
                  RoutingRules.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.error_document
                 (fun f ->
                    Ezxmlm.make_tag "ErrorDocument"
                      ([], (ErrorDocument.to_xml f)))])
             @
             [Util.option_map v.index_document
                (fun f ->
                   Ezxmlm.make_tag "IndexDocument"
                     ([], (IndexDocument.to_xml f)))])
            @
            [Util.option_map v.redirect_all_requests_to
               (fun f ->
                  Ezxmlm.make_tag "RedirectAllRequestsTo"
                    ([], (RedirectAllRequestsTo.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RoutingRules"
                      ([], (RoutingRules.to_xml [x])))) v.routing_rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("routing_rules", (RoutingRules.to_json v.routing_rules));
           Util.option_map v.redirect_all_requests_to
             (fun f ->
                ("redirect_all_requests_to",
                  (RedirectAllRequestsTo.to_json f)));
           Util.option_map v.index_document
             (fun f -> ("index_document", (IndexDocument.to_json f)));
           Util.option_map v.error_document
             (fun f -> ("error_document", (ErrorDocument.to_json f)))])
    let of_json j =
      {
        error_document =
          (Util.option_map (Json.lookup j "error_document")
             ErrorDocument.of_json);
        index_document =
          (Util.option_map (Json.lookup j "index_document")
             IndexDocument.of_json);
        redirect_all_requests_to =
          (Util.option_map (Json.lookup j "redirect_all_requests_to")
             RedirectAllRequestsTo.of_json);
        routing_rules =
          (RoutingRules.of_json
             (Util.of_option_exn (Json.lookup j "routing_rules")))
      }
  end
module PublicAccessBlockConfiguration =
  struct
    type t =
      {
      block_public_acls: Boolean.t option ;
      ignore_public_acls: Boolean.t option ;
      block_public_policy: Boolean.t option ;
      restrict_public_buckets: Boolean.t option }
    let make ?block_public_acls  ?ignore_public_acls  ?block_public_policy 
      ?restrict_public_buckets  () =
      {
        block_public_acls;
        ignore_public_acls;
        block_public_policy;
        restrict_public_buckets
      }
    let parse xml =
      Some
        {
          block_public_acls =
            (Util.option_bind (Xml.member "BlockPublicAcls" xml)
               Boolean.parse);
          ignore_public_acls =
            (Util.option_bind (Xml.member "IgnorePublicAcls" xml)
               Boolean.parse);
          block_public_policy =
            (Util.option_bind (Xml.member "BlockPublicPolicy" xml)
               Boolean.parse);
          restrict_public_buckets =
            (Util.option_bind (Xml.member "RestrictPublicBuckets" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.block_public_acls
                 (fun f ->
                    Ezxmlm.make_tag "BlockPublicAcls"
                      ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.ignore_public_acls
                (fun f ->
                   Ezxmlm.make_tag "IgnorePublicAcls"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.block_public_policy
               (fun f ->
                  Ezxmlm.make_tag "BlockPublicPolicy"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.restrict_public_buckets
              (fun f ->
                 Ezxmlm.make_tag "RestrictPublicBuckets"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.restrict_public_buckets
              (fun f -> ("restrict_public_buckets", (Boolean.to_json f)));
           Util.option_map v.block_public_policy
             (fun f -> ("block_public_policy", (Boolean.to_json f)));
           Util.option_map v.ignore_public_acls
             (fun f -> ("ignore_public_acls", (Boolean.to_json f)));
           Util.option_map v.block_public_acls
             (fun f -> ("block_public_acls", (Boolean.to_json f)))])
    let of_json j =
      {
        block_public_acls =
          (Util.option_map (Json.lookup j "block_public_acls")
             Boolean.of_json);
        ignore_public_acls =
          (Util.option_map (Json.lookup j "ignore_public_acls")
             Boolean.of_json);
        block_public_policy =
          (Util.option_map (Json.lookup j "block_public_policy")
             Boolean.of_json);
        restrict_public_buckets =
          (Util.option_map (Json.lookup j "restrict_public_buckets")
             Boolean.of_json)
      }
  end
module CORSConfiguration =
  struct
    type t = {
      c_o_r_s_rules: CORSRules.t }
    let make ~c_o_r_s_rules  () = { c_o_r_s_rules }
    let parse xml =
      Some
        { c_o_r_s_rules = (Xml.required "CORSRule" (CORSRules.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CORSRule" ([], (CORSRules.to_xml [x]))))
              v.c_o_r_s_rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("c_o_r_s_rules", (CORSRules.to_json v.c_o_r_s_rules))])
    let of_json j =
      {
        c_o_r_s_rules =
          (CORSRules.of_json
             (Util.of_option_exn (Json.lookup j "c_o_r_s_rules")))
      }
  end
module ReplicationStatus =
  struct
    type t =
      | COMPLETE 
      | PENDING 
      | FAILED 
      | REPLICA 
    let str_to_t =
      [("REPLICA", REPLICA);
      ("FAILED", FAILED);
      ("PENDING", PENDING);
      ("COMPLETE", COMPLETE)]
    let t_to_str =
      [(REPLICA, "REPLICA");
      (FAILED, "FAILED");
      (PENDING, "PENDING");
      (COMPLETE, "COMPLETE")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module ObjectLockLegalHold =
  struct
    type t = {
      status: ObjectLockLegalHoldStatus.t option }
    let make ?status  () = { status }
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (ObjectLockLegalHoldStatus.to_json f)))])
    let of_json j =
      {
        status =
          (Util.option_map (Json.lookup j "status")
             ObjectLockLegalHoldStatus.of_json)
      }
  end
module AccelerateConfiguration =
  struct
    type t = {
      status: BucketAccelerateStatus.t option }
    let make ?status  () = { status }
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketAccelerateStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (BucketAccelerateStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (BucketAccelerateStatus.to_json f)))])
    let of_json j =
      {
        status =
          (Util.option_map (Json.lookup j "status")
             BucketAccelerateStatus.of_json)
      }
  end
module MetricsConfigurationList =
  struct
    type t = MetricsConfiguration.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map MetricsConfiguration.parse [xml])
    let to_query v = Query.to_query_list MetricsConfiguration.to_query v
    let to_headers v =
      Headers.to_headers_list MetricsConfiguration.to_headers v
    let to_xml v = List.concat (List.map MetricsConfiguration.to_xml v)
    let to_json v = `List (List.map MetricsConfiguration.to_json v)
    let of_json j = Json.to_list MetricsConfiguration.of_json j
  end
module ObjectLockRetention =
  struct
    type t =
      {
      mode: ObjectLockRetentionMode.t option ;
      retain_until_date: DateTime.t option }
    let make ?mode  ?retain_until_date  () = { mode; retain_until_date }
    let parse xml =
      Some
        {
          mode =
            (Util.option_bind (Xml.member "Mode" xml)
               ObjectLockRetentionMode.parse);
          retain_until_date =
            (Util.option_bind (Xml.member "RetainUntilDate" xml)
               DateTime.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.mode
               (fun f ->
                  Ezxmlm.make_tag "Mode"
                    ([], (ObjectLockRetentionMode.to_xml f)))])
           @
           [Util.option_map v.retain_until_date
              (fun f ->
                 Ezxmlm.make_tag "RetainUntilDate" ([], (DateTime.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.retain_until_date
              (fun f -> ("retain_until_date", (DateTime.to_json f)));
           Util.option_map v.mode
             (fun f -> ("mode", (ObjectLockRetentionMode.to_json f)))])
    let of_json j =
      {
        mode =
          (Util.option_map (Json.lookup j "mode")
             ObjectLockRetentionMode.of_json);
        retain_until_date =
          (Util.option_map (Json.lookup j "retain_until_date")
             DateTime.of_json)
      }
  end
module AccessControlPolicy =
  struct
    type t = {
      grants: Grants.t ;
      owner: Owner.t option }
    let make ?(grants= [])  ?owner  () = { grants; owner }
    let parse xml =
      Some
        {
          grants =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccessControlList" xml)
                  Grants.parse));
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AccessControlList"
                       ([], (Grants.to_xml [x])))) v.grants))
           @
           [Util.option_map v.owner
              (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Some ("grants", (Grants.to_json v.grants))])
    let of_json j =
      {
        grants =
          (Grants.of_json (Util.of_option_exn (Json.lookup j "grants")));
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json)
      }
  end
module BucketCannedACL =
  struct
    type t =
      | Private 
      | Public_read 
      | Public_read_write 
      | Authenticated_read 
    let str_to_t =
      [("authenticated-read", Authenticated_read);
      ("public-read-write", Public_read_write);
      ("public-read", Public_read);
      ("private", Private)]
    let t_to_str =
      [(Authenticated_read, "authenticated-read");
      (Public_read_write, "public-read-write");
      (Public_read, "public-read");
      (Private, "private")]
    let to_string e = Util.of_option_exn (Util.list_find t_to_str e)
    let of_string s = Util.of_option_exn (Util.list_find str_to_t s)
    let make v () = v
    let parse xml =
      Util.option_bind (String.parse xml)
        (fun s -> Util.list_find str_to_t s)
    let to_query v =
      Query.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_headers v =
      Headers.Value (Some (Util.of_option_exn (Util.list_find t_to_str v)))
    let to_xml v =
      String.to_xml (Util.of_option_exn (Util.list_find t_to_str v))
    let to_json v =
      String.to_json (Util.of_option_exn (Util.list_find t_to_str v))
    let of_json j =
      Util.of_option_exn (Util.list_find str_to_t (String.of_json j))
  end
module CreateBucketConfiguration =
  struct
    type t = {
      location_constraint: BucketLocationConstraint.t option }
    let make ?location_constraint  () = { location_constraint }
    let parse xml =
      Some
        {
          location_constraint =
            (Util.option_bind (Xml.member "LocationConstraint" xml)
               BucketLocationConstraint.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.location_constraint
              (fun f ->
                 Ezxmlm.make_tag "LocationConstraint"
                   ([], (BucketLocationConstraint.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.location_constraint
              (fun f ->
                 ("location_constraint",
                   (BucketLocationConstraint.to_json f)))])
    let of_json j =
      {
        location_constraint =
          (Util.option_map (Json.lookup j "location_constraint")
             BucketLocationConstraint.of_json)
      }
  end
module BucketLoggingStatus =
  struct
    type t = {
      logging_enabled: LoggingEnabled.t option }
    let make ?logging_enabled  () = { logging_enabled }
    let parse xml =
      Some
        {
          logging_enabled =
            (Util.option_bind (Xml.member "LoggingEnabled" xml)
               LoggingEnabled.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.logging_enabled
              (fun f ->
                 Ezxmlm.make_tag "LoggingEnabled"
                   ([], (LoggingEnabled.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.logging_enabled
              (fun f -> ("logging_enabled", (LoggingEnabled.to_json f)))])
    let of_json j =
      {
        logging_enabled =
          (Util.option_map (Json.lookup j "logging_enabled")
             LoggingEnabled.of_json)
      }
  end
module CompletedMultipartUpload =
  struct
    type t = {
      parts: CompletedPartList.t }
    let make ?(parts= [])  () = { parts }
    let parse xml =
      Some { parts = (Util.of_option [] (CompletedPartList.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Part"
                      ([], (CompletedPartList.to_xml [x])))) v.parts))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("parts", (CompletedPartList.to_json v.parts))])
    let of_json j =
      {
        parts =
          (CompletedPartList.of_json
             (Util.of_option_exn (Json.lookup j "parts")))
      }
  end
module Buckets =
  struct
    type t = Bucket.t list
    let make elems () = elems
    let parse xml =
      Util.option_all (List.map Bucket.parse (Xml.members "Bucket" xml))
    let to_query v = Query.to_query_list Bucket.to_query v
    let to_headers v = Headers.to_headers_list Bucket.to_headers v
    let to_xml v =
      List.map (fun x -> Ezxmlm.make_tag "member" ([], (Bucket.to_xml x))) v
    let to_json v = `List (List.map Bucket.to_json v)
    let of_json j = Json.to_list Bucket.of_json j
  end
module NotificationConfigurationDeprecated =
  struct
    type t =
      {
      topic_configuration: TopicConfigurationDeprecated.t option ;
      queue_configuration: QueueConfigurationDeprecated.t option ;
      cloud_function_configuration: CloudFunctionConfiguration.t option }
    let make ?topic_configuration  ?queue_configuration 
      ?cloud_function_configuration  () =
      {
        topic_configuration;
        queue_configuration;
        cloud_function_configuration
      }
    let parse xml =
      Some
        {
          topic_configuration =
            (Util.option_bind (Xml.member "TopicConfiguration" xml)
               TopicConfigurationDeprecated.parse);
          queue_configuration =
            (Util.option_bind (Xml.member "QueueConfiguration" xml)
               QueueConfigurationDeprecated.parse);
          cloud_function_configuration =
            (Util.option_bind (Xml.member "CloudFunctionConfiguration" xml)
               CloudFunctionConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.topic_configuration
                (fun f ->
                   Ezxmlm.make_tag "TopicConfiguration"
                     ([], (TopicConfigurationDeprecated.to_xml f)))])
            @
            [Util.option_map v.queue_configuration
               (fun f ->
                  Ezxmlm.make_tag "QueueConfiguration"
                    ([], (QueueConfigurationDeprecated.to_xml f)))])
           @
           [Util.option_map v.cloud_function_configuration
              (fun f ->
                 Ezxmlm.make_tag "CloudFunctionConfiguration"
                   ([], (CloudFunctionConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.cloud_function_configuration
              (fun f ->
                 ("cloud_function_configuration",
                   (CloudFunctionConfiguration.to_json f)));
           Util.option_map v.queue_configuration
             (fun f ->
                ("queue_configuration",
                  (QueueConfigurationDeprecated.to_json f)));
           Util.option_map v.topic_configuration
             (fun f ->
                ("topic_configuration",
                  (TopicConfigurationDeprecated.to_json f)))])
    let of_json j =
      {
        topic_configuration =
          (Util.option_map (Json.lookup j "topic_configuration")
             TopicConfigurationDeprecated.of_json);
        queue_configuration =
          (Util.option_map (Json.lookup j "queue_configuration")
             QueueConfigurationDeprecated.of_json);
        cloud_function_configuration =
          (Util.option_map (Json.lookup j "cloud_function_configuration")
             CloudFunctionConfiguration.of_json)
      }
  end
module SelectObjectContentEventStream =
  struct
    type t =
      {
      records: RecordsEvent.t option ;
      stats: StatsEvent.t option ;
      progress: ProgressEvent.t option ;
      cont: ContinuationEvent.t option ;
      end_: EndEvent.t option }
    let make ?records  ?stats  ?progress  ?cont  ?end_  () =
      { records; stats; progress; cont; end_ }
    let parse xml =
      Some
        {
          records =
            (Util.option_bind (Xml.member "Records" xml) RecordsEvent.parse);
          stats =
            (Util.option_bind (Xml.member "Stats" xml) StatsEvent.parse);
          progress =
            (Util.option_bind (Xml.member "Progress" xml) ProgressEvent.parse);
          cont =
            (Util.option_bind (Xml.member "Cont" xml) ContinuationEvent.parse);
          end_ = (Util.option_bind (Xml.member "End" xml) EndEvent.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Util.option_map v.records
                  (fun f ->
                     Ezxmlm.make_tag "Records" ([], (RecordsEvent.to_xml f)))])
              @
              [Util.option_map v.stats
                 (fun f ->
                    Ezxmlm.make_tag "Stats" ([], (StatsEvent.to_xml f)))])
             @
             [Util.option_map v.progress
                (fun f ->
                   Ezxmlm.make_tag "Progress" ([], (ProgressEvent.to_xml f)))])
            @
            [Util.option_map v.cont
               (fun f ->
                  Ezxmlm.make_tag "Cont" ([], (ContinuationEvent.to_xml f)))])
           @
           [Util.option_map v.end_
              (fun f -> Ezxmlm.make_tag "End" ([], (EndEvent.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_ (fun f -> ("end_", (EndEvent.to_json f)));
           Util.option_map v.cont
             (fun f -> ("cont", (ContinuationEvent.to_json f)));
           Util.option_map v.progress
             (fun f -> ("progress", (ProgressEvent.to_json f)));
           Util.option_map v.stats
             (fun f -> ("stats", (StatsEvent.to_json f)));
           Util.option_map v.records
             (fun f -> ("records", (RecordsEvent.to_json f)))])
    let of_json j =
      {
        records =
          (Util.option_map (Json.lookup j "records") RecordsEvent.of_json);
        stats = (Util.option_map (Json.lookup j "stats") StatsEvent.of_json);
        progress =
          (Util.option_map (Json.lookup j "progress") ProgressEvent.of_json);
        cont =
          (Util.option_map (Json.lookup j "cont") ContinuationEvent.of_json);
        end_ = (Util.option_map (Json.lookup j "end_") EndEvent.of_json)
      }
  end
module RequestProgress =
  struct
    type t = {
      enabled: Boolean.t option }
    let make ?enabled  () = { enabled }
    let parse xml =
      Some
        {
          enabled =
            (Util.option_bind (Xml.member "Enabled" xml) Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.enabled
              (fun f -> Ezxmlm.make_tag "Enabled" ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.enabled
              (fun f -> ("enabled", (Boolean.to_json f)))])
    let of_json j =
      { enabled = (Util.option_map (Json.lookup j "enabled") Boolean.of_json)
      }
  end
module ScanRange =
  struct
    type t = {
      start: Long.t option ;
      end_: Long.t option }
    let make ?start  ?end_  () = { start; end_ }
    let parse xml =
      Some
        {
          start = (Util.option_bind (Xml.member "Start" xml) Long.parse);
          end_ = (Util.option_bind (Xml.member "End" xml) Long.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.start
               (fun f -> Ezxmlm.make_tag "Start" ([], (Long.to_xml f)))])
           @
           [Util.option_map v.end_
              (fun f -> Ezxmlm.make_tag "End" ([], (Long.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.end_ (fun f -> ("end_", (Long.to_json f)));
           Util.option_map v.start (fun f -> ("start", (Long.to_json f)))])
    let of_json j =
      {
        start = (Util.option_map (Json.lookup j "start") Long.of_json);
        end_ = (Util.option_map (Json.lookup j "end_") Long.of_json)
      }
  end
module DeletedObjects =
  struct
    type t = DeletedObject.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map DeletedObject.parse [xml])
    let to_query v = Query.to_query_list DeletedObject.to_query v
    let to_headers v = Headers.to_headers_list DeletedObject.to_headers v
    let to_xml v = List.concat (List.map DeletedObject.to_xml v)
    let to_json v = `List (List.map DeletedObject.to_json v)
    let of_json j = Json.to_list DeletedObject.of_json j
  end
module Errors =
  struct
    type t = Error.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map Error.parse [xml])
    let to_query v = Query.to_query_list Error.to_query v
    let to_headers v = Headers.to_headers_list Error.to_headers v
    let to_xml v = List.concat (List.map Error.to_xml v)
    let to_json v = `List (List.map Error.to_json v)
    let of_json j = Json.to_list Error.of_json j
  end
module CopyPartResult =
  struct
    type t = {
      e_tag: String.t option ;
      last_modified: DateTime.t option }
    let make ?e_tag  ?last_modified  () = { e_tag; last_modified }
    let parse xml =
      Some
        {
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.e_tag
               (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
           @
           [Util.option_map v.last_modified
              (fun f ->
                 Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_modified
              (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)))])
    let of_json j =
      {
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json)
      }
  end
module BucketLifecycleConfiguration =
  struct
    type t = {
      rules: LifecycleRules.t }
    let make ~rules  () = { rules }
    let parse xml =
      Some { rules = (Xml.required "Rule" (LifecycleRules.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule" ([], (LifecycleRules.to_xml [x]))))
              v.rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (LifecycleRules.to_json v.rules))])
    let of_json j =
      {
        rules =
          (LifecycleRules.of_json
             (Util.of_option_exn (Json.lookup j "rules")))
      }
  end
module Parts =
  struct
    type t = Part.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map Part.parse [xml])
    let to_query v = Query.to_query_list Part.to_query v
    let to_headers v = Headers.to_headers_list Part.to_headers v
    let to_xml v = List.concat (List.map Part.to_xml v)
    let to_json v = `List (List.map Part.to_json v)
    let of_json j = Json.to_list Part.of_json j
  end
module MultipartUploadList =
  struct
    type t = MultipartUpload.t list
    let make elems () = elems
    let parse xml = Util.option_all (List.map MultipartUpload.parse [xml])
    let to_query v = Query.to_query_list MultipartUpload.to_query v
    let to_headers v = Headers.to_headers_list MultipartUpload.to_headers v
    let to_xml v = List.concat (List.map MultipartUpload.to_xml v)
    let to_json v = `List (List.map MultipartUpload.to_json v)
    let of_json j = Json.to_list MultipartUpload.of_json j
  end
module CopyObjectResult =
  struct
    type t = {
      e_tag: String.t option ;
      last_modified: DateTime.t option }
    let make ?e_tag  ?last_modified  () = { e_tag; last_modified }
    let parse xml =
      Some
        {
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "LastModified" xml) DateTime.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.e_tag
               (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
           @
           [Util.option_map v.last_modified
              (fun f ->
                 Ezxmlm.make_tag "LastModified" ([], (DateTime.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.last_modified
              (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)))])
    let of_json j =
      {
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json)
      }
  end
module NotificationConfiguration =
  struct
    type t =
      {
      topic_configurations: TopicConfigurationList.t ;
      queue_configurations: QueueConfigurationList.t ;
      lambda_function_configurations: LambdaFunctionConfigurationList.t }
    let make ?(topic_configurations= [])  ?(queue_configurations= []) 
      ?(lambda_function_configurations= [])  () =
      {
        topic_configurations;
        queue_configurations;
        lambda_function_configurations
      }
    let parse xml =
      Some
        {
          topic_configurations =
            (Util.of_option [] (TopicConfigurationList.parse xml));
          queue_configurations =
            (Util.of_option [] (QueueConfigurationList.parse xml));
          lambda_function_configurations =
            (Util.of_option [] (LambdaFunctionConfigurationList.parse xml))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "TopicConfiguration"
                        ([], (TopicConfigurationList.to_xml [x]))))
                v.topic_configurations))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "QueueConfiguration"
                       ([], (QueueConfigurationList.to_xml [x]))))
               v.queue_configurations))
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CloudFunctionConfiguration"
                      ([], (LambdaFunctionConfigurationList.to_xml [x]))))
              v.lambda_function_configurations))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("lambda_function_configurations",
                (LambdaFunctionConfigurationList.to_json
                   v.lambda_function_configurations));
           Some
             ("queue_configurations",
               (QueueConfigurationList.to_json v.queue_configurations));
           Some
             ("topic_configurations",
               (TopicConfigurationList.to_json v.topic_configurations))])
    let of_json j =
      {
        topic_configurations =
          (TopicConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "topic_configurations")));
        queue_configurations =
          (QueueConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "queue_configurations")));
        lambda_function_configurations =
          (LambdaFunctionConfigurationList.of_json
             (Util.of_option_exn
                (Json.lookup j "lambda_function_configurations")))
      }
  end
module ListObjectsV2Output =
  struct
    type t =
      {
      is_truncated: Boolean.t option ;
      contents: ObjectList.t ;
      name: String.t option ;
      prefix: String.t option ;
      delimiter: String.t option ;
      max_keys: Integer.t option ;
      common_prefixes: CommonPrefixList.t ;
      encoding_type: EncodingType.t option ;
      key_count: Integer.t option ;
      continuation_token: String.t option ;
      next_continuation_token: String.t option ;
      start_after: String.t option }
    let make ?is_truncated  ?(contents= [])  ?name  ?prefix  ?delimiter 
      ?max_keys  ?(common_prefixes= [])  ?encoding_type  ?key_count 
      ?continuation_token  ?next_continuation_token  ?start_after  () =
      {
        is_truncated;
        contents;
        name;
        prefix;
        delimiter;
        max_keys;
        common_prefixes;
        encoding_type;
        key_count;
        continuation_token;
        next_continuation_token;
        start_after
      }
    let parse xml =
      Some
        {
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          contents = (Util.of_option [] (ObjectList.parse xml));
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          delimiter =
            (Util.option_bind (Xml.member "Delimiter" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "MaxKeys" xml) Integer.parse);
          common_prefixes = (Util.of_option [] (CommonPrefixList.parse xml));
          encoding_type =
            (Util.option_bind (Xml.member "EncodingType" xml)
               EncodingType.parse);
          key_count =
            (Util.option_bind (Xml.member "KeyCount" xml) Integer.parse);
          continuation_token =
            (Util.option_bind (Xml.member "ContinuationToken" xml)
               String.parse);
          next_continuation_token =
            (Util.option_bind (Xml.member "NextContinuationToken" xml)
               String.parse);
          start_after =
            (Util.option_bind (Xml.member "StartAfter" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.is_truncated
                         (fun f ->
                            Ezxmlm.make_tag "IsTruncated"
                              ([], (Boolean.to_xml f)))])
                     @
                     (List.map
                        (fun x ->
                           Some
                             (Ezxmlm.make_tag "Contents"
                                ([], (ObjectList.to_xml [x])))) v.contents))
                    @
                    [Util.option_map v.name
                       (fun f ->
                          Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.prefix
                      (fun f ->
                         Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.delimiter
                     (fun f ->
                        Ezxmlm.make_tag "Delimiter" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.max_keys
                    (fun f ->
                       Ezxmlm.make_tag "MaxKeys" ([], (Integer.to_xml f)))])
                @
                (List.map
                   (fun x ->
                      Some
                        (Ezxmlm.make_tag "CommonPrefixes"
                           ([], (CommonPrefixList.to_xml [x]))))
                   v.common_prefixes))
               @
               [Util.option_map v.encoding_type
                  (fun f ->
                     Ezxmlm.make_tag "EncodingType"
                       ([], (EncodingType.to_xml f)))])
              @
              [Util.option_map v.key_count
                 (fun f ->
                    Ezxmlm.make_tag "KeyCount" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.continuation_token
                (fun f ->
                   Ezxmlm.make_tag "ContinuationToken"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.next_continuation_token
               (fun f ->
                  Ezxmlm.make_tag "NextContinuationToken"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.start_after
              (fun f -> Ezxmlm.make_tag "StartAfter" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.start_after
              (fun f -> ("start_after", (String.to_json f)));
           Util.option_map v.next_continuation_token
             (fun f -> ("next_continuation_token", (String.to_json f)));
           Util.option_map v.continuation_token
             (fun f -> ("continuation_token", (String.to_json f)));
           Util.option_map v.key_count
             (fun f -> ("key_count", (Integer.to_json f)));
           Util.option_map v.encoding_type
             (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Some
             ("common_prefixes",
               (CommonPrefixList.to_json v.common_prefixes));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Some ("contents", (ObjectList.to_json v.contents));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)))])
    let of_json j =
      {
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        contents =
          (ObjectList.of_json (Util.of_option_exn (Json.lookup j "contents")));
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        max_keys =
          (Util.option_map (Json.lookup j "max_keys") Integer.of_json);
        common_prefixes =
          (CommonPrefixList.of_json
             (Util.of_option_exn (Json.lookup j "common_prefixes")));
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json);
        key_count =
          (Util.option_map (Json.lookup j "key_count") Integer.of_json);
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json);
        next_continuation_token =
          (Util.option_map (Json.lookup j "next_continuation_token")
             String.of_json);
        start_after =
          (Util.option_map (Json.lookup j "start_after") String.of_json)
      }
  end
module GetObjectTaggingRequest =
  struct
    type t = {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option }
    let make ~bucket  ~key  ?version_id  () = { bucket; key; version_id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
           @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json)
      }
  end
module GetObjectLegalHoldRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?version_id  ?request_payer  () =
      { bucket; key; version_id; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Util.option_map v.version_id
               (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module PutObjectRetentionOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let of_json j =
      {
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module CreateMultipartUploadOutput =
  struct
    type t =
      {
      abort_date: DateTime.t option ;
      abort_rule_id: String.t option ;
      bucket: String.t option ;
      key: String.t option ;
      upload_id: String.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      s_s_e_k_m_s_encryption_context: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?abort_date  ?abort_rule_id  ?bucket  ?key  ?upload_id 
      ?server_side_encryption  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?request_charged  () =
      {
        abort_date;
        abort_rule_id;
        bucket;
        key;
        upload_id;
        server_side_encryption;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        request_charged
      }
    let parse xml =
      Some
        {
          abort_date =
            (Util.option_bind (Xml.member "x-amz-abort-date" xml)
               DateTime.parse);
          abort_rule_id =
            (Util.option_bind (Xml.member "x-amz-abort-rule-id" xml)
               String.parse);
          bucket = (Util.option_bind (Xml.member "Bucket" xml) String.parse);
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          upload_id =
            (Util.option_bind (Xml.member "UploadId" xml) String.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.abort_rule_id
             (fun f ->
                Headers.Pair ("x-amz-abort-rule-id", (String.to_headers f)));
           Util.option_map v.abort_date
             (fun f ->
                Headers.Pair ("x-amz-abort-date", (DateTime.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.abort_date
                        (fun f ->
                           Ezxmlm.make_tag "x-amz-abort-date"
                             ([], (DateTime.to_xml f)))])
                    @
                    [Util.option_map v.abort_rule_id
                       (fun f ->
                          Ezxmlm.make_tag "x-amz-abort-rule-id"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.bucket
                      (fun f ->
                         Ezxmlm.make_tag "Bucket" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.key
                     (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.upload_id
                    (fun f ->
                       Ezxmlm.make_tag "UploadId" ([], (String.to_xml f)))])
                @
                [Util.option_map v.server_side_encryption
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-server-side-encryption"
                        ([], (ServerSideEncryption.to_xml f)))])
               @
               [Util.option_map v.s_s_e_customer_algorithm
                  (fun f ->
                     Ezxmlm.make_tag
                       "x-amz-server-side-encryption-customer-algorithm"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_key_m_d5
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-key-MD5"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_k_m_s_key_id
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-aws-kms-key-id"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_k_m_s_encryption_context
               (fun f ->
                  Ezxmlm.make_tag "x-amz-server-side-encryption-context"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.upload_id
             (fun f -> ("upload_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)));
           Util.option_map v.bucket (fun f -> ("bucket", (String.to_json f)));
           Util.option_map v.abort_rule_id
             (fun f -> ("abort_rule_id", (String.to_json f)));
           Util.option_map v.abort_date
             (fun f -> ("abort_date", (DateTime.to_json f)))])
    let of_json j =
      {
        abort_date =
          (Util.option_map (Json.lookup j "abort_date") DateTime.of_json);
        abort_rule_id =
          (Util.option_map (Json.lookup j "abort_rule_id") String.of_json);
        bucket = (Util.option_map (Json.lookup j "bucket") String.of_json);
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        upload_id =
          (Util.option_map (Json.lookup j "upload_id") String.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_encryption_context")
             String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketAnalyticsConfigurationOutput =
  struct
    type t = {
      analytics_configuration: AnalyticsConfiguration.t option }
    let make ?analytics_configuration  () = { analytics_configuration }
    let parse xml =
      Some
        {
          analytics_configuration =
            (Util.option_bind (Xml.member "AnalyticsConfiguration" xml)
               AnalyticsConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.analytics_configuration
              (fun f ->
                 Ezxmlm.make_tag "AnalyticsConfiguration"
                   ([], (AnalyticsConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.analytics_configuration
              (fun f ->
                 ("analytics_configuration",
                   (AnalyticsConfiguration.to_json f)))])
    let of_json j =
      {
        analytics_configuration =
          (Util.option_map (Json.lookup j "analytics_configuration")
             AnalyticsConfiguration.of_json)
      }
  end
module GetObjectRequest =
  struct
    type t =
      {
      bucket: String.t ;
      if_match: String.t option ;
      if_modified_since: DateTime.t option ;
      if_none_match: String.t option ;
      if_unmodified_since: DateTime.t option ;
      key: String.t ;
      range: String.t option ;
      response_cache_control: String.t option ;
      response_content_disposition: String.t option ;
      response_content_encoding: String.t option ;
      response_content_language: String.t option ;
      response_content_type: String.t option ;
      response_expires: DateTime.t option ;
      version_id: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      request_payer: RequestPayer.t option ;
      part_number: Integer.t option }
    let make ~bucket  ?if_match  ?if_modified_since  ?if_none_match 
      ?if_unmodified_since  ~key  ?range  ?response_cache_control 
      ?response_content_disposition  ?response_content_encoding 
      ?response_content_language  ?response_content_type  ?response_expires 
      ?version_id  ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ?request_payer  ?part_number  () =
      {
        bucket;
        if_match;
        if_modified_since;
        if_none_match;
        if_unmodified_since;
        key;
        range;
        response_cache_control;
        response_content_disposition;
        response_content_encoding;
        response_content_language;
        response_content_type;
        response_expires;
        version_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        request_payer;
        part_number
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          if_match =
            (Util.option_bind (Xml.member "If-Match" xml) String.parse);
          if_modified_since =
            (Util.option_bind (Xml.member "If-Modified-Since" xml)
               DateTime.parse);
          if_none_match =
            (Util.option_bind (Xml.member "If-None-Match" xml) String.parse);
          if_unmodified_since =
            (Util.option_bind (Xml.member "If-Unmodified-Since" xml)
               DateTime.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          range = (Util.option_bind (Xml.member "Range" xml) String.parse);
          response_cache_control =
            (Util.option_bind (Xml.member "response-cache-control" xml)
               String.parse);
          response_content_disposition =
            (Util.option_bind (Xml.member "response-content-disposition" xml)
               String.parse);
          response_content_encoding =
            (Util.option_bind (Xml.member "response-content-encoding" xml)
               String.parse);
          response_content_language =
            (Util.option_bind (Xml.member "response-content-language" xml)
               String.parse);
          response_content_type =
            (Util.option_bind (Xml.member "response-content-type" xml)
               String.parse);
          response_expires =
            (Util.option_bind (Xml.member "response-expires" xml)
               DateTime.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          part_number =
            (Util.option_bind (Xml.member "partNumber" xml) Integer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.part_number
              (fun f -> Query.Pair ("partNumber", (Integer.to_query f)));
           Util.option_map v.version_id
             (fun f -> Query.Pair ("versionId", (String.to_query f)));
           Util.option_map v.response_expires
             (fun f -> Query.Pair ("response-expires", (DateTime.to_query f)));
           Util.option_map v.response_content_type
             (fun f ->
                Query.Pair ("response-content-type", (String.to_query f)));
           Util.option_map v.response_content_language
             (fun f ->
                Query.Pair ("response-content-language", (String.to_query f)));
           Util.option_map v.response_content_encoding
             (fun f ->
                Query.Pair ("response-content-encoding", (String.to_query f)));
           Util.option_map v.response_content_disposition
             (fun f ->
                Query.Pair
                  ("response-content-disposition", (String.to_query f)));
           Util.option_map v.response_cache_control
             (fun f ->
                Query.Pair ("response-cache-control", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.range
             (fun f -> Headers.Pair ("Range", (String.to_headers f)));
           Util.option_map v.if_unmodified_since
             (fun f ->
                Headers.Pair ("If-Unmodified-Since", (DateTime.to_headers f)));
           Util.option_map v.if_none_match
             (fun f -> Headers.Pair ("If-None-Match", (String.to_headers f)));
           Util.option_map v.if_modified_since
             (fun f ->
                Headers.Pair ("If-Modified-Since", (DateTime.to_headers f)));
           Util.option_map v.if_match
             (fun f -> Headers.Pair ("If-Match", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((([] @
                             [Some
                                (Ezxmlm.make_tag "Bucket"
                                   ([], (String.to_xml v.bucket)))])
                            @
                            [Util.option_map v.if_match
                               (fun f ->
                                  Ezxmlm.make_tag "If-Match"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.if_modified_since
                              (fun f ->
                                 Ezxmlm.make_tag "If-Modified-Since"
                                   ([], (DateTime.to_xml f)))])
                          @
                          [Util.option_map v.if_none_match
                             (fun f ->
                                Ezxmlm.make_tag "If-None-Match"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.if_unmodified_since
                            (fun f ->
                               Ezxmlm.make_tag "If-Unmodified-Since"
                                 ([], (DateTime.to_xml f)))])
                        @
                        [Some
                           (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                       @
                       [Util.option_map v.range
                          (fun f ->
                             Ezxmlm.make_tag "Range" ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.response_cache_control
                         (fun f ->
                            Ezxmlm.make_tag "response-cache-control"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.response_content_disposition
                        (fun f ->
                           Ezxmlm.make_tag "response-content-disposition"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.response_content_encoding
                       (fun f ->
                          Ezxmlm.make_tag "response-content-encoding"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.response_content_language
                      (fun f ->
                         Ezxmlm.make_tag "response-content-language"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.response_content_type
                     (fun f ->
                        Ezxmlm.make_tag "response-content-type"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.response_expires
                    (fun f ->
                       Ezxmlm.make_tag "response-expires"
                         ([], (DateTime.to_xml f)))])
                @
                [Util.option_map v.version_id
                   (fun f ->
                      Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.s_s_e_customer_algorithm
                  (fun f ->
                     Ezxmlm.make_tag
                       "x-amz-server-side-encryption-customer-algorithm"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_key
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-key"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_customer_key_m_d5
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-customer-key-MD5"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.request_payer
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-payer"
                    ([], (RequestPayer.to_xml f)))])
           @
           [Util.option_map v.part_number
              (fun f -> Ezxmlm.make_tag "partNumber" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.part_number
              (fun f -> ("part_number", (Integer.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.response_expires
             (fun f -> ("response_expires", (DateTime.to_json f)));
           Util.option_map v.response_content_type
             (fun f -> ("response_content_type", (String.to_json f)));
           Util.option_map v.response_content_language
             (fun f -> ("response_content_language", (String.to_json f)));
           Util.option_map v.response_content_encoding
             (fun f -> ("response_content_encoding", (String.to_json f)));
           Util.option_map v.response_content_disposition
             (fun f -> ("response_content_disposition", (String.to_json f)));
           Util.option_map v.response_cache_control
             (fun f -> ("response_cache_control", (String.to_json f)));
           Util.option_map v.range (fun f -> ("range", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.if_unmodified_since
             (fun f -> ("if_unmodified_since", (DateTime.to_json f)));
           Util.option_map v.if_none_match
             (fun f -> ("if_none_match", (String.to_json f)));
           Util.option_map v.if_modified_since
             (fun f -> ("if_modified_since", (DateTime.to_json f)));
           Util.option_map v.if_match
             (fun f -> ("if_match", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        if_match =
          (Util.option_map (Json.lookup j "if_match") String.of_json);
        if_modified_since =
          (Util.option_map (Json.lookup j "if_modified_since")
             DateTime.of_json);
        if_none_match =
          (Util.option_map (Json.lookup j "if_none_match") String.of_json);
        if_unmodified_since =
          (Util.option_map (Json.lookup j "if_unmodified_since")
             DateTime.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        range = (Util.option_map (Json.lookup j "range") String.of_json);
        response_cache_control =
          (Util.option_map (Json.lookup j "response_cache_control")
             String.of_json);
        response_content_disposition =
          (Util.option_map (Json.lookup j "response_content_disposition")
             String.of_json);
        response_content_encoding =
          (Util.option_map (Json.lookup j "response_content_encoding")
             String.of_json);
        response_content_language =
          (Util.option_map (Json.lookup j "response_content_language")
             String.of_json);
        response_content_type =
          (Util.option_map (Json.lookup j "response_content_type")
             String.of_json);
        response_expires =
          (Util.option_map (Json.lookup j "response_expires")
             DateTime.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        part_number =
          (Util.option_map (Json.lookup j "part_number") Integer.of_json)
      }
  end
module GetBucketPolicyStatusOutput =
  struct
    type t = {
      policy_status: PolicyStatus.t option }
    let make ?policy_status  () = { policy_status }
    let parse xml =
      Some
        {
          policy_status =
            (Util.option_bind (Xml.member "PolicyStatus" xml)
               PolicyStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.policy_status
              (fun f ->
                 Ezxmlm.make_tag "PolicyStatus" ([], (PolicyStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.policy_status
              (fun f -> ("policy_status", (PolicyStatus.to_json f)))])
    let of_json j =
      {
        policy_status =
          (Util.option_map (Json.lookup j "policy_status")
             PolicyStatus.of_json)
      }
  end
module PutBucketReplicationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      replication_configuration: ReplicationConfiguration.t ;
      token: String.t option }
    let make ~bucket  ?content_m_d5  ~replication_configuration  ?token  () =
      { bucket; content_m_d5; replication_configuration; token }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          replication_configuration =
            (Xml.required "ReplicationConfiguration"
               (Util.option_bind (Xml.member "ReplicationConfiguration" xml)
                  ReplicationConfiguration.parse));
          token =
            (Util.option_bind
               (Xml.member "x-amz-bucket-object-lock-token" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.token
              (fun f ->
                 Headers.Pair
                   ("x-amz-bucket-object-lock-token", (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @
             [Util.option_map v.content_m_d5
                (fun f ->
                   Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "ReplicationConfiguration"
                  ([],
                    (ReplicationConfiguration.to_xml
                       v.replication_configuration)))])
           @
           [Util.option_map v.token
              (fun f ->
                 Ezxmlm.make_tag "x-amz-bucket-object-lock-token"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.token (fun f -> ("token", (String.to_json f)));
           Some
             ("replication_configuration",
               (ReplicationConfiguration.to_json v.replication_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        replication_configuration =
          (ReplicationConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "replication_configuration")));
        token = (Util.option_map (Json.lookup j "token") String.of_json)
      }
  end
module RestoreObjectOutput =
  struct
    type t =
      {
      request_charged: RequestCharged.t option ;
      restore_output_path: String.t option }
    let make ?request_charged  ?restore_output_path  () =
      { request_charged; restore_output_path }
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse);
          restore_output_path =
            (Util.option_bind (Xml.member "x-amz-restore-output-path" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.restore_output_path
              (fun f ->
                 Headers.Pair
                   ("x-amz-restore-output-path", (String.to_headers f)));
           Util.option_map v.request_charged
             (fun f ->
                Headers.Pair
                  ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.request_charged
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-charged"
                    ([], (RequestCharged.to_xml f)))])
           @
           [Util.option_map v.restore_output_path
              (fun f ->
                 Ezxmlm.make_tag "x-amz-restore-output-path"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.restore_output_path
              (fun f -> ("restore_output_path", (String.to_json f)));
           Util.option_map v.request_charged
             (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let of_json j =
      {
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json);
        restore_output_path =
          (Util.option_map (Json.lookup j "restore_output_path")
             String.of_json)
      }
  end
module PutBucketEncryptionRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      server_side_encryption_configuration:
        ServerSideEncryptionConfiguration.t }
    let make ~bucket  ?content_m_d5  ~server_side_encryption_configuration 
      () = { bucket; content_m_d5; server_side_encryption_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          server_side_encryption_configuration =
            (Xml.required "ServerSideEncryptionConfiguration"
               (Util.option_bind
                  (Xml.member "ServerSideEncryptionConfiguration" xml)
                  ServerSideEncryptionConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "ServerSideEncryptionConfiguration"
                 ([],
                   (ServerSideEncryptionConfiguration.to_xml
                      v.server_side_encryption_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("server_side_encryption_configuration",
                (ServerSideEncryptionConfiguration.to_json
                   v.server_side_encryption_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        server_side_encryption_configuration =
          (ServerSideEncryptionConfiguration.of_json
             (Util.of_option_exn
                (Json.lookup j "server_side_encryption_configuration")))
      }
  end
module GetBucketLifecycleOutput =
  struct
    type t = {
      rules: Rules.t }
    let make ?(rules= [])  () = { rules }
    let parse xml = Some { rules = (Util.of_option [] (Rules.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Rule" ([], (Rules.to_xml [x]))))
              v.rules))
    let to_json v =
      `Assoc (Util.list_filter_opt [Some ("rules", (Rules.to_json v.rules))])
    let of_json j =
      { rules = (Rules.of_json (Util.of_option_exn (Json.lookup j "rules")))
      }
  end
module PutBucketLifecycleRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      lifecycle_configuration: LifecycleConfiguration.t option }
    let make ~bucket  ?content_m_d5  ?lifecycle_configuration  () =
      { bucket; content_m_d5; lifecycle_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          lifecycle_configuration =
            (Util.option_bind (Xml.member "LifecycleConfiguration" xml)
               LifecycleConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Util.option_map v.lifecycle_configuration
              (fun f ->
                 Ezxmlm.make_tag "LifecycleConfiguration"
                   ([], (LifecycleConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.lifecycle_configuration
              (fun f ->
                 ("lifecycle_configuration",
                   (LifecycleConfiguration.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        lifecycle_configuration =
          (Util.option_map (Json.lookup j "lifecycle_configuration")
             LifecycleConfiguration.of_json)
      }
  end
module DeleteObjectTaggingOutput =
  struct
    type t = {
      version_id: String.t option }
    let make ?version_id  () = { version_id }
    let parse xml =
      Some
        {
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f ->
                 Headers.Pair ("x-amz-version-id", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.version_id
              (fun f ->
                 Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)))])
    let of_json j =
      {
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json)
      }
  end
module ListPartsRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      max_parts: Integer.t option ;
      part_number_marker: Integer.t option ;
      upload_id: String.t ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?max_parts  ?part_number_marker  ~upload_id 
      ?request_payer  () =
      { bucket; key; max_parts; part_number_marker; upload_id; request_payer
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          max_parts =
            (Util.option_bind (Xml.member "max-parts" xml) Integer.parse);
          part_number_marker =
            (Util.option_bind (Xml.member "part-number-marker" xml)
               Integer.parse);
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)));
           Util.option_map v.part_number_marker
             (fun f ->
                Query.Pair ("part-number-marker", (Integer.to_query f)));
           Util.option_map v.max_parts
             (fun f -> Query.Pair ("max-parts", (Integer.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
               @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
              @
              [Util.option_map v.max_parts
                 (fun f ->
                    Ezxmlm.make_tag "max-parts" ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.part_number_marker
                (fun f ->
                   Ezxmlm.make_tag "part-number-marker"
                     ([], (Integer.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "uploadId" ([], (String.to_xml v.upload_id)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Util.option_map v.part_number_marker
             (fun f -> ("part_number_marker", (Integer.to_json f)));
           Util.option_map v.max_parts
             (fun f -> ("max_parts", (Integer.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        max_parts =
          (Util.option_map (Json.lookup j "max_parts") Integer.of_json);
        part_number_marker =
          (Util.option_map (Json.lookup j "part_number_marker")
             Integer.of_json);
        upload_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "upload_id")));
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module HeadBucketRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module DeleteObjectRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      m_f_a: String.t option ;
      version_id: String.t option ;
      request_payer: RequestPayer.t option ;
      bypass_governance_retention: Boolean.t option }
    let make ~bucket  ~key  ?m_f_a  ?version_id  ?request_payer 
      ?bypass_governance_retention  () =
      {
        bucket;
        key;
        m_f_a;
        version_id;
        request_payer;
        bypass_governance_retention
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          m_f_a =
            (Util.option_bind (Xml.member "x-amz-mfa" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          bypass_governance_retention =
            (Util.option_bind
               (Xml.member "x-amz-bypass-governance-retention" xml)
               Boolean.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.bypass_governance_retention
              (fun f ->
                 Headers.Pair
                   ("x-amz-bypass-governance-retention",
                     (Boolean.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.m_f_a
             (fun f -> Headers.Pair ("x-amz-mfa", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
               @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
              @
              [Util.option_map v.m_f_a
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-mfa" ([], (String.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.request_payer
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-payer"
                    ([], (RequestPayer.to_xml f)))])
           @
           [Util.option_map v.bypass_governance_retention
              (fun f ->
                 Ezxmlm.make_tag "x-amz-bypass-governance-retention"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.bypass_governance_retention
              (fun f -> ("bypass_governance_retention", (Boolean.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.m_f_a (fun f -> ("m_f_a", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        m_f_a = (Util.option_map (Json.lookup j "m_f_a") String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        bypass_governance_retention =
          (Util.option_map (Json.lookup j "bypass_governance_retention")
             Boolean.of_json)
      }
  end
module GetBucketTaggingRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module AbortMultipartUploadRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      upload_id: String.t ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ~upload_id  ?request_payer  () =
      { bucket; key; upload_id; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Some
               (Ezxmlm.make_tag "uploadId" ([], (String.to_xml v.upload_id)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        upload_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "upload_id")));
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module GetBucketLocationOutput =
  struct
    type t = {
      location_constraint: BucketLocationConstraint.t option }
    let make ?location_constraint  () = { location_constraint }
    let parse xml =
      Some
        {
          location_constraint =
            (Util.option_bind (Xml.member "LocationConstraint" xml)
               BucketLocationConstraint.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.location_constraint
              (fun f ->
                 Ezxmlm.make_tag "LocationConstraint"
                   ([], (BucketLocationConstraint.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.location_constraint
              (fun f ->
                 ("location_constraint",
                   (BucketLocationConstraint.to_json f)))])
    let of_json j =
      {
        location_constraint =
          (Util.option_map (Json.lookup j "location_constraint")
             BucketLocationConstraint.of_json)
      }
  end
module PutObjectTaggingOutput =
  struct
    type t = {
      version_id: String.t option }
    let make ?version_id  () = { version_id }
    let parse xml =
      Some
        {
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f ->
                 Headers.Pair ("x-amz-version-id", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.version_id
              (fun f ->
                 Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)))])
    let of_json j =
      {
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json)
      }
  end
module GetBucketPolicyRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketVersioningRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module ListBucketAnalyticsConfigurationsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option ;
      continuation_token: String.t option ;
      next_continuation_token: String.t option ;
      analytics_configuration_list: AnalyticsConfigurationList.t }
    let make ?is_truncated  ?continuation_token  ?next_continuation_token 
      ?(analytics_configuration_list= [])  () =
      {
        is_truncated;
        continuation_token;
        next_continuation_token;
        analytics_configuration_list
      }
    let parse xml =
      Some
        {
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          continuation_token =
            (Util.option_bind (Xml.member "ContinuationToken" xml)
               String.parse);
          next_continuation_token =
            (Util.option_bind (Xml.member "NextContinuationToken" xml)
               String.parse);
          analytics_configuration_list =
            (Util.of_option [] (AnalyticsConfigurationList.parse xml))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.is_truncated
                 (fun f ->
                    Ezxmlm.make_tag "IsTruncated" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.continuation_token
                (fun f ->
                   Ezxmlm.make_tag "ContinuationToken"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.next_continuation_token
               (fun f ->
                  Ezxmlm.make_tag "NextContinuationToken"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AnalyticsConfiguration"
                      ([], (AnalyticsConfigurationList.to_xml [x]))))
              v.analytics_configuration_list))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("analytics_configuration_list",
                (AnalyticsConfigurationList.to_json
                   v.analytics_configuration_list));
           Util.option_map v.next_continuation_token
             (fun f -> ("next_continuation_token", (String.to_json f)));
           Util.option_map v.continuation_token
             (fun f -> ("continuation_token", (String.to_json f)));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)))])
    let of_json j =
      {
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json);
        next_continuation_token =
          (Util.option_map (Json.lookup j "next_continuation_token")
             String.of_json);
        analytics_configuration_list =
          (AnalyticsConfigurationList.of_json
             (Util.of_option_exn
                (Json.lookup j "analytics_configuration_list")))
      }
  end
module GetObjectLockConfigurationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetObjectTaggingOutput =
  struct
    type t = {
      version_id: String.t option ;
      tag_set: TagSet.t }
    let make ?version_id  ~tag_set  () = { version_id; tag_set }
    let parse xml =
      Some
        {
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          tag_set =
            (Xml.required "TagSet"
               (Util.option_bind (Xml.member "TagSet" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f ->
                 Headers.Pair ("x-amz-version-id", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.version_id
               (fun f ->
                  Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagSet" ([], (TagSet.to_xml [x]))))
              v.tag_set))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tag_set", (TagSet.to_json v.tag_set));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)))])
    let of_json j =
      {
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        tag_set =
          (TagSet.of_json (Util.of_option_exn (Json.lookup j "tag_set")))
      }
  end
module NoSuchBucket =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module ObjectAlreadyInActiveTierError =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module GetBucketLifecycleConfigurationOutput =
  struct
    type t = {
      rules: LifecycleRules.t }
    let make ?(rules= [])  () = { rules }
    let parse xml =
      Some { rules = (Util.of_option [] (LifecycleRules.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "Rule" ([], (LifecycleRules.to_xml [x]))))
              v.rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("rules", (LifecycleRules.to_json v.rules))])
    let of_json j =
      {
        rules =
          (LifecycleRules.of_json
             (Util.of_option_exn (Json.lookup j "rules")))
      }
  end
module PutBucketMetricsConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      id: String.t ;
      metrics_configuration: MetricsConfiguration.t }
    let make ~bucket  ~id  ~metrics_configuration  () =
      { bucket; id; metrics_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse));
          metrics_configuration =
            (Xml.required "MetricsConfiguration"
               (Util.option_bind (Xml.member "MetricsConfiguration" xml)
                  MetricsConfiguration.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
           @
           [Some
              (Ezxmlm.make_tag "MetricsConfiguration"
                 ([], (MetricsConfiguration.to_xml v.metrics_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("metrics_configuration",
                (MetricsConfiguration.to_json v.metrics_configuration));
           Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")));
        metrics_configuration =
          (MetricsConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "metrics_configuration")))
      }
  end
module GetBucketLocationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketPolicyOutput =
  struct
    type t = {
      policy: String.t option }
    let make ?policy  () = { policy }
    let parse xml =
      Some
        { policy = (Util.option_bind (Xml.member "Policy" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.policy
              (fun f -> Ezxmlm.make_tag "Policy" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.policy
              (fun f -> ("policy", (String.to_json f)))])
    let of_json j =
      { policy = (Util.option_map (Json.lookup j "policy") String.of_json) }
  end
module RestoreObjectRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option ;
      restore_request: RestoreRequest.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?version_id  ?restore_request  ?request_payer  ()
      = { bucket; key; version_id; restore_request; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          restore_request =
            (Util.option_bind (Xml.member "RestoreRequest" xml)
               RestoreRequest.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.restore_request
               (fun f ->
                  Ezxmlm.make_tag "RestoreRequest"
                    ([], (RestoreRequest.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.restore_request
             (fun f -> ("restore_request", (RestoreRequest.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        restore_request =
          (Util.option_map (Json.lookup j "restore_request")
             RestoreRequest.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module ListObjectVersionsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option ;
      key_marker: String.t option ;
      version_id_marker: String.t option ;
      next_key_marker: String.t option ;
      next_version_id_marker: String.t option ;
      versions: ObjectVersionList.t ;
      delete_markers: DeleteMarkers.t ;
      name: String.t option ;
      prefix: String.t option ;
      delimiter: String.t option ;
      max_keys: Integer.t option ;
      common_prefixes: CommonPrefixList.t ;
      encoding_type: EncodingType.t option }
    let make ?is_truncated  ?key_marker  ?version_id_marker  ?next_key_marker
       ?next_version_id_marker  ?(versions= [])  ?(delete_markers= [])  ?name
       ?prefix  ?delimiter  ?max_keys  ?(common_prefixes= [])  ?encoding_type
       () =
      {
        is_truncated;
        key_marker;
        version_id_marker;
        next_key_marker;
        next_version_id_marker;
        versions;
        delete_markers;
        name;
        prefix;
        delimiter;
        max_keys;
        common_prefixes;
        encoding_type
      }
    let parse xml =
      Some
        {
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          key_marker =
            (Util.option_bind (Xml.member "KeyMarker" xml) String.parse);
          version_id_marker =
            (Util.option_bind (Xml.member "VersionIdMarker" xml) String.parse);
          next_key_marker =
            (Util.option_bind (Xml.member "NextKeyMarker" xml) String.parse);
          next_version_id_marker =
            (Util.option_bind (Xml.member "NextVersionIdMarker" xml)
               String.parse);
          versions = (Util.of_option [] (ObjectVersionList.parse xml));
          delete_markers = (Util.of_option [] (DeleteMarkers.parse xml));
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          delimiter =
            (Util.option_bind (Xml.member "Delimiter" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "MaxKeys" xml) Integer.parse);
          common_prefixes = (Util.of_option [] (CommonPrefixList.parse xml));
          encoding_type =
            (Util.option_bind (Xml.member "EncodingType" xml)
               EncodingType.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Util.option_map v.is_truncated
                          (fun f ->
                             Ezxmlm.make_tag "IsTruncated"
                               ([], (Boolean.to_xml f)))])
                      @
                      [Util.option_map v.key_marker
                         (fun f ->
                            Ezxmlm.make_tag "KeyMarker"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.version_id_marker
                        (fun f ->
                           Ezxmlm.make_tag "VersionIdMarker"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.next_key_marker
                       (fun f ->
                          Ezxmlm.make_tag "NextKeyMarker"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.next_version_id_marker
                      (fun f ->
                         Ezxmlm.make_tag "NextVersionIdMarker"
                           ([], (String.to_xml f)))])
                  @
                  (List.map
                     (fun x ->
                        Some
                          (Ezxmlm.make_tag "Version"
                             ([], (ObjectVersionList.to_xml [x]))))
                     v.versions))
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "DeleteMarker"
                            ([], (DeleteMarkers.to_xml [x]))))
                    v.delete_markers))
                @
                [Util.option_map v.name
                   (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
               @
               [Util.option_map v.prefix
                  (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
              @
              [Util.option_map v.delimiter
                 (fun f ->
                    Ezxmlm.make_tag "Delimiter" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_keys
                (fun f -> Ezxmlm.make_tag "MaxKeys" ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "CommonPrefixes"
                       ([], (CommonPrefixList.to_xml [x]))))
               v.common_prefixes))
           @
           [Util.option_map v.encoding_type
              (fun f ->
                 Ezxmlm.make_tag "EncodingType" ([], (EncodingType.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.encoding_type
              (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Some
             ("common_prefixes",
               (CommonPrefixList.to_json v.common_prefixes));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Some ("delete_markers", (DeleteMarkers.to_json v.delete_markers));
           Some ("versions", (ObjectVersionList.to_json v.versions));
           Util.option_map v.next_version_id_marker
             (fun f -> ("next_version_id_marker", (String.to_json f)));
           Util.option_map v.next_key_marker
             (fun f -> ("next_key_marker", (String.to_json f)));
           Util.option_map v.version_id_marker
             (fun f -> ("version_id_marker", (String.to_json f)));
           Util.option_map v.key_marker
             (fun f -> ("key_marker", (String.to_json f)));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)))])
    let of_json j =
      {
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        key_marker =
          (Util.option_map (Json.lookup j "key_marker") String.of_json);
        version_id_marker =
          (Util.option_map (Json.lookup j "version_id_marker") String.of_json);
        next_key_marker =
          (Util.option_map (Json.lookup j "next_key_marker") String.of_json);
        next_version_id_marker =
          (Util.option_map (Json.lookup j "next_version_id_marker")
             String.of_json);
        versions =
          (ObjectVersionList.of_json
             (Util.of_option_exn (Json.lookup j "versions")));
        delete_markers =
          (DeleteMarkers.of_json
             (Util.of_option_exn (Json.lookup j "delete_markers")));
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        max_keys =
          (Util.option_map (Json.lookup j "max_keys") Integer.of_json);
        common_prefixes =
          (CommonPrefixList.of_json
             (Util.of_option_exn (Json.lookup j "common_prefixes")));
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json)
      }
  end
module ObjectNotInActiveTierError =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module PutBucketVersioningRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      m_f_a: String.t option ;
      versioning_configuration: VersioningConfiguration.t }
    let make ~bucket  ?content_m_d5  ?m_f_a  ~versioning_configuration  () =
      { bucket; content_m_d5; m_f_a; versioning_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          m_f_a =
            (Util.option_bind (Xml.member "x-amz-mfa" xml) String.parse);
          versioning_configuration =
            (Xml.required "VersioningConfiguration"
               (Util.option_bind (Xml.member "VersioningConfiguration" xml)
                  VersioningConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.m_f_a
              (fun f -> Headers.Pair ("x-amz-mfa", (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @
             [Util.option_map v.content_m_d5
                (fun f ->
                   Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
            @
            [Util.option_map v.m_f_a
               (fun f -> Ezxmlm.make_tag "x-amz-mfa" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "VersioningConfiguration"
                 ([],
                   (VersioningConfiguration.to_xml v.versioning_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("versioning_configuration",
                (VersioningConfiguration.to_json v.versioning_configuration));
           Util.option_map v.m_f_a (fun f -> ("m_f_a", (String.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        m_f_a = (Util.option_map (Json.lookup j "m_f_a") String.of_json);
        versioning_configuration =
          (VersioningConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "versioning_configuration")))
      }
  end
module PutBucketRequestPaymentRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      request_payment_configuration: RequestPaymentConfiguration.t }
    let make ~bucket  ?content_m_d5  ~request_payment_configuration  () =
      { bucket; content_m_d5; request_payment_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          request_payment_configuration =
            (Xml.required "RequestPaymentConfiguration"
               (Util.option_bind
                  (Xml.member "RequestPaymentConfiguration" xml)
                  RequestPaymentConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "RequestPaymentConfiguration"
                 ([],
                   (RequestPaymentConfiguration.to_xml
                      v.request_payment_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("request_payment_configuration",
                (RequestPaymentConfiguration.to_json
                   v.request_payment_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        request_payment_configuration =
          (RequestPaymentConfiguration.of_json
             (Util.of_option_exn
                (Json.lookup j "request_payment_configuration")))
      }
  end
module NoSuchKey =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module DeleteBucketMetricsConfigurationRequest =
  struct
    type t = {
      bucket: String.t ;
      id: String.t }
    let make ~bucket  ~id  () = { bucket; id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")))
      }
  end
module GetBucketInventoryConfigurationRequest =
  struct
    type t = {
      bucket: String.t ;
      id: String.t }
    let make ~bucket  ~id  () = { bucket; id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")))
      }
  end
module PutObjectLockConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      object_lock_configuration: ObjectLockConfiguration.t option ;
      request_payer: RequestPayer.t option ;
      token: String.t option ;
      content_m_d5: String.t option }
    let make ~bucket  ?object_lock_configuration  ?request_payer  ?token 
      ?content_m_d5  () =
      { bucket; object_lock_configuration; request_payer; token; content_m_d5
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          object_lock_configuration =
            (Util.option_bind (Xml.member "ObjectLockConfiguration" xml)
               ObjectLockConfiguration.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          token =
            (Util.option_bind
               (Xml.member "x-amz-bucket-object-lock-token" xml) String.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.token
             (fun f ->
                Headers.Pair
                  ("x-amz-bucket-object-lock-token", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @
              [Util.option_map v.object_lock_configuration
                 (fun f ->
                    Ezxmlm.make_tag "ObjectLockConfiguration"
                      ([], (ObjectLockConfiguration.to_xml f)))])
             @
             [Util.option_map v.request_payer
                (fun f ->
                   Ezxmlm.make_tag "x-amz-request-payer"
                     ([], (RequestPayer.to_xml f)))])
            @
            [Util.option_map v.token
               (fun f ->
                  Ezxmlm.make_tag "x-amz-bucket-object-lock-token"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.token (fun f -> ("token", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.object_lock_configuration
             (fun f ->
                ("object_lock_configuration",
                  (ObjectLockConfiguration.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        object_lock_configuration =
          (Util.option_map (Json.lookup j "object_lock_configuration")
             ObjectLockConfiguration.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        token = (Util.option_map (Json.lookup j "token") String.of_json);
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json)
      }
  end
module DeleteObjectOutput =
  struct
    type t =
      {
      delete_marker: Boolean.t option ;
      version_id: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?delete_marker  ?version_id  ?request_charged  () =
      { delete_marker; version_id; request_charged }
    let parse xml =
      Some
        {
          delete_marker =
            (Util.option_bind (Xml.member "x-amz-delete-marker" xml)
               Boolean.parse);
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.version_id
             (fun f ->
                Headers.Pair ("x-amz-version-id", (String.to_headers f)));
           Util.option_map v.delete_marker
             (fun f ->
                Headers.Pair ("x-amz-delete-marker", (Boolean.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.delete_marker
                (fun f ->
                   Ezxmlm.make_tag "x-amz-delete-marker"
                     ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.version_id
               (fun f ->
                  Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.delete_marker
             (fun f -> ("delete_marker", (Boolean.to_json f)))])
    let of_json j =
      {
        delete_marker =
          (Util.option_map (Json.lookup j "delete_marker") Boolean.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module DeleteBucketReplicationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module CompleteMultipartUploadOutput =
  struct
    type t =
      {
      location: String.t option ;
      bucket: String.t option ;
      key: String.t option ;
      expiration: String.t option ;
      e_tag: String.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      version_id: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?location  ?bucket  ?key  ?expiration  ?e_tag 
      ?server_side_encryption  ?version_id  ?s_s_e_k_m_s_key_id 
      ?request_charged  () =
      {
        location;
        bucket;
        key;
        expiration;
        e_tag;
        server_side_encryption;
        version_id;
        s_s_e_k_m_s_key_id;
        request_charged
      }
    let parse xml =
      Some
        {
          location =
            (Util.option_bind (Xml.member "Location" xml) String.parse);
          bucket = (Util.option_bind (Xml.member "Bucket" xml) String.parse);
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          expiration =
            (Util.option_bind (Xml.member "x-amz-expiration" xml)
               String.parse);
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.version_id
             (fun f ->
                Headers.Pair ("x-amz-version-id", (String.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.expiration
             (fun f ->
                Headers.Pair ("x-amz-expiration", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.location
                      (fun f ->
                         Ezxmlm.make_tag "Location" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.bucket
                     (fun f ->
                        Ezxmlm.make_tag "Bucket" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.key
                    (fun f -> Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
                @
                [Util.option_map v.expiration
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-expiration"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.e_tag
                  (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
              @
              [Util.option_map v.server_side_encryption
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-server-side-encryption"
                      ([], (ServerSideEncryption.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f ->
                   Ezxmlm.make_tag "x-amz-version-id" ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_k_m_s_key_id
               (fun f ->
                  Ezxmlm.make_tag
                    "x-amz-server-side-encryption-aws-kms-key-id"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)));
           Util.option_map v.bucket (fun f -> ("bucket", (String.to_json f)));
           Util.option_map v.location
             (fun f -> ("location", (String.to_json f)))])
    let of_json j =
      {
        location =
          (Util.option_map (Json.lookup j "location") String.of_json);
        bucket = (Util.option_map (Json.lookup j "bucket") String.of_json);
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        expiration =
          (Util.option_map (Json.lookup j "expiration") String.of_json);
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module PutObjectTaggingRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option ;
      content_m_d5: String.t option ;
      tagging: Tagging.t }
    let make ~bucket  ~key  ?version_id  ?content_m_d5  ~tagging  () =
      { bucket; key; version_id; content_m_d5; tagging }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          tagging =
            (Xml.required "Tagging"
               (Util.option_bind (Xml.member "Tagging" xml) Tagging.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some (Ezxmlm.make_tag "Tagging" ([], (Tagging.to_xml v.tagging)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tagging", (Tagging.to_json v.tagging));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        tagging =
          (Tagging.of_json (Util.of_option_exn (Json.lookup j "tagging")))
      }
  end
module GetBucketAclOutput =
  struct
    type t = {
      owner: Owner.t option ;
      grants: Grants.t }
    let make ?owner  ?(grants= [])  () = { owner; grants }
    let parse xml =
      Some
        {
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse);
          grants =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccessControlList" xml)
                  Grants.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.owner
               (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "AccessControlList"
                      ([], (Grants.to_xml [x])))) v.grants))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("grants", (Grants.to_json v.grants));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)))])
    let of_json j =
      {
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json);
        grants =
          (Grants.of_json (Util.of_option_exn (Json.lookup j "grants")))
      }
  end
module GetObjectAclOutput =
  struct
    type t =
      {
      owner: Owner.t option ;
      grants: Grants.t ;
      request_charged: RequestCharged.t option }
    let make ?owner  ?(grants= [])  ?request_charged  () =
      { owner; grants; request_charged }
    let parse xml =
      Some
        {
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse);
          grants =
            (Util.of_option []
               (Util.option_bind (Xml.member "AccessControlList" xml)
                  Grants.parse));
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Util.option_map v.owner
                (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "AccessControlList"
                       ([], (Grants.to_xml [x])))) v.grants))
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Some ("grants", (Grants.to_json v.grants));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)))])
    let of_json j =
      {
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json);
        grants =
          (Grants.of_json (Util.of_option_exn (Json.lookup j "grants")));
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketRequestPaymentRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module DeleteObjectsRequest =
  struct
    type t =
      {
      bucket: String.t ;
      delete: Delete.t ;
      m_f_a: String.t option ;
      request_payer: RequestPayer.t option ;
      bypass_governance_retention: Boolean.t option }
    let make ~bucket  ~delete  ?m_f_a  ?request_payer 
      ?bypass_governance_retention  () =
      { bucket; delete; m_f_a; request_payer; bypass_governance_retention }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          delete =
            (Xml.required "Delete"
               (Util.option_bind (Xml.member "Delete" xml) Delete.parse));
          m_f_a =
            (Util.option_bind (Xml.member "x-amz-mfa" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          bypass_governance_retention =
            (Util.option_bind
               (Xml.member "x-amz-bypass-governance-retention" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.bypass_governance_retention
              (fun f ->
                 Headers.Pair
                   ("x-amz-bypass-governance-retention",
                     (Boolean.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.m_f_a
             (fun f -> Headers.Pair ("x-amz-mfa", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @
              [Some (Ezxmlm.make_tag "Delete" ([], (Delete.to_xml v.delete)))])
             @
             [Util.option_map v.m_f_a
                (fun f -> Ezxmlm.make_tag "x-amz-mfa" ([], (String.to_xml f)))])
            @
            [Util.option_map v.request_payer
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-payer"
                    ([], (RequestPayer.to_xml f)))])
           @
           [Util.option_map v.bypass_governance_retention
              (fun f ->
                 Ezxmlm.make_tag "x-amz-bypass-governance-retention"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.bypass_governance_retention
              (fun f -> ("bypass_governance_retention", (Boolean.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.m_f_a (fun f -> ("m_f_a", (String.to_json f)));
           Some ("delete", (Delete.to_json v.delete));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        delete =
          (Delete.of_json (Util.of_option_exn (Json.lookup j "delete")));
        m_f_a = (Util.option_map (Json.lookup j "m_f_a") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        bypass_governance_retention =
          (Util.option_map (Json.lookup j "bypass_governance_retention")
             Boolean.of_json)
      }
  end
module UploadPartOutput =
  struct
    type t =
      {
      server_side_encryption: ServerSideEncryption.t option ;
      e_tag: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?server_side_encryption  ?e_tag  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id  ?request_charged  () =
      {
        server_side_encryption;
        e_tag;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        request_charged
      }
    let parse xml =
      Some
        {
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.e_tag
             (fun f -> Headers.Pair ("ETag", (String.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Util.option_map v.server_side_encryption
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-server-side-encryption"
                        ([], (ServerSideEncryption.to_xml f)))])
               @
               [Util.option_map v.e_tag
                  (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_algorithm
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-algorithm"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_customer_key_m_d5
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-customer-key-MD5"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_k_m_s_key_id
               (fun f ->
                  Ezxmlm.make_tag
                    "x-amz-server-side-encryption-aws-kms-key-id"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)))])
    let of_json j =
      {
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module UploadPartCopyRequest =
  struct
    type t =
      {
      bucket: String.t ;
      copy_source: String.t ;
      copy_source_if_match: String.t option ;
      copy_source_if_modified_since: DateTime.t option ;
      copy_source_if_none_match: String.t option ;
      copy_source_if_unmodified_since: DateTime.t option ;
      copy_source_range: String.t option ;
      key: String.t ;
      part_number: Integer.t ;
      upload_id: String.t ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      copy_source_s_s_e_customer_algorithm: String.t option ;
      copy_source_s_s_e_customer_key: String.t option ;
      copy_source_s_s_e_customer_key_m_d5: String.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~copy_source  ?copy_source_if_match 
      ?copy_source_if_modified_since  ?copy_source_if_none_match 
      ?copy_source_if_unmodified_since  ?copy_source_range  ~key 
      ~part_number  ~upload_id  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key  ?s_s_e_customer_key_m_d5 
      ?copy_source_s_s_e_customer_algorithm  ?copy_source_s_s_e_customer_key 
      ?copy_source_s_s_e_customer_key_m_d5  ?request_payer  () =
      {
        bucket;
        copy_source;
        copy_source_if_match;
        copy_source_if_modified_since;
        copy_source_if_none_match;
        copy_source_if_unmodified_since;
        copy_source_range;
        key;
        part_number;
        upload_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        copy_source_s_s_e_customer_algorithm;
        copy_source_s_s_e_customer_key;
        copy_source_s_s_e_customer_key_m_d5;
        request_payer
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          copy_source =
            (Xml.required "x-amz-copy-source"
               (Util.option_bind (Xml.member "x-amz-copy-source" xml)
                  String.parse));
          copy_source_if_match =
            (Util.option_bind (Xml.member "x-amz-copy-source-if-match" xml)
               String.parse);
          copy_source_if_modified_since =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-modified-since" xml)
               DateTime.parse);
          copy_source_if_none_match =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-none-match" xml)
               String.parse);
          copy_source_if_unmodified_since =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-unmodified-since" xml)
               DateTime.parse);
          copy_source_range =
            (Util.option_bind (Xml.member "x-amz-copy-source-range" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          part_number =
            (Xml.required "partNumber"
               (Util.option_bind (Xml.member "partNumber" xml) Integer.parse));
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          copy_source_s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          copy_source_s_s_e_customer_key =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-key" xml)
               String.parse);
          copy_source_s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)));
           Some (Query.Pair ("partNumber", (Integer.to_query v.part_number)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.copy_source_range
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-range", (String.to_headers f)));
           Util.option_map v.copy_source_if_unmodified_since
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-unmodified-since",
                    (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_none_match
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-none-match", (String.to_headers f)));
           Util.option_map v.copy_source_if_modified_since
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-modified-since",
                    (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_match
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-match", (String.to_headers f)));
           Some
             (Headers.Pair
                ("x-amz-copy-source", (String.to_headers v.copy_source)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((([] @
                           [Some
                              (Ezxmlm.make_tag "Bucket"
                                 ([], (String.to_xml v.bucket)))])
                          @
                          [Some
                             (Ezxmlm.make_tag "x-amz-copy-source"
                                ([], (String.to_xml v.copy_source)))])
                         @
                         [Util.option_map v.copy_source_if_match
                            (fun f ->
                               Ezxmlm.make_tag "x-amz-copy-source-if-match"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.copy_source_if_modified_since
                           (fun f ->
                              Ezxmlm.make_tag
                                "x-amz-copy-source-if-modified-since"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.copy_source_if_none_match
                          (fun f ->
                             Ezxmlm.make_tag
                               "x-amz-copy-source-if-none-match"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.copy_source_if_unmodified_since
                         (fun f ->
                            Ezxmlm.make_tag
                              "x-amz-copy-source-if-unmodified-since"
                              ([], (DateTime.to_xml f)))])
                     @
                     [Util.option_map v.copy_source_range
                        (fun f ->
                           Ezxmlm.make_tag "x-amz-copy-source-range"
                             ([], (String.to_xml f)))])
                    @
                    [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                   @
                   [Some
                      (Ezxmlm.make_tag "partNumber"
                         ([], (Integer.to_xml v.part_number)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "uploadId"
                        ([], (String.to_xml v.upload_id)))])
                 @
                 [Util.option_map v.s_s_e_customer_algorithm
                    (fun f ->
                       Ezxmlm.make_tag
                         "x-amz-server-side-encryption-customer-algorithm"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.s_s_e_customer_key
                   (fun f ->
                      Ezxmlm.make_tag
                        "x-amz-server-side-encryption-customer-key"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.s_s_e_customer_key_m_d5
                  (fun f ->
                     Ezxmlm.make_tag
                       "x-amz-server-side-encryption-customer-key-MD5"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.copy_source_s_s_e_customer_algorithm
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-copy-source-server-side-encryption-customer-algorithm"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.copy_source_s_s_e_customer_key
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-copy-source-server-side-encryption-customer-key"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.copy_source_s_s_e_customer_key_m_d5
               (fun f ->
                  Ezxmlm.make_tag
                    "x-amz-copy-source-server-side-encryption-customer-key-MD5"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                ("copy_source_s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f -> ("copy_source_s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                ("copy_source_s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Some ("part_number", (Integer.to_json v.part_number));
           Some ("key", (String.to_json v.key));
           Util.option_map v.copy_source_range
             (fun f -> ("copy_source_range", (String.to_json f)));
           Util.option_map v.copy_source_if_unmodified_since
             (fun f ->
                ("copy_source_if_unmodified_since", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_none_match
             (fun f -> ("copy_source_if_none_match", (String.to_json f)));
           Util.option_map v.copy_source_if_modified_since
             (fun f ->
                ("copy_source_if_modified_since", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_match
             (fun f -> ("copy_source_if_match", (String.to_json f)));
           Some ("copy_source", (String.to_json v.copy_source));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        copy_source =
          (String.of_json (Util.of_option_exn (Json.lookup j "copy_source")));
        copy_source_if_match =
          (Util.option_map (Json.lookup j "copy_source_if_match")
             String.of_json);
        copy_source_if_modified_since =
          (Util.option_map (Json.lookup j "copy_source_if_modified_since")
             DateTime.of_json);
        copy_source_if_none_match =
          (Util.option_map (Json.lookup j "copy_source_if_none_match")
             String.of_json);
        copy_source_if_unmodified_since =
          (Util.option_map (Json.lookup j "copy_source_if_unmodified_since")
             DateTime.of_json);
        copy_source_range =
          (Util.option_map (Json.lookup j "copy_source_range") String.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        part_number =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "part_number")));
        upload_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "upload_id")));
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        copy_source_s_s_e_customer_algorithm =
          (Util.option_map
             (Json.lookup j "copy_source_s_s_e_customer_algorithm")
             String.of_json);
        copy_source_s_s_e_customer_key =
          (Util.option_map (Json.lookup j "copy_source_s_s_e_customer_key")
             String.of_json);
        copy_source_s_s_e_customer_key_m_d5 =
          (Util.option_map
             (Json.lookup j "copy_source_s_s_e_customer_key_m_d5")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module ListBucketInventoryConfigurationsOutput =
  struct
    type t =
      {
      continuation_token: String.t option ;
      inventory_configuration_list: InventoryConfigurationList.t ;
      is_truncated: Boolean.t option ;
      next_continuation_token: String.t option }
    let make ?continuation_token  ?(inventory_configuration_list= []) 
      ?is_truncated  ?next_continuation_token  () =
      {
        continuation_token;
        inventory_configuration_list;
        is_truncated;
        next_continuation_token
      }
    let parse xml =
      Some
        {
          continuation_token =
            (Util.option_bind (Xml.member "ContinuationToken" xml)
               String.parse);
          inventory_configuration_list =
            (Util.of_option [] (InventoryConfigurationList.parse xml));
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          next_continuation_token =
            (Util.option_bind (Xml.member "NextContinuationToken" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.continuation_token
                 (fun f ->
                    Ezxmlm.make_tag "ContinuationToken"
                      ([], (String.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "InventoryConfiguration"
                        ([], (InventoryConfigurationList.to_xml [x]))))
                v.inventory_configuration_list))
            @
            [Util.option_map v.is_truncated
               (fun f ->
                  Ezxmlm.make_tag "IsTruncated" ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.next_continuation_token
              (fun f ->
                 Ezxmlm.make_tag "NextContinuationToken"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.next_continuation_token
              (fun f -> ("next_continuation_token", (String.to_json f)));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)));
           Some
             ("inventory_configuration_list",
               (InventoryConfigurationList.to_json
                  v.inventory_configuration_list));
           Util.option_map v.continuation_token
             (fun f -> ("continuation_token", (String.to_json f)))])
    let of_json j =
      {
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json);
        inventory_configuration_list =
          (InventoryConfigurationList.of_json
             (Util.of_option_exn
                (Json.lookup j "inventory_configuration_list")));
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        next_continuation_token =
          (Util.option_map (Json.lookup j "next_continuation_token")
             String.of_json)
      }
  end
module PutObjectLockConfigurationOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let of_json j =
      {
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketLoggingOutput =
  struct
    type t = {
      logging_enabled: LoggingEnabled.t option }
    let make ?logging_enabled  () = { logging_enabled }
    let parse xml =
      Some
        {
          logging_enabled =
            (Util.option_bind (Xml.member "LoggingEnabled" xml)
               LoggingEnabled.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.logging_enabled
              (fun f ->
                 Ezxmlm.make_tag "LoggingEnabled"
                   ([], (LoggingEnabled.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.logging_enabled
              (fun f -> ("logging_enabled", (LoggingEnabled.to_json f)))])
    let of_json j =
      {
        logging_enabled =
          (Util.option_map (Json.lookup j "logging_enabled")
             LoggingEnabled.of_json)
      }
  end
module NoSuchUpload =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module GetBucketVersioningOutput =
  struct
    type t =
      {
      status: BucketVersioningStatus.t option ;
      m_f_a_delete: MFADeleteStatus.t option }
    let make ?status  ?m_f_a_delete  () = { status; m_f_a_delete }
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketVersioningStatus.parse);
          m_f_a_delete =
            (Util.option_bind (Xml.member "MfaDelete" xml)
               MFADeleteStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.status
               (fun f ->
                  Ezxmlm.make_tag "Status"
                    ([], (BucketVersioningStatus.to_xml f)))])
           @
           [Util.option_map v.m_f_a_delete
              (fun f ->
                 Ezxmlm.make_tag "MfaDelete" ([], (MFADeleteStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.m_f_a_delete
              (fun f -> ("m_f_a_delete", (MFADeleteStatus.to_json f)));
           Util.option_map v.status
             (fun f -> ("status", (BucketVersioningStatus.to_json f)))])
    let of_json j =
      {
        status =
          (Util.option_map (Json.lookup j "status")
             BucketVersioningStatus.of_json);
        m_f_a_delete =
          (Util.option_map (Json.lookup j "m_f_a_delete")
             MFADeleteStatus.of_json)
      }
  end
module PutBucketAnalyticsConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      id: String.t ;
      analytics_configuration: AnalyticsConfiguration.t }
    let make ~bucket  ~id  ~analytics_configuration  () =
      { bucket; id; analytics_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse));
          analytics_configuration =
            (Xml.required "AnalyticsConfiguration"
               (Util.option_bind (Xml.member "AnalyticsConfiguration" xml)
                  AnalyticsConfiguration.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
           @
           [Some
              (Ezxmlm.make_tag "AnalyticsConfiguration"
                 ([],
                   (AnalyticsConfiguration.to_xml v.analytics_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("analytics_configuration",
                (AnalyticsConfiguration.to_json v.analytics_configuration));
           Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")));
        analytics_configuration =
          (AnalyticsConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "analytics_configuration")))
      }
  end
module CopyObjectRequest =
  struct
    type t =
      {
      a_c_l: ObjectCannedACL.t option ;
      bucket: String.t ;
      cache_control: String.t option ;
      content_disposition: String.t option ;
      content_encoding: String.t option ;
      content_language: String.t option ;
      content_type: String.t option ;
      copy_source: String.t ;
      copy_source_if_match: String.t option ;
      copy_source_if_modified_since: DateTime.t option ;
      copy_source_if_none_match: String.t option ;
      copy_source_if_unmodified_since: DateTime.t option ;
      expires: DateTime.t option ;
      grant_full_control: String.t option ;
      grant_read: String.t option ;
      grant_read_a_c_p: String.t option ;
      grant_write_a_c_p: String.t option ;
      key: String.t ;
      metadata: Metadata.t option ;
      metadata_directive: MetadataDirective.t option ;
      tagging_directive: TaggingDirective.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      storage_class: StorageClass.t option ;
      website_redirect_location: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      s_s_e_k_m_s_encryption_context: String.t option ;
      copy_source_s_s_e_customer_algorithm: String.t option ;
      copy_source_s_s_e_customer_key: String.t option ;
      copy_source_s_s_e_customer_key_m_d5: String.t option ;
      request_payer: RequestPayer.t option ;
      tagging: String.t option ;
      object_lock_mode: ObjectLockMode.t option ;
      object_lock_retain_until_date: DateTime.t option ;
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option }
    let make ?a_c_l  ~bucket  ?cache_control  ?content_disposition 
      ?content_encoding  ?content_language  ?content_type  ~copy_source 
      ?copy_source_if_match  ?copy_source_if_modified_since 
      ?copy_source_if_none_match  ?copy_source_if_unmodified_since  ?expires 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write_a_c_p
       ~key  ?metadata  ?metadata_directive  ?tagging_directive 
      ?server_side_encryption  ?storage_class  ?website_redirect_location 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?copy_source_s_s_e_customer_algorithm 
      ?copy_source_s_s_e_customer_key  ?copy_source_s_s_e_customer_key_m_d5 
      ?request_payer  ?tagging  ?object_lock_mode 
      ?object_lock_retain_until_date  ?object_lock_legal_hold_status  () =
      {
        a_c_l;
        bucket;
        cache_control;
        content_disposition;
        content_encoding;
        content_language;
        content_type;
        copy_source;
        copy_source_if_match;
        copy_source_if_modified_since;
        copy_source_if_none_match;
        copy_source_if_unmodified_since;
        expires;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write_a_c_p;
        key;
        metadata;
        metadata_directive;
        tagging_directive;
        server_side_encryption;
        storage_class;
        website_redirect_location;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        copy_source_s_s_e_customer_algorithm;
        copy_source_s_s_e_customer_key;
        copy_source_s_s_e_customer_key_m_d5;
        request_payer;
        tagging;
        object_lock_mode;
        object_lock_retain_until_date;
        object_lock_legal_hold_status
      }
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               ObjectCannedACL.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          cache_control =
            (Util.option_bind (Xml.member "Cache-Control" xml) String.parse);
          content_disposition =
            (Util.option_bind (Xml.member "Content-Disposition" xml)
               String.parse);
          content_encoding =
            (Util.option_bind (Xml.member "Content-Encoding" xml)
               String.parse);
          content_language =
            (Util.option_bind (Xml.member "Content-Language" xml)
               String.parse);
          content_type =
            (Util.option_bind (Xml.member "Content-Type" xml) String.parse);
          copy_source =
            (Xml.required "x-amz-copy-source"
               (Util.option_bind (Xml.member "x-amz-copy-source" xml)
                  String.parse));
          copy_source_if_match =
            (Util.option_bind (Xml.member "x-amz-copy-source-if-match" xml)
               String.parse);
          copy_source_if_modified_since =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-modified-since" xml)
               DateTime.parse);
          copy_source_if_none_match =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-none-match" xml)
               String.parse);
          copy_source_if_unmodified_since =
            (Util.option_bind
               (Xml.member "x-amz-copy-source-if-unmodified-since" xml)
               DateTime.parse);
          expires =
            (Util.option_bind (Xml.member "Expires" xml) DateTime.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          metadata =
            (Util.option_bind (Xml.member "x-amz-meta-" xml) Metadata.parse);
          metadata_directive =
            (Util.option_bind (Xml.member "x-amz-metadata-directive" xml)
               MetadataDirective.parse);
          tagging_directive =
            (Util.option_bind (Xml.member "x-amz-tagging-directive" xml)
               TaggingDirective.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          storage_class =
            (Util.option_bind (Xml.member "x-amz-storage-class" xml)
               StorageClass.parse);
          website_redirect_location =
            (Util.option_bind
               (Xml.member "x-amz-website-redirect-location" xml)
               String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          copy_source_s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          copy_source_s_s_e_customer_key =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-key" xml)
               String.parse);
          copy_source_s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member
                  "x-amz-copy-source-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          tagging =
            (Util.option_bind (Xml.member "x-amz-tagging" xml) String.parse);
          object_lock_mode =
            (Util.option_bind (Xml.member "x-amz-object-lock-mode" xml)
               ObjectLockMode.parse);
          object_lock_retain_until_date =
            (Util.option_bind
               (Xml.member "x-amz-object-lock-retain-until-date" xml)
               DateTime.parse);
          object_lock_legal_hold_status =
            (Util.option_bind (Xml.member "x-amz-object-lock-legal-hold" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Headers.Pair
                   ("x-amz-object-lock-legal-hold",
                     (ObjectLockLegalHoldStatus.to_headers f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-retain-until-date",
                    (DateTime.to_headers f)));
           Util.option_map v.object_lock_mode
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-mode", (ObjectLockMode.to_headers f)));
           Util.option_map v.tagging
             (fun f -> Headers.Pair ("x-amz-tagging", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.website_redirect_location
             (fun f ->
                Headers.Pair
                  ("x-amz-website-redirect-location", (String.to_headers f)));
           Util.option_map v.storage_class
             (fun f ->
                Headers.Pair
                  ("x-amz-storage-class", (StorageClass.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.tagging_directive
             (fun f ->
                Headers.Pair
                  ("x-amz-tagging-directive",
                    (TaggingDirective.to_headers f)));
           Util.option_map v.metadata_directive
             (fun f ->
                Headers.Pair
                  ("x-amz-metadata-directive",
                    (MetadataDirective.to_headers f)));
           Util.option_map v.metadata
             (fun f -> Headers.Pair ("x-amz-meta-", (Metadata.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.expires
             (fun f -> Headers.Pair ("Expires", (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_unmodified_since
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-unmodified-since",
                    (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_none_match
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-none-match", (String.to_headers f)));
           Util.option_map v.copy_source_if_modified_since
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-modified-since",
                    (DateTime.to_headers f)));
           Util.option_map v.copy_source_if_match
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-if-match", (String.to_headers f)));
           Some
             (Headers.Pair
                ("x-amz-copy-source", (String.to_headers v.copy_source)));
           Util.option_map v.content_type
             (fun f -> Headers.Pair ("Content-Type", (String.to_headers f)));
           Util.option_map v.content_language
             (fun f ->
                Headers.Pair ("Content-Language", (String.to_headers f)));
           Util.option_map v.content_encoding
             (fun f ->
                Headers.Pair ("Content-Encoding", (String.to_headers f)));
           Util.option_map v.content_disposition
             (fun f ->
                Headers.Pair ("Content-Disposition", (String.to_headers f)));
           Util.option_map v.cache_control
             (fun f -> Headers.Pair ("Cache-Control", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (ObjectCannedACL.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((((((((((([] @
                                               [Util.option_map v.a_c_l
                                                  (fun f ->
                                                     Ezxmlm.make_tag
                                                       "x-amz-acl"
                                                       ([],
                                                         (ObjectCannedACL.to_xml
                                                            f)))])
                                              @
                                              [Some
                                                 (Ezxmlm.make_tag "Bucket"
                                                    ([],
                                                      (String.to_xml v.bucket)))])
                                             @
                                             [Util.option_map v.cache_control
                                                (fun f ->
                                                   Ezxmlm.make_tag
                                                     "Cache-Control"
                                                     ([], (String.to_xml f)))])
                                            @
                                            [Util.option_map
                                               v.content_disposition
                                               (fun f ->
                                                  Ezxmlm.make_tag
                                                    "Content-Disposition"
                                                    ([], (String.to_xml f)))])
                                           @
                                           [Util.option_map
                                              v.content_encoding
                                              (fun f ->
                                                 Ezxmlm.make_tag
                                                   "Content-Encoding"
                                                   ([], (String.to_xml f)))])
                                          @
                                          [Util.option_map v.content_language
                                             (fun f ->
                                                Ezxmlm.make_tag
                                                  "Content-Language"
                                                  ([], (String.to_xml f)))])
                                         @
                                         [Util.option_map v.content_type
                                            (fun f ->
                                               Ezxmlm.make_tag "Content-Type"
                                                 ([], (String.to_xml f)))])
                                        @
                                        [Some
                                           (Ezxmlm.make_tag
                                              "x-amz-copy-source"
                                              ([],
                                                (String.to_xml v.copy_source)))])
                                       @
                                       [Util.option_map
                                          v.copy_source_if_match
                                          (fun f ->
                                             Ezxmlm.make_tag
                                               "x-amz-copy-source-if-match"
                                               ([], (String.to_xml f)))])
                                      @
                                      [Util.option_map
                                         v.copy_source_if_modified_since
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "x-amz-copy-source-if-modified-since"
                                              ([], (DateTime.to_xml f)))])
                                     @
                                     [Util.option_map
                                        v.copy_source_if_none_match
                                        (fun f ->
                                           Ezxmlm.make_tag
                                             "x-amz-copy-source-if-none-match"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map
                                       v.copy_source_if_unmodified_since
                                       (fun f ->
                                          Ezxmlm.make_tag
                                            "x-amz-copy-source-if-unmodified-since"
                                            ([], (DateTime.to_xml f)))])
                                   @
                                   [Util.option_map v.expires
                                      (fun f ->
                                         Ezxmlm.make_tag "Expires"
                                           ([], (DateTime.to_xml f)))])
                                  @
                                  [Util.option_map v.grant_full_control
                                     (fun f ->
                                        Ezxmlm.make_tag
                                          "x-amz-grant-full-control"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.grant_read
                                    (fun f ->
                                       Ezxmlm.make_tag "x-amz-grant-read"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.grant_read_a_c_p
                                   (fun f ->
                                      Ezxmlm.make_tag "x-amz-grant-read-acp"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.grant_write_a_c_p
                                  (fun f ->
                                     Ezxmlm.make_tag "x-amz-grant-write-acp"
                                       ([], (String.to_xml f)))])
                              @
                              [Some
                                 (Ezxmlm.make_tag "Key"
                                    ([], (String.to_xml v.key)))])
                             @
                             [Util.option_map v.metadata
                                (fun f ->
                                   Ezxmlm.make_tag "x-amz-meta-"
                                     ([], (Metadata.to_xml f)))])
                            @
                            [Util.option_map v.metadata_directive
                               (fun f ->
                                  Ezxmlm.make_tag "x-amz-metadata-directive"
                                    ([], (MetadataDirective.to_xml f)))])
                           @
                           [Util.option_map v.tagging_directive
                              (fun f ->
                                 Ezxmlm.make_tag "x-amz-tagging-directive"
                                   ([], (TaggingDirective.to_xml f)))])
                          @
                          [Util.option_map v.server_side_encryption
                             (fun f ->
                                Ezxmlm.make_tag
                                  "x-amz-server-side-encryption"
                                  ([], (ServerSideEncryption.to_xml f)))])
                         @
                         [Util.option_map v.storage_class
                            (fun f ->
                               Ezxmlm.make_tag "x-amz-storage-class"
                                 ([], (StorageClass.to_xml f)))])
                        @
                        [Util.option_map v.website_redirect_location
                           (fun f ->
                              Ezxmlm.make_tag
                                "x-amz-website-redirect-location"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.s_s_e_customer_algorithm
                          (fun f ->
                             Ezxmlm.make_tag
                               "x-amz-server-side-encryption-customer-algorithm"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.s_s_e_customer_key
                         (fun f ->
                            Ezxmlm.make_tag
                              "x-amz-server-side-encryption-customer-key"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.s_s_e_customer_key_m_d5
                        (fun f ->
                           Ezxmlm.make_tag
                             "x-amz-server-side-encryption-customer-key-MD5"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.s_s_e_k_m_s_key_id
                       (fun f ->
                          Ezxmlm.make_tag
                            "x-amz-server-side-encryption-aws-kms-key-id"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.s_s_e_k_m_s_encryption_context
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-context"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.copy_source_s_s_e_customer_algorithm
                     (fun f ->
                        Ezxmlm.make_tag
                          "x-amz-copy-source-server-side-encryption-customer-algorithm"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.copy_source_s_s_e_customer_key
                    (fun f ->
                       Ezxmlm.make_tag
                         "x-amz-copy-source-server-side-encryption-customer-key"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.copy_source_s_s_e_customer_key_m_d5
                   (fun f ->
                      Ezxmlm.make_tag
                        "x-amz-copy-source-server-side-encryption-customer-key-MD5"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.request_payer
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-request-payer"
                       ([], (RequestPayer.to_xml f)))])
              @
              [Util.option_map v.tagging
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-tagging" ([], (String.to_xml f)))])
             @
             [Util.option_map v.object_lock_mode
                (fun f ->
                   Ezxmlm.make_tag "x-amz-object-lock-mode"
                     ([], (ObjectLockMode.to_xml f)))])
            @
            [Util.option_map v.object_lock_retain_until_date
               (fun f ->
                  Ezxmlm.make_tag "x-amz-object-lock-retain-until-date"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Ezxmlm.make_tag "x-amz-object-lock-legal-hold"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 ("object_lock_legal_hold_status",
                   (ObjectLockLegalHoldStatus.to_json f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                ("object_lock_retain_until_date", (DateTime.to_json f)));
           Util.option_map v.object_lock_mode
             (fun f -> ("object_lock_mode", (ObjectLockMode.to_json f)));
           Util.option_map v.tagging
             (fun f -> ("tagging", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key_m_d5
             (fun f ->
                ("copy_source_s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_key
             (fun f -> ("copy_source_s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.copy_source_s_s_e_customer_algorithm
             (fun f ->
                ("copy_source_s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.website_redirect_location
             (fun f -> ("website_redirect_location", (String.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.tagging_directive
             (fun f -> ("tagging_directive", (TaggingDirective.to_json f)));
           Util.option_map v.metadata_directive
             (fun f -> ("metadata_directive", (MetadataDirective.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (Metadata.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.expires
             (fun f -> ("expires", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_unmodified_since
             (fun f ->
                ("copy_source_if_unmodified_since", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_none_match
             (fun f -> ("copy_source_if_none_match", (String.to_json f)));
           Util.option_map v.copy_source_if_modified_since
             (fun f ->
                ("copy_source_if_modified_since", (DateTime.to_json f)));
           Util.option_map v.copy_source_if_match
             (fun f -> ("copy_source_if_match", (String.to_json f)));
           Some ("copy_source", (String.to_json v.copy_source));
           Util.option_map v.content_type
             (fun f -> ("content_type", (String.to_json f)));
           Util.option_map v.content_language
             (fun f -> ("content_language", (String.to_json f)));
           Util.option_map v.content_encoding
             (fun f -> ("content_encoding", (String.to_json f)));
           Util.option_map v.content_disposition
             (fun f -> ("content_disposition", (String.to_json f)));
           Util.option_map v.cache_control
             (fun f -> ("cache_control", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (ObjectCannedACL.to_json f)))])
    let of_json j =
      {
        a_c_l =
          (Util.option_map (Json.lookup j "a_c_l") ObjectCannedACL.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        cache_control =
          (Util.option_map (Json.lookup j "cache_control") String.of_json);
        content_disposition =
          (Util.option_map (Json.lookup j "content_disposition")
             String.of_json);
        content_encoding =
          (Util.option_map (Json.lookup j "content_encoding") String.of_json);
        content_language =
          (Util.option_map (Json.lookup j "content_language") String.of_json);
        content_type =
          (Util.option_map (Json.lookup j "content_type") String.of_json);
        copy_source =
          (String.of_json (Util.of_option_exn (Json.lookup j "copy_source")));
        copy_source_if_match =
          (Util.option_map (Json.lookup j "copy_source_if_match")
             String.of_json);
        copy_source_if_modified_since =
          (Util.option_map (Json.lookup j "copy_source_if_modified_since")
             DateTime.of_json);
        copy_source_if_none_match =
          (Util.option_map (Json.lookup j "copy_source_if_none_match")
             String.of_json);
        copy_source_if_unmodified_since =
          (Util.option_map (Json.lookup j "copy_source_if_unmodified_since")
             DateTime.of_json);
        expires =
          (Util.option_map (Json.lookup j "expires") DateTime.of_json);
        grant_full_control =
          (Util.option_map (Json.lookup j "grant_full_control")
             String.of_json);
        grant_read =
          (Util.option_map (Json.lookup j "grant_read") String.of_json);
        grant_read_a_c_p =
          (Util.option_map (Json.lookup j "grant_read_a_c_p") String.of_json);
        grant_write_a_c_p =
          (Util.option_map (Json.lookup j "grant_write_a_c_p") String.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        metadata =
          (Util.option_map (Json.lookup j "metadata") Metadata.of_json);
        metadata_directive =
          (Util.option_map (Json.lookup j "metadata_directive")
             MetadataDirective.of_json);
        tagging_directive =
          (Util.option_map (Json.lookup j "tagging_directive")
             TaggingDirective.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        website_redirect_location =
          (Util.option_map (Json.lookup j "website_redirect_location")
             String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_encryption_context")
             String.of_json);
        copy_source_s_s_e_customer_algorithm =
          (Util.option_map
             (Json.lookup j "copy_source_s_s_e_customer_algorithm")
             String.of_json);
        copy_source_s_s_e_customer_key =
          (Util.option_map (Json.lookup j "copy_source_s_s_e_customer_key")
             String.of_json);
        copy_source_s_s_e_customer_key_m_d5 =
          (Util.option_map
             (Json.lookup j "copy_source_s_s_e_customer_key_m_d5")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        tagging = (Util.option_map (Json.lookup j "tagging") String.of_json);
        object_lock_mode =
          (Util.option_map (Json.lookup j "object_lock_mode")
             ObjectLockMode.of_json);
        object_lock_retain_until_date =
          (Util.option_map (Json.lookup j "object_lock_retain_until_date")
             DateTime.of_json);
        object_lock_legal_hold_status =
          (Util.option_map (Json.lookup j "object_lock_legal_hold_status")
             ObjectLockLegalHoldStatus.of_json)
      }
  end
module GetObjectLockConfigurationOutput =
  struct
    type t = {
      object_lock_configuration: ObjectLockConfiguration.t option }
    let make ?object_lock_configuration  () = { object_lock_configuration }
    let parse xml =
      Some
        {
          object_lock_configuration =
            (Util.option_bind (Xml.member "ObjectLockConfiguration" xml)
               ObjectLockConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.object_lock_configuration
              (fun f ->
                 Ezxmlm.make_tag "ObjectLockConfiguration"
                   ([], (ObjectLockConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_configuration
              (fun f ->
                 ("object_lock_configuration",
                   (ObjectLockConfiguration.to_json f)))])
    let of_json j =
      {
        object_lock_configuration =
          (Util.option_map (Json.lookup j "object_lock_configuration")
             ObjectLockConfiguration.of_json)
      }
  end
module DeleteBucketWebsiteRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module PutBucketWebsiteRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      website_configuration: WebsiteConfiguration.t }
    let make ~bucket  ?content_m_d5  ~website_configuration  () =
      { bucket; content_m_d5; website_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          website_configuration =
            (Xml.required "WebsiteConfiguration"
               (Util.option_bind (Xml.member "WebsiteConfiguration" xml)
                  WebsiteConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "WebsiteConfiguration"
                 ([], (WebsiteConfiguration.to_xml v.website_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("website_configuration",
                (WebsiteConfiguration.to_json v.website_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        website_configuration =
          (WebsiteConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "website_configuration")))
      }
  end
module GetBucketLifecycleRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketWebsiteRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetPublicAccessBlockOutput =
  struct
    type t =
      {
      public_access_block_configuration:
        PublicAccessBlockConfiguration.t option }
    let make ?public_access_block_configuration  () =
      { public_access_block_configuration }
    let parse xml =
      Some
        {
          public_access_block_configuration =
            (Util.option_bind
               (Xml.member "PublicAccessBlockConfiguration" xml)
               PublicAccessBlockConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.public_access_block_configuration
              (fun f ->
                 Ezxmlm.make_tag "PublicAccessBlockConfiguration"
                   ([], (PublicAccessBlockConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.public_access_block_configuration
              (fun f ->
                 ("public_access_block_configuration",
                   (PublicAccessBlockConfiguration.to_json f)))])
    let of_json j =
      {
        public_access_block_configuration =
          (Util.option_map
             (Json.lookup j "public_access_block_configuration")
             PublicAccessBlockConfiguration.of_json)
      }
  end
module GetBucketPolicyStatusRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketCorsRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module CreateBucketOutput =
  struct
    type t = {
      location: String.t option }
    let make ?location  () = { location }
    let parse xml =
      Some
        {
          location =
            (Util.option_bind (Xml.member "Location" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.location
              (fun f -> Headers.Pair ("Location", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.location
              (fun f -> Ezxmlm.make_tag "Location" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.location
              (fun f -> ("location", (String.to_json f)))])
    let of_json j =
      {
        location =
          (Util.option_map (Json.lookup j "location") String.of_json)
      }
  end
module ListBucketAnalyticsConfigurationsRequest =
  struct
    type t = {
      bucket: String.t ;
      continuation_token: String.t option }
    let make ~bucket  ?continuation_token  () =
      { bucket; continuation_token }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          continuation_token =
            (Util.option_bind (Xml.member "continuation-token" xml)
               String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f ->
                 Query.Pair ("continuation-token", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.continuation_token
              (fun f ->
                 Ezxmlm.make_tag "continuation-token" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f -> ("continuation_token", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json)
      }
  end
module PutBucketCorsRequest =
  struct
    type t =
      {
      bucket: String.t ;
      c_o_r_s_configuration: CORSConfiguration.t ;
      content_m_d5: String.t option }
    let make ~bucket  ~c_o_r_s_configuration  ?content_m_d5  () =
      { bucket; c_o_r_s_configuration; content_m_d5 }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          c_o_r_s_configuration =
            (Xml.required "CORSConfiguration"
               (Util.option_bind (Xml.member "CORSConfiguration" xml)
                  CORSConfiguration.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Some
               (Ezxmlm.make_tag "CORSConfiguration"
                  ([], (CORSConfiguration.to_xml v.c_o_r_s_configuration)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Some
             ("c_o_r_s_configuration",
               (CORSConfiguration.to_json v.c_o_r_s_configuration));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        c_o_r_s_configuration =
          (CORSConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "c_o_r_s_configuration")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json)
      }
  end
module GetBucketRequestPaymentOutput =
  struct
    type t = {
      payer: Payer.t option }
    let make ?payer  () = { payer }
    let parse xml =
      Some
        { payer = (Util.option_bind (Xml.member "Payer" xml) Payer.parse) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.payer
              (fun f -> Ezxmlm.make_tag "Payer" ([], (Payer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payer (fun f -> ("payer", (Payer.to_json f)))])
    let of_json j =
      { payer = (Util.option_map (Json.lookup j "payer") Payer.of_json) }
  end
module PutObjectLegalHoldOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let of_json j =
      {
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module DeletePublicAccessBlockRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module DeleteBucketTaggingRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module BucketAlreadyOwnedByYou =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module GetObjectTorrentRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?request_payer  () =
      { bucket; key; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module DeleteBucketEncryptionRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketLoggingRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketReplicationOutput =
  struct
    type t = {
      replication_configuration: ReplicationConfiguration.t option }
    let make ?replication_configuration  () = { replication_configuration }
    let parse xml =
      Some
        {
          replication_configuration =
            (Util.option_bind (Xml.member "ReplicationConfiguration" xml)
               ReplicationConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.replication_configuration
              (fun f ->
                 Ezxmlm.make_tag "ReplicationConfiguration"
                   ([], (ReplicationConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.replication_configuration
              (fun f ->
                 ("replication_configuration",
                   (ReplicationConfiguration.to_json f)))])
    let of_json j =
      {
        replication_configuration =
          (Util.option_map (Json.lookup j "replication_configuration")
             ReplicationConfiguration.of_json)
      }
  end
module AbortMultipartUploadOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let of_json j =
      {
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketWebsiteOutput =
  struct
    type t =
      {
      redirect_all_requests_to: RedirectAllRequestsTo.t option ;
      index_document: IndexDocument.t option ;
      error_document: ErrorDocument.t option ;
      routing_rules: RoutingRules.t }
    let make ?redirect_all_requests_to  ?index_document  ?error_document 
      ?(routing_rules= [])  () =
      {
        redirect_all_requests_to;
        index_document;
        error_document;
        routing_rules
      }
    let parse xml =
      Some
        {
          redirect_all_requests_to =
            (Util.option_bind (Xml.member "RedirectAllRequestsTo" xml)
               RedirectAllRequestsTo.parse);
          index_document =
            (Util.option_bind (Xml.member "IndexDocument" xml)
               IndexDocument.parse);
          error_document =
            (Util.option_bind (Xml.member "ErrorDocument" xml)
               ErrorDocument.parse);
          routing_rules =
            (Util.of_option []
               (Util.option_bind (Xml.member "RoutingRules" xml)
                  RoutingRules.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.redirect_all_requests_to
                 (fun f ->
                    Ezxmlm.make_tag "RedirectAllRequestsTo"
                      ([], (RedirectAllRequestsTo.to_xml f)))])
             @
             [Util.option_map v.index_document
                (fun f ->
                   Ezxmlm.make_tag "IndexDocument"
                     ([], (IndexDocument.to_xml f)))])
            @
            [Util.option_map v.error_document
               (fun f ->
                  Ezxmlm.make_tag "ErrorDocument"
                    ([], (ErrorDocument.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "RoutingRules"
                      ([], (RoutingRules.to_xml [x])))) v.routing_rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("routing_rules", (RoutingRules.to_json v.routing_rules));
           Util.option_map v.error_document
             (fun f -> ("error_document", (ErrorDocument.to_json f)));
           Util.option_map v.index_document
             (fun f -> ("index_document", (IndexDocument.to_json f)));
           Util.option_map v.redirect_all_requests_to
             (fun f ->
                ("redirect_all_requests_to",
                  (RedirectAllRequestsTo.to_json f)))])
    let of_json j =
      {
        redirect_all_requests_to =
          (Util.option_map (Json.lookup j "redirect_all_requests_to")
             RedirectAllRequestsTo.of_json);
        index_document =
          (Util.option_map (Json.lookup j "index_document")
             IndexDocument.of_json);
        error_document =
          (Util.option_map (Json.lookup j "error_document")
             ErrorDocument.of_json);
        routing_rules =
          (RoutingRules.of_json
             (Util.of_option_exn (Json.lookup j "routing_rules")))
      }
  end
module HeadObjectRequest =
  struct
    type t =
      {
      bucket: String.t ;
      if_match: String.t option ;
      if_modified_since: DateTime.t option ;
      if_none_match: String.t option ;
      if_unmodified_since: DateTime.t option ;
      key: String.t ;
      range: String.t option ;
      version_id: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      request_payer: RequestPayer.t option ;
      part_number: Integer.t option }
    let make ~bucket  ?if_match  ?if_modified_since  ?if_none_match 
      ?if_unmodified_since  ~key  ?range  ?version_id 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ?request_payer  ?part_number  () =
      {
        bucket;
        if_match;
        if_modified_since;
        if_none_match;
        if_unmodified_since;
        key;
        range;
        version_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        request_payer;
        part_number
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          if_match =
            (Util.option_bind (Xml.member "If-Match" xml) String.parse);
          if_modified_since =
            (Util.option_bind (Xml.member "If-Modified-Since" xml)
               DateTime.parse);
          if_none_match =
            (Util.option_bind (Xml.member "If-None-Match" xml) String.parse);
          if_unmodified_since =
            (Util.option_bind (Xml.member "If-Unmodified-Since" xml)
               DateTime.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          range = (Util.option_bind (Xml.member "Range" xml) String.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          part_number =
            (Util.option_bind (Xml.member "partNumber" xml) Integer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.part_number
              (fun f -> Query.Pair ("partNumber", (Integer.to_query f)));
           Util.option_map v.version_id
             (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.range
             (fun f -> Headers.Pair ("Range", (String.to_headers f)));
           Util.option_map v.if_unmodified_since
             (fun f ->
                Headers.Pair ("If-Unmodified-Since", (DateTime.to_headers f)));
           Util.option_map v.if_none_match
             (fun f -> Headers.Pair ("If-None-Match", (String.to_headers f)));
           Util.option_map v.if_modified_since
             (fun f ->
                Headers.Pair ("If-Modified-Since", (DateTime.to_headers f)));
           Util.option_map v.if_match
             (fun f -> Headers.Pair ("If-Match", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((([] @
                       [Some
                          (Ezxmlm.make_tag "Bucket"
                             ([], (String.to_xml v.bucket)))])
                      @
                      [Util.option_map v.if_match
                         (fun f ->
                            Ezxmlm.make_tag "If-Match"
                              ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.if_modified_since
                        (fun f ->
                           Ezxmlm.make_tag "If-Modified-Since"
                             ([], (DateTime.to_xml f)))])
                    @
                    [Util.option_map v.if_none_match
                       (fun f ->
                          Ezxmlm.make_tag "If-None-Match"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.if_unmodified_since
                      (fun f ->
                         Ezxmlm.make_tag "If-Unmodified-Since"
                           ([], (DateTime.to_xml f)))])
                  @
                  [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                 @
                 [Util.option_map v.range
                    (fun f -> Ezxmlm.make_tag "Range" ([], (String.to_xml f)))])
                @
                [Util.option_map v.version_id
                   (fun f ->
                      Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
               @
               [Util.option_map v.s_s_e_customer_algorithm
                  (fun f ->
                     Ezxmlm.make_tag
                       "x-amz-server-side-encryption-customer-algorithm"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_key
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-key"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_customer_key_m_d5
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-customer-key-MD5"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.request_payer
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-payer"
                    ([], (RequestPayer.to_xml f)))])
           @
           [Util.option_map v.part_number
              (fun f -> Ezxmlm.make_tag "partNumber" ([], (Integer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.part_number
              (fun f -> ("part_number", (Integer.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.range (fun f -> ("range", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.if_unmodified_since
             (fun f -> ("if_unmodified_since", (DateTime.to_json f)));
           Util.option_map v.if_none_match
             (fun f -> ("if_none_match", (String.to_json f)));
           Util.option_map v.if_modified_since
             (fun f -> ("if_modified_since", (DateTime.to_json f)));
           Util.option_map v.if_match
             (fun f -> ("if_match", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        if_match =
          (Util.option_map (Json.lookup j "if_match") String.of_json);
        if_modified_since =
          (Util.option_map (Json.lookup j "if_modified_since")
             DateTime.of_json);
        if_none_match =
          (Util.option_map (Json.lookup j "if_none_match") String.of_json);
        if_unmodified_since =
          (Util.option_map (Json.lookup j "if_unmodified_since")
             DateTime.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        range = (Util.option_map (Json.lookup j "range") String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        part_number =
          (Util.option_map (Json.lookup j "part_number") Integer.of_json)
      }
  end
module ListBucketInventoryConfigurationsRequest =
  struct
    type t = {
      bucket: String.t ;
      continuation_token: String.t option }
    let make ~bucket  ?continuation_token  () =
      { bucket; continuation_token }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          continuation_token =
            (Util.option_bind (Xml.member "continuation-token" xml)
               String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f ->
                 Query.Pair ("continuation-token", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.continuation_token
              (fun f ->
                 Ezxmlm.make_tag "continuation-token" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f -> ("continuation_token", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json)
      }
  end
module ListObjectsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option ;
      marker: String.t option ;
      next_marker: String.t option ;
      contents: ObjectList.t ;
      name: String.t option ;
      prefix: String.t option ;
      delimiter: String.t option ;
      max_keys: Integer.t option ;
      common_prefixes: CommonPrefixList.t ;
      encoding_type: EncodingType.t option }
    let make ?is_truncated  ?marker  ?next_marker  ?(contents= [])  ?name 
      ?prefix  ?delimiter  ?max_keys  ?(common_prefixes= [])  ?encoding_type 
      () =
      {
        is_truncated;
        marker;
        next_marker;
        contents;
        name;
        prefix;
        delimiter;
        max_keys;
        common_prefixes;
        encoding_type
      }
    let parse xml =
      Some
        {
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          marker = (Util.option_bind (Xml.member "Marker" xml) String.parse);
          next_marker =
            (Util.option_bind (Xml.member "NextMarker" xml) String.parse);
          contents = (Util.of_option [] (ObjectList.parse xml));
          name = (Util.option_bind (Xml.member "Name" xml) String.parse);
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          delimiter =
            (Util.option_bind (Xml.member "Delimiter" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "MaxKeys" xml) Integer.parse);
          common_prefixes = (Util.of_option [] (CommonPrefixList.parse xml));
          encoding_type =
            (Util.option_bind (Xml.member "EncodingType" xml)
               EncodingType.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.is_truncated
                       (fun f ->
                          Ezxmlm.make_tag "IsTruncated"
                            ([], (Boolean.to_xml f)))])
                   @
                   [Util.option_map v.marker
                      (fun f ->
                         Ezxmlm.make_tag "Marker" ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.next_marker
                     (fun f ->
                        Ezxmlm.make_tag "NextMarker" ([], (String.to_xml f)))])
                 @
                 (List.map
                    (fun x ->
                       Some
                         (Ezxmlm.make_tag "Contents"
                            ([], (ObjectList.to_xml [x])))) v.contents))
                @
                [Util.option_map v.name
                   (fun f -> Ezxmlm.make_tag "Name" ([], (String.to_xml f)))])
               @
               [Util.option_map v.prefix
                  (fun f -> Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
              @
              [Util.option_map v.delimiter
                 (fun f ->
                    Ezxmlm.make_tag "Delimiter" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_keys
                (fun f -> Ezxmlm.make_tag "MaxKeys" ([], (Integer.to_xml f)))])
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "CommonPrefixes"
                       ([], (CommonPrefixList.to_xml [x]))))
               v.common_prefixes))
           @
           [Util.option_map v.encoding_type
              (fun f ->
                 Ezxmlm.make_tag "EncodingType" ([], (EncodingType.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.encoding_type
              (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Some
             ("common_prefixes",
               (CommonPrefixList.to_json v.common_prefixes));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.name (fun f -> ("name", (String.to_json f)));
           Some ("contents", (ObjectList.to_json v.contents));
           Util.option_map v.next_marker
             (fun f -> ("next_marker", (String.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)))])
    let of_json j =
      {
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        next_marker =
          (Util.option_map (Json.lookup j "next_marker") String.of_json);
        contents =
          (ObjectList.of_json (Util.of_option_exn (Json.lookup j "contents")));
        name = (Util.option_map (Json.lookup j "name") String.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        max_keys =
          (Util.option_map (Json.lookup j "max_keys") Integer.of_json);
        common_prefixes =
          (CommonPrefixList.of_json
             (Util.of_option_exn (Json.lookup j "common_prefixes")));
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json)
      }
  end
module GetBucketEncryptionOutput =
  struct
    type t =
      {
      server_side_encryption_configuration:
        ServerSideEncryptionConfiguration.t option }
    let make ?server_side_encryption_configuration  () =
      { server_side_encryption_configuration }
    let parse xml =
      Some
        {
          server_side_encryption_configuration =
            (Util.option_bind
               (Xml.member "ServerSideEncryptionConfiguration" xml)
               ServerSideEncryptionConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.server_side_encryption_configuration
              (fun f ->
                 Ezxmlm.make_tag "ServerSideEncryptionConfiguration"
                   ([], (ServerSideEncryptionConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.server_side_encryption_configuration
              (fun f ->
                 ("server_side_encryption_configuration",
                   (ServerSideEncryptionConfiguration.to_json f)))])
    let of_json j =
      {
        server_side_encryption_configuration =
          (Util.option_map
             (Json.lookup j "server_side_encryption_configuration")
             ServerSideEncryptionConfiguration.of_json)
      }
  end
module HeadObjectOutput =
  struct
    type t =
      {
      delete_marker: Boolean.t option ;
      accept_ranges: String.t option ;
      expiration: String.t option ;
      restore: String.t option ;
      last_modified: DateTime.t option ;
      content_length: Long.t option ;
      e_tag: String.t option ;
      missing_meta: Integer.t option ;
      version_id: String.t option ;
      cache_control: String.t option ;
      content_disposition: String.t option ;
      content_encoding: String.t option ;
      content_language: String.t option ;
      content_type: String.t option ;
      expires: DateTime.t option ;
      website_redirect_location: String.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      metadata: Metadata.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      storage_class: StorageClass.t option ;
      request_charged: RequestCharged.t option ;
      replication_status: ReplicationStatus.t option ;
      parts_count: Integer.t option ;
      object_lock_mode: ObjectLockMode.t option ;
      object_lock_retain_until_date: DateTime.t option ;
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option }
    let make ?delete_marker  ?accept_ranges  ?expiration  ?restore 
      ?last_modified  ?content_length  ?e_tag  ?missing_meta  ?version_id 
      ?cache_control  ?content_disposition  ?content_encoding 
      ?content_language  ?content_type  ?expires  ?website_redirect_location 
      ?server_side_encryption  ?metadata  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id  ?storage_class 
      ?request_charged  ?replication_status  ?parts_count  ?object_lock_mode 
      ?object_lock_retain_until_date  ?object_lock_legal_hold_status  () =
      {
        delete_marker;
        accept_ranges;
        expiration;
        restore;
        last_modified;
        content_length;
        e_tag;
        missing_meta;
        version_id;
        cache_control;
        content_disposition;
        content_encoding;
        content_language;
        content_type;
        expires;
        website_redirect_location;
        server_side_encryption;
        metadata;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        storage_class;
        request_charged;
        replication_status;
        parts_count;
        object_lock_mode;
        object_lock_retain_until_date;
        object_lock_legal_hold_status
      }
    let parse xml =
      Some
        {
          delete_marker =
            (Util.option_bind (Xml.member "x-amz-delete-marker" xml)
               Boolean.parse);
          accept_ranges =
            (Util.option_bind (Xml.member "accept-ranges" xml) String.parse);
          expiration =
            (Util.option_bind (Xml.member "x-amz-expiration" xml)
               String.parse);
          restore =
            (Util.option_bind (Xml.member "x-amz-restore" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "Last-Modified" xml) DateTime.parse);
          content_length =
            (Util.option_bind (Xml.member "Content-Length" xml) Long.parse);
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          missing_meta =
            (Util.option_bind (Xml.member "x-amz-missing-meta" xml)
               Integer.parse);
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          cache_control =
            (Util.option_bind (Xml.member "Cache-Control" xml) String.parse);
          content_disposition =
            (Util.option_bind (Xml.member "Content-Disposition" xml)
               String.parse);
          content_encoding =
            (Util.option_bind (Xml.member "Content-Encoding" xml)
               String.parse);
          content_language =
            (Util.option_bind (Xml.member "Content-Language" xml)
               String.parse);
          content_type =
            (Util.option_bind (Xml.member "Content-Type" xml) String.parse);
          expires =
            (Util.option_bind (Xml.member "Expires" xml) DateTime.parse);
          website_redirect_location =
            (Util.option_bind
               (Xml.member "x-amz-website-redirect-location" xml)
               String.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          metadata =
            (Util.option_bind (Xml.member "x-amz-meta-" xml) Metadata.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          storage_class =
            (Util.option_bind (Xml.member "x-amz-storage-class" xml)
               StorageClass.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse);
          replication_status =
            (Util.option_bind (Xml.member "x-amz-replication-status" xml)
               ReplicationStatus.parse);
          parts_count =
            (Util.option_bind (Xml.member "x-amz-mp-parts-count" xml)
               Integer.parse);
          object_lock_mode =
            (Util.option_bind (Xml.member "x-amz-object-lock-mode" xml)
               ObjectLockMode.parse);
          object_lock_retain_until_date =
            (Util.option_bind
               (Xml.member "x-amz-object-lock-retain-until-date" xml)
               DateTime.parse);
          object_lock_legal_hold_status =
            (Util.option_bind (Xml.member "x-amz-object-lock-legal-hold" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Headers.Pair
                   ("x-amz-object-lock-legal-hold",
                     (ObjectLockLegalHoldStatus.to_headers f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-retain-until-date",
                    (DateTime.to_headers f)));
           Util.option_map v.object_lock_mode
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-mode", (ObjectLockMode.to_headers f)));
           Util.option_map v.parts_count
             (fun f ->
                Headers.Pair ("x-amz-mp-parts-count", (Integer.to_headers f)));
           Util.option_map v.replication_status
             (fun f ->
                Headers.Pair
                  ("x-amz-replication-status",
                    (ReplicationStatus.to_headers f)));
           Util.option_map v.request_charged
             (fun f ->
                Headers.Pair
                  ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.storage_class
             (fun f ->
                Headers.Pair
                  ("x-amz-storage-class", (StorageClass.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.metadata
             (fun f -> Headers.Pair ("x-amz-meta-", (Metadata.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.website_redirect_location
             (fun f ->
                Headers.Pair
                  ("x-amz-website-redirect-location", (String.to_headers f)));
           Util.option_map v.expires
             (fun f -> Headers.Pair ("Expires", (DateTime.to_headers f)));
           Util.option_map v.content_type
             (fun f -> Headers.Pair ("Content-Type", (String.to_headers f)));
           Util.option_map v.content_language
             (fun f ->
                Headers.Pair ("Content-Language", (String.to_headers f)));
           Util.option_map v.content_encoding
             (fun f ->
                Headers.Pair ("Content-Encoding", (String.to_headers f)));
           Util.option_map v.content_disposition
             (fun f ->
                Headers.Pair ("Content-Disposition", (String.to_headers f)));
           Util.option_map v.cache_control
             (fun f -> Headers.Pair ("Cache-Control", (String.to_headers f)));
           Util.option_map v.version_id
             (fun f ->
                Headers.Pair ("x-amz-version-id", (String.to_headers f)));
           Util.option_map v.missing_meta
             (fun f ->
                Headers.Pair ("x-amz-missing-meta", (Integer.to_headers f)));
           Util.option_map v.e_tag
             (fun f -> Headers.Pair ("ETag", (String.to_headers f)));
           Util.option_map v.content_length
             (fun f -> Headers.Pair ("Content-Length", (Long.to_headers f)));
           Util.option_map v.last_modified
             (fun f ->
                Headers.Pair ("Last-Modified", (DateTime.to_headers f)));
           Util.option_map v.restore
             (fun f -> Headers.Pair ("x-amz-restore", (String.to_headers f)));
           Util.option_map v.expiration
             (fun f ->
                Headers.Pair ("x-amz-expiration", (String.to_headers f)));
           Util.option_map v.accept_ranges
             (fun f -> Headers.Pair ("accept-ranges", (String.to_headers f)));
           Util.option_map v.delete_marker
             (fun f ->
                Headers.Pair ("x-amz-delete-marker", (Boolean.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((([] @
                                      [Util.option_map v.delete_marker
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "x-amz-delete-marker"
                                              ([], (Boolean.to_xml f)))])
                                     @
                                     [Util.option_map v.accept_ranges
                                        (fun f ->
                                           Ezxmlm.make_tag "accept-ranges"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.expiration
                                       (fun f ->
                                          Ezxmlm.make_tag "x-amz-expiration"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Util.option_map v.restore
                                      (fun f ->
                                         Ezxmlm.make_tag "x-amz-restore"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.last_modified
                                     (fun f ->
                                        Ezxmlm.make_tag "Last-Modified"
                                          ([], (DateTime.to_xml f)))])
                                 @
                                 [Util.option_map v.content_length
                                    (fun f ->
                                       Ezxmlm.make_tag "Content-Length"
                                         ([], (Long.to_xml f)))])
                                @
                                [Util.option_map v.e_tag
                                   (fun f ->
                                      Ezxmlm.make_tag "ETag"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.missing_meta
                                  (fun f ->
                                     Ezxmlm.make_tag "x-amz-missing-meta"
                                       ([], (Integer.to_xml f)))])
                              @
                              [Util.option_map v.version_id
                                 (fun f ->
                                    Ezxmlm.make_tag "x-amz-version-id"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.cache_control
                                (fun f ->
                                   Ezxmlm.make_tag "Cache-Control"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.content_disposition
                               (fun f ->
                                  Ezxmlm.make_tag "Content-Disposition"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.content_encoding
                              (fun f ->
                                 Ezxmlm.make_tag "Content-Encoding"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.content_language
                             (fun f ->
                                Ezxmlm.make_tag "Content-Language"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.content_type
                            (fun f ->
                               Ezxmlm.make_tag "Content-Type"
                                 ([], (String.to_xml f)))])
                        @
                        [Util.option_map v.expires
                           (fun f ->
                              Ezxmlm.make_tag "Expires"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.website_redirect_location
                          (fun f ->
                             Ezxmlm.make_tag
                               "x-amz-website-redirect-location"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.server_side_encryption
                         (fun f ->
                            Ezxmlm.make_tag "x-amz-server-side-encryption"
                              ([], (ServerSideEncryption.to_xml f)))])
                     @
                     [Util.option_map v.metadata
                        (fun f ->
                           Ezxmlm.make_tag "x-amz-meta-"
                             ([], (Metadata.to_xml f)))])
                    @
                    [Util.option_map v.s_s_e_customer_algorithm
                       (fun f ->
                          Ezxmlm.make_tag
                            "x-amz-server-side-encryption-customer-algorithm"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.s_s_e_customer_key_m_d5
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-customer-key-MD5"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.s_s_e_k_m_s_key_id
                     (fun f ->
                        Ezxmlm.make_tag
                          "x-amz-server-side-encryption-aws-kms-key-id"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.storage_class
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-storage-class"
                         ([], (StorageClass.to_xml f)))])
                @
                [Util.option_map v.request_charged
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-request-charged"
                        ([], (RequestCharged.to_xml f)))])
               @
               [Util.option_map v.replication_status
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-replication-status"
                       ([], (ReplicationStatus.to_xml f)))])
              @
              [Util.option_map v.parts_count
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-mp-parts-count"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.object_lock_mode
                (fun f ->
                   Ezxmlm.make_tag "x-amz-object-lock-mode"
                     ([], (ObjectLockMode.to_xml f)))])
            @
            [Util.option_map v.object_lock_retain_until_date
               (fun f ->
                  Ezxmlm.make_tag "x-amz-object-lock-retain-until-date"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Ezxmlm.make_tag "x-amz-object-lock-legal-hold"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 ("object_lock_legal_hold_status",
                   (ObjectLockLegalHoldStatus.to_json f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                ("object_lock_retain_until_date", (DateTime.to_json f)));
           Util.option_map v.object_lock_mode
             (fun f -> ("object_lock_mode", (ObjectLockMode.to_json f)));
           Util.option_map v.parts_count
             (fun f -> ("parts_count", (Integer.to_json f)));
           Util.option_map v.replication_status
             (fun f -> ("replication_status", (ReplicationStatus.to_json f)));
           Util.option_map v.request_charged
             (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (Metadata.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.website_redirect_location
             (fun f -> ("website_redirect_location", (String.to_json f)));
           Util.option_map v.expires
             (fun f -> ("expires", (DateTime.to_json f)));
           Util.option_map v.content_type
             (fun f -> ("content_type", (String.to_json f)));
           Util.option_map v.content_language
             (fun f -> ("content_language", (String.to_json f)));
           Util.option_map v.content_encoding
             (fun f -> ("content_encoding", (String.to_json f)));
           Util.option_map v.content_disposition
             (fun f -> ("content_disposition", (String.to_json f)));
           Util.option_map v.cache_control
             (fun f -> ("cache_control", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.missing_meta
             (fun f -> ("missing_meta", (Integer.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.content_length
             (fun f -> ("content_length", (Long.to_json f)));
           Util.option_map v.last_modified
             (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.restore
             (fun f -> ("restore", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (String.to_json f)));
           Util.option_map v.accept_ranges
             (fun f -> ("accept_ranges", (String.to_json f)));
           Util.option_map v.delete_marker
             (fun f -> ("delete_marker", (Boolean.to_json f)))])
    let of_json j =
      {
        delete_marker =
          (Util.option_map (Json.lookup j "delete_marker") Boolean.of_json);
        accept_ranges =
          (Util.option_map (Json.lookup j "accept_ranges") String.of_json);
        expiration =
          (Util.option_map (Json.lookup j "expiration") String.of_json);
        restore = (Util.option_map (Json.lookup j "restore") String.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json);
        content_length =
          (Util.option_map (Json.lookup j "content_length") Long.of_json);
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        missing_meta =
          (Util.option_map (Json.lookup j "missing_meta") Integer.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        cache_control =
          (Util.option_map (Json.lookup j "cache_control") String.of_json);
        content_disposition =
          (Util.option_map (Json.lookup j "content_disposition")
             String.of_json);
        content_encoding =
          (Util.option_map (Json.lookup j "content_encoding") String.of_json);
        content_language =
          (Util.option_map (Json.lookup j "content_language") String.of_json);
        content_type =
          (Util.option_map (Json.lookup j "content_type") String.of_json);
        expires =
          (Util.option_map (Json.lookup j "expires") DateTime.of_json);
        website_redirect_location =
          (Util.option_map (Json.lookup j "website_redirect_location")
             String.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        metadata =
          (Util.option_map (Json.lookup j "metadata") Metadata.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json);
        replication_status =
          (Util.option_map (Json.lookup j "replication_status")
             ReplicationStatus.of_json);
        parts_count =
          (Util.option_map (Json.lookup j "parts_count") Integer.of_json);
        object_lock_mode =
          (Util.option_map (Json.lookup j "object_lock_mode")
             ObjectLockMode.of_json);
        object_lock_retain_until_date =
          (Util.option_map (Json.lookup j "object_lock_retain_until_date")
             DateTime.of_json);
        object_lock_legal_hold_status =
          (Util.option_map (Json.lookup j "object_lock_legal_hold_status")
             ObjectLockLegalHoldStatus.of_json)
      }
  end
module PutObjectLegalHoldRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      legal_hold: ObjectLockLegalHold.t option ;
      request_payer: RequestPayer.t option ;
      version_id: String.t option ;
      content_m_d5: String.t option }
    let make ~bucket  ~key  ?legal_hold  ?request_payer  ?version_id 
      ?content_m_d5  () =
      { bucket; key; legal_hold; request_payer; version_id; content_m_d5 }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          legal_hold =
            (Util.option_bind (Xml.member "LegalHold" xml)
               ObjectLockLegalHold.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((([] @
                [Some
                   (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
               @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
              @
              [Util.option_map v.legal_hold
                 (fun f ->
                    Ezxmlm.make_tag "LegalHold"
                      ([], (ObjectLockLegalHold.to_xml f)))])
             @
             [Util.option_map v.request_payer
                (fun f ->
                   Ezxmlm.make_tag "x-amz-request-payer"
                     ([], (RequestPayer.to_xml f)))])
            @
            [Util.option_map v.version_id
               (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.legal_hold
             (fun f -> ("legal_hold", (ObjectLockLegalHold.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        legal_hold =
          (Util.option_map (Json.lookup j "legal_hold")
             ObjectLockLegalHold.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json)
      }
  end
module DeleteObjectTaggingRequest =
  struct
    type t = {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option }
    let make ~bucket  ~key  ?version_id  () = { bucket; key; version_id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
           @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json)
      }
  end
module PutPublicAccessBlockRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      public_access_block_configuration: PublicAccessBlockConfiguration.t }
    let make ~bucket  ?content_m_d5  ~public_access_block_configuration  () =
      { bucket; content_m_d5; public_access_block_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          public_access_block_configuration =
            (Xml.required "PublicAccessBlockConfiguration"
               (Util.option_bind
                  (Xml.member "PublicAccessBlockConfiguration" xml)
                  PublicAccessBlockConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "PublicAccessBlockConfiguration"
                 ([],
                   (PublicAccessBlockConfiguration.to_xml
                      v.public_access_block_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("public_access_block_configuration",
                (PublicAccessBlockConfiguration.to_json
                   v.public_access_block_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        public_access_block_configuration =
          (PublicAccessBlockConfiguration.of_json
             (Util.of_option_exn
                (Json.lookup j "public_access_block_configuration")))
      }
  end
module PutBucketAccelerateConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      accelerate_configuration: AccelerateConfiguration.t }
    let make ~bucket  ~accelerate_configuration  () =
      { bucket; accelerate_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          accelerate_configuration =
            (Xml.required "AccelerateConfiguration"
               (Util.option_bind (Xml.member "AccelerateConfiguration" xml)
                  AccelerateConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Some
              (Ezxmlm.make_tag "AccelerateConfiguration"
                 ([],
                   (AccelerateConfiguration.to_xml v.accelerate_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("accelerate_configuration",
                (AccelerateConfiguration.to_json v.accelerate_configuration));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        accelerate_configuration =
          (AccelerateConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "accelerate_configuration")))
      }
  end
module PutObjectAclOutput =
  struct
    type t = {
      request_charged: RequestCharged.t option }
    let make ?request_charged  () = { request_charged }
    let parse xml =
      Some
        {
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)))])
    let of_json j =
      {
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module ListBucketMetricsConfigurationsOutput =
  struct
    type t =
      {
      is_truncated: Boolean.t option ;
      continuation_token: String.t option ;
      next_continuation_token: String.t option ;
      metrics_configuration_list: MetricsConfigurationList.t }
    let make ?is_truncated  ?continuation_token  ?next_continuation_token 
      ?(metrics_configuration_list= [])  () =
      {
        is_truncated;
        continuation_token;
        next_continuation_token;
        metrics_configuration_list
      }
    let parse xml =
      Some
        {
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          continuation_token =
            (Util.option_bind (Xml.member "ContinuationToken" xml)
               String.parse);
          next_continuation_token =
            (Util.option_bind (Xml.member "NextContinuationToken" xml)
               String.parse);
          metrics_configuration_list =
            (Util.of_option [] (MetricsConfigurationList.parse xml))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Util.option_map v.is_truncated
                 (fun f ->
                    Ezxmlm.make_tag "IsTruncated" ([], (Boolean.to_xml f)))])
             @
             [Util.option_map v.continuation_token
                (fun f ->
                   Ezxmlm.make_tag "ContinuationToken"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.next_continuation_token
               (fun f ->
                  Ezxmlm.make_tag "NextContinuationToken"
                    ([], (String.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "MetricsConfiguration"
                      ([], (MetricsConfigurationList.to_xml [x]))))
              v.metrics_configuration_list))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("metrics_configuration_list",
                (MetricsConfigurationList.to_json
                   v.metrics_configuration_list));
           Util.option_map v.next_continuation_token
             (fun f -> ("next_continuation_token", (String.to_json f)));
           Util.option_map v.continuation_token
             (fun f -> ("continuation_token", (String.to_json f)));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)))])
    let of_json j =
      {
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json);
        next_continuation_token =
          (Util.option_map (Json.lookup j "next_continuation_token")
             String.of_json);
        metrics_configuration_list =
          (MetricsConfigurationList.of_json
             (Util.of_option_exn (Json.lookup j "metrics_configuration_list")))
      }
  end
module GetObjectRetentionOutput =
  struct
    type t = {
      retention: ObjectLockRetention.t option }
    let make ?retention  () = { retention }
    let parse xml =
      Some
        {
          retention =
            (Util.option_bind (Xml.member "Retention" xml)
               ObjectLockRetention.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.retention
              (fun f ->
                 Ezxmlm.make_tag "Retention"
                   ([], (ObjectLockRetention.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.retention
              (fun f -> ("retention", (ObjectLockRetention.to_json f)))])
    let of_json j =
      {
        retention =
          (Util.option_map (Json.lookup j "retention")
             ObjectLockRetention.of_json)
      }
  end
module DeleteBucketInventoryConfigurationRequest =
  struct
    type t = {
      bucket: String.t ;
      id: String.t }
    let make ~bucket  ~id  () = { bucket; id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")))
      }
  end
module GetObjectTorrentOutput =
  struct
    type t = {
      body: Blob.t option ;
      request_charged: RequestCharged.t option }
    let make ?body  ?request_charged  () = { body; request_charged }
    let parse xml =
      Some
        {
          body = (Util.option_bind (Xml.member "Body" xml) Blob.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Util.option_map v.body
               (fun f -> Ezxmlm.make_tag "Body" ([], (Blob.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.body (fun f -> ("body", (Blob.to_json f)))])
    let of_json j =
      {
        body = (Util.option_map (Json.lookup j "body") Blob.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module PutObjectAclRequest =
  struct
    type t =
      {
      a_c_l: ObjectCannedACL.t option ;
      access_control_policy: AccessControlPolicy.t option ;
      bucket: String.t ;
      content_m_d5: String.t option ;
      grant_full_control: String.t option ;
      grant_read: String.t option ;
      grant_read_a_c_p: String.t option ;
      grant_write: String.t option ;
      grant_write_a_c_p: String.t option ;
      key: String.t ;
      request_payer: RequestPayer.t option ;
      version_id: String.t option }
    let make ?a_c_l  ?access_control_policy  ~bucket  ?content_m_d5 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write 
      ?grant_write_a_c_p  ~key  ?request_payer  ?version_id  () =
      {
        a_c_l;
        access_control_policy;
        bucket;
        content_m_d5;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write;
        grant_write_a_c_p;
        key;
        request_payer;
        version_id
      }
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               ObjectCannedACL.parse);
          access_control_policy =
            (Util.option_bind (Xml.member "AccessControlPolicy" xml)
               AccessControlPolicy.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write =
            (Util.option_bind (Xml.member "x-amz-grant-write" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_write
             (fun f ->
                Headers.Pair ("x-amz-grant-write", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (ObjectCannedACL.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.a_c_l
                         (fun f ->
                            Ezxmlm.make_tag "x-amz-acl"
                              ([], (ObjectCannedACL.to_xml f)))])
                     @
                     [Util.option_map v.access_control_policy
                        (fun f ->
                           Ezxmlm.make_tag "AccessControlPolicy"
                             ([], (AccessControlPolicy.to_xml f)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "Bucket"
                          ([], (String.to_xml v.bucket)))])
                   @
                   [Util.option_map v.content_m_d5
                      (fun f ->
                         Ezxmlm.make_tag "Content-MD5"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.grant_full_control
                     (fun f ->
                        Ezxmlm.make_tag "x-amz-grant-full-control"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.grant_read
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-grant-read"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.grant_read_a_c_p
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-grant-read-acp"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.grant_write
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-grant-write"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.grant_write_a_c_p
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-grant-write-acp"
                      ([], (String.to_xml f)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Util.option_map v.request_payer
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-payer"
                    ([], (RequestPayer.to_xml f)))])
           @
           [Util.option_map v.version_id
              (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_write
             (fun f -> ("grant_write", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.access_control_policy
             (fun f ->
                ("access_control_policy", (AccessControlPolicy.to_json f)));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (ObjectCannedACL.to_json f)))])
    let of_json j =
      {
        a_c_l =
          (Util.option_map (Json.lookup j "a_c_l") ObjectCannedACL.of_json);
        access_control_policy =
          (Util.option_map (Json.lookup j "access_control_policy")
             AccessControlPolicy.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        grant_full_control =
          (Util.option_map (Json.lookup j "grant_full_control")
             String.of_json);
        grant_read =
          (Util.option_map (Json.lookup j "grant_read") String.of_json);
        grant_read_a_c_p =
          (Util.option_map (Json.lookup j "grant_read_a_c_p") String.of_json);
        grant_write =
          (Util.option_map (Json.lookup j "grant_write") String.of_json);
        grant_write_a_c_p =
          (Util.option_map (Json.lookup j "grant_write_a_c_p") String.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json)
      }
  end
module CreateBucketRequest =
  struct
    type t =
      {
      a_c_l: BucketCannedACL.t option ;
      bucket: String.t ;
      create_bucket_configuration: CreateBucketConfiguration.t option ;
      grant_full_control: String.t option ;
      grant_read: String.t option ;
      grant_read_a_c_p: String.t option ;
      grant_write: String.t option ;
      grant_write_a_c_p: String.t option ;
      object_lock_enabled_for_bucket: Boolean.t option }
    let make ?a_c_l  ~bucket  ?create_bucket_configuration 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write 
      ?grant_write_a_c_p  ?object_lock_enabled_for_bucket  () =
      {
        a_c_l;
        bucket;
        create_bucket_configuration;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write;
        grant_write_a_c_p;
        object_lock_enabled_for_bucket
      }
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               BucketCannedACL.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          create_bucket_configuration =
            (Util.option_bind (Xml.member "CreateBucketConfiguration" xml)
               CreateBucketConfiguration.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write =
            (Util.option_bind (Xml.member "x-amz-grant-write" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          object_lock_enabled_for_bucket =
            (Util.option_bind
               (Xml.member "x-amz-bucket-object-lock-enabled" xml)
               Boolean.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_enabled_for_bucket
              (fun f ->
                 Headers.Pair
                   ("x-amz-bucket-object-lock-enabled",
                     (Boolean.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_write
             (fun f ->
                Headers.Pair ("x-amz-grant-write", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (BucketCannedACL.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.a_c_l
                      (fun f ->
                         Ezxmlm.make_tag "x-amz-acl"
                           ([], (BucketCannedACL.to_xml f)))])
                  @
                  [Some
                     (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                 @
                 [Util.option_map v.create_bucket_configuration
                    (fun f ->
                       Ezxmlm.make_tag "CreateBucketConfiguration"
                         ([], (CreateBucketConfiguration.to_xml f)))])
                @
                [Util.option_map v.grant_full_control
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-grant-full-control"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.grant_read
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-grant-read"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.grant_read_a_c_p
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-grant-read-acp"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.grant_write
                (fun f ->
                   Ezxmlm.make_tag "x-amz-grant-write"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.grant_write_a_c_p
               (fun f ->
                  Ezxmlm.make_tag "x-amz-grant-write-acp"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.object_lock_enabled_for_bucket
              (fun f ->
                 Ezxmlm.make_tag "x-amz-bucket-object-lock-enabled"
                   ([], (Boolean.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_enabled_for_bucket
              (fun f ->
                 ("object_lock_enabled_for_bucket", (Boolean.to_json f)));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_write
             (fun f -> ("grant_write", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.create_bucket_configuration
             (fun f ->
                ("create_bucket_configuration",
                  (CreateBucketConfiguration.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (BucketCannedACL.to_json f)))])
    let of_json j =
      {
        a_c_l =
          (Util.option_map (Json.lookup j "a_c_l") BucketCannedACL.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        create_bucket_configuration =
          (Util.option_map (Json.lookup j "create_bucket_configuration")
             CreateBucketConfiguration.of_json);
        grant_full_control =
          (Util.option_map (Json.lookup j "grant_full_control")
             String.of_json);
        grant_read =
          (Util.option_map (Json.lookup j "grant_read") String.of_json);
        grant_read_a_c_p =
          (Util.option_map (Json.lookup j "grant_read_a_c_p") String.of_json);
        grant_write =
          (Util.option_map (Json.lookup j "grant_write") String.of_json);
        grant_write_a_c_p =
          (Util.option_map (Json.lookup j "grant_write_a_c_p") String.of_json);
        object_lock_enabled_for_bucket =
          (Util.option_map (Json.lookup j "object_lock_enabled_for_bucket")
             Boolean.of_json)
      }
  end
module GetBucketCorsOutput =
  struct
    type t = {
      c_o_r_s_rules: CORSRules.t }
    let make ?(c_o_r_s_rules= [])  () = { c_o_r_s_rules }
    let parse xml =
      Some { c_o_r_s_rules = (Util.of_option [] (CORSRules.parse xml)) }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some
                   (Ezxmlm.make_tag "CORSRule" ([], (CORSRules.to_xml [x]))))
              v.c_o_r_s_rules))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("c_o_r_s_rules", (CORSRules.to_json v.c_o_r_s_rules))])
    let of_json j =
      {
        c_o_r_s_rules =
          (CORSRules.of_json
             (Util.of_option_exn (Json.lookup j "c_o_r_s_rules")))
      }
  end
module GetBucketMetricsConfigurationRequest =
  struct
    type t = {
      bucket: String.t ;
      id: String.t }
    let make ~bucket  ~id  () = { bucket; id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")))
      }
  end
module PutBucketLoggingRequest =
  struct
    type t =
      {
      bucket: String.t ;
      bucket_logging_status: BucketLoggingStatus.t ;
      content_m_d5: String.t option }
    let make ~bucket  ~bucket_logging_status  ?content_m_d5  () =
      { bucket; bucket_logging_status; content_m_d5 }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          bucket_logging_status =
            (Xml.required "BucketLoggingStatus"
               (Util.option_bind (Xml.member "BucketLoggingStatus" xml)
                  BucketLoggingStatus.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Some
               (Ezxmlm.make_tag "BucketLoggingStatus"
                  ([], (BucketLoggingStatus.to_xml v.bucket_logging_status)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Some
             ("bucket_logging_status",
               (BucketLoggingStatus.to_json v.bucket_logging_status));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        bucket_logging_status =
          (BucketLoggingStatus.of_json
             (Util.of_option_exn (Json.lookup j "bucket_logging_status")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json)
      }
  end
module UploadPartRequest =
  struct
    type t =
      {
      body: Blob.t option ;
      bucket: String.t ;
      content_length: Long.t option ;
      content_m_d5: String.t option ;
      key: String.t ;
      part_number: Integer.t ;
      upload_id: String.t ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      request_payer: RequestPayer.t option }
    let make ?body  ~bucket  ?content_length  ?content_m_d5  ~key 
      ~part_number  ~upload_id  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key  ?s_s_e_customer_key_m_d5  ?request_payer  () =
      {
        body;
        bucket;
        content_length;
        content_m_d5;
        key;
        part_number;
        upload_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        request_payer
      }
    let parse xml =
      Some
        {
          body = (Util.option_bind (Xml.member "Body" xml) Blob.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_length =
            (Util.option_bind (Xml.member "Content-Length" xml) Long.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          part_number =
            (Xml.required "partNumber"
               (Util.option_bind (Xml.member "partNumber" xml) Integer.parse));
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)));
           Some (Query.Pair ("partNumber", (Integer.to_query v.part_number)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.content_length
             (fun f -> Headers.Pair ("Content-Length", (Long.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Util.option_map v.body
                        (fun f ->
                           Ezxmlm.make_tag "Body" ([], (Blob.to_xml f)))])
                    @
                    [Some
                       (Ezxmlm.make_tag "Bucket"
                          ([], (String.to_xml v.bucket)))])
                   @
                   [Util.option_map v.content_length
                      (fun f ->
                         Ezxmlm.make_tag "Content-Length"
                           ([], (Long.to_xml f)))])
                  @
                  [Util.option_map v.content_m_d5
                     (fun f ->
                        Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
                 @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                @
                [Some
                   (Ezxmlm.make_tag "partNumber"
                      ([], (Integer.to_xml v.part_number)))])
               @
               [Some
                  (Ezxmlm.make_tag "uploadId"
                     ([], (String.to_xml v.upload_id)))])
              @
              [Util.option_map v.s_s_e_customer_algorithm
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-algorithm"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_customer_key
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-customer-key"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_customer_key_m_d5
               (fun f ->
                  Ezxmlm.make_tag
                    "x-amz-server-side-encryption-customer-key-MD5"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Some ("part_number", (Integer.to_json v.part_number));
           Some ("key", (String.to_json v.key));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.content_length
             (fun f -> ("content_length", (Long.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.body (fun f -> ("body", (Blob.to_json f)))])
    let of_json j =
      {
        body = (Util.option_map (Json.lookup j "body") Blob.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_length =
          (Util.option_map (Json.lookup j "content_length") Long.of_json);
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        part_number =
          (Integer.of_json (Util.of_option_exn (Json.lookup j "part_number")));
        upload_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "upload_id")));
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module DeleteBucketAnalyticsConfigurationRequest =
  struct
    type t = {
      bucket: String.t ;
      id: String.t }
    let make ~bucket  ~id  () = { bucket; id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")))
      }
  end
module CompleteMultipartUploadRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      multipart_upload: CompletedMultipartUpload.t option ;
      upload_id: String.t ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?multipart_upload  ~upload_id  ?request_payer  ()
      = { bucket; key; multipart_upload; upload_id; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          multipart_upload =
            (Util.option_bind (Xml.member "CompleteMultipartUpload" xml)
               CompletedMultipartUpload.parse);
          upload_id =
            (Xml.required "uploadId"
               (Util.option_bind (Xml.member "uploadId" xml) String.parse));
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("uploadId", (String.to_query v.upload_id)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((([] @
               [Some
                  (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
              @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
             @
             [Util.option_map v.multipart_upload
                (fun f ->
                   Ezxmlm.make_tag "CompleteMultipartUpload"
                     ([], (CompletedMultipartUpload.to_xml f)))])
            @
            [Some
               (Ezxmlm.make_tag "uploadId" ([], (String.to_xml v.upload_id)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Some ("upload_id", (String.to_json v.upload_id));
           Util.option_map v.multipart_upload
             (fun f ->
                ("multipart_upload", (CompletedMultipartUpload.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        multipart_upload =
          (Util.option_map (Json.lookup j "multipart_upload")
             CompletedMultipartUpload.of_json);
        upload_id =
          (String.of_json (Util.of_option_exn (Json.lookup j "upload_id")));
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module DeleteBucketPolicyRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetPublicAccessBlockRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketReplicationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module DeleteBucketRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module ListBucketMetricsConfigurationsRequest =
  struct
    type t = {
      bucket: String.t ;
      continuation_token: String.t option }
    let make ~bucket  ?continuation_token  () =
      { bucket; continuation_token }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          continuation_token =
            (Util.option_bind (Xml.member "continuation-token" xml)
               String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f ->
                 Query.Pair ("continuation-token", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.continuation_token
              (fun f ->
                 Ezxmlm.make_tag "continuation-token" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.continuation_token
              (fun f -> ("continuation_token", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json)
      }
  end
module GetBucketLifecycleConfigurationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module ListBucketsOutput =
  struct
    type t = {
      buckets: Buckets.t ;
      owner: Owner.t option }
    let make ?(buckets= [])  ?owner  () = { buckets; owner }
    let parse xml =
      Some
        {
          buckets =
            (Util.of_option []
               (Util.option_bind (Xml.member "Buckets" xml) Buckets.parse));
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            (List.map
               (fun x ->
                  Some (Ezxmlm.make_tag "Buckets" ([], (Buckets.to_xml [x]))))
               v.buckets))
           @
           [Util.option_map v.owner
              (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Some ("buckets", (Buckets.to_json v.buckets))])
    let of_json j =
      {
        buckets =
          (Buckets.of_json (Util.of_option_exn (Json.lookup j "buckets")));
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json)
      }
  end
module BucketAlreadyExists =
  struct
    type t = unit
    let make () = ()
    let parse xml = Some ()
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v = Util.list_filter_opt []
    let to_json v = `Assoc (Util.list_filter_opt [])
    let of_json j = ()
  end
module CreateMultipartUploadRequest =
  struct
    type t =
      {
      a_c_l: ObjectCannedACL.t option ;
      bucket: String.t ;
      cache_control: String.t option ;
      content_disposition: String.t option ;
      content_encoding: String.t option ;
      content_language: String.t option ;
      content_type: String.t option ;
      expires: DateTime.t option ;
      grant_full_control: String.t option ;
      grant_read: String.t option ;
      grant_read_a_c_p: String.t option ;
      grant_write_a_c_p: String.t option ;
      key: String.t ;
      metadata: Metadata.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      storage_class: StorageClass.t option ;
      website_redirect_location: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      s_s_e_k_m_s_encryption_context: String.t option ;
      request_payer: RequestPayer.t option ;
      tagging: String.t option ;
      object_lock_mode: ObjectLockMode.t option ;
      object_lock_retain_until_date: DateTime.t option ;
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option }
    let make ?a_c_l  ~bucket  ?cache_control  ?content_disposition 
      ?content_encoding  ?content_language  ?content_type  ?expires 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write_a_c_p
       ~key  ?metadata  ?server_side_encryption  ?storage_class 
      ?website_redirect_location  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key  ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?request_payer  ?tagging 
      ?object_lock_mode  ?object_lock_retain_until_date 
      ?object_lock_legal_hold_status  () =
      {
        a_c_l;
        bucket;
        cache_control;
        content_disposition;
        content_encoding;
        content_language;
        content_type;
        expires;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write_a_c_p;
        key;
        metadata;
        server_side_encryption;
        storage_class;
        website_redirect_location;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        request_payer;
        tagging;
        object_lock_mode;
        object_lock_retain_until_date;
        object_lock_legal_hold_status
      }
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               ObjectCannedACL.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          cache_control =
            (Util.option_bind (Xml.member "Cache-Control" xml) String.parse);
          content_disposition =
            (Util.option_bind (Xml.member "Content-Disposition" xml)
               String.parse);
          content_encoding =
            (Util.option_bind (Xml.member "Content-Encoding" xml)
               String.parse);
          content_language =
            (Util.option_bind (Xml.member "Content-Language" xml)
               String.parse);
          content_type =
            (Util.option_bind (Xml.member "Content-Type" xml) String.parse);
          expires =
            (Util.option_bind (Xml.member "Expires" xml) DateTime.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          metadata =
            (Util.option_bind (Xml.member "x-amz-meta-" xml) Metadata.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          storage_class =
            (Util.option_bind (Xml.member "x-amz-storage-class" xml)
               StorageClass.parse);
          website_redirect_location =
            (Util.option_bind
               (Xml.member "x-amz-website-redirect-location" xml)
               String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          tagging =
            (Util.option_bind (Xml.member "x-amz-tagging" xml) String.parse);
          object_lock_mode =
            (Util.option_bind (Xml.member "x-amz-object-lock-mode" xml)
               ObjectLockMode.parse);
          object_lock_retain_until_date =
            (Util.option_bind
               (Xml.member "x-amz-object-lock-retain-until-date" xml)
               DateTime.parse);
          object_lock_legal_hold_status =
            (Util.option_bind (Xml.member "x-amz-object-lock-legal-hold" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Headers.Pair
                   ("x-amz-object-lock-legal-hold",
                     (ObjectLockLegalHoldStatus.to_headers f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-retain-until-date",
                    (DateTime.to_headers f)));
           Util.option_map v.object_lock_mode
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-mode", (ObjectLockMode.to_headers f)));
           Util.option_map v.tagging
             (fun f -> Headers.Pair ("x-amz-tagging", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.website_redirect_location
             (fun f ->
                Headers.Pair
                  ("x-amz-website-redirect-location", (String.to_headers f)));
           Util.option_map v.storage_class
             (fun f ->
                Headers.Pair
                  ("x-amz-storage-class", (StorageClass.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.metadata
             (fun f -> Headers.Pair ("x-amz-meta-", (Metadata.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.expires
             (fun f -> Headers.Pair ("Expires", (DateTime.to_headers f)));
           Util.option_map v.content_type
             (fun f -> Headers.Pair ("Content-Type", (String.to_headers f)));
           Util.option_map v.content_language
             (fun f ->
                Headers.Pair ("Content-Language", (String.to_headers f)));
           Util.option_map v.content_encoding
             (fun f ->
                Headers.Pair ("Content-Encoding", (String.to_headers f)));
           Util.option_map v.content_disposition
             (fun f ->
                Headers.Pair ("Content-Disposition", (String.to_headers f)));
           Util.option_map v.cache_control
             (fun f -> Headers.Pair ("Cache-Control", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (ObjectCannedACL.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((([] @
                                     [Util.option_map v.a_c_l
                                        (fun f ->
                                           Ezxmlm.make_tag "x-amz-acl"
                                             ([], (ObjectCannedACL.to_xml f)))])
                                    @
                                    [Some
                                       (Ezxmlm.make_tag "Bucket"
                                          ([], (String.to_xml v.bucket)))])
                                   @
                                   [Util.option_map v.cache_control
                                      (fun f ->
                                         Ezxmlm.make_tag "Cache-Control"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.content_disposition
                                     (fun f ->
                                        Ezxmlm.make_tag "Content-Disposition"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.content_encoding
                                    (fun f ->
                                       Ezxmlm.make_tag "Content-Encoding"
                                         ([], (String.to_xml f)))])
                                @
                                [Util.option_map v.content_language
                                   (fun f ->
                                      Ezxmlm.make_tag "Content-Language"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.content_type
                                  (fun f ->
                                     Ezxmlm.make_tag "Content-Type"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.expires
                                 (fun f ->
                                    Ezxmlm.make_tag "Expires"
                                      ([], (DateTime.to_xml f)))])
                             @
                             [Util.option_map v.grant_full_control
                                (fun f ->
                                   Ezxmlm.make_tag "x-amz-grant-full-control"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.grant_read
                               (fun f ->
                                  Ezxmlm.make_tag "x-amz-grant-read"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.grant_read_a_c_p
                              (fun f ->
                                 Ezxmlm.make_tag "x-amz-grant-read-acp"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.grant_write_a_c_p
                             (fun f ->
                                Ezxmlm.make_tag "x-amz-grant-write-acp"
                                  ([], (String.to_xml f)))])
                         @
                         [Some
                            (Ezxmlm.make_tag "Key"
                               ([], (String.to_xml v.key)))])
                        @
                        [Util.option_map v.metadata
                           (fun f ->
                              Ezxmlm.make_tag "x-amz-meta-"
                                ([], (Metadata.to_xml f)))])
                       @
                       [Util.option_map v.server_side_encryption
                          (fun f ->
                             Ezxmlm.make_tag "x-amz-server-side-encryption"
                               ([], (ServerSideEncryption.to_xml f)))])
                      @
                      [Util.option_map v.storage_class
                         (fun f ->
                            Ezxmlm.make_tag "x-amz-storage-class"
                              ([], (StorageClass.to_xml f)))])
                     @
                     [Util.option_map v.website_redirect_location
                        (fun f ->
                           Ezxmlm.make_tag "x-amz-website-redirect-location"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.s_s_e_customer_algorithm
                       (fun f ->
                          Ezxmlm.make_tag
                            "x-amz-server-side-encryption-customer-algorithm"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.s_s_e_customer_key
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-customer-key"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.s_s_e_customer_key_m_d5
                     (fun f ->
                        Ezxmlm.make_tag
                          "x-amz-server-side-encryption-customer-key-MD5"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.s_s_e_k_m_s_key_id
                    (fun f ->
                       Ezxmlm.make_tag
                         "x-amz-server-side-encryption-aws-kms-key-id"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.s_s_e_k_m_s_encryption_context
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-server-side-encryption-context"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.request_payer
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-request-payer"
                       ([], (RequestPayer.to_xml f)))])
              @
              [Util.option_map v.tagging
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-tagging" ([], (String.to_xml f)))])
             @
             [Util.option_map v.object_lock_mode
                (fun f ->
                   Ezxmlm.make_tag "x-amz-object-lock-mode"
                     ([], (ObjectLockMode.to_xml f)))])
            @
            [Util.option_map v.object_lock_retain_until_date
               (fun f ->
                  Ezxmlm.make_tag "x-amz-object-lock-retain-until-date"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Ezxmlm.make_tag "x-amz-object-lock-legal-hold"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 ("object_lock_legal_hold_status",
                   (ObjectLockLegalHoldStatus.to_json f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                ("object_lock_retain_until_date", (DateTime.to_json f)));
           Util.option_map v.object_lock_mode
             (fun f -> ("object_lock_mode", (ObjectLockMode.to_json f)));
           Util.option_map v.tagging
             (fun f -> ("tagging", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.website_redirect_location
             (fun f -> ("website_redirect_location", (String.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (Metadata.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.expires
             (fun f -> ("expires", (DateTime.to_json f)));
           Util.option_map v.content_type
             (fun f -> ("content_type", (String.to_json f)));
           Util.option_map v.content_language
             (fun f -> ("content_language", (String.to_json f)));
           Util.option_map v.content_encoding
             (fun f -> ("content_encoding", (String.to_json f)));
           Util.option_map v.content_disposition
             (fun f -> ("content_disposition", (String.to_json f)));
           Util.option_map v.cache_control
             (fun f -> ("cache_control", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (ObjectCannedACL.to_json f)))])
    let of_json j =
      {
        a_c_l =
          (Util.option_map (Json.lookup j "a_c_l") ObjectCannedACL.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        cache_control =
          (Util.option_map (Json.lookup j "cache_control") String.of_json);
        content_disposition =
          (Util.option_map (Json.lookup j "content_disposition")
             String.of_json);
        content_encoding =
          (Util.option_map (Json.lookup j "content_encoding") String.of_json);
        content_language =
          (Util.option_map (Json.lookup j "content_language") String.of_json);
        content_type =
          (Util.option_map (Json.lookup j "content_type") String.of_json);
        expires =
          (Util.option_map (Json.lookup j "expires") DateTime.of_json);
        grant_full_control =
          (Util.option_map (Json.lookup j "grant_full_control")
             String.of_json);
        grant_read =
          (Util.option_map (Json.lookup j "grant_read") String.of_json);
        grant_read_a_c_p =
          (Util.option_map (Json.lookup j "grant_read_a_c_p") String.of_json);
        grant_write_a_c_p =
          (Util.option_map (Json.lookup j "grant_write_a_c_p") String.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        metadata =
          (Util.option_map (Json.lookup j "metadata") Metadata.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        website_redirect_location =
          (Util.option_map (Json.lookup j "website_redirect_location")
             String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_encryption_context")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        tagging = (Util.option_map (Json.lookup j "tagging") String.of_json);
        object_lock_mode =
          (Util.option_map (Json.lookup j "object_lock_mode")
             ObjectLockMode.of_json);
        object_lock_retain_until_date =
          (Util.option_map (Json.lookup j "object_lock_retain_until_date")
             DateTime.of_json);
        object_lock_legal_hold_status =
          (Util.option_map (Json.lookup j "object_lock_legal_hold_status")
             ObjectLockLegalHoldStatus.of_json)
      }
  end
module PutBucketPolicyRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      confirm_remove_self_bucket_access: Boolean.t option ;
      policy: String.t }
    let make ~bucket  ?content_m_d5  ?confirm_remove_self_bucket_access 
      ~policy  () =
      { bucket; content_m_d5; confirm_remove_self_bucket_access; policy }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          confirm_remove_self_bucket_access =
            (Util.option_bind
               (Xml.member "x-amz-confirm-remove-self-bucket-access" xml)
               Boolean.parse);
          policy =
            (Xml.required "Policy"
               (Util.option_bind (Xml.member "Policy" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.confirm_remove_self_bucket_access
              (fun f ->
                 Headers.Pair
                   ("x-amz-confirm-remove-self-bucket-access",
                     (Boolean.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @
             [Util.option_map v.content_m_d5
                (fun f ->
                   Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
            @
            [Util.option_map v.confirm_remove_self_bucket_access
               (fun f ->
                  Ezxmlm.make_tag "x-amz-confirm-remove-self-bucket-access"
                    ([], (Boolean.to_xml f)))])
           @ [Some (Ezxmlm.make_tag "Policy" ([], (String.to_xml v.policy)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("policy", (String.to_json v.policy));
           Util.option_map v.confirm_remove_self_bucket_access
             (fun f ->
                ("confirm_remove_self_bucket_access", (Boolean.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        confirm_remove_self_bucket_access =
          (Util.option_map
             (Json.lookup j "confirm_remove_self_bucket_access")
             Boolean.of_json);
        policy =
          (String.of_json (Util.of_option_exn (Json.lookup j "policy")))
      }
  end
module GetBucketAccelerateConfigurationOutput =
  struct
    type t = {
      status: BucketAccelerateStatus.t option }
    let make ?status  () = { status }
    let parse xml =
      Some
        {
          status =
            (Util.option_bind (Xml.member "Status" xml)
               BucketAccelerateStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.status
              (fun f ->
                 Ezxmlm.make_tag "Status"
                   ([], (BucketAccelerateStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.status
              (fun f -> ("status", (BucketAccelerateStatus.to_json f)))])
    let of_json j =
      {
        status =
          (Util.option_map (Json.lookup j "status")
             BucketAccelerateStatus.of_json)
      }
  end
module GetBucketAccelerateConfigurationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module PutBucketNotificationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      notification_configuration: NotificationConfigurationDeprecated.t }
    let make ~bucket  ?content_m_d5  ~notification_configuration  () =
      { bucket; content_m_d5; notification_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          notification_configuration =
            (Xml.required "NotificationConfiguration"
               (Util.option_bind (Xml.member "NotificationConfiguration" xml)
                  NotificationConfigurationDeprecated.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some
              (Ezxmlm.make_tag "NotificationConfiguration"
                 ([],
                   (NotificationConfigurationDeprecated.to_xml
                      v.notification_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("notification_configuration",
                (NotificationConfigurationDeprecated.to_json
                   v.notification_configuration));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        notification_configuration =
          (NotificationConfigurationDeprecated.of_json
             (Util.of_option_exn (Json.lookup j "notification_configuration")))
      }
  end
module PutObjectOutput =
  struct
    type t =
      {
      expiration: String.t option ;
      e_tag: String.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      version_id: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      s_s_e_k_m_s_encryption_context: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?expiration  ?e_tag  ?server_side_encryption  ?version_id 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key_m_d5 
      ?s_s_e_k_m_s_key_id  ?s_s_e_k_m_s_encryption_context  ?request_charged 
      () =
      {
        expiration;
        e_tag;
        server_side_encryption;
        version_id;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        request_charged
      }
    let parse xml =
      Some
        {
          expiration =
            (Util.option_bind (Xml.member "x-amz-expiration" xml)
               String.parse);
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.version_id
             (fun f ->
                Headers.Pair ("x-amz-version-id", (String.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.e_tag
             (fun f -> Headers.Pair ("ETag", (String.to_headers f)));
           Util.option_map v.expiration
             (fun f ->
                Headers.Pair ("x-amz-expiration", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.expiration
                      (fun f ->
                         Ezxmlm.make_tag "x-amz-expiration"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.e_tag
                     (fun f -> Ezxmlm.make_tag "ETag" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.server_side_encryption
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-server-side-encryption"
                         ([], (ServerSideEncryption.to_xml f)))])
                @
                [Util.option_map v.version_id
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-version-id"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.s_s_e_customer_algorithm
                  (fun f ->
                     Ezxmlm.make_tag
                       "x-amz-server-side-encryption-customer-algorithm"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_key_m_d5
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-key-MD5"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_k_m_s_key_id
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-aws-kms-key-id"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_k_m_s_encryption_context
               (fun f ->
                  Ezxmlm.make_tag "x-amz-server-side-encryption-context"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (String.to_json f)))])
    let of_json j =
      {
        expiration =
          (Util.option_map (Json.lookup j "expiration") String.of_json);
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_encryption_context")
             String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketTaggingOutput =
  struct
    type t = {
      tag_set: TagSet.t }
    let make ~tag_set  () = { tag_set }
    let parse xml =
      Some
        {
          tag_set =
            (Xml.required "TagSet"
               (Util.option_bind (Xml.member "TagSet" xml) TagSet.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "TagSet" ([], (TagSet.to_xml [x]))))
              v.tag_set))
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("tag_set", (TagSet.to_json v.tag_set))])
    let of_json j =
      {
        tag_set =
          (TagSet.of_json (Util.of_option_exn (Json.lookup j "tag_set")))
      }
  end
module SelectObjectContentOutput =
  struct
    type t = {
      payload: SelectObjectContentEventStream.t option }
    let make ?payload  () = { payload }
    let parse xml =
      Some
        {
          payload =
            (Util.option_bind (Xml.member "Payload" xml)
               SelectObjectContentEventStream.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.payload
              (fun f ->
                 Ezxmlm.make_tag "Payload"
                   ([], (SelectObjectContentEventStream.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.payload
              (fun f ->
                 ("payload", (SelectObjectContentEventStream.to_json f)))])
    let of_json j =
      {
        payload =
          (Util.option_map (Json.lookup j "payload")
             SelectObjectContentEventStream.of_json)
      }
  end
module GetObjectLegalHoldOutput =
  struct
    type t = {
      legal_hold: ObjectLockLegalHold.t option }
    let make ?legal_hold  () = { legal_hold }
    let parse xml =
      Some
        {
          legal_hold =
            (Util.option_bind (Xml.member "LegalHold" xml)
               ObjectLockLegalHold.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.legal_hold
              (fun f ->
                 Ezxmlm.make_tag "LegalHold"
                   ([], (ObjectLockLegalHold.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.legal_hold
              (fun f -> ("legal_hold", (ObjectLockLegalHold.to_json f)))])
    let of_json j =
      {
        legal_hold =
          (Util.option_map (Json.lookup j "legal_hold")
             ObjectLockLegalHold.of_json)
      }
  end
module GetObjectRetentionRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?version_id  ?request_payer  () =
      { bucket; key; version_id; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Util.option_map v.version_id
               (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module SelectObjectContentRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      expression: String.t ;
      expression_type: ExpressionType.t ;
      request_progress: RequestProgress.t option ;
      input_serialization: InputSerialization.t ;
      output_serialization: OutputSerialization.t ;
      scan_range: ScanRange.t option }
    let make ~bucket  ~key  ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ~expression  ~expression_type 
      ?request_progress  ~input_serialization  ~output_serialization 
      ?scan_range  () =
      {
        bucket;
        key;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        expression;
        expression_type;
        request_progress;
        input_serialization;
        output_serialization;
        scan_range
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          expression =
            (Xml.required "Expression"
               (Util.option_bind (Xml.member "Expression" xml) String.parse));
          expression_type =
            (Xml.required "ExpressionType"
               (Util.option_bind (Xml.member "ExpressionType" xml)
                  ExpressionType.parse));
          request_progress =
            (Util.option_bind (Xml.member "RequestProgress" xml)
               RequestProgress.parse);
          input_serialization =
            (Xml.required "InputSerialization"
               (Util.option_bind (Xml.member "InputSerialization" xml)
                  InputSerialization.parse));
          output_serialization =
            (Xml.required "OutputSerialization"
               (Util.option_bind (Xml.member "OutputSerialization" xml)
                  OutputSerialization.parse));
          scan_range =
            (Util.option_bind (Xml.member "ScanRange" xml) ScanRange.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.s_s_e_customer_key_m_d5
              (fun f ->
                 Headers.Pair
                   ("x-amz-server-side-encryption-customer-key-MD5",
                     (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((([] @
                     [Some
                        (Ezxmlm.make_tag "Bucket"
                           ([], (String.to_xml v.bucket)))])
                    @
                    [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
                   @
                   [Util.option_map v.s_s_e_customer_algorithm
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-customer-algorithm"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.s_s_e_customer_key
                     (fun f ->
                        Ezxmlm.make_tag
                          "x-amz-server-side-encryption-customer-key"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.s_s_e_customer_key_m_d5
                    (fun f ->
                       Ezxmlm.make_tag
                         "x-amz-server-side-encryption-customer-key-MD5"
                         ([], (String.to_xml f)))])
                @
                [Some
                   (Ezxmlm.make_tag "Expression"
                      ([], (String.to_xml v.expression)))])
               @
               [Some
                  (Ezxmlm.make_tag "ExpressionType"
                     ([], (ExpressionType.to_xml v.expression_type)))])
              @
              [Util.option_map v.request_progress
                 (fun f ->
                    Ezxmlm.make_tag "RequestProgress"
                      ([], (RequestProgress.to_xml f)))])
             @
             [Some
                (Ezxmlm.make_tag "InputSerialization"
                   ([], (InputSerialization.to_xml v.input_serialization)))])
            @
            [Some
               (Ezxmlm.make_tag "OutputSerialization"
                  ([], (OutputSerialization.to_xml v.output_serialization)))])
           @
           [Util.option_map v.scan_range
              (fun f ->
                 Ezxmlm.make_tag "ScanRange" ([], (ScanRange.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.scan_range
              (fun f -> ("scan_range", (ScanRange.to_json f)));
           Some
             ("output_serialization",
               (OutputSerialization.to_json v.output_serialization));
           Some
             ("input_serialization",
               (InputSerialization.to_json v.input_serialization));
           Util.option_map v.request_progress
             (fun f -> ("request_progress", (RequestProgress.to_json f)));
           Some
             ("expression_type", (ExpressionType.to_json v.expression_type));
           Some ("expression", (String.to_json v.expression));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        expression =
          (String.of_json (Util.of_option_exn (Json.lookup j "expression")));
        expression_type =
          (ExpressionType.of_json
             (Util.of_option_exn (Json.lookup j "expression_type")));
        request_progress =
          (Util.option_map (Json.lookup j "request_progress")
             RequestProgress.of_json);
        input_serialization =
          (InputSerialization.of_json
             (Util.of_option_exn (Json.lookup j "input_serialization")));
        output_serialization =
          (OutputSerialization.of_json
             (Util.of_option_exn (Json.lookup j "output_serialization")));
        scan_range =
          (Util.option_map (Json.lookup j "scan_range") ScanRange.of_json)
      }
  end
module ListObjectsV2Request =
  struct
    type t =
      {
      bucket: String.t ;
      delimiter: String.t option ;
      encoding_type: EncodingType.t option ;
      max_keys: Integer.t option ;
      prefix: String.t option ;
      continuation_token: String.t option ;
      fetch_owner: Boolean.t option ;
      start_after: String.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ?delimiter  ?encoding_type  ?max_keys  ?prefix 
      ?continuation_token  ?fetch_owner  ?start_after  ?request_payer  () =
      {
        bucket;
        delimiter;
        encoding_type;
        max_keys;
        prefix;
        continuation_token;
        fetch_owner;
        start_after;
        request_payer
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          delimiter =
            (Util.option_bind (Xml.member "delimiter" xml) String.parse);
          encoding_type =
            (Util.option_bind (Xml.member "encoding-type" xml)
               EncodingType.parse);
          max_keys =
            (Util.option_bind (Xml.member "max-keys" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          continuation_token =
            (Util.option_bind (Xml.member "continuation-token" xml)
               String.parse);
          fetch_owner =
            (Util.option_bind (Xml.member "fetch-owner" xml) Boolean.parse);
          start_after =
            (Util.option_bind (Xml.member "start-after" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.start_after
              (fun f -> Query.Pair ("start-after", (String.to_query f)));
           Util.option_map v.fetch_owner
             (fun f -> Query.Pair ("fetch-owner", (Boolean.to_query f)));
           Util.option_map v.continuation_token
             (fun f -> Query.Pair ("continuation-token", (String.to_query f)));
           Util.option_map v.prefix
             (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_keys
             (fun f -> Query.Pair ("max-keys", (Integer.to_query f)));
           Util.option_map v.encoding_type
             (fun f ->
                Query.Pair ("encoding-type", (EncodingType.to_query f)));
           Util.option_map v.delimiter
             (fun f -> Query.Pair ("delimiter", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Some
                      (Ezxmlm.make_tag "Bucket"
                         ([], (String.to_xml v.bucket)))])
                  @
                  [Util.option_map v.delimiter
                     (fun f ->
                        Ezxmlm.make_tag "delimiter" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.encoding_type
                    (fun f ->
                       Ezxmlm.make_tag "encoding-type"
                         ([], (EncodingType.to_xml f)))])
                @
                [Util.option_map v.max_keys
                   (fun f ->
                      Ezxmlm.make_tag "max-keys" ([], (Integer.to_xml f)))])
               @
               [Util.option_map v.prefix
                  (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
              @
              [Util.option_map v.continuation_token
                 (fun f ->
                    Ezxmlm.make_tag "continuation-token"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.fetch_owner
                (fun f ->
                   Ezxmlm.make_tag "fetch-owner" ([], (Boolean.to_xml f)))])
            @
            [Util.option_map v.start_after
               (fun f ->
                  Ezxmlm.make_tag "start-after" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.start_after
             (fun f -> ("start_after", (String.to_json f)));
           Util.option_map v.fetch_owner
             (fun f -> ("fetch_owner", (Boolean.to_json f)));
           Util.option_map v.continuation_token
             (fun f -> ("continuation_token", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.encoding_type
             (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json);
        max_keys =
          (Util.option_map (Json.lookup j "max_keys") Integer.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        continuation_token =
          (Util.option_map (Json.lookup j "continuation_token")
             String.of_json);
        fetch_owner =
          (Util.option_map (Json.lookup j "fetch_owner") Boolean.of_json);
        start_after =
          (Util.option_map (Json.lookup j "start_after") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module DeleteObjectsOutput =
  struct
    type t =
      {
      deleted: DeletedObjects.t ;
      request_charged: RequestCharged.t option ;
      errors: Errors.t }
    let make ?(deleted= [])  ?request_charged  ?(errors= [])  () =
      { deleted; request_charged; errors }
    let parse xml =
      Some
        {
          deleted = (Util.of_option [] (DeletedObjects.parse xml));
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse);
          errors = (Util.of_option [] (Errors.parse xml))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Deleted"
                        ([], (DeletedObjects.to_xml [x])))) v.deleted))
            @
            [Util.option_map v.request_charged
               (fun f ->
                  Ezxmlm.make_tag "x-amz-request-charged"
                    ([], (RequestCharged.to_xml f)))])
           @
           (List.map
              (fun x ->
                 Some (Ezxmlm.make_tag "Error" ([], (Errors.to_xml [x]))))
              v.errors))
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("errors", (Errors.to_json v.errors));
           Util.option_map v.request_charged
             (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Some ("deleted", (DeletedObjects.to_json v.deleted))])
    let of_json j =
      {
        deleted =
          (DeletedObjects.of_json
             (Util.of_option_exn (Json.lookup j "deleted")));
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json);
        errors =
          (Errors.of_json (Util.of_option_exn (Json.lookup j "errors")))
      }
  end
module PutBucketInventoryConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      id: String.t ;
      inventory_configuration: InventoryConfiguration.t }
    let make ~bucket  ~id  ~inventory_configuration  () =
      { bucket; id; inventory_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse));
          inventory_configuration =
            (Xml.required "InventoryConfiguration"
               (Util.option_bind (Xml.member "InventoryConfiguration" xml)
                  InventoryConfiguration.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
           @
           [Some
              (Ezxmlm.make_tag "InventoryConfiguration"
                 ([],
                   (InventoryConfiguration.to_xml v.inventory_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("inventory_configuration",
                (InventoryConfiguration.to_json v.inventory_configuration));
           Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")));
        inventory_configuration =
          (InventoryConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "inventory_configuration")))
      }
  end
module UploadPartCopyOutput =
  struct
    type t =
      {
      copy_source_version_id: String.t option ;
      copy_part_result: CopyPartResult.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?copy_source_version_id  ?copy_part_result 
      ?server_side_encryption  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id  ?request_charged  () =
      {
        copy_source_version_id;
        copy_part_result;
        server_side_encryption;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        request_charged
      }
    let parse xml =
      Some
        {
          copy_source_version_id =
            (Util.option_bind (Xml.member "x-amz-copy-source-version-id" xml)
               String.parse);
          copy_part_result =
            (Util.option_bind (Xml.member "CopyPartResult" xml)
               CopyPartResult.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.copy_source_version_id
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-version-id", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Util.option_map v.copy_source_version_id
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-copy-source-version-id"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.copy_part_result
                   (fun f ->
                      Ezxmlm.make_tag "CopyPartResult"
                        ([], (CopyPartResult.to_xml f)))])
               @
               [Util.option_map v.server_side_encryption
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-server-side-encryption"
                       ([], (ServerSideEncryption.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_algorithm
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-algorithm"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_customer_key_m_d5
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-customer-key-MD5"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_k_m_s_key_id
               (fun f ->
                  Ezxmlm.make_tag
                    "x-amz-server-side-encryption-aws-kms-key-id"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.copy_part_result
             (fun f -> ("copy_part_result", (CopyPartResult.to_json f)));
           Util.option_map v.copy_source_version_id
             (fun f -> ("copy_source_version_id", (String.to_json f)))])
    let of_json j =
      {
        copy_source_version_id =
          (Util.option_map (Json.lookup j "copy_source_version_id")
             String.of_json);
        copy_part_result =
          (Util.option_map (Json.lookup j "copy_part_result")
             CopyPartResult.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketAnalyticsConfigurationRequest =
  struct
    type t = {
      bucket: String.t ;
      id: String.t }
    let make ~bucket  ~id  () = { bucket; id }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          id =
            (Xml.required "id"
               (Util.option_bind (Xml.member "id" xml) String.parse))
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Some (Query.Pair ("id", (String.to_query v.id)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @ [Some (Ezxmlm.make_tag "id" ([], (String.to_xml v.id)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("id", (String.to_json v.id));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        id = (String.of_json (Util.of_option_exn (Json.lookup j "id")))
      }
  end
module ListObjectsRequest =
  struct
    type t =
      {
      bucket: String.t ;
      delimiter: String.t option ;
      encoding_type: EncodingType.t option ;
      marker: String.t option ;
      max_keys: Integer.t option ;
      prefix: String.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ?delimiter  ?encoding_type  ?marker  ?max_keys  ?prefix
       ?request_payer  () =
      {
        bucket;
        delimiter;
        encoding_type;
        marker;
        max_keys;
        prefix;
        request_payer
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          delimiter =
            (Util.option_bind (Xml.member "delimiter" xml) String.parse);
          encoding_type =
            (Util.option_bind (Xml.member "encoding-type" xml)
               EncodingType.parse);
          marker = (Util.option_bind (Xml.member "marker" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "max-keys" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.prefix
              (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_keys
             (fun f -> Query.Pair ("max-keys", (Integer.to_query f)));
           Util.option_map v.marker
             (fun f -> Query.Pair ("marker", (String.to_query f)));
           Util.option_map v.encoding_type
             (fun f ->
                Query.Pair ("encoding-type", (EncodingType.to_query f)));
           Util.option_map v.delimiter
             (fun f -> Query.Pair ("delimiter", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @
                [Util.option_map v.delimiter
                   (fun f ->
                      Ezxmlm.make_tag "delimiter" ([], (String.to_xml f)))])
               @
               [Util.option_map v.encoding_type
                  (fun f ->
                     Ezxmlm.make_tag "encoding-type"
                       ([], (EncodingType.to_xml f)))])
              @
              [Util.option_map v.marker
                 (fun f -> Ezxmlm.make_tag "marker" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_keys
                (fun f -> Ezxmlm.make_tag "max-keys" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.marker (fun f -> ("marker", (String.to_json f)));
           Util.option_map v.encoding_type
             (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json);
        marker = (Util.option_map (Json.lookup j "marker") String.of_json);
        max_keys =
          (Util.option_map (Json.lookup j "max_keys") Integer.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module PutObjectRequest =
  struct
    type t =
      {
      a_c_l: ObjectCannedACL.t option ;
      body: Blob.t option ;
      bucket: String.t ;
      cache_control: String.t option ;
      content_disposition: String.t option ;
      content_encoding: String.t option ;
      content_language: String.t option ;
      content_length: Long.t option ;
      content_m_d5: String.t option ;
      content_type: String.t option ;
      expires: DateTime.t option ;
      grant_full_control: String.t option ;
      grant_read: String.t option ;
      grant_read_a_c_p: String.t option ;
      grant_write_a_c_p: String.t option ;
      key: String.t ;
      metadata: Metadata.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      storage_class: StorageClass.t option ;
      website_redirect_location: String.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      s_s_e_k_m_s_encryption_context: String.t option ;
      request_payer: RequestPayer.t option ;
      tagging: String.t option ;
      object_lock_mode: ObjectLockMode.t option ;
      object_lock_retain_until_date: DateTime.t option ;
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option }
    let make ?a_c_l  ?body  ~bucket  ?cache_control  ?content_disposition 
      ?content_encoding  ?content_language  ?content_length  ?content_m_d5 
      ?content_type  ?expires  ?grant_full_control  ?grant_read 
      ?grant_read_a_c_p  ?grant_write_a_c_p  ~key  ?metadata 
      ?server_side_encryption  ?storage_class  ?website_redirect_location 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?request_payer  ?tagging 
      ?object_lock_mode  ?object_lock_retain_until_date 
      ?object_lock_legal_hold_status  () =
      {
        a_c_l;
        body;
        bucket;
        cache_control;
        content_disposition;
        content_encoding;
        content_language;
        content_length;
        content_m_d5;
        content_type;
        expires;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write_a_c_p;
        key;
        metadata;
        server_side_encryption;
        storage_class;
        website_redirect_location;
        s_s_e_customer_algorithm;
        s_s_e_customer_key;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        request_payer;
        tagging;
        object_lock_mode;
        object_lock_retain_until_date;
        object_lock_legal_hold_status
      }
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               ObjectCannedACL.parse);
          body = (Util.option_bind (Xml.member "Body" xml) Blob.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          cache_control =
            (Util.option_bind (Xml.member "Cache-Control" xml) String.parse);
          content_disposition =
            (Util.option_bind (Xml.member "Content-Disposition" xml)
               String.parse);
          content_encoding =
            (Util.option_bind (Xml.member "Content-Encoding" xml)
               String.parse);
          content_language =
            (Util.option_bind (Xml.member "Content-Language" xml)
               String.parse);
          content_length =
            (Util.option_bind (Xml.member "Content-Length" xml) Long.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          content_type =
            (Util.option_bind (Xml.member "Content-Type" xml) String.parse);
          expires =
            (Util.option_bind (Xml.member "Expires" xml) DateTime.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse);
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          metadata =
            (Util.option_bind (Xml.member "x-amz-meta-" xml) Metadata.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          storage_class =
            (Util.option_bind (Xml.member "x-amz-storage-class" xml)
               StorageClass.parse);
          website_redirect_location =
            (Util.option_bind
               (Xml.member "x-amz-website-redirect-location" xml)
               String.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key" xml)
               String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          tagging =
            (Util.option_bind (Xml.member "x-amz-tagging" xml) String.parse);
          object_lock_mode =
            (Util.option_bind (Xml.member "x-amz-object-lock-mode" xml)
               ObjectLockMode.parse);
          object_lock_retain_until_date =
            (Util.option_bind
               (Xml.member "x-amz-object-lock-retain-until-date" xml)
               DateTime.parse);
          object_lock_legal_hold_status =
            (Util.option_bind (Xml.member "x-amz-object-lock-legal-hold" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Headers.Pair
                   ("x-amz-object-lock-legal-hold",
                     (ObjectLockLegalHoldStatus.to_headers f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-retain-until-date",
                    (DateTime.to_headers f)));
           Util.option_map v.object_lock_mode
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-mode", (ObjectLockMode.to_headers f)));
           Util.option_map v.tagging
             (fun f -> Headers.Pair ("x-amz-tagging", (String.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.website_redirect_location
             (fun f ->
                Headers.Pair
                  ("x-amz-website-redirect-location", (String.to_headers f)));
           Util.option_map v.storage_class
             (fun f ->
                Headers.Pair
                  ("x-amz-storage-class", (StorageClass.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.metadata
             (fun f -> Headers.Pair ("x-amz-meta-", (Metadata.to_headers f)));
           Util.option_map v.grant_write_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.expires
             (fun f -> Headers.Pair ("Expires", (DateTime.to_headers f)));
           Util.option_map v.content_type
             (fun f -> Headers.Pair ("Content-Type", (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.content_length
             (fun f -> Headers.Pair ("Content-Length", (Long.to_headers f)));
           Util.option_map v.content_language
             (fun f ->
                Headers.Pair ("Content-Language", (String.to_headers f)));
           Util.option_map v.content_encoding
             (fun f ->
                Headers.Pair ("Content-Encoding", (String.to_headers f)));
           Util.option_map v.content_disposition
             (fun f ->
                Headers.Pair ("Content-Disposition", (String.to_headers f)));
           Util.option_map v.cache_control
             (fun f -> Headers.Pair ("Cache-Control", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (ObjectCannedACL.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((((((((((((((((((([] @
                                        [Util.option_map v.a_c_l
                                           (fun f ->
                                              Ezxmlm.make_tag "x-amz-acl"
                                                ([],
                                                  (ObjectCannedACL.to_xml f)))])
                                       @
                                       [Util.option_map v.body
                                          (fun f ->
                                             Ezxmlm.make_tag "Body"
                                               ([], (Blob.to_xml f)))])
                                      @
                                      [Some
                                         (Ezxmlm.make_tag "Bucket"
                                            ([], (String.to_xml v.bucket)))])
                                     @
                                     [Util.option_map v.cache_control
                                        (fun f ->
                                           Ezxmlm.make_tag "Cache-Control"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.content_disposition
                                       (fun f ->
                                          Ezxmlm.make_tag
                                            "Content-Disposition"
                                            ([], (String.to_xml f)))])
                                   @
                                   [Util.option_map v.content_encoding
                                      (fun f ->
                                         Ezxmlm.make_tag "Content-Encoding"
                                           ([], (String.to_xml f)))])
                                  @
                                  [Util.option_map v.content_language
                                     (fun f ->
                                        Ezxmlm.make_tag "Content-Language"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.content_length
                                    (fun f ->
                                       Ezxmlm.make_tag "Content-Length"
                                         ([], (Long.to_xml f)))])
                                @
                                [Util.option_map v.content_m_d5
                                   (fun f ->
                                      Ezxmlm.make_tag "Content-MD5"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.content_type
                                  (fun f ->
                                     Ezxmlm.make_tag "Content-Type"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.expires
                                 (fun f ->
                                    Ezxmlm.make_tag "Expires"
                                      ([], (DateTime.to_xml f)))])
                             @
                             [Util.option_map v.grant_full_control
                                (fun f ->
                                   Ezxmlm.make_tag "x-amz-grant-full-control"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.grant_read
                               (fun f ->
                                  Ezxmlm.make_tag "x-amz-grant-read"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.grant_read_a_c_p
                              (fun f ->
                                 Ezxmlm.make_tag "x-amz-grant-read-acp"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.grant_write_a_c_p
                             (fun f ->
                                Ezxmlm.make_tag "x-amz-grant-write-acp"
                                  ([], (String.to_xml f)))])
                         @
                         [Some
                            (Ezxmlm.make_tag "Key"
                               ([], (String.to_xml v.key)))])
                        @
                        [Util.option_map v.metadata
                           (fun f ->
                              Ezxmlm.make_tag "x-amz-meta-"
                                ([], (Metadata.to_xml f)))])
                       @
                       [Util.option_map v.server_side_encryption
                          (fun f ->
                             Ezxmlm.make_tag "x-amz-server-side-encryption"
                               ([], (ServerSideEncryption.to_xml f)))])
                      @
                      [Util.option_map v.storage_class
                         (fun f ->
                            Ezxmlm.make_tag "x-amz-storage-class"
                              ([], (StorageClass.to_xml f)))])
                     @
                     [Util.option_map v.website_redirect_location
                        (fun f ->
                           Ezxmlm.make_tag "x-amz-website-redirect-location"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.s_s_e_customer_algorithm
                       (fun f ->
                          Ezxmlm.make_tag
                            "x-amz-server-side-encryption-customer-algorithm"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.s_s_e_customer_key
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-customer-key"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.s_s_e_customer_key_m_d5
                     (fun f ->
                        Ezxmlm.make_tag
                          "x-amz-server-side-encryption-customer-key-MD5"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.s_s_e_k_m_s_key_id
                    (fun f ->
                       Ezxmlm.make_tag
                         "x-amz-server-side-encryption-aws-kms-key-id"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.s_s_e_k_m_s_encryption_context
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-server-side-encryption-context"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.request_payer
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-request-payer"
                       ([], (RequestPayer.to_xml f)))])
              @
              [Util.option_map v.tagging
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-tagging" ([], (String.to_xml f)))])
             @
             [Util.option_map v.object_lock_mode
                (fun f ->
                   Ezxmlm.make_tag "x-amz-object-lock-mode"
                     ([], (ObjectLockMode.to_xml f)))])
            @
            [Util.option_map v.object_lock_retain_until_date
               (fun f ->
                  Ezxmlm.make_tag "x-amz-object-lock-retain-until-date"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Ezxmlm.make_tag "x-amz-object-lock-legal-hold"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 ("object_lock_legal_hold_status",
                   (ObjectLockLegalHoldStatus.to_json f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                ("object_lock_retain_until_date", (DateTime.to_json f)));
           Util.option_map v.object_lock_mode
             (fun f -> ("object_lock_mode", (ObjectLockMode.to_json f)));
           Util.option_map v.tagging
             (fun f -> ("tagging", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key
             (fun f -> ("s_s_e_customer_key", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.website_redirect_location
             (fun f -> ("website_redirect_location", (String.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (Metadata.to_json f)));
           Some ("key", (String.to_json v.key));
           Util.option_map v.grant_write_a_c_p
             (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.expires
             (fun f -> ("expires", (DateTime.to_json f)));
           Util.option_map v.content_type
             (fun f -> ("content_type", (String.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.content_length
             (fun f -> ("content_length", (Long.to_json f)));
           Util.option_map v.content_language
             (fun f -> ("content_language", (String.to_json f)));
           Util.option_map v.content_encoding
             (fun f -> ("content_encoding", (String.to_json f)));
           Util.option_map v.content_disposition
             (fun f -> ("content_disposition", (String.to_json f)));
           Util.option_map v.cache_control
             (fun f -> ("cache_control", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.body (fun f -> ("body", (Blob.to_json f)));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (ObjectCannedACL.to_json f)))])
    let of_json j =
      {
        a_c_l =
          (Util.option_map (Json.lookup j "a_c_l") ObjectCannedACL.of_json);
        body = (Util.option_map (Json.lookup j "body") Blob.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        cache_control =
          (Util.option_map (Json.lookup j "cache_control") String.of_json);
        content_disposition =
          (Util.option_map (Json.lookup j "content_disposition")
             String.of_json);
        content_encoding =
          (Util.option_map (Json.lookup j "content_encoding") String.of_json);
        content_language =
          (Util.option_map (Json.lookup j "content_language") String.of_json);
        content_length =
          (Util.option_map (Json.lookup j "content_length") Long.of_json);
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        content_type =
          (Util.option_map (Json.lookup j "content_type") String.of_json);
        expires =
          (Util.option_map (Json.lookup j "expires") DateTime.of_json);
        grant_full_control =
          (Util.option_map (Json.lookup j "grant_full_control")
             String.of_json);
        grant_read =
          (Util.option_map (Json.lookup j "grant_read") String.of_json);
        grant_read_a_c_p =
          (Util.option_map (Json.lookup j "grant_read_a_c_p") String.of_json);
        grant_write_a_c_p =
          (Util.option_map (Json.lookup j "grant_write_a_c_p") String.of_json);
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        metadata =
          (Util.option_map (Json.lookup j "metadata") Metadata.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        website_redirect_location =
          (Util.option_map (Json.lookup j "website_redirect_location")
             String.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key =
          (Util.option_map (Json.lookup j "s_s_e_customer_key")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_encryption_context")
             String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        tagging = (Util.option_map (Json.lookup j "tagging") String.of_json);
        object_lock_mode =
          (Util.option_map (Json.lookup j "object_lock_mode")
             ObjectLockMode.of_json);
        object_lock_retain_until_date =
          (Util.option_map (Json.lookup j "object_lock_retain_until_date")
             DateTime.of_json);
        object_lock_legal_hold_status =
          (Util.option_map (Json.lookup j "object_lock_legal_hold_status")
             ObjectLockLegalHoldStatus.of_json)
      }
  end
module PutBucketAclRequest =
  struct
    type t =
      {
      a_c_l: BucketCannedACL.t option ;
      access_control_policy: AccessControlPolicy.t option ;
      bucket: String.t ;
      content_m_d5: String.t option ;
      grant_full_control: String.t option ;
      grant_read: String.t option ;
      grant_read_a_c_p: String.t option ;
      grant_write: String.t option ;
      grant_write_a_c_p: String.t option }
    let make ?a_c_l  ?access_control_policy  ~bucket  ?content_m_d5 
      ?grant_full_control  ?grant_read  ?grant_read_a_c_p  ?grant_write 
      ?grant_write_a_c_p  () =
      {
        a_c_l;
        access_control_policy;
        bucket;
        content_m_d5;
        grant_full_control;
        grant_read;
        grant_read_a_c_p;
        grant_write;
        grant_write_a_c_p
      }
    let parse xml =
      Some
        {
          a_c_l =
            (Util.option_bind (Xml.member "x-amz-acl" xml)
               BucketCannedACL.parse);
          access_control_policy =
            (Util.option_bind (Xml.member "AccessControlPolicy" xml)
               AccessControlPolicy.parse);
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          grant_full_control =
            (Util.option_bind (Xml.member "x-amz-grant-full-control" xml)
               String.parse);
          grant_read =
            (Util.option_bind (Xml.member "x-amz-grant-read" xml)
               String.parse);
          grant_read_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-read-acp" xml)
               String.parse);
          grant_write =
            (Util.option_bind (Xml.member "x-amz-grant-write" xml)
               String.parse);
          grant_write_a_c_p =
            (Util.option_bind (Xml.member "x-amz-grant-write-acp" xml)
               String.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.grant_write_a_c_p
              (fun f ->
                 Headers.Pair
                   ("x-amz-grant-write-acp", (String.to_headers f)));
           Util.option_map v.grant_write
             (fun f ->
                Headers.Pair ("x-amz-grant-write", (String.to_headers f)));
           Util.option_map v.grant_read_a_c_p
             (fun f ->
                Headers.Pair ("x-amz-grant-read-acp", (String.to_headers f)));
           Util.option_map v.grant_read
             (fun f ->
                Headers.Pair ("x-amz-grant-read", (String.to_headers f)));
           Util.option_map v.grant_full_control
             (fun f ->
                Headers.Pair
                  ("x-amz-grant-full-control", (String.to_headers f)));
           Util.option_map v.content_m_d5
             (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.a_c_l
             (fun f ->
                Headers.Pair ("x-amz-acl", (BucketCannedACL.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((([] @
                   [Util.option_map v.a_c_l
                      (fun f ->
                         Ezxmlm.make_tag "x-amz-acl"
                           ([], (BucketCannedACL.to_xml f)))])
                  @
                  [Util.option_map v.access_control_policy
                     (fun f ->
                        Ezxmlm.make_tag "AccessControlPolicy"
                          ([], (AccessControlPolicy.to_xml f)))])
                 @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @
                [Util.option_map v.content_m_d5
                   (fun f ->
                      Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
               @
               [Util.option_map v.grant_full_control
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-grant-full-control"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.grant_read
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-grant-read"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.grant_read_a_c_p
                (fun f ->
                   Ezxmlm.make_tag "x-amz-grant-read-acp"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.grant_write
               (fun f ->
                  Ezxmlm.make_tag "x-amz-grant-write" ([], (String.to_xml f)))])
           @
           [Util.option_map v.grant_write_a_c_p
              (fun f ->
                 Ezxmlm.make_tag "x-amz-grant-write-acp"
                   ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.grant_write_a_c_p
              (fun f -> ("grant_write_a_c_p", (String.to_json f)));
           Util.option_map v.grant_write
             (fun f -> ("grant_write", (String.to_json f)));
           Util.option_map v.grant_read_a_c_p
             (fun f -> ("grant_read_a_c_p", (String.to_json f)));
           Util.option_map v.grant_read
             (fun f -> ("grant_read", (String.to_json f)));
           Util.option_map v.grant_full_control
             (fun f -> ("grant_full_control", (String.to_json f)));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket));
           Util.option_map v.access_control_policy
             (fun f ->
                ("access_control_policy", (AccessControlPolicy.to_json f)));
           Util.option_map v.a_c_l
             (fun f -> ("a_c_l", (BucketCannedACL.to_json f)))])
    let of_json j =
      {
        a_c_l =
          (Util.option_map (Json.lookup j "a_c_l") BucketCannedACL.of_json);
        access_control_policy =
          (Util.option_map (Json.lookup j "access_control_policy")
             AccessControlPolicy.of_json);
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        grant_full_control =
          (Util.option_map (Json.lookup j "grant_full_control")
             String.of_json);
        grant_read =
          (Util.option_map (Json.lookup j "grant_read") String.of_json);
        grant_read_a_c_p =
          (Util.option_map (Json.lookup j "grant_read_a_c_p") String.of_json);
        grant_write =
          (Util.option_map (Json.lookup j "grant_write") String.of_json);
        grant_write_a_c_p =
          (Util.option_map (Json.lookup j "grant_write_a_c_p") String.of_json)
      }
  end
module GetObjectAclRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      version_id: String.t option ;
      request_payer: RequestPayer.t option }
    let make ~bucket  ~key  ?version_id  ?request_payer  () =
      { bucket; key; version_id; request_payer }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((([] @
              [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
             @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
            @
            [Util.option_map v.version_id
               (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_payer
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-payer"
                   ([], (RequestPayer.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_payer
              (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json)
      }
  end
module PutBucketLifecycleConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      lifecycle_configuration: BucketLifecycleConfiguration.t option }
    let make ~bucket  ?lifecycle_configuration  () =
      { bucket; lifecycle_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          lifecycle_configuration =
            (Util.option_bind (Xml.member "LifecycleConfiguration" xml)
               BucketLifecycleConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Util.option_map v.lifecycle_configuration
              (fun f ->
                 Ezxmlm.make_tag "LifecycleConfiguration"
                   ([], (BucketLifecycleConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.lifecycle_configuration
              (fun f ->
                 ("lifecycle_configuration",
                   (BucketLifecycleConfiguration.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        lifecycle_configuration =
          (Util.option_map (Json.lookup j "lifecycle_configuration")
             BucketLifecycleConfiguration.of_json)
      }
  end
module GetBucketMetricsConfigurationOutput =
  struct
    type t = {
      metrics_configuration: MetricsConfiguration.t option }
    let make ?metrics_configuration  () = { metrics_configuration }
    let parse xml =
      Some
        {
          metrics_configuration =
            (Util.option_bind (Xml.member "MetricsConfiguration" xml)
               MetricsConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.metrics_configuration
              (fun f ->
                 Ezxmlm.make_tag "MetricsConfiguration"
                   ([], (MetricsConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.metrics_configuration
              (fun f ->
                 ("metrics_configuration", (MetricsConfiguration.to_json f)))])
    let of_json j =
      {
        metrics_configuration =
          (Util.option_map (Json.lookup j "metrics_configuration")
             MetricsConfiguration.of_json)
      }
  end
module ListPartsOutput =
  struct
    type t =
      {
      abort_date: DateTime.t option ;
      abort_rule_id: String.t option ;
      bucket: String.t option ;
      key: String.t option ;
      upload_id: String.t option ;
      part_number_marker: Integer.t option ;
      next_part_number_marker: Integer.t option ;
      max_parts: Integer.t option ;
      is_truncated: Boolean.t option ;
      parts: Parts.t ;
      initiator: Initiator.t option ;
      owner: Owner.t option ;
      storage_class: StorageClass.t option ;
      request_charged: RequestCharged.t option }
    let make ?abort_date  ?abort_rule_id  ?bucket  ?key  ?upload_id 
      ?part_number_marker  ?next_part_number_marker  ?max_parts 
      ?is_truncated  ?(parts= [])  ?initiator  ?owner  ?storage_class 
      ?request_charged  () =
      {
        abort_date;
        abort_rule_id;
        bucket;
        key;
        upload_id;
        part_number_marker;
        next_part_number_marker;
        max_parts;
        is_truncated;
        parts;
        initiator;
        owner;
        storage_class;
        request_charged
      }
    let parse xml =
      Some
        {
          abort_date =
            (Util.option_bind (Xml.member "x-amz-abort-date" xml)
               DateTime.parse);
          abort_rule_id =
            (Util.option_bind (Xml.member "x-amz-abort-rule-id" xml)
               String.parse);
          bucket = (Util.option_bind (Xml.member "Bucket" xml) String.parse);
          key = (Util.option_bind (Xml.member "Key" xml) String.parse);
          upload_id =
            (Util.option_bind (Xml.member "UploadId" xml) String.parse);
          part_number_marker =
            (Util.option_bind (Xml.member "PartNumberMarker" xml)
               Integer.parse);
          next_part_number_marker =
            (Util.option_bind (Xml.member "NextPartNumberMarker" xml)
               Integer.parse);
          max_parts =
            (Util.option_bind (Xml.member "MaxParts" xml) Integer.parse);
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          parts = (Util.of_option [] (Parts.parse xml));
          initiator =
            (Util.option_bind (Xml.member "Initiator" xml) Initiator.parse);
          owner = (Util.option_bind (Xml.member "Owner" xml) Owner.parse);
          storage_class =
            (Util.option_bind (Xml.member "StorageClass" xml)
               StorageClass.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.abort_rule_id
             (fun f ->
                Headers.Pair ("x-amz-abort-rule-id", (String.to_headers f)));
           Util.option_map v.abort_date
             (fun f ->
                Headers.Pair ("x-amz-abort-date", (DateTime.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((((([] @
                        [Util.option_map v.abort_date
                           (fun f ->
                              Ezxmlm.make_tag "x-amz-abort-date"
                                ([], (DateTime.to_xml f)))])
                       @
                       [Util.option_map v.abort_rule_id
                          (fun f ->
                             Ezxmlm.make_tag "x-amz-abort-rule-id"
                               ([], (String.to_xml f)))])
                      @
                      [Util.option_map v.bucket
                         (fun f ->
                            Ezxmlm.make_tag "Bucket" ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.key
                        (fun f ->
                           Ezxmlm.make_tag "Key" ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.upload_id
                       (fun f ->
                          Ezxmlm.make_tag "UploadId" ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.part_number_marker
                      (fun f ->
                         Ezxmlm.make_tag "PartNumberMarker"
                           ([], (Integer.to_xml f)))])
                  @
                  [Util.option_map v.next_part_number_marker
                     (fun f ->
                        Ezxmlm.make_tag "NextPartNumberMarker"
                          ([], (Integer.to_xml f)))])
                 @
                 [Util.option_map v.max_parts
                    (fun f ->
                       Ezxmlm.make_tag "MaxParts" ([], (Integer.to_xml f)))])
                @
                [Util.option_map v.is_truncated
                   (fun f ->
                      Ezxmlm.make_tag "IsTruncated" ([], (Boolean.to_xml f)))])
               @
               (List.map
                  (fun x ->
                     Some (Ezxmlm.make_tag "Part" ([], (Parts.to_xml [x]))))
                  v.parts))
              @
              [Util.option_map v.initiator
                 (fun f ->
                    Ezxmlm.make_tag "Initiator" ([], (Initiator.to_xml f)))])
             @
             [Util.option_map v.owner
                (fun f -> Ezxmlm.make_tag "Owner" ([], (Owner.to_xml f)))])
            @
            [Util.option_map v.storage_class
               (fun f ->
                  Ezxmlm.make_tag "StorageClass"
                    ([], (StorageClass.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.owner (fun f -> ("owner", (Owner.to_json f)));
           Util.option_map v.initiator
             (fun f -> ("initiator", (Initiator.to_json f)));
           Some ("parts", (Parts.to_json v.parts));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)));
           Util.option_map v.max_parts
             (fun f -> ("max_parts", (Integer.to_json f)));
           Util.option_map v.next_part_number_marker
             (fun f -> ("next_part_number_marker", (Integer.to_json f)));
           Util.option_map v.part_number_marker
             (fun f -> ("part_number_marker", (Integer.to_json f)));
           Util.option_map v.upload_id
             (fun f -> ("upload_id", (String.to_json f)));
           Util.option_map v.key (fun f -> ("key", (String.to_json f)));
           Util.option_map v.bucket (fun f -> ("bucket", (String.to_json f)));
           Util.option_map v.abort_rule_id
             (fun f -> ("abort_rule_id", (String.to_json f)));
           Util.option_map v.abort_date
             (fun f -> ("abort_date", (DateTime.to_json f)))])
    let of_json j =
      {
        abort_date =
          (Util.option_map (Json.lookup j "abort_date") DateTime.of_json);
        abort_rule_id =
          (Util.option_map (Json.lookup j "abort_rule_id") String.of_json);
        bucket = (Util.option_map (Json.lookup j "bucket") String.of_json);
        key = (Util.option_map (Json.lookup j "key") String.of_json);
        upload_id =
          (Util.option_map (Json.lookup j "upload_id") String.of_json);
        part_number_marker =
          (Util.option_map (Json.lookup j "part_number_marker")
             Integer.of_json);
        next_part_number_marker =
          (Util.option_map (Json.lookup j "next_part_number_marker")
             Integer.of_json);
        max_parts =
          (Util.option_map (Json.lookup j "max_parts") Integer.of_json);
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        parts = (Parts.of_json (Util.of_option_exn (Json.lookup j "parts")));
        initiator =
          (Util.option_map (Json.lookup j "initiator") Initiator.of_json);
        owner = (Util.option_map (Json.lookup j "owner") Owner.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module ListMultipartUploadsOutput =
  struct
    type t =
      {
      bucket: String.t option ;
      key_marker: String.t option ;
      upload_id_marker: String.t option ;
      next_key_marker: String.t option ;
      prefix: String.t option ;
      delimiter: String.t option ;
      next_upload_id_marker: String.t option ;
      max_uploads: Integer.t option ;
      is_truncated: Boolean.t option ;
      uploads: MultipartUploadList.t ;
      common_prefixes: CommonPrefixList.t ;
      encoding_type: EncodingType.t option }
    let make ?bucket  ?key_marker  ?upload_id_marker  ?next_key_marker 
      ?prefix  ?delimiter  ?next_upload_id_marker  ?max_uploads 
      ?is_truncated  ?(uploads= [])  ?(common_prefixes= [])  ?encoding_type 
      () =
      {
        bucket;
        key_marker;
        upload_id_marker;
        next_key_marker;
        prefix;
        delimiter;
        next_upload_id_marker;
        max_uploads;
        is_truncated;
        uploads;
        common_prefixes;
        encoding_type
      }
    let parse xml =
      Some
        {
          bucket = (Util.option_bind (Xml.member "Bucket" xml) String.parse);
          key_marker =
            (Util.option_bind (Xml.member "KeyMarker" xml) String.parse);
          upload_id_marker =
            (Util.option_bind (Xml.member "UploadIdMarker" xml) String.parse);
          next_key_marker =
            (Util.option_bind (Xml.member "NextKeyMarker" xml) String.parse);
          prefix = (Util.option_bind (Xml.member "Prefix" xml) String.parse);
          delimiter =
            (Util.option_bind (Xml.member "Delimiter" xml) String.parse);
          next_upload_id_marker =
            (Util.option_bind (Xml.member "NextUploadIdMarker" xml)
               String.parse);
          max_uploads =
            (Util.option_bind (Xml.member "MaxUploads" xml) Integer.parse);
          is_truncated =
            (Util.option_bind (Xml.member "IsTruncated" xml) Boolean.parse);
          uploads = (Util.of_option [] (MultipartUploadList.parse xml));
          common_prefixes = (Util.of_option [] (CommonPrefixList.parse xml));
          encoding_type =
            (Util.option_bind (Xml.member "EncodingType" xml)
               EncodingType.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (((((((((((([] @
                      [Util.option_map v.bucket
                         (fun f ->
                            Ezxmlm.make_tag "Bucket" ([], (String.to_xml f)))])
                     @
                     [Util.option_map v.key_marker
                        (fun f ->
                           Ezxmlm.make_tag "KeyMarker"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.upload_id_marker
                       (fun f ->
                          Ezxmlm.make_tag "UploadIdMarker"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.next_key_marker
                      (fun f ->
                         Ezxmlm.make_tag "NextKeyMarker"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.prefix
                     (fun f ->
                        Ezxmlm.make_tag "Prefix" ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.delimiter
                    (fun f ->
                       Ezxmlm.make_tag "Delimiter" ([], (String.to_xml f)))])
                @
                [Util.option_map v.next_upload_id_marker
                   (fun f ->
                      Ezxmlm.make_tag "NextUploadIdMarker"
                        ([], (String.to_xml f)))])
               @
               [Util.option_map v.max_uploads
                  (fun f ->
                     Ezxmlm.make_tag "MaxUploads" ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.is_truncated
                 (fun f ->
                    Ezxmlm.make_tag "IsTruncated" ([], (Boolean.to_xml f)))])
             @
             (List.map
                (fun x ->
                   Some
                     (Ezxmlm.make_tag "Upload"
                        ([], (MultipartUploadList.to_xml [x])))) v.uploads))
            @
            (List.map
               (fun x ->
                  Some
                    (Ezxmlm.make_tag "CommonPrefixes"
                       ([], (CommonPrefixList.to_xml [x]))))
               v.common_prefixes))
           @
           [Util.option_map v.encoding_type
              (fun f ->
                 Ezxmlm.make_tag "EncodingType" ([], (EncodingType.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.encoding_type
              (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Some
             ("common_prefixes",
               (CommonPrefixList.to_json v.common_prefixes));
           Some ("uploads", (MultipartUploadList.to_json v.uploads));
           Util.option_map v.is_truncated
             (fun f -> ("is_truncated", (Boolean.to_json f)));
           Util.option_map v.max_uploads
             (fun f -> ("max_uploads", (Integer.to_json f)));
           Util.option_map v.next_upload_id_marker
             (fun f -> ("next_upload_id_marker", (String.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.next_key_marker
             (fun f -> ("next_key_marker", (String.to_json f)));
           Util.option_map v.upload_id_marker
             (fun f -> ("upload_id_marker", (String.to_json f)));
           Util.option_map v.key_marker
             (fun f -> ("key_marker", (String.to_json f)));
           Util.option_map v.bucket (fun f -> ("bucket", (String.to_json f)))])
    let of_json j =
      {
        bucket = (Util.option_map (Json.lookup j "bucket") String.of_json);
        key_marker =
          (Util.option_map (Json.lookup j "key_marker") String.of_json);
        upload_id_marker =
          (Util.option_map (Json.lookup j "upload_id_marker") String.of_json);
        next_key_marker =
          (Util.option_map (Json.lookup j "next_key_marker") String.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        next_upload_id_marker =
          (Util.option_map (Json.lookup j "next_upload_id_marker")
             String.of_json);
        max_uploads =
          (Util.option_map (Json.lookup j "max_uploads") Integer.of_json);
        is_truncated =
          (Util.option_map (Json.lookup j "is_truncated") Boolean.of_json);
        uploads =
          (MultipartUploadList.of_json
             (Util.of_option_exn (Json.lookup j "uploads")));
        common_prefixes =
          (CommonPrefixList.of_json
             (Util.of_option_exn (Json.lookup j "common_prefixes")));
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json)
      }
  end
module ListObjectVersionsRequest =
  struct
    type t =
      {
      bucket: String.t ;
      delimiter: String.t option ;
      encoding_type: EncodingType.t option ;
      key_marker: String.t option ;
      max_keys: Integer.t option ;
      prefix: String.t option ;
      version_id_marker: String.t option }
    let make ~bucket  ?delimiter  ?encoding_type  ?key_marker  ?max_keys 
      ?prefix  ?version_id_marker  () =
      {
        bucket;
        delimiter;
        encoding_type;
        key_marker;
        max_keys;
        prefix;
        version_id_marker
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          delimiter =
            (Util.option_bind (Xml.member "delimiter" xml) String.parse);
          encoding_type =
            (Util.option_bind (Xml.member "encoding-type" xml)
               EncodingType.parse);
          key_marker =
            (Util.option_bind (Xml.member "key-marker" xml) String.parse);
          max_keys =
            (Util.option_bind (Xml.member "max-keys" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          version_id_marker =
            (Util.option_bind (Xml.member "version-id-marker" xml)
               String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id_marker
              (fun f -> Query.Pair ("version-id-marker", (String.to_query f)));
           Util.option_map v.prefix
             (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_keys
             (fun f -> Query.Pair ("max-keys", (Integer.to_query f)));
           Util.option_map v.key_marker
             (fun f -> Query.Pair ("key-marker", (String.to_query f)));
           Util.option_map v.encoding_type
             (fun f ->
                Query.Pair ("encoding-type", (EncodingType.to_query f)));
           Util.option_map v.delimiter
             (fun f -> Query.Pair ("delimiter", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @
                [Util.option_map v.delimiter
                   (fun f ->
                      Ezxmlm.make_tag "delimiter" ([], (String.to_xml f)))])
               @
               [Util.option_map v.encoding_type
                  (fun f ->
                     Ezxmlm.make_tag "encoding-type"
                       ([], (EncodingType.to_xml f)))])
              @
              [Util.option_map v.key_marker
                 (fun f ->
                    Ezxmlm.make_tag "key-marker" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_keys
                (fun f -> Ezxmlm.make_tag "max-keys" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.version_id_marker
              (fun f ->
                 Ezxmlm.make_tag "version-id-marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.version_id_marker
              (fun f -> ("version_id_marker", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_keys
             (fun f -> ("max_keys", (Integer.to_json f)));
           Util.option_map v.key_marker
             (fun f -> ("key_marker", (String.to_json f)));
           Util.option_map v.encoding_type
             (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json);
        key_marker =
          (Util.option_map (Json.lookup j "key_marker") String.of_json);
        max_keys =
          (Util.option_map (Json.lookup j "max_keys") Integer.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        version_id_marker =
          (Util.option_map (Json.lookup j "version_id_marker") String.of_json)
      }
  end
module GetBucketEncryptionRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module DeleteBucketCorsRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module CopyObjectOutput =
  struct
    type t =
      {
      copy_object_result: CopyObjectResult.t option ;
      expiration: String.t option ;
      copy_source_version_id: String.t option ;
      version_id: String.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      s_s_e_k_m_s_encryption_context: String.t option ;
      request_charged: RequestCharged.t option }
    let make ?copy_object_result  ?expiration  ?copy_source_version_id 
      ?version_id  ?server_side_encryption  ?s_s_e_customer_algorithm 
      ?s_s_e_customer_key_m_d5  ?s_s_e_k_m_s_key_id 
      ?s_s_e_k_m_s_encryption_context  ?request_charged  () =
      {
        copy_object_result;
        expiration;
        copy_source_version_id;
        version_id;
        server_side_encryption;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        s_s_e_k_m_s_encryption_context;
        request_charged
      }
    let parse xml =
      Some
        {
          copy_object_result =
            (Util.option_bind (Xml.member "CopyObjectResult" xml)
               CopyObjectResult.parse);
          expiration =
            (Util.option_bind (Xml.member "x-amz-expiration" xml)
               String.parse);
          copy_source_version_id =
            (Util.option_bind (Xml.member "x-amz-copy-source-version-id" xml)
               String.parse);
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          s_s_e_k_m_s_encryption_context =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-context" xml)
               String.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f ->
                 Headers.Pair
                   ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-context",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.version_id
             (fun f ->
                Headers.Pair ("x-amz-version-id", (String.to_headers f)));
           Util.option_map v.copy_source_version_id
             (fun f ->
                Headers.Pair
                  ("x-amz-copy-source-version-id", (String.to_headers f)));
           Util.option_map v.expiration
             (fun f ->
                Headers.Pair ("x-amz-expiration", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        (((((((((([] @
                    [Util.option_map v.copy_object_result
                       (fun f ->
                          Ezxmlm.make_tag "CopyObjectResult"
                            ([], (CopyObjectResult.to_xml f)))])
                   @
                   [Util.option_map v.expiration
                      (fun f ->
                         Ezxmlm.make_tag "x-amz-expiration"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.copy_source_version_id
                     (fun f ->
                        Ezxmlm.make_tag "x-amz-copy-source-version-id"
                          ([], (String.to_xml f)))])
                 @
                 [Util.option_map v.version_id
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-version-id"
                         ([], (String.to_xml f)))])
                @
                [Util.option_map v.server_side_encryption
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-server-side-encryption"
                        ([], (ServerSideEncryption.to_xml f)))])
               @
               [Util.option_map v.s_s_e_customer_algorithm
                  (fun f ->
                     Ezxmlm.make_tag
                       "x-amz-server-side-encryption-customer-algorithm"
                       ([], (String.to_xml f)))])
              @
              [Util.option_map v.s_s_e_customer_key_m_d5
                 (fun f ->
                    Ezxmlm.make_tag
                      "x-amz-server-side-encryption-customer-key-MD5"
                      ([], (String.to_xml f)))])
             @
             [Util.option_map v.s_s_e_k_m_s_key_id
                (fun f ->
                   Ezxmlm.make_tag
                     "x-amz-server-side-encryption-aws-kms-key-id"
                     ([], (String.to_xml f)))])
            @
            [Util.option_map v.s_s_e_k_m_s_encryption_context
               (fun f ->
                  Ezxmlm.make_tag "x-amz-server-side-encryption-context"
                    ([], (String.to_xml f)))])
           @
           [Util.option_map v.request_charged
              (fun f ->
                 Ezxmlm.make_tag "x-amz-request-charged"
                   ([], (RequestCharged.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.request_charged
              (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.s_s_e_k_m_s_encryption_context
             (fun f -> ("s_s_e_k_m_s_encryption_context", (String.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.copy_source_version_id
             (fun f -> ("copy_source_version_id", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (String.to_json f)));
           Util.option_map v.copy_object_result
             (fun f -> ("copy_object_result", (CopyObjectResult.to_json f)))])
    let of_json j =
      {
        copy_object_result =
          (Util.option_map (Json.lookup j "copy_object_result")
             CopyObjectResult.of_json);
        expiration =
          (Util.option_map (Json.lookup j "expiration") String.of_json);
        copy_source_version_id =
          (Util.option_map (Json.lookup j "copy_source_version_id")
             String.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        s_s_e_k_m_s_encryption_context =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_encryption_context")
             String.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json)
      }
  end
module GetBucketInventoryConfigurationOutput =
  struct
    type t = {
      inventory_configuration: InventoryConfiguration.t option }
    let make ?inventory_configuration  () = { inventory_configuration }
    let parse xml =
      Some
        {
          inventory_configuration =
            (Util.option_bind (Xml.member "InventoryConfiguration" xml)
               InventoryConfiguration.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Util.option_map v.inventory_configuration
              (fun f ->
                 Ezxmlm.make_tag "InventoryConfiguration"
                   ([], (InventoryConfiguration.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.inventory_configuration
              (fun f ->
                 ("inventory_configuration",
                   (InventoryConfiguration.to_json f)))])
    let of_json j =
      {
        inventory_configuration =
          (Util.option_map (Json.lookup j "inventory_configuration")
             InventoryConfiguration.of_json)
      }
  end
module PutBucketTaggingRequest =
  struct
    type t =
      {
      bucket: String.t ;
      content_m_d5: String.t option ;
      tagging: Tagging.t }
    let make ~bucket  ?content_m_d5  ~tagging  () =
      { bucket; content_m_d5; tagging }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse);
          tagging =
            (Xml.required "Tagging"
               (Util.option_bind (Xml.member "Tagging" xml) Tagging.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((([] @
             [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
            @
            [Util.option_map v.content_m_d5
               (fun f ->
                  Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
           @
           [Some (Ezxmlm.make_tag "Tagging" ([], (Tagging.to_xml v.tagging)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some ("tagging", (Tagging.to_json v.tagging));
           Util.option_map v.content_m_d5
             (fun f -> ("content_m_d5", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json);
        tagging =
          (Tagging.of_json (Util.of_option_exn (Json.lookup j "tagging")))
      }
  end
module PutObjectRetentionRequest =
  struct
    type t =
      {
      bucket: String.t ;
      key: String.t ;
      retention: ObjectLockRetention.t option ;
      request_payer: RequestPayer.t option ;
      version_id: String.t option ;
      bypass_governance_retention: Boolean.t option ;
      content_m_d5: String.t option }
    let make ~bucket  ~key  ?retention  ?request_payer  ?version_id 
      ?bypass_governance_retention  ?content_m_d5  () =
      {
        bucket;
        key;
        retention;
        request_payer;
        version_id;
        bypass_governance_retention;
        content_m_d5
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          key =
            (Xml.required "Key"
               (Util.option_bind (Xml.member "Key" xml) String.parse));
          retention =
            (Util.option_bind (Xml.member "Retention" xml)
               ObjectLockRetention.parse);
          request_payer =
            (Util.option_bind (Xml.member "x-amz-request-payer" xml)
               RequestPayer.parse);
          version_id =
            (Util.option_bind (Xml.member "versionId" xml) String.parse);
          bypass_governance_retention =
            (Util.option_bind
               (Xml.member "x-amz-bypass-governance-retention" xml)
               Boolean.parse);
          content_m_d5 =
            (Util.option_bind (Xml.member "Content-MD5" xml) String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.version_id
              (fun f -> Query.Pair ("versionId", (String.to_query f)))])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> Headers.Pair ("Content-MD5", (String.to_headers f)));
           Util.option_map v.bypass_governance_retention
             (fun f ->
                Headers.Pair
                  ("x-amz-bypass-governance-retention",
                    (Boolean.to_headers f)));
           Util.option_map v.request_payer
             (fun f ->
                Headers.Pair
                  ("x-amz-request-payer", (RequestPayer.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @ [Some (Ezxmlm.make_tag "Key" ([], (String.to_xml v.key)))])
               @
               [Util.option_map v.retention
                  (fun f ->
                     Ezxmlm.make_tag "Retention"
                       ([], (ObjectLockRetention.to_xml f)))])
              @
              [Util.option_map v.request_payer
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-request-payer"
                      ([], (RequestPayer.to_xml f)))])
             @
             [Util.option_map v.version_id
                (fun f -> Ezxmlm.make_tag "versionId" ([], (String.to_xml f)))])
            @
            [Util.option_map v.bypass_governance_retention
               (fun f ->
                  Ezxmlm.make_tag "x-amz-bypass-governance-retention"
                    ([], (Boolean.to_xml f)))])
           @
           [Util.option_map v.content_m_d5
              (fun f -> Ezxmlm.make_tag "Content-MD5" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.content_m_d5
              (fun f -> ("content_m_d5", (String.to_json f)));
           Util.option_map v.bypass_governance_retention
             (fun f -> ("bypass_governance_retention", (Boolean.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.request_payer
             (fun f -> ("request_payer", (RequestPayer.to_json f)));
           Util.option_map v.retention
             (fun f -> ("retention", (ObjectLockRetention.to_json f)));
           Some ("key", (String.to_json v.key));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        key = (String.of_json (Util.of_option_exn (Json.lookup j "key")));
        retention =
          (Util.option_map (Json.lookup j "retention")
             ObjectLockRetention.of_json);
        request_payer =
          (Util.option_map (Json.lookup j "request_payer")
             RequestPayer.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        bypass_governance_retention =
          (Util.option_map (Json.lookup j "bypass_governance_retention")
             Boolean.of_json);
        content_m_d5 =
          (Util.option_map (Json.lookup j "content_m_d5") String.of_json)
      }
  end
module ListMultipartUploadsRequest =
  struct
    type t =
      {
      bucket: String.t ;
      delimiter: String.t option ;
      encoding_type: EncodingType.t option ;
      key_marker: String.t option ;
      max_uploads: Integer.t option ;
      prefix: String.t option ;
      upload_id_marker: String.t option }
    let make ~bucket  ?delimiter  ?encoding_type  ?key_marker  ?max_uploads 
      ?prefix  ?upload_id_marker  () =
      {
        bucket;
        delimiter;
        encoding_type;
        key_marker;
        max_uploads;
        prefix;
        upload_id_marker
      }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          delimiter =
            (Util.option_bind (Xml.member "delimiter" xml) String.parse);
          encoding_type =
            (Util.option_bind (Xml.member "encoding-type" xml)
               EncodingType.parse);
          key_marker =
            (Util.option_bind (Xml.member "key-marker" xml) String.parse);
          max_uploads =
            (Util.option_bind (Xml.member "max-uploads" xml) Integer.parse);
          prefix = (Util.option_bind (Xml.member "prefix" xml) String.parse);
          upload_id_marker =
            (Util.option_bind (Xml.member "upload-id-marker" xml)
               String.parse)
        }
    let to_query v =
      Query.List
        (Util.list_filter_opt
           [Util.option_map v.upload_id_marker
              (fun f -> Query.Pair ("upload-id-marker", (String.to_query f)));
           Util.option_map v.prefix
             (fun f -> Query.Pair ("prefix", (String.to_query f)));
           Util.option_map v.max_uploads
             (fun f -> Query.Pair ("max-uploads", (Integer.to_query f)));
           Util.option_map v.key_marker
             (fun f -> Query.Pair ("key-marker", (String.to_query f)));
           Util.option_map v.encoding_type
             (fun f ->
                Query.Pair ("encoding-type", (EncodingType.to_query f)));
           Util.option_map v.delimiter
             (fun f -> Query.Pair ("delimiter", (String.to_query f)))])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ((((((([] @
                 [Some
                    (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
                @
                [Util.option_map v.delimiter
                   (fun f ->
                      Ezxmlm.make_tag "delimiter" ([], (String.to_xml f)))])
               @
               [Util.option_map v.encoding_type
                  (fun f ->
                     Ezxmlm.make_tag "encoding-type"
                       ([], (EncodingType.to_xml f)))])
              @
              [Util.option_map v.key_marker
                 (fun f ->
                    Ezxmlm.make_tag "key-marker" ([], (String.to_xml f)))])
             @
             [Util.option_map v.max_uploads
                (fun f ->
                   Ezxmlm.make_tag "max-uploads" ([], (Integer.to_xml f)))])
            @
            [Util.option_map v.prefix
               (fun f -> Ezxmlm.make_tag "prefix" ([], (String.to_xml f)))])
           @
           [Util.option_map v.upload_id_marker
              (fun f ->
                 Ezxmlm.make_tag "upload-id-marker" ([], (String.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.upload_id_marker
              (fun f -> ("upload_id_marker", (String.to_json f)));
           Util.option_map v.prefix (fun f -> ("prefix", (String.to_json f)));
           Util.option_map v.max_uploads
             (fun f -> ("max_uploads", (Integer.to_json f)));
           Util.option_map v.key_marker
             (fun f -> ("key_marker", (String.to_json f)));
           Util.option_map v.encoding_type
             (fun f -> ("encoding_type", (EncodingType.to_json f)));
           Util.option_map v.delimiter
             (fun f -> ("delimiter", (String.to_json f)));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        delimiter =
          (Util.option_map (Json.lookup j "delimiter") String.of_json);
        encoding_type =
          (Util.option_map (Json.lookup j "encoding_type")
             EncodingType.of_json);
        key_marker =
          (Util.option_map (Json.lookup j "key_marker") String.of_json);
        max_uploads =
          (Util.option_map (Json.lookup j "max_uploads") Integer.of_json);
        prefix = (Util.option_map (Json.lookup j "prefix") String.of_json);
        upload_id_marker =
          (Util.option_map (Json.lookup j "upload_id_marker") String.of_json)
      }
  end
module GetBucketNotificationConfigurationRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetObjectOutput =
  struct
    type t =
      {
      body: Blob.t option ;
      delete_marker: Boolean.t option ;
      accept_ranges: String.t option ;
      expiration: String.t option ;
      restore: String.t option ;
      last_modified: DateTime.t option ;
      content_length: Long.t option ;
      e_tag: String.t option ;
      missing_meta: Integer.t option ;
      version_id: String.t option ;
      cache_control: String.t option ;
      content_disposition: String.t option ;
      content_encoding: String.t option ;
      content_language: String.t option ;
      content_range: String.t option ;
      content_type: String.t option ;
      expires: DateTime.t option ;
      website_redirect_location: String.t option ;
      server_side_encryption: ServerSideEncryption.t option ;
      metadata: Metadata.t option ;
      s_s_e_customer_algorithm: String.t option ;
      s_s_e_customer_key_m_d5: String.t option ;
      s_s_e_k_m_s_key_id: String.t option ;
      storage_class: StorageClass.t option ;
      request_charged: RequestCharged.t option ;
      replication_status: ReplicationStatus.t option ;
      parts_count: Integer.t option ;
      tag_count: Integer.t option ;
      object_lock_mode: ObjectLockMode.t option ;
      object_lock_retain_until_date: DateTime.t option ;
      object_lock_legal_hold_status: ObjectLockLegalHoldStatus.t option }
    let make ?body  ?delete_marker  ?accept_ranges  ?expiration  ?restore 
      ?last_modified  ?content_length  ?e_tag  ?missing_meta  ?version_id 
      ?cache_control  ?content_disposition  ?content_encoding 
      ?content_language  ?content_range  ?content_type  ?expires 
      ?website_redirect_location  ?server_side_encryption  ?metadata 
      ?s_s_e_customer_algorithm  ?s_s_e_customer_key_m_d5 
      ?s_s_e_k_m_s_key_id  ?storage_class  ?request_charged 
      ?replication_status  ?parts_count  ?tag_count  ?object_lock_mode 
      ?object_lock_retain_until_date  ?object_lock_legal_hold_status  () =
      {
        body;
        delete_marker;
        accept_ranges;
        expiration;
        restore;
        last_modified;
        content_length;
        e_tag;
        missing_meta;
        version_id;
        cache_control;
        content_disposition;
        content_encoding;
        content_language;
        content_range;
        content_type;
        expires;
        website_redirect_location;
        server_side_encryption;
        metadata;
        s_s_e_customer_algorithm;
        s_s_e_customer_key_m_d5;
        s_s_e_k_m_s_key_id;
        storage_class;
        request_charged;
        replication_status;
        parts_count;
        tag_count;
        object_lock_mode;
        object_lock_retain_until_date;
        object_lock_legal_hold_status
      }
    let parse xml =
      Some
        {
          body = (Util.option_bind (Xml.member "Body" xml) Blob.parse);
          delete_marker =
            (Util.option_bind (Xml.member "x-amz-delete-marker" xml)
               Boolean.parse);
          accept_ranges =
            (Util.option_bind (Xml.member "accept-ranges" xml) String.parse);
          expiration =
            (Util.option_bind (Xml.member "x-amz-expiration" xml)
               String.parse);
          restore =
            (Util.option_bind (Xml.member "x-amz-restore" xml) String.parse);
          last_modified =
            (Util.option_bind (Xml.member "Last-Modified" xml) DateTime.parse);
          content_length =
            (Util.option_bind (Xml.member "Content-Length" xml) Long.parse);
          e_tag = (Util.option_bind (Xml.member "ETag" xml) String.parse);
          missing_meta =
            (Util.option_bind (Xml.member "x-amz-missing-meta" xml)
               Integer.parse);
          version_id =
            (Util.option_bind (Xml.member "x-amz-version-id" xml)
               String.parse);
          cache_control =
            (Util.option_bind (Xml.member "Cache-Control" xml) String.parse);
          content_disposition =
            (Util.option_bind (Xml.member "Content-Disposition" xml)
               String.parse);
          content_encoding =
            (Util.option_bind (Xml.member "Content-Encoding" xml)
               String.parse);
          content_language =
            (Util.option_bind (Xml.member "Content-Language" xml)
               String.parse);
          content_range =
            (Util.option_bind (Xml.member "Content-Range" xml) String.parse);
          content_type =
            (Util.option_bind (Xml.member "Content-Type" xml) String.parse);
          expires =
            (Util.option_bind (Xml.member "Expires" xml) DateTime.parse);
          website_redirect_location =
            (Util.option_bind
               (Xml.member "x-amz-website-redirect-location" xml)
               String.parse);
          server_side_encryption =
            (Util.option_bind (Xml.member "x-amz-server-side-encryption" xml)
               ServerSideEncryption.parse);
          metadata =
            (Util.option_bind (Xml.member "x-amz-meta-" xml) Metadata.parse);
          s_s_e_customer_algorithm =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-algorithm"
                  xml) String.parse);
          s_s_e_customer_key_m_d5 =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-customer-key-MD5"
                  xml) String.parse);
          s_s_e_k_m_s_key_id =
            (Util.option_bind
               (Xml.member "x-amz-server-side-encryption-aws-kms-key-id" xml)
               String.parse);
          storage_class =
            (Util.option_bind (Xml.member "x-amz-storage-class" xml)
               StorageClass.parse);
          request_charged =
            (Util.option_bind (Xml.member "x-amz-request-charged" xml)
               RequestCharged.parse);
          replication_status =
            (Util.option_bind (Xml.member "x-amz-replication-status" xml)
               ReplicationStatus.parse);
          parts_count =
            (Util.option_bind (Xml.member "x-amz-mp-parts-count" xml)
               Integer.parse);
          tag_count =
            (Util.option_bind (Xml.member "x-amz-tagging-count" xml)
               Integer.parse);
          object_lock_mode =
            (Util.option_bind (Xml.member "x-amz-object-lock-mode" xml)
               ObjectLockMode.parse);
          object_lock_retain_until_date =
            (Util.option_bind
               (Xml.member "x-amz-object-lock-retain-until-date" xml)
               DateTime.parse);
          object_lock_legal_hold_status =
            (Util.option_bind (Xml.member "x-amz-object-lock-legal-hold" xml)
               ObjectLockLegalHoldStatus.parse)
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v =
      Headers.List
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Headers.Pair
                   ("x-amz-object-lock-legal-hold",
                     (ObjectLockLegalHoldStatus.to_headers f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-retain-until-date",
                    (DateTime.to_headers f)));
           Util.option_map v.object_lock_mode
             (fun f ->
                Headers.Pair
                  ("x-amz-object-lock-mode", (ObjectLockMode.to_headers f)));
           Util.option_map v.tag_count
             (fun f ->
                Headers.Pair ("x-amz-tagging-count", (Integer.to_headers f)));
           Util.option_map v.parts_count
             (fun f ->
                Headers.Pair ("x-amz-mp-parts-count", (Integer.to_headers f)));
           Util.option_map v.replication_status
             (fun f ->
                Headers.Pair
                  ("x-amz-replication-status",
                    (ReplicationStatus.to_headers f)));
           Util.option_map v.request_charged
             (fun f ->
                Headers.Pair
                  ("x-amz-request-charged", (RequestCharged.to_headers f)));
           Util.option_map v.storage_class
             (fun f ->
                Headers.Pair
                  ("x-amz-storage-class", (StorageClass.to_headers f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-aws-kms-key-id",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-key-MD5",
                    (String.to_headers f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption-customer-algorithm",
                    (String.to_headers f)));
           Util.option_map v.metadata
             (fun f -> Headers.Pair ("x-amz-meta-", (Metadata.to_headers f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                Headers.Pair
                  ("x-amz-server-side-encryption",
                    (ServerSideEncryption.to_headers f)));
           Util.option_map v.website_redirect_location
             (fun f ->
                Headers.Pair
                  ("x-amz-website-redirect-location", (String.to_headers f)));
           Util.option_map v.expires
             (fun f -> Headers.Pair ("Expires", (DateTime.to_headers f)));
           Util.option_map v.content_type
             (fun f -> Headers.Pair ("Content-Type", (String.to_headers f)));
           Util.option_map v.content_range
             (fun f -> Headers.Pair ("Content-Range", (String.to_headers f)));
           Util.option_map v.content_language
             (fun f ->
                Headers.Pair ("Content-Language", (String.to_headers f)));
           Util.option_map v.content_encoding
             (fun f ->
                Headers.Pair ("Content-Encoding", (String.to_headers f)));
           Util.option_map v.content_disposition
             (fun f ->
                Headers.Pair ("Content-Disposition", (String.to_headers f)));
           Util.option_map v.cache_control
             (fun f -> Headers.Pair ("Cache-Control", (String.to_headers f)));
           Util.option_map v.version_id
             (fun f ->
                Headers.Pair ("x-amz-version-id", (String.to_headers f)));
           Util.option_map v.missing_meta
             (fun f ->
                Headers.Pair ("x-amz-missing-meta", (Integer.to_headers f)));
           Util.option_map v.e_tag
             (fun f -> Headers.Pair ("ETag", (String.to_headers f)));
           Util.option_map v.content_length
             (fun f -> Headers.Pair ("Content-Length", (Long.to_headers f)));
           Util.option_map v.last_modified
             (fun f ->
                Headers.Pair ("Last-Modified", (DateTime.to_headers f)));
           Util.option_map v.restore
             (fun f -> Headers.Pair ("x-amz-restore", (String.to_headers f)));
           Util.option_map v.expiration
             (fun f ->
                Headers.Pair ("x-amz-expiration", (String.to_headers f)));
           Util.option_map v.accept_ranges
             (fun f -> Headers.Pair ("accept-ranges", (String.to_headers f)));
           Util.option_map v.delete_marker
             (fun f ->
                Headers.Pair ("x-amz-delete-marker", (Boolean.to_headers f)))])
    let to_xml v =
      Util.list_filter_opt
        ((((((((((((((((((((((((((((((([] @
                                         [Util.option_map v.body
                                            (fun f ->
                                               Ezxmlm.make_tag "Body"
                                                 ([], (Blob.to_xml f)))])
                                        @
                                        [Util.option_map v.delete_marker
                                           (fun f ->
                                              Ezxmlm.make_tag
                                                "x-amz-delete-marker"
                                                ([], (Boolean.to_xml f)))])
                                       @
                                       [Util.option_map v.accept_ranges
                                          (fun f ->
                                             Ezxmlm.make_tag "accept-ranges"
                                               ([], (String.to_xml f)))])
                                      @
                                      [Util.option_map v.expiration
                                         (fun f ->
                                            Ezxmlm.make_tag
                                              "x-amz-expiration"
                                              ([], (String.to_xml f)))])
                                     @
                                     [Util.option_map v.restore
                                        (fun f ->
                                           Ezxmlm.make_tag "x-amz-restore"
                                             ([], (String.to_xml f)))])
                                    @
                                    [Util.option_map v.last_modified
                                       (fun f ->
                                          Ezxmlm.make_tag "Last-Modified"
                                            ([], (DateTime.to_xml f)))])
                                   @
                                   [Util.option_map v.content_length
                                      (fun f ->
                                         Ezxmlm.make_tag "Content-Length"
                                           ([], (Long.to_xml f)))])
                                  @
                                  [Util.option_map v.e_tag
                                     (fun f ->
                                        Ezxmlm.make_tag "ETag"
                                          ([], (String.to_xml f)))])
                                 @
                                 [Util.option_map v.missing_meta
                                    (fun f ->
                                       Ezxmlm.make_tag "x-amz-missing-meta"
                                         ([], (Integer.to_xml f)))])
                                @
                                [Util.option_map v.version_id
                                   (fun f ->
                                      Ezxmlm.make_tag "x-amz-version-id"
                                        ([], (String.to_xml f)))])
                               @
                               [Util.option_map v.cache_control
                                  (fun f ->
                                     Ezxmlm.make_tag "Cache-Control"
                                       ([], (String.to_xml f)))])
                              @
                              [Util.option_map v.content_disposition
                                 (fun f ->
                                    Ezxmlm.make_tag "Content-Disposition"
                                      ([], (String.to_xml f)))])
                             @
                             [Util.option_map v.content_encoding
                                (fun f ->
                                   Ezxmlm.make_tag "Content-Encoding"
                                     ([], (String.to_xml f)))])
                            @
                            [Util.option_map v.content_language
                               (fun f ->
                                  Ezxmlm.make_tag "Content-Language"
                                    ([], (String.to_xml f)))])
                           @
                           [Util.option_map v.content_range
                              (fun f ->
                                 Ezxmlm.make_tag "Content-Range"
                                   ([], (String.to_xml f)))])
                          @
                          [Util.option_map v.content_type
                             (fun f ->
                                Ezxmlm.make_tag "Content-Type"
                                  ([], (String.to_xml f)))])
                         @
                         [Util.option_map v.expires
                            (fun f ->
                               Ezxmlm.make_tag "Expires"
                                 ([], (DateTime.to_xml f)))])
                        @
                        [Util.option_map v.website_redirect_location
                           (fun f ->
                              Ezxmlm.make_tag
                                "x-amz-website-redirect-location"
                                ([], (String.to_xml f)))])
                       @
                       [Util.option_map v.server_side_encryption
                          (fun f ->
                             Ezxmlm.make_tag "x-amz-server-side-encryption"
                               ([], (ServerSideEncryption.to_xml f)))])
                      @
                      [Util.option_map v.metadata
                         (fun f ->
                            Ezxmlm.make_tag "x-amz-meta-"
                              ([], (Metadata.to_xml f)))])
                     @
                     [Util.option_map v.s_s_e_customer_algorithm
                        (fun f ->
                           Ezxmlm.make_tag
                             "x-amz-server-side-encryption-customer-algorithm"
                             ([], (String.to_xml f)))])
                    @
                    [Util.option_map v.s_s_e_customer_key_m_d5
                       (fun f ->
                          Ezxmlm.make_tag
                            "x-amz-server-side-encryption-customer-key-MD5"
                            ([], (String.to_xml f)))])
                   @
                   [Util.option_map v.s_s_e_k_m_s_key_id
                      (fun f ->
                         Ezxmlm.make_tag
                           "x-amz-server-side-encryption-aws-kms-key-id"
                           ([], (String.to_xml f)))])
                  @
                  [Util.option_map v.storage_class
                     (fun f ->
                        Ezxmlm.make_tag "x-amz-storage-class"
                          ([], (StorageClass.to_xml f)))])
                 @
                 [Util.option_map v.request_charged
                    (fun f ->
                       Ezxmlm.make_tag "x-amz-request-charged"
                         ([], (RequestCharged.to_xml f)))])
                @
                [Util.option_map v.replication_status
                   (fun f ->
                      Ezxmlm.make_tag "x-amz-replication-status"
                        ([], (ReplicationStatus.to_xml f)))])
               @
               [Util.option_map v.parts_count
                  (fun f ->
                     Ezxmlm.make_tag "x-amz-mp-parts-count"
                       ([], (Integer.to_xml f)))])
              @
              [Util.option_map v.tag_count
                 (fun f ->
                    Ezxmlm.make_tag "x-amz-tagging-count"
                      ([], (Integer.to_xml f)))])
             @
             [Util.option_map v.object_lock_mode
                (fun f ->
                   Ezxmlm.make_tag "x-amz-object-lock-mode"
                     ([], (ObjectLockMode.to_xml f)))])
            @
            [Util.option_map v.object_lock_retain_until_date
               (fun f ->
                  Ezxmlm.make_tag "x-amz-object-lock-retain-until-date"
                    ([], (DateTime.to_xml f)))])
           @
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 Ezxmlm.make_tag "x-amz-object-lock-legal-hold"
                   ([], (ObjectLockLegalHoldStatus.to_xml f)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Util.option_map v.object_lock_legal_hold_status
              (fun f ->
                 ("object_lock_legal_hold_status",
                   (ObjectLockLegalHoldStatus.to_json f)));
           Util.option_map v.object_lock_retain_until_date
             (fun f ->
                ("object_lock_retain_until_date", (DateTime.to_json f)));
           Util.option_map v.object_lock_mode
             (fun f -> ("object_lock_mode", (ObjectLockMode.to_json f)));
           Util.option_map v.tag_count
             (fun f -> ("tag_count", (Integer.to_json f)));
           Util.option_map v.parts_count
             (fun f -> ("parts_count", (Integer.to_json f)));
           Util.option_map v.replication_status
             (fun f -> ("replication_status", (ReplicationStatus.to_json f)));
           Util.option_map v.request_charged
             (fun f -> ("request_charged", (RequestCharged.to_json f)));
           Util.option_map v.storage_class
             (fun f -> ("storage_class", (StorageClass.to_json f)));
           Util.option_map v.s_s_e_k_m_s_key_id
             (fun f -> ("s_s_e_k_m_s_key_id", (String.to_json f)));
           Util.option_map v.s_s_e_customer_key_m_d5
             (fun f -> ("s_s_e_customer_key_m_d5", (String.to_json f)));
           Util.option_map v.s_s_e_customer_algorithm
             (fun f -> ("s_s_e_customer_algorithm", (String.to_json f)));
           Util.option_map v.metadata
             (fun f -> ("metadata", (Metadata.to_json f)));
           Util.option_map v.server_side_encryption
             (fun f ->
                ("server_side_encryption", (ServerSideEncryption.to_json f)));
           Util.option_map v.website_redirect_location
             (fun f -> ("website_redirect_location", (String.to_json f)));
           Util.option_map v.expires
             (fun f -> ("expires", (DateTime.to_json f)));
           Util.option_map v.content_type
             (fun f -> ("content_type", (String.to_json f)));
           Util.option_map v.content_range
             (fun f -> ("content_range", (String.to_json f)));
           Util.option_map v.content_language
             (fun f -> ("content_language", (String.to_json f)));
           Util.option_map v.content_encoding
             (fun f -> ("content_encoding", (String.to_json f)));
           Util.option_map v.content_disposition
             (fun f -> ("content_disposition", (String.to_json f)));
           Util.option_map v.cache_control
             (fun f -> ("cache_control", (String.to_json f)));
           Util.option_map v.version_id
             (fun f -> ("version_id", (String.to_json f)));
           Util.option_map v.missing_meta
             (fun f -> ("missing_meta", (Integer.to_json f)));
           Util.option_map v.e_tag (fun f -> ("e_tag", (String.to_json f)));
           Util.option_map v.content_length
             (fun f -> ("content_length", (Long.to_json f)));
           Util.option_map v.last_modified
             (fun f -> ("last_modified", (DateTime.to_json f)));
           Util.option_map v.restore
             (fun f -> ("restore", (String.to_json f)));
           Util.option_map v.expiration
             (fun f -> ("expiration", (String.to_json f)));
           Util.option_map v.accept_ranges
             (fun f -> ("accept_ranges", (String.to_json f)));
           Util.option_map v.delete_marker
             (fun f -> ("delete_marker", (Boolean.to_json f)));
           Util.option_map v.body (fun f -> ("body", (Blob.to_json f)))])
    let of_json j =
      {
        body = (Util.option_map (Json.lookup j "body") Blob.of_json);
        delete_marker =
          (Util.option_map (Json.lookup j "delete_marker") Boolean.of_json);
        accept_ranges =
          (Util.option_map (Json.lookup j "accept_ranges") String.of_json);
        expiration =
          (Util.option_map (Json.lookup j "expiration") String.of_json);
        restore = (Util.option_map (Json.lookup j "restore") String.of_json);
        last_modified =
          (Util.option_map (Json.lookup j "last_modified") DateTime.of_json);
        content_length =
          (Util.option_map (Json.lookup j "content_length") Long.of_json);
        e_tag = (Util.option_map (Json.lookup j "e_tag") String.of_json);
        missing_meta =
          (Util.option_map (Json.lookup j "missing_meta") Integer.of_json);
        version_id =
          (Util.option_map (Json.lookup j "version_id") String.of_json);
        cache_control =
          (Util.option_map (Json.lookup j "cache_control") String.of_json);
        content_disposition =
          (Util.option_map (Json.lookup j "content_disposition")
             String.of_json);
        content_encoding =
          (Util.option_map (Json.lookup j "content_encoding") String.of_json);
        content_language =
          (Util.option_map (Json.lookup j "content_language") String.of_json);
        content_range =
          (Util.option_map (Json.lookup j "content_range") String.of_json);
        content_type =
          (Util.option_map (Json.lookup j "content_type") String.of_json);
        expires =
          (Util.option_map (Json.lookup j "expires") DateTime.of_json);
        website_redirect_location =
          (Util.option_map (Json.lookup j "website_redirect_location")
             String.of_json);
        server_side_encryption =
          (Util.option_map (Json.lookup j "server_side_encryption")
             ServerSideEncryption.of_json);
        metadata =
          (Util.option_map (Json.lookup j "metadata") Metadata.of_json);
        s_s_e_customer_algorithm =
          (Util.option_map (Json.lookup j "s_s_e_customer_algorithm")
             String.of_json);
        s_s_e_customer_key_m_d5 =
          (Util.option_map (Json.lookup j "s_s_e_customer_key_m_d5")
             String.of_json);
        s_s_e_k_m_s_key_id =
          (Util.option_map (Json.lookup j "s_s_e_k_m_s_key_id")
             String.of_json);
        storage_class =
          (Util.option_map (Json.lookup j "storage_class")
             StorageClass.of_json);
        request_charged =
          (Util.option_map (Json.lookup j "request_charged")
             RequestCharged.of_json);
        replication_status =
          (Util.option_map (Json.lookup j "replication_status")
             ReplicationStatus.of_json);
        parts_count =
          (Util.option_map (Json.lookup j "parts_count") Integer.of_json);
        tag_count =
          (Util.option_map (Json.lookup j "tag_count") Integer.of_json);
        object_lock_mode =
          (Util.option_map (Json.lookup j "object_lock_mode")
             ObjectLockMode.of_json);
        object_lock_retain_until_date =
          (Util.option_map (Json.lookup j "object_lock_retain_until_date")
             DateTime.of_json);
        object_lock_legal_hold_status =
          (Util.option_map (Json.lookup j "object_lock_legal_hold_status")
             ObjectLockLegalHoldStatus.of_json)
      }
  end
module PutBucketNotificationConfigurationRequest =
  struct
    type t =
      {
      bucket: String.t ;
      notification_configuration: NotificationConfiguration.t }
    let make ~bucket  ~notification_configuration  () =
      { bucket; notification_configuration }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse));
          notification_configuration =
            (Xml.required "NotificationConfiguration"
               (Util.option_bind (Xml.member "NotificationConfiguration" xml)
                  NotificationConfiguration.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        (([] @
            [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
           @
           [Some
              (Ezxmlm.make_tag "NotificationConfiguration"
                 ([],
                   (NotificationConfiguration.to_xml
                      v.notification_configuration)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt
           [Some
              ("notification_configuration",
                (NotificationConfiguration.to_json
                   v.notification_configuration));
           Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")));
        notification_configuration =
          (NotificationConfiguration.of_json
             (Util.of_option_exn (Json.lookup j "notification_configuration")))
      }
  end
module DeleteBucketLifecycleRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end
module GetBucketAclRequest =
  struct
    type t = {
      bucket: String.t }
    let make ~bucket  () = { bucket }
    let parse xml =
      Some
        {
          bucket =
            (Xml.required "Bucket"
               (Util.option_bind (Xml.member "Bucket" xml) String.parse))
        }
    let to_query v = Query.List (Util.list_filter_opt [])
    let to_headers v = Headers.List (Util.list_filter_opt [])
    let to_xml v =
      Util.list_filter_opt
        ([] @
           [Some (Ezxmlm.make_tag "Bucket" ([], (String.to_xml v.bucket)))])
    let to_json v =
      `Assoc
        (Util.list_filter_opt [Some ("bucket", (String.to_json v.bucket))])
    let of_json j =
      {
        bucket =
          (String.of_json (Util.of_option_exn (Json.lookup j "bucket")))
      }
  end